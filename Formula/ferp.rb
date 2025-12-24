class Ferp < Formula
  desc "A GNU grep clone written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/ferp"
  url "https://github.com/FortranGoingOnForty/ferp/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "22215a544137239defd1a419db88a7bc49bb3d8d2a8728619200992c7b4c5394"
  head "https://github.com/FortranGoingOnForty/ferp.git", branch: "trunk"

  depends_on "gcc" => :build
  depends_on "llvm" => :build
  depends_on "pcre2"

  def install
    # Use -j1 to avoid race condition: release target runs clean, then parallel jobs
    # start before build directory is recreated
    system "make", "-j1", "release", "FC=gfortran"
    bin.install "ferp"

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
  end

  test do
    assert_match "hello", pipe_output("#{bin}/ferp hello", "hello world")
  end
end
