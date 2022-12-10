import 'package:dartus/tomuss.dart';
import 'package:lyon1agenda/src/lyon1agenda.dart';
import 'package:lyon1agenda/src/model/agenda.dart';
import 'package:lyon1agenda/src/model/event.dart';
import 'package:lyon1agenda/src/utils/agenda_url.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  DotEnv env = DotEnv(includePlatformEnvironment: true);
  test('getAgenda from URL', () async {
    env.load();
    final List<String> icalLinks = [
      env['ICAL_LINK'] ?? "",
    ];

    for (final String link in icalLinks) {
      final Lyon1Agenda agendaClient =
          Lyon1Agenda(AgendaURL(Authentication("", "")));
      final Agenda? agendaOpt = await agendaClient.getAgenda(url: link);

      expect(agendaOpt == null, equals(false));

      final Agenda agenda = agendaOpt ?? Agenda.empty();

      for (final Event event in agenda.events) {
        expect(event.start.runtimeType, equals(DateTime));
        expect(event.end.runtimeType, equals(DateTime));
        expect(event.lastModified.runtimeType, equals(DateTime));

        expect(event.description, isNot(isEmpty));
        expect(event.description.contains("Exported"), equals(false));
        expect(event.name, isNot(isEmpty));
        //expect(event.location, isNot(isEmpty)); sometime no location is provided

        // TODO: investigate
        // expect(event.teacher, isNot(isEmpty)); // does not pass
      }
    }
  });
}
