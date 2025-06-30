libssw.so: ssw.c
	gcc $< -shared -fPIC -o $@

test: test.c ssw.c
	gcc $< -o $@
