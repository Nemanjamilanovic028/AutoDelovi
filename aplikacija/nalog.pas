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
    procedure buttonNaruciPosiljkuClick(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNalog: TformNalog;

implementation

uses login, dm, meni;

{$R *.fmx}

procedure TformNalog.buttonNaruciPosiljkuClick(Sender: TObject);
begin
formNalog.hide;
formlogin.show;
end;

procedure TformNalog.buttonNazadClick(Sender: TObject);
begin
    formNalog.hide;
    formMeni.show;
end;

end.
