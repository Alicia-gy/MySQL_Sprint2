USE universidad;
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%";
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND NIF LIKE "%K";
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, departamento.nombre AS nombre_departamento FROM persona AS p INNER JOIN profesor ON p.id = profesor.id_profesor INNER JOIN departamento ON profesor.id_departamento = departamento.id WHERE p.tipo = "profesor" ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT p.nombre, p.apellido1, p.apellido2, a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM persona AS p INNER JOIN alumno_se_matricula_asignatura AS m ON p.id = m.id_alumno INNER JOIN asignatura AS a ON m.id_asignatura = a.id INNER JOIN curso_escolar AS c ON m.id_curso_escolar = c.id WHERE p.tipo = "alumno" AND p.nif = "26902806M";
SELECT DISTINCT d.nombre AS departamento FROM departamento AS d INNER JOIN profesor AS p ON d.id = p.id_departamento INNER JOIN asignatura AS a ON p.id_profesor = a.id_profesor INNER JOIN grado AS g ON a.id_grado = g.id WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)"; 
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona AS p INNER JOIN alumno_se_matricula_asignatura AS m ON p.id = m.id_alumno INNER JOIN asignatura AS a ON m.id_asignatura = a.id INNER JOIN curso_escolar AS c ON m.id_curso_escolar = c.id WHERE c.anyo_inicio = 2018;

SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona AS p LEFT JOIN profesor ON profesor.id_profesor = p.id LEFT JOIN departamento AS d ON profesor.id_departamento = d.id WHERE p.tipo = "profesor" ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona AS p LEFT JOIN profesor ON profesor.id_profesor = p.id LEFT JOIN departamento AS d ON profesor.id_departamento = d.id WHERE p.tipo = "profesor" AND d.id IS NULL;
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona AS p RIGHT JOIN profesor ON profesor.id_profesor = p.id RIGHT JOIN departamento AS d ON profesor.id_departamento = d.id WHERE p.id IS NULL;
SELECT a.nombre AS asignatura, p.apellido1, p.apellido2, p.nombre FROM persona AS p LEFT JOIN asignatura AS a ON p.id = a.id_profesor WHERE p.tipo = "profesor" AND a.id IS NULL;
SELECT a.nombre AS asignatura, p.apellido1, p.apellido2, p.nombre FROM persona AS p RIGHT JOIN asignatura AS a ON p.id = a.id_profesor WHERE p.id IS NULL;
SELECT DISTINCT d.nombre AS departamento, a.nombre AS asignatura, a.curso FROM departamento AS d LEFT JOIN profesor AS pf ON d.id = pf.id_departamento LEFT JOIN persona AS p ON pf.id_profesor = p.id LEFT JOIN asignatura AS a ON p.id = a.id_profesor WHERE a.curso IS NULL;

SELECT COUNT(nombre) AS numero_alumnos FROM persona WHERE tipo = "alumno";
SELECT COUNT(nombre) AS numero_alumnos FROM persona WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%";
SELECT d.nombre AS departamento, COUNT(pf.id_profesor) AS numero_profesores FROM departamento AS d INNER JOIN profesor AS pf ON d.id = pf.id_departamento GROUP BY d.nombre ORDER BY numero_profesores DESC; 
SELECT d.nombre AS departamento, COUNT(pf.id_profesor) AS numero_profesores FROM departamento AS d LEFT JOIN profesor AS pf ON d.id = pf.id_departamento GROUP BY d.nombre ORDER BY numero_profesores DESC;
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre HAVING numero_asignaturas > 40;
SELECT g.nombre AS grado, a.tipo, SUM(a.creditos) AS creditos FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo ORDER BY g.nombre DESC;
SELECT c.anyo_inicio, COUNT(am.id_alumno) AS numero_alumnos FROM curso_escolar AS c LEFT JOIN alumno_se_matricula_asignatura AS am ON c.id = am.id_curso_escolar GROUP BY c.anyo_inicio;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS asignaturas FROM persona AS p LEFT JOIN asignatura AS a ON p.id = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY asignaturas DESC;
SELECT * FROM persona WHERE tipo = "alumno" ORDER BY fecha_nacimiento DESC LIMIT 1;
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona AS p INNER JOIN profesor AS pf ON p.id = pf.id_profesor LEFT JOIN asignatura AS a ON p.id = a.id_profesor WHERE a.id IS NULL;