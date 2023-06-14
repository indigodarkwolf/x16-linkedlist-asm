.include "example.inc"

;=================================================
;=================================================
;
; Example use
;
;-------------------------------------------------

.bss
LIST_INSTANTIATE "foo", 100

.segment "ONCE"
.segment "STARTUP"
	jsr list_test

.code
LIST_IMPLEMENT "foo", 100

.proc list_test
	LIST_INIT "foo"
	LIST_ALLOC "foo"	; Allocates index 0
	LIST_ALLOC "foo"	; Allocates index 1
	LIST_ALLOC "foo"	; Allocates index 2
	LIST_ALLOC "foo"	; Allocates index 3
	LIST_ALLOC "foo"	; Allocates index 4
	lda #2
	LIST_FREE "foo"		; Frees index 2
	LIST_ALLOC "foo"	; Allocates index 5

	jsr list_for_test
	jsr list_for_rev_test

	lda #0
	LIST_FREE "foo"
	lda #1
	LIST_FREE "foo"
	lda #3
	LIST_FREE "foo"
	lda #4
	LIST_FREE "foo"
	lda #5
	LIST_FREE "foo"

	LIST_ALLOC "foo"	; Allocates index 6
	LIST_ALLOC "foo"	; Allocates index 7
	LIST_ALLOC "foo"	; Allocates index 8
	LIST_ALLOC "foo"	; Allocates index 9
	LIST_ALLOC "foo"	; Allocates index 10

	jsr list_for_test
	jsr list_for_rev_test

	rts
.endproc

.proc list_for_test
	stz $03
	LIST_FOR_BEGIN "foo", "test_for", sta $02
		cmp #$03
		bne not_index_3
		LIST_FOR_CONTINUE "foo", "test_for"
	not_index_3:
		ldx $03
		sta $04,x
		inx
		stx $03
	LIST_FOR_END "foo", "test_for", lda $02
	rts
.endproc

.proc list_for_rev_test
	stz $03
	LIST_FOR_BEGIN_REVERSE "foo", "test_for", sta $02
		cmp #$03
		bne not_index_3
		LIST_FOR_CONTINUE_REVERSE "foo", "test_for"
	not_index_3:
		ldx $03
		sta $04,x
		inx
		stx $03
	LIST_FOR_END_REVERSE "foo", "test_for", lda $02
	rts
.endproc

.export list_test

