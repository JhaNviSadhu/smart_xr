import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:smart_xr/views/home/cubit/home_cubit.dart';

import 'views/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  // FlutterDownloader.registerCallback(downloadCallback);
  runApp(const MyApp());
}

void downloadCallback(
    String id, DownloadTaskStatus status, int progress) async {
  print('callback: ID = $id || status = $status || progress = $progress');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Smart XR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Smart XR'),
      ),
    );
  }
}
