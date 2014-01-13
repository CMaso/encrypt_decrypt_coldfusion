This is a web application written in Coldfusion to encrypt and decrypt text utilizing Trithemius cipher.
trit.cfm is the page to view in a web browser, and trithemius.cfc is the "class" (or component, as it's called
in CF) that is instantiated as an object to explain how it works and to do the calculations and return the
encrypted/decrypted text.

I've included 2 ways to encrypt/decrypt -- the first is simple -- encryption is based on the character's position in a table,
and is not hard to break. The second uses a key (either a default key or one provided by the user),
which is a list of integers of any length. This makes the cipher text much harder to break.


