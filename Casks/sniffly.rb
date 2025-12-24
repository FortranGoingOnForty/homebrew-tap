cask "sniffly" do
  version "0.4.3"
  sha256 "52c8a18288c15460a9612a9c08324541471ebf2ccec3879970c6b3e7afdf23b8"

  url "https://github.com/FortranGoingOnForty/sniffly/releases/download/v#{version}/Sniffly-#{version}-macOS.zip"
  name "Sniffly"
  desc "Fast, visual disk space analyzer built with Fortran and GTK4"
  homepage "https://github.com/FortranGoingOnForty/sniffly"

  # No dependencies needed - all GTK4 libraries are bundled!
  app "Sniffly.app"

  zap trash: "~/Library/Logs/Sniffly.log"
end
