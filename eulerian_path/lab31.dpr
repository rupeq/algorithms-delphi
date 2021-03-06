program lab32;
{�������� �������� �. �.
���������� �������� ������ �������� ���� � �����.}

{$APPTYPE CONSOLE}
Uses
  SysUtils;

Type
  uk = ^steck;
  steck = record
    data: integer;
    next: uk;
  end;

Var
  uk1, uk2: uk;
  n, i, j, x, v, u: integer;
  c : array [1..20] of byte; // ������ �������� ������
  m : array [1..20, 1..20] of boolean ; //������ ���������

function Rus(mes: string):string;
var
  i: integer;
begin
  for i:=1 to length(mes) do
   case mes[i] of
     '�'..'�':mes[i] := Chr(Ord(mes[i]) - 64);
     '�'..'�': mes[i]:= Chr (Ord(mes [i] ) -16);
   end;
  rus := mes;
end;

{������ �����}
procedure MatrixInput;
var
  matrix : textfile; 
  i, j : integer;
  a, b : byte;
begin
  assign(matrix, 'input.txt');
  reset(matrix);
  readln(matrix, n); //�������� ���������� ������
  writeln(rus('��������� ������� ���������: '));
  a := 1;
  for i:=1 to n do
  begin
    write(a, '  ');
    inc(a);
    for j:=1 to n do 
    begin
      read(matrix, b);
      write(b, ' ');
      if b = 1 then // ���� ������� ������� ����� 1
        m[i,j]:=true  // ������� � ������ �������� True
      else 
        m[i,j]:=false;
    end;
    writeln;
  end;
  close(matrix);
end;

{������ ��������� ��������}
Function PeekStek(top: uk): integer;
Begin
  result:=top^.data
End;

{���������� ������ ��������} 
Procedure PushStek(x: integer; var top: uk);
Var
  vsp: uk;
Begin
  New(vsp);
  vsp^.data:=x;
  vsp^.next:=top;
  top:=vsp;
End;

{�������� ��������}
Procedure PopStek(var x: integer; var top: uk);
Begin
  x:=top^.data;
  top:=top^.next
End;

{������} 
Procedure PrintStek(main: uk; counter : integer);
var
  res: string;
Begin
  if main = nil then //���� ���� ����
  begin
    writeln(rus('������.')); //������
  end;
  if counter = 0 then
    write(rus('���������� � ������� ����, � ������� ����: '))
  else
    write(rus('������� ����: '));
  While main <> nil do
  Begin
    res := res + IntToStr(main^.data) + '-'; //������� ���������� �����
    main:=main^.next;
  end;
  delete(res, length(res), length(res));  //������ ��������� "-"
  writeln(res);
  readln;
End;

var
  counter: integer;
{�������� ���������}
Begin
  matrixinput;
  v:=1;
  counter:=0;
  for i:=1 to N do
  begin
    c[i]:=0;
    for j:=1 to N do 
      if m[i,j] = True then
        inc(c[i]);    //������� ������� ������
  end;
  for i:=1 to n do
  begin
    if c[i] mod 2 <> 0 then  //���� ���� ����� 2 �������
    begin
      inc(counter);        //������� ������� �������
      v:=i;     //�� ���� ������� ����
    end;
  end;
  if counter = 0 then //���� ��� ������ � �������� ��������, �����
    v:=1              // ���� ����� � ����, � ����; ������ ���������� � 1
  else if (counter <> 2) and (counter <> 0) then
  begin
    writeln(rus('������ ���� �� �������� �������� ����'));
    readln;
    exit;
  end;
  uk1:=nil;
  uk2:=nil;
  if (v <= n) then
    PushStek(v, uk1); // � ���� ������ �������
  While uk1 <> NIL do //���� ���� �� ����
  Begin
    v:=PeekStek(uk1); //v �������� �� ������� �����
    i:=1;
    While (i <= n) and not m[v,i] do
      inc(i);
    If i <= n then
    Begin
      u:=i;
      PushStek(u, uk1); //��������� � ������
      m[v,u]:=False; // ������� v � ������� �����
      m[u,v]:=False;
    End
    else // �����
    Begin
      PopStek(x, uk1); // ������� ����� ��������� �� v � ������� ���
      PushStek(x, uk2); // ������ ����� ����� ������ � ����
    End;
  End;
  PrintStek(uk2, counter);
End.
