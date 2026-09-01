class Facsimile < Formula
  desc "Terminal text editor written in Fortran with VSCode-style keybindings"
  homepage "https://github.com/FortranGoingOnForty/facsimile"
  url "https://github.com/FortranGoingOnForty/facsimile/archive/refs/tags/v0.33.0.tar.gz"
  sha256 "9914694095c0264ed8c5df712e45c3494302f96c54c59ff0141e00c37df9fed3"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/facsimile.git", branch: "trunk"

  depends_on "gcc" # for gfortran

  def install
    # Pin the compiler to the GCC dependency. On Apple silicon, allowing Make
    # to discover another Fortran compiler can produce a binary that aborts on
    # deferred-length character assignment in the command palette.
    system "make", "FC=#{formula_opt_bin("gcc")}/gfortran"

    # Install binary
    bin.install "fac"

    # Create symlink for convenience
    bin.install_symlink "fac" => "facsimile"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test that fac can run (basic version check or help)
    system "#{bin}/fac", "--help"
  end
end
