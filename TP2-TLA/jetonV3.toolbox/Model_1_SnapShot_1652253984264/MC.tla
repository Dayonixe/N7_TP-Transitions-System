---- MODULE MC ----
EXTENDS jetonV3, TLC

\* CONSTANT definitions @modelParameterConstants:0N
const_16522539822215000 == 
5
----

\* INIT definition @modelBehaviorNoSpec:0
init_16522539822226000 ==
FALSE/\etat = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_16522539822227000 ==
FALSE/\etat' = etat
----
=============================================================================
\* Modification History
\* Created Wed May 11 09:26:22 CEST 2022 by theo
