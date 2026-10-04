import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rotary_parking/view_model/paking_controller.dart';

class BookingPage extends StatelessWidget {
  final String slotName;
  final String slotId;
  const BookingPage({super.key, required this.slotId, required this.slotName});

  @override
  Widget build(BuildContext context) {
    ParkingController parkingController = Get.put(ParkingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "BOOK SLOT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animation/running_car.json',
                      width: 250,
                      height: 150,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Book Now ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          slotName,
                          style: const TextStyle(
                            fontSize: 26,
                            //fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Text(
                      "Enter your name ",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: parkingController.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 192, 190, 190))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 194, 193, 193))),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.lightBlue,
                          ),
                          labelText: "Name",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Text(
                      "Enter Vehical Number ",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: parkingController.vehicalNumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 192, 190, 190))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 194, 193, 193))),
                          prefixIcon: const Icon(
                            Icons.car_rental,
                            color: Colors.blue,
                          ),
                          hintText: "ex: 529  ب و م",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Choose Slot Time (in Minuits)",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Slider(
                    mouseCursor: MouseCursor.defer,
                    thumbColor: Colors.blue,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: "${parkingController.parkingTimeInMin.value} min",
                    value: parkingController.parkingTimeInMin.value,
                    onChanged: (newValue) {
                      parkingController.parkingTimeInMin.value = newValue;
                      // if (v <= 30) {
                      //   parkingController.parkingAmount.value = 30;
                      // } else {
                      //   parkingController.parkingAmount.value = 60;
                      // }
                      parkingController.parkingAmount.value =
                          (parkingController.parkingTimeInMin.value * 1.5)
                              .round();
                    },
                    divisions: 5,
                    min: 10,
                    max: 60,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("10"),
                      Text("20"),
                      Text("30"),
                      Text("40"),
                      Text("50"),
                      Text("60"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text("Amount to Be Pay"),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_pound,
                              size: 30,
                              color: Colors.blue,
                            ),
                            Obx(
                              () => Text(
                                "${parkingController.parkingAmount.value}",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // withoutFirebase.makePayment(slotId);
                        //  withoutFirebase.slot1.value = true;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "PAY NOW",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
