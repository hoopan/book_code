/***
 * Excerpted from "Pragmatic Scala",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/vsscala2 for more book information.
***/
def calculator(input: Int) = { println(s"calc with $input"); input }

val equipment1 = new Equipment(calculator)
val equipment2 = new Equipment(calculator)

equipment1.simulate(4)
equipment2.simulate(6)
