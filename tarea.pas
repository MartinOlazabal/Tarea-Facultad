
PROCEDURE CrearSucesion (VAR suc : Sucesion);
begin
  suc.tope:= 0;
end;

PROCEDURE AgregarValor (VAR suc : Sucesion; valor : Natural; VAR res: Resultado);
var j , i : integer;
begin
i:= 1;  
(*Verifico que suc tenga espacio*)
if (suc.tope) = (MAX) then
res.quePaso := fallo
else begin
while (i <= suc.tope) and (suc.valores[i] < valor) do  (*Busco la posicion del valor con su respectivo orden*)
i := i + 1;
if (i > suc.tope) then begin
suc.tope := suc.tope + 1;
suc.valores[i] := valor;
res.quePaso := Agregado;
res.posicion := i ;   
end
else if (i <= suc.tope) then begin
if (suc.valores[i] = valor) then
res.quePaso := Fallo
else if (suc.valores[i] > valor) then begin
suc.tope := suc.tope + 1;
for j:= suc.tope downto i+1 do
suc.valores[j] := suc.valores[j-1];   
suc.valores[i] := valor;
res.quePaso := Agregado;
res.posicion := i;   
end;
end;
end;
end;

FUNCTION EstaEnSucesion (suc: Sucesion; valor: Natural): boolean;
var i: integer;
begin
i:= 1;
if suc.tope > 0 then begin
while (i <= suc.tope) and (suc.valores[i] <> valor) do (*Busca el valor en el arreglo*)
i:= i +1;
EstaEnSucesion:= i <= suc.tope;    
end else
EstaEnSucesion := false;    
end;

FUNCTION SucesionesIguales (suc1, suc2 : Sucesion) : boolean;
var i: integer;
begin
i:= 1;
if (suc1.tope <> suc2.tope) then  (*Si el tope es distinto ya se sabe que no son iguales*)
SucesionesIguales:= false
else begin
while (i <= suc1.tope) and (suc1.valores[i] = suc2.valores[i])  do
i:= i + 1; 
SucesionesIguales := i > suc1.tope;
end;    
end;

FUNCTION CardinalInterseccion(suc1,suc2: Sucesion): integer; (*Funcion auxiliar que devuelve el cardinal de la interseccion de los conjuntos*)
var contador,k, j : integer;
begin
k:=1;
contador := suc1.tope + suc2.tope;
for j:= 1 to suc1.tope do begin
for k:=1 to suc2.tope do begin
if (suc1.valores[j] = suc2.valores[k]) then 
contador := contador - 1
end;  
end;
CardinalInterseccion := contador;
end;

function estaenlista(suc1,suc2 : sucesion; k : integer): boolean; (*Funcion auxiliar para buscar si un valor ya fue ingresado en el arreglo suc1*)
var q : integer;
begin
q:= 1;
while (q <= suc1.tope) and (suc2.valores[k] <> suc1.valores[q]) do 
q:= q + 1;   
estaenlista := q <= suc1.tope;
end;


procedure OrdenarSucesion(var suc1:sucesion); (*Funcion auxiliar que ordena un arreglo de menor a mayor*)
var k,j,aux : integer;
begin
 for k:= 2 to suc1.tope do begin
    j := k;
  while (j >= 2) and (suc1.valores[j] < suc1.valores[j-1]) do begin
  aux:= suc1.valores[j];
  suc1.valores[j] := suc1.valores[j-1];
  suc1.valores[j-1]:= aux;
  j:= j - 1;
end;  
end;

end; 


PROCEDURE FusionarSucesiones (suc1, suc2 : Sucesion; VAR suc3 : Sucesion; VAR res: resultado);
var i,k,z : integer;
begin
(*Verifico que suc3 tiene espacio*)
if CardinalInterseccion(suc1,suc2) > MAX then
res.quePaso := Fallo
else begin
suc3.tope := CardinalInterseccion(suc1, suc2);
(*Asigno suc1 a suc3*)
for i:= 1 to suc1.tope  do 
suc3.valores[i]:= suc1.valores[i];
z := suc1.tope;

