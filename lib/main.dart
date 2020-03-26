import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tem_report/ShowSnackbar.dart';
import 'package:tem_report/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool loading = false;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController fullnameCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  final FocusNode _fullnameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  AnimationController fadeAniCon;
  Animation<double> fadeAnimation;

  AnimationController slideAniCon;
  Animation slideAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    setAnimataion();
  }

  setAnimataion() async {
    fadeAniCon = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    fadeAnimation = CurvedAnimation(parent: fadeAniCon, curve: Curves.easeIn);

    slideAniCon = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    slideAnimation = Tween<Offset>(
      begin: Offset(-10.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: slideAniCon,
        curve: Interval(
          0.0,
          0.9,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
    );

    await slideAniCon.forward();
    fadeAniCon.forward();
  }

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 300));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/snow.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
              child: Container(
                decoration: BoxDecoration(color: Colors.teal.shade600.withOpacity(0.7)),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ListView(
                      controller: _scrollController,
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height / 4),
                        Text(
                          "What's Your Name?",
                          style: Theme.of(context).textTheme.title,
                        ),

                        slideWg(),

                        // -------- Button UI --------
                        SizedBox(height: 20),
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: loading
                                  ? SpinKitFoldingCube(
                                      color: Colors.teal.shade600.withOpacity(0.7),
                                      size: 25.0,
                                      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 2000)),
                                    )
                                  : Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.teal.shade600.withOpacity(0.7),
                                    ),
                              onPressed: () {
                                onTabBtn();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget slideWg() {
    return SlideTransition(
      position: slideAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // -------- FIRST NAME UI --------
          SizedBox(height: 20),
          Text(
            'FULLNAME',
            style: Theme.of(context).textTheme.body1,
          ),
          TextField(
            style: Theme.of(context).textTheme.body2,
            controller: fullnameCon,
            textInputAction: TextInputAction.next,
            focusNode: _fullnameFocus,
            onTap: _scrollToBottom,
            onSubmitted: (text) {
              _fullnameFocus.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
          ),

          // -------- Password UI --------
          SizedBox(height: 20),
          Text(
            'PASSWORD',
            style: Theme.of(context).textTheme.body1,
          ),
          TextField(
            style: Theme.of(context).textTheme.body2,
            focusNode: _passwordFocus,
            controller: passwordCon,
            obscureText: true,
            onSubmitted: (text) => onTabBtn(),
          ),
        ],
      ),
    );
  }

  onTabBtn() async {
    if (fullnameCon.text == '') {
      final bar = ShowSnackbar().show("REQUIRE FULLNAME", color: Colors.orange);
      _key.currentState.showSnackBar(bar);
      return;
    }

    if (loading) return;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(seconds: 4));

    final bar = ShowSnackbar().show("HELLO ${fullnameCon.text}");
    _key.currentState.showSnackBar(bar);

    setState(() {
      loading = false;
      fullnameCon.clear();
      passwordCon.clear();
    });
  }
}
