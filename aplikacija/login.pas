unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts;

type
  TformLogin = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    top: TLayout;
    client: TLayout;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Layout1: TLayout;
    Text4: TText;
    Layout2: TLayout;
    editEmail: TEdit;
    editSifra: TEdit;
    buttonLogin: TButton;
    buttonRegister: TButton;
    procedure buttonLoginClick(Sender: TObject);
    procedure buttonRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formLogin: TformLogin;

implementation

uses dm,meni,register;

{$R *.fmx}

procedure TformLogin.buttonLoginClick(Sender: TObject);
  var
    pwd: string;
  begin
    if Trim(editEmail.Text) = '' then
    begin
      Showmessage('Molimo unesite email!');
      editEmail.SetFocus;
    end
    else if Trim(editSifra.Text) = '' then
    begin
      Showmessage('Molimo unesite sifru!');
      editSifra.SetFocus;
    end
    else
    begin
      // Validacija
      with db do
      begin
        dbAutodelovi.Open;
        qtemp.SQL.Clear;
        qtemp.SQL.Text := 'SELECT * FROM korisnici WHERE email=' + QuotedStr(editEmail.Text);
        qtemp.Open;
        if qtemp.RecordCount = 0 then
        begin
          ShowMessage('Email ne postoji!');
          editEmail.SetFocus;
        end
        else
        begin
          pwd := qtemp.FieldByName('sifra').AsString;
          if pwd = editSifra.Text then
          begin

            formLogin.Hide;
            formMeni.Show;
          end
          else
          begin
            ShowMessage('Pogresna sifra!');
            editSifra.SetFocus;
          end;
        end;
      end;
    end;
  end;
procedure TformLogin.buttonRegisterClick(Sender: TObject);
begin
    formLogin.hide;
    formRegister.show;
end;

end.
