
%ligaT(cidade1,cidade2,distancia).
%ligaA(cidade1,cidade2,distancia).

ligaT(amesterdam,brussels,210).
ligaT(amesterdam,paris,501).

ligaT(andorra,ljubljana,1430).
ligaT(andorra,madrid,609).
ligaT(andorra,paris,861).

ligaT(berlin,copenhagen,356).
ligaT(berlin,paris,1048).
ligaT(berlin,prague,351).
ligaT(berlin,tallin,1042).
ligaT(berlin,warsaw,572).

ligaT(bratislava,budapest,200).
ligaT(bratislava,vienna,79).

ligaT(brussels,amesterdam,210).

ligaT(budapest,bratislava,200).

ligaT(copenhagen,berlin,356).
ligaT(copenhagen,oslo,606).
ligaT(copenhagen,stockholm,657).

ligaT(dublin,paris,1083).

ligaT(lisbon,madrid,625).
ligaT(lisbon,porto,313).

ligaT(ljubljana,andorra,1430).
ligaT(ljubljana,vienna,384).
ligaT(ljubljana,zagreb,140).

ligaT(london,paris,464).

ligaT(luxembourg,paris,374).

ligaT(madrid,andorra,609).
ligaT(madrid,lisbon,625).
ligaT(madrid,paris,1276).
ligaT(madrid,porto,561).

ligaT(oslo,copenhagen,606).
ligaT(oslo,stockholm,521).

ligaT(paris,amesterdam,501).
ligaT(paris,andorra,861).
ligaT(paris,berlin,1048).
ligaT(paris,brussels,314).
ligaT(paris,dublin,1083).
ligaT(paris,london,464).
ligaT(paris,luxembourg,374).
ligaT(paris,madrid,1276).
ligaT(paris,rome,1424).
ligaT(paris,vienna,1236).

ligaT(porto,lisbon,313).
ligaT(porto,madrid,561).

ligaT(prague,berlin,351).
ligaT(prague,vienna,309).

ligaT(riga,berlin,351).
ligaT(riga,vilnius,302).

ligaT(rome,paris,1424).

ligaT(tallin,riga,309).

ligaT(vienna,bratislava,79).
ligaT(vienna,ljubljana,384).
ligaT(vienna,paris,1236).
ligaT(vienna,prague,309).

ligaT(vilnius,riga,302).
ligaT(vilnius,warsaw,459).

ligaT(warsaw,vilnius,459).

ligaT(zagreb,ljubljana,140).

% Dados Avioes

ligaA(amesterdam,paris,430).

ligaA(berlim,paris,878).

ligaA(copenhagen,helsinki,884).
ligaA(copenhagen,oslo,484).
ligaA(copenhagen,stockholm,523).

ligaA(dublin,paris,836).

ligaA(helsinki,copenhagen,884).

ligaA(lisbon,madrid,503).

ligaA(london,paris,344).

ligaA(madrid,lisbon,503).
ligaA(madrid,paris,1054).

ligaA(oslo,copenhagen,484).

ligaA(paris,amesterdam,430).
ligaA(paris,berlin,878).
ligaA(paris,dublin,836).
ligaA(paris,london,344).
ligaA(paris,madrid,1054).
ligaA(paris,rome,1107).
ligaA(paris,vienna,1035).

ligaA(rome,paris,1107).

ligaA(stockolm,copenhagen,523).

ligaA(vienna,paris,1035).


% predicados auxiliares
% X e 
membro(X,[X|_]).
membro(X,[_|Y]):-membro(X,Y).