(*Asigno suc2 a suc3 (si el valor no existe actualmente en suc3)*)
if suc2.tope > 0 then begin
for k:= 1  to suc2.tope do begin
if (estaenlista(suc3,suc2,k) = false) then  begin
z:= z+1;
suc3.valores[z]:= suc2.valores[k]; 
end;
end;   
(*Aplico la Ordenacion*)
OrdenarSucesion(suc3); 
end;
res.quePaso := Creado;
end;
end;


PROCEDURE CrearLista (VAR col : ListaSucesiones);
var p:ListaSucesiones;
begin
p:= nil;
col:= p;
end;

PROCEDURE AgregarSucesion (VAR lst : ListaSucesiones; suc : Sucesion; VAR pos : Natural);
var l,p,z : ListaSucesiones;
    contador: Natural;
begin
p:= lst;
contador := 1;
if p = nil then begin (*Separo aparte el caso de que p sea nil*)
new(l);
l^.suc:= suc;
l^.sig:= nil;
p:= l;
lst:= p; 
pos:= contador; 
end else begin (*Ahora me ocupo de los casos restantes donde p <> nil*)
while (p^.sig <> nil) do begin
p:= p^.sig;
contador:= contador + 1;  
end;  
new(z);
z^.suc:= suc;
z^.sig:= nil;
p^.sig := z;
pos:= contador + 1;
end;
end;


FUNCTION TodasIguales (lst : ListaSucesiones) : boolean;
var p,k : ListaSucesiones;
begin
p:= lst;
if p = nil then 
TodasIguales:= true 
else begin
k:= lst^.sig;
while (k <> nil) and (SucesionesIguales(p^.suc,k^.suc) = true) do (*Comparo las sucesiones mediante la funcion creada para ello*)
k:= k^.sig;
TodasIguales:= k = nil;
end;
end;

PROCEDURE FusionarEnLista (VAR lst : ListaSucesiones; pos1, pos2 : Natural; VAR res : Resultado);
var p,pivot1,pivot2,q : ListaSucesiones;
    contador, contador2,contador3,z,k,i : integer;
    nuevasuc: sucesion;
begin
contador := 1;
p:= lst;
(*Calculo el largo de la lista*)
if p <> nil then begin
while (p^.sig <> nil) do  begin
contador:= contador + 1;
p:= p^.sig;  
end;
(*Verifico que las posiciones sean Validas*)
if ((0 < pos1) and (pos1 <= contador)) and ((0 < pos2) and (pos2 <= contador)) then begin
pivot1:= lst;
pivot2:= lst;
contador2:= 1;
contador3:= 1;
(*Busca la posicion de pos1 en la lista*)
while (pivot1^.sig <> nil) and (contador2 <> pos1) do  begin
contador2:= contador2 + 1;
pivot1:= pivot1^.sig;  
end;
(*Busca la posicion de pos2 en la lista*)
while (pivot2^.sig <> nil) and (contador3 <> pos2) do  begin
contador3:= contador3 + 1;
pivot2:= pivot2^.sig;  
end;
(*Aplico la fusion de sucesiones creada anteriormente*)
if CardinalInterseccion(pivot1^.suc,pivot2^.suc) > MAX then
res.quePaso := Fallo
else begin
nuevasuc.tope := CardinalInterseccion(pivot1^.suc,pivot2^.suc);
(*Asigno suc1 a suc3*)
for i:= 1 to pivot1^.suc.tope do 
nuevasuc.valores[i]:= pivot1^.suc.valores[i];
z := pivot1^.suc.tope;

(*Asigno suc2 a suc3 si ya no pertenecia a el*)
if pivot2^.suc.tope > 0 then begin
for k:= 1  to pivot2^.suc.tope do begin
if (estaenlista(nuevasuc,pivot2^.suc,k) = false) then  begin
z:= z+1;
nuevasuc.valores[z]:= pivot2^.suc.valores[k]; 
end;
end;   
(*Ordenacion*)
OrdenarSucesion(nuevasuc); 
end;
(*Agrego la nueva suce*)
new(q); 
q^.suc:= nuevasuc;
q^.sig := nil;
p^.sig := q;
res.quePaso := Agregado;
res.posicion:= contador + 1;

end;
end else 
res.quePaso:= Fallo;
end else
res.quePaso:= Fallo;
end;

(*Martin Olazabal*)
