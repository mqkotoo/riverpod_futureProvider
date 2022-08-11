import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future/privider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  // MyHomePage({Key? key, required this.title}) : super(key: key);

   final String title = 'ゆめ';

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final postalCode = ref.watch(apiProvider).asData?.value;

    print(postalCode);

     return Scaffold(
      appBar: AppBar(
         title: Text(title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 7,
              onChanged: (text) => onPostalCodeChanged(text, ref),
            ),
            // Spacer(),
            Text(postalCode?.data[0].ja.prefecture ?? "No postal code..."),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void onPostalCodeChanged(String text,WidgetRef ref) {
    if(text.length != 7) {
      return;
    }

    try {
      int.parse(text);
      ref.watch(postalCodeProvider.notifier).state = text;
      print(text);
    }catch (e) {}
  }
}
