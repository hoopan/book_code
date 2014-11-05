;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(let [x :a
      f (^:once fn* [] (println x))]
  (f)  ;; prints :a
  (f)) ;; prints nil

(let [x :a
      f (fn [] (println x))]
  (f)  ;; prints :a
  (f)) ;; prints :a