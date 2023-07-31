import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/widgets/posts_carousel.dart';

import '../data/data.dart';
import '../widgets/following_users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  late PageController _favoritesPageController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0,viewportFraction: 0.8,keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'FRENZY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          tabs: const [
            Tab(
              text: 'Trending',
              icon: Icon(Icons.trending_up),
            ),
            Tab(
              text: 'Lastest',
              icon: Icon(Icons.local_fire_department),
            )
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              FollowingUsers(),
              PostsCarousel(
                pageController: _pageController,
                title: 'Posts',
                post: posts,
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
