import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget implements PreferredSizeWidget {
  // Header Constructor
  const HeaderCard({super.key, required this.title});

  // Header Parameters
  final String title;

  // Help Message
  static const String _helpMessage = "PLACEHOLDER HELP MESSAGE";

  // Build
  @override
  Widget build(BuildContext context) {
    // UI Elements
    final helpIconButtonElement = IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: _helpMessage,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Help'),
            content: const Text(_helpMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );

    // Build header bar
    return AppBar(
      title: Text(title),
      centerTitle: false,
      elevation: 0,
      actions: [helpIconButtonElement, const SizedBox(width: 6)],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
