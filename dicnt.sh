#!/bin/bash

# Checking presence of the dictionnary argument
if [ -z $1  ]
then
	echo "argument missing : precise dictionnary file"
else
	# Checking that dictionnary file is indeed present
	if [ ! -e $1 ]
	then
		# Checking presence of 2nd argument and pulling remote file
		if [ $# -ge 2 ] && [ $2='-netimport' ]
		then
			# getting remote file
			rm dico.txt dico.zip 2> /dev/null
			wget http://www.siteduzero.com/uploads/fr/ftp/mateo21/cpp/dico.zip
			# Unzip and removing .zip
			unzip dico.zip
			rm dico.zip
			# removing any previous instance temp file
			if [ -e countlist ]
			then
				rm countlist
			fi
			# building the count file
			for i in `cat alphabet`
			do
				echo `cat $1 | grep "$i" | wc -l` "-" "$i" >> countlist
			done

			# Sorting the count file
			sort -nro countlist countlist
			cat countlist
			rm countlist
		else
			echo "dictionnary not present. Use '-netimport' option to donwload the file "
		fi
	else
		# removing any previous instance temp file
		if [ -e countlist ]
		then
			rm countlist
		fi
		# building the count file
		for i in `cat alphabet`
		do
			echo `cat $1 | grep "$i" | wc -l` "-" "$i" >> countlist
		done

		# Sorting the count file
		sort -nro countlist countlist
		cat countlist
		rm countlist
	fi
fi
