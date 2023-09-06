import 'package:file_download_tutorial/download_cubit/file_manager_cubit.dart';
import 'package:file_download_tutorial/models/file_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

class SingleFileDownload extends StatelessWidget {
  SingleFileDownload({Key? key, required this.fileInfo}) : super(key: key);

  final FileInfo fileInfo;
  FileManagerCubit fileManagerCubit = FileManagerCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 70),
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFE1FEC6).withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
                child: ListTile(
                leading: state.newFileLocation.isEmpty
                    ? Stack(children: [
                      Container(height: 56, width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.blue
                        ),
                      ),
                  state.progress == 0 ? const SizedBox(
                    height: 56,
                      width: 56,
                      child: Center(child: Icon(Icons.arrow_downward, size: 35, color: Colors.white,))) :
                   const SizedBox(
                      height: 56,
                      width: 56,
                      child: Center(child: Icon(Icons.cancel, size: 42, color: Colors.white,))),
                  Container(
                    height: 56,
                    width: 56,
                    padding: const EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      value: state.progress,
                      strokeAlign: 3,
                      color: Colors.redAccent,
                      backgroundColor: Colors.blue,
                    ),
                  )
                ],)
                    : Container(
                  height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.blue
                    ),
                    child: const Icon(Icons.file_copy, color: Colors.white,)),
                title: Text(fileInfo.fileName),
                subtitle: state.progress == 0 || state.progress == 1.0 ? Text("${fileInfo.memory*state.progress} / ${fileInfo.memory} MB") :
                    Text(fileInfo.memory.toString()),
                onTap: () {
                  context
                      .read<FileManagerCubit>()
                      .downloadFile(fileInfo: fileInfo);
                },
                trailing: IconButton(
                  onPressed: () {
                    if (state.newFileLocation.isNotEmpty) {
                      print(state.newFileLocation);
                      OpenFilex.open(state.newFileLocation);
                    }
                  },
                  icon: const Icon(Icons.file_open, color: Colors.white,),
                ),
            ),
              ),
          );
          //   ListTile(
          //   leading: state.newFileLocation.isEmpty
          //       ? const Icon(Icons.download)
          //       : const Icon(Icons.download_done),
          //   title: Text("Downloaded: ${state.progress * 100} %"),
          //   subtitle: LinearProgressIndicator(
          //     value: state.progress,
          //     backgroundColor: Colors.black,
          //   ),
          //   onTap: () {
          //     context
          //         .read<FileManagerCubit>()
          //         .downloadFile(fileInfo: fileInfo);
          //   },
          //   trailing: IconButton(
          //     onPressed: () {
          //       if (state.newFileLocation.isNotEmpty) {
          //         print(state.newFileLocation);
          //         OpenFilex.open(state.newFileLocation);
          //       }
          //     },
          //     icon: const Icon(Icons.file_open),
          //   ),
          // );
        },
      ),
    );
  }
}
