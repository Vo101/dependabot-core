module github.com/dependabot/dependabot-core/go_modules/helpers

require (
	github.com/Masterminds/vcs v1.12.0
	github.com/dependabot/dependabot-core/go_modules/helpers/updater v0.0.0
	github.com/dependabot/gomodules-extracted v0.0.0-20181020215834-1b2f850478a3
)

replace github.com/dependabot/dependabot-core/go_modules/helpers/importresolver => ./importresolver

replace github.com/dependabot/dependabot-core/go_modules/helpers/updater => ./updater

replace github.com/dependabot/dependabot-core/go_modules/helpers/updatechecker => ./updatechecker

replace github.com/Masterminds/vcs => github.com/dependabot/vcs v1.12.1-0.20190208210831-56e31f59151a
