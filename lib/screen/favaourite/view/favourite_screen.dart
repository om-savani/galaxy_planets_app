import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/data_model.dart';
import '../../../routes/app_routes.dart';
import '../../home/provider/home_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    List<Planet> favoritePlanets = watch.planetList
        .where((planet) => watch.isFavourite(planet.name))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Favourite Planets",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: watch.isDark,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          favoritePlanets.isNotEmpty
              ? ListView.builder(
                  itemCount: favoritePlanets.length,
                  itemBuilder: (context, index) {
                    final planet = favoritePlanets[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detail,
                          arguments: planet,
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(planet.image),
                      ),
                      title: Text(
                        planet.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${planet.distanceFromEarth} km from Earth",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          watch.toggleFavourite(planet.name);
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No favourite planets added yet!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
