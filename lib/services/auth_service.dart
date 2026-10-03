import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream para monitorar em tempo real se o usuário está logado
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuário atual
  User? get currentUser => _auth.currentUser;

  // Login com Email e Senha
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Retorna null em caso de sucesso
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Erro ao realizar login.';
    }
  }

  // Cadastro com Email e Senha
  Future<String?> cadastrar({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Retorna null em caso de sucesso
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Erro ao criar conta.';
    }
  }

  // Deslogar
  Future<void> deslogar() async {
    await _auth.signOut();
  }
}