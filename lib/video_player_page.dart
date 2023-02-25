import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
void main() => runApp(const VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://instagram.fist1-2.fna.fbcdn.net/o1/v/t16/f1/m78/5046581EA39BC2BEF7FF05A4ACC4298B_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLnN0b3J5LmJhc2VsaW5lIn0&_nc_ht=instagram.fist1-2.fna.fbcdn.net&_nc_cat=104&vs=705169128056251_2998598360&_nc_vs=HBksFQIYUWlnX3hwdl9wbGFjZW1lbnRfcGVybWFuZW50X3YyLzUwNDY1ODFFQTM5QkMyQkVGN0ZGMDVBNEFDQzQyOThCX3ZpZGVvX2Rhc2hpbml0Lm1wNBUAAsgBABUAGCRHSzJBMmhOLWhNM1U4M3dGQU0wbDJiZ2ZybkZFYnBrd0FBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAACbE5ffir63NQBUCKAJDMywXQDDu2RaHKwIYEmRhc2hfYmFzZWxpbmVfMV92MREAdegHAA%3D%3D&_nc_rid=0e2512e340&ccb=9-4&oh=00_AfAHpsSSi8BTpBRRi2k5k8fypbTf_SkNmRrByuTwbNrBTw&oe=63FA73F5&_nc_sid=21929d')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body:Column(
            children: [
              Container(width: 300,height: 600,
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : null
              ),Container(child: ElevatedButton(child: Text("DOWNLOADO"),onPressed: (){_saveVideo();},),),
            ],
          ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  _saveVideo() async {

     var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    await Dio().download("https://instagram.fist1-2.fna.fbcdn.net/o1/v/t16/f1/m78/5046581EA39BC2BEF7FF05A4ACC4298B_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLnN0b3J5LmJhc2VsaW5lIn0&_nc_ht=instagram.fist1-2.fna.fbcdn.net&_nc_cat=104&vs=705169128056251_2998598360&_nc_vs=HBksFQIYUWlnX3hwdl9wbGFjZW1lbnRfcGVybWFuZW50X3YyLzUwNDY1ODFFQTM5QkMyQkVGN0ZGMDVBNEFDQzQyOThCX3ZpZGVvX2Rhc2hpbml0Lm1wNBUAAsgBABUAGCRHSzJBMmhOLWhNM1U4M3dGQU0wbDJiZ2ZybkZFYnBrd0FBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAACbE5ffir63NQBUCKAJDMywXQDDu2RaHKwIYEmRhc2hfYmFzZWxpbmVfMV92MREAdegHAA%3D%3D&_nc_rid=0e2512e340&ccb=9-4&oh=00_AfAHpsSSi8BTpBRRi2k5k8fypbTf_SkNmRrByuTwbNrBTw&oe=63FA73F5&_nc_sid=21929d", savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    await Dio().delete(savePath);
    print(result);


  }
}