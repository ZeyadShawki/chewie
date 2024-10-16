import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class AdaptiveControls extends StatelessWidget {
  const AdaptiveControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const MaterialControls();

      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return const MaterialControls();

      case TargetPlatform.iOS:
        return const MaterialControls();
      default:
        return const MaterialControls();
    }
  }
}
