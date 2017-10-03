/* Test du chi-2 d'indépendance */
/* H0 : indépendant contre H1 : non-indépendant */
data couleur;
	input yeux $ cheveux $ effectif;
	cards;
 bleus blonds 25
 bleus bruns 9
 bleus noirs 3
 bleus rouges 7
 verts blonds 13
 verts bruns 17
 verts noirs 10
 verts rouges 7
 marrons blonds 7
 marrons bruns 13 
 marrons noirs 8
 marrons rouges 5
 ;
run;

proc print; run;
proc means; run; /* faux */
proc freq nlevels;
run;

proc freq data=couleur order = data;
	tables yeux*cheveux;
	weight effectif;
	title1 "tableau de contingence observé";
	title2 "-------------------------------------
	-------------------------------------------";
	/* ordre dans le tableau : effectif, pourcentage global, pourcentage dans la ligne, pourcentage dans la colonne */
run;
 
proc freq data = couleur order = data;
	tables yeux*cheveux /expected nofreq nocol norow nopercent;
	weight effectif;
	title1 "tableau de contingence observé";
	title2 "-------------------------------------
	-------------------------------------------";
run;


proc freq data = couleur order = data;
	tables yeux*cheveux /chisq /*nofreq nocol norow nopercent*/;
	weight effectif;
	title1 "Chi-2 et chi-2 du ratio de vraisemblance";
	title2 "-------------------------------------
	-------------------------------------------";
run;
