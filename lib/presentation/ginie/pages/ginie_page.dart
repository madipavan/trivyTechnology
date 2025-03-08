import 'package:flutter/material.dart';

class GiniePage extends StatefulWidget {
  const GiniePage({super.key});

  @override
  State<GiniePage> createState() => _GiniePageState();
}

class _GiniePageState extends State<GiniePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("GiniePage"),
      ),
    );
  }
}
