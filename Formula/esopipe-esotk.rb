class EsopipeEsotk < Formula
  desc "ESO ESOTK instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/esotk/esotk-kit-0.9.8-10.tar.gz"
  sha256 "cc2c578a96f88ff7e287a13d6a8d1e4ecb05c545c80c973fb95889135cfea942"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?esotk-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-esotk-recipes"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "esotk-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/esotk-#{version_norevision}").install Dir["esotk-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
