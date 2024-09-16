-- 1) Procedura che permette di creare un nuovo evento

create or replace procedure CreaEvento(
    codice_evento_in     char,
    nome_evento_in       varchar,
    data_evento_in       date,
    ora_inizio_ev_in     timestamp,
    ora_fine_ev_in       timestamp,
    tipo_evento_in       varchar,
    numero_spett_in      number,
    nome_impianto_ev_in  varchar
) is
begin
    insert into evento (codice_evento, nome_evento, data_evento, ora_inizio_ev, ora_fine_ev, tipo_evento, numero_spett, nome_impianto_ev) values (codice_evento_in, nome_evento_in, data_evento_in, ora_inizio_ev_in, ora_fine_ev_in, tipo_evento_in, numero_spett_in, nome_impianto_ev_in);
    dbms_output.put_line('Evento creato con successo.');
exception
    when others then
        dbms_output.put_line('Errore durante la creazione dell''evento: ' || '20020');
end;

-- 2) Procedura che permette di aggiornare i turni del personale

create or replace procedure AggiornaTurno(
    codice_turno_in      char,
    orario_inizio_t_in   timestamp,
    orario_fine_t_in     timestamp,
    tipo_t_in            varchar
) is
begin
    update turno
    set orario_inizio_t = orario_inizio_t_in,
        orario_fine_t = orario_fine_t_in,
        tipo_t = tipo_t_in
    where codice_turno = codice_turno_in;
     dbms_output.put_line('Turno aggiornato con successo.');
exception
    when no_data_found then
         dbms_output.put_line('Nessun turno trovato con il codice specificato.');
    when others then
         dbms_output.put_line('Errore durante l''aggiornamento del turno: ' || '20021');
end;

-- 3) Procedura che permette di aggiungere un nuovo corso ed assegnare il suo istruttore

create or replace procedure aggiungi_corso(
    p_nome_corso corso.nome_corso%type,
    p_data_inizio_c corso.data_inizio_c%type,
    p_data_fine_c corso.data_fine_c%type,
    p_giorno corso.giorno%type,
    p_ora corso.ora%type,
    p_istruttore_corso istruttore.codice_imp_istr%type,
    p_costo corso.costo%type
) is
begin
    -- Inserisci il nuovo corso
    insert into corso(nome_corso, data_inizio_c, data_fine_c, giorno, ora, istruttore_corso, costo) values (p_nome_corso, p_data_inizio_c, p_data_fine_c, p_giorno, p_ora, p_istruttore_corso, p_costo);
    
    -- Aggiorna l'istruttore con il nuovo corso
    update istruttore
    set nome_corso_istr = p_nome_corso
    where codice_imp_istr = p_istruttore_corso;
    
    commit;
    
     dbms_output.put_line('Nuovo corso aggiunto con successo.');
exception
    when others then
        rollback;
         dbms_output.put_line('Errore durante l''aggiunta del corso: ' || '20022');
end;

-- 4) Procedura che permette di cancellare una prenotazione

create or replace procedure cancella_prenotazione(
    data_prenotazione date,
    ora_prenotazione timestamp
)is
begin
    delete from prenotazione
    where data_pren = data_prenotazione and ora_pren = ora_prenotazione;
    if SQL%rowcount = 0 then
         dbms_output.put_line('Nessuna prenotazione trovata con il codice specificato, data e ora.');
    else
         dbms_output.put_line('Prenotazione cancellata con successo.');
    end if;
exception
    when others then
         dbms_output.put_line('Si è verificato un errore durante la cancellazione della prenotazione: ' || '20023');
end;

-- 5) PROCEDURA che aggiorna le prenotazioni

create or replace procedure aggiorna_prenotazione(
    data_pren date,
    ora_pren timestamp,
    nuovo_costo_pren number,
    nuovo_nome_impianto_pren varchar,
    nuovo_nome_corso_pren varchar
)is
begin
    update prenotazione
    set costo_pren = nuovo_costo_pren,
        nome_impianto_pren = nuovo_nome_impianto_pren,
        nome_corso_pren = nuovo_nome_corso_pren
    where data_pren = data_pren and ora_pren = ora_pren;

    if SQL%rowcount= 0 then
         dbms_output.put_line('Nessuna prenotazione trovata con la data e l''ora specificate.');
    else
         dbms_output.put_line('Prenotazione aggiornata con successo.');
    end if;
exception
    when others then
         dbms_output.put_line('Si è verificato un errore durante l''aggiornamento della prenotazione: ' || '20024');
end;

-- 6) Procedura che permette di aggiungere una nuova ditta di manutenzione

create or replace procedure aggiungi_ditta_manutenzione(
    v_nome_ditta varchar,
    v_contratto varchar
) is
begin
    insert into ditta_man (nome_ditta, contratto) values (v_nome_ditta, v_contratto);
     dbms_output.put_line('Nuova ditta di manutenzione aggiunta con successo.');
    commit;
exception
    when others then
         dbms_output.put_line('Si è verificato un errore durante l''aggiunta della ditta di manutenzione: ' || '20025');
        rollback;
end;