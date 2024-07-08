import 'package:dream_ai/home/components/app_colors.dart';
import 'package:dream_ai/home/screen/home_screen.dart';
import 'package:dream_ai/provider/price_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';



void main() async{
  await dotenv.load(fileName: ".env.dev");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       theme: ThemeData(
          fontFamily: 'Avenir',
          brightness: Brightness.light,
          primaryColor: AppColors.lightBlue,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.lightBlue,
            elevation: 0.0,
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: const ColorScheme(
            
            surfaceTint: Colors.white,
            primary: AppColors.lightBlue,
            secondary: Colors.blue,
            surface: Colors.white,
            background: Colors.black12,
            error: Colors.red,
            onPrimary: Colors.black,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.red,
            brightness: Brightness.light,
          ).copyWith(background: Colors.white),
        ),
      home: HomeScreen() ,
    );
  }
}


