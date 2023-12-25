import 'package:flutter/material.dart';

class vehicledetails extends StatefulWidget {
  const vehicledetails({super.key});

  @override
  State<vehicledetails> createState() => _vehicleDetailsState();
}

class _vehicleDetailsState extends State<vehicledetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: ElevatedButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleFormScreen()),
        ); },
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal),foregroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
          child: const Text("Add Vehicle"),


        ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text:"Bike",icon: Icon(Icons.directions_bike_rounded,color: Colors.black,)),
              Tab(text:"Car",icon: Icon(Icons.car_crash_outlined,color: Colors.black,)),
            ],
            labelColor: Colors.white,labelStyle: TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.grey,unselectedLabelStyle: TextStyle(fontSize: 15),
            indicatorSize: TabBarIndicatorSize.tab,indicatorWeight: 3,indicatorColor:Colors.greenAccent,
          ),
          title: const Text('Vehicle Details'),titleTextStyle: const TextStyle(color: Colors.greenAccent,fontSize: 25),
          backgroundColor: Colors.teal,centerTitle: true,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(child: DynamicCardList(vehicleTypegiven: "Bike",)
            ),


            SingleChildScrollView(child: DynamicCardList(vehicleTypegiven: "Car",)
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicCardList extends StatefulWidget {
  final String vehicleTypegiven;

  DynamicCardList({super.key, required this.vehicleTypegiven});

  @override
  _DynamicCardListState createState() => _DynamicCardListState();
}

class _DynamicCardListState extends State<DynamicCardList> {
  static List<Vehicle> vehicles = [
    Vehicle(vehicleNo: 'MP08MZ1956', brandName: 'Honda', vehicleType: 'Bike', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'UP93KP9387', brandName: 'Hyundai', vehicleType: 'Car', fuelType: 'Diesel'),
    Vehicle(vehicleNo: 'HR34FR2346', brandName: 'Ferrari', vehicleType: 'Car', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'HR26EV0001', brandName: 'Toyota', vehicleType: 'Car', fuelType: 'Diesel'),
    Vehicle(vehicleNo: 'MP12MZ1345', brandName: 'Kawasaki', vehicleType: 'Bike', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'KL23MZ9479', brandName: 'Royal Enfield', vehicleType: 'Bike', fuelType: 'Diesel'),
    Vehicle(vehicleNo: 'MH67KP1001', brandName: 'Morris Garrage', vehicleType: 'Car', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'JK91HI8005', brandName: 'Suzuki', vehicleType: 'Car', fuelType: 'Diesel'),
    Vehicle(vehicleNo: 'BH12TR1345', brandName: 'Jawa', vehicleType: 'Bike', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'JH12MZ3344', brandName: 'Hero', vehicleType: 'Bike', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'PB12MZ1345', brandName: 'Yamaha', vehicleType: 'Bike', fuelType: 'Petrol'),
    Vehicle(vehicleNo: 'JK23H1111', brandName: 'Tata', vehicleType: 'Car', fuelType: 'Diesel'),
  ];

  @override
  Widget build(BuildContext context) {
    List<Vehicle> filteredVehicles =
    vehicles.where((vehicle) => vehicle.vehicleType == widget.vehicleTypegiven).toList();

    return Column(
      children: filteredVehicles.map((vehicle) =>
          buildDynamicCard(vehicle.vehicleNo, vehicle.brandName, vehicle.vehicleType, vehicle.fuelType)).toList(),
    );
  }

  Widget buildDynamicCard(String vehicleNo, String brandName, String vehicleType, String fuelType) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(vehicleNo, style: const TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(brandName),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(vehicleType),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(fuelType),
            ),
            TextButton(
              onPressed: () {
                // Call the delete function here
                deleteVehicle(vehicleNo);
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
  void addVehicle(Vehicle v){
    vehicles.add(v);
  }
  void deleteVehicle(String vehicleNo) {
    setState(() {
      vehicles.removeWhere((vehicle) => vehicle.vehicleNo == vehicleNo);
    });
  }
}

class VehicleFormScreen extends StatefulWidget {
  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> brands = ['Honda', 'Hyundai', 'Ferrari', 'Toyota', 'Kawasaki', 'Royal Enfield', 'Morris Garrage', 'Suzuki', 'Jawa', 'Hero', 'Yamaha', 'Tata',];
  List<String> vehicleTypes = ["Bike","Car"];
  List<String> fuelTypes = ["Petrol", "Diesel", "Electric"];

  String _vehicleNo = "";
  String _brandName = "Honda";
  String _vehicleType = "Bike";
  String _fuelType = "Petrol";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Form'),titleTextStyle: const TextStyle(color: Colors.greenAccent,fontSize: 25),
        backgroundColor: Colors.teal,centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Vehicle No.'),
                  validator: (value) {
                    final RegExp vehicleNoRegex = RegExp(r'^[A-Z][A-Z]\d\d[A-Z]{1,2}\d\d\d\d$');
            
                    if (value == null || value.isEmpty) {
                      return 'Please enter the vehicle number.';
                    } else if (!vehicleNoRegex.hasMatch(value)) {
                      return 'Invalid vehicle number format.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _vehicleNo = value!;
                  },
                ),
                const SizedBox(height: 70),
                const Text("Brand Name",style: TextStyle(fontSize: 20,color: Colors.teal),),
                DropdownButton(
                  dropdownColor: Colors.teal,
                  value: _brandName.isNotEmpty ? _brandName : null,
                  icon: const Icon(Icons.keyboard_arrow_down),
            

                  items: brands.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      _brandName = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 70),
                const Text("Vehicle Type",style: TextStyle(fontSize: 20,color: Colors.teal),),
                DropdownButton(
                  dropdownColor: Colors.teal,
                  value: _vehicleType.isNotEmpty ? _vehicleType : null,
                  icon: const Icon(Icons.keyboard_arrow_down),
            
                  // Array list of items
                  items: vehicleTypes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _vehicleType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 70),
                const Text("Fuel Type",style: TextStyle(fontSize: 20,color: Colors.teal),),
                DropdownButton(
                  dropdownColor: Colors.teal,
                  value: _fuelType.isNotEmpty ? _fuelType : null,
                  icon: const Icon(Icons.keyboard_arrow_down),
            
                  // Array list of items
                  items: fuelTypes.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      _fuelType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
            
                      Vehicle newVehicle = Vehicle(
                        vehicleNo: _vehicleNo,
                        brandName: _brandName,
                        vehicleType: _vehicleType,
                        fuelType: _fuelType,
                      );
                      _DynamicCardListState.vehicles.add(newVehicle);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Vehicle {
  final String vehicleNo;
  final String brandName;
  final String vehicleType;
  final String fuelType;

  Vehicle({
    required this.vehicleNo,
    required this.brandName,
    required this.vehicleType,
    required this.fuelType,
  });
}

