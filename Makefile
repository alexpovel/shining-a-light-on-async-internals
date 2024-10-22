%.html: %.md custom.html
	pandoc --to=revealjs --incremental --embed-resources --standalone --slide-level=2 --include-in-header=custom.html --output=$@ $<

.PHONY: watch
watch:
	@echo "Watching for changes..."
	@cargo watch --watch presentation.md --shell "make presentation.html"
