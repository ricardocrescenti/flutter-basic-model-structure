import 'package:flutter/material.dart';
import 'package:basic_structure/basic_structure.dart';

class CategoryList extends StatelessWidget {
  final bool useListView;
  final Axis direction;
  final List<CategoryModelPattern> categories;
  final Widget Function(BuildContext context, CategoryModelPattern category) buildItem;

  CategoryList({
    this.useListView = false,
    this.direction = Axis.vertical,
    @required this.categories,
    @required this.buildItem}) {
      assert(useListView != null);
      assert(direction != null);
      assert(categories != null);
    }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = categories.map<Widget>((category) => _buildItem(context, category)).toList();

    if (useListView) {
      
      return ListView(
        scrollDirection: direction,
        children: items,
      );
    
    } else {

      if (direction == Axis.horizontal) {
        return Row(children: items);
      } else {
        return Column(children: items);
      }

    }
  }

  Widget _buildItem(BuildContext context, CategoryModelPattern category) {
    return buildItem(context, category);
  }
}