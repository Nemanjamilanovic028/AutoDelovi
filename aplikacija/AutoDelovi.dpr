program AutoDelovi;

uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {formLogin},
  dm in 'dm.pas' {db},
  meni in 'meni.pas' {formMeni},
  register in 'register.pas' {formRegister};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(Tdb, db);
  Application.CreateForm(TformMeni, formMeni);
  Application.CreateForm(TformRegister, formRegister);
  Application.Run;
end.
