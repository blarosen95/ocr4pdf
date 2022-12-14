# frozen_string_literal: true

RSpec.describe Ocr4pdf do
  it "has a version number" do
    expect(Ocr4pdf::VERSION).not_to be nil
  end

  it "raises an error when non-PDF files are passed" do
    expect { Ocr4pdf.new("spec/fixtures/tesseract-screenshot.png").create_ocr_pdf }.to raise_error("Input file must be a PDF")
  end

  it "can create a PDF with OCR text from a rasterized PDF" do
    ocr_blob = Ocr4pdf.new("spec/fixtures/tesseract-screenshot.pdf").create_ocr_pdf
    File.binwrite("spec/fixtures/tesseract-screenshot.ocr.pdf", ocr_blob)
    ocr_file = File.expand_path("spec/fixtures/tesseract-screenshot.ocr.pdf")

    first_line_text = Open3.capture2("pdftotext -f 1 -l 1 -r 300 #{ocr_file} - | head -n 1")[0].strip
    expect(first_line_text).to eq "Tesseract documentation"

    # Delete the file
    File.delete(ocr_file)
  end

  it "can create a PDF with OCR text from a PDF with regular embedded text" do
    ocr_blob = Ocr4pdf.new("spec/fixtures/w4-page-2.pdf").create_ocr_pdf
    File.binwrite("spec/fixtures/w4-page-2.ocr.pdf", ocr_blob)
    ocr_file = File.expand_path("spec/fixtures/w4-page-2.ocr.pdf")

    first_line_text = Open3.capture2("pdftotext -f 1 -l 1 -r 300 #{ocr_file} - | head -n 1")[0].strip
    expect(first_line_text).to start_with "Form W-4 (2022)"

    # Delete the file
    File.delete(ocr_file)
  end

  it "can create a PDF from a multi-page rasterized PDF" do
    ocr_blob = Ocr4pdf.new("spec/fixtures/form-w4.pdf").create_ocr_pdf
    File.binwrite("spec/fixtures/form-w4.ocr.pdf", ocr_blob)
    ocr_file = File.expand_path("spec/fixtures/form-w4.ocr.pdf")

    third_page_first_text_line = Open3.capture2("pdftotext -f 3 -l 3 -r 300 #{ocr_file} - | head -n 3")[0].strip
    third_page_first_text_line = third_page_first_text_line.tr("\n", " ").gsub(/\s{2,}/, " ")
    # TODO: The following is a flaw of poppler-util's pdftotext, the OCR result is actually correct:
    expect(third_page_first_text_line).to start_with "Form W-4 (2022) Page3"

    # Delete the file
    File.delete(ocr_file)
  end
end
