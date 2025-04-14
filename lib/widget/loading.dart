import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isFullScreen;

  const LoadingWidget({Key? key, required this.isFullScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}