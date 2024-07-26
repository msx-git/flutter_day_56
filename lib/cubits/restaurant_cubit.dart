import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/restaurant.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(InitialState());

  List<Restaurant> restaurants = [
    Restaurant(
      id: UniqueKey().toString(),
      title: "Rayhon",
      lat: "41.2858424",
      long: "69.2057004",
    )
  ];

  Future<void> getRestaurants() async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(LoadedState(restaurants));
  }

  Future<void> addRestaurant({
    required String title,
    required String lat,
    required String long,
  }) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    restaurants.add(
      Restaurant(
        id: UniqueKey().toString(),
        title: title,
        lat: lat,
        long: long,
      ),
    );
    emit(LoadedState(restaurants));
  }
}
