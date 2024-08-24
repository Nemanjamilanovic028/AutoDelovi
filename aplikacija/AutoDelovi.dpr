program AutoDelovi;

uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {formLogin},
  dm in 'dm.pas' {db},
  meni in 'meni.pas' {formMeni},
  register in 'register.pas' {formRegister},
  meni2 in 'meni2.pas' {formMeni2},
  detalji in 'detalji.pas' {formDetalji},
  korpa in 'korpa.pas' {formKorpa},
  nalog in 'nalog.pas' {formNalog},
  meni3 in 'meni3.pas' {formMeni3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(Tdb, db);
  Application.CreateForm(TformMeni, formMeni);
  Application.CreateForm(TformRegister, formRegister);
  Application.CreateForm(TformMeni2, formMeni2);
  Application.CreateForm(TformDetalji, formDetalji);
  Application.CreateForm(TformKorpa, formKorpa);
  Application.CreateForm(TformNalog, formNalog);
  Application.CreateForm(TformMeni3, formMeni3);
  Application.Run;
end.
