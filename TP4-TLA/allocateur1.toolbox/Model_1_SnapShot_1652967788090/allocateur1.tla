---------------- MODULE allocateur1 ----------------
\* Time-stamp: <30 mar 2016 10:24 queinnec@enseeiht.fr>

(* Version concrète de l'allocation de ressources. *)

EXTENDS Naturals

CONSTANT
   M,    \* nbre de ressources
   N     \* nbre de processus

VARIABLES
  nbDispo,
  demande,
  satisfait

vars == << nbDispo, demande, satisfait >>


TypeInvariant ==
  [] (/\ nbDispo \in 0..M
      /\ demande \in [ 0..N-1 -> 0..M ]
      /\ satisfait \in [ 0..N-1 -> BOOLEAN ])

(* Calcule la somme des demandes pour les processus contenus dans S *)
SommeDemande[S \in SUBSET (0..N-1) ] ==
  IF S = {} THEN 0
  ELSE LET e == CHOOSE x \in S : TRUE
       IN demande[e] + SommeDemande[S \ {e}]

(* XXXX Autres propriétés temporelles de sûreté ??? *)
PasDinsatisfait == [] (\A i \in 0..N-1 : demande[i] = 0 => ~satisfait[i])

SommeSatisfait == [] (SommeDemande[{i \in 0..N-1 : satisfait[i]}] = M-nbDispo)

(* XXXX Autres propriétés temporelles de vivacité ??? *)
VivaciteIndividuelle == [] (\A i \in 0..N-1 : demande[i] > 0 ~> satisfait[i])

VivaciteGlobale == []((\E i \in 0..N-1 : demande[i] > 0) ~> (\E j \in 0..N-1 : satisfait[j]))

----------------------------------------------------------------

Init ==
   /\ nbDispo = M
   /\ demande = [ i \in 0..N-1 |-> 0 ]
   /\ satisfait = [ i \in 0..N-1 |-> FALSE ]


demander(i,p) == /\ demande[i] = 0
                /\ ~satisfait[i]
                /\ demande' = [demande EXCEPT ![i] = p]
                /\ UNCHANGED <<nbDispo,satisfait>>

obtenir(i) == /\ demande[i] > 0
                /\ demande[i] <= nbDispo
                /\ ~satisfait[i]
                /\ satisfait' = [satisfait EXCEPT ![i] = TRUE]
                /\ nbDispo' = nbDispo - demande[i]
                /\ UNCHANGED <<demande>>

liberer(i) == /\ satisfait[i]
                /\ demande[i] > 0
                /\ nbDispo' = nbDispo + demande[i]
                /\ demande' = [demande EXCEPT ![i] = 0]
                /\ satisfait' = [satisfait EXCEPT ![i] = FALSE]


Next ==
 \E i \in 0..N-1 : \E p \in 1..M :
    \/ demander(i,p)
    \/ obtenir(i)
    \/ liberer(i)

Fairness == \A i \in 0..N-1 :
    /\ WF_<<nbDispo,demande,satisfait>> (obtenir(i))

Spec ==
 /\ Init
 /\ [] [ Next ]_vars
 /\ Fairness

================================================================
