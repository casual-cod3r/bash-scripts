#!/bin/bash

## For this script, you need to install sendEmail tool (sudo apt-get install sendEmail)

## For keeping it secure using SSL/TLS, install (sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl)

clear


####################################### USER INPUTs    ###################################################

echo "Enter your email address"

read EMAILFROM

echo

echo

echo "Enter the email address to which you will send an email"

read EMAILTO

##########################      Selecting the SMTP servers based on user input ##########################


if [[ $EMAILFROM == *"gmail.com"* ]]

	then 
		EMAILSERVER="smtp.googlemail.com:587";

elif [[ $EMAILFROM == *"yahoo.com"* ]]

	then 
		EMAILSERVER="smtp.mail.yahoo.com:465";
else
	echo "Please enter your VALID username of your account ...Exiting now" 
	exit
fi

echo

echo

############################ Confirming the Username of their account #########################################

EMAILUSERSHORTEN=${EMAILFROM%@*}    #gets the part of main staring before the delimiter "@" in this example

echo "Is your username [$EMAILUSERSHORTEN]? [Yes/No]"

read USERNAMECONFIRM

USERNAMECONFIRMLOWER=$(echo "$USERNAMECONFIRM" | tr '[:upper:]' '[:lower:]')



if [[ $USERNAMECONFIRMLOWER == "yes" ]] 

	then

		EMAILUSER=$EMAILUSERSHORTEN;

elif [[ $USERNAMECONFIRMLOWER == "no" ]]
	then
		echo "Please enter your username"
		read EMAILUSER;
else 

	echo "Bad Input....Exiting the program"  
	exit 
fi		


################################ Asking the password (masked input) #########################################

 

echo "Please enter your password"

read -s EMAILPASS

echo 

echo 
##############################     EMAIL SUBJECT and BODY   ##############################################
echo "Please enter subject"

read EMAILSUBJECT

echo

echo

echo "Type message body"

read MESSAGEBODY

echo
echo
#############################            ATTACHMENTS  and sending email accordingly    ###############################################
echo "Do you want include any attachments (yes/no)?"

read ATTACHMENT

ATTACHMENTLOWER=$(echo "$ATTACHMENT" | tr '[:upper:]' '[:lower:]')



if [[ $ATTACHMENTLOWER == "yes" ]] 

	then

		echo "Please enter the file location";
		read LOCATION
		echo "Sending email....." 
		sendEmail -f $EMAILFROM -t $EMAILTO -u $EMAILSUBJECT -m $MESSAGEBODY  -s $EMAILSERVER -xu $EMAILUSER -xp $EMAILPASS -o tls=yes -a $LOCATION  ##Normal mesage with attachements

elif [[ $ATTACHMENTLOWER == "no" ]] 
	then
		
		echo "Sending email....."
		sendEmail -f $EMAILFROM -t $EMAILTO -u $EMAILSUBJECT -m $MESSAGEBODY  -s $EMAILSERVER -xu $EMAILUSER -xp $EMAILPASS -o tls=yes  ##Normal mesage without attachments
	
else [[ $ATTACHMENTLOWER == *""* ]] 
	echo "bad input.... exiting" 
	exit

fi
####

