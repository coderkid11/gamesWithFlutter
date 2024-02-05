// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    this.title2 = '',
    required this.subtitle,
    this.subtitle2 = '',
  });

  final String title;
  final String title2;
  final String subtitle;
  final String subtitle2;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          if (title2.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              title2,
              style: Theme.of(context).textTheme.headlineLarge,
            ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          ],
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleLarge,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 1.seconds)
              .then()
              .fadeOut(duration: 1.seconds),
          Text(
            subtitle2,
            style: Theme.of(context).textTheme.titleLarge,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 1.seconds)
              .then()
              .fadeOut(duration: 1.seconds),
        ],
      ),
    );
  }
}
