#!/bin/bash
#script by stelios.miaoudakis@leroymerlin.gr 12/2017
#execute bimp_fiscal if lanceur is disabled

fiscerr="/home2/lm/prog/util/fic/BIMP_FISCAL.arret"
deltdir="/home2/doc_fiscaux/att/"
fiscdir="/home2/lm/prog/SBILUX_src/client/"
bimpdir="/home2/lm/prog/util/bat/"

if ls -1 $fiscerr >/dev/null 2>&1
then
echo "File was found attempt to delete" > /tmp/bfarr.txt 2>&1
rm -f $fiscerr >>/tmp/bfarr.txt 2>&1
fi
 if ls -1 $deltdir/* >/dev/null 2>&1
then
echo 'File Exist' > /tmp/fe.txt
cd $fiscdir
./time.sh > /tmp/fisc.log
cd $bimpdir
./bimp_fiscal.bat >> /tmp/bimpf.log
else
echo 'File does not exist' > /tmp/fde.txt
cd $fiscdir
./stat.sh > /tmp/st.log
fi
#Send mail
CURDATE=$(date +%d%m)
F1="/tmp/bimpf.log"
MDATE=$(date +%d%m -r $F1)
MAILBAT="/home2/lm/prog/util/bat/"

if [ $MDATE -eq $CURDATE ]
then
echo "File created today $CURDATE "
cd $MAILBAT
./sendmail.pl -s="lmgr.smtp.adeo.com" -f="bo" -t="smiaoudakis@leroymerlin.gr" -j="test" -m="$F1"
else
echo "File created $MDATE "
exit
fi