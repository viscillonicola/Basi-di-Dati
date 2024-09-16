-- 1) Trigger per controllare che un socio non possa avere più di un abbonamento attivo alla volta

create or replace trigger controllo_abbonamenti_attivi
before insert on abbonamento
for each row
declare
    abbonamenti_attivi number;
begin
    select count(*)
    into abbonamenti_attivi
    from abbonamento
    where codice_socio_abb = :new.codice_socio_abb and scadenza >= sysdate;

    if abbonamenti_attivi > 0 then
        raise_application_error(-20001, 'Il socio ha già un abbonamento attivo.');
    end if;
end;


-- 2) Controllare se il numero dei soci superi il numero di armadietti disponibili

create or replace trigger controllo_numero_soci_armadietti
before insert or update on socio
for each row
declare
    num_soci number;
    num_armadietti number;
begin   
    select count(*) into num_soci
    from socio;
    
    select count(*) into num_armadietti
    from armadietto;
    
    if num_soci > num_armadietti then
        raise_application_error(-20002, 'Il numero di soci supera il numero di armadietti disponibili.');
    end if;
end;

-- 3) Controllo se il tipo di impianto corrisponde ad un tipo inserito

create or replace trigger controllo_tipo_impianto
before insert or update on impianto
for each row
begin
    if lower(:new.tipo) not in('tennis', 'calcio', 'pallavolo', 'basket', 'padel', 'boxe') then
        raise_application_error(-20003, 'Il tipo di impianto specificato non è valido. I tipi validi sono: tennis, calcio, pallavolo, basket, padel e boxe.');
    end if;
end;


-- 4) Controllo i tipi di contratto

create or replace trigger controllo_contratto_ditta_man
before insert or update on ditta_man
for each row
begin
    if lower(:new.contratto) not in ('manutenzione preventiva', 'riparazione', 'assistenza tecnica') then
        raise_application_error(-20004, 'Il tipo di contratto specificato non è valido. I tipi validi sono: manutenzione preventiva, riparazione, assistenza tecnica.');
    end if;
end;


-- 5) Controllo sport praticato 

create or update trigger controllo_sport_praticato
before insert or update on istruttore
for each row
begin
    if lower(:new.sport_praticato) not in ('fitness', 'nuoto', 'arti marziali', 'basket', 'calcio', 'tennis', 'padel', 'pallavolo', 'danza') then
        raise_application_error(-20005, 'Lo sport praticato specificato non è valido. Gli sport validi sono: fitness, nuoto, arti marziali, basket, calcio, tennis, padel, pallavolo, danza.');
    end if;
end;


-- 6) Trigger per verificare che la data di inizio di un corso sia precedente alla data di fine

create or replace trigger controllo_date_corso
before insert or update on corso
for each row
begin
    if :new.data_inizio_c >= :new.data_fine_c then
        raise_application_error(-20006, 'La data di inizio deve essere precedente alla data di fine del corso.');
    end if;
end;


-- 7) Trigger per controllare che un socio non possa avere più di una visita medica al giorno

create or replace trigger controllo_visite_mediche_giornaliere
before insert on visita_medica
for each row
declare
    visite_giornaliere number;
begin
    select count(*)
    into visite_giornaliere
    from visita_medica
    where codice_socio_vis = :new.codice_socio_vis and data_visita = :new.data_visita;

    if visite_giornaliere > 0 then
        raise_application_error(-20007, 'Il socio ha già effettuato una visita medica in questa data.');
    end if;
end;



-- 8)  Trigger per verificare che la data di inizio della manutenzione sia precedente alla data di fine

create or replace trigger controllo_data_manutenzione
before insert or update on manutenzione
for each row
begin
    if :new.data_inizio_man >= :new.data_fine_man then
        raise_application_error(-20009, 'La data di inizio della manutenzione deve essere precedente alla data di fine.');
    end if;
end;


-- 9) Trigger per verificare che la data di inizio dell'abbonamento sia precedente alla scadenza:

create or replace trigger controllo_data_abbonamento
before insert or update on abbonamento
for each row
begin
    if :new.data_inizio_abb >= :new.scadenza then
        raise_application_error(-20010, 'La data di inizio dell''abbonamento deve essere precedente alla data di scadenza.');
    end if;
end;
