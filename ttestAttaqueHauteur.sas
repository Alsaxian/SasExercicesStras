/* Ex. tester si Attaque a une influance sur Hauteur dans data=mais1 */
/* vérifier d'abord les 2 indépendances */


proc sort data=mais1;
	by Attaque;
run;
/* Il faut absolument trier avant d'appliquer Shapiro-Wilk */
/* vérifier les conditions d'application du test Shapiro avant de le faire */
Proc univariate data = mais1 normal; /* SAS fait Shapiro-Wilk, K-S, etc. pour tester la normalité.
On n'a pas besoin de préciser. */
	var hauteur;
	by Attaque;
run;
/* Ne pas oublier de regarder l'égalité des variances avant de lire la méthode pooled */
proc ttest data=mais1;
	var hauteur;
	class attaque; /* On pourrait aussi mettre by mais ça donne autre chose. */
run;