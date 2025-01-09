import 'dart:math';

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
          Visibility(
            visible: watch.isDark,
            child: Positioned.fill(
                child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeTransition(
                          opacity: animation,
                          child: const Text(
                            'Explore',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: animation,
                          child: const Text(
                            'Planets',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        read.changeThemeMode();
                      },
                      icon: watch.isDark
                          ? const Icon(
                              Icons.light_mode,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.dark_mode,
                              color: Colors.white,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.favourite);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                40.h,
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
                          onIndexChanged: (value) {
                            read.setSelectedPlanetIndex(value);
                          },
                          onTap: (index) {
                            Navigator.pushNamed(context, AppRoutes.detail,
                                arguments: watch.planetList[index]);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                              watch.planetList[index].image,
                              fit: BoxFit.fitWidth,
                            );
                          },
                          itemCount: watch.planetList.length,
                          itemWidth: 500.0,
                          itemHeight: 400.0,
                          layout: SwiperLayout.TINDER,
                        ),
                      ),
                      20.h,
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Distance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${watch.planetList[watch.selectedPlanetIndex].distanceFromEarth} km",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 40,
                          ),

                          // Dashed Line
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    (constraints.maxWidth / 20).floor(),
                                    (index) => Container(
                                      width: 10,
                                      height: 2,
                                      color: Colors.white70,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Rocket Icon
                          Transform.rotate(
                            angle: 45 * pi / 180,
                            child: const Icon(
                              Icons.rocket_launch,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
