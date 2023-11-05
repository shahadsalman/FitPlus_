import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitplus/screens/home/edit_profile_controller.dart';
import 'package:fitplus/screens/map_picker/map_picker_screen.dart';
import 'package:fitplus/screens/map_picker/models/lat_lng_model.dart';
import 'package:fitplus/value/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../../src/controller/splash_screens_controller.dart';
import '../login&register/login.dart';
import '../map_picker/models/place_info.dart';
import 'mainGym.dart';


class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final controller=Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 20,
          leading: GestureDetector(
              onTap: (){
Get.back();
              },

              child: Icon(Icons.arrow_back)),

          backgroundColor: const Color.fromARGB(255, 210, 199, 226),
          title: const Text('Edit Profile'),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20)),
      body:
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (_,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          controller.urlImage.value=snapshot.data!['logo'];
          controller.nameGym.text=snapshot.data!['nameGym'];
          controller.locationGym.value=snapshot.data!['locationGym'];
          controller.gymLocation=PlaceInfo(
              latLng: LatLng(
                  latitude: snapshot.data!.data()!.containsKey('gymLat')?snapshot.data!['gymLat']:37.764870,
                  longitude:snapshot.data!.data()!.containsKey('gymLng')?snapshot.data!['gymLng']:73.74894 ));
          controller.descriptionGym.text=snapshot.data!['descriptionGym'];
          controller.email.text=snapshot.data!['email'];
          controller.phone.text=snapshot.data!['phone'];
          controller.commercial.text=snapshot.data!.data()!.containsKey('commercial')?snapshot.data!['commercial']:"";
          controller.availableWifi.value=snapshot.data!['availableWifi'];
          controller.availableBarking.value=snapshot.data!['availableBarking'];
          controller.sundayFrom.value=snapshot.data!['workingHours'][0]['Time'].toString().split('-').first;
          controller.sundayTo.value=snapshot.data!['workingHours'][0]['Time'].toString().split('-').last;
          controller.mondayFrom.value=snapshot.data!['workingHours'][1]['Time'].toString().split('-').first;
          controller.mondayTo.value=snapshot.data!['workingHours'][1]['Time'].toString().split('-').last;
          controller.tuesdayFrom.value=snapshot.data!['workingHours'][2]['Time'].toString().split('-').first;
          controller.tuesdayTo.value=snapshot.data!['workingHours'][2]['Time'].toString().split('-').last;
          controller.wednesdayFrom.value=snapshot.data!['workingHours'][3]['Time'].toString().split('-').first;
          controller.wednesdayTo.value=snapshot.data!['workingHours'][3]['Time'].toString().split('-').last;
          controller.thursdayFrom.value=snapshot.data!['workingHours'][4]['Time'].toString().split('-').first;
          controller.thursdayTo.value=snapshot.data!['workingHours'][4]['Time'].toString().split('-').last;
          controller.fridayFrom.value=snapshot.data!['workingHours'][5]['Time'].toString().split('-').first;
          controller.fridayTo.value=snapshot.data!['workingHours'][5]['Time'].toString().split('-').last;
          controller.saturdayFrom.value=snapshot.data!['workingHours'][6]['Time'].toString().split('-').first;
          controller.saturdayTo.value=snapshot.data!['workingHours'][6]['Time'].toString().split('-').last;

          return ListView(
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
                      controller.pickImageAfterSelect(context: context);
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Obx(()=>Center(
                        child:  controller.urlImage.value!=""
                            ? Image.network(
                          controller.urlImage.value,
                          fit: BoxFit.fill,
                          height: 150,
                        ) : const Icon(Icons.camera_alt, size: 50),
                      )),
                    ),
                  ),
                ],
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
                    controller: controller.email,
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
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 35, right: 35),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  maxLength: 10,
                    controller: controller.phone,
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
                    controller: controller.commercial,
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
                    controller: controller.nameGym,
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
                    controller: controller.descriptionGym,
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
                      child: Text('Available Wifi In GYM ?',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    Obx(() => Switch(
                      value: controller.availableWifi.value,
                      onChanged: (value) {
                        controller.availableWifi.value = value;

                      },
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Available Barking In GYM ?',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    Obx(() => Switch(
                      value: controller.availableBarking.value,
                      onChanged: (value) {
                        controller.availableBarking.value = value;
                      },
                    )),
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
                      child: Text('Working Hours',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
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
                      child: Text('Sunday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.sundayFrom.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(()=>Text(controller.sundayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.sundayTo.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.sundayTo.value)),
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
                      child: Text('Monday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.mondayFrom.value = await controller.selectTime(context: context);

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child:Obx(() =>  Text(controller.mondayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.mondayTo.value = await controller.selectTime(context: context);

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(()=>Text(controller.mondayTo.value)),
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
                      child: Text('tuesday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.tuesdayFrom.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.tuesdayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.tuesdayTo.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.tuesdayTo.value)),
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
                      child: Text('wednesday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.wednesdayFrom.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.wednesdayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.wednesdayTo.value = await controller.selectTime(context: context);

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.wednesdayTo.value)),
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
                      child: Text('thursday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.thursdayFrom.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.thursdayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.thursdayTo.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child:Obx(() =>  Text(controller.thursdayTo.value)),
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
                      child: Text('friday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.fridayFrom.value= await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.fridayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.fridayTo.value = await controller.selectTime(context: context);

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.fridayTo.value)),
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
                      child: Text('saturday',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.saturdayFrom.value = await controller.selectTime(context: context);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.saturdayFrom.value)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.saturdayTo.value = await controller.selectTime(context: context);

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Obx(() => Text(controller.saturdayTo.value)),
                        ),
                      ),
                    )
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
                    Expanded(
                        child:Obx(() =>  Text(
                          controller.locationGym.value ,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16),
                        ))),
                    const SizedBox(width: 10),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final PlaceInfo? result = await Get.to(
                              () => MapPickerScreen(
                            lat: controller.gymLocation!=null?controller.gymLocation!.latLng.latitude:37.764870,
                            lng: controller.gymLocation!=null?controller.gymLocation!.latLng.longitude:73.74894,
                            countries: const ["SA"],
                          ),
                        );
                        if (result != null && result.address.isNotEmpty) {
                          controller.gymLocation = result;
                          controller.locationGym.value=result.address;
                        }
                      },
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.white, size: 18),
                            SizedBox(width: 5),
                            Text("Choose",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
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
                      if (controller.urlImage.value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Image GYM"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.email.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a email"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (!controller.isValidEmail(controller.email.text.toString())) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a valid email"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.commercial.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a Commercial Record"),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                      else if (controller.commercial.text.trim().length<14 ) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a 14 digit Commercial Record"),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                      else if (controller.phone.text.trim().length!=10) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter 10 digits Phone Number"),
                          backgroundColor: Colors.redAccent,
                        ));
                      }



                      else if (controller.phone.text.trim().isEmpty ) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a Phone Number"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.locationGym.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please select the gym location"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.phone.text.toString()[0] != '0') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("The phone number must start with 05"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.phone.text.toString()[1] != '5') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("The phone number must start with 05"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.nameGym.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Name GYM"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.descriptionGym.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Description Name GYM"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.sundayFrom.value == 'From' ||
                          controller.sundayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In Sunday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.mondayFrom.value == 'From' ||
                          controller.mondayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In monday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.tuesdayFrom.value == 'From' ||
                          controller.tuesdayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In tuesday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.wednesdayFrom.value == 'From' ||
                          controller.wednesdayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                          Text("Please Add Working Hours GYM In wednesday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.thursdayFrom.value == 'From' ||
                          controller.thursdayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In thursday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.fridayFrom.value == 'From' ||
                          controller.fridayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In friday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else if (controller.saturdayFrom.value == 'From' ||
                          controller.saturdayTo.value == 'To') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Add Working Hours GYM In saturday"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else {
                        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                          'logo': controller.urlImage.value,
                          'nameGym': controller.nameGym.text,
                          'locationGym': controller.gymLocation!.address,
                          'gymLat': controller.gymLocation!.latLng.latitude,
                          'gymLng': controller.gymLocation!.latLng.longitude,
                          'descriptionGym': controller.descriptionGym.text,
                          'email': controller.email.text,
                          'phone': controller.phone.text,
                          'commercial': controller.commercial.text,
                          'availableWifi': controller.availableWifi.value,
                          'availableBarking': controller.availableBarking.value,
                          'workingHours': [
                            {
                              'name': 'Sunday',
                              'Time':
                              '${controller.sundayFrom.value} - ${controller.sundayTo.value}'
                            },
                            {
                              'name': 'Monday',
                              'Time':
                              '${controller.mondayFrom.value} - ${controller.mondayTo.value}'
                            },
                            {
                              'name': 'Tuesday',
                              'Time':
                              '${controller.tuesdayFrom.value} - ${controller.tuesdayTo.value}'
                            },
                            {
                              'name': 'Wednesday',
                              'Time':
                              '${controller.wednesdayFrom.value} - ${controller.wednesdayTo.value}'
                            },
                            {
                              'name': 'Thursday',
                              'Time':
                              '${controller.thursdayFrom.value}-${controller.thursdayTo.value}'
                            },
                            {
                              'name': 'Friday',
                              'Time':
                              '${controller.fridayFrom.value} - ${controller.fridayTo.value}'
                            },
                            {
                              'name': 'Saturday',
                              'Time':
                              '${controller.saturdayFrom.value} - ${controller.saturdayTo.value}'
                            },
                          ],
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 179, 178, 178),
                      minimumSize:  Size(double.infinity, 50),
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
              const SizedBox(
                height: 80,
              ),
            ],
          );
        },
      ),
    );
  }
}
