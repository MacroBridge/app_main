import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget implements PreferredSizeWidget {
  // Header Constructor
  const HeaderCard({super.key, required this.title});

  // Header Parameters
  final String title;

  // Help Message
  static const String _helpMessage = """
  
  """;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(title),
      centerTitle: false,
      elevation: 0,
      actions: [
        IconButton(
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
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
