SELECT *
FROM Aterrizaje_Despegue..Vuelo_2020

--Buscaremos la Cantidad de Vuelos Realizados por a駉-- 

SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2019' as A駉
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE ID_viaje is not null and not [Clasificaci髇 Vuelo] = 'N/A'
UNION
SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2020' as A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE ID_viaje is not null and not [Clasificaci髇 Vuelo] = 'N/A'
UNION
SELECT DISTINCT COUNT(ID_viaje) as CantidadViajesRealizados, '2021' as A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE ID_viaje is not null and not [Clasificaci贸n Vuelo] = 'N/A'
order by 2

--Cantidad De vuelos Internacionales y nacionales por a駉--


SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificaci髇 Vuelo] as Clasificaci髇DeVuelo,
A駉
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE not [Clasificaci髇 Vuelo] = 'N/A'
GROUP BY [Clasificaci髇 Vuelo], A駉
UNION
SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificaci髇 Vuelo] as Clasificaci髇DeVuelo,
A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci髇 Vuelo] = 'N/A'
GROUP BY [Clasificaci髇 Vuelo], A駉
Union
SELECT DISTINCT COUNT(ID_viaje) as ID_Viaje,[Clasificaci贸n Vuelo] as Clasificaci髇DeVuelo, A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificaci贸n Vuelo] = 'N/A'
GROUP BY [Clasificaci贸n Vuelo], A駉
ORDER BY A駉


--PORCENTAJE de vuelos nacionales vs internacionales en cada a駉--

-- 1era variable--
DROP Table if exists #CantidadVuelosNacionales
Create Table #CantidadVuelosNacionales
(
Cantidad_vuelos_nacionales int,
Clasificaci髇_de_vuelo nvarchar(50),
A駉 int
)

Insert into #CantidadVuelosNacionales
SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosNacionales,
[Clasificaci髇 Vuelo], A駉
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE  [Clasificaci髇 Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci髇 Vuelo], A駉

--2 variable--
DROP Table if exists #CantidadVuelosInternacionales
Create Table #CantidadVuelosInternacionales
(
Cantidad_vuelos_internacionales int,
Clasificaci髇_de_vuelo nvarchar(50),
A駉 int,
Cantidad_vuelos_totales int
)

Insert into #CantidadVuelosInternacionales
SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosNacionales,
[Clasificaci髇 Vuelo], A駉, '0'
FROM Aterrizaje_Despegue..Vuelo_2019
WHERE  [Clasificaci髇 Vuelo] = 'Internacional'
GROUP BY  [Clasificaci髇 Vuelo], A駉

UPDATE #CantidadVuelosInternacionales set Cantidad_vuelos_totales = 393429 where Cantidad_vuelos_totales = 0

select * from  #CantidadVuelosInternacionales
SELECT * from #CantidadVuelosNacionales


--Porcentaje de vuelos intnernacionales y nacionales del a駉 2019--


SELECT CVI.Cantidad_vuelos_totales, CVI.Cantidad_vuelos_internacionales,
(cast(Cantidad_vuelos_internacionales as decimal)/convert(decimal,Cantidad_vuelos_totales))*100 as Porcentaje_vuelos_internacionales,
CVI.A駉
FROM #CantidadVuelosInternacionales CVI INNER JOIN
#CantidadVuelosNacionales cvn ON CVI.A駉=cvn.A駉
GROUP BY Cantidad_vuelos_internacionales, CVI.A駉, Cantidad_vuelos_totales

SELECT CVI.Cantidad_vuelos_totales, CVN.Cantidad_vuelos_nacionales,
(cast(Cantidad_vuelos_nacionales as decimal)/cast(Cantidad_vuelos_totales as decimal))*100 as Porcentaje_vuelos_Nacionales,
CVI.A駉
FROM #CantidadVuelosInternacionales CVI INNER JOIN
#CantidadVuelosNacionales cvn ON CVI.A駉=cvn.A駉
GROUP BY Cantidad_vuelos_nacionales, CVI.A駉, Cantidad_vuelos_totales


--porcentaje vuelos nacionales e internacionales a駉 2020--

SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosNacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci髇 Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci髇 Vuelo], A駉


SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosInternacionales,
[Clasificaci髇 Vuelo], A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci髇 Vuelo] = 'Internacional'
GROUP BY  [Clasificaci髇 Vuelo], A駉

SELECT COUNT(ID_viaje) as CantidadTotalViaje, A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci髇 Vuelo] = 'N/A'
GROUP BY A駉

DROP TABLE IF exists #CantidadVuelosNacionales2020
CREATE table #CantidadVuelosNacionales2020
(
CantidadVuelosNacionales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosNacionales2020
SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosNacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci髇 Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci髇 Vuelo], A駉

SELECT * FROM #CantidadVuelosNacionales2020

