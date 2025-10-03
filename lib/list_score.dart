import 'package:flutter/material.dart';

class ListScore extends StatefulWidget {
  final List<Icon>? listScore;
  const ListScore({super.key, this.listScore});

  @override
  State<ListScore> createState() => _ListScoreState();
}

class _ListScoreState extends State<ListScore> {
  @override
  Widget build(BuildContext context) {
    return Row(children: widget.listScore!);
  }
}
