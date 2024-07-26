import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_56/cubits/restaurant_cubit.dart';
import 'package:flutter_day_56/ui/screens/restaurants_screen.dart';
import 'package:flutter_day_56/ui/widgets/manage_restaurant.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YandexMapController mapController;

  List<MapObject>? polylines;

  Point myCurrentLocation = const Point(
    latitude: 41.2624092,
    longitude:69.1517428,
  );

  // Point najotTalim = const Point(
  //   latitude: 41.2856806,
  //   longitude: 69.2034646,
  // );

  void onMapCreated(YandexMapController controller) {
    mapController = controller;

    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myCurrentLocation,
          zoom: 20,
        ),
      ),
    );
    setState(() {});
  }

  void onCameraPositionChanged(
    CameraPosition position,
    CameraUpdateReason reason,
    bool finished,
  ) async {
    myCurrentLocation = position.target;

    if (finished) {
      // polylines =
      //     await YandexMapService.getDirection(najotTalim, myCurrentLocation);
    }

    setState(() {});
  }

  List<PlacemarkMapObject> placeObjects = [];

  void addRestaurant(PlacemarkMapObject restaurant) {
    placeObjects.add(restaurant);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeObjects = context
        .read<RestaurantCubit>()
        .restaurants
        .map(
          (e) => PlacemarkMapObject(
            mapId: MapObjectId(UniqueKey().toString()),
            point: Point(
              latitude: double.parse(e.lat),
              longitude: double.parse(e.long),
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  "assets/route_start.png",
                ),
              ),
            ),
            text: PlacemarkText(
              text: e.title,
              style: const PlacemarkTextStyle(color: Colors.red, size: 20),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            onCameraPositionChanged: onCameraPositionChanged,
            mapType: MapType.vector,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId("myCurrentLocation"),
                point: myCurrentLocation,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/place.png",
                    ),
                  ),
                ),
              ),
              ...placeObjects,
              ...?polylines,
            ],
          ),
          SafeArea(
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (ctx) => const RestaurantsScreen()),
              ),
              child: const Text("Restaurants"),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ManageRestaurant(point: myCurrentLocation),
          );
          // addRestaurant(
          //   PlacemarkMapObject(
          //     mapId: MapObjectId(UniqueKey().toString()),
          //     point: const Point(
          //       latitude: 41.2818424,
          //       longitude: 69.2017004,
          //     ),
          //     icon: PlacemarkIcon.single(
          //       PlacemarkIconStyle(
          //         image: BitmapDescriptor.fromAssetImage(
          //           "assets/route_start.png",
          //         ),
          //       ),
          //     ),
          //     text: const PlacemarkText(
          //       text: "Rayhon",
          //       style: PlacemarkTextStyle(),
          //     ),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
