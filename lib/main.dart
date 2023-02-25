
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:untitled/video_player_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(onPressed:   (){Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoApp()),
        );}, icon: Icon(Icons.video_library_outlined),)
      ),
      body:   Column(
        children: [
          Container(
            width: 390,
            height:500 ,
            child: Image.network("https://instagram.fist1-1.fna.fbcdn.net/v/t51.2885-15/332951616_1318665122024367_5348527791292833313_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fist1-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=gr0bmbZ8cFMAX8FJ5UF&edm=AHlfZHwBAAAA&ccb=7-5&oh=00_AfBfWzRBz5yCeAc58OKy3XgMapIQWwOpoSzt1H6ZRmZtvA&oe=63FD799D&_nc_sid=21929d"),),
          Container(
              width:180,
              height:50,child: ElevatedButton(onPressed: () {
_save();

          },
            child: Text("DOWNLOAD",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo)),))
        ],
      ),
    );



  }
  _save() async {
    var response = await Dio().get(
        "https://instagram.fist1-1.fna.fbcdn.net/v/t51.2885-15/332951616_1318665122024367_5348527791292833313_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fist1-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=gr0bmbZ8cFMAX8FJ5UF&edm=AHlfZHwBAAAA&ccb=7-5&oh=00_AfBfWzRBz5yCeAc58OKy3XgMapIQWwOpoSzt1H6ZRmZtvA&oe=63FD799D&_nc_sid=21929d",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        name: "hello");
    print(result);
  }
}