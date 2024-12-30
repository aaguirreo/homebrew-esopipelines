class EsopipeSofi < Formula
  desc "ESO SOFI instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/sofi/sofi-kit-1.5.16.tar.gz"
  sha256 "ce0fc266650c962291f0ce07fc32b687703fed6c6440a68114022d47c96b165e"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?sofi-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-sofi-1.5.16"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c14f518121b469f8116a9ad0777da7b53c1ec33ed97676e5f9fbc8d11b9c4f94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "71a82fca22ffe41ebed85c66337d01300045418ae2ba1bf66caf6fde5d5ba3ef"
    sha256 cellar: :any_skip_relocation, ventura:       "caad4dc2512f843de9cec3e56b8eebe5c9498d1be75ffa31b9c597fbd26e8d30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8960d583bddd14ba42089c58175663173f1584f1f80a724106e9eeb3e5d58eea"
  end

  def pipeline
    "sofi"
  end

  depends_on "esopipe-sofi-recipes"

  def install
    system "tar", "xf", "#{pipeline}-calib-#{version.major_minor_patch}.tar.gz"
    (prefix/"share/esopipes/datastatic/#{pipeline}-#{version.major_minor_patch}").install Dir["#{pipeline}-calib-#{version.major_minor_patch}/cal/*"]
  end

  test do
    system "true"
  end
end
