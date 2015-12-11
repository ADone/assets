module Lotus
  module Assets
    class Precompiler
      def initialize(configuration, duplicates)
        @configuration = configuration
        @duplicates    = duplicates
      end

      def run
        applications.each do |duplicate|
          config = duplicate.configuration
          config.compile true

          config.files.each do |file|
            Compiler.compile(config, file, basename(file))
          end
        end
      end

      private

      def applications
        @duplicates.empty? ?
          [Lotus::Assets] : @duplicates
      end

      def basename(file)
        File.basename(file, File.extname(file))
      end
    end
  end
end
