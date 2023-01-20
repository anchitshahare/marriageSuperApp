import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marriage_super_app/Expense_Tracker/screens/expense_tracker_screen.dart';

class HomepageScreen extends StatefulWidget {
  static const routeName = '/homepage';

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool _isVisible = true;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  void _getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: imageFile == null
                  ? Container(
                      height: height / 3,
                      width: double.infinity,
                      color: Colors.grey,
                    )
                  : SizedBox(
                      height: height / 3,
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.file(
                          imageFile!,
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                width: width / 2,
                height: height / 6,
                alignment: Alignment.center,
                color: Colors.grey.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.photo_camera_outlined),
                  iconSize: 100,
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                      _getImage();
                    });
                  },
                ),
              ),
            ),
          ]),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, ExpenseTrackerScreen.routeName),
                  child: SubAppCard(
                    icon: Icons.wallet,
                    text: 'Expense Tracker',
                  ),
                ),
                SubAppCard(
                  icon: Icons.checklist,
                  text: 'Checklist',
                ),
                SubAppCard(
                  icon: Icons.people,
                  text: 'Guest List',
                ),
                SubAppCard(
                  icon: Icons.restaurant,
                  text: 'Food Menu',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubAppCard extends StatelessWidget {
  const SubAppCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Text(
            text,
            textScaleFactor: 1.1,
          ),
        ],
      ),
    );
  }
}
