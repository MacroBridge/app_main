import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/recording_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Recording Card States
  RecordingStatus recordingStatus = RecordingStatus.idle;

  // Recording State Handlers
  void handleRecordingStart() {
    /*
    TODO: Implement the following steps:
      1. [x] Set recording status to recording
      2. [ ] Start recording audio
    */

    // Set recording status to recording
    setState(() => recordingStatus = RecordingStatus.recording);
  }

  Future<void> handleRecordingStop() async {
    /*
    TODO: Implement following steps:
      1. [ ] Stop recording audio
      2. [x] Update recording status to processing
      2. [ ] Move to processing phase
      3. [ ] Send to STT engine, wait for parsing
      4. [x] Return to idle when done
    */

    // Set recording status to processing
    setState(() => recordingStatus = RecordingStatus.processing);

    await Future.delayed(const Duration(seconds: 3));

    // Set recording status to idle when done
    setState(() => recordingStatus = RecordingStatus.idle);
  }

  @override
  Widget build(BuildContext context) {
    // Build homescreen layout
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Recording Card Element
              RecordingCard(
                status: recordingStatus,
                onStart: handleRecordingStart,
                onStop: handleRecordingStop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
