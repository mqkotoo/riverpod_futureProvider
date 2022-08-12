import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/postal_code.dart';
import 'main_logic.dart';


final _logicProvider = Provider<Logic>((ref) => Logic());
final _postalCodeProvider = StateProvider<String>((ref) => "");

AutoDisposeFutureProviderFamily<PostalCode, String> _apiFamilyProvider =
    FutureProvider.autoDispose.family<PostalCode,String>((ref,postalcode) async {

      Logic logic  = ref.watch(_logicProvider);

      if(!logic.willProceed(postalcode)) {
        return PostalCode.empty;
      }

      return await logic.getPostalCode(postalcode);
    });

class MainPageVM {

  late final WidgetRef _ref;
  String get postalcode => _ref.watch(_postalCodeProvider);

  AsyncValue<PostalCode> postalCodeWithFamily(String postcode) =>
      _ref.watch(_apiFamilyProvider(postcode));

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  void onPostalcodeChanged(String postalcode) {
    _ref.read(_postalCodeProvider.notifier).update((state) => postalcode);
  }
}