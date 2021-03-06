import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tuple/tuple.dart';

import 'providers/authentification.dart';


class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return HistoryPage();
              else
                return Login();
            } else {
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 250,
                width: 250,
              ));
            }
          });
    else
      return HistoryPage();
  }
}





class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date1 = '' ;
    String date2 = '' ;
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          //GlobalWidgetsLocalizations localizations = Localizations.of<GlobalWidgetsLocalizations>(context, GlobalWidgetsLocalizations);
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                      'https://images.unsplash.com/photo-1584559582213-787a2953dcbe?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2560&q=80'),
                  fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'History'),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                        "Selecciona el intervalo de fechas \n             para ver tu historial",
                        style: TextStyle(fontFamily: 'Mont', fontSize: 28)),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SfDateRangePicker(
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        date1 =
                            args.value.startDate.toString().split(' ').first;
                        date2 = args.value.endDate.toString().split(' ').first;
                        print(date1);
                        print(date2);
                      },
                      selectionMode: DateRangePickerSelectionMode.range,
                      maxDate: DateTime.now(),
                      minDate: DateTime.parse(Provider.of<UserModel>(context, listen: false).creationDate),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (date1.length > 5 && date2.length > 5 )
                            Navigator.pushNamed(context, 'HistoryView',
                              arguments: Tuple2(date1, date2));
                         else
                          showMessage(context);
                         
                      },
                      child: Text(
                        "Ver",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ))
            ],
          ),
        ),
      );
  }

  showMessage(context) {
    final snackBar = SnackBar(
      content: Text('Por favor seleccione dos fechas'),
      action: SnackBarAction(
        label: 'Aceptar',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
