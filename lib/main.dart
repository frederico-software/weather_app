import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/login_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 52, 164, 229)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather App :: Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty.";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty.";
    }
    if (value.length < 4 || value.length > 12) {
      return "Password must be between 4 and 12 characters.";
    }
    return null;
  }

  void _doLogin() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    }
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (LoginService.doLogin(username, password)) {
      _usernameController.clear();
      _passwordController.clear();
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Username and password are correct. Redirecting...")));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const WeatherPage(),
      ));
    } else {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong username or password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Weather App",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Please enter your username and password to log in:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _usernameController,
                            validator: _usernameValidator,
                            decoration:
                                const InputDecoration(hintText: "Username"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: _passwordValidator,
                            decoration:
                                const InputDecoration(hintText: "Password"),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FilledButton(
                            onPressed: _doLogin,
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Tooltip(
                  message:
                      "Created by Frederico Wagner Carneiro Rodrigues de Jesus",
                  child: Text(
                    "About this App",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
