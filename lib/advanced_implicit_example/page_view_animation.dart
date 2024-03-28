import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learning_animations/advanced_implicit_example/page_view_item.dart';
import 'package:learning_animations/advanced_implicit_example/reuseable_text.dart';

class PageViewAnimation extends StatefulWidget {
  const PageViewAnimation({super.key});

  @override
  State<PageViewAnimation> createState() => _PageViewAnimationState();
}

class _PageViewAnimationState extends State<PageViewAnimation> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;
    final List<String> locations = [
      'atcostal',
      'dubia',
      'afganistan',
    ];

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const ReuseableText(
          text: 'Interests',
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
        leading: const Icon(Iconsax.search_normal, color: Colors.white),
        actions: const [
          Icon(Iconsax.location5, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: locations.length,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return PageViewItem(
            location: locations[index],
            index: index,
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        destinations: const [
          Icon(Iconsax.location, color: Colors.white),
          Icon(Iconsax.location_add, color: Colors.white),
          Icon(Iconsax.profile_2user, color: Colors.white),
        ],
      ),
    );
  }
}
