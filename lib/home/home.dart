import 'dart:developer';
import 'package:barsha_fm_admin_panel/home/page/add_blog.dart';
import 'package:barsha_fm_admin_panel/home/page/add_interview.dart';
import 'package:barsha_fm_admin_panel/home/page/add_live_show.dart';
import 'package:barsha_fm_admin_panel/home/page/add_news.dart';
import 'package:barsha_fm_admin_panel/home/page/add_team_member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.3,
              child: Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Barsha FM',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: const DrawerButton(
                        buttonName: 'Blogs Posts',
                        buttonColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: DrawerButton(
                        buttonName: 'News',
                        buttonColor: Colors.grey[350]!,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: DrawerButton(
                        buttonName: 'Our team members',
                        buttonColor: Colors.grey[350]!,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      child: DrawerButton(
                        buttonName: 'Live Shows',
                        buttonColor: Colors.grey[350]!,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 4;
                        });
                      },
                      child: DrawerButton(
                        buttonName: 'Interviews',
                        buttonColor: Colors.grey[350]!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.76,
              child: IndexedStack(
                index: selectedIndex,
                children: const [
                  BlogsPostScreen(),
                  NewsPostScreen(),
                  TeamMemberScreen(),
                  LiveShowScreen(),
                  InterviewScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsPostScreen extends StatefulWidget {
  const BlogsPostScreen({super.key});

  @override
  State<BlogsPostScreen> createState() => _BlogsPostScreenState();
}

class _BlogsPostScreenState extends State<BlogsPostScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('blog').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> blogSnapshot) {
          if (blogSnapshot.hasData) {
            log('---------${blogSnapshot.data!.docs}');
          }
          if (blogSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Map<String, dynamic>> blogMap = [];
          for (var element in blogSnapshot.data!.docs) {
            blogMap.add(element.data() as Map<String, dynamic>);
          }

          List<Map<String, dynamic>> blogList = blogSnapshot.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

         // log('blogList : ${blogSnapshot.data!.docs.length}');

          return Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Blogs Posts',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: AddBlogPage(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          maximumSize: const Size(144, 48),
                          minimumSize: const Size(144, 48),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Create Blog',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 24),
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8),
                    itemCount: blogMap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, blogIndex) {
                      return Container(
                        height: 260,
                        width: 210,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/radio2.jpg',
                                fit: BoxFit.cover,
                                height: 180,
                                width: 180,
                              ),
                            ),
                            Text(
                              blogMap[blogIndex]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                             Text(
                              blogMap[blogIndex]['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }
}

class NewsPostScreen extends StatefulWidget {
  const NewsPostScreen({super.key});

  @override
  State<NewsPostScreen> createState() => _NewsPostScreenState();
}

class _NewsPostScreenState extends State<NewsPostScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('news').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> newsSnapshot,
        ) {
          
          if (newsSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Map<String, dynamic>> newsMap = [];
          for (var element in newsSnapshot.data!.docs) {
            newsMap.add(element.data() as Map<String, dynamic>);
          }

          List<Map<String, dynamic>> newsList = newsSnapshot.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

         // log('blogList : ${newsSnapshot.data!.docs.length}');

          return Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'News Posts',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: AddNewsPage(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          maximumSize: const Size(144, 48),
                          minimumSize: const Size(144, 48),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Create News',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 24),
                 GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8),
                    itemCount: newsMap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, newsIndex) {
                    return Container(
                      height: 260,
                      width: 210,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/radio2.jpg',
                              fit: BoxFit.cover,
                              height: 180,
                              width: 180,
                            ),
                          ),
                           Text(
                            newsMap[newsIndex]['title'] != null ? newsMap[newsIndex]['title'] : 'Something went wrong',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            newsMap[newsIndex]['description'] != null ? newsMap[newsIndex]['description'] : 'Something wnet wrong',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          );
        });
  }
}

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({super.key});

  @override
  State<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('team').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> teamSnapshot,
        ) {
          if (teamSnapshot.hasData) {
            log('---------${teamSnapshot.data!.docs}');
          }
          if (teamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

         List< Map<String, dynamic>> teamMap = [];
          for (var element in teamSnapshot.data!.docs) {
            teamMap.add(element.data() as Map<String, dynamic>);
          }

          List<Map<String, dynamic>> teamList = teamSnapshot.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

          //log('blogList : ${teamSnapshot.data!.docs.length}');

          return Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Team Member',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: AddTeamMember(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          maximumSize: const Size(144, 48),
                          minimumSize: const Size(144, 48),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Create Team Member',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 24),
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8),
                    itemCount: teamMap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, teamIndex) {
                    return Container(
                      height: 260,
                      width: 210,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/radio2.jpg',
                              fit: BoxFit.cover,
                              height: 180,
                              width: 180,
                            ),
                          ),
                          Text(
                             teamMap[teamIndex]['title'] != null ? teamMap[teamIndex]['title'] : 'Something went wrong',
                             maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                           Text(
                            teamMap[teamIndex]['position'] != null ? teamMap[teamIndex]['position'] : 'Something went wrong',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          );
        });
  }
}

