import 'dart:convert';

import 'package:flutter/cupertino.dart';

abstract class PatternModel {
  Map<String, dynamic> json;
  Map<String, dynamic> _lastJson;
  bool _exportOnlyChanged;
  bool _ignoreNulls;

  BigInt id;
  String uuid;
  DateTime createdAt;
  DateTime updatedAt;

  PatternModel();

  getJsonValue<T>(String fieldName, {T Function(dynamic value) convertion, T nullValue}) {
    if (this._lastJson[fieldName] != null) {
      if (convertion != null) {
        return convertion(this._lastJson[fieldName]);
      } else if (T == int) {
        return int.parse(this._lastJson[fieldName].toString());
      } else if (T == BigInt) {
        return BigInt.parse(this._lastJson[fieldName].toString());
      } else if (T == double) {
        return double.parse(this._lastJson[fieldName].toString());
      } else if (T == DateTime) {
        if (!(this._lastJson[fieldName] is DateTime)) {
          return DateTime.parse(this._lastJson[fieldName].toString());
        }
      }
      return this._lastJson[fieldName] as T;
    }
    return nullValue;
  }
  setJsonValue(Map map, String fieldName, dynamic value, {bool onlyNotNull = false, alwaysExport = false, dynamic Function(dynamic value) convertion, dynamic nullValue}) {    
    if ((onlyNotNull || _ignoreNulls) && value == null) {
      return;
    }

    if (value is List && convertion != null) {
      value = (value as List).map((item) => convertion(item)).toList();
    } else {
      value = (convertion != null ? convertion(value) : value);
    }

    value ??= nullValue;

    if (_exportOnlyChanged != null && json != null && _exportOnlyChanged && json[fieldName] == value && (alwaysExport == null || alwaysExport == false)) {
      return;
    }

    map[fieldName] = value;
  }

  @mustCallSuper
  PatternModel.fromJson(dynamic json) {
    if (json is String) {
      this.json = jsonDecode(json);
    } else {
      this.json = Map.from(json);
    }

    updateValues(json);
  }
  @mustCallSuper
  PatternModel.empty() {
    json = Map();
  }

  @mustCallSuper
  void updateValues(Map<String, dynamic> values) {
    _lastJson = values;
    id = getJsonValue<BigInt>('id', convertion: (value) => BigInt.parse(value.toString()));
    uuid = getJsonValue<String>('uuid');
    createdAt = getJsonValue<DateTime>('created_at');
    updatedAt = getJsonValue<DateTime>('updated_at');
  }

  @mustCallSuper
  Map<String, dynamic> toJson({bool exportOnlyChanged = false, bool ignoreNulls = false}) {
    Map map = Map<String, dynamic>();
    _exportOnlyChanged = exportOnlyChanged;
    _ignoreNulls = ignoreNulls;

    setJsonValue(map, 'id', id, onlyNotNull: true, alwaysExport: true);
    setJsonValue(map, 'uuid', uuid, onlyNotNull: true, alwaysExport: true);

    return map;
  }
}