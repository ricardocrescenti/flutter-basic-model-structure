import 'package:basic_structure/basic_structure.dart';

import '../basic_structure.dart';

abstract class CategoryModelPattern<ImageModel, ParentModel> extends PatternModel {
  String name;
  String description;
  ImageModel image;
  ParentModel parent;

  ImageModel getImageFromJson(dynamic json);
  ParentModel getParentFromJson(dynamic json);
  
  CategoryModelPattern.fromJson(json) : super.fromJson(json);
  CategoryModelPattern.empty() : super.empty();

  @override
  void updateValues(Map<String, dynamic> values) {
    super.updateValues(values);
    name = getJsonValue<String>('name');
    description = getJsonValue<String>('description');
    image = getJsonValue<ImageModel>('image', convertion: (value) => getImageFromJson(value));
    parent = getJsonValue<ParentModel>('parent', convertion: (value) => getParentFromJson(value));
  }

  @override
  Map<String, dynamic> toJson({bool exportOnlyChanged = false, bool ignoreNulls = false}) {
    Map<String, dynamic> map = super.toJson(exportOnlyChanged: exportOnlyChanged, ignoreNulls: ignoreNulls);
    
    setJsonValue(map, 'name', name);
    setJsonValue(map, 'description', description);
    setJsonValue(map, 'image', image);
    setJsonValue(map, 'parent', parent);
    
    return map;
  }
}