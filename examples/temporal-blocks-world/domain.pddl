(define (domain blocksworld_domain)
   (:requirements :action-costs :durative-actions :fluents :negative-preconditions :typing)
   (:types
      Boolean - root
      block - root
      root - object
   )
   (:constants
   )
   (:predicates
      (Holding ?block1 - block)
      (On ?block1 - block ?block2 - block)
      (OnGround ?block1 - block)
      (TopClear ?block1 - block)
   )
   (:functions
   )
   (:durative-action pick-up-from-block
      :parameters (?block1 - block ?block2 - block)
      :duration
         (= ?duration 10.0)
      :condition (and
         (at start
            (On ?block1 ?block2)
         )
         (at start
            (TopClear ?block1)
         )
         (at start
            (forall (?block3 - block)
               (not
                  (Holding ?block3)
               )
            )
         )
      )
      :effect (and
         (at end
            (Holding ?block1)
         )
         (at end
            (TopClear ?block2)
         )
         (at end
            (not
               (On ?block1 ?block2)
            )
         )
      )
   )
   (:durative-action pick-up-from-ground
      :parameters (?block1 - block)
      :duration
         (= ?duration 5.0)
      :condition (and
         (at start
            (OnGround ?block1)
         )
         (at start
            (TopClear ?block1)
         )
         (at start
            (forall (?block2 - block)
               (not
                  (Holding ?block2)
               )
            )
         )
      )
      :effect (and
         (at end
            (Holding ?block1)
         )
      )
   )
   (:durative-action put-down-on-block
      :parameters (?block1 - block ?block2 - block)
      :duration
         (= ?duration 10.0)
      :condition (and
         (at start
            (Holding ?block1)
         )
         (at start
            (TopClear ?block2)
         )
      )
      :effect (and
         (at end
            (On ?block1 ?block2)
         )
         (at end
            (not
               (Holding ?block1)
            )
         )
         (at end
            (not
               (TopClear ?block2)
            )
         )
      )
   )
   (:durative-action put-down-on-ground
      :parameters (?block1 - block)
      :duration
         (= ?duration 5.0)
      :condition (and
         (at start
            (Holding ?block1)
         )
      )
      :effect (and
         (at end
            (OnGround ?block1)
         )
         (at end
            (not
               (Holding ?block1)
            )
         )
      )
   )


)