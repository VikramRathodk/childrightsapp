import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:video_player/video_player.dart';

class ManageVideosPage extends StatefulWidget {
  const ManageVideosPage({Key? key}) : super(key: key);

  @override
  State<ManageVideosPage> createState() => _ManageVideosPageState();
}

class _ManageVideosPageState extends State<ManageVideosPage> {
  late List<String> videoUrls = []; // List to store uploaded video URLs
  File? _video;
  final picker = ImagePicker();
  late VideoPlayerController _videoController;
  bool isVideoLoaded = false;
  late List<String> videoNames = [];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network('');
    _fetchVideos(); // Fetch uploaded videos on initialization
  }

  Future<void> _fetchVideos() async {
    // Retrieve list of video URLs from Firebase Storage
    ListResult result = await FirebaseStorage.instance.ref('videos/').listAll();
    setState(() {
      videoUrls = result.items.map((item) => item.fullPath).toList();
      videoNames = result.items.map((item) => item.name).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _initializeVideoController();
        isVideoLoaded = true;
      });
    }
  }

  Future<void> uploadVideo() async {
    if (_video != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('videos/${Path.basename(_video!.path)}');
      UploadTask uploadTask = storageReference.putFile(_video!);
      await uploadTask.whenComplete(() {
        print('Video uploaded');
        _fetchVideos(); 
      });
    } else {
      print('No video selected');
    }
  }

  Future<void> deleteVideo(String videoUrl) async {
    Reference storageReference = FirebaseStorage.instance.ref(videoUrl);
    try {
      await storageReference.delete();
      print('Video deleted');
      _fetchVideos(); 
    } catch (e) {
      print('Error deleting video: $e');
    }
  }

  void _initializeVideoController() {
    _videoController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_video != null && isVideoLoaded)
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                )
              else
                Container(),
              ElevatedButton(
                onPressed: () {
                  pickVideo();
                },
                child: Text('Pick Video'),
              ),
              ElevatedButton(
                onPressed: () {
                  uploadVideo();
                },
                child: Text('Upload Video'),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: videoUrls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(videoNames.isNotEmpty ? videoNames[index] : 'Video $index'),
                    onTap: () {
                      // Play the selected video
                      _videoController = VideoPlayerController.network(
                        'https://firebasestorage.googleapis.com/v0/b/your-storage-url.appspot.com/o/${videoUrls[index]}?alt=media',
                      )..initialize().then((_) {
                          setState(() {});
                        });
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteVideo(videoUrls[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
