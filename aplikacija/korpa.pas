unit korpa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Generics.Collections, FMX.Objects, FMX.Layouts;

type
  TArtikalUKorpi = record
    Brend: string;
    Ime: string;
    Cena: Currency;
    JedinicaMere: string;
    Kolicina: Integer;
  end;

  TformKorpa = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    buttonNaruciPosiljku: TButton;
    top: TLayout;
    buttonNazad: TButton;
    Text1: TText;
    Image1: TImage;
    client: TLayout;
    izabraniArtikalText: TText;
    buttonIzaberiJos: TButton;
    CenaText: TText;
    procedure ButtonPrikaziKorpuClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonNaruciPosiljkuClick(Sender: TObject);
    procedure buttonPovecajKolicinuClick(Sender: TObject); // Nova metoda
    procedure buttonSmanjiKolicinuClick(Sender: TObject);  // Nova metoda
  private
    FItems: TList<TArtikalUKorpi>;
    FSelectedItemIndex: Integer; // Indeks izabranog artikla
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DodajUKorpu(const Artikal: TArtikalUKorpi);
    procedure PrikaziKorpu;
  end;

var
  formKorpa: TformKorpa;

implementation

uses nalog, dm, login, meni;

{$R *.fmx}

constructor TformKorpa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList<TArtikalUKorpi>.Create;
  FSelectedItemIndex := -1; // Početno nema izabranog artikla
end;

destructor TformKorpa.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TformKorpa.DodajUKorpu(const Artikal: TArtikalUKorpi);
begin
  FItems.Add(Artikal);
  FSelectedItemIndex := FItems.Count - 1; // Postavi zadnji dodat artikal kao izabrani
end;

procedure TformKorpa.Image1Click(Sender: TObject);
begin
  formKorpa.Hide;
  formNalog.Show;
end;

procedure TformKorpa.PrikaziKorpu;
var
  Artikal: TArtikalUKorpi;
  Total: Currency;
  ArtikliList: TStringList;
begin
  Total := 0;
  ArtikliList := TStringList.Create;
  try
    for Artikal in FItems do
    begin
      Total := Total + (Artikal.Cena * Artikal.Kolicina);
      ArtikliList.Add(Format('%s - %s: %m %s x %d', [Artikal.Brend, Artikal.Ime, Artikal.Cena, Artikal.JedinicaMere, Artikal.Kolicina]));
    end;
    izabraniArtikalText.Text := ArtikliList.Text;
    CenaText.Text := 'Ukupna cena: ' + CurrToStr(Total);
  finally
    ArtikliList.Free;
  end;
end;

procedure TformKorpa.buttonNaruciPosiljkuClick(Sender: TObject);
var
  Artikal: TArtikalUKorpi;
  Total: Currency;
begin
  Total := 0;

  for Artikal in FItems do
  begin
    Total := Total + (Artikal.Cena * Artikal.Kolicina);

    with db.qtemp do
    begin
      SQL.Text := 'INSERT INTO posiljke (email, brend, ime, cena, jedinica_mere, kolicina, ukupna_cena) ' +
                  'VALUES (:email, :brend, :ime, :cena, :jedinica_mere, :kolicina, :ukupna_cena)';
      ParamByName('email').AsString := formLogin.editEmail.Text;
      ParamByName('brend').AsString := Artikal.Brend;
      ParamByName('ime').AsString := Artikal.Ime;
      ParamByName('cena').AsFloat := Artikal.Cena;
      ParamByName('jedinica_mere').AsString := Artikal.JedinicaMere;
      ParamByName('kolicina').AsInteger := Artikal.Kolicina;
      ParamByName('ukupna_cena').AsFloat := Artikal.Cena * Artikal.Kolicina;
      ExecSQL;
    end;
  end;

  ShowMessage('Vaša narudžba je uspešno kreirana!');
  FItems.Clear;
  formKorpa.Hide;
  formMeni.Show;
end;

procedure TformKorpa.buttonNazadClick(Sender: TObject);
begin
  formKorpa.Hide;
  formMeni.Show;
end;

procedure TformKorpa.ButtonPrikaziKorpuClick(Sender: TObject);
begin
  PrikaziKorpu;
end;

procedure TformKorpa.buttonPovecajKolicinuClick(Sender: TObject);
var
  Artikal: TArtikalUKorpi;
begin
  if (FSelectedItemIndex >= 0) and (FSelectedItemIndex < FItems.Count) then
  begin
    Artikal := FItems[FSelectedItemIndex];
    Artikal.Kolicina := Artikal.Kolicina + 1;
    FItems[FSelectedItemIndex] := Artikal;
    PrikaziKorpu;
  end;
end;

procedure TformKorpa.buttonSmanjiKolicinuClick(Sender: TObject);
var
  Artikal: TArtikalUKorpi;
begin
  if (FSelectedItemIndex >= 0) and (FSelectedItemIndex < FItems.Count) then
  begin
    Artikal := FItems[FSelectedItemIndex];
    if Artikal.Kolicina > 1 then
    begin
      Artikal.Kolicina := Artikal.Kolicina - 1;
      FItems[FSelectedItemIndex] := Artikal;
      PrikaziKorpu;
    end;
  end;
end;


end.

