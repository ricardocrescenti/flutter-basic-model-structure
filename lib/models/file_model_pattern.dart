import 'dart:io';

import 'package:basic_model_structure/basic_model_structure.dart';

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

  StorageUploaderManager initializeUploadPhotoManager();

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

  FileModelPattern();  
  FileModelPattern.fromJson(json) : super.fromJson(json);

  @override
  void readValues() {
    super.readValues();
    type = readValue('type');
    content = readValue('content');
    privateUrl = readValue('privateUrl');
    publicUrl = readValue('publicUrl');
  }

  @override
  void writeValues(bool exportOnlyChanged, bool ignoreNulls) {
    writeValue('type', type);
    writeValue('content', content);
    writeValue('privateUrl', privateUrl);
    writeValue('publicUrl', publicUrl);
  }
}
