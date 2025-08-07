class Vehicle {
  final String imagePath;
  final String name;
  final String status;
  final String purchaseDate;
  final String chassisNumber;
  final int odoReading;
  final String lastServiceDate;
  final String nextServiceDate;
  final String noOfWheels;

  Vehicle({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.purchaseDate,
    required this.chassisNumber,
    required this.odoReading,
    required this.lastServiceDate,
    required this.nextServiceDate,
    required this.noOfWheels,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      imagePath: map['imagePath'] ?? 'assets/images/gear.jpg',
      name: map['name'] ?? '',
      status: map['status'] ?? 'Offline',
      purchaseDate: map['purchaseDate'] ?? '',
      chassisNumber: map['chassisNumber'] ?? '',
      odoReading: int.tryParse(map['odoReading']?.toString() ?? '') ?? 0,
      lastServiceDate: map['lastServiceDate'] ?? '',
      nextServiceDate: map['nextServiceDate'] ?? '',
      noOfWheels: map['noOfWheels'] ?? 'Four',
    );
  } // Vehicle data RETRIEVED from DB

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'status': status,
      'purchaseDate': purchaseDate,
      'chassisNumber': chassisNumber,
      'odoReading': odoReading.toString(),
      'lastServiceDate': lastServiceDate,
      'nextServiceDate': nextServiceDate,
      'noOfWheels': noOfWheels,
    };
  } // Vehicle data MAPPED and passed to DB
}