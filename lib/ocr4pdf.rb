# frozen_string_literal: true

require_relative "ocr4pdf/version"
require "ocr4pdf/create_ocr_pdf"

class Ocr4pdf
  class Error < StandardError; end

  # attr_reader :source, :errors
  attr_reader :source

  def initialize(src = "")
    @source = src
    # @errors = []
  end

  def create_ocr_pdf
    CreateOcrPdf.run(@source)
  end
end
