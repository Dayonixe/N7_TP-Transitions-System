---------------- MODULE philosophes0 ----------------
(* Philosophes. Version en utilisant l'état des voisins. *)

EXTENDS Naturals

CONSTANT N

ASSUME N > 2

Philos == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

Hungry == "H"
Thinking == "T"
Eating == "E"

VARIABLES
    etat    \* i -> Hungry,Thinking,Eating


TypeInvariant == [] (etat \in [ Philos -> { Hungry, Thinking, Eating }])

ExclMutuelle == [] (\A i \in Philos : etat[i] = Eating => (droite(i) /= Eating /\ gauche(i) /= Eating))

VivaciteIndividuelle == \A i \in Philos : etat[i] = Hungry ~> etat[i] = Eating

VivaciteGlobale == (\E i \in Philos : etat[i] = Hungry) ~> (\E j \in Philos : etat[j] = Eating)


----------------------------------------------------------------


Init == etat = [ i \in Philos |-> Thinking ]


demande(i) == etat[i] = Thinking
    /\ etat' = [etat EXCEPT![i] = Hungry]

mange(i) == etat[i] = Hungry
    /\ \A j \in Philos : etat[j] /= Eating
    /\ etat' = [etat EXCEPT![i] = Eating]

pense(i) == etat[i] = Eating
    /\ etat' = [etat EXCEPT![i] = Thinking]


Next == \E i \in Philos :
    \/ demande(i)
    \/ mange(i)
    \/ pense(i)

Fairness == \A i \in Philos :
    /\ WF_<<etat>> (demande(i))
    /\ WF_<<etat>> (mange(i))
    /\ WF_<<etat>> (pense(i))

Spec ==
    /\ Init
    /\ [] [ Next ]_<<etat>>
    /\ Fairness

==================================================================
