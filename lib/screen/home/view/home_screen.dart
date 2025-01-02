import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/routes/app_routes.dart';
import 'package:galaxy_planets_app/utils/extensions/sizedbox_extension.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    context.read<HomeProvider>().getPlanetList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeProvider>();
    final watch = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeTransition(
                            opacity: animation,
                            child: const Text(
                              'Welcome',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: animation,
                            child: const Text(
                              'Claire Maiden',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.h,
                  // Center(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: List.generate(
                  //       watch.planetList.length,
                  //       (index) => AnimatedContainer(
                  //         duration: const Duration(milliseconds: 300),
                  //         margin: const EdgeInsets.symmetric(horizontal: 5),
                  //         height: 8,
                  //         width: 8,
                  //         decoration: BoxDecoration(
                  //           color: index == watch.selectedPlanetIndex
                  //               ? Colors.white
                  //               : Colors.white54,
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  20.h,
                  if (watch.planetList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            watch.planetList[watch.selectedPlanetIndex].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        20.h,
                        Center(
                          child: Swiper(
                            onTap: (index) {
                              Navigator.pushNamed(context, AppRoutes.detail,
                                  arguments: watch.planetList[index]);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Image.asset(
                                watch.planetList[index].image,
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: watch.planetList.length,
                            itemWidth: 300.0,
                            itemHeight: 400.0,
                            layout: SwiperLayout.TINDER,
                          ),
                        ),
                        20.h,
                      ],
                    ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: watch.planetList.length,
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         onTap: () => read.setSelectedPlanetIndex(index),
                  //         onLongPress: () {
                  //           Navigator.pushNamed(context, AppRoutes.detail,
                  //               arguments: watch.planetList[index]);
                  //         },
                  //         child: Container(
                  //           margin: const EdgeInsets.symmetric(vertical: 10.0),
                  //           padding: const EdgeInsets.all(10.0),
                  //           decoration: BoxDecoration(
                  //             color: index == watch.selectedPlanetIndex
                  //                 ? Colors.white24
                  //                 : const Color(0xFF1B263B),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               ClipRRect(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 child: Image.asset(
                  //                   watch.planetList[index].image,
                  //                   height: 60,
                  //                   width: 60,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
