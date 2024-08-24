unit meni;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TformMeni = class(TForm)
    Rectangle1: TRectangle;
    bot: TLayout;
    top: TLayout;
    client: TLayout;
    buttonNazad: TButton;
    Text1: TText;
    Image1: TImage;
    Rectangle2: TRectangle;
    buttonAkumulatori: TButton;
    butonSviDelovi: TButton;
    buttonGume: TButton;
    ListBox1: TListBox;
    buttonPrikazi: TButton;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonPrikaziClick(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure buttonAkumulatoriClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure buttonGumeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMeni: TformMeni;

implementation

uses login, dm, meni2, nalog, meni3;

{$R *.fmx}

procedure TformMeni.buttonAkumulatoriClick(Sender: TObject);
begin
    formMeni.hide;
    formMeni2.show;
end;

procedure TformMeni.buttonGumeClick(Sender: TObject);
begin
    formMeni.hide;
    formMeni3.show;
end;

procedure TformMeni.buttonNazadClick(Sender: TObject);
begin
  formMeni.Hide;
  formLogin.Show;
end;

procedure TformMeni.buttonPrikaziClick(Sender: TObject);
begin
  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT * FROM delovi';
    qtemp.Open;

    // Prikaz delova koji su pronađeni
    if not qtemp.IsEmpty then
    begin
      ListBox1.Clear;
      while not qtemp.Eof do
      begin
        ListBox1.Items.Add(qtemp.FieldByName('ime').AsString);
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

procedure TformMeni.Image1Click(Sender: TObject);
begin
    formMeni.hide;
    formNalog.show;
end;

procedure TformMeni.ListBox1Change(Sender: TObject);
var
  selectedPartName: string;
  description: string;
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    selectedPartName := ListBox1.Items[ListBox1.ItemIndex];

    with dm.db do
    begin
      qtemp.SQL.Text := 'SELECT opis FROM delovi WHERE ime = :ime';
      qtemp.ParamByName('ime').AsString := selectedPartName;
      qtemp.Open;

      if not qtemp.IsEmpty then
      begin
        description := qtemp.FieldByName('opis').AsString;
        ShowMessage(Format('%s: ' + sLineBreak + '%s', [selectedPartName, description]));
      end
      else
      begin
        ShowMessage('Nema opisa za izabranu stavku.');
      end;

      qtemp.Close;
    end;
  end;
end;

end.

