import 'package:flutter/material.dart';
import '../imagecontainer.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({Key? key}) : super(key: key);

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          color: Colors.black87,
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    mainAxisExtent: 200),
                children: const [
                  ImageContainer(id: "1"),
                  ImageContainer(id: "2"),
                  ImageContainer(id: "3"),
                  ImageContainer(id: "4"),
                  ImageContainer(id: "5"),
                  ImageContainer(id: "6"),
                  ImageContainer(id: "7"),
                  ImageContainer(id: "8"),
                  ImageContainer(id: "9"),
                  ImageContainer(id: "10"),
                  ImageContainer(id: "11"),
                  ImageContainer(id: "12"),
                ],
              )),
        ));
  }
}
