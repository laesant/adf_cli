import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();
  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }
  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  @override
  FutureOr? run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informe o id do aluno com o comando --id=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando dados do aluno...');
    print('-------------------------------------------');

    if (students.length > 1) {
      print('Por favor informe somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor informe um aluno no arquivo $filePath');
      return;
    }
    var student = students.first;

    final data = student.split(';');
    final courseCsv = data[2].split(',').map((e) => e.trim()).toList();
    final coursesFutures = courseCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();
    final courses = await Future.wait(coursesFutures);
    final studentModel = Student(
      id: int.parse(id),
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

    await studentRepository.update(studentModel);

    print('Aluno atualizado com sucesso!');
    print('-------------------------------------------');
  }
}
