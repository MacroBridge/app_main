import 'package:flutter/material.dart';

enum RecordingStatus { idle, recording, processing }

// Recording Card widget - parent state management
class RecordingCard extends StatelessWidget {
  // Widget Constructor
  const RecordingCard({
    super.key,
    required this.status,
    required this.onStart,
    required this.onStop,
  });

  // Widget Parameters
  final RecordingStatus status;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    // Material You color palette
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    // Recording state variables
    final isRecording = status == RecordingStatus.recording;
    final isProcessing = status == RecordingStatus.processing;

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

    // Event Handlers
    void handleRecordingStatus() {
      // Do nothing if recording is being processed
      if (isProcessing) return;

      if (isRecording) {
        // Call stop recording callback if recording
        onStop();
      } else {
        // Call start recording callback if not recording
        onStart();
      }
    }

    // Animation Constants
    const animationDuration = Duration(milliseconds: 250);
    const animationCurve = Curves.easeInOut;

    // UI Elements
    final microphoneButtonElement = GestureDetector(
      onTap: handleRecordingStatus,
      child: Center(
        child:
            isProcessing // Spinner if processing, mic icon otherwise (filled when recording)
            ? CircularProgressIndicator(color: circleFg, strokeWidth: 3)
            : Icon(
                isRecording ? Icons.mic : Icons.mic_none_outlined,
                size: 56,
                color: circleFg,
              ),
      ),
    );

    final recordingStatusElement = SizedBox(
      width: double.infinity,
      height: 30,
      child: Center(
        child: Text(
          switch (status) {
            RecordingStatus.idle => "Ready to Record",
            RecordingStatus.recording => "Recording...",
            RecordingStatus.processing => "Processing...",
          },
          style: textScheme.titleSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Microphone Icon
            AnimatedContainer(
              duration: animationDuration,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleBg,
                border: isRecording
                    ? Border.all(color: colorScheme.error, width: 2)
                    : null,
              ),
              child: microphoneButtonElement,
            ),

            // Separator
            const SizedBox(height: 24),

            // Recording Status
            recordingStatusElement,
          ],
        ),
      ),
    );
  }
}
