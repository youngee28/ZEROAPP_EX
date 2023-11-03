import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExPage extends StatefulWidget {
  const ExPage({super.key});

  @override
  State<ExPage> createState() => _ExPageState();
}

class _ExPageState extends State<ExPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('My App'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      //
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          CupertinoIcons.location,
          color: Colors.cyan[700],
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        color: Colors.cyan[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.home)),
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.person)),
          ],
        ),
      ),
    );
  }

  ListView _body() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        const SizedBox(
          height: 100,
        ),
        const SizedBox(
          height: 600,
        ),
      ],
    );
  }
}
