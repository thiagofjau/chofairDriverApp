import 'package:flutter/material.dart';

class RatingTabPage extends StatefulWidget {
  const RatingTabPage({super.key});

  @override
  State<RatingTabPage> createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ratings'
      ),
    );
  }
}