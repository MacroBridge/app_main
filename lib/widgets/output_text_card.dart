import 'package:MacroBridge/widgets/recording_card.dart';
import 'package:flutter/material.dart';

class OutputTextCard extends StatefulWidget {
  const OutputTextCard({super.key, this.textContent});

  final String? textContent;

  @override
  State<OutputTextCard> createState() => _OutputTextCardState();
}

class _OutputTextCardState extends State<OutputTextCard> {
  // Text box
  late final TextEditingController _controller;
  static const String _placeholderText =
      "Enter text here or describe your meal...";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.textContent ?? "");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OutputTextCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textContent != oldWidget.textContent) {
      _controller.text = widget.textContent ?? "";
    }
  }

  // Event handler for when audio is successfully transcribed
  void _onTranscript(String text) {
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    // Material You color palette
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Textbox Style
    final textBoxStyle = textTheme.bodyMedium?.copyWith(
      fontFamily: "monospace",
      color: colorScheme.onSurface,
    );

    // UI Elements
    final textBoxElement = SizedBox(
      height: 180,
      child: TextField(
        controller: _controller,
        style: textBoxStyle,
        keyboardType: TextInputType.multiline,
        expands: true,
        minLines: null,
        maxLines: null,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(3),
          hintText: _placeholderText,
          hintStyle: textBoxStyle?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );

    // Build output text card
    return Card(
      // Card Styling
      elevation: 3,
      color: colorScheme.surfaceContainerLow,

      // Card Elements
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            RecordingCard(onTranscript: _onTranscript),
            const Divider(height: 20, thickness: 1),
            textBoxElement,
          ],
        ),
      ),
    );
  }
}
