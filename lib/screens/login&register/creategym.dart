import 'dart:io';

import 'package:fitplus/firebase/fb_auth_controller.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/screens/map_picker/map_picker_screen.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:fitplus/value/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../firebase/fb_notifications.dart';
import '../map_picker/models/place_info.dart';
import 'login.dart';

class CreateAccountManagerGym extends StatefulWidget {
  CreateAccountManagerGym({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController commercial = TextEditingController();
  TextEditingController nameGym = TextEditingController();
  TextEditingController locationGym = TextEditingController();
  TextEditingController descriptionGym = TextEditingController();
  TextEditingController priceOneMonth = TextEditingController();
  TextEditingController priceThreeMonth = TextEditingController();
  TextEditingController priceSixMonth = TextEditingController();
  TextEditingController price12Month = TextEditingController();
  bool selectNewImage = false;
  bool availableWifi = false;
  bool availableBarking = false;
  String sundayFrom = 'From';
  String sundayTo = 'To';
  String mondayFrom = 'From';
  String mondayTo = 'To';
  String tuesdayFrom = 'From';
  String tuesdayTo = 'To';
  String wednesdayFrom = 'From';
  String wednesdayTo = 'To';
  String thursdayFrom = 'From';
  String thursdayTo = 'To';
  String fridayFrom = 'From';
  String fridayTo = 'To';
  String saturdayFrom = 'From';
  String saturdayTo = 'To';
  late XFile? _pickedFile;
  String urlImage = '';

  @override
  State<CreateAccountManagerGym> createState() => _CreateAccountManagerGymState();
}

class _CreateAccountManagerGymState extends State<CreateAccountManagerGym> {
  PlaceInfo? gymLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 20, backgroundColor: const Color.fromARGB(255, 210, 199, 226), title: const Text('Create Gym'), centerTitle: true, titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20)),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  /// change image logo
                  pickImageAfterSelect(context: context);
                },
                child: Container(
                  height: 150,
                  width: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: Colors.black)),
                  child: Center(
                    child: widget.selectNewImage
                        ? Image.file(
                            File(widget._pickedFile!.path),
                            fit: BoxFit.fill,
                            height: 150,
                          )
                        : const Icon(Icons.camera_alt, size: 50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: TextField(
                controller: widget.email,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: TextField(
                controller: widget.password,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: TextField(
                controller: widget.phone,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Phone Number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 80,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: TextField(
                maxLength: 14,
                controller: widget.commercial,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Commercial Record ',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
                controller: widget.nameGym,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Name Gym',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextField(
                maxLength: 2000,
                maxLines: 3,
                controller: widget.descriptionGym,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 210, 202, 221),
                  filled: true,
                  hintText: 'Description Of Gym',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Available Wifi In GYM ?', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                Switch(
                  value: widget.availableWifi,
                  onChanged: (value) {
                    setState(() {
                      widget.availableWifi = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Available Barking In GYM ?', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                Switch(
                  value: widget.availableBarking,
                  onChanged: (value) {
                    setState(() {
                      widget.availableBarking = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text('Working Hours', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Sunday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.sundayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.sundayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.sundayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.sundayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Monday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.mondayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.mondayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.mondayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.mondayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('tuesday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.tuesdayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.tuesdayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.tuesdayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.tuesdayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('wednesday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.wednesdayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.wednesdayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.wednesdayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.wednesdayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('thursday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.thursdayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.thursdayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.thursdayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.thursdayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('friday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.fridayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.fridayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.fridayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.fridayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text('saturday', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () async {
                    widget.saturdayFrom = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.saturdayFrom),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    widget.saturdayTo = await selectTime(context: context);
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.saturdayTo),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Subscription Price',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                        controller: widget.priceOneMonth,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: '1 month',
                          hintStyle: const TextStyle(fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                        controller: widget.priceThreeMonth,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: '3 month',
                          hintStyle: const TextStyle(fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                        controller: widget.priceSixMonth,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: '6 month',
                          hintStyle: const TextStyle(fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                        controller: widget.price12Month,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: '12 month',
                          hintStyle: const TextStyle(fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  gymLocation?.address ?? "Select gym location here",
                  maxLines: 2,
                  style: const TextStyle(fontSize: 16),
                )),
                const SizedBox(width: 10),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final PlaceInfo? result = await Get.to(
                      () => MapPickerScreen(
                        lat: gymLocation?.latLng.latitude,
                        lng: gymLocation?.latLng.longitude,
                        countries: const ["SA"],
                      ),
                    );
                    if (result != null && result.address.isNotEmpty) {
                      gymLocation = result;
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                        SizedBox(width: 5),
                        Text("Choose", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        SizedBox(width: 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () async {
                  /// save all data in firebase (create account)
                  if (widget.urlImage.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Image GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.email.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a email"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (!isValidEmail(widget.email.text.toString())) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a valid email"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.commercial.text.trim().isEmpty ) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a Commercial Record"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }

                  else if (widget.commercial.text.trim().length<14 ) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a 14 digit Commercial Record"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }



                  else if (widget.password.text.trim().length < 6) {



                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password length is short (minimum : 6)"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.phone.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a Phone Number"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                  else if (widget.phone.text.trim().length!=10) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter 10 digits Phone Number"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }


                  else if (gymLocation?.address.isEmpty ?? true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select the gym location"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.phone.text.toString()[0] != '0') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("The phone number must start with 05"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.phone.text.toString()[1] != '5') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("The phone number must start with 05"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.nameGym.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Name GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.descriptionGym.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Description Name GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.sundayFrom == 'From' || widget.sundayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In Sunday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.mondayFrom == 'From' || widget.mondayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In monday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.tuesdayFrom == 'From' || widget.tuesdayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In tuesday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.wednesdayFrom == 'From' || widget.wednesdayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In wednesday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.thursdayFrom == 'From' || widget.thursdayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In thursday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.fridayFrom == 'From' || widget.fridayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In friday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.saturdayFrom == 'From' || widget.saturdayTo == 'To') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Working Hours GYM In saturday"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.priceOneMonth.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Subscription Price For 1 Month GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.priceThreeMonth.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Subscription Price For 3 Month GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.priceSixMonth.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Subscription Price For 6 Month GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else if (widget.price12Month.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Add Subscription Price For 12 Month GYM"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else {
                    String fcm = await FbNotifications.getFcm();
                    bool state = await FbAuthController().createAccount(context,
                        user: {
                          'fcm': fcm,
                          'logo': widget.urlImage,
                          'logo2': '',
                          'nameGym': widget.nameGym.text,
                          'locationGym': gymLocation!.address,
                          'gymLat': gymLocation!.latLng.latitude,
                          'gymLng': gymLocation!.latLng.longitude,
                          'descriptionGym': widget.descriptionGym.text,
                          'email': widget.email.text,
                          'password': await AppController.to.encryptData(plainText: widget.password.text, encryptData: true),
                          'phone': widget.phone.text,
                          'commercial': widget.commercial.text,
                          'typeAccount': 2,
                          'availableWifi': widget.availableWifi,
                          'availableBarking': widget.availableBarking,
                          'workingHours': [
                            {'name': 'Sunday', 'Time': '${widget.sundayFrom} - ${widget.sundayTo}'},
                            {'name': 'Monday', 'Time': '${widget.mondayFrom} - ${widget.mondayTo}'},
                            {'name': 'Tuesday', 'Time': '${widget.tuesdayFrom} - ${widget.tuesdayTo}'},
                            {'name': 'Wednesday', 'Time': '${widget.wednesdayFrom} - ${widget.wednesdayTo}'},
                            {'name': 'Thursday', 'Time': '${widget.thursdayFrom}-${widget.thursdayTo}'},
                            {'name': 'Friday', 'Time': '${widget.fridayFrom} - ${widget.fridayTo}'},
                            {'name': 'Saturday', 'Time': '${widget.saturdayFrom} - ${widget.saturdayTo}'},
                          ],
                          'price': {
                            '1': widget.priceOneMonth.text,
                            '3': widget.priceThreeMonth.text,
                            '6': widget.priceSixMonth.text,
                            '12': widget.price12Month.text,
                          },
                          'reviews': [],
                          'offers': [],
                          'images': [],
                          'listSubscribe': [],
                        },
                        password: widget.password.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 179, 178, 178),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 30),
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
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Future<void> pickImageAfterSelect({required BuildContext context}) async {
    ImagePicker imagePicker = ImagePicker();

    widget._pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (widget._pickedFile != null) {
      /// here code upload image to firebase
      setState(() {
        widget.selectNewImage = true;
      });
      File file = File(widget._pickedFile!.path);
      widget.urlImage = await FbFireStoreController().uploadFile(imageFile: file, fileName: widget._pickedFile!.name);
    }
  }

  Future<String> selectTime({
    required BuildContext context,
  }) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );
    if (picked != null) {
      hiddenKeyboard(context);
      return '${picked.hour}:${picked.minute}';
    } else {
      return '';
    }
  }

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
}
