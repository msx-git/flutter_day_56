import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_56/cubits/restaurant_cubit.dart';
import 'package:flutter_day_56/ui/widgets/my_text_form_field.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../data/restaurant.dart';

class ManageRestaurant extends StatefulWidget {
  const ManageRestaurant({super.key, this.restaurant, this.point});

  final Restaurant? restaurant;
  final Point? point;

  @override
  State<ManageRestaurant> createState() => _ManageRestaurantState();
}

class _ManageRestaurantState extends State<ManageRestaurant> {
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text =
        widget.restaurant == null ? "" : widget.restaurant!.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.restaurant == null ? "Add a restaurant" : "Edit the restaurant",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextFormField(
              label: widget.restaurant == null ? "Restaurant name" : "New name",
              controller: titleController,
              validator: (p0) {
                if (p0!.trim().isEmpty) {
                  return widget.restaurant == null
                      ? "Enter restaurant name"
                      : "Enter new name";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.restaurant == null
                ? context.read<RestaurantCubit>().addRestaurant(
                      title: titleController.text.trim(),
                      lat: widget.point!.latitude.toString(),
                      long: widget.point!.longitude.toString(),
                    )
                : null;
          },
          child: Text(
            widget.restaurant == null ? "Add" : "Save",
            style: const TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
