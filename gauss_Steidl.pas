unit gauss_Steidl;

interface
{ toDo:
  -Zrobi� arytmetyke interval
  -Sprawdzic o co chodzi z rekordami
  -Doko�czyc to g�wno
  }

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, IntervalArithmetic32and64;

type
    matrix = array[0..20,0..20] of Extended; //deklaracja dw�ch nowych typ�w danych
    vector = array[0..20] of Extended;

  TForm1 = class(TForm)
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Button1: TButton;
    StringGrid2: TStringGrid;
    Edit4: TEdit;
    Button3: TButton;
    Panel2: TPanel;
    Memo1: TMemo;
    Label3: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button2: TButton;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure SzukajClickNormal(Sender: TObject);
    procedure SzukajClickInterval(Sender: TObject);
    procedure UstawIloscZmiennych(Sender: TObject);
    procedure DodajZmiennaS(Sender: TObject);
    procedure DodajZmiennaX(Sender: TObject);
    procedure Reset(Sender: TObject);
    procedure WczytaDane1(Sender: TObject);
    procedure WczytajDane2(Sender: TObject);

    //procedure ustawTablice(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  //normal
  A : matrix;
  L : matrix;
  D : matrix;
  U : matrix;
  b : vector;
  x : vector;


 //interval
  Ai : array[0..20,0..20] of interval;
  Li : array[0..20,0..20] of interval;
  Di : array[0..20,0..20] of interval;
  Ui : array[0..20,0..20] of interval;
  bi : array[0..20] of interval;
  xi : array[0..20] of interval;
  x_left_strings: array[0..20] of String;
  x_right_strings: array[0..20] of String;


  it : Integer;   //ilo�� iteracji
  zmienne : Integer; //ilos� zmiennych
  ii : Integer;
  jj : Integer;
  ss : Integer;
  st : Integer;


implementation
{$R *.dfm}



procedure TForm1.SzukajClickNormal(Sender: TObject);
var
  it : Integer;
  i : Integer;
  j : Integer;
  k : Integer;
  g : String;


begin

  //Memo1.Clear;

  it:= StrToInt(Edit1.Text);
  zmienne := StrToInt(Edit2.Text);


  //Inicjalizacja macierzy  L
  for i := 0 to zmienne do
    begin
      for j := 0 to zmienne do
        begin
            if i > j then
            begin
              L[i][j] := A[i][j];
            end
            else
            begin
              L[i][j] := 0;
            end;
        end;
    end;


  //Inicjalizacja macierzy D
   for i := 0 to zmienne do
     begin
        for j := 0 to zmienne do
          begin
            if i = j then
            begin
              D[i][j] := A[i][j];
            end
            else
            begin
              D[i][j] := 0;
            end;
          end;
     end;

  //Inicjalizacja macierzy U
     for i := 0 to zmienne do
     begin
        for j := 0 to zmienne do
          begin
            if i < j then
            begin
              U[i][j] := A[i][j];
            end
            else
            begin
              U[i][j] := 0;
            end;
          end;
     end;

  // Macierz odwrotna Do D -> D^-1
    for i := 0 to zmienne do
      begin
        for j := 0 to zmienne do
        begin
          if D[i][j] <> 0 then
          begin
              D[i][j] := 1/D[i][j];
          end;
        end;
      end;

  // Macierz D^-1 * b
  for i := 0 to zmienne do
    begin
      for j := 0 to zmienne do
        begin
          if D[i][j] <> 0 then
          begin
            b[i] := D[i][j] * b[i];
          end;
        end;
    end;

  //Macierz D^-1 * L
  for i := 0 to zmienne do
  begin
    for j := 0 to (zmienne-1) do
    begin
      L[i][j] := D[i][i] * L[i][j];
    end;

  end;

  //Macierz D^-1 * U
  for i := 0 to zmienne do
    begin
      for j := 1 to zmienne do
        begin
          U[i][j] := D[i][i] * U[i][j];
        end;
    end;


  for k := 0  to it do
  begin
    for i := 0 to zmienne do
    begin
      x[i] := b[i];                    // x= D^-1 *b -
      for j := 0 to i-1 do
          x[i] := x[i] - L[i][j]*x[j]; // D^-1*L *x -
      for j := i+1 to zmienne do
          x[i] := x[i] - U[i][j]*x[j]; // D^-1*U *x
    end;

  end;

  //wypisanie liczb do memo
  for i := 0 to zmienne-1 do
    begin
      Memo1.Lines.Add('x' + IntToStr(i+1) + ':  ' +FloatToStrF(x[i], ffExponent, 15,2));
    end;

    Memo1.Lines.Add(' ');


  for i := 0 to zmienne do
    begin
     // b[i] := 0;
      x[i] := 0;
    end;


