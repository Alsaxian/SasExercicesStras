proc glm data=mais1;
	class parcelle verse_traitement;
	model Hauteur= parcelle verse_traitement;
	lsmeans parcelle Verse_traitement / adjust=tukey;
	output out=mais3 r=residus;
run;

proc univariate data=mais3 normal;
	var residus;
run;

/* Anova à 2 facteur avec interaction, pour voir si les facteurs ont le même effet quelque soit le group. */
proc glm data=mais1;
	class parcelle verse_traitement;
	model Hauteur= parcelle verse_traitement
Parcelle*Verse_Traitement;
	lsmeans parcelle Verse_traitement
Parcelle*Verse_traitement / adjust=tukey;
	output out=mais4 r=residus;
run;


proc univariate data=mais3 normal;
	var residus;
run;

/* Après on a le choix d'utiliser ANCOVA pour analyser les covariances. */