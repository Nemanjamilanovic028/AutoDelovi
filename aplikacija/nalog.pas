unit nalog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformNalog = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    buttonNaruciPosiljku: TButton;
    top: TLayout;
    buttonNazad: TButton;
    Text1: TText;
    Image1: TImage;
    client: TLayout;
    textIme: TText;
    textPrezime: TText;
    textSifra: TText;
    textEmail: TText;
    buttonPrikazi: TButton;
    procedure buttonNaruciPosiljkuClick(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonPrikaziClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNalog: TformNalog;

implementation

uses login, meni;

{$R *.fmx}

procedure TformNalog.buttonPrikaziClick(Sender: TObject);
begin
  // Ova procedura samo osigurava da su podaci prikazani, podaci su već prebačeni tokom logovanja
  ShowMessage('Prikazani podaci korisnika.');
end;

procedure TformNalog.buttonNaruciPosiljkuClick(Sender: TObject);
begin
  formNalog.Hide;
  formLogin.Show;
end;

procedure TformNalog.buttonNazadClick(Sender: TObject);
begin
  formNalog.Hide;
  formMeni.Show;
end;

end.

