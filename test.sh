#!/bin/bash

# mcat -- campagne d'appels à mcat-scd

chmod +x mcat_scd
chmod +x mcat_scs
chmod +x mcat_lib

# La commande à tester
MCAT_SCD=./mcat_scd
MCAT_LIB=./mcat_lib
# Le fichier à lui mettre en entrée
MCAT_INPUT=sample.txt
# Le fichier de temps à générer
TIME_FILE_SCD=mcat-scd-tm.dat
TIME_FILE_LIB=mcat-lib-tm.dat

# La commande gnu time
TIME_CMD="/usr/bin/time"
# Les options de cette commande
TIME_OPT="-f %e"

# La taille du buffer
BUFFER_SIZE=1

# Création d'un gros fichier de 30MB
dd if=/dev/urandom of=sample.txt bs=10M count=1
# Initialisation du fichier de résultats
rm -f $TIME_FILE_SCD && echo "# buf         real" > $TIME_FILE_SCD

while [ $BUFFER_SIZE -le 8388608 ]
do
    export MCAT_BUFSIZ=$BUFFER_SIZE
    echo -n "$MCAT_BUFSIZ           " >> $TIME_FILE_SCD
    $TIME_CMD "$TIME_OPT" $MCAT_SCD $MCAT_INPUT > /dev/null 2>> $TIME_FILE_SCD
    BUFFER_SIZE=$(($BUFFER_SIZE * 2));
done

# Affichage de la courbe gnuplot
gnuplot run.gnu

# Réinitalisation de BUFFER_SIZE
BUFFER_SIZE=1

# Initialisation du fichier de résultats
rm -f $TIME_FILE_LIB && echo "# buf         real" > $TIME_FILE_LIB

while [ $BUFFER_SIZE -le 8388608 ]
do
    export MCAT_BUFSIZ=$BUFFER_SIZE
    echo -n "$MCAT_BUFSIZ           " >> $TIME_FILE_LIB
    $TIME_CMD "$TIME_OPT" $MCAT_LIB $MCAT_INPUT > /dev/null 2>> $TIME_FILE_LIB
    BUFFER_SIZE=$(($BUFFER_SIZE * 2));
done

# Suppression du gros fichier, parce que 30MB quand même...
rm -f sample.txt

# eof
