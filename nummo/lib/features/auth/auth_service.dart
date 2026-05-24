import 'dart:async';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'user_model.dart';

class AuthService {
  static const String _boxName = 'users';
  static const String _currentUserKey = 'current_user';
  late Box<User> _box;
  final _uuid = const Uuid();

  final _authController = StreamController<User?>.broadcast();
  Stream<User?> get authStream => _authController.stream;

  Future<void> init() async {
    _box = await Hive.openBox<User>(_boxName);
    final currentUser = _box.get(_currentUserKey);
    _authController.add(currentUser);
  }

  Future<User?> login(String email, String password) async {
    final user = _box.values.cast<User?>().firstWhere(
      (u) => u?.email == email,
      orElse: () => null,
    );
    
    // Verificamos si existe Y si la contraseña coincide
    if (user != null && user.password == password) {
      await _box.put(_currentUserKey, user.copyWith());
      _authController.add(user);
      return user;
    }
    return null; 
  }

  Future<User?> register(String email, String password, String name) async {
    final exists = _box.values.any((u) => u.email == email);
    if (exists) return null;

    final user = User(id: _uuid.v4(), email: email, name: name, password: password);
    
    // Guarda el usuario, pero NO inicia sesión automáticamente
    await _box.put(user.id, user);
    
    return user;
  }

  Future<void> logout() async {
    await _box.delete(_currentUserKey);
    _authController.add(null);
  }

  User? get currentUser => _box.get(_currentUserKey);
  bool get isAuthenticated => currentUser != null;

  Future<void> updateUser(User user) async {
    await _box.put(user.id, user);
    if (currentUser?.id == user.id) {
      await _box.put(_currentUserKey, user.copyWith());
      _authController.add(user);
    }
  }

  Future<void> dispose() async {
    await _authController.close();
  }
}