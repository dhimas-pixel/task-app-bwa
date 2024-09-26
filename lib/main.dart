import 'package:course_task_app/common/app_color.dart';
import 'package:course_task_app/common/app_route.dart';
import 'package:course_task_app/data/models/user.dart';
import 'package:course_task_app/presentation/bloc/user/user_cubit.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          primaryColor: AppColor.primary,
          colorScheme: ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          ),
          scaffoldBackgroundColor: AppColor.scaffold,
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: AppBarTheme(
            surfaceTintColor: AppColor.primary,
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
        ),
        initialRoute: AppRoute.home,
        routes: {
          AppRoute.home: (context) {
            return FutureBuilder(
              future: DSession.getUser(),
              builder: (context, snapshot) {
                if (snapshot.data == null) return const Scaffold(); // Login
                User user = User.fromJson(Map.from(snapshot.data!));
                context.read<UserCubit>().update(user);
                if (user.role == "Admin") return const Scaffold(); // Admin

                return const Scaffold(
                  body: Center(
                    child: Text("Home Employee"),
                  ),
                );
              },
            );
          },
          AppRoute.login: (context) => const Scaffold(),
          AppRoute.addEmployee: (context) => const Scaffold(),
          AppRoute.addTask: (context) => const Scaffold(),
          AppRoute.detailTask: (context) => const Scaffold(),
          AppRoute.listTask: (context) => const Scaffold(),
          AppRoute.profile: (context) => const Scaffold(),
          AppRoute.monitorEmployee: (context) => const Scaffold(),
        },
      ),
    );
  }
}
