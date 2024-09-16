create table socio (
    codice_socio        char(9)             primary key,
    nome                varchar(30)         not null,
    cognome             varchar(30)         not null,
    data_nascita        date,
    codice_fiscale      char(16)            unique,
    via                 varchar(30),
    cap                 char(5),
    citta               varchar(30)
)

create table armadietto (
    numero_armadietto       char(2)         primary key,
    capacita                number
)

create table abbonamento (
    codice_abbonamento      char(9)         primary key,
    data_inizio_abb         date            not null,
    costo                   number,
    scadenza                date            not null,
    codice_socio_abb        char(9)         not null,
    numero_armadietto_abb   char(2)			not null,
    constraint fk_abbonamento1 foreign key (codice_socio_abb) references socio(codice_socio),
    constraint fk_abbonamento2 foreign key (numero_armadietto_abb) references armadietto(numero_armadietto)
)

create table attivita (
    codice_attivita     char(9)         primary key,
    nome_attivita       varchar(30)     not null,
    equip_richiesto     varchar(30)
)

create table interessa (
        codice_attivita_int     char(9)		not null,
        codice_socio_int        char(9)		not null,
        constraint pk_interessa primary key (codice_attivita_int, codice_socio_int),
        constraint fk_interessa1 foreign key (codice_attivita_int) references attivita(codice_attivita),
        constraint fk_interessa2 foreign key (codice_socio_int) references socio(codice_socio)
)

create table corso (
    nome_corso          varchar(30)         primary key,
    data_inizio_c       date                not null,
    data_fine_c         date                not null,        
    giorno              varchar(10)			not null,
    ora                 timestamp(0)		not null,
    istruttore_corso    varchar(30),
    costo               number
)

create table impianto (
    nome_impianto           varchar(30)         primary key,
    copertura               char(6)             check (copertura in ('aperto', 'chiuso', 'Aperto', 'Chiuso')),
    tipo                    varchar(30)         not null
)

create table prenotazione (
    data_pren          date				,
    ora_pren           timestamp(0)		,
    costo_pren         number			not null,
    codice_socio_pren  char(9)          not null,
	nome_impianto_pren varchar(30),
	nome_corso_pren	   varchar(30),
    constraint pk_prenotazione primary key (data_pren, ora_pren),
    constraint fk_prenotazione1 foreign key (codice_socio_pren) references socio(codice_socio),
	constraint fk_prenotazione2 foreign key (nome_impianto_pren) references impianto(nome_impianto),
	constraint fk_prenotazione3 foreign key (nome_corso_pren) references corso(nome_corso)
)

//per contratto possiamo intendere ad esempio: manutenzione preventiva, riparazioni, assistenza tecnica.

create table ditta_man (
    nome_ditta      varchar(30)     primary key,
    contratto       varchar(30)     
)

create table manutenzione (
    data_inizio_man         date		not null,
    data_fine_man           date		not null,
    costo                   number		not null,
    nome_impianto_man       varchar(30)         not null,
	nome_ditta_man			varchar(30)			not null,
    constraint pk_manutenzione primary key (data_inizio_man, data_fine_man),
    constraint fk_manutenzione1 foreign key (nome_impianto_man) references impianto(nome_impianto),
	constraint fk_manutenzione2 foreign key (nome_ditta_man) references ditta_man(nome_ditta)
)

create table evento (
    codice_evento		char(3)			primary key,
	nome_evento         varchar(30)		not null,
    data_evento         date			not null,
    ora_inizio_ev       timestamp(0)	not null,
    ora_fine_ev         timestamp(0)	not null,
    tipo_evento         varchar(30),
    numero_spett        number,
    nome_impianto_ev    varchar(30)     not null,
    constraint fk_evento foreign key (nome_impianto_ev) references impianto(nome_impianto)
)

create table sponsor (
    nome_sponsor        varchar(30)         primary key,
    settore_sponsor     varchar(30),
    anno_fondazione     number
)

create table sponsorizza (
    codice_evento_sp        char(3)			not null,
    nome_sponsor_sp         varchar(30)		not null,
	constraint pk_sponsorizza primary key (codice_evento_sp, nome_sponsor_sp),
    constraint fk_sponsorizza1 foreign key (codice_evento_sp) references evento(codice_evento),
    constraint fk_sponsorizza2 foreign key (nome_sponsor_sp) references sponsor(nome_sponsor)
)

