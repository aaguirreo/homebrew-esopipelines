class EsopipeKmosRecipes < Formula
  desc "ESO KMOS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.8-7.tar.gz"
  sha256 "63bf3ffae483a37d6ed4ac702d7c960efbffa30c8d62003a0ae7846a8f1d5c43"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-kmos-recipes-4.4.8-7"
    sha256 cellar: :any,                 arm64_sequoia: "631cdb84c6a01d96c05913f6dc499d18459975914b34d241b0b0e529bdd686d3"
    sha256 cellar: :any,                 arm64_sonoma:  "744e984cf41ff4438c9f3ef573177edd4780dabf4bd81d3463ebb214217e0840"
    sha256 cellar: :any,                 ventura:       "d18ede5b118fac2515157081af994d3e8a6372fd2128d7617f2faedf59cac9eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cddcec89df7a0f340c2df071add8a2d7d66d694df220f6da95295d5753950efc"
  end

  def name_version
    "kmos-#{version.major_minor_patch}"
  end

  depends_on "pkgconf" => :build
  depends_on "cpl"
  depends_on "esorex"
  depends_on "telluriccorr"

  def install
    system "tar", "xf", "#{name_version}.tar.gz"
    cd name_version.to_s do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-telluriccorr=#{Formula["telluriccorr"].prefix}"
      system "make", "install"
      rm bin/"kmos_calib.py"
      rm bin/"kmos_verify.py"
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
    assert_match "kmos_dark -- version #{version.major_minor_patch}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
