/* la procédure gplot ne marche sous la version University. Essayer à la maison ! */
proc gplot data=mais1;
	plot Hauteur*Masse;
run;

proc sgplot data=Mais1;
	scatter y=Hauteur x=Masse;
run;

proc reg data=mais1;
	model hauteur=Masse;
run;

proc reg data=Mais1;
	model Hauteur=Masse;
	output out=mais5 r=residus;
run;

proc univariate data= Mais5 normal;
	var residus;
run;

/* Pour mieux coir ces graphes : */
proc reg data=mais1 plots=diagnostics(unpack);
	model hauteur = masse;
run;
/* Le graphe Rstudent c'est pour vérifier si les résidus se trouvent dans une bande de la même hauteur. */
/* Le graphe D de Cook c'est pour voir les poids que les points ont sur le modèle. Si c'est trop important. */

/* Imprimer seulement  ce qu'on veut */
proc reg data=mais1 plots=(qqplot Residuals(smooth)
	cooksd(label) residualbypredicted(label));
	model hauteur = masse;
run;
/* Le graphe lissage Loess permet de voir si les résidus sont équilibrement répartis. Il prend une fenêtre mobile pour calculer
la moyenne locale, dont la longueur je ne connais pas. */

/* Régression multiple */
proc contents data=mais1; run;

proc reg data=mais1;
	model masse=hauteur hauteur_j7 nb_grains nb_jours_attaque;
run;

/* Calcul de VIF */
proc reg data=mais1;
	model masse=hauteur hauteur_j7 nb_grains nb_jours_attaque / VIF;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / VIF;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / selection=backward AIC BIC;
run;

proc reg data=mais1;
	model masse=hauteur;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / selection=Rsquare AIC BIC;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / selection=backward;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / selection=backward slstay=0.05;
run;

proc reg data=mais1;
	model masse=hauteur nb_grains nb_jours_attaque / selection=stepwise;
run;