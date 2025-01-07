// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:responsive_desktop/main.dart';

class TreeStructureLeftSide extends StatelessWidget {
  final String mainTitle;
  final List list;
  final String listKeyTitle;
  final double listHeight;
  final String matchingTitle;
  final String matchingTitleKey;
  final void Function(int)? onTap;
  const TreeStructureLeftSide(
      {super.key,
      required this.mainTitle,
      required this.list,
      required this.listKeyTitle,
      required this.listHeight,
      required this.matchingTitle,
      required this.matchingTitleKey,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: 300 * getResponsiveConSize(context),
          padding: EdgeInsets.symmetric(
              horizontal: 20 * getResponsiveConSize(context)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20 * getResponsiveConSize(context)),
              Container(
                  height: 30 * getResponsiveConSize(context),
                  width: 250 * getResponsiveConSize(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10 * getResponsiveConSize(context)),
                      border: Border.all(
                          color: const Color(0x33000000), width: 0.5)),
                  padding: EdgeInsets.only(top: 8, left: 50),
                  child: Text(mainTitle ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      // style: 13.textBoldT.txtclr
                      style: TextStyle(
                          height: 0,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              getResponsiveFontSize(context, sizeValue: '')))),
              // SizedBox(height: max(10, 10 )),
              Row(children: [
                SizedBox(width: 20),
                verticalLineShow(height: 10)
              ]),
              SizedBox(
                height: listHeight, // max(643, 643 ),
                width: 280 * getResponsiveConSize(context),
                child: ListView.separated(
                    itemCount: list.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(width: 20),
                          if ((list.length - 1) != index)
                            verticalLineShow(
                                height: 30 * getResponsiveConSize(context))
                          else
                            verticalLineShow(
                                margin: EdgeInsets.only(
                                    bottom: 15 * getResponsiveConSize(context)),
                                height: 15 * getResponsiveConSize(context)),
                          horizontalLineShow(
                              width: 30 * getResponsiveConSize(context)),
                          Container(
                            height: 30 * getResponsiveConSize(context),
                            width: 200 * getResponsiveConSize(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10 * getResponsiveConSize(context)),
                                border: Border.all(
                                    width: 0.5,
                                    color: (matchingTitle ==
                                            list[index][matchingTitleKey]
                                        ? const Color(0xFF2C5BDE)
                                        : const Color(0x33000000)))),
                            child: InkWell(
                              splashColor: const Color(0x7E9E9E9E),
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                onTap?.call(index);
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  verticalLineShow(
                                      height:
                                          16 * getResponsiveConSize(context)),
                                  SizedBox(width: 10),
                                  Text(list[index][listKeyTitle] ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      // style: matchingTitle ==
                                      //         list[index][matchingTitleKey]
                                      //     ? 13
                                      //         .textBoldT
                                      //         .setColor(const Color(0xFF2C5BDE))
                                      //     : 13.textBoldT.txtclr
                                      style: TextStyle(
                                          color: ((matchingTitle ==
                                                  list[index][matchingTitleKey])
                                              ? const Color(0xFF2C5BDE)
                                              : Colors.black),
                                          fontWeight: FontWeight.w600,
                                          fontSize: getResponsiveFontSize(
                                              context,
                                              sizeValue: ''))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Row(children: [
                        SizedBox(width: 20),
                        verticalLineShow(height: 10),
                      ]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalLineShow({double? height, EdgeInsetsGeometry? margin}) {
    return Container(
        margin: margin,
        color: const Color(0x33000000),
        width: 0.5,
        height: height);
  }

  Widget horizontalLineShow({double? width, EdgeInsetsGeometry? margin}) {
    return Container(
        margin: margin,
        color: const Color(0x33000000),
        width: width,
        height: 0.5);
  }

  double getResponsiveConSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1600) {
      return 2.8;
    } else if (screenWidth > 1200) {
      return 2.2;
    } else if (screenWidth > 800) {
      return 1.6;
    } else if (screenWidth > 400) {
      return 1.2;
    } else {
      return 1;
    }
  }
}
