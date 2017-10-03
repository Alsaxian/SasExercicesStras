filename mais "/folders/myfolders/LogiStat/mais.xlsx";

proc import datafile = mais
	dmbs = xlsx
	out = work.mais1;
	getnames = yes;
run;

proc contents data = work.mais1; run;

proc print data = work.mais1; run;

proc means data = work.mais1;
	var Hauteur Masse;
	class Parcelle;
run;

proc means data = work.mais1;
	var Hauteur Masse;
run;

proc means data = work.mais1;
	var Hauteur Masse;
	class Parcelle Couleur; /* L'ordre inverse des var. donne aussi l'ordre inverse de la table */  
run;

proc sort data = work.mais1;
	by couleur;
run;

proc freq data = work.mais1 order=data;
	tables couleur /chisq nocum
/* L'option nocum supprime les colonnes "effectif cumulé" et "pourcentage cumulé" 
alor que l'option nopercent supprime les colonnes "pourcentage" et "pourcentage cumulé". */
 
	testp = (0.334 0.334 0.334); /* Attention ici c'est les effectifs */

run;

proc freq data = work.mais1 order = data;
	tables parcelle /chisq nocum
	testp = (.17 .2 .30 .33);
run; 
/* Le graphique en dessous du tablaux de la sortie signifie les pourcentages desquels les ralisations 
de chaque classe sont plus ou moins que les valeurs théoriques. */

proc freq data = mais1 order = data; /* chi2 d'indépendance */
	tables parcelle*couleur /expected nofreq nopercent nocol norow;
	title1 "tableau des effectifs théoriques, toujours vérifier d'abord la règle de Cochran! ";
	title2 "-------------------------------------
	-------------------------------------------";
run;

proc freq data = mais1 order = data; /* chi2 d'indépendance, mais il 
ne faut pas faire ce test car la règle de Cochran n'est pas vérifiée ! */
	tables parcelle*couleur /chisq;
	title1 "tableau de contingence observé";
	title2 "-------------------------------------
	-------------------------------------------";
run;
/* Dans ce cas-là, on peut utiliser le test exact de Fisher. */
/* Le test exact de Fisher, il est complexe à calculer par rapport à celui de chi-2.
Mais avec l'ordi ce n'est plus un problème et certains pensent qu'on doive toujours préférer 
le test exact de Fisher. */

proc freq data = mais1 order = data; /* chi2 d'indépendance, mais il 
ne faut pas faire ce test car la règle de Cochran n'est pas vérifiée ! */
	tables parcelle*couleur /expected;
	title1 "tableau de contingence de Fisher";
	title2 "-------------------------------------
	-------------------------------------------";
	exact fisher;
run;
/* Sinon on pourrait faire aussi le G-test, test du chi-2 du ratio de vraisemblences. */
/* Pas ici en fait, le G-test exige aussi la Règle de Cochran. */


proc freq data = mais1 order = data; /* chi2 d'indépendance, mais il 
ne faut pas faire ce test car la règle de Cochran n'est pas vérifiée ! */
	tables attaque*verse_traitement /chisq;
	title1 "Chi-2 et tout lorsque le tableau est de 2*2";
	title2 "-------------------------------------
	-------------------------------------------";
run; /* lorsque 2*2, SAS donne automatiquement l'ajusté de Yates et le test exact de Fisher. */
