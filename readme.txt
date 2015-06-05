This is a web application written in Coldfusion to encrypt and decrypt text utilizing Trithemius cipher. You can see the app in action on my website at http://www.WorldOfXophe.com/portfolio/trit.cfm. If you're not familiar with Adobe Coldfusion, it's a scripting language similar to PHP or ASP, used to create dynamic web pages, and requires the Coldfusion server.

trit.cfm is the page to view in a web browser. A .cfm page is just a normal html page with Coldfusion code embedded -- the ".cfm" extension tells the Coldfusion application server to process all of the page's code and render it as html to the browser.

trithemius.cfc is the "class" (or component, as it's called in CF) that is instantiated as an object to show the user how the encoding works, to do the calculations, and return the encrypted or decrypted text.

I've included 2 ways to encrypt/decrypt -- the first is simple -- encryption is based on the character's position in a table, and is not hard to break. The second uses a key (either a default key or one provided by the user), which is a list of integers of any length. This makes the cipher text much harder to break, and theoretically impossible* to break if the key is large enough and contains no mathematic pattern.
