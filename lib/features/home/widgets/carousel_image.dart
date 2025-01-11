import 'package:flutter/material.dart';

class PageViewImage extends StatefulWidget {
  const PageViewImage({super.key});

  @override
  _PageViewImageState createState() => _PageViewImageState();
}

class _PageViewImageState extends State<PageViewImage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  List<String> carouselImages = [
    'assets/carousel/carousel1.jpg',
    'assets/carousel/carousel2.jpg',
    'assets/carousel/carousel3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (_controller.hasClients) {
      if (_currentIndex == carouselImages.length - 1) {
        _controller.animateToPage(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        _controller.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }

      // Delay the next scroll
      Future.delayed(const Duration(seconds: 3), _autoScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width, // Height of the carousel
          child: PageView.builder(
            controller: _controller,
            itemCount: carouselImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                carouselImages[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselImages.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.jumpToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
