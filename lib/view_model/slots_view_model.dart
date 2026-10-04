import 'package:rotary_parking/model/slotsnumber.dart';

mixin class SlotsViewModel {
  dynamic body;

  getSlots() {
    return SlotsNumbers.getSlots();
  }
}
