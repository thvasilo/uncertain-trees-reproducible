#!/usr/bin/env bash

export MOA_PATH="../../binaries"

# Friedman One
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanOneGlobalSlow) -f ./friedman-one-globalslow.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanOneGlobalAbruptReoccurring) -f ./friedman-one-globalabrupt.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanOneLocalExpanding) -f ./friedman-one-locexp.arff -m 1000000"

# Friedman Two
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanTwoGlobalSlow) -f ./friedman-two-globalslow.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanTwoGlobalAbruptReoccurring) -f ./friedman-two-globalabrupt.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanTwoLocalExpanding) -f ./friedman-two-locexp.arff -m 1000000"

# Friedman Three
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanThreeGlobalSlow) -f ./friedman-three-globalslow.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanThreeGlobalAbruptReoccurring) -f ./friedman-three-globalabrupt.arff -m 1000000"
java -cp "${MOA_PATH}/moa-2017.10-SNAPSHOT.jar:${MOA_PATH}/dependency-jars/*" moa.DoTask "WriteStreamToARFFFile -s (generators.regression.FriedmanThreeLocalExpanding) -f ./friedman-three-locexp.arff -m 1000000"
