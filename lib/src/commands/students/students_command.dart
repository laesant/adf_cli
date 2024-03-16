import 'package:args/command_runner.dart';

import '../../repositories/student_repository.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand() {
    final repository = StudentRepository();
    addSubcommand(FindAllCommand(repository));
    addSubcommand(FindByIdCommand(repository));
  }
}
