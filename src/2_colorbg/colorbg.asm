  processor 6502
  include "../include/vcs.h"
  include "../include/macro.h"
  seg code
  org $F000       ; define the code origin at $F000

START:
  CLEAN_START     ; Macro to safely clear the memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set background luminosity color to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #$1E        ; Load color into A ($1E is NTSC yellow)
  sta COLUBK      ; store A to BackgroundColor Address $09

  jmp START       ; Repeat from START

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFFC       ; Defines origin to $FFFC
  .word START     ; Reset vector at $FFFC (where program starts)
  .word START     ; Interrupt vector at $FFFE (unused in the VCS)
