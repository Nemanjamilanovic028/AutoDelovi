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
  private
    FItems: TList<TArtikalUKorpi>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DodajUKorpu(const Artikal: TArtikalUKorpi);
    procedure PrikaziKorpu;
  end;

var
  formKorpa: TformKorpa;

implementation

uses nalog, meni,dm, login, meni;

{$R *.fmx}

constructor TformKorpa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList<TArtikalUKorpi>.Create;
end;

destructor TformKorpa.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TformKorpa.DodajUKorpu(const Artikal: TArtikalUKorpi);
begin
  FItems.Add(Artikal);
end;

procedure TformKorpa.Image1Click(Sender: TObject);
begin
    formKorpa.hide;
    formNalog.show;
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
    // Ovde postavljamo tekstove za prikazivanje u formi `korpa`
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
  Email: string;
begin
  Total := 0;

  // Prolazak kroz sve artikle u korpi i računanje ukupne cene
  for Artikal in FItems do
  begin
    Total := Total + (Artikal.Cena * Artikal.Kolicina);

    // Ubacivanje svakog artikla u tabelu "posiljke"
    with db.qtemp do
    begin
      SQL.Text := 'INSERT INTO posiljke (email, brend, ime, cena, jedinica_mere, kolicina, ukupna_cena) ' +
                  'VALUES (:email, :brend, :ime, :cena, :jedinica_mere, :kolicina, :ukupna_cena)';
      ParamByName('email').AsString := formLogin.editEmail.Text;  // Email korisnika iz forme login
      ParamByName('brend').AsString := Artikal.Brend;
      ParamByName('ime').AsString := Artikal.Ime;
      ParamByName('cena').AsFloat := Artikal.Cena;
      ParamByName('jedinica_mere').AsString := Artikal.JedinicaMere;
      ParamByName('kolicina').AsInteger := Artikal.Kolicina;
      ParamByName('ukupna_cena').AsFloat := Artikal.Cena * Artikal.Kolicina;
      ExecSQL;
    end;
  end;

  // Pokaži poruku da je narudžba uspešno kreirana
  ShowMessage('Vaša narudžba je uspešno kreirana!');

  // Očisti korpu
  FItems.Clear;

  // Vrati se na glavni meni ili otvori formu nalog
  formKorpa.Hide;
  formMeni.Show;
end;


procedure TformKorpa.buttonNazadClick(Sender: TObject);
begin
    formKorpa.hide;
    formMeni.show;
end;

procedure TformKorpa.ButtonPrikaziKorpuClick(Sender: TObject);
begin
  PrikaziKorpu;
end;

end.

