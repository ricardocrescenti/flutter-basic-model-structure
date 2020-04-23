import 'package:basic_structure/basic_structure.dart';

import '../basic_structure.dart';

abstract class CategoryModelPattern<ImageModel extends ImageModelPattern> extends PatternModel {
  String name;
  String description;
  ImageModel image;

  ImageModel getPhotoFromJson(dynamic json);

  @override
  CategoryModelPattern.fromJson(json): super.fromJson(json) {
    name = getJsonValue<String>('name');
    description = getJsonValue<String>('description');
    image = getJsonValue<ImageModel>('image', convertion: (value) => getPhotoFromJson(value));
  }
}