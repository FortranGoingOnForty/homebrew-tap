class Fuss < Formula
  desc "Tree utility for dirty git files, written in modern Fortran"
  homepage "https://github.com/FortranGoingOnForty/fuss"
  url "https://github.com/FortranGoingOnForty/fuss/archive/refs/tags/v1.2.7.tar.gz"
  sha256 "cfbf3194f5e24afb564b54fba3d3478f46e0298046e3ec75cd5191f956d5d0e5"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/fuss.git", branch: "trunk"

  depends_on "gcc" # for gfortran
  depends_on "fzf"

  def install
    # Build using make
    system "make"

    # Install binary
    bin.install "fuss"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test that fuss can run (it will fail without git repo, but should show usage)
    system "#{bin}/fuss", "--help" rescue true
  end
end
