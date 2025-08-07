import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';
import '../models/vehicle.dart';

// Controllers used for controlling Input Fields
final TextEditingController _brandController = TextEditingController();
final TextEditingController _modelController = TextEditingController();
final TextEditingController nameController = TextEditingController();

Future<List<String>> fetchBrands(String query) async {
  // Ideally fetch from an API or local list
  final brands = ['Maruti', 'Hyundai', 'Tata', 'Toyota', 'Honda', 'Kia', 'Mahindra'];
  return brands.where((b) => b.toLowerCase().contains(query.toLowerCase())).toList();
}

Future<List<String>> fetchModels(String brand) async {
  // Dummy brand-to-model mapping
  final Map<String, List<String>> brandModels = {
    'Maruti': ['Baleno', 'Swift', 'WagonR'],
    'Hyundai': ['i20', 'Verna', 'Creta'],
    'Tata': ['Nexon', 'Altroz', 'Harrier'],
    'Toyota': ['Innova', 'Fortuner', 'Glanza'],
    'Honda': ['City', 'Amaze'],
    'Kia': ['Seltos', 'Sonet'],
    'Mahindra': ['XUV300', 'XUV700', 'Thar'],
  };

  return brandModels[brand]?.toList() ?? [];
}

class AddVehiclePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddVehicle;
  AddVehiclePage({super.key, required this.onAddVehicle});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();

  // Vehicle Addition  fields
  String? selectedBrand;
  String? selectedModel;
  String status = 'Online';
  String noOfWheels = 'Two';
  DateTime? purchaseYear;
  final TextEditingController chassisController = TextEditingController();
  final TextEditingController odoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  DateTime? lastService;
  DateTime? nextService;
  File? vehicleImage;

  final ImagePicker _picker = ImagePicker();

  // Helper pickers

  Future<void> _pickDate(BuildContext context, Function(DateTime) onDatePicked,
      {DateTime? initialDate}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null) onDatePicked(picked);
  }

   Future<void> _pickImage() async {
    final XFile? pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop(await _picker.pickImage(source: ImageSource.gallery));
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.of(ctx).pop(await _picker.pickImage(source: ImageSource.camera));
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(ctx).pop(null),
              )
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        vehicleImage = File(pickedFile.path);
      });
    }
  } // Image picker

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (purchaseYear == null || lastService == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select all dates')),
        );
        return;
      }

      final newVehicle = Vehicle(
        name: nameController.text.trim(),
        status: status,
        purchaseDate: purchaseYear!.toIso8601String(),
        chassisNumber: chassisController.text.trim(),
        odoReading: int.parse(odoController.text.trim()),
        lastServiceDate: lastService!.toIso8601String(),
        nextServiceDate: nextService!.toIso8601String() ?? '',
        //imagePath: 'motovault/assets/images/gear.jpg',
        imagePath: vehicleImage?.path ?? '',
        noOfWheels: noOfWheels,
      ); //This section sends data to the Vehicle.dart file


      await DBHelper.insertVehicle(newVehicle.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vehicle added successfully!')),
      );

      Navigator.pop(context); // Close the form screen
    }
  }// Data Validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a Vehicle')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name TextField
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Name',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Status Picker
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'Online', child: Text('Online')),
                  DropdownMenuItem(value: 'Offline', child: Text('Offline')),
                ],
                value: status,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      status = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // No of Wheels
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'No. Of Wheels'),
                items: const [
                  DropdownMenuItem(value: 'Two', child: Text('Two')),
                  DropdownMenuItem(value: 'Four', child: Text('Four')),
                ],
                value: noOfWheels,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      noOfWheels = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Purchase Year Date Picker
              InkWell(
                onTap: () => _pickDate(context, (date) {
                  setState(() {
                    purchaseYear = date;
                  });
                }),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Purchase Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    purchaseYear == null
                        ? 'Select Date'
                        : '${purchaseYear!.year}-${purchaseYear!.month.toString().padLeft(2, '0')}-${purchaseYear!.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Chassis Number TextField
              TextFormField(
                controller: chassisController,
                maxLength: 17,
                decoration: const InputDecoration(
                  labelText: 'Chassis Number',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().length != 17) {
                    return 'Chassis number must be exactly 17 characters';
                  }
                  if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(val.trim())) {
                    return 'Invalid chassis number format';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 16),

              // ODO Reading TextField styled with monospace
              TextFormField(
                controller: odoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ODO Reading (km)',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'RobotoMono', fontSize: 20),
                validator: (val) {
                  final numVal = int.tryParse(val ?? '');
                  if (numVal == null || numVal < 0) {
                    return 'Please enter a valid non-negative number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last Service Date Picker
              InkWell(
                onTap: () => _pickDate(context, (date) {
                  setState(() {
                    lastService = date;
                  });
                }),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Service Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    lastService == null
                        ? 'Select Date'
                        : '${lastService!.year}-${lastService!.month.toString().padLeft(2, '0')}-${lastService!.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Next Service Date Picker
              InkWell(
                onTap: () => _pickDate(context, (date) {
                  setState(() {
                    nextService = date;
                  });
                }),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Next Service Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    nextService == null
                        ? 'Select Date'
                        : '${nextService!.year}-${nextService!.month.toString().padLeft(2, '0')}-${nextService!.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Image picker button + preview
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Pick Vehicle Image'),
                onPressed: _pickImage,
              ),
              if (vehicleImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(vehicleImage!, height: 150),
                ),
              const SizedBox(height: 32),

              // Full-width Add button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Vehicle',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // Submit Form
}