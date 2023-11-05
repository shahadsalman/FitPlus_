import 'package:fitplus/firebase/fb_auth_controller.dart';
import 'package:fitplus/firebase/fb_notifications.dart';
import 'package:fitplus/screens/login&register/login.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class User_Signup extends StatefulWidget {
  const User_Signup({super.key});

  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<User_Signup> {
  bool isLoading = false;
  TextEditingController FNameController = TextEditingController();
  TextEditingController LNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController NationalIDController = TextEditingController();
  TextEditingController BirthDateController = TextEditingController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp Regex = RegExp(
      r'^((?:[0]+)(?:[5]+)(?:\s?\d{8}))$',
    );
    return Regex.hasMatch(phoneNumber);
  }

  bool isValidNationalID(String ID) {
    final RegExp Regex = RegExp(
      r'[0-9]{10}',
    );
    return Regex.hasMatch(ID);
  }

  bool isValidAge(String Age) {
    final RegExp Regex = RegExp(r'^[0-9]{1,2}$');
    return Regex.hasMatch(Age);
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });

    // Your sign-up logic here

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 210, 199, 226),title: const Text('Create Account'),centerTitle: true,titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20)
        ),
        backgroundColor: const Color.fromARGB(255, 255, 251, 251),
        body: SingleChildScrollView(
          child: Column(
            children: [
             Container(
              width: 250,
              margin: const EdgeInsets.fromLTRB(80, 30, 85, 0),
              child: Image.asset('assets/logo.png'),
            ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')), ],
                            style: const TextStyle(
                                 color: Colors.black, fontSize: 25),
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                               
                              ),
                              hintText: "First Name",
                              
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: FNameController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')), ],
                            style: const TextStyle(
                              
                               color: Colors.black, fontSize: 25),
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                               
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              hintText: "Last Name",
                              
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: LNameController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                            //obscureText: true,
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              
                              ),
                              hintText: "Email",
                             
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(
                               color: Colors.black, fontSize: 25),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                               
                              ),
                              hintText: "Password",
                              
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                               
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              hintText: "Phone number",
                           
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: phonenumberController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            maxLength: 10,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                                  inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), ],
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              hintText: "National ID",
                             
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: NationalIDController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), ],
    keyboardType: TextInputType.number,
                            style: const TextStyle(
                               color: Colors.black, fontSize: 25),
                            decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 210, 202, 221),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                             
                              ),
                              hintText: "Age",
                          
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: BirthDateController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color.fromARGB(255, 179, 178, 178),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (FNameController.text.trim().isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a First Name"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (LNameController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a Last Name"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (emailController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Please enter an Email"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (!isValidEmail(
                                        emailController.text.toString())) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a valid email"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (passwordController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a Password"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (passwordController.text
                                            .trim()
                                            .length <
                                        6) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Password length is short (minimum: 6)"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (phonenumberController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a Phone Number"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if(phonenumberController.text.toString()[0] != '0'){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "The phone number must start with 05"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if(phonenumberController.text.toString()[1] != '5'){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "The phone number must start with 05"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    }else if (!isValidPhoneNumber(
                                        phonenumberController.text
                                            .toString())) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "The Phone Number entered is incorrect"),
                                        backgroundColor: Colors.redAccent,
                                      ));

                                    } else if (NationalIDController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Please enter a National ID "),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (!isValidNationalID(
                                        NationalIDController.text.toString())) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "The National ID number must have 10 digits "),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (BirthDateController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Please enter your Age"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (!isValidAge(
                                        BirthDateController.text.toString())) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "The Age entered is incorrect"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    } else if (int.parse(BirthDateController.text)<15) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "your age must be 15 or above"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    }
                                    else {
                                    String fcm = await FbNotifications.getFcm();
                                      bool state = await FbAuthController()
                                          .createAccount(context,
                                              user: {
                                                'fcm':fcm,
                                                'FName': FNameController.text,
                                                'LName': LNameController.text,
                                                'email': emailController.text,
                                                'password':
                                                    await AppController
                                                        .to
                                                        .encryptData(
                                                            plainText:
                                                                passwordController
                                                                    .text,
                                                            encryptData: true),
                                                'phone':
                                                    phonenumberController.text,
                                                'id': NationalIDController.text,
                                                'age': BirthDateController.text,
                                                'typeAccount': 1,
                                                'listSubscribe': [],

                                              },
                                              password:
                                                  passwordController.text);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'If already have an account ',
                                style: TextStyle(fontSize: 17),
                              ),
                              TextButton(
                                onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPick()));
                                  Get.offAll(() => const MyLogin());
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Log in',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                            const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
