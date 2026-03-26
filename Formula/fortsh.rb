class Fortsh < Formula
  desc "Modern Unix shell implementation in Fortran with AST-based parsing"
  homepage "https://github.com/FortranGoingOnForty/fortsh"
  url "https://github.com/FortranGoingOnForty/fortsh/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "e317822928b621b896ecf1bf9f12b493e8c83c7b618fe749232f420ea867ab14"
  license "GPL-3.0-only"
  head "https://github.com/FortranGoingOnForty/fortsh.git", branch: "trunk"

  depends_on "gcc" # for gfortran
  depends_on "fzf" # for interactive keybinds

  def install
    # Build using release target for optimized build
    system "make", "release"

    # Install binary
    bin.install "bin/fortsh"

    # Install documentation
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      fortsh includes interactive fzf keybinds:
        Ctrl+F  - File browser
        Ctrl+R  - History browser
        Alt+j   - Directory jump
        Alt+g   - Git browser
    EOS
  end

  test do
    # Test that fortsh can execute a simple command
    assert_match "fortsh", shell_output("#{bin}/fortsh --version 2>&1", 1)
  end
end
