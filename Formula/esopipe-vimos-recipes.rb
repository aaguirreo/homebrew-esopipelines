class EsopipeVimosRecipes < Formula
  desc "ESO VIMOS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/vimos/vimos-kit-4.1.10.tar.gz"
  sha256 "e4394926ada4e5f59be3de67d56630bf113943d2398298a8f2b7abf1e908de4e"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?vimos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-vimos-recipes-4.1.10"
    sha256 cellar: :any,                 arm64_sequoia: "48c1208a65b37a5f2847f7794bed3c30b208b1580b210f810a91859b8044f7ca"
    sha256 cellar: :any,                 arm64_sonoma:  "424a9a36b379eb65d6ec8b23f3354ce8c3167a61233ce9e302b5f84e1aaff13c"
    sha256 cellar: :any,                 ventura:       "298d792e4dc27127b13d013c7b88c98ee6bfe8ab35411aa034d6a546fd917432"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff19b62281b5b3c3ecf48a55e6cdc5ef61f189f8a5cee2780b5ee78dcf7f842c"
  end

  def name_version
    "vimos-#{version.major_minor_patch}"
  end

  depends_on "pkgconf" => :build
  depends_on "cfitsio@4.2.0"
  depends_on "cpl@7.3.2"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl@2.6"

  uses_from_macos "curl"

  def install
    system "tar", "xf", "#{name_version}.tar.gz"
    cd name_version.to_s do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cfitsio=#{Formula["cfitsio@4.2.0"].prefix}",
                            "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}",
                            "--with-gsl=#{Formula["gsl@2.6"].prefix}"
      system "make", "install"
    end
  end

  def post_install
    workflow_dir_1 = prefix/"share/reflex/workflows/#{name_version}"
    workflow_dir_2 = prefix/"share/esopipes/#{name_version}/reflex"
    workflow_dir_1.glob("*.xml").each do |workflow|
      ohai "Updating #{workflow}"
      if workflow.read.include?("CALIB_DATA_PATH_TO_REPLACE")
        inreplace workflow, "CALIB_DATA_PATH_TO_REPLACE", HOMEBREW_PREFIX/"share/esopipes/datastatic"
      end
      if workflow.read.include?("ROOT_DATA_PATH_TO_REPLACE")
        inreplace workflow, "ROOT_DATA_PATH_TO_REPLACE", "#{Dir.home}/reflex_data"
      end
      if workflow.read.include?("$ROOT_DATA_DIR/reflex_input")
        inreplace workflow, "$ROOT_DATA_DIR/reflex_input", HOMEBREW_PREFIX/"share/esopipes/datademo"
      end
      cp workflow, workflow_dir_2
    end
  end

  test do
    assert_match "vimos_ima_dark -- version #{version.major_minor_patch}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page vimos_ima_dark")
  end
end
