import 'package:flutter/material.dart';
import 'package:flutter_feed_newdemo_app/ui/loginPage/login.dart';
import 'package:flutter_feed_newdemo_app/custom/fab_bottom_app_bar.dart';
import 'package:flutter_feed_newdemo_app/home.dart';
import 'package:flutter_feed_newdemo_app/ui/newsFeedPage/FeedLatestArticle.dart';
import 'package:flutter_feed_newdemo_app/ui/newsFeedPage/widgets/ThumsUpReactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('My App'),
        ),
        body: LoginScreen(),
        // body: FbReactionBox(),
      ),
    );
  }
}
