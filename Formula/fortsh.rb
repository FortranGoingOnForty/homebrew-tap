class Fortsh < Formula
  desc "Modern Unix shell implementation in Fortran with AST-based parsing"
  homepage "https://github.com/FortranGoingOnForty/fortsh"
  url "https://github.com/FortranGoingOnForty/fortsh/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "e110a76a7e9f78173901d014ccf17b46e40b7573f1ac2844ebd971999111aef4"
  license "GPL-3.0-only"
  head "https://github.com/FortranGoingOnForty/fortsh.git", branch: "trunk"

  # Compiler dependency varies by platform.
  # macOS ARM64 requires flang-new (gfortran has critical bugs on Apple Silicon
  # — see docs/MACOS_ARM64_WORKAROUNDS.md). Everything else uses gfortran.
  on_macos do
    on_arm do
      depends_on "flang"
    end
    on_intel do
      depends_on "gcc"
    end
  end
  on_linux do
    depends_on "gcc"
  end

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
