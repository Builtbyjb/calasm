dev:
	as calasm.s -o calasm.o && \
	ld calasm.o -o calasm -l System -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64