class LiveShowScreen extends StatefulWidget {
  const LiveShowScreen({super.key});

  @override
  State<LiveShowScreen> createState() => _LiveShowScreenState();
}

class _LiveShowScreenState extends State<LiveShowScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('live').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> liveSnapshot,
        ) {
          if (liveSnapshot.hasData) {
            log('---------${liveSnapshot.data!.docs}');
          }
          if (liveSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Map<String, dynamic>> liveMap = [];
          for (var element in liveSnapshot.data!.docs) {
            liveMap.add(element.data() as Map<String, dynamic>);
          }

          List<Map<String, dynamic>> liveList = liveSnapshot.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

         // log('blogList : ${liveSnapshot.data!.docs.length}');

          return Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Live Show',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: AddLiveShowPage(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          maximumSize: const Size(144, 48),
                          minimumSize: const Size(144, 48),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Create Live show',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 24),
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8),
                    itemCount: liveMap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, liveIndex) {
                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.13,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.6,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            'assets/images/radio2.jpg',
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                     Text(
                                      liveMap[liveIndex]['show title'] != null ? liveMap[liveIndex]['show title'] : 'Something went wrong',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 35,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.05,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    color: Colors.grey),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.asset(
                                    "assets/images/radio2.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              child: Text(
                                liveMap[liveIndex]['host name'] != null ? liveMap[liveIndex]['host name'] : 'Something went wrong',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                )
              ],
            ),
          );
        });
  }
}

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('interview').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> interviewSnapshot,
        ) {
          if (interviewSnapshot.hasData) {
            log('---------${interviewSnapshot.data!.docs}');
          }
          if (interviewSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Map<String, dynamic>> interviewMap = [];
          for (var element in interviewSnapshot.data!.docs) {
            interviewMap.add(element.data() as Map<String, dynamic>);
          }

          List<Map<String, dynamic>> interviewList = interviewSnapshot
              .data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

         // log('blogList : ${interviewSnapshot.data!.docs.length}');

          return Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Interview',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: AddInterviewPage(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          maximumSize: const Size(144, 48),
                          minimumSize: const Size(144, 48),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Create Latest Interview',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 24),
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8),
                    itemCount: interviewMap.length,
                    shrinkWrap: true,
                    itemBuilder: (context, interviewIndex) {
                    return Container(
                      height: 260,
                      width: 210,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/radio2.jpg',
                              fit: BoxFit.cover,
                              height: 180,
                              width: 180,
                            ),
                          ),
                           Text(
                            interviewMap[interviewIndex]['title'] != null ? interviewMap[interviewIndex]['title'] : 'Something went wrong',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                           Text(
                            interviewMap[interviewIndex]['description'] != null ? interviewMap[interviewIndex]['description'] : 'Something went wrong',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          );
        });
  }
}

class DrawerButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  const DrawerButton({
    required this.buttonName,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 190,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        buttonName,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
