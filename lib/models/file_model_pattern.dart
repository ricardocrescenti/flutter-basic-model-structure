import 'dart:io';

import 'package:basic_structure/basic_structure.dart';

abstract class FileModelPattern extends PatternModel {
  StorageUploaderManager _uploadPhotoManager;
  StorageUploaderManager get uploadPhotoManager {
    if (_uploadPhotoManager == null) {
      _uploadPhotoManager = initializeUploadPhotoManager();
    }
    return _uploadPhotoManager;
  }
  set uploadPhotoManager(StorageUploaderManager value) {
    _uploadPhotoManager = value;
  }
  
  final Map<String,String> _cachePublicUrl = Map();

  File downloadedPhotoFile;

  String type;
  String content;
  BigInt views;
  String privateUrl;
  String publicUrl;

  initializeUploadPhotoManager();

  Future<String> getPublicUrl({int size}) async {
    if (publicUrl != null && publicUrl.isNotEmpty) {
      return (size != null ? publicUrl.replaceAll('.jpg', '@$size.jpg') : publicUrl);
    }

    if (privateUrl == null || privateUrl.isEmpty) {
      return '';
    }

    String privateUrlSize = (size != null ? privateUrl.replaceAll('.jpg', '@$size.jpg') : privateUrl);
    if (_cachePublicUrl[privateUrlSize] != null) {
      return _cachePublicUrl[privateUrlSize];
    }

    String publicUrlSize = await generatePublicUrl(privateUrlSize);
    _cachePublicUrl[privateUrlSize] = publicUrlSize;

    return publicUrlSize;
  }

  Future<String> generatePublicUrl(String privateUrl) async {
    return await uploadPhotoManager.storageReference.getRoot().child(privateUrl).getDownloadURL();
  }

  FileModelPattern.fromJson(json) : super.fromJson(json);
  FileModelPattern.empty() : super.empty();

  @override
  void updateValues(Map<String, dynamic> values) {
    super.updateValues(values);
    type = getJsonValue('type');
    content = getJsonValue('content');
    views = getJsonValue('views');
    privateUrl = getJsonValue('private_url');
    publicUrl = getJsonValue('public_url');
  }

  @override
  Map<String, dynamic> toJson({bool exportOnlyChanged = false, bool ignoreNulls = false}) {
    Map<String, dynamic> map = super.toJson(exportOnlyChanged: exportOnlyChanged, ignoreNulls: ignoreNulls);
    
    setJsonValue(map, 'type', type);
    setJsonValue(map, 'content', content);
    setJsonValue(map, 'private_url', privateUrl);
    setJsonValue(map, 'public_url', publicUrl);
    
    return map;
  }
}