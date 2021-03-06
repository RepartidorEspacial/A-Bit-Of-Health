import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => print('created'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
      providers: [
        Provider(create: (_) => UserModel()),
        Provider(create: (_) => FoodOfferModel(foodOffers: [])),
        Provider(create: (_) => <FoodOffer>[]),
        ChangeNotifierProvider(create: (_) => Food())
      ],
      
    
              child: MaterialApp(
                localizationsDelegates: [
                        SfGlobalLocalizations.delegate,
                         GlobalMaterialLocalizations.delegate,
                         GlobalWidgetsLocalizations.delegate,
                         GlobalCupertinoLocalizations.delegate
                  ],
                supportedLocales: [
                        const Locale('en'),
                        const Locale('es')
                  ],
              locale: const Locale('es'),

          debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle().copyWith(padding:MaterialStateProperty.all( EdgeInsets.symmetric( vertical:21,horizontal: 17) ))
          ),
          scrollbarTheme: ScrollbarThemeData().copyWith(
              trackBorderColor:
                  MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
              showTrackOnHover: true,
              isAlwaysShown: true,
              thumbColor:
                  MaterialStateProperty.all((Colors.white.withOpacity(0.5))),
              trackColor:
                  MaterialStateProperty.all(Colors.black.withOpacity(0.1))),
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'HomePage',
        routes: getRoutes(),
      ),
    );
  }
}
