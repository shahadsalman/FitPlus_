import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitplus/firebase/fb_auth_controller.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/screens/details_gym/details_gym_screen.dart';
import 'package:fitplus/screens/screenUser/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:gap/gap.dart';

class HomeScreenUser extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();

  bool fav = false;
  HomeScreenUser({super.key, this.fav = false});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 199, 226),
          elevation: 20,
          centerTitle: true,
          actions: const <Widget>[
            // IconButton(
            //   onPressed: () {
            //     //notafication
            //   },
            //   icon: const Icon(Icons.notifications),
            // ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(10, 60),
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: widget.searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search,
                              color: Color.fromARGB(255, 16, 16, 16)),
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 16, 16, 16)),
                          helperStyle: TextStyle(fontSize: 50)),
                    ),
                  ))
            ]),
          ),
        ),
        drawer: const NavigationDrawer(),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData) {
                return Container();
              }

              Map<String, dynamic> data =
                  userSnapshot.data!.data() as Map<String, dynamic>;

              List<String> favList = data['fav'] != null
                  ? List.from(userSnapshot.data!['fav'])
                  : [''];

              print(favList);

              return Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: widget.fav == false
                      ? FbFireStoreController().read(
                          nameCollection: 'users',
                          descending: true,
                          orderBy: 'typeAccount')
                      : FirebaseFirestore.instance
                          .collection('users')
                          //.where("typeAccount", isEqualTo: 2)
                          .where('gymId',
                              whereIn: favList.isEmpty ? [''] : favList)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                      List<QueryDocumentSnapshot> listGyme = [];
                      if (widget.searchController.text.trim().isEmpty) {
                        for (var gym in data) {
                          if (gym.get('typeAccount') == 2) {
                            listGyme.add(gym);
                          }
                        }
                      } else {
                        for (var gym in data) {
                          if (gym.get('typeAccount') == 2 &&
                              gym
                                  .get('nameGym')
                                  .toString()
                                  .toLowerCase()
                                  .contains(widget.searchController.text
                                      .toLowerCase())) {
                            listGyme.add(gym);
                          }
                        }
                      }
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                var token =
                                    FirebaseAuth.instance.currentUser!.uid;
                                bool isSubscriber = listGyme[index]
                                        ['listSubscribe']
                                    .contains(token.toString());
                                print(listGyme[index].data());
                                Get.to(() => DetailsGymScreen(
                                      currentUser: token,
                                      data: listGyme[index],
                                      subscribeUser: isSubscriber,
                                    ));
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Image.network(
                                        listGyme[index]['logo'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                listGyme[index]['nameGym'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                              child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              listGyme[index]['descriptionGym'],
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                              ),
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 14,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  listGyme[index]
                                                      ['locationGym'],
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, top: 8),
                                      child: IconButton(
                                        splashRadius: 1,
                                        icon: Icon(
                                          favList.contains(listGyme[index].id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favList
                                                  .contains(listGyme[index].id)
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                        onPressed: () {
                                          if (favList
                                              .contains(listGyme[index].id)) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update(
                                                    /*  ? {
                                                      'fav': FieldValue.arrayUnion([listGyme[index].id])
                                                    }
                                                  : */
                                                    {
                                                  'fav': FieldValue.arrayRemove(
                                                      [listGyme[index].id])
                                                });
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              'fav': FieldValue.arrayUnion(
                                                  [listGyme[index].id])
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 2,
                              color: const Color(0xff48358e),
                            );
                          },
                          itemCount: listGyme.length);
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.warning,
                                size: 85, color: Colors.grey.shade500),
                            Text(
                              'Empty',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TimesNewRoman',
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            }),
      );
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              builMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget builMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text(
              'Profile',
            ),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text('Logout'),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              FbAuthController().signOut();
            },
          ),
        ],
      );
}
