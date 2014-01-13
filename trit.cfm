<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<cfparam name="form.text" default="">
<cfparam name="form.cipherText" default="">
<cfparam name="form.key" default="">

<cfset trithemius = createObject("component", "trithemius")>
<cfset tabulaRecta = trithemius.showTabulaRecta()>

<cfif isDefined("form.actionEncrypt")>
	<cfset form.cipherText = trithemius.encryptComplex(form.text, trim(form.key))>
<cfelseif isDefined("form.actionDecrypt")>
	<cfset form.text = trithemius.decryptComplex(form.cipherText, trim(form.key))>
</cfif>

<head>
	<title>Trithemius Cipher Exercise</title>
<script language="javascript">
function clearText() {
	document.myForm.text.value = "";
}

function clearCipherText() {
	document.myForm.cipherText.value = "";
}
</script>
</head>

<body>
<cfoutput>
This is an exercise to create functions which will encrypt and decrypt strings using Trithemius cipher.<br /><br />

Trithemius cipher is a simple encrypting method making use of a "tabula recta", as the one below:<br /><br />

#tabulaRecta#
<br />
The encryption is done as follows:<br /><br />
First letter in the string corresponds to the letter in the first row (itself).  Second letter in the string corresponds to the letter 1 row below itself.  Third letter in the string
corresponds to the letter 2 rows below itself.  So if a is the first letter, it converts to "a".  If a is the second letter, it converts to the letter 1 row below a, or "b".  If a is the third letter in the string, it converts to 
the letter 2 rows below a, or "c".  And so on.  So, "hello" would be encrypted to "hfnos".<br /><br />

This is easily decrypted once one gets the pattern, mostly because Trithemius cipher has no key.  A key is easily made, though, as a string of random numbers, so that the number of rows to go down corresponds to the random sequence of key elements rather than a predictable n+1.  Example - if my key were "5,21,6,14,7" then "hello" would encrypt to "mzrzv":<br><br>

5 rows down from h = "m"<br>
21 rows down from e = "z"<br>
6 rows down from l = "r"<br>
14 rows down from l = "z"<br>
7 rows down from 0 = "v"<br><br>

and this would be much more difficult to crack.<br><br>
The text areas below will encrypt/decrypt to Trithemius cipher using the key entered (or a default key, if none). Note - I modified the coding scheme to include numbers on 6/3/2010. Ideally, the coding scheme would include all characters, including blank spaces and capital letters, so individual words in the cipher text could not be identified.<br> 

<form name="myForm" action="trit.cfm##pagebottom" method="post">
<a name="pageBottom" />
<table align="center" cellpadding="1" cellspacing="1">
	<tr>
	<td colspan="2">Key (comma-delimited list of positive whole numbers):&nbsp;&nbsp;<input type="text" name="key" value="#form.key#"></td>
	</tr>

	<tr>
		<td align="center">Text:<br><textarea name="text" cols="50" rows="20">#form.text#</textarea><br><input type="submit" value="Encrypt" name="actionEncrypt"><input type="button" value="Clear" onClick="clearText();"></td>
		<td align="center">CipherText:<br><textarea name="cipherText" cols="50" rows="20">#form.cipherText#</textarea><br><input type="submit" value="Decrypt" name="actionDecrypt"><input type="button" value="Clear" onClick="clearCipherText();"></td>
	</tr>
</table>
</form>


</cfoutput>



</body>
</html>