DROP  table if exists #CantidadVuelosInternacionales2020
CREATE table #CantidadVuelosInternacionales2020
(
CantidadVuelosInternacionales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosInternacionales2020
SELECT COUNT([Clasificaci髇 Vuelo]) as CantidadVuelosInternacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE  [Clasificaci髇 Vuelo] = 'Internacional'
GROUP BY  [Clasificaci髇 Vuelo], A駉

SELECT * FROM #CantidadVuelosInternacionales2020

DROP  table if exists #CantidadVuelosTotales2020
CREATE table #CantidadVuelosTotales2020
(
CantidadVuelosTotales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosTotales2020
SELECT COUNT(ID_viaje) as CantidadTotalViaje, A駉
FROM Aterrizaje_Despegue..Vuelo_2020
WHERE not [Clasificaci髇 Vuelo] = 'N/A'
GROUP BY A駉

SELECT * FROM #CantidadVuelosTotales2020

SELECT T.CantidadVuelosTotales, n.CantidadVuelosNacionales,
n.CantidadVuelosNacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosNacionales,
t.A駉
FROM #CantidadVuelosTotales2020 T INNER JOIN #CantidadVuelosInternacionales2020 I
ON T.A駉=I.A駉 INNER JOIN #CantidadVuelosNacionales2020 N
ON I.A駉=N.A駉

SELECT T.CantidadVuelosTotales, I.CantidadVuelosInternacionales,
I.CantidadVuelosInternacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosInternacionales,
T.A駉
FROM #CantidadVuelosTotales2020 T INNER JOIN #CantidadVuelosInternacionales2020 I
ON T.A駉=I.A駉 INNER JOIN #CantidadVuelosNacionales2020 N
ON I.A駉=N.A駉

--porcentaje vuelos nacionales e internacionales a駉 2021--

SELECT COUNT([Clasificaci贸n Vuelo]) as CantidadVuelosNacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificaci贸n Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci贸n Vuelo], A駉


SELECT COUNT([Clasificaci贸n Vuelo]) as CantidadVuelosInternacionales,
[Clasificaci贸n Vuelo], A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificaci贸n Vuelo] = 'Internacional'
GROUP BY  [Clasificaci贸n Vuelo], A駉

SELECT COUNT(ID_viaje) as CantidadTotalViaje, A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificaci贸n Vuelo] = 'N/A'
GROUP BY A駉

DROP TABLE IF exists #CantidadVuelosNacionales2021
CREATE table #CantidadVuelosNacionales2021
(
CantidadVuelosNacionales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosNacionales2020
SELECT COUNT([Clasificaci贸n Vuelo]) as CantidadVuelosNacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificaci贸n Vuelo] = 'Cabotaje'
GROUP BY  [Clasificaci贸n Vuelo], A駉

SELECT * FROM #CantidadVuelosNacionales2021

DROP  table if exists #CantidadVuelosInternacionales2021
CREATE table #CantidadVuelosInternacionales2021
(
CantidadVuelosInternacionales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosInternacionales2020
SELECT COUNT([Clasificaci贸n Vuelo]) as CantidadVuelosInternacionales,
 A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE  [Clasificaci贸n Vuelo] = 'Internacional'
GROUP BY  [Clasificaci贸n Vuelo], A駉

SELECT * FROM #CantidadVuelosInternacionales2021

DROP  table if exists #CantidadVuelosTotales2021
CREATE table #CantidadVuelosTotales2021
(
CantidadVuelosTotales decimal,
A駉 int
)
INSERT INTO #CantidadVuelosTotales2020
SELECT COUNT(ID_viaje) as CantidadTotalViaje, A駉
FROM Aterrizaje_Despegue..Vuelo_2021
WHERE not [Clasificaci贸n Vuelo] = 'N/A'
GROUP BY A駉

SELECT * FROM #CantidadVuelosTotales2021

SELECT T.CantidadVuelosTotales, n.CantidadVuelosNacionales,
n.CantidadVuelosNacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosNacionales,
t.A駉
FROM #CantidadVuelosTotales2021 T INNER JOIN #CantidadVuelosInternacionales2021 I
ON T.A駉=I.A駉 INNER JOIN #CantidadVuelosNacionales2021 N
ON I.A駉=N.A駉

SELECT T.CantidadVuelosTotales, I.CantidadVuelosInternacionales,
I.CantidadVuelosInternacionales/T.CantidadVuelosTotales*100 as PorcentajeVuelosInternacionales,
T.A駉
FROM #CantidadVuelosTotales2021 T INNER JOIN #CantidadVuelosInternacionales2021 I
ON T.A駉=I.A駉 INNER JOIN #CantidadVuelosNacionales2021 N
ON I.A駉=N.A駉

--CREO Variables para Porcentaje de viajes totales por per韔do--

SELECT * FROM Aterrizaje_Despegue..BD_Vuelos

SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do
FROM BD_Vuelos
WHERE Per韔do like 'P%na'
GROUP BY Per韔do
UNION
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do
FROM BD_Vuelos
WHERE Per韔do like 'Cuarentena'
GROUP BY Per韔do
UNION
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do
FROM BD_Vuelos
WHERE Per韔do like 'Post Cua%'
GROUP BY Per韔do

DROP TABLE IF exists #Precuarentena
CREATE TABLE #Precuarentena
(
CantidadVuelos int,
Per韔do nvarchar (50),
ClaveRelacion int
)

INSERT INTO #Precuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do, 1
FROM BD_Vuelos
WHERE Per韔do like 'P%na'
GROUP BY Per韔do

DROP TABLE IF exists #Cuarentena
CREATE TABLE #Cuarentena
(
CantidadVuelos int,
Per韔do nvarchar (50),
ClaveRelacion int
)

INSERT INTO #Cuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do, 1
FROM BD_Vuelos
WHERE Per韔do like 'Cuarentena'
GROUP BY Per韔do

DROP TABLE IF exists #PostCuarentena
CREATE TABLE #PostCuarentena
(
CantidadVuelos int,
Per韔do nvarchar (50),
ClaveRelacion int
)

INSERT INTO #PostCuarentena
SELECT DISTINCT COUNT(ID_VIaje) as CantidadVuelos,Per韔do, COUNT(ID_Viaje)-3805 as ClaveRelacion
FROM BD_Vuelos
WHERE Per韔do like 'Post Cua%'
GROUP BY Per韔do

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


