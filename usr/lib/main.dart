import 'package:flutter/material.dart';

void main() {
  runApp(const HouseholdServicesApp());
}

class HouseholdServicesApp extends StatelessWidget {
  const HouseholdServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Household Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Household Services'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProviderRegisterScreen()),
                );
              },
              child: const Text('I am a Service Provider'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientSearchScreen()),
                );
              },
              child: const Text('I need a Service'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderRegisterScreen extends StatefulWidget {
  const ProviderRegisterScreen({super.key});

  @override
  _ProviderRegisterScreenState createState() => _ProviderRegisterScreenState();
}

class _ProviderRegisterScreenState extends State<ProviderRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _serviceType = '';
  String _contact = '';
  String _location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Type (e.g., Plumber, Cleaner)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service type';
                  }
                  return null;
                },
                onSaved: (value) => _serviceType = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Information'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact info';
                  }
                  return null;
                },
                onSaved: (value) => _contact = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                onSaved: (value) => _location = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // For now, just show a success message. In a real app, this would save to database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({super.key});

  @override
  _ClientSearchScreenState createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  // Mock data for providers
  final List<Map<String, String>> _providers = [
    {'name': 'John Doe', 'service': 'Plumber', 'contact': 'john@example.com', 'location': 'City A'},
    {'name': 'Jane Smith', 'service': 'Cleaner', 'contact': 'jane@example.com', 'location': 'City B'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Service Provider'),
      ),
      body: ListView.builder(
        itemCount: _providers.length,
        itemBuilder: (context, index) {
          final provider = _providers[index];
          return ListTile(
            title: Text('${provider['name']} - ${provider['service']}'),
            subtitle: Text('Location: ${provider['location']}'),
            trailing: ElevatedButton(
              onPressed: () {
                // In a real app, this would initiate contact (e.g., email, call)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contacting ${provider['name']} at ${provider['contact']}')),
                );
              },
              child: const Text('Contact'),
            ),
          );
        },
      ),
    );
  }
}