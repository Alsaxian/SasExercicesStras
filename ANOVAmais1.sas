proc anova data=mais1;
	class parcelle;
	model hauteur=parcelle;
run;

/* avec le test de Bartlett */
proc anova data=mais1;
	class parcelle;
	model hauteur = parcelle;
	means parcelle / hovtest=bartlett;
run;
/* ANOVA n'est pas robuste à l'homogénéité de vanriance. dans le cas où les variances ne sont pas égales,
on peut rajouter l'option welch */
proc anova data=mais1;
	class parcelle;
	model hauteur = parcelle;
	means parcelle / hovtest=bartlett welch;
run;

/* Il a fallu vérifier la normalité, même si l'ANOVA est robuste à la normalité.
Comme c'est pas possible de faire un seul Shapiro sous ANOVA, qui est normalement plus fiable que faire de
tests de SHapiro pour chacun des groupes, on est obligé de faire séparément. */
proc univariate normal;
	var hauteur;
	class parcelle;
run;

/* version glm */
proc glm data=mais1;
	class parcelle;
	model hauteur=parcelle;
run;

/* avec le test de Bartlett */
proc glm data=mais1;
	class parcelle;
	model hauteur = parcelle;
	means parcelle / hovtest=bartlett;
run;

/* Pour vérifier la normalité */
proc glm data=mais1;
	class parcelle;
	model hauteur = parcelle;
	output out = mais2 r=residus;
run;

proc univariate data=mais2 normal;
	var residus;
run;

/* comparaison multiple avec anova */
proc anova data=mais1;
	class parcelle;
	model hauteur=parcelle;
	means parcelle /tukey;
run;
/* Dans le résultat, ... veut dire significativement différent. Sinon rien. */

/* comparaison multiple avec glm */
proc glm data=mais1;
	class parcelle;
	model hauteur=parcelle;
	means parcelle /tukey;
run;

/* Quand on ne précise pas le groupe de référence, SAS choisit le premier dans l'ordre alphabétique. */
proc anova data=mais1;
	class Parcelle;
	model Hauteur=Parcelle;
	means parcelle / dunnett;
run;
/* Puis on précise quel groupe est la référence. */
proc anova data=mais1;
	class Parcelle;
	model Hauteur=Parcelle;
	means parcelle / dunnett('Nord');
run;

