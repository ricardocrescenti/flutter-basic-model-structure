import 'package:basic_structure/basic_structure.dart';

import '../basic_structure.dart';

abstract class CategoryModelPattern<ImageModel, ParentModel> extends PatternModel {
  String name;
  String description;
  ImageModel image;
  ParentModel parent;

  ImageModel getImageFromJson(dynamic json);

  ParentModel getParentFromJson(dynamic json);
  
  CategoryModelPattern() : super();  
  CategoryModelPattern.fromJson(json) : super.fromJson(json);

  @override
  void readValues() {
    super.readValues();
    name = readValue<String>('name');
    description = readValue<String>('description');
    image = readValue<ImageModel>('image', convertion: (value) => getImageFromJson(value));
    parent = readValue<ParentModel>('parent', convertion: (value) => getParentFromJson(value));
  }

  @override
  void writeValues(bool exportOnlyChanged, bool ignoreNulls) {
    writeValue('name', name);
    writeValue('description', description);
    writeValue('image', image);
    writeValue('parent', parent);
  }
}


class Teste extends CategoryModelPattern<dynamic, Teste> {

  Teste() : super();
  Teste.fromJson(json) : super.fromJson(json);

  @override
  getImageFromJson(json) {
    throw UnimplementedError();
  }

  @override
  Teste getParentFromJson(json) {
    throw UnimplementedError();
  }

}

Teste getTeste() {
  return Teste();
}