class Fortbite < Formula
  desc "Command-line calculator written in Fortran with arbitrary precision arithmetic, complex numbers, and matrices"
  homepage "https://github.com/FortranGoingOnForty/fortbite"
  url "https://github.com/FortranGoingOnForty/fortbite/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "57a88e0694f38f86d21457be70fe0f4438efe8bc84d5850ccde3918de93696eb"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/fortbite.git", branch: "main"

  depends_on "gcc" # for gfortran

  def install
    # Build using default target
    system "make"

    # Install binary
    bin.install "build/bin/fortbite"

    # Install documentation
    doc.install "README.md"
    doc.install "QUICK_REFERENCE.md"
    doc.install "USAGE_GUIDE.md"
  end

  test do
    # Test that fortbite can execute and respond to help command
    assert_match "fortbite", shell_output("echo 'help' | #{bin}/fortbite 2>&1", 0)
  end
end
