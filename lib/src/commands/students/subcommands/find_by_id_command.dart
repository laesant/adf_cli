import 'dart:async';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentRepository repository;

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }
  @override
  String get description => 'Find Student By Id';

  @override
  String get name => 'byId';

  @override
  FutureOr? run() async {
    final id = int.tryParse(argResults?['id'] ?? '');
    if (id == null) {
      print('Por favor envie o id do aluno com o comando --id=0 ou -i 0');
      return;
    }

    print('Aguarde buscando dados...');
    final student = await repository.findById(id);
    print('----------------------------------');
    print('Aluno ${student.name}:');
    print('----------------------------------');
    print('Nome: ${student.name}');
    print('Idade: ${student.age ?? 'Não informado'}');
    print('Cursos:');
    student.nameCourses.forEach(print);
    print('Endereço:');
    print(
        '   ${student.address.street}, ${student.address.number} (${student.address.zipCode})');
  }
}
