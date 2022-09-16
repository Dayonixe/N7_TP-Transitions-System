-------------------------------- MODULE cani --------------------------------

EXTENDS Naturals

CONSTANTS NB_M, NB_C

VARIABLES riveD, riveG, barque

Rives == {"G", "D"}

TypeInvariant ==
  [] (/\ riveD.cannibale >= 0
      /\ riveD.cannibale <= NB_C
      /\ riveD.missionnaire >= 0
      /\ riveD.missionnaire <= NB_M)

pasMiam ==
    /\ riveD.cannibale <= riveD.missionnaire
    /\ riveG.cannibale <= riveG.missionnaire

ToujoursOk == []pasMiam

Solution == [] \neg(riveD.missionnaire = NB_M /\ riveD.cannibale = NB_C)

-----------------------------------------------------------------------------

inv(r) == IF r = "G" THEN "D" ELSE "G"

Init ==
    /\ riveG = [missionnaire |-> NB_M, cannibale |-> NB_C]
    /\ riveD = [missionnaire |-> 0, cannibale |-> 0]
    /\ barque = "G"

bouger(nbM,nbC) ==
    /\ nbM+nbC <= 2
    /\ nbM+nbC >= 1
    /\ IF barque="G" THEN
            (inv(barque)
            /\ riveG.missionnaire - nbM
            /\ riveG.cannibale - nbC
            /\ riveD.missionnaire + nbM
            /\ riveD.cannibale + nbC)
        ELSE
            (inv(barque)
            /\ riveD.missionnaire - nbM
            /\ riveD.cannibale - nbC
            /\ riveG.missionnaire + nbM
            /\ riveG.cannibale + nbC)
    /\ pasMiam'

Next == \E nbM,nbC \in 0..2 : bouger(nbM,nbC)

Spec == Init /\ [] [ Next ]_<<riveD,riveG>>

=============================================================================
\* Modification History
\* Last modified Thu May 05 11:59:39 CEST 2022 by theo
\* Created Thu May 05 10:48:22 CEST 2022 by theo
