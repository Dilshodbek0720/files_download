import 'package:file_download_tutorial/models/file_info.dart';
import 'package:file_download_tutorial/widgets/single_file_download.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int doublePress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.blue,),
        title: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Martha Craig", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.black
              ),),
              Text("last seen just now", style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFF787878)
              ),)
            ],
          ),
        ),
        actions: [
          SizedBox(height: 37, width: 37, child: Image.asset("assets/images/profile.png"),),
          const SizedBox(width: 8,)
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/backround.png", fit: BoxFit.cover,),
          ),
          ListView(
            children: List.generate(filesData.length, (index) {
              var singleFile = filesData[index];
              return SingleFileDownload(fileInfo: singleFile);
            }),
          )
        ],
      ),
    );
  }
}
