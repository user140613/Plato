(define (problem blocksworld_problem)
   (:domain blocksworld_domain)
   (:objects
      a - block
      b - block
      c - block
   )
   (:init
      (On c b)
      (OnGround a)
      (OnGround b)
      (TopClear a)
      (TopClear c)
   )
   (:goal (and
      (On a b)
      (On b c)
      (OnGround c)
   ))
)