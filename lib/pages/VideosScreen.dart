import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late List<VideoPlayerController> _videoPlayerControllers = [];
  List<String> videoUrls = []; // List to store fetched video URLs

  @override
  void initState() {
    super.initState();
    _fetchVideoUrls();
  }

  void _fetchVideoUrls() async {
    try {
      // Replace 'videos/' with the actual path in your Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('videos/');

      // List all items under the 'videos/' path
      ListResult result = await storageRef.listAll();

      // Get the download URL for each video and add it to the videoUrls list
      for (Reference ref in result.items) {
        String downloadURL = await ref.getDownloadURL();
        setState(() {
          videoUrls.add(downloadURL);
          _videoPlayerControllers.add(
            VideoPlayerController.network(downloadURL)
              ..initialize().then((_) {
                setState(() {});
              })
              ..addListener(() {
                // Handle video state changes here if needed
              }),
          );
        });
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  @override
  void dispose() {
    for (var controller in _videoPlayerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                _videoPlayerControllers[index].value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            _videoPlayerControllers[index].value.aspectRatio,
                        child: VideoPlayer(_videoPlayerControllers[index]),
                      )
                    : CircularProgressIndicator(), // Show loader while video is loading
                VideoControls(controller: _videoPlayerControllers[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VideoControls extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoControls({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          icon: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
        IconButton(
          onPressed: () {
            controller.seekTo(Duration.zero);
          },
          icon: Icon(Icons.stop),
        ),
        IconButton(
          onPressed: () {
            if (controller.value.isPlaying) {
              controller.pause();
            }
          },
          icon: Icon(Icons.pause),
        ),
      ],
    );
  }
}
