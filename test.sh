#!/bin/bash
#
# mcat -- campagne d'appels à mcat-scd
#


# La commande à tester
MCAT=./mcat_scd
#MCAT=/bin/cat
# le fichier à lui mettre en entrée
MCAT_INPUT=bigfile
# Le fichier de temps à générer
TIME_FILE=mcat-tm.dat

TMP_FILE_WORK=tmpfile

# la commande gnu time
TIME_CMD="/usr/bin/time"
#TIME_CMD="time"
# les options de cette commande
TIME_OPT="-f %e %U %S"

rm -f $MCAT_INPUT


# Creation du fichier de test 'testfile.data' de taille 10 mega
dd if=/dev/zero of=$MCAT_INPUT bs=1M count=10

# initialisation du fichier de résultats
#rm -f $TIME_FILE && echo "# real user sys" > $TIME_FILE
rm -f $TIME_FILE && echo "# taille duree" > $TIME_FILE


# un autre exemple de boucle
for size in `awk 'BEGIN { for( i=1; i<=8388608; i*=2 ) print i }'`; do
    export MCAT_BUFSIZ=$size
    echo $MCAT_BUFSIZ
    #echo "TODO"
    $TIME_CMD "$TIME_OPT" $MCAT $MCAT_INPUT > /dev/null 2> $TMP_FILE_WORK
    echo $MCAT_BUFSIZ $(cat $TMP_FILE_WORK | cut -d ' ' -f 2) 1>> $TIME_FILE
done

# un exemple de redirection des sorties standard et d'erreur
#$TIME_CMD "$TIME_OPT" cat $MCAT_INPUT > /dev/null 2>> $TIME_FILE

# Supression du fichier de test

rm -f $MCAT_INPUT

gnuplot run.gnu
# eof
