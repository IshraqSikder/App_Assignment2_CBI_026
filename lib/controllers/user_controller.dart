import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  late Database _database;
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      // Debugging path output
      _database = await openDatabase(
        join(dbPath, 'user.db'),
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
          );
        },
        version: 1,
      );
      await _fetchUsers();
    } catch (e) {}
  }

  Future<void> _fetchUsers() async {
    try {
      final List<Map<String, dynamic>> userMaps =
          await _database.query('users');
      users.value = userMaps.map((map) => User.fromMap(map)).toList();
    } catch (e) {}
  }

  Future<void> insertUser(String name, int age) async {
    try {
      final user = User(name: name, age: age);
      await _database.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await _fetchUsers(); // Refresh users after insert
    } catch (e) {}
  }
}
