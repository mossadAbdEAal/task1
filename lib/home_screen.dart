import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/custom_container.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.inputKey});

 
  final String inputKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fetchedDataString;
  
  Future<void> _loadSavedInput() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? savedData = sharedPreferences.getString(widget.inputKey);
    setState(() {
      fetchedDataString = savedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF005EAA),
          toolbarHeight: 60,
          title: const Text(
            'Branch / Store / Cashier',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                    icon: const Icon(Icons.save, color: Colors.white),
                    onPressed: () async {
                      await _loadSavedInput();
                    }),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Branch',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.center,
                        child:const  Text(
                          '0',
                          style:  TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Custom No.'),
                      SizedBox(height: 2),
                      CustomContainer(
                        textFieldLabel: '0',
                        containerWidth: 100,
                        containerHeight: 40,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              _buildTextFieldSection('Arabic Name', 'مباني المؤسسة', 370),
              _buildTextFieldSection('Arabic Description', 'W', 370),
              _buildTextFieldSection('English Name', 'Company Branches', 370),
              _buildTextFieldSection('English Description', '', 370),
              _buildTextFieldSection('Note', 'any notes', 370),
              _buildTextFieldSection('Address', 'KSA', 370),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldSection(String label, String hint, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        CustomContainer(
          textFieldLabel: hint,
          containerWidth: width,
        ),
      ],
    );
  }
}
