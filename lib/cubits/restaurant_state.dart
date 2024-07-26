import '../data/restaurant.dart';

sealed class RestaurantState {}

final class InitialState extends RestaurantState {}

final class LoadingState extends RestaurantState {}

final class LoadedState extends RestaurantState {
  List<Restaurant> restaurants;

  LoadedState(this.restaurants);
}

final class ErrorState extends RestaurantState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
