import 'dart:io';

List<String> productNames = [
  'Keyboard',
  'Mouse',
  'Monitor',
  'USB Cable',
  'Headphones'
];
List<double> productPrices = [100, 50, 300, 20, 150];

void main() {
  print("Welcome to the store!");

  while (true) {
    List<int> cartQuantities = [0, 0, 0, 0, 0];

    showMenu();

    while (true) {
      stdout.write("Enter product number (1-5) or 0 to finish: ");
      int productNumber = int.tryParse(stdin.readLineSync()!) ?? -1;

      if (productNumber == 0) break;
      if (productNumber < 1 || productNumber > 5) {
        print("Invalid product number.");
        continue;
      }

      stdout.write("Enter quantity: ");
      int quantity = int.tryParse(stdin.readLineSync()!) ?? 0;
      if (quantity <= 0) {
        print("Invalid quantity.");
        continue;
      }

      cartQuantities[productNumber - 1] += quantity;
    }

    stdout.write("Enter your name: ");
    String name = stdin.readLineSync()!;
    stdout.write("Enter your phone number: ");
    String phone = stdin.readLineSync()!;

    double subtotal = 0;
    print("\n----- Receipt -----");
    for (int i = 0; i < 5; i++) {
      if (cartQuantities[i] > 0) {
        double totalPrice = productPrices[i] * cartQuantities[i];
        subtotal += totalPrice;
        print(
            "${productNames[i]} x${cartQuantities[i]} = \$${totalPrice.toStringAsFixed(2)}");
      }
    }

    double tax = calculateTax(subtotal);
    double discount = calculateDiscount(subtotal);

    double deliveryFee = 0;
    stdout.write("\nDo you want delivery? (yes/no): ");
    String delivery = stdin.readLineSync()!.toLowerCase();

    if (delivery == 'yes') {
      stdout.write("Enter delivery distance in km: ");
      int km = int.tryParse(stdin.readLineSync()!) ?? 0;
      deliveryFee = calculateDeliveryFee(km);
    }

    double total = subtotal + tax + deliveryFee - discount;

    print("\n----------------------------");
    print("Subtotal: \$${subtotal.toStringAsFixed(2)}");
    print("Tax (13%): \$${tax.toStringAsFixed(2)}");
    print("Discount: \$${discount.toStringAsFixed(2)}");
    if (deliveryFee > 0) {
      print("Delivery fee: \$${deliveryFee.toStringAsFixed(2)}");
    }
    print("----------------------------");
    print("Total to pay: \$${total.toStringAsFixed(2)}");
    print("Thank you, $name");
    print("----------------------------\n");

    stdout.write("New customer? (yes/no): ");
    String again = stdin.readLineSync()!.toLowerCase();
    if (again != 'yes') {
      print("Goodbye.");
      break;
    }
  }
}

void showMenu() {
  print("\nAvailable products:");
  for (int i = 0; i < productNames.length; i++) {
    print("${i + 1}. ${productNames[i]} - \$${productPrices[i]}");
  }
}

double calculateTax(double subtotal) {
  return subtotal * 0.13;
}

double calculateDiscount(double subtotal) {
  return subtotal > 1000 ? subtotal * 0.1 : 0;
}

double calculateDeliveryFee(int km) {
  return 15 + (km * 1.2);
}
