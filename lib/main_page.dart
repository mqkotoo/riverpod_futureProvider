import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_future/main_page_vm.dart';


class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {

  MainPageVM _vm = MainPageVM();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              // keyboardType: TextInputType.number,
              maxLength: 7,
              onChanged: (text) => _vm.onPostalcodeChanged(text),
            ),
            Expanded(
              child: _vm.postalCodeWithFamily(_vm.postalcode).when(
                data: (data) => ListView.separated(
                  itemCount: data.data.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.data[index].ja.prefecture),
                      Text(data.data[index].ja.address1),
                      Text(data.data[index].ja.address2),
                    ],
                  ), separatorBuilder: (context,index) => Divider(color: Colors.black),
                ),
                error: (error,stack) => Text(error.toString()),
                loading: () => AspectRatio(
                  aspectRatio:1,
                  child: const CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

