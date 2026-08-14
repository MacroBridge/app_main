import 'package:flutter/material.dart';

enum RecordingStatus { idle, recording, processing }

// Recording Card widget - parent state management
class RecordingCard extends StatelessWidget {
  // Widget Parameters
  final RecordingStatus status;
  final VoidCallback onStart;
  final VoidCallback onStop;

  // Widget Constructor
  const RecordingCard({
    super.key,
    required this.status,
    required this.onStart,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    // Material You color palette
    final colors = Theme.of(context).colorScheme;

    // Recording state variables
    final isRecording = status == RecordingStatus.recording;
    final isProcessing = status == RecordingStatus.processing;

    // Colors based on recording state (error* if recording, primary* otherwise)
    final circleBg = isRecording
        ? colors.errorContainer
        : colors.primaryContainer;
    final circleFg = isRecording
        ? colors.onErrorContainer
        : colors.onPrimaryContainer;
    final borderColor = isRecording ? colors.error : colors.outlineVariant;

    // Microphone Button Element
    final MicrophoneButtonElem = Center(
      child:
          isProcessing // Spinner if processing, mic icon otherwise
          ? CircularProgressIndicator(color: circleFg, strokeWidth: 3)
          : Icon(
              // Mic icon is filled when recording
              isRecording ? Icons.mic : Icons.mic_none_outlined,
              size: 56,
              color: circleFg,
            ),
    );

    // Build recording card
    return Card(
      // Card Styling
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(24),
      ),
      color: colors.surfaceContainerLow,

      // Card Elements
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Microphone Circle Element
            AnimatedScale(
              scale: isRecording ? 1.08 : 1.0, // Increase size when recording
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                // Color/border transition speed
                duration: const Duration(milliseconds: 250),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleBg,
                  border:
                      isRecording // Show border only when recording
                      ? Border.all(color: colors.error, width: 2)
                      : null,
                ),
                child: MicrophoneButtonElem,
              ),
            ),

            // Separator Element
            const SizedBox(height: 24),

            // Recording Button Element
            SizedBox(
              width: double.infinity,
              height: 48,
              // Swap button based on state, not its label
              child: isRecording
                  ? FilledButton.icon(
                      onPressed: onStop,
                      icon: const Icon(Icons.stop_circle_outlined),
                      label: const Text('Stop Recording'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.error,
                        foregroundColor: colors.onError,
                      ),
                    )
                  : FilledButton.tonalIcon(
                      onPressed: isProcessing ? null : onStart,
                      // Disabled during processing
                      icon: const Icon(Icons.mic_outlined),
                      label: Text(
                        isProcessing ? 'Processing...' : 'Start Recording',
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.secondaryContainer,
                        foregroundColor: colors.onSecondaryContainer,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
