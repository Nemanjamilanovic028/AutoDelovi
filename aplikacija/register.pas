unit register;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformRegister = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    buttonLogin: TButton;
    top: TLayout;
    Text1: TText;
    client: TLayout;
    Text2: TText;
    Text3: TText;
    Layout1: TLayout;
    editIme: TEdit;
    Text4: TText;
    Layout2: TLayout;
    editPrezime: TEdit;
    buttonRegister: TButton;
    Layout3: TLayout;
    editEmail: TEdit;
    Layout4: TLayout;
    editSifra: TEdit;
    Text5: TText;
    Text6: TText;
    procedure buttonLoginClick(Sender: TObject);
    procedure buttonRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRegister: TformRegister;

implementation

uses login, dm;

{$R *.fmx}

procedure TformRegister.buttonLoginClick(Sender: TObject);
var
  sifra, ime, prezime, email: string;
begin
  //provera da li su podaci uneti
  if Trim(editSifra.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite sifru!');
    editSifra.SetFocus;
    Exit;
  end;
  if Trim(editEmail.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite email!');
    editEmail.SetFocus;
    Exit;
  end;
  if Trim(editIme.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite ime!');
    editIme.SetFocus;
    Exit;
  end;
  if Trim(editPrezime.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite prezime!');
    editPrezime.SetFocus;
    Exit;
  end;

  // Dohvaćanje unesenih podataka
  sifra := editSifra.Text;
  ime := editime.Text;
  prezime := editPrezime.Text;
  email := editemail.Text;

  with db do
  begin
    qtemp.SQL.Clear;
    qtemp.SQL.Text := 'SELECT * FROM korisnici WHERE email = :email';
    qtemp.ParamByName('email').AsString := email;
    qtemp.Open;

    if qtemp.Fields[0].AsInteger > 0 then
    begin
      ShowMessage('Email adresa već postoji. Molimo izaberite drugu.');
      qtemp.Close;
      Exit;
    end;

    qtemp.SQL.Clear;
    qtemp.SQL.Text := 'INSERT INTO korisnici (ime, prezime, sifra, email) ' +
                      'VALUES (:ime, :prezime , :sifra, :email)';
    qtemp.Params.ParamByName('ime').AsString := ime;
    qtemp.Params.ParamByName('prezime').AsString := prezime;
    qtemp.Params.ParamByName('sifra').AsString := sifra;
    qtemp.Params.ParamByName('email').AsString := email;
    qtemp.ExecSQL;

    ShowMessage('Uspešno ste se registrovali!');

    formRegister.Hide;
    formLogin.Show;
  end;
end;

procedure TformRegister.buttonRegisterClick(Sender: TObject);
begin
    formRegister.hide;
    formLogin.show;
end;

end.
