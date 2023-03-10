#!/bin/bash




# take the file and only keep the choice place by the user


searchPlace (){

    # array chossen depend of the argument

    case $1 in
            1)declare -a arr=("97701" "97801" "97201" "97202" "97203" "97204" "97205" "97206" "97207" "97208" "97209" "97210" "97211" "97212" "97213" "97214" "97215" "97216" "97217" "97218" "97219" "97220" "97221" "97222" "97223" "97224" "97225" "97226" "97227" "97228" "97229" "97230" "97231" "97232" "97233" "97234" "97101" "97102" "97103" "97104" "97105" "97106" "97107" "97108" "97109" "97110" "97111" "97112" "97113" "97114" "97115" "97116" "97117" "97118" "97119" "97120" "97121" "98411" "98412" "98413" "98415" "98414" "97502" "97501" "97301" "97302" "97303" "97304" "97305" "97306" "97307" "97308" "97309" "97310" "97311" "97312" "97313" "97314" "97352" "97353" "97356" "97357" "97358" "97360" "97361" "97362");;
            2)declare -a arr=("97301" "97302" "97303" "97304" "97305" "97306" "97307" "97308" "97309" "97310" "97311" "97312" "97313" "97314" "97352" "97353" "97356" "97357" "97358" "97360" "97361" "97362");;
            3)declare -a arr=("97502" "97501");;
            4)declare -a arr=("97701" "97801" "97201" "97202" "97203" "97204" "97205" "97206" "97207" "97208" "97209" "97210" "97211" "97212" "97213" "97214" "97215" "97216" "97217" "97218" "97219" "97220" "97221" "97222" "97223" "97224" "97225" "97226" "97227" "97228" "97229" "97230" "97231" "97232" "97233" "97234" "97101" "97102" "97103" "97104" "97105" "97106" "97107" "97108" "97109" "97110" "97111" "97112" "97113" "97114" "97115" "97116" "97117" "97118" "97119" "97120" "97121");;
            5)declare -a arr=("98411" "98412" "98413" "98415");;
            6)declare -a arr=("98414");;
    esac

    echo "ID OMM station;Date;Direction du vent moyen 10 mn;Vitesse du vent moyen 10 mn;Humidité;Pression station;Coordonnees;Température (°C);Altitude;communes (code)" >> ./Data/FirstSelection/WeatherbyP.csv



    # We read the old file and create a new one with the selection

    while IFS=";" read -r c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
    do
        
        if [ -z "$c10" ] ; then  continue ; fi

        if [ "$1" -eq 1 ] ; then
            test=0
            for i in "${arr[@]}" 
            do
                if [[ "$i" == "$c10" ]] ; then
                    test=1
                fi
            done
            if [ $test -eq 0 ] ; then 
                    echo "$c1;$c2;$c3;$c4;$c5;$c6;$c7;$c8;$c9" >> ./Data/FirstSelection/WeatherbyP.csv
            fi
        else
            for i in "${arr[@]}" 
            do
                if [ "$i" = "$c10" ] ; then
                    echo "$c1;$c2;$c3;$c4;$c5;$c6;$c7;$c8;$c9" >> ./Data/FirstSelection/WeatherbyP.csv
                    break
                fi
            done
        fi
    done < ./Data/Origin/Weather.csv

}



# check argument and return 0 if their is a problme, otherwise launch the selection by place


SpaceArg(){

    rm -f ./Data/FirstSelection/WeatherbyP.csv

    for i in "$@" ; do

        case $i in 
            "-F")
                for j in "$@" ; do
                    if [ "$j" = "-G" ] || [ "$j" = "-S" ]  || [ "$j" = "-A" ] || [ "$j" = "-O" ] || [ "$j" = "-Q" ] ; then   
                        return 0
                    fi
                done
                searchPlace 1
                return 1;;
                

            "-G")
                for j in "$@" ; do
                    if [ "$j" = "-F" ] || [ "$j" = "-S" ]  || [ "$j" = "-A" ] || [ "$j" = "-O" ] || [ "$j" = "-Q" ] ; then   
                        return 0
                    fi
                done
                searchPlace 2
                return 1;;

            "-S")
                for j in "$@" ; do
                    if [ "$j" = "-G" ] || [ "$j" = "-F" ]  || [ "$j" = "-A" ] || [ "$j" = "-O" ] || [ "$j" = "-Q" ] ; then   
                        return 0
                    fi
                done
                searchPlace 3
                return 1;;

            "-A")
                for j in "$@" ; do
                    if [ "$j" = "-G" ] || [ "$j" = "-S" ]  || [ "$j" = "-F" ] || [ "$j" = "-O" ] || [ "$j" = "-Q" ] ; then   
                        return 0
                    fi
                done
                searchPlace 4
                return 1;;

            "-O")
                for j in "$@" ; do
                    if [ "$j" = "-G" ] || [ "$j" = "-S" ]  || [ "$j" = "-A" ] || [ "$j" = "-F" ] || [ "$j" = "-Q" ] ; then   
                        return 0
                    fi
                done
                searchPlace 5
                return 1;;

            "-Q")
                for j in "$@" ; do
                    if [ "$j" = "-G" ] || [ "$j" = "-S" ]  || [ "$j" = "-A" ] || [ "$j" = "-O" ] || [ "$j" = "-F" ] ; then   
                        return 0
                    fi
                done
                searchPlace 6
                return 1;;
        esac

    done
    cp ./Data/Origin/Weather.csv ./Data/FirstSelection/WeatherbyP.csv
    return 1

}