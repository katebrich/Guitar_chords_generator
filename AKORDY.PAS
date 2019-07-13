
{ Generator kytarovych akordu }
{ Katerina Brichackova }
{ NMIN101, ZS 2014/2015}

uses crt;
type Tpole=array[1..20] of integer;
var stupnice:array[1..12] of string;
    zaklad, typ, bas, cislo:integer;
    akord, jmeno_souboru:string;
    ton:array[1..10] of string;
    hmatnik:array[1..6,0..15] of string;  {1..6 struny, 0..15 prazce vcetne volne struny=0}
    pocet_basu:integer;
    pocet_tonu:integer;
    i,j,k:integer;
    vysledek:Tpole;
    vystup:text;

procedure Vytvor_stupnici;
{Priradi tony C-durove toniny do pole Stupnice}

var i:integer;
begin
  for i:=1 to 12 do
    case i of
      1: stupnice[i]:='C';
      2: stupnice[i]:='C#';
      3: stupnice[i]:='D';
      4: stupnice[i]:='D#';
      5: stupnice[i]:='E';
      6: stupnice[i]:='F';
      7: stupnice[i]:='F#';
      8: stupnice[i]:='G';
      9: stupnice[i]:='G#';
     10: stupnice[i]:='A';
     11: stupnice[i]:='A#';
     12: stupnice[i]:='H';
    end;
end;

procedure Nacti_akord;
{ve trech krocich nabidne uzivateli moznosti pro vyber akordu}
{nacte ze vstupu zaklad, typ a pripadne bas akordu}
{do promenne "akord" ulozi cely nazev akordu}

begin
 writeln;
 writeln(' Vyberte ze seznamu zaklad akordu a zadejte jeho cislo a ENTER: ');
 writeln;
 writeln('   1: C');
 writeln('   2: C#');
 writeln('   3: D');
 writeln('   4: D#');
 writeln('   5: E');
 writeln('   6: F');
 writeln('   7: F#');
 writeln('   8: G');
 writeln('   9: G#');
 writeln('  10: A');
 writeln('  11: A#');
 writeln('  12: H');
 readln(zaklad);
 if (zaklad<1) or (zaklad>12) then     {osetreni neplatneho vstupu}
  repeat
    begin
      writeln('Nespravny vstup. Zadejte cislo od 1 do 12.');
      readln(zaklad);
    end
  until (zaklad>=1) and (zaklad<=12);
 clrscr;
 writeln;
 writeln(' Nyni vyberte typ akordu: ');
 writeln;
 write('   1: ***                 ');   writeln(' 2: mi');
 write('   3: 6                   ');   writeln(' 4: mi6');
 write('   5: 7                   ');   writeln(' 6: mi7');
 write('   7: maj7                ');   writeln(' 8: mimaj7');
 write('   9: 9                   ');   writeln('10: mi9');
 write('  11: dim                 ');   writeln('12: sus2');
 write('  13: add2                ');   writeln('14: sus4');
 write('  15: + (aug)             ');   writeln('16: sus2sus4');
 write('  17: 11                  ');   writeln('18: 5b');
 write('  19: 13                  ');   writeln('20: 7#5');
 write('  21: mi7#5               ');   writeln('22: 7b5');
 write('  23: mi7b5               ');   writeln;
 readln(typ);
  if (typ<1) or (typ>23) then
  repeat
    begin
      writeln('Nespravny vstup. Zadejte cislo od 1 do 23.');
      readln(typ);
    end
  until (typ>=1) and (typ<=23);
 clrscr;
 writeln;
 writeln(' Prejete si zadat lomeny akord?' );
 writeln('   1: ANO');
 writeln('   2: NE');
 readln(cislo);
  if (cislo<1) or (cislo>2) then
  repeat
    begin
      writeln('Nespravny vstup. Zadejte cislo 1 nebo 2.');
      readln(cislo);
    end
  until (cislo=1) or (cislo=2);
 clrscr;
 writeln;
 if cislo=1 then
   begin
     writeln(' Zadejte basovy ton (tj. cast za lomitkem): ');
     writeln;
     writeln('   1: C');
     writeln('   2: C#');
     writeln('   3: D');
     writeln('   4: D#');
     writeln('   5: E');
     writeln('   6: F');
     writeln('   7: F#');
     writeln('   8: G');
     writeln('   9: G#');
     writeln('  10: A');
     writeln('  11: A#');
     writeln('  12: H');
     readln(bas);
      if (bas<1) or (bas>12) then
      repeat
        begin
         writeln('Nespravny vstup. Zadejte cislo od 1 do 12.');
         readln(bas);
        end
      until (bas>=1) and (bas<=12);
   end;
   clrscr;
   writeln;

 {ulozeni celeho jmena akordu:}
   akord:=stupnice[zaklad];
   case typ of
     2: akord:=akord+'mi';
     3: akord:=akord+'6';
     4: akord:=akord+'mi6';
     5: akord:=akord+'7';
     6: akord:=akord+'mi7';
     7: akord:=akord+'maj7';
     8: akord:=akord+'mimaj7';
     9: akord:=akord+'9';
     10: akord:=akord+'mi9';
     11: akord:=akord+'dim';
     12: akord:=akord+'sus2';
     13: akord:=akord+'add2';
     14: akord:=akord+'sus4';
     15: akord:=akord+'+';
     16: akord:=akord+'sus2sus4';
     17: akord:=akord+'11';
     18: akord:=akord+'5b';
     19: akord:=akord+'13';
     20: akord:=akord+'7#5';
     21: akord:=akord+'mi7#5';
     22: akord:=akord+'7b5';
     23: akord:=akord+'mi7b5';
     end;

     jmeno_souboru:=akord;
     if (cislo=1) and (bas<>zaklad) then
        begin
          jmeno_souboru:=akord+'-'+stupnice[bas];
          akord:=akord+'/'+stupnice[bas];
        end;

