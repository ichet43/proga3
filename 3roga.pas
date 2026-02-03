uses
  CRT;
var
  saved_a, saved_b, saved_znach,saved_perv: real;
  saved_n: integer;
  a_entered, n_entered, integral_calculated, b_entered: boolean;
procedure Enter;
  begin
  writeln;
  writeln('Нажмите Enter для возврата в меню');
  ReadLn; 
  end;
function Left(a, b: real; n: integer): real;
var
  h, sum, x, f: real;
  i: integer;
begin
  h := (b - a) / n;
  sum := 0;
  for i := 0 to n-1 do
  begin
    x := a + i * h;
    f := x*x*x + 2*x*x + 3*x + 10;
    sum := sum + f;
  end;
  Left := sum * h;
end;
function Perv(x: real): real;
begin
  Perv := x*x*x*x/4 + 2*x*x*x/3 + 3*x*x/2 + 10*x;
end;
procedure InputA;
begin
  write('Введите нижний предел интегрирования (a): ');
  readln(saved_a);
  if b_entered and (saved_a > saved_b) then
    begin
      a_entered := false;
      writeln('Ошибка: нижний предел не может быть больше верхнего');
      write('Введите снова: ');
      readln(saved_a);
    end;
      a_entered := true;
end;
procedure InputB;
begin
  write('Введите верхний предел интегрирования (b): ');
  readln(saved_b);
  if a_entered and (saved_a > saved_b) then
  begin
    b_entered := false;
    writeln('Ошибка: нижний предел не может быть больше верхнего');
    write('Введите снова: ');
    readln(saved_b);
  end;
    b_entered := true;
end;
procedure InputN;
begin
  write('Введите количество отрезков разбиения (n > 0): ');
  readln(saved_n);
  if saved_n <= 0 then
  begin
    writeln('Ошибка: количество отрезков должно быть положительным');
    write('Введите снова: ');
    readln(saved_n);
  end;
  n_entered := true;
end;
procedure Integral;
begin
  if not a_entered then
  begin
    writeln('Ошибка: сначала введите предел интегрирования (пункт 1)');
    Enter;
    exit;
  end;
  if not b_entered then
  begin
    writeln('Ошибка: сначала введите предел интегрирования (пункт 2)');
    Enter;
    exit;
  end;
  if not n_entered then
  begin
    writeln('Ошибка: сначала введите количество отрезков (пункт 3)');
    Enter;
    exit;
  end;
  saved_znach := Left(saved_a, saved_b, saved_n);
  saved_perv := Perv(saved_b) - Perv(saved_a);
  integral_calculated := true;
  writeln;
  writeln('РЕЗУЛЬТАТЫ');
  writeln('Шаг вычислений: h = ', (saved_b-saved_a)/saved_n);
  writeln;
  writeln('  I_примерное = ', saved_znach);
  writeln;
  writeln('  I_точное = ', saved_perv);
  writeln;
  Enter;
end;
procedure Error;
var
  abs_error, ot_error: real;
begin
  writeln('=== ОЦЕНКА ПОГРЕШНОСТИ ===');
  if not integral_calculated then
  begin
    writeln('Ошибка: сначала выполните вычисление интеграла (пункт 4)');
    Enter;
    exit;
  end;
  abs_error := abs(saved_perv - saved_znach);
  if saved_perv <> 0 then
    ot_error := (abs_error / abs(saved_perv)) * 100
  else
    ot_error := 100;
  writeln('Абсолютная погрешность:', abs_error);
  writeln;
  writeln('Относительная погрешность:', ot_error, '%');
  writeln;
  Enter;
end;
var
  vod: integer;
begin
  a_entered := false;
  b_entered := false;
  n_entered := false;
  integral_calculated := false;
  while true do
  begin
    ClrScr;
    writeln('   ВЫЧИСЛЕНИЕ ОПРЕДЕЛЕННОГО ИНТЕГРАЛА');
    writeln;
    writeln('Функция: f(x) = x^3 + 2x^2 + 3x + 10');
    writeln;
    writeln('1. Ввод нижнего предела интегрирования (a)');
    writeln('2. Ввод верхнего предела интегрирования (b)');
    writeln('3. Ввод количества отрезков (n)');
    writeln('4. Вычислить интеграл');
    writeln('5. Оценить погрешность');
    writeln('0. Выйти из программы');
    writeln;
    
    writeln('=====================');
    writeln;
    write('Введите номер пункта меню (1-5): ');
    
    //Ввод числа
    readln(vod);
    if (vod < 0) or (vod > 5) then
    begin
      writeln('Ошибка: введите число от 0 до 5');
      Enter;
      continue;
    end;
    
    case vod of
      1: InputA;
      2: InputB;
      3: InputN;
      4: Integral;
      5: Error;
      0: break;
    end;
  end;
end.