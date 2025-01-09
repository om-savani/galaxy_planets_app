import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/model/data_model.dart';
import 'package:galaxy_planets_app/screen/home/provider/home_provider.dart';
import 'package:galaxy_planets_app/utils/extensions/sizedbox_extension.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    Planet model = ModalRoute.of(context)!.settings.arguments as Planet;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0D1B2A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          model.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              read.toggleFavourite(model.name);
            },
            icon: Icon(
              watch.isFavourite(model.name)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: watch.isDark,
            child: Positioned(
              child: Image.asset(
                'assets/images/background.jpeg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    model.image,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: watch.isDark
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.thermostat_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          5.h,
                          Text(
                            '${model.temperature}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              20.h,
              Text(
                model.type,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              10.h,
              Text(
                "${model.distanceFromEarth} km from Earth",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              30.h,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: watch.isDark
                        ? Colors.transparent
                        : const Color(0xFF1B263B),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        20.h,
                        DetailListTile(
                          icon: Icons.speed,
                          title: 'Average Orbital Speed',
                          value: model.averageOrbitalSpeed,
                        ),
                        DetailListTile(
                          icon: Icons.satellite,
                          title: 'Satellites',
                          value: '${model.numberOfSatellites}',
                        ),
                        DetailListTile(
                          icon: Icons.public,
                          title: 'Surface Area',
                          value: '${model.surfaceArea} km²',
                        ),
                        DetailListTile(
                          icon: Icons.access_time,
                          title: 'Rotation Period',
                          value: '${model.rotationPeriod} ',
                        ),
                        DetailListTile(
                          icon: Icons.access_time,
                          title: 'Orbital Period',
                          value: '${model.orbitalPeriod} ',
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1B2A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              10.h,
                              Text(
                                textAlign: TextAlign.center,
                                model.description,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const DetailListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xFF0D1B2A),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