end;


procedure Vypis_tony;
{do promenne Ton[i] priradi i-ty ton akordu}
{na standardni vystup vypise tony, ze kterych je akord slozen}

var i:integer;
    k:integer;
    kolikaty:integer;
begin
  writeln(' Akord ',akord,' je slozen z tonu:');
  writeln;
  if (cislo=1) and (bas<>zaklad) then    {pokud je zadany bas odlisny od zakladu, vypise promennou Bas na prvnim miste}
    begin
      ton[1]:=stupnice[bas];
      i:=2;
    end
  else
    i:=1;
  ton[i]:=stupnice[zaklad];  {zaklad je prvni ton (resp. je pred nim jen bas)}
  inc(i);
  case typ of
  {podle toho, o jaky typ akordu jde, urci intervaly mezi jednotlivymi tony a spravne tony ulozi}
    1: begin
        kolikaty:=(zaklad+4) mod 12;   {hlida "preteceni" stupnice-ma jen 12 tonu, ktere se pote opakuji}
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    2: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    3: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+9) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
     4: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+9) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
      5: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
     6: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    7: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+11) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    8: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+11) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    9: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    10: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    11: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+6) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    12: begin
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    13: begin
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    14: begin
        kolikaty:=(zaklad+5) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
       end;
    15: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+8) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    16: begin
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+5) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    17: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+5) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    18: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+6) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    19: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+7) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+2) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+9) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
     20: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+8) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
     21: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+8) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
     22: begin
        kolikaty:=(zaklad+4) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+6) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    23: begin
        kolikaty:=(zaklad+3) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+6) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
        inc(i);
        kolikaty:=(zaklad+10) mod 12;
        if kolikaty=0 then kolikaty:=12;
        ton[i]:=stupnice[kolikaty];
       end;
    end;

  pocet_tonu:=i;
  for k:=1 to pocet_tonu do   {vypise tony na standardni vystup}
    write(' ',ton[k]);


end;


procedure Vytvor_hmatnik;
{do promenne Hmatnik[struna,prazec] ulozi nazev tonu, ktery zahrajeme na kytare drzenim dane struny na danem prazci}
{prazec=0 predstavuje hrani prazdne struny}

var i:integer;
    struna, prazec:integer;
begin
  for struna:=1 to 6 do
   begin
    case struna of    {urci, od kolikateho tonu stupnice ma prirazovat na dane strune}
     1: i:=5;
     2: i:=12;
     3: i:=8;
     4: i:=3;
     5: i:=10;
     6: i:=5;
    end;
   for prazec:=0 to 15 do
      begin
        hmatnik[struna,prazec]:=stupnice[i];
        inc(i);
        if i>12 then i:=i-12;
      end;
  end;

end;


function Spravny_ton(struna,prazec:integer):boolean;
{urci, zda je ton obsazen v akordu}

begin
   spravny_ton:=false;
   for i:=1 to pocet_tonu do
     if hmatnik[struna,prazec]=ton[i] then
       begin
         spravny_ton:=true;
         break;
       end;

end;

function Je_hratelny(x,y:integer;vysledek:Tpole):boolean;
{overi nekolik podminek, za kterych je dany akord hratelny}

var min, max:integer;
    obsazen, prirazeno:boolean;
    prazdnych, nejnizsich, potreba_prstu:integer;
    barre_2,barre_3:boolean;
begin
  vysledek[x]:=y;
  je_hratelny:=true;
  prirazeno:=false;

{1.-prsty musi byt nejvyse v rozsahu 4 prazcu}
{min a max jsou cisla nejnizsiho a nejvyssiho hraneho prazce, krome 0-prazdna struna}
  max:=1;
  min:=16;
  for i:=1 to x do
    begin
      if vysledek[i]>max then max:=vysledek[i];
      if (vysledek[i]<min) and (vysledek[i]<>0) {0 je prazdna struna, ta se do rozsahu nepocita}
         then min:=vysledek[i];
    end;
  if max-min>3 then
    begin
      je_hratelny:=false;
      prirazeno:=true;
    end;

