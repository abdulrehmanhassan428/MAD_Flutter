
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

// ===== Step 1: Classes and extends =====

class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  // Step 2.1: Parent method
  String describe() => '$title ($year)';
}

class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);

  // Step 2.2: Override parent method
  @override
  String describe() => '${super.describe()}, $pages pages';
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// ===== Step 2.3: Magazine class =====

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;

  return Magazine(
    titles[i],
    yearOf(i),
    1 + (t + u) % 12,
  );
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

// ===== Step 1 =====

void step1() {
  print('--- Step 1 ---');

  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item.pages is a compile error because LibraryItem
  // does not declare a pages field, even though the object is a Book.
}

// ===== Step 2 =====

void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // If @override is forgotten and describe is misspelled as
  // descibe(), Dart treats it as a different method. The inherited
  // describe() remains unchanged, so the custom output is not used.
}

// ===== Remaining steps =====

void step3() {
  print('--- Step 3 ---');
}

void step4() {
  print('--- Step 4 ---');
}

void step5() {
  print('--- Step 5 ---');
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
