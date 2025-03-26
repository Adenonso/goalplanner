import 'package:flutter/material.dart';

class MyDropdownmenu extends StatelessWidget {
  const MyDropdownmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // onSelected: (String result) {
      //   // Handle the selected menu item here
      //   print("result");
      // },
      // onSelected: (){},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Option 1',
          child: Text('Delete'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 2',
          child: Text('Copy'),
        ),
      ],
      icon: Icon(Icons.more_vert_rounded),
    );
  }
}
