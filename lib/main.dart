import 'package:daily_supplications_app/modules/supplications_screen.dart';
import 'package:daily_supplications_app/shared/cubit/cubit.dart';
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:daily_supplications_app/shared/local/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacthHelper.inti();
bool?  themeModeValue= await CacthHelper.get_Data(key: "themeMode")??false;
print(themeModeValue!);
  runApp(
    DevicePreview(
      enabled: true, // Set to false in production
      builder: (context) => BlocProvider(
        create: (context) => AppCubit()..createDb()..changeValueOfThemeMode(value:themeModeValue ),
        child: MyApp(themeModeValue),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool ?value;
   MyApp(value);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(393, 852), // Set your base design size here
      builder: (context, child) {

        ScreenUtil.configure(
          data: MediaQuery.of(context),

        );
        return App(value);
      },
    );
  }
}
class App extends StatelessWidget {
  bool ?value;
  App(value);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return MaterialApp(
      useInheritedMediaQuery: true, // Necessary for DevicePreview
      locale: Locale('ar'),
      builder: DevicePreview.appBuilder,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0Xff21201e),
        textTheme: TextTheme(
          labelMedium: TextStyle(
              fontSize: 25.sp, fontWeight: FontWeight.bold,
              color: Colors.white,
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF005b1e),
          foregroundColor: Color(0xff000000),
          iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
          cardColor: Color(0Xff5846fe),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF01591c),
        )
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
              labelMedium: TextStyle(
                fontSize: 25.sp, fontWeight: FontWeight.bold,
                color: Colors.black,
              )
          ),
          appBarTheme: AppBarTheme(
              backgroundColor:Colors.blue,
              foregroundColor: Colors.blue,
              iconTheme: IconThemeData(
                color: Colors.white,
              )
          ),
          cardColor: Colors.blue,

          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
          )
      ),

      themeMode: AppCubit.get(context).themeMode?ThemeMode.light:ThemeMode.dark,


      debugShowCheckedModeBanner: false,
      home: SupplicationsScreen(),
    );
  },
);
  }
}

