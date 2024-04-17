import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';

class MyCheckBox extends StatefulWidget {
  final String text;
  final Function(bool) onPressed;

  const MyCheckBox({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onPressed(_isChecked);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
            _isChecked
                ? Icon(Icons.check, color: Colors.white)
                : Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
