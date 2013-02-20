#!/bin/bash
# Golfed. 813 chars.
# Original: https://github.com/Qwertylex/bash-kanatrainer
# Golfed: https://gist.github.com/passcod/4994357
# License: CC BY-SA 3.0.

l="a;i;u;e;o;ka;ki;ku;ke;ko;sa;shi;su;se;so;ta;chi;tsu;te;to;na;ni;nu;ne;no;ha;hi;fu;he;ho;ma;mi;mu;me;mo;ya;yu;yo;ra;ri;ru;re;ro;wa;wo;n"
hira="あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん"
kata="アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマモムメモヤユヨラリルレロワヲン"
read -ep "hira or kata: " c;a=$(eval echo $`echo ${c}`)
n=0;r=0;t=${#a};IFS=';' read -ra l <<< "$l"
score(){ printf "\n\nScore: %i\nCorrect: %i/%i\n" $((2*$r-$n)) $r $n;exit
};for k in `seq $t | sort -R`;do
let k-=1;trap score SIGINT SIGTERM;i=${l[$k]}
read -ep "${a:$k:1} Romaji?: " w;if [ $i == "$w" ];then
echo Correct!;let r+=1;else
echo Sorry, it was $i.;fi;let n+=1;done
score
