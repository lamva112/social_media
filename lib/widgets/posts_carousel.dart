import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/post_model.dart';

class PostsCarousel extends StatelessWidget {
  final PageController? pageController;
  final String title;
  final List<Post> post;

  const PostsCarousel({super.key, this.pageController, this.title = '', this.post = const []});

  Widget _buildPost(context, index) {
    Post post = posts[index];
    double value = (index == 1) ? 0.75 : 1;

    return AnimatedBuilder(
      animation: pageController!,
      builder: (BuildContext context,Widget? widget){
        if(pageController!.position.haveDimensions){
          value = ((pageController!.page ?? 0) - index);
          value = (1 - (value.abs() * 0.25)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                height: 400.0,
                width: 300.0,
                image: AssetImage(post.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            post.likes.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(post.comments.toString()),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          ),
        ),
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: pageController,
              itemCount: post.length,
              itemBuilder: (_, index) {
                return _buildPost(context, index);
              }),
        )
      ],
    );
  }
}
