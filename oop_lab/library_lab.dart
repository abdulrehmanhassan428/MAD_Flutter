
const String rollNo = '04072313030';

// ===== Seeded settings (Do not edit) =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;

final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;
final int daysBig = 10 + u;
final int feeCap = 150 + 10 * t;
final int renewLimit = 1 + t % 3;
final int renewAttempts = 2 + u;
final int shelfSize = 3 + u % 4;

// ===== Step 1: Abstract Class and Inheritance =====
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

// ===== Step 4: Interface =====
abstract class Borrowable {
  bool get isAvailable;

  void borrow();

  void giveBack();
}

// ===== Step 5: Mixin =====
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) return false;

    renewals++;
    return true;
  }
}

// ===== Step 1: Book =====
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

// ===== Step 2: Magazine =====
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// ===== Step 3: DVD =====
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

// ===== Step 6: Enum =====
enum MemberType {
  guest,
  student,
  faculty;

  int get maxLoans {
    switch (this) {
      case MemberType.guest:
        return 2;
      case MemberType.student:
        return 5;
      case MemberType.faculty:
        return 10;
    }
  }

  int applyDiscount(int fee) {
    switch (this) {
      case MemberType.guest:
        return fee;
      case MemberType.student:
        return fee ~/ 2;
      case MemberType.faculty:
        return fee ~/ 4;
    }
  }
}

// ===== Step 7: Extension Methods =====
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) {
    return fold(0, (sum, item) => sum + item.lateFee(days));
  }
}

// ===== Step 1 =====
void step1() {
  print('--- Step 1 ---');

  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item.pages is unavailable through the LibraryItem reference.
}

// ===== Step 2 =====
void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // @override helps detect misspelled method names.
}

// ===== Step 3 =====
void step3() {
  print('--- Step 3 ---');

  Book book = mainBook();
  Magazine magazine = mainMagazine();
  Dvd dvd = mainDvd();

  print(
    'Step 3: Book late fee for $daysLate days = '
    '${book.lateFee(daysLate)}',
  );

  print(
    'Step 3: Magazine late fee for $daysLate days = '
    '${magazine.lateFee(daysLate)}',
  );

  print(
    'Step 3: Dvd late fee for $daysLate days = '
    '${dvd.lateFee(daysLate)}',
  );

  // LibraryItem cannot be instantiated because it is abstract.
}

// ===== Step 4 =====
void step4() {
  print('--- Step 4 ---');

  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? '
      '${item is Borrowable}',
    );
  }
}

// ===== Step 5 =====
void step5() {
  print('--- Step 5 ---');

  Book book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) ok++;
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts '
    '(limit $renewLimit)',
  );

  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Book and Dvd share the Renewable mixin.
}

// ===== Step 6 =====
void step6() {
  print('--- Step 6 ---');

  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);

  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print(
    'Step 6: book fee $fee -> '
    '${type.applyDiscount(fee)} after discount',
  );

  // Enum values are safer than strings because Dart checks valid values.
}

// ===== Step 7 =====
void step7() {
  print('--- Step 7 ---');

  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  int discountedFee = type.applyDiscount(fee);

  List<LibraryItem> shelf = [
    mainBook(),
    mainMagazine(),
    mainDvd(),
  ];

  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );

  // Extensions allow convenient syntax such as 72.rs
  // instead of calling a separate function like rs(72).
}

// ===== Steps 8–10: Awaiting Instructions =====
void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}

// ===== Main =====
void main() {
  print('Seed: $seed (t=$t, u=$u)');

  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}
