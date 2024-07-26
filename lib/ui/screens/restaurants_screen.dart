import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/restaurant_cubit.dart';
import '../../cubits/restaurant_state.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => context.read<RestaurantCubit>().getRestaurants(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(child: Text("Restaurants aren't loaded yet."));
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          final restaurants = (state as LoadedState).restaurants;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) => ListTile(
              leading: Text("${index + 1}"),
              title: Text(restaurants[index].title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.place_outlined,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_note_outlined,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
