import 'dart:async';

import 'package:flutter/material.dart';

enum RecordingStatus { idle, recording, processing }

class RecordingCard extends StatefulWidget {
  const RecordingCard({super.key, required this.onTranscript});

  final ValueChanged<String> onTranscript;

  @override
  State<RecordingCard> createState() => _RecordingCardState();
}

class _RecordingCardState extends State<RecordingCard> {
  // Track widget's recording status
  RecordingStatus _status = RecordingStatus.idle;
  DateTime? _startTime;
  Duration _timeElapsed = Duration.zero;
  final Duration _maxDuration = Duration(minutes: 0, seconds: 15);
  Timer? _ticker;

  // Formats duration as mm:ss
  String _formatDuration(Duration d) {
    final mins = d.inMinutes.remainder(60).toString().padLeft(2, "0");
    final secs = d.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$mins:$secs";
  }

  // Function for when audio recording has started
  Future<void> _startRecording() async {
    setState(() => _status = RecordingStatus.recording);

    // Start recording timer
    _startTime = DateTime.now();
    _timeElapsed = Duration.zero;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      // Only update timer if recording
      if (_status == RecordingStatus.recording) {
        // Stop recording once max duration reached
        final elapsed = DateTime.now().difference(_startTime!);
        if (elapsed >= _maxDuration) {
          setState(() => _timeElapsed = _maxDuration);
          _stopRecording();
          return;
        }

        // Update time elapsed
        setState(() => _timeElapsed = elapsed);
      }
    });

    // TODO: Call audio recording start here
  }

  // Function for when audio recording has stopped
  Future<void> _stopRecording() async {
    setState(() => _status = RecordingStatus.processing);

    // TODO: Get audio data
    // TODO: Get transcription from audio data

    await Future.delayed(const Duration(seconds: 3)); // placeholder

    // Reset status and invoke callback with transcribed text
    setState(() => _status = RecordingStatus.idle);
    widget.onTranscript("PLACEHOLDER VALUE");
  }

  // Event handler for microphone button
  void _handleTapEvent() {
    if (_status == RecordingStatus.processing) return;
    _status == RecordingStatus.recording ? _stopRecording() : _startRecording();
  }

  @override
  Widget build(BuildContext context) {
    // Material You color palette
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    // Recording state variables
    final isRecording = _status == RecordingStatus.recording;
    final isProcessing = _status == RecordingStatus.processing;

    // Colors based on recording state (error* if recording, primary* otherwise)
    final circleBg = isRecording
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;
    final circleFg = isRecording
        ? colorScheme.onErrorContainer
        : colorScheme.onPrimaryContainer;
    final borderColor = isRecording
        ? colorScheme.error
        : colorScheme.outlineVariant;

    // UI Elements
    final microphoneButtonElement = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleBg,
        border: isRecording
            ? Border.all(color: colorScheme.error, width: 2)
            : null,
      ),
      child: GestureDetector(
        onTap: _handleTapEvent,
        child: Center(
          child:
              isProcessing // Spinner if processing, mic icon otherwise (filled when recording)
              ? CircularProgressIndicator(color: circleFg, strokeWidth: 3)
              : Icon(
                  isRecording ? Icons.mic : Icons.mic_none_outlined,
                  size: 40,
                  color: circleFg,
                ),
        ),
      ),
    );

    final timeElapsedElement = Text(
      "${_formatDuration(_timeElapsed)} / ${_formatDuration(_maxDuration)}",
      style: textScheme.titleSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    );

    final recordingStatusElement = Text(
      switch (_status) {
        RecordingStatus.idle => "Ready to Record",
        RecordingStatus.recording => "Recording...",
        RecordingStatus.processing => "Processing...",
      },
      style: textScheme.titleSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    );

    // Build recording card
    return Card(
      // Card Styling
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      color: colorScheme.surfaceContainerLow,

      // Card Elements
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            recordingStatusElement,
            const Spacer(),
            timeElapsedElement,
            const SizedBox(width: 16),
            microphoneButtonElement,
          ],
        ),
      ),
    );
  }
}