end;



////////////////////////////////////////////////////////////////////////////////



procedure TForm1.SzukajClickInterval(Sender: TObject);
var
  it : Integer;
  i : integer;
  j : Integer;
  k : Integer;
  g : String;
  zmienne : Integer;
  zero_string : String;
  jeden_string : String;
  dwa_string : String;
  zero: interval;
  jeden: interval;
  dwa: interval;
  temp : String;

begin

  //Memo1.Clear;

  it:= StrToInt(Edit1.Text);
  zmienne := StrToInt(Edit2.Text);
  zero_string := IntToStr(0);
  jeden_string := IntToStr(1);
  //dwa_string := IntToStr(100);

  zero := int_read(zero_string);
  jeden := int_read(jeden_string);
  //dwa := int_read(dwa_string);




  //Inicjalizacja macierzy  L
  for i := 0 to zmienne do
    begin
      for j := 0 to zmienne do
        begin
            if i > j then
            begin
              Li[i][j] := Ai[i][j];
            end
            else
            begin
              Li[i][j] := zero;
            end;
        end;
    end;

  //Inicjalizacja macierzy D
   for i := 0 to zmienne do
     begin
        for j := 0 to zmienne do
          begin
            if i = j then
            begin
              Di[i][j] := Ai[i][j];
            end
            else
            begin
              Di[i][j] := zero;
            end;
          end;
     end;

  //Inicjalizacja macierzy U
     for i := 0 to zmienne do
     begin
        for j := 0 to zmienne do
          begin
            if i < j then
            begin
              Ui[i][j] := Ai[i][j];
            end
            else
            begin
              Ui[i][j] := zero;
            end;
          end;
       end;


  // Macierz odwrotna Do D -> D^-1
    for i := 0 to zmienne-1 do
      begin
            //D[i][j] := 1/D[i][j];
            dwa := idiv(jeden,Di[i][i]);
            Di[i][i] := dwa;
      end;


  // Macierz D^-1 * b
  for i := 0 to zmienne do
    begin
      bi[i] := imul(Di[i][i], bi[i]);
    end;

  //Macierz D^-1 * L
  for i := 0 to zmienne do
  begin
    for j := 0 to (zmienne-1) do
    begin
      //Li[i][j] := Di[i][i] * Li[i][j];
      Li[i][j] := imul(Di[i][i], Li[i][j]);
    end;

  end;

  //Macierz D^-1 * U
  for i := 0 to zmienne do
    begin
      for j := 1 to zmienne do
        begin
          //Ui[i][j] := Di[i][i] * Ui[i][j];
          Ui[i][j] := imul(Di[i][j], Ui[i][j]);
        end;
    end;


  for k := 0  to it do
  begin
    for i := 0 to zmienne do
    begin
      xi[i] := bi[i];                    // x= D^-1 *b -
      for j := 0 to i-1 do
          //xi[i] := xi[i] - Li[i][j]*xi[j]; // D^-1*L *x -
          xi[i] := isub(xi[i], imul(Li[i][j], xi[j]));
      for j := i+1 to zmienne do
         // xi[i] := xi[i] - Ui[i][j]*xi[j]; // D^-1*U *x
          xi[i] := isub(xi[i], imul(Ui[i][j], xi[j]));
    end;

  end;

  for i := 0 to zmienne-1 do
    begin
       iends_to_strings(xi[i], x_left_strings[i], x_right_strings[i])
    end;

  //wypisanie liczb do memo
  for i := 0 to zmienne-1 do
    begin
      //Memo1.Lines.Add('x' + IntToStr(i+1) + ':  ' +FloatToStrF(xi[i], ffExponent, 15,2));
      Memo1.Lines.Add('x' + IntToStr(i+1) + ':  ' + x_left_strings[i] + '  ' + x_right_strings[i] );
    end;
    Memo1.Lines.Add(' ');


