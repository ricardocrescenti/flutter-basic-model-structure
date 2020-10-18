import 'package:useful_classes/useful_classes.dart';

abstract class PatternModel extends BasicModel {
  BigInt id;
  String uuid;
  DateTime createdAt;
  DateTime updatedAt;

  PatternModel() : super();  
  PatternModel.fromJson(json) : super.fromJson(json);

  @override
  void readValues() {
    id = readValue<BigInt>('id', convertion: (value) => BigInt.parse(value.toString()));
    uuid = readValue<String>('uuid');
    createdAt = readValue<DateTime>('created_at');
    updatedAt = readValue<DateTime>('updated_at');
  }
}
