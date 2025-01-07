// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_desktop/app_controller.dart';
import 'package:responsive_desktop/table.dart';
import 'package:responsive_desktop/tree_structure_left_side.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appController = Get.put(AppDataController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Responsive Desktop App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ResponsiveHome());
  }
}

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('Responsive Desktop',
              style: TextStyle(
                  fontSize: getResponsiveFontSize(context, sizeValue: 'L'),
                  fontWeight: FontWeight.bold))),
      body: LayoutBuilder(builder: (context, constraints) {
        if (size.width > 800) {
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            child: Row(children: [
              Expanded(child: buildSideMenu(context)),
              Expanded(
                  flex: 3,
                  child: Column(children: [
                    buildMainContent(context),
                    const TableShow(),
                    SizedBox(height: 10),
                    treeStructure(context)
                  ])),
            ]),
          );
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            child: Center(
                child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.85,
              child: Column(children: [
                buildSideMenu(context),
                buildMainContent(context),
                const TableShow(),
                SizedBox(height: 10),
                treeStructure(context)
              ]),
            )),
          );
        }
      }),
    );
  }

  Widget buildSideMenu(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.all(20),
        child: Flex(
            direction: (size.width > 800) ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: (size.width > 800)
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              commonSideTitle(context, title: 'Home'),
              SizedBox(height: 10),
              commonSideTitle(context, title: 'About'),
              SizedBox(height: 10),
              commonSideTitle(context, title: 'Contact')
            ]));
  }

  commonSideTitle(BuildContext context, {String title = ''}) {
    return Text(title,
        style: TextStyle(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, sizeValue: 'M')));
  }

  Widget buildMainContent(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Text('Welcome to the responsive app!',
              style: TextStyle(
                  fontSize: getResponsiveFontSize(context, sizeValue: 'M'))),
          SizedBox(height: 20),
          Text('This layout adjusts based on the screen size.',
              style: TextStyle(fontSize: getResponsiveFontSize(context))),
        ]));
  }

  Widget treeStructure(BuildContext context) {
    return InkWell(
        splashColor: const Color(0x7E9E9E9E),
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          SharedPreferences instance = await SharedPreferences.getInstance();
          instance.setString('IDkey', 'ID1');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              List list = [
                {'key': 'Website Link', 'ID': 'ID1'},
                {'key': 'Web Link', 'ID': 'ID2'},
                {'key': 'Web browser', 'ID': 'ID3'},
                {'key': 'Hello web', 'ID': 'ID4'},
                {'key': 'Ask Question', 'ID': 'ID5'}
              ];
              return GetBuilder<AppDataController>(
                  id: 'TreeUpdate',
                  builder: (cont) {
                    print('pavan ${instance.getString('IDkey')}');
                    return TreeStructureLeftSide(
                        mainTitle: 'Home',
                        listKeyTitle: 'key',
                        list: list,
                        listHeight: MediaQuery.sizeOf(context).height,
                        onTap: (index) async {
                          instance.setString('IDkey', list[index]['ID']);
                          appController.update(['TreeUpdate']);
                        },
                        matchingTitle: instance.getString('IDkey') ?? '',
                        matchingTitleKey: 'ID');
                  });
            },
          ));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            child: commonSideTitle(context, title: 'Tree structure')));
  }
}

double getResponsiveFontSize(BuildContext context, {String? sizeValue}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double mulFac = (sizeValue == 'L' ? 1.5 : (sizeValue == 'M' ? 1.25 : 1));
  if (screenWidth > 1600) {
    return 30 * mulFac;
  } else if (screenWidth > 1200) {
    return 24 * mulFac;
  } else if (screenWidth > 800) {
    return 18 * mulFac;
  } else if (screenWidth > 400) {
    return 14 * mulFac;
  } else {
    return 12 * mulFac;
  }
}
