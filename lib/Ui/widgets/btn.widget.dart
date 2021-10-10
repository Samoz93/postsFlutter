import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final isDisabled;
  const Btn(
      {Key? key, this.onTap, required this.title, this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color1 = Color(0xff26BE96);
    final color2 = Color(0xff75D6BC);
    final isDisabledStyle = isDisabled || onTap == null;
    return InkWell(
      onTap: isDisabledStyle ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: isDisabledStyle
              ? []
              : [
                  BoxShadow(
                    color: color2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
          gradient: isDisabledStyle
              ? null
              : LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
