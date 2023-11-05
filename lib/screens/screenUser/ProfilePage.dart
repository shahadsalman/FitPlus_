import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(
      r'^05\d{8}$',
    );
    return regex.hasMatch(phoneNumber);
  }

  bool isValidNationalID(String id) {
    final RegExp regex = RegExp(
      r'^[0-9]{10}$',
    );
    return regex.hasMatch(id);
  }

  bool isValidAge(String age) {
    final RegExp regex = RegExp(r'^\d{1,2}$');
    return regex.hasMatch(age);
  }

  bool _isEditing = false;
  bool _isLoading = false;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();
    final userData = userDoc.data() as Map<String, dynamic>;
    fNameController.text = userData['FName'];
    lNameController.text = userData['LName'];
    emailController.text = userData['email'];
    phoneNumberController.text = userData['phone'];
    nationalIDController.text = userData['id'];
    birthDateController.text = userData['age'];
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedEmail = emailController.text;

      // Check if the edited email matches an existing email in the database
      bool emailExists = false;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: updatedEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (final doc in snapshot.docs) {
          if (doc.id != _user.uid) {
            // Matching email found, but not for the current user
            emailExists = true;
            break;
          }
        }
      }

      if (emailExists) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Email Already Exists'),
              content: Text(
                  'This email is already in use. Please use a different email.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // No existing email found for another user, proceed with the update
        final updatedData = {
          'FName': fNameController.text,
          'LName': lNameController.text,
          'email': updatedEmail,
          'phone': phoneNumberController.text,
          'id': nationalIDController.text,
          'age': birthDateController.text,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .update(updatedData);

        setState(() {
          _isEditing = false;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 199, 226),
        elevation: 20,
        centerTitle: true,
        title: const Text('Profile'),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _updateUserProfile,
            ),
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fNameController,
                        enabled: _isEditing,
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: lNameController,
                        enabled: _isEditing,
                        decoration: InputDecoration(labelText: 'Last Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          controller: emailController,
                          enabled: _isEditing,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!isValidEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }),
                      TextFormField(
                        controller: phoneNumberController,
                        enabled: _isEditing,
                        decoration: InputDecoration(labelText: 'Phone number'),
                        keyboardType: TextInputType
                            .number, // Ensure a numeric keyboard initially
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!isValidPhoneNumber(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nationalIDController,
                        enabled: _isEditing,
                        decoration: InputDecoration(labelText: 'National ID'),
                        keyboardType: TextInputType
                            .number, // Ensure a numeric keyboard initially
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                          LengthLimitingTextInputFormatter(
                              10), // Set a limit of 10 characters
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your National ID number';
                          } else if (!isValidNationalID(value)) {
                            return 'The National ID number must have 10 digits';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: birthDateController,
                        enabled: _isEditing,
                        decoration: InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType
                            .number, // Ensure a numeric keyboard initially
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          } else if (!isValidAge(value)) {
                            return 'Please enter a valid age';
                          } else if (int.parse(value) < 15) {
                            return 'Your age must be 15 or above';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

void main() => runApp(MaterialApp(home: ProfilePage()));
