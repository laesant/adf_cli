import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_dio_repository.dart';
import '../../../repositories/student_dio_repository.dart';

class InsertCommand extends Command {
  final StudentDioRepository studentRepository;
  final ProductDioRepository productRepository;

  InsertCommand(this.studentRepository)
      : productRepository = ProductDioRepository() {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  @override
  FutureOr? run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('-------------------------------------------');
    for (var student in students) {
      final data = student.split(';');
      final courseCsv = data[2].split(',').map((e) => e.trim()).toList();
      final coursesFutures = courseCsv.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();
      final courses = await Future.wait(coursesFutures);
      final studentModel = Student(
        name: data[0],
        age: int.tryParse(data[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: data[3],
          number: int.parse(data[4]),
          zipCode: data[5],
          city: City(id: 1, name: data[6]),
          phone: Phone(ddd: int.parse(data[7]), phone: data[8]),
        ),
      );

      await studentRepository.insert(studentModel);
    }
    print('Alunos adicionados com sucesso!');
    print('-------------------------------------------');
  }
}
