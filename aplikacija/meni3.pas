unit meni3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TformMeni3 = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    buttonPrikazi: TButton;
    top: TLayout;
    buttonNazad: TButton;
    Text1: TText;
    Image1: TImage;
    client: TLayout;
    Rectangle2: TRectangle;
    buttonAkumulatori: TButton;
    butonSviDelovi: TButton;
    buttonGume: TButton;
    ListBox1: TListBox;
    procedure buttonNazadClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure buttonPrikaziClick(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure butonSviDeloviClick(Sender: TObject);
    procedure buttonAkumulatoriClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMeni3: TformMeni3;

implementation

uses meni, nalog, dm, detalji, meni2;

{$R *.fmx}

procedure TformMeni3.butonSviDeloviClick(Sender: TObject);
begin
    formMeni3.hide;
    formMeni.show;
end;

procedure TformMeni3.buttonAkumulatoriClick(Sender: TObject);
begin
    formMeni3.hide;
    formMeni2.show;
end;

procedure TformMeni3.buttonNazadClick(Sender: TObject);
begin
    formMeni3.Hide;
    formMeni.show;
end;

procedure TformMeni3.buttonPrikaziClick(Sender: TObject);
begin
  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT * FROM gume';
    qtemp.Open;

    // Prikaz delova koji su pronađeni
    if not qtemp.IsEmpty then
    begin
      ListBox1.Clear;
      while not qtemp.Eof do
      begin
        ListBox1.Items.Add(qtemp.FieldByName('brend').AsString + ' ' + qtemp.FieldByName('ime').AsString);
        qtemp.Next;
      end;
      // Omogućavanje korisniku da klikne na stavku u ListBox-u
      ListBox1.OnChange := ListBox1Change;
    end
    else
    begin
      ListBox1.Clear;
      ListBox1.Items.Add('Nema delova sa izabranim imenom.');
    end;

    // Zatvaranje upita
    qtemp.Close;
  end;
end;

procedure TformMeni3.Image1Click(Sender: TObject);
begin
    formMeni3.hide;
    formNalog.show;
end;
procedure TformMeni3.ListBox1Change(Sender: TObject);
var
  selectedPartName, brend, ime, cena, jedinica, status, rok: string;
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    selectedPartName := ListBox1.Items[ListBox1.ItemIndex];

    // Pretpostavljamo da selectedPartName sadrži "Brend Ime"
    brend := Copy(selectedPartName, 1, Pos(' ', selectedPartName) - 1);
    ime := Copy(selectedPartName, Pos(' ', selectedPartName) + 1, Length(selectedPartName));

    with dm.db do
    begin
      qtemp.SQL.Text := 'SELECT brend, ime, cena, jedinicaMere, status, rokIsporuke FROM gume WHERE brend = :brend AND ime = :ime';
      qtemp.ParamByName('brend').AsString := brend;
      qtemp.ParamByName('ime').AsString := ime;
      qtemp.Open;

      if not qtemp.IsEmpty then
      begin
        brend := qtemp.FieldByName('brend').AsString;
        ime := qtemp.FieldByName('ime').AsString;
        cena := qtemp.FieldByName('cena').AsString;
        jedinica := qtemp.FieldByName('jedinicaMere').AsString;
        status := qtemp.FieldByName('status').AsString;
        rok := qtemp.FieldByName('rokIsporuke').AsString;

        formMeni3.Hide;

        // Otvaranje forme sa detaljima
        if not Assigned(formDetalji) then
          Application.CreateForm(TformDetalji, formDetalji);

        formDetalji.PrikaziDetalje(brend, ime, cena, jedinica, status, rok);
        formDetalji.ShowModal;
      end
      else
      begin
        ShowMessage('Nema podataka za izabranu stavku.');
      end;

      qtemp.Close;
    end;
  end;
end;


end.