end;






procedure TForm1.UstawIloscZmiennych(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
   zmienne :=  StrToInt(Edit2.Text);

   //ustawienie wielkosci StringGridow
   StringGrid1.RowCount := zmienne;
   StringGrid1.ColCount := zmienne;
   StringGrid2.RowCount := zmienne;
   StringGrid2.ColCount := 1;

end;


procedure TForm1.WczytaDane1(Sender: TObject);
var
i : Integer;
j : Integer;
zmienne : Integer;
begin
 zmienne := 3;
 StringGrid1.RowCount := 4;
 StringGrid1.ColCount := 4;
 StringGrid2.ColCount := 1;
 StringGrid2.RowCount := 4;
 StringGrid1.Cells[0,0] := FloatToStr(-12.235);
 StringGrid1.Cells[1,0] := FloatToStr(1.229);
 StringGrid1.Cells[2,0] := FloatToStr(0.5597);
 StringGrid1.Cells[3,0] := IntToStr(0);
 StringGrid1.Cells[0,1] := FloatToStr(1.229);
 StringGrid1.Cells[1,1] := FloatToStr(-6.78);
 StringGrid1.Cells[2,1] := FloatToStr(0.765);
 StringGrid1.Cells[3,1] := IntToStr(0);
 StringGrid1.Cells[0,2] := FloatToStr(0.5597);
 StringGrid1.Cells[1,2] := FloatToStr(0.765);
 StringGrid1.Cells[2,2] := FloatToStr(91.0096);
 StringGrid1.Cells[3,2] := IntToStr(2);
 StringGrid1.Cells[0,3] := FloatToStr(0);
 StringGrid1.Cells[1,3] := IntToStr(0);
 StringGrid1.Cells[2,3] := IntToStr(-2);
 StringGrid1.Cells[3,3] := FloatToStr(5.5);

 StringGrid2.Cells[0,0] := FloatToStr(0.956);
 StringGrid2.Cells[0,1] := FloatToStr(51.5603);
 StringGrid2.Cells[0,2] := IntToStr(2);
 StringGrid2.Cells[0,3] := FloatToStr(5.8);

 //dodanie do tablic

 for i := 0 to zmienne do
   begin
     for j := 0 to zmienne do
       begin
         A[i][j] := StrToFloat(StringGrid1.Cells[j,i]);
         Ai[i][j] := int_read(StringGrid1.Cells[j,i]);
       end;
   end;

  for i := 0 to zmienne do
    begin
      b[i] := StrToFloat(StringGrid2.Cells[0,i]);
      bi[i] := int_read(StringGrid2.Cells[0,i]);
    end;

    Edit1.Text := IntToStr(10);
    Edit2.Text := IntToStr(4);

end;

procedure TForm1.WczytajDane2(Sender: TObject);
var
i : Integer;
j : Integer;
zmienne : Integer;
begin
 zmienne := 3;
 StringGrid1.RowCount := 4;
 StringGrid1.ColCount := 4;
 StringGrid2.ColCount := 1;
 StringGrid2.RowCount := 4;
 StringGrid1.Cells[0,0] := FloatToStr(-6.937);
 StringGrid1.Cells[1,0] := FloatToStr(-9.7632);
 StringGrid1.Cells[2,0] := FloatToStr(17.4);
 StringGrid1.Cells[3,0] := IntToStr(-1);
 StringGrid1.Cells[0,1] := IntToStr(4);
 StringGrid1.Cells[1,1] := FloatToStr(8.77);
 StringGrid1.Cells[2,1] := FloatToStr(5.098);
 StringGrid1.Cells[3,1] := IntToStr(19);
 StringGrid1.Cells[0,2] := FloatToStr(-9.482);
 StringGrid1.Cells[1,2] := FloatToStr(3.98);
 StringGrid1.Cells[2,2] := IntToStr(-8);
 StringGrid1.Cells[3,2] := FloatToStr(-14.567);
 StringGrid1.Cells[0,3] := FloatToStr(-3.21);
 StringGrid1.Cells[1,3] := IntToStr(-3);
 StringGrid1.Cells[2,3] := FloatToStr(7.9301);
 StringGrid1.Cells[3,3] := IntToStr(9);
 StringGrid1.Cells[0,4] := FloatToStr(-12.28);
 StringGrid1.Cells[1,4] := IntToStr(16);
 StringGrid1.Cells[2,4] := FloatToStr(3.44);
 StringGrid1.Cells[3,4] := FloatToStr(5.613);

 StringGrid2.Cells[0,0] := FloatToStr(5.892);
 StringGrid2.Cells[0,1] := FloatToStr(-6.13);
 StringGrid2.Cells[0,2] := FloatToStr(-3.269);
 StringGrid2.Cells[0,3] := FloatToStr(8.812);


 //dodanie do tablic

 for i := 0 to zmienne do
   begin
     for j := 0 to zmienne do
       begin
         A[i][j] := StrToFloat(StringGrid1.Cells[j,i]);
         Ai[i][j] := int_read(StringGrid1.Cells[j,i]);
       end;
   end;

  for i := 0 to zmienne do
    begin
      b[i] := StrToFloat(StringGrid2.Cells[0,i]);
      bi[i] := int_read(StringGrid2.Cells[0,i]);
    end;

    Edit1.Text := IntToStr(25);
    Edit2.Text := IntToStr(4);
end;

procedure TForm1.DodajZmiennaS(Sender: TObject);
begin
 if ss < zmienne then
    begin
      b[ss] := StrToFloat(Edit4.Text);
      StringGrid2.Cells[0,ss] := FloatToStr(b[ss]);
      bi[ss] := int_read(StringGrid2.Cells[0,ss]);
      Inc(ss);
    end;
end;


//DodajZmiennaX() dodaje do StringGrida i A
procedure TForm1.DodajZmiennaX(Sender: TObject);
var
  i: Integer;
  j: Integer;

begin
if ii < zmienne then
  begin
    if jj < zmienne then
    begin
      StringGrid1.Cells[jj,ii] := Edit3.Text;
      A[ii][jj] := StrToFloat(Edit3.Text);
      Ai[ii][jj] := int_read(Edit3.Text);
      Inc(jj);
    end
    else
    begin
      Inc(ii);
      jj := 0;
      StringGrid1.Cells[jj,ii] := Edit3.Text;
      A[ii][jj] := StrToFloat(Edit3.Text);
      Ai[ii][jj] := int_read(Edit3.Text);
      Inc(jj);
    end;
  end;


end;




procedure TForm1.Reset(Sender: TObject);
var
i: Integer;
j: Integer;
zero_string: String;
zero: interval;
begin

  zero_string := IntToStr(0);
  zero:=int_read(zero_string);

   for i := 0 to zmienne do
   begin
     for j := 0 to zmienne do
     begin
        A[i][j] := 0;
        L[i][j] := 0;
        D[i][j] := 0;
        U[i][j] := 0;

        Ai[i][j] := zero;
        Li[i][j] := zero;
        Di[i][j] := zero;
        Ui[i][j] := zero;
        StringGrid1.Cells[j,i] := ' ';
     end;
   end;

   for i := 0 to zmienne do
     begin
       StringGrid2.Cells[0,i] := ' ';
     end;

   for i := 0 to zmienne do
     begin
       b[i] := 0;
       x[i] := 0;
     end;

   Edit1.Text := ' ';
   Edit2.Text := ' ';
   Edit3.Text := ' ';
   Edit4.Text := ' ';


   Memo1.Clear;

end;

end.
