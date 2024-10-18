import 'dart:io';

import 'package:chewie/src/chewie_player.dart';
import 'package:chewie/src/helpers/adaptive_controls.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerWithControls extends StatelessWidget {
  const PlayerWithControls({super.key});

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    double calculateAspectRatio(BuildContext context) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;

      return width > height ? width / height : height / width;
    }

    Widget buildControls(
      BuildContext context,
      ChewieController chewieController,
    ) {
      return chewieController.showControls
          ? chewieController.customControls ?? const AdaptiveControls()
          : const SizedBox();
    }

    Widget buildPlayerWithControls(
      ChewieController chewieController,
      BuildContext context,
    ) {
      return Stack(
        children: <Widget>[
          if (chewieController.placeholder != null)
            chewieController.placeholder!,
          !chewieController.isFullScreen
              ? chewieController.isNetworkUrl
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      clipBehavior: Clip
                          .hardEdge, // It's highly advisable to use this behavior to improve performance.

                      child: Image.network(
                          loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return chewieController.imageLoadingIndeicater;
                      }, chewieController.thumbnailUrl))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      clipBehavior: Clip
                          .hardEdge, // It's highly advisable to use this behavior to improve performance.

                      child: Image.file(File(chewieController.thumbnailUrl)))
              : InteractiveViewer(
                  transformationController:
                      chewieController.transformationController,
                  maxScale: chewieController.maxScale,
                  panEnabled: chewieController.zoomAndPan,
                  scaleEnabled: chewieController.zoomAndPan,
                  child: Center(
                      child: chewieController.isFullScreen
                          ? AspectRatio(
                              aspectRatio: chewieController.aspectRatio ??
                                  chewieController
                                      .videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(
                                  chewieController.videoPlayerController),
                            )
                          : Container())),
          if (!chewieController.isFullScreen)
            buildControls(context, chewieController)
          else
            SafeArea(
              bottom: false,
              child: buildControls(context, chewieController),
            ),
        ],
      );
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
        child: SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: AspectRatio(
            aspectRatio: calculateAspectRatio(context),
            child: buildPlayerWithControls(chewieController, context),
          ),
        ),
      );
    });
  }
}
