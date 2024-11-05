
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomContainer extends StatefulWidget {
  const CustomContainer({
    super.key,
    required this.textFieldLabel,
    required this.containerWidth,
    this.containerHeight = 50.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.margin = const EdgeInsets.all(10),
    this.borderColor = Colors.grey,
  });

  final String textFieldLabel;
  final double containerWidth;
  final double containerHeight;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color borderColor;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  final TextEditingController _controller = TextEditingController();
  String? text;


  Future<void> saveInput() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mossad',text!);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ النص بنجاح!')),
    );
  }
  
    Future<String> _loadSavedInput() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedInput = prefs.getString('mossad');
    if (savedInput != null) {
      _controller.text = savedInput;
      return _controller.text;
    }
    return 'default value';
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.borderColor),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.textFieldLabel,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onSubmitted: (value) async {
          text=value;
          await saveInput();
          String showtext=await _loadSavedInput();

          log(showtext);

        },
      ),
    );
  }
}