uses
  CRT;
var
  saved_a, saved_b, saved_znach,saved_perv: real;
  saved_n: integer;
  a_entered, n_entered, integral_calculated, b_entered: boolean;
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
      writeln('Нажмите Enter для возврата в меню');
      readln;
      exit;
    end;
      a_entered := true;
      integral_calculated := false;
      writeln;
      writeln('Предел интегрирования успешно сохраненён');
      writeln('Нажмите Enter для возврата в меню');
      readln;
end;
procedure InputB;
begin
  write('Введите верхний предел интегрирования (b): ');
  readln(saved_b);
  if a_entered and (saved_a > saved_b) then
  begin
    b_entered := false;
    writeln('Ошибка: нижний предел не может быть больше верхнего');
    writeln('Нажмите Enter для возврата в меню');
    readln;
    exit;
  end;
    b_entered := true;
    integral_calculated := false;
    writeln;
    writeln('Предел интегрирования успешно сохраненён');
    writeln('Нажмите Enter для возврата в меню');
    readln;
end;
procedure InputN;
begin
  write('Введите количество отрезков разбиения (n > 0): ');
  readln(saved_n);
  if saved_n <= 0 then
  begin
    writeln('Ошибка: количество отрезков должно быть положительным');
    writeln('Нажмите Enter для возврата в меню');
    readln;
    exit;
  end;
  n_entered := true;
  integral_calculated := false;
  writeln;
  writeln('Количество отрезков успешно сохранено');
  writeln('Нажмите Enter для возврата в меню');
  readln;
end;
procedure Integral;
begin
  if not (a_entered and b_entered) then
  begin
    writeln('Ошибка: сначала введите пределы интегрирования (пункт 1,2)');
    writeln('Нажмите Enter для возврата в меню');
    readln;
    exit;
  end;
  if not n_entered then
  begin
    writeln('Ошибка: сначала введите количество отрезков (пункт 3)');
    writeln('Нажмите Enter для возврата в меню');
    readln;
    exit;
  end;
  saved_znach := Left(saved_a, saved_b, saved_n);
  saved_perv := Perv(saved_b) - Perv(saved_a);
  integral_calculated := true;
  writeln;
  writeln('РЕЗУЛЬТАТЫ');
  writeln('Шаг вычислений: h = ', (saved_b-saved_a)/saved_n);
  writeln;
  writeln('  I = ', saved_perv);
  writeln;
  writeln('Нажмите Enter для возврата в меню...');
  readln;
end;
procedure Error;
var
  abs_error, ot_error: real;
begin
  writeln('=== ОЦЕНКА ПОГРЕШНОСТИ ===');
  if not integral_calculated then
  begin
    writeln('Ошибка: сначала выполните вычисление интеграла (пункт 3)');
    writeln('Нажмите Enter для возврата в меню');
    readln;
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
  writeln('Нажмите Enter для возврата в меню');
  readln;
end;
var
  choice: integer;
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
    writeln('1. Ввод предела интегрирования (a)');
    writeln('2. Ввод предела интегрирования (b)');
    writeln('3. Ввод количества отрезков (n)');
    writeln('4. Вычислить интеграл');
    writeln('5. Оценить погрешность');
    writeln('0. Выйти из программы');
    writeln;
    
    if a_entered then
    begin
      writeln('Текущие пределы интегрирования:');
      writeln('  a = ', saved_a);
    end;
    if b_entered then
    begin
      writeln('Текущие пределы интегрирования:');
      writeln(' b = ', saved_b);
    end;
    if n_entered then
    begin
      writeln('Текущее количество отрезков:');
      writeln('  n = ', saved_n);
    end;
    if integral_calculated then
    begin
      writeln('Результат вычислений:');
      writeln('  I = ', saved_perv);
    end;
    
    writeln('=====================');
    writeln;
    write('Введите номер пункта меню (1-5): ');
    
    //Ввод числа
    readln(choice);
    if (choice < 0) or (choice > 5) then
    begin
      writeln('Ошибка: введите число от 0 до 5');
      writeln('Нажмите Enter для продолжения');
      readln;
      continue;
    end;
    
    case choice of
      1: InputA;
      2: InputB;
      3: InputN;
      4: Integral;
      5: Error;
      0: break;
    end;
  end;
end.