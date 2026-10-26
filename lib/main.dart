
import 'package:flutter/material.dart';

void main() {
  runApp(const PracticeApp());
}

class PracticeApp extends StatelessWidget {
  const PracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),
      home: const PracticePage(),
    );
  }
}

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _simulateError = false;
  String? _tip;
  String? _error;

  // Local mock service
  Future<String> _getMockTip() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_simulateError) {
      throw Exception('Mock service unavailable');
    }

    return 'Use a strong password with letters, numbers, and symbols.';
  }

  // Load a practice tip
  Future<void> _loadTip() async {
    setState(() {
      _isLoading = true;
      _tip = null;
      _error = null;
    });

    try {
      final result = await _getMockTip()
          .timeout(const Duration(seconds: 10));

      if (!mounted) return;

      setState(() {
        _tip = result.length > 240
            ? result.substring(0, 240)
            : result;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Could not load the tip. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Your Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Check Form
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Demo form passed validation!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Check Form'),
              ),

              const Divider(height: 48),

              // Mock Tip Section
              const Text(
                'Practice Tip Service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Local mock response. No live AI is used.',
              ),
              const SizedBox(height: 12),

              SwitchListTile(
                title: const Text('Simulate service error'),
                value: _simulateError,
                onChanged: _isLoading
                    ? null
                    : (value) {
                        setState(() {
                          _simulateError = value;
                        });
                      },
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _isLoading ? null : _loadTip,
                child: const Text('Get Practice Tip'),
              ),

              const SizedBox(height: 16),

              // Loading
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              // Success
              if (_tip != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Mock signup advice: $_tip'),
                  ),
                ),

              // Error and Retry
              if (_error != null) ...[
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _loadTip,
                  child: const Text('Retry'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
