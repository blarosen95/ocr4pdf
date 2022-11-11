require "open3"
require "tmpdir"
require "securerandom"

class Ocr4pdf
  module CreateOcrPdf
    def self.run(src)
      # Make src an absolute path:
      src = File.expand_path(src)

      # Only allow PDF files as input:
      file_type = Open3.capture2("file -b --mime-type #{src}")[0].strip
      raise "Input file must be a PDF" unless file_type == "application/pdf"

      pdf_info_raw = Open3.capture2("pdfinfo", src)[0].split("\n")

      pdf_info = {}
      pdf_info_raw.each { |v| pdf_info[v.split(":")[0]] = v.split(":")[1] }

      page_count = pdf_info["Pages"].to_i
      # TODO: Eventually, should add an exception for 0 pages

      format_helper = page_count.to_s.length

      Dir.mktmpdir do |tmp_dir|
        # TODO: Eventually, should add unpaper usage right around here. That way they not only parse better but look better too.

        Dir.chdir("#{tmp_dir}/") do
          1.upto(page_count) do |page|
            base_name = page.to_s.rjust(format_helper, "0")
            # Create a TIFF file for the page:
            Open3.capture2("pdftocairo -singlefile -f #{page} -l #{page} -tiff #{src} #{base_name}")
            # Run Tesseract on the TIFF, exporting as a PDF:
            Open3.capture2("tesseract #{base_name}.tif #{base_name} pdf quiet")
          end
          # Unite the pages into a single PDF:
          Open3.capture2("pdfunite #{tmp_dir}/*.pdf #{File.basename(src, ".*")}.ocr.pdf")
          File.binread("#{File.basename(src, ".*")}.ocr.pdf").dup
        end
      end
    end
  end
end
