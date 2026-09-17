class Armfortas < Formula
  desc "Bespoke Fortran compiler for ARM64 and x86_64"
  homepage "https://github.com/FortranGoingOnForty/armfortas"
  url "https://github.com/FortranGoingOnForty/armfortas/releases/download/v0.1.0/armfortas-0.1.0.tar.gz"
  sha256 "e59fc642d28637dae814ec431cad898388a219a68db8f8c02ff64a4782859492"
  license "GPL-3.0-only"

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/armfortas --version")
    assert_match version.to_s, shell_output("#{bin}/afs --version")

    (testpath/"hello.f90").write <<~FORTRAN
      program hello
        print *, "ARMFORTAS package smoke"
      end program hello
    FORTRAN

    ENV["AFS_RUNTIME_CACHE"] = (testpath/"runtime-cache").to_s
    system bin/"armfortas", "hello.f90", "-o", "hello"
    assert_match "ARMFORTAS package smoke", shell_output("./hello")
  end
end
