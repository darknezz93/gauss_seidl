program Project1;

uses
  Vcl.Forms,
  gauss_Steidl in 'gauss_Steidl.pas' {Form1},
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
