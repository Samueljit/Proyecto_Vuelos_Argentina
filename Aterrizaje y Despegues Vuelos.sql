SELECT *
FROM Aterrizaje_Despegue..Vuelo_2020

--Buscaremos la Cantidad de Vuelos Realizados por a�o-- 

SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2019' as A�o
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE ID_viaje is not null and not [Clasificaci�n Vuelo] = 'N/A'
UNION
SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2020' as A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE ID_viaje is not null and not [Clasificaci�n Vuelo] = 'N/A'
UNION
SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2021' as A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE ID_viaje is not null and not [Clasificación Vuelo] = 'N/A'
order by 2

--Cantidad De vuelos Internacionales y nacionales por a�o--


SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificaci�n Vuelo] as Clasificaci�nDeVuelo,
A�o
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE not [Clasificaci�n Vuelo] = 'N/A'
GROUP BY [Clasificaci�n Vuelo], A�o
UNION
SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificaci�n Vuelo] as Clasificaci�nDeVuelo,
A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci�n Vuelo] = 'N/A'
GROUP BY [Clasificaci�n Vuelo], A�o
Union
SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificación Vuelo] as Clasificaci�nDeVuelo, A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificación Vuelo] = 'N/A'
GROUP BY [Clasificación Vuelo], A�o
ORDER BY A�o


--PORCENTAJE de vuelos nacionales vs internacionales en cada a�o--

-- 1era variable--
DROP Table if exists #CantidadVuelosNacionales
Create Table #CantidadVuelosNacionales
(
Cantidad_vuelos_nacionales int,
Clasificaci�n_de_vuelo nvarchar(50),
A�o int
)

Insert into #CantidadVuelosNacionales
SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosNacionales,
[Clasificaci�n Vuelo], A�o
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE  [Clasificaci�n Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci�n Vuelo], A�o

--2 variable--
DROP Table if exists #CantidadVuelosInternacionales
Create Table #CantidadVuelosInternacionales
(
Cantidad_vuelos_internacionales int,
Clasificaci�n_de_vuelo nvarchar(50),
A�o int,
Cantidad_vuelos_totales int
)

Insert into #CantidadVuelosInternacionales
SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosNacionales,
[Clasificaci�n Vuelo], A�o, '0'
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE  [Clasificaci�n Vuelo] = 'Internacional'
GROUP BY  [Clasificaci�n Vuelo], A�o

UPDATE #CantidadVuelosInternacionales set Cantidad_vuelos_totales = 393429 where Cantidad_vuelos_totales = 0

select * from  #CantidadVuelosInternacionales
SELECT * from #CantidadVuelosNacionales


--Porcentaje de vuelos intnernacionales y nacionales del a�o 2019--


SELECT CVI.Cantidad_vuelos_totales, CVI.Cantidad_vuelos_internacionales,
(cast(Cantidad_vuelos_internacionales as decimal)/convert(decimal,Cantidad_vuelos_totales))*100 as Porcentaje_vuelos_internacionales,
CVI.A�o
FROM #CantidadVuelosInternacionales CVI INNER JOIN
#CantidadVuelosNacionales cvn ON CVI.A�o=cvn.A�o
GROUP BY Cantidad_vuelos_internacionales, CVI.A�o, Cantidad_vuelos_totales

SELECT CVI.Cantidad_vuelos_totales, CVN.Cantidad_vuelos_nacionales,
(cast(Cantidad_vuelos_nacionales as decimal)/cast(Cantidad_vuelos_totales as decimal))*100 as Porcentaje_vuelos_Nacionales,
CVI.A�o
FROM #CantidadVuelosInternacionales CVI INNER JOIN
#CantidadVuelosNacionales cvn ON CVI.A�o=cvn.A�o
GROUP BY Cantidad_vuelos_nacionales, CVI.A�o, Cantidad_vuelos_totales


--porcentaje vuelos nacionales e internacionales a�o 2020--

SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosNacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci�n Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci�n Vuelo], A�o


SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosInternacionales,
[Clasificaci�n Vuelo], A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci�n Vuelo] = 'Internacional'
GROUP BY  [Clasificaci�n Vuelo], A�o

SELECT COUNT(ID_viaje) as CantidadTotalViaje, A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci�n Vuelo] = 'N/A'
GROUP BY A�o

