test:
	prove -Ilib -j4 `find t/ -type f -name "*.t"`