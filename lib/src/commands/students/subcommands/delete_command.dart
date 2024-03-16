import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository repository;

  DeleteCommand(this.repository) {
    argParser.addOption('id', help: 'The id of the student', abbr: 'i');
  }

  @override
  String get description => 'Delete Student by ID';

  @override
  String get name => 'delete';
  @override
  FutureOr? run() async {
    final id = int.tryParse(argResults?['id'] ?? '');
    if (id == null) {
      print('Por favor envie o id do aluno com o comando --id=0 ou -i 0');
      return;
    }
    print('Carregando...');
    final student = await repository.findById(id);
    print('Confirmar exclusão do aluno ${student.name}? (S ou N)');
    final showCourses = stdin.readLineSync();
    if (showCourses?.toLowerCase() == 's') {
      print('Aguarde excluindo aluno...');
      print('-------------------------------------------');
      try {
        await repository.deleteById(id);
        print('Aluno excluido com sucesso!');
      } on Exception catch (_) {
        print('Ocorreu um erro ao tentar excluir o aluno!');
      } finally {
        print('-------------------------------------------');
      }
    } else {
      print('-------------------------------------------');
      print('Operação cancelada!');
      print('-------------------------------------------');
    }
  }
}
