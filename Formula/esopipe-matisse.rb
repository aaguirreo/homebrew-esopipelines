class EsopipeMatisse < Formula
  desc "ESO MATISSE instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/matisse/matisse-kit-2.2.0-5.tar.gz"
  sha256 "ca482f85356e193add2368eceb0ed6ad2410860dc015c163cce276e0044f132c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?matisse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-matisse-recipes"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "matisse-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/matisse-#{version_norevision}").install Dir["matisse-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
