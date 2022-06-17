import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapkit/snapkit.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class ImageContainer extends StatefulWidget {
  final String id;

  const ImageContainer({Key? key, required this.id}) : super(key: key);

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File? image;
  String? fileName;
  String? appPath;
  String? key;
  Snapkit snapkit = Snapkit();
  String? imageC;
  String? widgetid;
  String? finalLink;
  

  @override
  void initState() {
    super.initState();

    getDir();
  }

  getDir() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    setState(() {
      appPath = appDir.path;
      widgetid = widget.id;
      finalLink = '$appPath/${widget.id}.jpg';
    });

    print(appPath);
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      Navigator.of(context).pop();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      final Directory extDir = await getApplicationDocumentsDirectory();
      String dirPath = extDir.path;
      var fileName = widget.id;
      final File localImage = await imageTemp.copy('$dirPath/$fileName.jpg');

      setState(() {
        imageC = image.path;
        finalLink = imageC;

        // bool check = (File('$appPath/${widget.id}.jpg').existsSync());
      });
    }

    Future sendPhoto() async {
      if ((File('$appPath/${widget.id}.jpg').existsSync())) {
        snapkit.share(
          SnapchatMediaType.PHOTO,
          image: FileImage(
            File('$appPath/${widget.id}.jpg'),
          ),
        );
      }
    }

    Future deleteImage() async {
      (File('$appPath/${widget.id}.jpg')).delete();
      Navigator.of(context).pop();

      setState(() {
        finalLink = null;
        // final bool check = (File('$appPath/${widget.id}.jpg').existsSync());
      });
    }

    Future openPopup() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(10.0),
            content: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: double.infinity,
                        color: Colors.white,
                        onPressed: () {
                          pickImage();
                        },
                        child: Text(
                          'AJOUTER UNE IMAGE',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        )),
                    SizedBox(height: 10),
                    MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: double.infinity,
                        color: Colors.red,
                        onPressed: () {
                          deleteImage();
                        },
                        child: Text(
                          'VIDER LE SLOT',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ))
                  ],
                ))));

    bool check = (File('$finalLink').existsSync());
    return GestureDetector(
        onTap: () {
          openPopup();
        },
        child: Container(
            decoration: BoxDecoration(
                image: check
                    ? DecorationImage(
                        image: FileImage(
                          File('$finalLink'),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(5)),
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  color: Colors.white,
                  onPressed: () {
                    sendPhoto();
                  },
                  child: Text(
                    'SNAPPER',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            )));
  }
}
