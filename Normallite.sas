/* Test de normalité, pour vérifier la condition de normalité d'un autre test */

/* Le test de Shapiro-Wilk est normalement pour tester de petits échatillons, dont la taille
va de 12 (au moins il en faut 8) à des certaines. R refuse de faire une taille d'échantillon à partir
de 5000 car le test sera trop puissant qui préfère une erreur de 1er type à celle de 2e. Non-robustesse du test. */
Proc univariate data = mais1 normal;
	var hauteur;
run;
/* Pour un test de QQplot il peut arriver qu'aux extrêmes les queues du graphe ne sont pas sur la diagonale, ce qui n'est pas grave. */
proc univariate data=mais1;
	var hauteur; /* pas nécessaire */
	qqplot hauteur / normal (mu=est sigma=est); /* pour établir une loi normale dont la moyenne est l'écart-type sont ceux relevés de
	l'échantillon. Mais même si l'on met mu=0, sigma=1, ça doit quand-même donner une droite !! Propriété des lois normales. */
run;


/* Ttest, test de Student. pour cela il faut d'abord vérifier les conditions de normalité et pour cela, 
il faut d'abord trier. */

proc sort data=mais1;
	by Verse_Traitement;
run;

proc univariate data=mais1 normal;
	var Hauteur;
	by Verse_Traitement;
run;
proc ttest data = mais1;
	var Hauteur;
	class Verse_Traitement;
run;
/* Ici c'est l'égalité des variance qui a le plus d'importance. Sinon il faut lire le résultat Satter. */

/* Test de Student apparié, one sample ttest */
proc univariate data = mais1 normal;
	var Hauteur Hauteur_J7;
run;
proc ttest data=mais1;
	paired Hauteur*Hauteur_J7;
run;