# g2.vim

No, it's not about G-spot.

Adds `g2` mapping. It prints binary values of the bytes used in the character
under the cursor, assuming it is in
[UTF-8](http://vimdoc.sourceforge.net/htmldoc/mbyte.html#utf8) encoding. This
also shows composing characters.

Example of a character with two composing characters:

    01100101 + 11001100 10000001 + 11001101 10000101

The `g2` mapping is equivalent to vim's builtin
[g8](http://vimdoc.sourceforge.net/htmldoc/various.html#g8),
it just shows binary instead of hex values.

### Licence

[MIT](LICENSE.md)
