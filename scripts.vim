if did_filetype()
  finish
endif

if getline(1) =~ "^#!.*/racket"
  setfiletype racket
endif

if getline(1) =~ "^#!.*/pollen"
  setfiletype pollen
endif
