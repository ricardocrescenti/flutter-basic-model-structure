import 'package:basic_structure/basic_structure.dart';

import '../basic_structure.dart';

abstract class CategoryModelPattern<ImageModel extends ImageModelPattern> extends PatternModel {
  String name;
  String description;
  ImageModel image;

  ImageModel getPhotoFromJson(dynamic json);
  
  CategoryModelPattern.fromJson(json) : super.fromJson(json);
  CategoryModelPattern.empty() : super.empty();

  @override
  void updateValues(Map<String, dynamic> values) {
    super.updateValues(values);
    name = getJsonValue<String>('name');
    description = getJsonValue<String>('description');
    image = getJsonValue<ImageModel>('image', convertion: (value) => getPhotoFromJson(value));
  }
}