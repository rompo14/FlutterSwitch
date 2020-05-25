library flutter_switch;

import 'package:flutter/material.dart';

class FlutterSwitch extends StatefulWidget {
  final bool value, showOnOff;
  final ValueChanged<bool> onToggle;
  final Color activeColor,
      inactiveColor,
      activeTextColor,
      inactiveTextColor,
      disabledColor,
      toggleColor;
  final double width, height, toggleSize, valueFontSize, borderRadius, padding;
  final List<BoxShadow> boxShadow;
  final Color borderColor;
  final bool disabled;

  const FlutterSwitch({
    Key key,
    this.value,
    this.onToggle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.toggleColor = Colors.white,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleSize = 25.0,
    this.valueFontSize = 16.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.boxShadow,
    this.borderColor = const Color(0xFFF4F4F4),
    this.disabledColor = const Color(0xFFEBF3FE),
    this.disabled = false
  }) : super(key: key);

  @override
  _FlutterSwitchState createState() => _FlutterSwitchState();
}

class _FlutterSwitchState extends State<FlutterSwitch>
    with SingleTickerProviderStateMixin {
  Animation _toggleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    );
    _toggleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: !widget.disabled ? () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onToggle(true)
                : widget.onToggle(false);
          } : null,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(widget.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: !widget.disabled 
              ? _toggleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
              : widget.disabledColor
              border: Border.all(width: 1, color: !widget.disabled ? widget.borderColor ? widget.disabledColor)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _toggleAnimation.value == Alignment.centerRight
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            widget.showOnOff ? "On" : "",
                            style: TextStyle(
                              color: widget.activeTextColor,
                              fontWeight: FontWeight.w900,
                              fontSize: widget.valueFontSize,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Align(
                  alignment: _toggleAnimation.value,
                  child: Container(
                    width: widget.toggleSize,
                    height: widget.toggleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.toggleColor,
                      boxShadow: widget?.boxShadow ?? [
                        BoxShadow(color: Colors.black.withOpacity(.06), offset: Offset(0, 3), blurRadius: 1),
                        BoxShadow(color: Colors.black.withOpacity(.15), offset: Offset(0, 3), blurRadius: 8),
                      ]
                    ),
                  ),
                ),
                _toggleAnimation.value == Alignment.centerLeft
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.showOnOff ? "Off" : "",
                            style: TextStyle(
                              color: widget.inactiveTextColor,
                              fontWeight: FontWeight.w900,
                              fontSize: widget.valueFontSize,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
