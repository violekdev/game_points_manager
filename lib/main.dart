import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/logic/cubit/theme_cubit.dart';

import 'package:game_points_manager/logic/debug/app_bloc_observer.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  Bloc.observer = AppBlocObserver();
  runApp(App(
    appRouter: AppRouter(),
  ));
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({
    Key key,
    @required this.appRouter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<PlayersCubit>(
          create: (playersCubitContext) => PlayersCubit(),
        ),
      ],
      child: CalcApp(appRouter: appRouter),
    );
  }
}

class CalcApp extends StatefulWidget {
  const CalcApp({
    Key key,
    @required this.appRouter,
  }) : super(key: key);

  final AppRouter appRouter;

  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        // builder: DevicePreview.appBuilder,
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: context
            .select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.splash,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
      );
    });
  }
}
