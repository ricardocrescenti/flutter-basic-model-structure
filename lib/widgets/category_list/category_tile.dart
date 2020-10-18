import 'package:flutter/material.dart';
import 'package:basic_model_structure/basic_model_structure.dart';

enum TextPosition { Center, TopInside, TopOutside, BottomInside, BottomOutside }

class CategoryTile extends StatelessWidget {
  final CategoryModelPattern category;
  final bool showImagem;
  final int flex;
  final double width;
  final double height;
  final TextPosition textPosition;
  final Widget Function(BuildContext context, CategoryModelPattern category) buildImage;
  final Widget Function(BuildContext context, CategoryModelPattern category) buildName;
  
  CategoryTile(this.category, {
    this.showImagem = true,
    this.flex,
    this.width,
    this.height,
    this.textPosition = TextPosition.BottomInside,
    this.buildImage,
    this.buildName
   });

  @override
  Widget build(BuildContext context) {
    Widget item = Container(
      width: width,
      height: height,
      child: Stack(
        alignment: _getStackAlignment(),
        children: <Widget>[
          _buildImage(context, category),
          _buildName(context, category)
        ],
      )
    );

    if (flex != null && flex > 0) {
      item = Flexible(child: item, flex: flex);
    }

    return item;
  }

  AlignmentDirectional _getStackAlignment() {
    switch (this.textPosition) {
      case TextPosition.Center: return AlignmentDirectional.center; break;
      case TextPosition.TopInside: return AlignmentDirectional.topCenter; break;
      case TextPosition.TopOutside: return AlignmentDirectional.topCenter; break;
      case TextPosition.BottomInside: return AlignmentDirectional.bottomCenter; break;
      case TextPosition.BottomOutside: return AlignmentDirectional.bottomCenter; break;
      default: throw ArgumentError('Invalid textPosition');
    }
  }
  _buildImage(BuildContext context, CategoryModelPattern category) {
    return (buildName != null ? buildImage(context, category) : Container(
      margin: EdgeInsets.all(2),
      color: Colors.redAccent
    ));
  }
  _buildName(BuildContext context, CategoryModelPattern category) {
    return (buildName != null ? buildName(context, category) : Padding(
      padding: EdgeInsets.all(10),
      child: Text(category.name, style: Theme.of(context).textTheme.bodyText1, softWrap: false, overflow: TextOverflow.fade,)
    ));
  }
}