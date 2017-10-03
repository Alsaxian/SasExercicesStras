data dice;
	input face $ effectif;
	cards;
	Face1 17
	Face2 14
	Face3 15
	Face4 18
	Face5 16
	Face6 20
;
run;

/* test de chi2, c'est de calculer Sum(e_i-t_i)^2/t_i es la comparer acec chi2(k-1). */

proc freq data = work.dice order=data;
	tables face /chisq nocum
/* L'option nocum supprime les colonnes "effectif cumulé" et "pourcentage cumulé" 
alor que l'option nopercent supprime les colonnes "pourcentage" et "pourcentage cumulé". */
 
	testf = (16.667 16.667 16.667 16.667 16.667 16.667); /* Attention ici c'est les effectifs */
	weight effectif; /* Manque de cette phrase, SAS va compter les occurences. */
run;


data dice;
	input face $ effectif;
	cards;
	Face1 17
	Face2 14
	Face3 15
	Face4 18
	Face5 16
	Face6 25
;
run;

proc freq data = work.dice order=data;
	tables face /chisq nocum
	testp = (16.667 16.667 16.667 16.667 16.667 16.667); /* Attention ici c'est la proportion */
	weight effectif;
run;