DROP TABLE IF exists #CantidadVuelosNacionales2020
CREATE table #CantidadVuelosNacionales2020
(
CantidadVuelosNacionales decimal,
A�o int
)
INSERT INTO #CantidadVuelosNacionales2020
SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosNacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci�n Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci�n Vuelo], A�o

SELECT * FROM #CantidadVuelosNacionales2020

DROP  table if exists #CantidadVuelosInternacionales2020
CREATE table #CantidadVuelosInternacionales2020
(
CantidadVuelosInternacionales decimal,
A�o int
)
INSERT INTO #CantidadVuelosInternacionales2020
SELECT COUNT([Clasificaci�n Vuelo]) as CantidadVuelosInternacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci�n Vuelo] = 'Internacional'
GROUP BY  [Clasificaci�n Vuelo], A�o

SELECT * FROM #CantidadVuelosInternacionales2020

DROP  table if exists #CantidadVuelosTotales2020
CREATE table #CantidadVuelosTotales2020
(
CantidadVuelosTotales decimal,
A�o int
)
INSERT INTO #CantidadVuelosTotales2020
SELECT COUNT(ID_viaje) as CantidadTotalViaje, A�o
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci�n Vuelo] = 'N/A'
GROUP BY A�o

SELECT * FROM #CantidadVuelosTotales2020

SELECT T.CantidadVuelosTotales, n.CantidadVuelosNacionales,
n.CantidadVuelosNacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosNacionales,
t.A�o
FROM #CantidadVuelosTotales2020 T INNER JOIN #CantidadVuelosInternacionales2020 I
ON T.A�o=I.A�o INNER JOIN #CantidadVuelosNacionales2020 N
ON I.A�o=N.A�o

SELECT T.CantidadVuelosTotales, I.CantidadVuelosInternacionales,
I.CantidadVuelosInternacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosInternacionales,
T.A�o
FROM #CantidadVuelosTotales2020 T INNER JOIN #CantidadVuelosInternacionales2020 I
ON T.A�o=I.A�o INNER JOIN #CantidadVuelosNacionales2020 N
ON I.A�o=N.A�o

--porcentaje vuelos nacionales e internacionales a�o 2021--

SELECT COUNT([Clasificación Vuelo]) as CantidadVuelosNacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificación Vuelo] = 'Cabotaje'
GROUP BY  [Clasificación Vuelo], A�o


SELECT COUNT([Clasificación Vuelo]) as CantidadVuelosInternacionales,
[Clasificación Vuelo], A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificación Vuelo] = 'Internacional'
GROUP BY  [Clasificación Vuelo], A�o

SELECT COUNT(ID_viaje) as CantidadTotalViaje, A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificación Vuelo] = 'N/A'
GROUP BY A�o

DROP TABLE IF exists #CantidadVuelosNacionales2021
CREATE table #CantidadVuelosNacionales2021
(
CantidadVuelosNacionales decimal,
A�o int
)
INSERT INTO #CantidadVuelosNacionales2020
SELECT COUNT([Clasificación Vuelo]) as CantidadVuelosNacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificación Vuelo] = 'Cabotaje'
GROUP BY  [Clasificación Vuelo], A�o

SELECT * FROM #CantidadVuelosNacionales2021

DROP  table if exists #CantidadVuelosInternacionales2021
CREATE table #CantidadVuelosInternacionales2021
(
CantidadVuelosInternacionales decimal,
A�o int
)
INSERT INTO #CantidadVuelosInternacionales2020
SELECT COUNT([Clasificación Vuelo]) as CantidadVuelosInternacionales,
 A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificación Vuelo] = 'Internacional'
GROUP BY  [Clasificación Vuelo], A�o

SELECT * FROM #CantidadVuelosInternacionales2021

DROP  table if exists #CantidadVuelosTotales2021
CREATE table #CantidadVuelosTotales2021
(
CantidadVuelosTotales decimal,
A�o int
)
INSERT INTO #CantidadVuelosTotales2020
SELECT COUNT(ID_viaje) as CantidadTotalViaje, A�o
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificación Vuelo] = 'N/A'
GROUP BY A�o

SELECT * FROM #CantidadVuelosTotales2021

