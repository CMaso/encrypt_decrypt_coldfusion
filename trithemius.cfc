<cfcomponent hint="functions for encrypting and decrypting text using Trithemius cipher">

<!---------
showTabulaRecta
---------->
<cffunction name="showTabulaRecta" access="public" returntype="string" hint="Will draw the tabula recta, which illustrates how Trithemius cipher encrypts text">

	<cfset var tabula = "">
	<cfset var length = 0>
	<cfset var alphabet = arrayNew(1)>
	
	<!--- note - the alphabet array contains numbers, as well --->
	<cfloop from="97" to="122" index="i">
		<cfset alphabet[i-96]=chr(i)>
	</cfloop>
	
	<!--- this adds numbers to the table --->
	<cfloop from="0" to="9" index="n">
		<cfset alphabet[27+n]="#n#">
	</cfloop>
	
	<cfset length=arrayLen(alphabet)>
	
	<cfsavecontent variable="tabula">
		<cfoutput>
		<div style="font-family:courier;padding-left:130px;white-space:nowrap;">
		<cfloop from="0" to="#length-1#" index="a">
			#a + 1# <cfif a LT 9>&nbsp;</cfif>- <cfloop from="0" to="#length-1#" index="i">#alphabet[(i+a) mod length + 1]# |</cfloop><br />
		</cfloop>
		</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn tabula>

</cffunction>

