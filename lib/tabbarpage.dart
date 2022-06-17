import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tabs/images.dart';
import 'tabs/videos.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  // here the desired height
                  child: AppBar(
                    backgroundColor: Colors.black87,
                    title: TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black87,
                        indicatorColor: Colors.white,
                        indicatorWeight: 1,
                        labelStyle: TextStyle(fontFamily: 'Poppins'),
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'PHOTOS',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'VIDÉOS',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ]),
                  ))),
          body: const TabBarView(
            children: [
              ImageTab(),
              VideoTab(),
            ],
          )));
}
