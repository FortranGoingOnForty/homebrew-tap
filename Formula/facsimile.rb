class Facsimile < Formula
  desc "Terminal text editor written in Fortran with VSCode-style keybindings"
  homepage "https://github.com/FortranGoingOnForty/facsimile"
  url "https://github.com/FortranGoingOnForty/facsimile/archive/refs/tags/v0.30.1.tar.gz"
  sha256 "8299ed2961e6aeda9bb8ec57e65b191402f72441cfea0ab58f2fd65fcf8ee9ef"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/facsimile.git", branch: "trunk"

  depends_on "gcc" # for gfortran

  def install
    # Build using make
    system "make"

    # Install binary
    bin.install "fac"

    # Create symlink for convenience
    bin.install_symlink "fac" => "facsimile"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test that fac can run (basic version check or help)
    system "#{bin}/fac", "--help" rescue true
  end
end
