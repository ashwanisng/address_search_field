library address_search_text_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

part 'src/models/address_point.dart';
part 'src/services/location_service.dart';
part 'src/widgets/address_search_box.dart';

/// A [TextField] wich [onTap] shows
/// a custom [AlertDialog] with a search bar and a
/// list with results called [AddressSearchBox].
class AddressSearchTextField extends StatelessWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle style;

  /// Country to look for an address.
  final String country;

  /// Resulting addresses to be ignored.
  final List<String> exceptions;

  /// If it finds coordinates, they will be set to the reference.
  final bool coordForRef;

  /// Callback to run when search ends.
  final void Function(AddressPoint point) onDone;

  /// Creates a [TextField] wich [onTap] shows
  /// a custom [AlertDialog] with a search bar and a
  /// list with results called [AddressSearchBox].
  AddressSearchTextField({
    TextEditingController controller,
    this.decoration = const InputDecoration(),
    this.style = const TextStyle(),
    @required this.country,
    this.exceptions = const <String>[],
    this.coordForRef = false,
    @required this.onDone,
  })  : assert(country.isNotEmpty, "Country can't be empty"),
        this.controller = controller ?? TextEditingController() {
    LocationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: this.controller,
      decoration: this.decoration,
      style: this.style,
      textCapitalization: TextCapitalization.words,
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AddressSearchBox(
          controller: this.controller,
          country: this.country,
          exceptions: this.exceptions,
          coordForRef: this.coordForRef,
          onDone: this.onDone,
        ),
      ),
    );
  }
}
