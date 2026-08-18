import 'package:MacroBridge/widgets/output_text_card.dart';
import 'package:flutter/material.dart';

import '../widgets/header_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Build homescreen layout
    return Scaffold(
      appBar: HeaderCard(title: "MacroBridge"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0)
              .copyWith(bottom: 16.0),
          child: Column(children: [OutputTextCard()]),
        ),
      ),
    );
  }
}
