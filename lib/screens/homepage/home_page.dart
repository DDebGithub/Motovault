import 'package:flutter/material.dart';
import 'package:motovault/screens/add_vehicle_screen.dart';

import '../../db/db_helper.dart';
import '../../models/vehicle.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void addVehicleToDb(Map<String, dynamic> vehicleData) async {
    await DBHelper.insertVehicle(vehicleData);
  }
  void _onItemTapped(int index) {
    if (index == 2) {
      // Handle "+" button tap

    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildQuickTile(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: theme.primaryColor, size: 28),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(
      BuildContext context,
      String name,
      String status,
      String lastService,
      String odo,
      int serviceDueInDays,
      String imagePath,
      ) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'online':
        statusColor = Colors.green;
        break;
      case 'offline':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.yellow[700]!;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: statusColor,
                      ),
                      const SizedBox(width: 4),

                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("Last Service: $lastService"),
                  Text("ODO: $odo kms"),
                  Text("Service due in $serviceDueInDays days"),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }  // Homepage // My Vehicles Section

  Widget _buildHomePage() {
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MotoVault',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Access Tiles
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickTile(context, Icons.build, 'Service'),
                  _buildQuickTile(context, Icons.description, 'Documents'),
                  _buildQuickTile(context, Icons.schedule, 'Schedule'),
                  _buildQuickTile(context, Icons.history, 'History'),
                ],
              ),
            ),

            // My Vehicles section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Vehicles',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  /*_buildVehicleCard(context, 'Nexa Baleno', 'Online',
                      'Apr 24, 2024', '24,500', 15, 'assets/images/gear.jpg'),
                  const SizedBox(height: 8),
                  _buildVehicleCard(context, 'Yamaha FZ', 'Offline',
                      'Mar 12, 2024', '12,700', 30, 'assets/images/gear.jpg'),*/
                ],
              ),
            ),

            // Upcoming Reminders Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Reminders',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to full list
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildReminderListCard(
                      Icons.shield, "Insurance", "Baleno", "Due in 5 days"),
                  const SizedBox(height: 12),
                  _buildReminderListCard(
                      Icons.oil_barrel, "Oil Change", "Yamaha FZ", "In 30 days"),
                ],
              ),
            ),
            const SizedBox(height: 80), // To avoid bottom nav overlap
          ],
        ),
      ),
    );
  } // Contains All Home Page Tab Sections

  Widget _buildReminderListCard(
      IconData icon,
      String type,
      String vehicleName,
      String dueInfo,
      ) { // Homepage // Reminders Section
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(vehicleName),
                ],
              ),
            ),
            Text(dueInfo, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return VehiclePage();
      case 3:
        return RemindersScreen();
      case 4:
        return const Center(child: Text('Settings Page'));
      default:
        return _buildHomePage();
    }
  } // Page selector section

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddVehiclePage(onAddVehicle: addVehicleToDb),
            ),
          );// Handle add action (e.g. show dialog to add vehicle or reminder)
        },
        backgroundColor: Colors.deepOrangeAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Vehicles'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Reminders'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  } //Bottom NAV

}


// Vehicles Tab
class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});


  Future<List<Vehicle>> fetchVehiclesFromDB() async {
    final rows = await DBHelper.getVehicles();
    return rows.map((row) => Vehicle.fromMap(row)).toList();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text('My Vehicles'),
              ],
            ),
          ), // My Vehicles Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search vehicles...',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white),
                )
              ],
            ),
          ), // Search Box
          const SizedBox(height: 12),

          /// Fetch & Show Vehicles
          Expanded(
            child: FutureBuilder<List<Vehicle>>(
              future: fetchVehiclesFromDB(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No vehicles found.'));
                }

                final vehicles = snapshot.data!;
                return ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return _buildVehicleCard(vehicles[index], context);
                  },
                );
              },
            )
            ,
          ),
        ],
      ),
    );
  } // Fetch & Show Vehicle Section
  Widget _buildVehicleCard(Vehicle vehicle, BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                vehicle.imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      vehicle.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: _getStatusColor(vehicle.status),
                    ),
                  ],
                ),
                Text('Purchased: ${vehicle.purchaseDate}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 18),
                    const SizedBox(width: 6),
                    Text('Chassis: ${vehicle.chassisNumber}'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.speed, size: 18),
                    const SizedBox(width: 6),
                    Text('${vehicle.odoReading} km'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.build, size: 18),
                    const SizedBox(width: 6),
                    Text('Last: ${vehicle.lastServiceDate}'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 6),
                    Text('Next: ${vehicle.nextServiceDate}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } // Section to Show Vehicle Data

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
        return Colors.green;
      case 'offline':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
// Vehicles Tab

// Reminders Tab

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {

  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Service', 'Document', 'Payment']; // Filter types
  @override
  Widget build(BuildContext context) {
    final filteredReminders = selectedFilter == 'All'
        ? reminders
        : reminders.where((r) => r['type'] == selectedFilter).toList();

    final overdueCount = reminders.where((r) => (r['date'] as DateTime).isBefore(DateTime.now())).length;
    final todayCount = reminders.where((r) {
      final d = r['date'] as DateTime;
      return d.year == DateTime.now().year && d.month == DateTime.now().month && d.day == DateTime.now().day;
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = selectedFilter == filter;
                  return ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedFilter = filter),
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey[300],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Overdue + Today stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Overdue: $overdueCount'),
                Text('Today: $todayCount'),
              ],
            ),
            const SizedBox(height: 16),

            // Reminder Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredReminders.length,
                itemBuilder: (context, index) {
                  final reminder = filteredReminders[index];
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            getIconForType(reminder['type'] as String),
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Middle Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                reminder['type'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(reminder['vehicle'] as String),
                              const SizedBox(height: 4),
                              Text(
                                getDateLabel(reminder['date'] as DateTime),
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),

                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            reminder['image'] as String,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
}// Card Section
  final reminders = [
    {
      'type': 'Service',
      'vehicle': 'Nexa Baleno',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'image': 'assets/images/gear.jpg',
    },
    {
      'type': 'Document',
      'vehicle': 'Yamaha FZ',
      'date': DateTime.now(),
      'image': 'assets/images/gear.jpg',
    },
    {
      'type': 'Payment',
      'vehicle': 'Nexa Baleno',
      'date': DateTime.now().add(const Duration(days: 7)),
      'image': 'assets/images/gear.jpg',
    },
  ]; // To be pulled from DB later
  IconData getIconForType(String type) {
    switch (type) {
      case 'Service':
        return Icons.build;
      case 'Document':
        return Icons.description;
      case 'Payment':
        return Icons.calendar_today;
      default:
        return Icons.notifications;
    }
  } // Icon based on service
  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.isBefore(now)) {
      final overdueDays = now.difference(date).inDays;
      return '$overdueDays days overdue';
    } else {
      return '${date.day}-${date.month}-${date.year}';
    }
  } // Date Logic


}
