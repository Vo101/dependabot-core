# frozen_string_literal: true

require "dependabot/utils"
require "dependabot/dependency_file"
require "dependabot/npm_and_yarn/file_parser"
require "dependabot/npm_and_yarn/version"

module Dependabot
  module NpmAndYarn
    class SubDependencyFilesFilterer
      def initialize(dependency_files:, dependencies:)
        @dependency_files = dependency_files
        @dependencies = dependencies
      end

      def filtered_lockfiles
        lockfiles.select do |lockfile|
          sub_dependencies(lockfile).any? do |sub_dep|
            dependencies.any? do |dep|
              sub_dep.name == dep.name &&
                version_class.new(dep.version) >
                  version_class.new(sub_dep.version)
            end
          end
        end
      end

      private

      attr_reader :dependency_files, :dependencies

      def sub_dependencies(lockfile)
        # Add dummy_package_manifest to keep existing validation login in base
        # file parser
        NpmAndYarn::FileParser.new(
          dependency_files: [dummy_package_manifest, lockfile],
          source: nil,
          credentials: nil # Only needed for top level dependencies
        ).parse
      end

      def lockfiles
        @lockfiles ||= dependency_files.select { |file| lockfile?(file) }
      end

      def dummy_package_manifest
        @dummy_package_manifest ||= Dependabot::DependencyFile.new(
          content: "{}",
          name: "package.json"
        )
      end

      def lockfile?(file)
        file.name.end_with?(
          "package-lock.json",
          "yarn.lock",
          "npm-shrinkwrap.json"
        )
      end

      def version_class
        NpmAndYarn::Version
      end
    end
  end
end
