import 'package:flutter/material.dart';

import '../widgets/header_card.dart';
import '../widgets/recording_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onTranscript(String text) {
    // TODO: Do something with the transcript
  }

  @override
  Widget build(BuildContext context) {
    // Build homescreen layout
    return Scaffold(
      appBar: HeaderCard(title: "MacroBridge"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0)
              .copyWith(bottom: 16.0),
          child: Column(
            children: [
              // Recording Card Element
              RecordingCard(onTranscript: onTranscript),
            ],
          ),
        ),
      ),
    );
  }
}
