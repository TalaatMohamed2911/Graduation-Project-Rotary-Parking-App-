import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rotary_parking/model/car_model.dart';

class ParkingController extends GetxController {
  RxList<CarModel> parkingSlotList = <CarModel>[].obs;
  TextEditingController name = TextEditingController();
  TextEditingController vehicalNumber = TextEditingController();
  RxDouble parkingTimeInMin = 10.0.obs;
  RxInt parkingAmount = 5.obs;
  RxString slotName = "".obs;
  // int time = 19;
  Rx<CarModel> slot1 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;
  Rx<CarModel> slot2 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;
  Rx<CarModel> slot3 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;
  Rx<CarModel> slot4 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;
  Rx<CarModel> slot5 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;
  Rx<CarModel> slot6 = CarModel(
    booked: false,
    isParked: false,
    parkingHours: "",
    name: "",
    paymentDone: false,
  ).obs;

  void bookParkingSlot(String slotId) {
    //print(parkingTimeInMin.value);
    slotName.value = slotId;

    //print(slotId);
    if (slotId == "1") {
      slot1Controller();
    } else if (slotId == "2") {
      slot2Controller();
    } else if (slotId == "3") {
      slot3Controller();
    } else if (slotId == "4") {
      slot4Controller();
    } else if (slotId == "5") {
      slot5Controller();
    } else if (slotId == "6") {
      slot6Controller();
    }
    BookedPopup();
  }

  void slot1Controller() async {
    slot1.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );

    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      slot1.value.parkingHours = parkingTime.toString();
      print(parkingTime);
    }

    slot1.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void slot2Controller() async {
    slot2.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );
    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      print(parkingTime);
      slot2.value.parkingHours = parkingTime.toString();
    }

    slot2.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void slot3Controller() async {
    slot3.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );
    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      print(parkingTime);
      slot3.value.parkingHours = parkingTime.toString();
    }

    slot3.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void slot4Controller() async {
    slot4.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );
    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      print(parkingTime);
      slot4.value.parkingHours = parkingTime.toString();
    }

    slot4.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void slot5Controller() async {
    slot5.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );
    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      print(parkingTime);
      slot5.value.parkingHours = parkingTime.toString();
    }

    slot5.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void slot6Controller() async {
    slot6.value = CarModel(
      booked: true,
      isParked: true,
      parkingHours: "${parkingTimeInMin.value}",
      name: name.text,
      paymentDone: true,
    );
    int parkingTime = parkingTimeInMin.value.toInt();

    while (parkingTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      parkingTime--;
      print(parkingTime);
      slot6.value.parkingHours = parkingTime.toString();
    }

    slot6.value = CarModel(
      booked: false,
      isParked: false,
      parkingHours: "",
      name: "",
      paymentDone: false,
    );
    print("Parking Time  ❤️ End ");
  }

  void timeCounter() {}
  Future<dynamic> BookedPopup() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: "SLOT BOOKED",
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        ),
        content: Column(
          children: [
            Lottie.asset(
              'assets/animation/done1.json',
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Slot Booked",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 5),
                const Text(
                  "Name : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  name.text,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.car_rental),
                const SizedBox(width: 5),
                const Text(
                  "Vehical No  : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  vehicalNumber.text,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.watch_later_outlined),
                const SizedBox(width: 5),
                const Text(
                  "Parking time : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  parkingTimeInMin.value.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.solar_power_outlined),
                const SizedBox(width: 5),
                const Text(
                  "Parking Slot : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Text(
                  "A-${slotName.value.toString()}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.currency_rupee,
                  size: 40,
                  color: Colors.blue,
                ),
                Text(
                  parkingAmount.value.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Close"),
            )
          ],
        ));
  }
}
