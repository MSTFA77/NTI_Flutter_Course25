import 'dart:io';

String name = '';
String accountNumber = '';
String accountType = '';
double balance = 0;

void main() {
  stdout.write("Enter your name: ");
  name = stdin.readLineSync()!;

  stdout.write("Enter account number: ");
  accountNumber = stdin.readLineSync()!;

  while (true) {
    stdout.write("Enter account type (savings/checking): ");n 
    accountType = stdin.readLineSync()!.toLowerCase();
    if (accountType == 'savings' || accountType == 'checking') {
      break;
    } else {
      print("Invalid account type.");
    }
  }

  while (true) {
    stdout.write("Enter initial balance: ");
    balance = double.tryParse(stdin.readLineSync()!) ?? -1;
    if (balance >= 0) {
      break;
    } else {
      print("Invalid balance.");
    }
  }

  while (true) {
    showMenu();
    stdout.write("Choose an option: ");
    int choice = int.tryParse(stdin.readLineSync()!) ?? 0;

    if (choice == 1) {
      deposit();
    } else if (choice == 2) {
      withdraw();
    } else if (choice == 3) {
      calculateProfit();
    } else if (choice == 4) {
      showSummary();
    } else if (choice == 5) {
      print("Thank you for using the banking system. Goodbye!");
      break;
    } else {
      print("Invalid option.");
    }
  }
}

void showMenu() {
  print("\n------ Menu ------");
  print("1. Deposit");
  print("2. Withdraw");
  print("3. Predict Future Balance (Profit Model)");
  print("4. View Account Summary");
  print("5. Exit");
}

void deposit() {
  stdout.write("Enter amount to deposit: ");
  double amount = double.tryParse(stdin.readLineSync()!) ?? -1;
  if (amount <= 0) {
    print("Invalid amount. Deposit failed.");
  } else {
    balance += amount;
    print("Deposit successful. New balance: \$${balance.toStringAsFixed(2)}");
  }
}

void withdraw() {
  stdout.write("Enter amount to withdraw: ");
  double amount = double.tryParse(stdin.readLineSync()!) ?? -1;
  if (amount <= 0) {
    print("Invalid amount. Withdrawal failed.");
  } else if (amount > balance) {
    print("Insufficient balance. Withdrawal denied.");
  } else {
    balance -= amount;
    print("Withdrawal successful. New balance: \$${balance.toStringAsFixed(2)}");
  }
}

void calculateProfit() {
  stdout.write("Enter number of years: ");
  int years = int.tryParse(stdin.readLineSync()!) ?? -1;

  stdout.write("Enter annual profit rate (%): ");
  double rate = double.tryParse(stdin.readLineSync()!) ?? -1;

  if (years < 0 || rate < 0) {
    print("Invalid input. Prediction failed.");
    return;
  }

  double futureBalance = balance * (1 + (rate / 100 * years));
  int rounded = futureBalance.round();

  print("Predicted future balance after $years years: \$${futureBalance.toStringAsFixed(2)}");
  print("Rounded balance: \$$rounded");
}

void showSummary() {
  print("\nAccount Summary:");
  print("Name: $name");
  print("Account Number: $accountNumber");
  print("Account Type: $accountType");
  print("Current Balance: \$${balance.toStringAsFixed(2)}");
  print("Rounded Balance: \$${balance.round()}");
}
