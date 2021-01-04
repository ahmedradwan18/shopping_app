import 'package:flutter/material.dart';

class myPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  myPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return myPopupMenuItemState();
  }
}

class myPopupMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, myPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