create table turno (
  codice_turno   	char(6)   		primary key,
  orario_inizio_t	timestamp(0)	not null,
  orario_fine_t  	timestamp(0)	not null,
  tipo_t	     	varchar(30)		check (tipo_t in ('Mattina', 'Pomeriggio', 'Sera', 'mattina', 'pomeriggio', 'sera'))
)

create table personale (
    codice_imp      char(6)        	primary key,
    nome_imp        varchar(30)     not null,
    cognome_imp     varchar(30)     not null,
    via_imp         varchar(30),
    cap_imp         char(5),
    citta_imp       varchar(30),
    stipendio       number,
	codice_turno_p	char(6)			not null,
	constraint fk_personale foreign key (codice_turno_p) references turno(codice_turno)
)

create table istruttore (
	codice_imp_istr     char(6)		primary key,
    sport_praticato     varchar(30),
    eta_istruttore      char(2),
    nome_corso_istr     varchar(30)     not null,
    constraint fk_istruttore1 foreign key (codice_imp_istr) references personale(codice_imp),
    constraint fk_istruttore2 foreign key (nome_corso_istr) references corso(nome_corso)
)

create table medico (
	codice_imp_med          char(6)        primary key,
    specializzazione        varchar(30)    not null,
    anno_abilit             char(4),
    constraint fk_medico foreign key (codice_imp_med) references personale(codice_imp)
)

create table amministrativo (
    codice_imp_amm      char(6)        primary key,
    constraint fk_amministrativo foreign key (codice_imp_amm) references personale(codice_imp)
)

create table addetto_pulizie (
    codice_imp_add      char(6)        primary key,
    constraint fk_addetto foreign key (codice_imp_add) references personale(codice_imp)
)

create table addetto_bar (
	codice_imp_addbar   char(6)			primary key,
    ruolo               varchar(30)			not null,
    constraint fk_addetto_bar foreign key (codice_imp_addbar) references personale(codice_imp)
)

create table visita_medica (
	codice_visita			char(4)			primary key,
    esito                   varchar(30)		not null,
    data_visita             date			not null,
    codice_imp_med_vis		char(6)         not null,
	codice_socio_vis		char(9)			not null,
    constraint fk_visita1 foreign key (codice_imp_med_vis) references medico(codice_imp_med),
	constraint fk_visita2 foreign key (codice_socio_vis) references socio(codice_socio)
)

create table magazzino (
    codice_magazzino    char(1)     primary key,
    telefono            char(10)    unique,
    via_m               varchar(30),
    cap_m               char(5),
    citta_m             varchar(30)
)

create table bar (
    nome_bar                varchar(30)     primary key,
    orario_apertura         timestamp(0)    not null,
    orario_chiusura         timestamp(0)    not null,
    codice_magazzino_bar    char(1)         not null,
    constraint fk_bar2 foreign key (codice_magazzino_bar) references magazzino(codice_magazzino)
)

create table lavora (
	codice_imp_addbar_lavora	char(6)			not null,
	nome_bar_lavora				varchar(30)		not null,
	constraint pk_lavora primary key (codice_imp_addbar_lavora, nome_bar_lavora),
	constraint fk_lavora1 foreign key (codice_imp_addbar_lavora) references addetto_bar(codice_imp_addbar),
	constraint fk_lavora2 foreign key (nome_bar_lavora) references bar(nome_bar)
)

 create table assegna (
	data_assegnazione      			date,
	scadenza_assegnazione   		date,
	stato                   		varchar(30) check (stato in ('Non Disponibile', 'non disponibile', 'Disponibile', 'disponibile')),
	numero_armadietto_assegna       char(2),
	codice_abbonamento_assegna     	char(9),
	constraint pk_assegna  primary key (data_assegnazione, scadenza_assegnazione),
	constraint fk_assegna1 foreign key (numero_armadietto_assegna) references armadietto(numero_armadietto),
	constraint fk_assegna2 foreign key (codice_abbonamento_assegna) references abbonamento(codice_abbonamento)
)