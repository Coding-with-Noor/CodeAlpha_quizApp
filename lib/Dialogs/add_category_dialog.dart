import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/FlashCardCategory.dart';

void showAddCategoryDialog({
  required BuildContext context,
  required Function(FlashCardCategory newCategory) onCategoryAdded,
}) {
  final titleController = TextEditingController();
  String selectedImagePath = 'avatar'; // Default fallback value

  final List<Map<String, String>> presetImages = [
    {'name': 'Islamic', 'path': 'Assets/Images/islamic knowledge.jpg'},
    {'name': 'Geography', 'path': 'Assets/Images/world geography.jpg'},
    {'name': 'Science', 'path': 'Assets/Images/Science.jpg'},
    {'name': 'IT/Tech', 'path': 'Assets/Images/IT.jpg'},
    {'name': 'History', 'path': 'Assets/Images/History.jpg'},
    {'name': 'GK', 'path': 'Assets/Images/GK.jpg'},
    {'name': 'Space', 'path': 'Assets/Images/space.jpg'},
    {'name': 'Animals', 'path': 'Assets/Images/Animals.jpg'},
    {'name': 'English', 'path': 'Assets/Images/English.jpg'},
    {'name': 'Sports', 'path': 'Assets/Images/Sports.jpg'},
  ];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickImage() async {
            try {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
                maxWidth: 800,
                maxHeight: 800,
                imageQuality: 85,
              );
              if (image != null) {
                setState(() {
                  selectedImagePath = image.path;
                });
              }
            } catch (e) {
              debugPrint("Error picking image: $e");
            }
          }

          Widget buildPreviewImage() {
            if (selectedImagePath.startsWith('Assets/')) {
              return Image.asset(
                selectedImagePath,
                fit: BoxFit.cover,
              );
            } else if (selectedImagePath != 'avatar' &&
                selectedImagePath.isNotEmpty &&
                File(selectedImagePath).existsSync()) {
              return Image.file(
                File(selectedImagePath),
                fit: BoxFit.cover,
              );
            } else {
              return const Icon(
                Icons.folder_open_rounded,
                size: 32,
                color: Color(0XFF705E46),
              );
            }
          }

          return AlertDialog(
            backgroundColor: const Color(0XFFFDFBF7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              "Add Category",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xFF422701),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      labelText: "Category Title",
                      labelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0XFF705E46),
                      ),
                      hintText: "e.g. Computer Science",
                      hintStyle: const TextStyle(fontFamily: 'Poppins'),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0XFF422701),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0XFF705E46),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Category Image",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF422701),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE6D8),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0XFF705E46),
                            width: 1.2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Center(
                            child: buildPreviewImage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: pickImage,
                          icon: const Icon(
                            Icons.image_search_rounded,
                            size: 18,
                            color: Color(0XFFFFFFFF),
                          ),
                          label: const Text(
                            "Choose Custom",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFFFFFF),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF422701),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Or Choose Preset Theme:",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      color: Color(0XFF705E46),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: presetImages.length,
                      itemBuilder: (context, idx) {
                        final preset = presetImages[idx];
                        final path = preset['path']!;
                        final isSelected = (selectedImagePath == path);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImagePath = path;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0XFF422701)
                                          : Colors.transparent,
                                      width: isSelected ? 3.0 : 0.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Image.asset(
                                      path,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    right: 2,
                                    top: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Color(0XFF422701),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0XFF422701),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF422701),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final titleText = titleController.text.trim();
                  if (titleText.isNotEmpty) {
                    final newCategory = FlashCardCategory(
                      title: titleText,
                      imagePath: selectedImagePath,
                      cards: [],
                    );
                    onCategoryAdded(newCategory);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0XFFFFFFFF),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
