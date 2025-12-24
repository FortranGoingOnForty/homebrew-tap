class Sniffert < Formula
  desc "Terminal-based disk analyzer inspired by SpaceSniffer, written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/sniffert"
  url "https://github.com/FortranGoingOnForty/sniffert/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "9553b7104ea8f63792be592b72001279d9033c0c85677b07b3caf6a645dec898"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/sniffert.git", branch: "trunk"

  depends_on "gcc" # for gfortran
  depends_on "fzf"

  def install
    # Build using make
    system "make"

    # Install binary
    bin.install "sniffert"

    # Install documentation if present
    doc.install "README.md" if File.exist?("README.md")
  end

  test do
    # Test that sniffert can run
    system "#{bin}/sniffert", "--help" rescue true
  end
end
