PLUGIN_NAME = kami
VITAL_MODULES = System.Filepath \
								DateTime

.PHONY: all
all:
	vim -c "Vitalize . --name=$(PLUGIN_NAME) $(VITAL_MODULES)" -c q

.PHONY: test
test:
	themis

.PHONY: doc
doc:
	vimdoc .

.PHONY: lint
lint:
	find . -name "*.vim" | grep -v vital | xargs beco vint

.PHONY: clean
clean:
	/bin/rm -rf autoload/vital*

