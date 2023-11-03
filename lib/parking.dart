import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zeroapp/exercise.dart';
import 'main_screen.dart';
// import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'exercise.dart';

class Parkinglot extends StatefulWidget {
  const Parkinglot({super.key});

  @override
  State<Parkinglot> createState() => _ParkinglotState();
}

class _ParkinglotState extends State<Parkinglot> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  bool isSettingsExpanded = false;
  String userName = 'Guest';
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getUserName();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();

      if (userDoc.exists) {
        final userName = userDoc['Name'];
        return userName;
      } else {
        return 'Guest1';
      }
    } else {
      return 'Guest2';
    }
  }

  void toggleSettingsExpansion() {
    if (mounted) {
      setState(() {
        isSettingsExpanded = !isSettingsExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginSignupScreen()),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userName = snapshot.data;
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('image/little_mermaid.png'),
                      // backgroundColor: Colors.white,
                    ),
                    accountName: Text(userName ?? 'Guest'),
                    accountEmail: Text(userEmail ?? 'None'),
                    onDetailsPressed: () {
                      print('accountName,accountEmail');
                    },
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                            //bottomLeft: Radius.circular(40.0),
                            //bottomRight: Radius.circular(40.0)
                            )),
                    otherAccountsPictures: [
                      GestureDetector(
                        onTap: () {
                          _authentication.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginSignupScreen()),
                          );
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.exit_to_app_sharp,
                              color: Colors.white),
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.map, color: Colors.blueGrey),
                    title: Text('주차장 찾기'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExPage()),
                      );
                    },
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    leading: Icon(Icons.my_location, color: Colors.blueGrey),
                    title: Text('내 차 찾기'),
                    onTap: () {
                      print('Home is clikced');
                    },
                    trailing: Icon(Icons.navigate_next),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blueGrey),
                    title: Text('Settings'),
                    onTap: () {
                      toggleSettingsExpansion();
                    },
                    trailing: isSettingsExpanded
                        ? Icon(Icons.expand_less)
                        : Icon(Icons.expand_more),
                  ),
                  AnimatedCrossFade(
                      firstChild: SizedBox.shrink(),
                      secondChild: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.blueGrey,
                              ),
                              title: Text('회원정보수정'),
                              onTap: () {
                                print('회원정보수정');
                              },
                              trailing: Icon(Icons.navigate_next),
                            )
                          ],
                        ),
                      ),
                      crossFadeState: isSettingsExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 270))

                  // if (isSettingsExpanded)
                  //   Padding(
                  //     padding: EdgeInsets.only(left: 16), // 들여쓰기
                  //     child: Column(
                  //       children: <Widget>[
                  //         ListTile(
                  //           leading: Icon(Icons.person),
                  //           title: Text('회원정보수정'),
                  //           onTap: () {
                  //             print('개인정보 수정');
                  //           },
                  //           trailing: Icon(Icons.navigate_next),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                ],
              );
            }
          },
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'BBBBBBBBBBBBBBB',
            style: TextStyle(fontSize: 24),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          GestureDetector(
            onTap: () {
              print('gesturedetector1');
            },
            child: Container(
              width: 170,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 212, 211, 211),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 17), // Add some space between the squares
          GestureDetector(
            onTap: () {
              // Navigate to a different page or do something else.
            },
            child: Container(
              width: 170,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 212, 211, 211),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
        ]),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            //
          },
          child: Container(
            width: 360,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 212, 211, 211),
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            //
          },
          child: Container(
            width: 360,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 212, 211, 211),
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
