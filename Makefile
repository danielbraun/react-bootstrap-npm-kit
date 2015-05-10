JS_SRC = $(shell find lib/ -name *.js -o -name *.jsx) 

all: build

node_modules: package.json
	npm install
	touch $@

build: node_modules build/build.js build/build.css build/fonts build/images 
	@touch $@

build/build.css: assets/app.less 
	@mkdir -p build
	./node_modules/less/bin/lessc $< > $@

build/build.js: $(JS_SRC)
	@mkdir -p build
	./node_modules/browserify/bin/cmd.js -t reactify lib/main.js > $@

build/fonts:  node_modules/bootstrap/fonts 
	cp -r $</ $@

build/images: assets/images
	cp -r $</ $@
	touch $@

clean: 
	rm -rf build/ node_modules/ 

.PHONY: clean 
