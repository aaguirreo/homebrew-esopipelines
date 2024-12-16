class EsopipeCriresRecipes < Formula
  desc "ESO CRIRES instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/crires/crire-kit-2.3.19.tar.gz"
  sha256 "bb61983ba2c57b45f2d1ebd78f321e12badff824351ace4d4227fa97ead2bbe6"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?crire-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-crires-recipes-2.3.19"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "bbf23dcabed9b3bb1ffb0e23e04b9b0549d624914a9da4e7c21040552dcf97a0"
    sha256 cellar: :any,                 arm64_sonoma:  "e3d246f39d19e066f1d98c4a48c645e7057ba418557f14b2bfd77c02b976657e"
    sha256 cellar: :any,                 ventura:       "2ff6759ca4f5359bc69856a331654c6f96932547e57c446ec5291d38269581f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc634158e5c21af4e84aa44a83135781c5030e415d569fd4eb467b3305e65387"
  end

  def name_version
    "crire-#{version.major_minor_patch}"
  end

  depends_on "pkgconf" => :build
  depends_on "cpl@7.3.2"
  depends_on "esorex"

  def install
    system "tar", "xf", "#{name_version}.tar.gz"
    cd name_version.to_s do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl@7.3.2"].prefix}"
      system "make", "install"
    end
  end

  test do
    assert_match "crires_spec_dark -- version #{version.major_minor_patch}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page crires_spec_dark")
  end
end
