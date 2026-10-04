import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotary_parking/component/parking_slot_info_window.dart';
import 'package:rotary_parking/view_model/paking_controller.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    ParkingController parkingController = Get.put(ParkingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "SMART CAR PARKING",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Parking Slots",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Please select any slot",
                        style:
                            TextStyle(color: Color.fromARGB(255, 35, 122, 38)),
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ParkingSlot(
                        isBooked: parkingController.slot1.value.booked,
                        isParked: parkingController.slot1.value.isParked,
                        slotName: "Slot no.1",
                        slotId: "1",
                        time: parkingController.slot1.value.parkingHours
                            .toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: VerticalDivider(
                      color: Colors.blue,
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ParkingSlot(
                        isBooked: parkingController.slot2.value.booked,
                        isParked: parkingController.slot2.value.isParked,
                        slotName: "Slot no.2",
                        slotId: "2",
                        time: parkingController.slot2.value.parkingHours
                            .toString(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ParkingSlot(
                        isBooked: parkingController.slot3.value.booked,
                        isParked: parkingController.slot3.value.isParked,
                        slotName: "Slot no.3",
                        slotId: "3",
                        time: parkingController.slot3.value.parkingHours
                            .toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: VerticalDivider(
                      color: Colors.blue,
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ParkingSlot(
                        isBooked: parkingController.slot4.value.booked,
                        isParked: parkingController.slot4.value.isParked,
                        slotName: "Slot no.4",
                        slotId: "4",
                        time: parkingController.slot4.value.parkingHours
                            .toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
