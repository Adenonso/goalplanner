import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  bool _lights = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            AppBar(title: Text('Settings')),

            //set dark/light mode
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.white,
              title: const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 17),
              ),
              trailing: Switch(
                  value: _lights,
                  onChanged: (bool value) {
                    setState(() {
                      _lights = !_lights;
                    });
                  }),
              onTap: () {},
            ),

            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.white,
              title: const Text(
                'View Analytics',
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(CupertinoIcons.graph_circle),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
