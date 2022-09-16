---- MODULE MC ----
EXTENDS jetonV3, TLC

\* CONSTANT definitions @modelParameterConstants:0N
const_16522539307022000 == 
5
----

\* INIT definition @modelBehaviorNoSpec:0
init_16522539307033000 ==
FALSE/\etat = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_16522539307034000 ==
FALSE/\etat' = etat
----
=============================================================================
\* Modification History
\* Created Wed May 11 09:25:30 CEST 2022 by theo
