import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:snapkit/snapkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({Key? key}) : super(key: key);

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  File? video;
  String? videoP;
  String? localVideo;
  String? videoFinal;
  Snapkit snapkit = Snapkit();

  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    print(videoP);
  }

  @override
  void dispose() {
    // controller!.dispose();
    super.dispose();
  }

  Future pickVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    final videoTemp = File(video.path);

    setState(() => this.video = videoTemp);
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    // final File localVideo = await videoTemp.copy('$dirPath/video.mp4');

    setState(() {
      videoP = video.path;
    });

    setState(() {
      if (File('$dirPath/video.mp4').existsSync()) {
        videoFinal = '$dirPath/video.mp4';
        print(videoFinal);
      }
    });

    controller = VideoPlayerController.file(File(videoP!))
      ..initialize().then((_) {
        setState(() {});
      });

    controller!.play();
  }

  Future sendVideo() async {
    snapkit.share(SnapchatMediaType.VIDEO,
        // videoPath: 'assets/videos/TestVideo.mp4',
        videoPath: videoFinal);
    print(videoP);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: GestureDetector(
            onTap: () {
              pickVideo();
            },
            child: (videoP != null)
                ? AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoPlayer(controller!),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(30), // Image radius
                      child: Image.asset('assets/images/video.png',
                          width: 70, fit: BoxFit.cover),
                    ),
                  )

            // : Image.asset(
            //     'assets/images/video.png',
            //     width: 70,
            //   ), //
            ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 50,
              color: Colors.black,
              child: Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: double.infinity,
                          color: Colors.white,
                          onPressed: () {
                            sendVideo();
                          },
                          child: Text('SNAPPER LA VIDÉO',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                              ))))))),
    );
  }
}