SELECT T.CantidadVuelosTotales, n.CantidadVuelosNacionales,
n.CantidadVuelosNacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosNacionales,
t.A�o
FROM #CantidadVuelosTotales2021 T INNER JOIN #CantidadVuelosInternacionales2021 I
ON T.A�o=I.A�o INNER JOIN #CantidadVuelosNacionales2021 N
ON I.A�o=N.A�o

SELECT T.CantidadVuelosTotales, I.CantidadVuelosInternacionales,
I.CantidadVuelosInternacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosInternacionales,
T.A�o
FROM #CantidadVuelosTotales2021 T INNER JOIN #CantidadVuelosInternacionales2021 I
ON T.A�o=I.A�o INNER JOIN #CantidadVuelosNacionales2021 N
ON I.A�o=N.A�o

--CREO Variables para Porcentaje de viajes totales por per�odo--

SELECT * FROM Aterrizaje_Despegue..BD_Vuelos

SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo
FROM BD_Vuelos
WHERE Per�odo like 'P%na'
GROUP BY Per�odo
UNION
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo
FROM BD_Vuelos
WHERE Per�odo like 'Cuarentena'
GROUP BY Per�odo
UNION
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo
FROM BD_Vuelos
WHERE Per�odo like 'Post Cua%'
GROUP BY Per�odo

DROP TABLE IF exists #Precuarentena
CREATE TABLE #Precuarentena
(
CantidadVuelos int,
Per�odo nvarchar (50),
ClaveRelacion int
)

INSERT INTO #Precuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo, 1
FROM BD_Vuelos
WHERE Per�odo like 'P%na'
GROUP BY Per�odo

DROP TABLE IF exists #Cuarentena
CREATE TABLE #Cuarentena
(
CantidadVuelos int,
Per�odo nvarchar (50),
ClaveRelacion int
)

INSERT INTO #Cuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo, 1
FROM BD_Vuelos
WHERE Per�odo like 'Cuarentena'
GROUP BY Per�odo

DROP TABLE IF exists #PostCuarentena
CREATE TABLE #PostCuarentena
(
CantidadVuelos int,
Per�odo nvarchar (50),
ClaveRelacion int
)

INSERT INTO #PostCuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per�odo, COUNT(ID_Viaje)-3805 as ClaveRelacion
FROM BD_Vuelos
WHERE Per�odo like 'Post Cua%'
GROUP BY Per�odo

SELECT pr.CantidadVuelos as Precuarentena, C.CantidadVuelos Cuarentena,
(CAST(C.CantidadVuelos as float)/CAST(PR.CantidadVuelos as float)*100) as Porcentaje_Precuarentena_vs_Cuarentena
FROM #Precuarentena PR
INNER JOIN #Cuarentena C
ON PR.ClaveRelacion=C.ClaveRelacion
INNER JOIN #PostCuarentena P
ON C.ClaveRelacion=P.ClaveRelacion

--PRUEBA--
DROP TABLE IF exists #Prueba
CREATE TABLE #Prueba	
( PRec int,
Porcentaje float,
ClaveRelacion int
)
INSERT INTO #Prueba
SELECT pr.CantidadVuelos as Precuarentena,
(CAST(C.CantidadVuelos as float)/CAST(PR.CantidadVuelos as float)*100) as Porcentaje_Precuarentena_vs_Cuarentena,1
FROM #Precuarentena PR
INNER JOIN #Cuarentena C
ON PR.ClaveRelacion=C.ClaveRelacion
INNER JOIN #PostCuarentena P
ON C.ClaveRelacion=P.ClaveRelacion


SELECT pr.CantidadVuelos as Precuarentena, C.CantidadVuelos Cuarentena, A.Porcentaje as PorcentajeCuarentena,
TRIM(REPLACE(a.Porcentaje-100,'-','')) as Porcentaje_Caida_Vuelos_PrecuarentenaVSCuarentena
FROM #Precuarentena PR
INNER JOIN #Cuarentena C
ON PR.ClaveRelacion=C.ClaveRelacion
INNER JOIN #PostCuarentena P
ON C.ClaveRelacion=P.ClaveRelacion INNER JOIN #Prueba A ON P.ClaveRelacion=A.ClaveRelacion


