import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/FlashCardCategory.dart';
import 'Database/SQLiteDBHelper.dart';

class EditCategoryScreen extends StatefulWidget {
  final FlashCardCategory category;

  const EditCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late TextEditingController _titleController;
  final SQLiteDBHelper _dbHelper = SQLiteDBHelper();
  late String _selectedImagePath;

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

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.category.title);
    _selectedImagePath = widget.category.imagePath;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
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
          _selectedImagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Widget _buildPreviewImage() {
    if (_selectedImagePath.startsWith('Assets/')) {
      return Image.asset(
        _selectedImagePath,
        fit: BoxFit.cover,
      );
    } else if (_selectedImagePath != 'avatar' &&
        _selectedImagePath.isNotEmpty &&
        File(_selectedImagePath).existsSync()) {
      return Image.file(
        File(_selectedImagePath),
        fit: BoxFit.cover,
      );
    } else {
      return const Icon(
        Icons.folder_open_rounded,
        size: 36,
        color: Color(0XFF705E46),
      );
    }
  }

  Future<void> _saveCategory() async {
    final updatedTitle = _titleController.text.trim();
    if (updatedTitle.isEmpty) return;

    if (widget.category.id == null) {
      debugPrint("Error: Category ID is null, cannot update category in database.");
      if (mounted) Navigator.pop(context, false);
      return;
    }

    await _dbHelper.updateCategory(
      widget.category.id!,
      updatedTitle,
      _selectedImagePath,
    );

    // Return true to indicate the category was updated
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5EFE5),
      appBar: AppBar(
        backgroundColor: const Color(0XFF422701),
        title: const Text(
          'Edit Category',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0XFFFFFFFF),
            height: 1.8,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  labelText: 'Category Title',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0XFF705E46),
                  ),
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
              const SizedBox(height: 24),
              const Text(
                "Category Image",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF422701),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
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
                        child: _buildPreviewImage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.image_search_rounded,
                        size: 20,
                        color: Color(0XFFFFFFFF),
                      ),
                      label: const Text(
                        "Choose Custom Image",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
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
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Or Select Preset Theme:",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF705E46),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 76,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: presetImages.length,
                  itemBuilder: (context, idx) {
                    final preset = presetImages[idx];
                    final path = preset['path']!;
                    final isSelected = (_selectedImagePath == path);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImagePath = path;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0XFF422701)
                                      : Colors.transparent,
                                  width: isSelected ? 3.0 : 0.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                right: 3,
                                top: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Color(0XFF422701),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 12,
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
              const SizedBox(height: 36),
              ElevatedButton.icon(
                onPressed: _saveCategory,
                icon: const Icon(Icons.save, size: 22, color: Color(0XFFFFFFFF)),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF422701),
                  foregroundColor: const Color(0xFFFFFFFF),
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
