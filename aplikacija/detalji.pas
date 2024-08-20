unit detalji;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts, korpa;

type
  TformDetalji = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    buttonDodajUKorpu: TButton;
    top: TLayout;
    buttonNazad: TButton;
    Text1: TText;
    Image1: TImage;
    client: TLayout;
    Rectangle2: TRectangle;
    buttonAkumulatori: TButton;
    buttonGume: TButton;
    labelBrend: TLabel;
    labelIme: TLabel;
    labelCena: TLabel;
    labelJedinica: TLabel;
    labelStatus: TLabel;
    labelRok: TLabel;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonDodajUKorpuClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrikaziDetalje(const Brend, Ime, Cena, Jedinica, Status, rokIsporuke: string);
  end;

var
  formDetalji: TformDetalji;

implementation

uses meni, nalog;

{$R *.fmx}

procedure TformDetalji.buttonDodajUKorpuClick(Sender: TObject);
var
  Artikal: TArtikalUKorpi;
  CenaStr: string;
begin
  Artikal.Brend := LabelBrend.Text;
  Artikal.Ime := LabelIme.Text;

  CenaStr := StringReplace(LabelCena.Text, 'Cena: ', '', [rfReplaceAll]);
  Artikal.Cena := StrToCurr(CenaStr);

  Artikal.JedinicaMere := LabelJedinica.Text;
  Artikal.Kolicina := 1;

  // Dodajemo artikal u korpu koristeći metodu forme `korpa`
  if Assigned(formKorpa) then
  begin
    formKorpa.DodajUKorpu(Artikal);
    formKorpa.PrikaziKorpu;  // Prikazujemo korpu sa artiklom
    formKorpa.Show;  // Prikazujemo formu `korpa`
    formDetalji.Hide;  // Skrivamo trenutnu formu
  end;
end;

procedure TformDetalji.buttonNazadClick(Sender: TObject);
begin
  formDetalji.Hide;
  formMeni.show;
end;

procedure TformDetalji.Image1Click(Sender: TObject);
begin
    formDetalji.hide;
    formNalog.show;
end;

procedure TformDetalji.PrikaziDetalje(const Brend, Ime, Cena, Jedinica, Status, rokIsporuke: string);
begin
  LabelBrend.Text := 'Brend: ' + Brend;
  LabelIme.Text := 'Akumulator: ' + Ime;
  LabelCena.Text := 'Cena: ' + Cena;
  LabelJedinica.Text := 'Jedinica mere: ' + Jedinica;
  LabelStatus.Text := 'Status: ' + Status;
  LabelRok.Text := 'Rok Isporuke: ' + rokIsporuke;
end;

end.

