PREFIX ?= /
SRC_DIR := $(dir $(lastword $(MAKEFILE_LIST)))


default:  help


PNG_S := $(wildcard $(SRC_DIR)/*.png)
PNG_I := $(patsubst $(SRC_DIR)/osu-wine-%.png, $(PREFIX)/usr/share/icons/hicolor/%/apps/osu-wine.png, $(PNG_S))

$(PREFIX)/usr/share/icons/hicolor/%/apps/osu-wine.png: $(SRC_DIR)/osu-wine-%.png
	install -Dm644 $< $@


DSK_S := $(wildcard $(SRC_DIR)/*.desktop)
DSK_I := $(patsubst $(SRC_DIR)/%.desktop, $(PREFIX)/usr/share/applications/%.desktop, $(DSK_S))

$(PREFIX)/usr/share/applications/%.desktop: $(SRC_DIR)/%.desktop
	install -Dm644 $< $@


BIN_S := $(SRC_DIR)/osu-wine
BIN_I := $(PREFIX)/usr/bin/osu-wine

$(BIN_I): $(BIN_S)
	install -Dm755 $< $@


CNF_S := $(SRC_DIR)/osu-wine.conf
CNF_I := $(PREFIX)/etc/osu-wine.conf

$(CNF_I): $(CNF_S)
	install -Dm644 $< $@

install: ## Install osu-wine
install: $(PNG_I) $(DSK_I) $(CNF_I) $(BIN_I)

uninstall: ## Delete osu-wine
uninstall:
	@rm -fv $(PNG_I) $(DSK_I) $(CNF_I) $(BIN_I)

deb: ## Create debian package
deb:
	./package.sh debian

help: ## Show help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/\t/'
