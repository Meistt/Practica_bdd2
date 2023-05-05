USE AdventureWorks;

-- 1 Listar los códigos y descripciones de todos los productos
SELECT p.ProductNumber AS NUMERO_PRODUCTO, p.Name AS NOMBRE_PRODUCTO
FROM Production.Product p;

-- 2 Listar los datos de la subcategoría número 17
SELECT* 
FROM Production.ProductSubCategory sc
WHERE sc.ProductSubcategoryID = 17;

-- 3 Listar los productos cuya descripción comience con D
SELECT*
FROM Production.Product p
WHERE p.Name LIKE('D%');

-- 4 Listar las descripciones de los productos cuyo número finalice
SELECT*
FROM Production.Product p
WHERE p.ProductNumber LIKE('%8');

-- 5 Listar aquellos productos que posean un color asignado. Se deberán excluir todos aquellos que no posean ningún valor.
SELECT*
FROM Production.Product p
WHERE P.Color IS NOT NULL;

-- 6 Listar el código y descripción de los productos de color Black (Negro) y que posean el nivel de stock en 500.
SELECT p.Name AS NOMBRE_PRODUCTO, p.ProductNumber AS NUMERO_PRODUCTO, p.SafetyStockLevel AS STOCK
FROM Production.Product p
WHERE P.Color LIKE('%Black%') AND p.SafetyStockLevel = 500;

-- 7 Listar los productos que sean de color Black (Negro) ó Silver.
SELECT*
FROM Production.Product p
WHERE P.Color IN('Black','Silver'); -- (136)

-- 8 Listar los diferentes colores que posean asignados los productos. Sólo se deben listar los colores.
SELECT DISTINCT P.Color
FROM Production.Product p 
WHERE p.Color IS NOT NULL; -- AGREGUÉ IS NOT NULL PQ HAY UN COLOR NULL

-- 9 Contar la cantidad de categorías que se encuentren cargadas en la base.

SELECT COUNT(p.ProductCategoryID)AS CANTIDAD_CATEGORIAS
FROM Production.ProductCategory p;

-- 10 Contar la cantidad de subcategorías que posee asignada la categoría 2
SELECT COUNT(sc.ProductSubcategoryID) CANTIDAD_CATEGORIAS_2
FROM Production.ProductSubcategory sc
WHERE sc.ProductCategoryID = 2;

-- 11 Listar la cantidad de productos que existan por cada uno de los colores.
SELECT p.Color AS COLOR , COUNT(p.ProductID) AS CANTIDAD_PRODUCTOS_ASOCIADOS
FROM Production.Product p 
WHERE p.Color IS NOT NULL
GROUP BY(p.Color);

-- verificar cantidad
SELECT COUNT(*) CANTIDAD FROM Production.Product WHERE Product.Color = 'Grey';

-- 12 Sumar todos los niveles de stocks aceptables que deben existir para los productos con color Black. (CONSULTAR)
SELECT SUM(p.ProductID) AS CANTIDAD_STOCK_TOTAL_NEGRO, p.Color AS COLOR
FROM Production.Product P
WHERE p.Color = 'Black'
GROUP BY(p.Color);

-- 13 Calcular el promedio de stock que se debe tener de todos los productos cuyo código se encuentre entre el 316 y 320.
SELECT AVG(P.SafetyStockLevel) AS PROMEDIO_STOCK
FROM Production.Product P
WHERE P.ProductID BETWEEN 316 AND 320; -- 660

-- 14 Listar el nombre del producto y descripción de la subcategoría que posea asignada.
SELECT p.ProductNumber AS NUMERO_PRODUCTO, SC.NAME AS DESCRIPCION_SUBCATEGORIA
FROM Production.Product P JOIN Production.ProductSubcategory SC ON P.ProductID = SC.ProductCategoryID;

-- 15 Listar todas las categorías que poseen asignado al menos una subcategoría. Se deberán excluir aquellas que no posean ninguna //CONSULTAR SI ES LO MISMO, DUDA
SELECT PC.PRODUCTCATEGORYID AS CATEGORIA, PC.Name AS NOMBRE_CATEGORIA, SC.ProductSubcategoryID AS PRODUCT_SUBCATEGORY_ID_SC, SC.ProductCategoryID AS PRODUCT_CATEGORY_ID_SC, SC.NAME AS NOMBRE_SUBCATEGORIA
FROM Production.ProductCategory PC JOIN Production.ProductSubcategory SC ON PC.ProductCategoryID = SC.ProductCategoryID;




SELECT p.ProductNumber AS NUMERO_PRODUCTO, SC.NAME AS DESCRIPCION_SUBCATEGORIA
FROM Production.Product P JOIN Production.ProductSubcategory SC ON P.ProductID = SC.ProductCategoryID;

-- 16 istar el código y descripción de los productos que posean fotos asignadas. (Ayuda: Production.ProductPhoto)
SELECT P.PRODUCTNUMBER AS CODIGO_PRODUCTO, P.NAME AS DESCRIPCION_PRODUCTO
FROM Production.Product AS P JOIN Production.ProductPhoto PP ON P.ProductID = PP.ProductPhotoID;

-- 17 Listar la cantidad de productos que existan por cada una de las Clases (Ayuda: campo Class)
SELECT P.Class AS CLASE, COUNT(P.PRODUCTID) AS CANTIDAD_PRODUCTOS_POR_CLASE
FROM Production.Product P
WHERE p.Class IS NOT NULL 
GROUP BY P.Class;

-- 18 Listar la descripción de los productos y su respectivo color. Sólo nos interesa caracterizar al color con los valores: Black, Silver u Otro. Por lo cual si no es ni silver ni black se debe indicar Otro. (Ayuda: utilizar case)
SELECT P.PRODUCTNUMBER AS NUMERO_PRODUCTO, P.NAME AS PRODUCTO,
CASE
	WHEN P.COLOR LIKE 'Black' THEN 'BLACK'
	WHEN P.COLOR LIKE 'Silver' THEN 'SILVER'
	ELSE 'OTRO'
END AS COLOR_WHEN
FROM Production.Product P;

-- 19 Listar el nombre de la categoría, el nombre de la subcategoría y la descripción del producto.
SELECT PC.ProductCategoryID AS P_CATEGORY,PC.Name as NOMBRE_CATEGORIA, SC.ProductCategoryID AS P_CATEGORY_ID, SC.ProductSubcategoryID AS PS_CATEGORY_ID ,sc.NAME AS NOMBRE_SUBCATEGORIA, P.ProductID AS PRODUCT_ID,P.NAME AS NOMBRE_PRODUCTO
FROM Production.Product P
JOIN Production.ProductSubcategory SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN Production.ProductCategory PC ON PC.ProductCategoryID = SC.ProductCategoryID;

SELECT PC.Name as NOMBRE_CATEGORIA,sc.NAME AS NOMBRE_SUBCATEGORIA,P.NAME AS PRODUCTO
FROM Production.Product P
JOIN Production.ProductSubcategory SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN Production.ProductCategory PC ON PC.ProductCategoryID = SC.ProductCategoryID;

-- 20 Listar la cantidad de subcategorías que posean asignado los productos
SELECT* FROM Production.Product;
SELECT* FROM Production.ProductCategory;
SELECT* FROM Production.ProductSubcategory;
