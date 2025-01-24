function select_option {

    
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    
    for opt; do printf "\n"; done

    
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}
chmod +x ./source/exe/jk
echo "Welcome to DOOZY IOS tool, github.com/TEAM-DLK/iphone-bypass-2025/"
echo "We are not responsible for any damage done to your device"
echo "WE CANT GUARANTEE UNLOCK, ON SOME DEVICES IT WILL WORK ON SOME NOT!!!!!"
echo "Features: Bypass Activation lock, Remove old icloud account, root shell to Idevice, Jailbreak the device"
echo "Select one option using up/down keys and enter to confirm:"
echo
chmod +x ./source/exe/jk
options=( "Icloud bypass IOS 10.3-18.3! NO SIM CARD (AUTOMATIC ONE)" "newPHP ICLOUD BYPASS WITH SIM  " "Removes old icloud account conected to the device  (JAILBREAK REQUIRED)" "Jailbreak the device" "Exit")

select_option "${options[@]}"
choice=$?

echo "Choosen = $choice"

echo "Launching selected option..."
if [ $choice = "0" ]; then
   clear
   chmod +x ./source/ibypass.sh
   ./source/ibypass.sh
elif [ $choice = "1" ]; then
    clear
    chmod +x ./source/php.sh
    ./source/php.sh
elif [ $choice = "2" ]; then
    clear
    chmod +x ./source/rm_oldicloud.sh
    ./source/rm_oldicloud.sh
elif [ $choice = "3" ]; then
    clear
    chmod +x ./source/jailbreak.sh
    ./source/jailbreak.sh
else
    echo "Exiting..."
    clear
    echo "Bye!"
    exit
fi