{2.-jsou v hmatu obsazeny vsechny tony akordu?}
  if prirazeno<>true then       {pokud uz akord neni hratelny,nema smysl overovat dalsi podminky}
  begin
   for i:=1 to pocet_tonu do
    begin
      obsazen:=false;
      for j:=1 to x do
        if hmatnik[j,vysledek[j]]=ton[i] then obsazen:=true;
      if obsazen=false then
        begin
          je_hratelny:=false;
          prirazeno:=true;
          break;
        end;
    end;
   end;

{3.-dalsi podminky:}
if prirazeno=false then
begin

prazdnych:=0;
nejnizsich:=0;
for i:=1 to x do
  begin
   if vysledek[i]=0 then inc(prazdnych);      {kolik se hraje prazdnych strun?}
   if vysledek[i]=min then inc(nejnizsich);   {jde pouzit barre akord?}
  end;
for i:=1 to x-1 do
  if vysledek[i]=vysledek[i+1] then barre_2:=true; {2 struny muzu hrat jednim prstem}
for i:=1 to x-2 do
  if (vysledek[i]=vysledek[i+1]) and (vysledek[i+1]=vysledek[i+2]) then barre_3:=true; {3 struny jednim prstem}

{vyhodnoceni:}
if prazdnych>0 then potreba_prstu:=x-prazdnych   {pokud prazdna struna, nemuzu pouzit barre akord}
                                                 {na prazdne struny nejsou potreba prsty}
else if prazdnych=0 then
   begin
     potreba_prstu:=x-nejnizsich+1;  {zahraju barre akord}
                                     {pouziji jen jeden prst na pocet nejnizsich strun}
     if (nejnizsich=1) and (barre_2=true) then potreba_prstu:=x-1;  {jednim prstem zahraju 2 struny}
     if (nejnizsich=1) and (barre_3=true) then potreba_prstu:=x-2;
     if (nejnizsich=1) and (barre_2=false) and (barre_3=false) then potreba_prstu:=x;
   end;

je_hratelny:=potreba_prstu<=4
end;

end;



procedure Vypis_akord(x,y:integer; vysledek:Tpole);
{do souboru vypise, jak akord zahrat}
{x a y jsou cisla struny a prazce, kde je bas}

begin
  for i:=1 to x-1 do writeln(vystup,vysledek[i]);   {vypise cisla prazcu na strunach nad basem}
  writeln(vystup,y);                     {vypise cislo prazce, na kterem je bas}
  for i:=1 to 6-x do                         {oznaci zatlumene struny pod basem}
    writeln(vystup,'X');
  writeln(vystup);
end;


procedure Hledej_akord(x,y,struna:integer; var vysledek:Tpole);
{x,y jsou oznacuji pozici basu - bas je na miste hmatnik[x,y]}
{na vsech strunach nad strunou, na ktere je bas,}
{oznaci v poli vysledku cislem 1 tony, ktere patri do akordu}
{a jsou v rozsahu max. 3 prazce od basu}

var prazec:integer;
    zacatek,konec:integer;
begin
   if (struna=x) and (Je_hratelny(x,y,vysledek)) then Vypis_akord(x,y,vysledek)
   else if struna<x then
    begin
     if y-3<1 then zacatek:=1 else zacatek:=y-3;  {urci rozsah hledanych tonu max. 3 prazce od basu}
     if y+3>15 then konec:=15 else konec:=y+3;    {pokud je rozsah pred/za hmatnikem, urci minimalni zacatek/maximalni konec}
     prazec:=0;                                   {nejprve vybira prazdnou strunu}
        if Spravny_ton(struna,prazec) then
          begin
            vysledek[struna]:=prazec;
            Hledej_akord(x,y,struna+1,vysledek);
          end;
     for prazec:=zacatek to konec do              {hleda tony v povolenem rozsahu}
        if Spravny_ton(struna,prazec) then
          begin
            vysledek[struna]:=prazec;
            Hledej_akord(x,y,struna+1,vysledek);
          end;
    end;
end;


procedure Oznac_bas(x:string);
{x je jmeno basoveho tonu}
{hleda vsechny moznosti, jak hrat bas, na 4., 5. a 6. strune}
{pro kazdou moznost zavola funkci Hledej_akord, ktera urci zbyvajici tony}

var struna,prazec: integer;
begin
  pocet_basu:=0;
   for prazec:=0 to 15 do
    for struna:=6 downto 4 do
     begin
      if hmatnik[struna,prazec]=x then
        begin
         Hledej_akord(struna,prazec,1,vysledek);
         inc(pocet_basu);
        end;
     end;
end;




begin
 Vytvor_stupnici;
 Nacti_akord;
 Vypis_tony;
 Vytvor_hmatnik;
 Assign(vystup,jmeno_souboru);
 Rewrite(vystup);
 Oznac_bas(ton[1]); {tato funkce vola funkci Hledej_akord, ta vola funkci Je_hratelny a Vypis_akord}
 close(vystup);
 repeat until keypressed;
 clrscr;
end.