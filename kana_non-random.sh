#!/bin/bash
#Alex's Kana trainer alpha0.97 NON RANDOM
#Ideas for script skeleton taken from http://tldp.org/LDP/abs/html/randomvar.html (See "Example 9-12")
#License: This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.

hiras="あ,a い,i う,u え,e お,o か,ka き,ki く,ku け,ke こ,ko さ,sa し,shi す,su せ,se そ,so た,ta ち,chi つ,tsu て,te と,to な,na に,ni ぬ,nu ね,ne の,no は,ha ひ,hi ふ,fu へ,he ほ,ho ま,ma み,mi む,mu め,me も,mo や,ya ゆ,yu よ,yo ら,ra り,ri る,ru れ,re ろ,ro わ,wa を,wo ん,n"
katas="ア,a イ,i ウ,u エ,e オ,o カ,ka キ,ki ク,ku ケ,ke コ,ko サ,sa シ,shi ス,su セ,se ソ,so タ,ta チ,chi ツ,tsu テ,te ト,to ナ,na ニ,ni ヌ,nu ネ,ne ノ,no ハ,ha ヒ,hi フ,fu ヘ,he ホ,ho マ,ma モ,mi ム,mu メ,me モ,mo ヤ,ya ユ,yu ヨ,yo ラ,ra リ,ri ル,ru レ,re ロ,ro ワ,wa ヲ,wo ン,n"

read -e -p "hira or kata: " choice
case $choice in
"hira")
  kana=($hiras)
  ;;
"kata")
  kana=($katas)
  ;;
esac

correct=0
incorrect=0
count=-1

while :
do
let "count += 1"
kana_count=${#kana[*]}

if [ "$count" == "$kana_count" ]
then
echo; echo; echo Total Score: $score; echo Correct Answers: $correct; echo Incorrect Anwsers: $incorrect; exit 0
fi

kana_romaji=$(echo ${kana[$(($count))]})
kana_o=$(echo $kana_romaji | cut -d , -f 1 -)
romaji=$(echo $kana_romaji | cut -d , -f 2 -)

read -e -p "$kana_o Romaji?: " answer
if [ "$romaji" == "$answer" ];
then
	echo "Correct!"
	let "correct += 1"
	let "score += 1"
else
	echo "Sorry, it was $romaji."
	let "incorrect += 1"
	let "score -= 1"
fi
trap "echo; echo; echo Total Score: $score; echo Correct Answers: $correct; echo Incorrect Anwsers: $incorrect;exit 0" SIGINT SIGTERM
done
