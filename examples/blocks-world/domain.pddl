(define (domain blocksworld_domain)
   (:requirements :negative-preconditions :typing)
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
   (:action pick-up-from-block
      :parameters (?block1 - block ?block2 - block)
      :precondition (and
         (On ?block1 ?block2)
         (TopClear ?block1)
         (forall (?block3 - block)
            (not
               (Holding ?block3)
            )
         )
      )
      :effect (and
         (Holding ?block1)
         (TopClear ?block2)
         (not
            (On ?block1 ?block2)
         )
      )
   )
   (:action pick-up-from-ground
      :parameters (?block1 - block)
      :precondition (and
         (OnGround ?block1)
         (TopClear ?block1)
         (forall (?block2 - block)
            (not
               (Holding ?block2)
            )
         )
      )
      :effect (and
         (Holding ?block1)
         (not
            (OnGround ?block1)
         )
      )
   )
   (:action put-down-on-block
      :parameters (?block1 - block ?block2 - block)
      :precondition (and
         (Holding ?block1)
         (TopClear ?block2)
      )
      :effect (and
         (On ?block1 ?block2)
         (not
            (TopClear ?block2)
         )
         (not
            (Holding ?block1)
         )
      )
   )
   (:action put-down-on-ground
      :parameters (?block1 - block)
      :precondition (and
         (Holding ?block1)
      )
      :effect (and
         (OnGround ?block1)
         (not
            (Holding ?block1)
         )
      )
   )


)