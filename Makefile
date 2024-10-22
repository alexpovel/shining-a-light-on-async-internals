# Setting the `revealjs-url` variable to the local checkout speeds things up. Otherwise,
# pandoc will fetch from remote on every compile. In my case that was from `unpkg.com`,
# which rate-limited me after a while.
%.html: %.md custom.html
	@echo "Converting $< to $@..."
	git submodule update --init --recursive
	pandoc \
		--verbose \
		--variable=revealjs-url:./reveal.js \
		--to=revealjs \
		--incremental \
		--embed-resources \
		--standalone \
		--slide-level=2 \
		--include-in-header=custom.html \
		--output=$@ \
		$<

.PHONY: watch
watch:
	@echo "Watching for changes..."
	@cargo watch --watch presentation.md --shell "make presentation.html"

static/qrcode.svg:
	@echo "Generating QR code..."
	@qrencode -t SVG -o $@ "https://github.com/alexpovel/shining-a-light-on-async-internals"