<!---------
encryptSimple
---------->
<cffunction name="encryptSimple" access="public" returntype="string" output="no" hint="Encrypts to Trithemius cipher using keyless algorithm">

	<cfargument name="str" type="string" required="yes">
	
	<cfset var arrStr = "">
	<cfset var arrLength = "">
	<cfset var letterCounter = 0>
	<cfset var alphabet = arrayNew(1)>
	<cfset var cipherText = "">
	<cfset var alphaList = "">
	<cfset var letterIndex = "">
	<cfset var letterEncrypted = "">
	
	<!--- create array holding lower case alphabet --->
	<cfloop from="97" to="122" index="i">
		<cfset alphabet[i-96]=chr(i)>
	</cfloop>
	
	<cfloop from="0" to="9" index="n">
		<cfset alphabet[27+n]="#n#">
	</cfloop>
	
	<!--- keep a comma-delimited list of alphabet - we'll need this, since CF has no native function to find a value's index within an array --->
	<cfset alphaList = arrayToList(alphabet)>
	
	<!--- <cfset strAbra=strAbra.replaceAll( '\B' , "-" ) /> --->
	<!--- java function to insert pipes into empty spaces of string, so as to make it a pipe-delimited list --->
	<cfset arguments.str = arguments.str.replaceAll( '' , "|" )>
	
	<!--- convert to an array, including spaces between words. (Leading and trailing commas will be removed --->
	<cfset arrStr = listToArray(arguments.str, "|")>
	
	<!--- hold length of the string in a variable, so it only has to be evaluated once --->
	<cfset arrLength = arrayLen(arrStr)>
	
	<!--- Now the fun begins. Loop over each letter in the array, and convert based on algorithm of Trithemius cipher. Note that blank spaces do not count, nor do special chars or anything not found in the alphabet; so it's necessary to use the letterCounter var to know which row in the tabula recta to use for a given letter--->
	<cfloop from="1" to="#arrLength#" index="i">
		<cfif not listFindNoCase(alphaList, arrStr[i])> <!--- if char is not in the alphabet, do not try to encrypt it or increment letterCounter --->
			<cfset cipherText = cipherText & arrStr[i]>
		<cfelse>
			<!--- find the letter's location in the alphabet.  Then subtract 1. --->
			<cfset letterIndex = listFindNoCase(alphaList, arrStr[i])-1>
			
			<!--- encrypt the letter, append to cipherText, increment letterCounter--->
			
			<!--- encrypting requires some playing with the numbers, since 26 mod 26 = zero, and we need to avoid letting zero appear in the brackets - this will throw an error. So we add 1 at the very end; this ensures that the final number will be a value between 1 and 26 instead of a value between 0 and 25.  This is also the reason we have to subtract 1 when setting letterIndex.  If we didn't, letterEncrypted would be 1 letter too high. --->
			<cfset letterEncryted = alphabet[(letterCounter + letterIndex) mod 36 + 1]>
			<cfset cipherText = cipherText & letterEncryted>
			<cfset letterCounter = letterCounter + 1>
		</cfif>
	</cfloop>
	
	<cfreturn cipherText>

</cffunction>

<!---------
decryptSimple
---------->
<cffunction name="decryptSimple" access="public" returntype="string" output="no" hint="Decrypts Trithemius cipher using keyless algorithm">

<cfargument name="str" type="string" required="yes">
	
	<cfset var arrStr = "">
	<cfset var arrLength = "">
	<cfset var letterCounter = 0>
	<cfset var alphabet = arrayNew(1)>
	<cfset var decryptedText = "">
	<cfset var alphaList = "">
	<cfset var letterIndex = "">
	<cfset var letterDecrypted = "">
	
	<!--- create array holding lower case alphabet --->
	<cfloop from="97" to="122" index="i">
		<cfset alphabet[i-96]=chr(i)>
	</cfloop>
	
	<cfloop from="0" to="9" index="n">
		<cfset alphabet[27+n]="#n#">
	</cfloop>
	
	<!--- keep a comma-delimited list of alphabet - we'll need this, since CF has no native function to find a value's index within an array --->
	<cfset alphaList = arrayToList(alphabet)>
	
	<!--- <cfset strAbra=strAbra.replaceAll( '\B' , "-" ) /> --->
	<!--- java function to insert pipes into empty spaces of string, so as to make it a pipe-delimited list --->
	<cfset arguments.str = arguments.str.replaceAll( '' , "|" )>
	
	<!--- convert to an array, including spaces between words. (Leading and trailing commas will be removed --->
	<cfset arrStr = listToArray(arguments.str, "|")>
	
	<!--- hold length of the string in a variable, so it only has to be evaluated once --->
	<cfset arrLength = arrayLen(arrStr)>
	
	<!--- Now the fun begins. Loop over each letter in the array, and convert based on algorithm of Trithemius cipher. Note that blank spaces do not count, nor do special chars or anything not found in the alphabet; so it's necessary to use the letterCounter var to know which row in the tabula recta to use for a given letter--->
	<cfloop from="1" to="#arrLength#" index="i">
		<cfif not listFindNoCase(alphaList, arrStr[i])> <!--- if char is not in the alphabet, do not try to decrypt it or increment letterCounter --->
			<cfset decryptedText = decryptedText & arrStr[i]>
		<cfelse>
			<!--- decrypt the letter, append to decryptedText, increment letterCounter--->
			<cfset letterIndex = listFindNoCase(alphaList, arrStr[i])-1>
			<cfset letterDecrypted = alphabet[(letterIndex + 26 - (letterCounter mod 36)) mod 36 + 1]>
			<cfset decryptedText = decryptedText & letterDecrypted>
			<cfset letterCounter = letterCounter + 1>
		</cfif>
	</cfloop>
		
	<cfreturn decryptedText>

</cffunction>

<!---------
encryptComplex
---------->
<cffunction name="encryptComplex" access="public" returnType="string" output="no" hint="Encrypts to Trithemius cipher with use of a key (series of numbers)- much more difficult to break code">

	<cfargument name="str" type="string" required="yes">
	<cfargument name="key" type="string" required="no" default="7,26,85,2,94,12,50,19,6,78">
			
	<cfset var arrStr = "">
	<cfset var arrLength = "">
	<cfset var arrKey = "">
	<cfset var arrKeyLength = "">
	<cfset var alphabet = arrayNew(1)>
	<cfset var cipherText = "">
	<cfset var alphaList = "">
	<cfset var letterIndex = "">
	<cfset var letterEncrypted = "">
	
	<cfif NOT len(trim(arguments.key))>
		<cfset arguments.key = "7,26,85,2,94,12,50,19,6,78">
	</cfif>
	
	<!--- create array holding lower case alphabet --->
	<cfloop from="97" to="122" index="i">
		<cfset alphabet[i-96]=chr(i)>
	</cfloop>
	
	<cfloop from="0" to="9" index="n">
		<cfset alphabet[27+n]="#n#">
	</cfloop>
	
	<!--- convert key to an array --->
	<cfset arrKey = listToArray(arguments.key)>
		
	<!--- save this for future use --->
	<cfset arrKeyLength = arrayLen(arrKey)>
						
	<!--- keep a comma-delimited list of alphabet - we'll need this, since CF has no native function to find a value's index within an array --->
	<cfset alphaList = arrayToList(alphabet)>
	
	<!--- <cfset strAbra=strAbra.replaceAll( '\B' , "-" ) /> --->
	<!--- java function to insert pipes into empty spaces of string, so as to make it a pipe-delimited list --->
	<cfset arguments.str = arguments.str.replaceAll( '' , "|" )>
	
	<!--- convert to an array, including spaces between words. (Leading and trailing delimiters will be removed.  Note this means that if pipes (or whatever's being used as the delimiter) are punctuation in the text, they will be stripped out when text is encrypted --->
	<cfset arrStr = listToArray(arguments.str, "|")>
	
	<!--- hold length of the string in a variable, so it only has to be evaluated once --->
	<cfset arrLength = arrayLen(arrStr)>
	
	<!--- Now the fun begins. Loop over each letter in the array, and convert based on algorithm of Trithemius cipher. Note that blank spaces do not count, nor do special chars or anything not found in the alphabet; so it's necessary to use the letterCounter var to know which row in the tabula recta to use for a given letter.  At the same time, the key is used in figuring which row to use, so that the pattern is random rather than the n+1 used in encryptSimple.--->

<!--- note that here I make no use of lettercounter.  spaces and special characters are not encrypted, but they progress the sequence to the next element in the key.  So if my key is "2,5,7", and my string is "a a", then it goes 2 for the a, skips the 5, and goes to 7 for the next a.--->

	<cfloop from="1" to="#arrLength#" index="i">
		<cfif not listFindNoCase(alphaList, arrStr[i])> <!--- if char is not in the alphabet, do not try to encrypt it --->
			<cfset cipherText = cipherText & arrStr[i]>
		<cfelse>
			<!--- find the letter's location in the alphabet.  Then subtract 1. --->
			<cfset letterIndex = listFindNoCase(alphaList, arrStr[i])-1>
			
			
			
			<!--- encrypt the letter, append to cipherText, increment letterCounter--->
			
			<!--- encrypting requires some playing with the numbers, since 26 mod 26 = zero, and we need to avoid letting zero appear in the brackets - this will throw an error. So we add 1 at the very end; this ensures that the final number will be a value between 1 and 26 instead of a value between 0 and 25.  This is also the reason we have to subtract 1 when setting letterIndex.  If we didn't, letterEncrypted would be 1 letter too high. Note that here, in lieu of lettercounter, we use arrKey to make use of the key, which theoretically can be a list of any length of positive integers --->

<!--- A little note here for future ref. Here we're repeating the key.  If the key is 1,12,66 then we want to keep repeating this pattern for as long as we have to.  The way this is done is make the index equal to (i-1) mod 3 + 1 (or really, (i-1) mod arrayKeyLength + 1, since the key has a variable length. --->

			<cfset letterEncryted = alphabet[(arrKey[(i-1) mod arrKeyLength + 1] + letterIndex) mod 36 + 1]>
			<cfset cipherText = cipherText & letterEncryted>
						
		</cfif>
	</cfloop>
	
	<cfreturn cipherText>
	
</cffunction>

<!---------
decryptComplex
---------->
<cffunction name="decryptComplex" access="public" returntype="string" output="no" hint="Decrypts Trithemius cipher using the key provided (using default key if none)">

<!--- note that default key must match the default key of encryptComplex() --->
<cfargument name="str" type="string" required="yes">
<cfargument name="key" type="string" required="no" default="7,26,85,2,94,12,50,19,6,78">
	
	<cfset var arrStr = "">
	<cfset var arrLength = "">
	<cfset var arrKey = "">
	<cfset var alphabet = arrayNew(1)>
	<cfset var decryptedText = "">
	<cfset var alphaList = "">
	<cfset var letterIndex = "">
	<cfset var letterDecrypted = "">
	
	<!--- create array holding lower case alphabet --->
	<cfloop from="97" to="122" index="i">
		<cfset alphabet[i-96]=chr(i)>
	</cfloop>
	
	<cfloop from="0" to="9" index="n">
		<cfset alphabet[27+n]="#n#">
	</cfloop>
	
	<!--- convert key to an array --->
	<cfif not listLen(arguments.key)>
		<cfset arrKey = listToArray("7,26,85,2,94,12,50,19,6,78")>
	<cfelse>
		<cfset arrKey = listToArray(arguments.key)>
	</cfif>
	
	<!--- save this for future use --->
	<cfset arrKeyLength = arrayLen(arrKey)>
		
	<!--- keep a comma-delimited list of alphabet - we'll need this, since CF has no native function to find a value's index within an array --->
	<cfset alphaList = arrayToList(alphabet)>
	
	<!--- <cfset strAbra=strAbra.replaceAll( '\B' , "-" ) /> --->
	<!--- java function to insert pipes into empty spaces of string, so as to make it a pipe-delimited list --->
	<cfset arguments.str = arguments.str.replaceAll( '' , "|" )>
	
	<!--- convert to an array, including spaces between words. (Leading and trailing commas will be removed --->
	<cfset arrStr = listToArray(arguments.str, "|")>
	
	<!--- hold length of the string in a variable, so it only has to be evaluated once --->
	<cfset arrLength = arrayLen(arrStr)>
	
	<!--- Now the fun begins. Loop over each letter in the array, and convert based on algorithm of Trithemius cipher. Note that blank spaces do not count, nor do special chars or anything not found in the alphabet; so it's necessary to use the letterCounter var to know which row in the tabula recta to use for a given letter--->
	<cfloop from="1" to="#arrLength#" index="i">
		<cfif not listFindNoCase(alphaList, arrStr[i])> <!--- if char is not in the alphabet, do not try to decrypt it --->
			<cfset decryptedText = decryptedText & arrStr[i]>
		<cfelse>
			<!--- decrypt the letter, append to decryptedText.  Note here use of arrKey rather than letterCounter, as in decryptSimple()--->
			<cfset letterIndex = listFindNoCase(alphaList, arrStr[i])-1>
			<cfset letterDecrypted = alphabet[(letterIndex + 36 - (arrKey[(i-1) mod arrKeyLength + 1] mod 36)) mod 36 + 1]>
			<cfset decryptedText = decryptedText & letterDecrypted>
			
		</cfif>
	</cfloop>
		
	<cfreturn decryptedText>

</cffunction>

</cfcomponent>