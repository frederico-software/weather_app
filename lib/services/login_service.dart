class LoginService {
  static const DEFAULT_LOGIN = "Fred";
  static const DEFAULT_PASSWORD = "1234";
  
  static bool doLogin(String username, String password) {
    // Dummy login request
    return (username == DEFAULT_LOGIN && password == DEFAULT_PASSWORD);
  }
}