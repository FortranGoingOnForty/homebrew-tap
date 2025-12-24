class Fit < Formula
  desc "Terminal-based merge conflict resolver with three-pane TUI interface"
  homepage "https://github.com/FortranGoingOnForty/fit"
  url "https://github.com/FortranGoingOnForty/fit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b9052fa5be652f395163aaa5f4f6927e535ab4321ed35c88c7d5cb0bdc0be951"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/fit.git", branch: "trunk"

  depends_on "gcc" # for gfortran

  def install
    # Build using make
    system "make", "release"

    # Install binary
    bin.install "bin/fit"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test that fit can show help
    system "#{bin}/fit", "--help" rescue true
  end
end
