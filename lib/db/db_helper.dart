import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:motovault/models/vehicle.dart';

class DBHelper {
  static Future<void> insertVehicle(Map<String, dynamic> vehicle) async {
    final db = await getDatabaseInstance(); // Replace with your actual method to get the DB
    await db.insert('vehicles', vehicle, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Database> getDatabaseInstance() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'garage.db'),
      onCreate: (db, version) {
        return db.execute(
            '''
              CREATE TABLE vehicles (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                status TEXT CHECK(status IN ('Online', 'Offline')),
                purchaseDate TEXT,
                chassisNumber TEXT,
                odoReading INTEGER,
                lastServiceDate TEXT,
                imagePath TEXT
              );
            '''
        );
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getVehicles() async {
    final db = await getDatabaseInstance();
    return await db.query('vehicles');
  }

}