-- Creazione degli utenti

CREATE USER db_parthenope IDENTIFIED BY admin;         
CREATE USER socio IDENTIFIED BY SocioPass123;
CREATE USER istruttore IDENTIFIED BY IstPass123;
CREATE USER addetto_bar IDENTIFIED BY AddbPass123;
CREATE USER medico IDENTIFIED BY MedPass123;
CREATE USER addetto_pulizie IDENTIFIED BY AddPPass123;
CREATE USER impiegato_amministrativo IDENTIFIED BY AmmPass123;
CREATE USER ditta_manutenzione IDENTIFIED BY DittaManPass123;
CREATE USER responsabile_turni IDENTIFIED BY RespTurPass123;
CREATE USER sponsors IDENTIFIED BY SponsorsPass123;
CREATE USER organizzatore_evento IDENTIFIED BY OrgEvPass123;


-- Assegnazione dei privilegi agli utenti

GRANT All PRIVILEGES TO db_parthenope;
GRANT CONNECT, RESOURCE, DBA to db_parthenope;

GRANT CREATE SESSION TO socio;
GRANT SELECT ON armadietto to socio;
GRANT SELECT ON abbonamento to socio;
GRANT SELECT ON prenotazione to socio;


GRANT CREATE SESSION TO istruttore;
GRANT SELECT, INSERT, UPDATE, DELETE ON corso to istruttore;
GRANT SELECT ON turno to istruttore;

GRANT CREATE SESSION TO addetto_bar;
GRANT SELECT ON bar to addetto_bar;
GRANT SELECT ON magazzino to addetto_bar;
GRANT SELECT ON turno to addetto_bar;

GRANT CREATE SESSION TO medico;
GRANT SELECT, INSERT, UPDATE, DELETE ON visita_medica to medico;
GRANT SELECT ON turno to medico;

GRANT CREATE SESSION TO addetto_pulizie;
GRANT SELECT ON bar to addetto_pulizie;
GRANT SELECT ON impianto to addetto_pulizie;
GRANT SELECT ON turno to addetto_pulizie;

GRANT CREATE SESSION TO impiegato_amministrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON prenotazione to impiegato_amministrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON turno to impiegato_amministrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON corso to impiegato_amministrativo;
GRANT EXECUTE ON aggiungi_ditta_manutenzione to impiegato_amministrativo;
GRANT EXECUTE ON aggiungi_corso to impiegato_amministrativo;
GRANT EXECUTE ON aggiorna_prenotazione to impiegato_amministrativo;
GRANT EXECUTE ON cancella_prenotazione to impiegato_amministrativo;


GRANT CREATE SESSION TO ditta_manutenzione;
GRANT SELECT ON ditta_man to ditta_manutenzione;
GRANT SELECT ON manutenzione to ditta_manutenzione;

GRANT CREATE SESSION TO responsabile_turni;
GRANT SELECT, INSERT, UPDATE, DELETE ON turno to responsabile_turni;
GRANT EXECUTE ON AggiornaTurno to responsabile_turni;


GRANT CREATE SESSION TO organizzatore_evento;
GRANT SELECT, INSERT, UPDATE, DELETE ON evento to organizzatore_evento;
GRANT SELECT ON impianto to organizzatore_evento;
GRANT SELECT ON sponsor to organizzatore;
GRANT EXECUTE ON CreaEvento  to organizzatore_evento;

GRANT CREATE SESSION TO sponsors;
GRANT SELECT sponsor to sponsors;
GRANT SELECT ON impianto to sponsors;
GRANT SELECT ON sponsor to sponsors;