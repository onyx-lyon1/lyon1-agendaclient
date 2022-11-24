import 'package:dartus/tomuss.dart';
import 'package:lyon1agenda/lyon1agenda.dart';

void main() async {
  final Lyon1Agenda agendaClient = Lyon1Agenda.useAuthentication(
      Authentication("p1234567", "a_valid_password"));
  final Agenda? agendaOpt = await agendaClient.getAgenda();
  if (agendaOpt == null) {
    // handle gracefully
  }
  final Agenda agenda = agendaOpt ?? Agenda.empty();

  for (final Event e in agenda.events) {
    print(e.name);
    print("\t${e.location} | ${e.teacher}");
    print("\t${e.start.toString()} -> ${e.end.toString()}");
  }
}
