class CodCli < Formula
  desc "CLI for common commands used by CO Digital staff"
  homepage "https://github.com/govwifi/cod-cli"
  url "git@github.com:govwifi/cod-cli.git",
      using:    :git,
      tag:      "v5.112.0",
      revision: "3247f57d0f2f4241b7a9bd975c383881d3339921"
  head "git@github.com:govwifi/cod-cli.git",
      using:  :git,
      branch: "main"

  depends_on "go" => :build
  depends_on "aws-vault" if OS.linux?
  depends_on "awscli"
  depends_on "ykman"

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = `uname -m`.strip == "x86_64" ? "amd64" : "arm64"

    system "make"

    bin.install "cod"
    bin.install_symlink("cod" => "cod-cli")

    # Completion for `cod`
    output = Utils.safe_popen_read("#{bin}/cod", "shell-completion", "bash")
    (bash_completion/"cod").write output
    output = Utils.safe_popen_read("#{bin}/cod", "shell-completion", "zsh")
    (zsh_completion/"_cod").write output

    # Completion for `cod-cli`
    output = Utils.safe_popen_read("#{bin}/cod-cli", "shell-completion", "bash")
    (bash_completion/"cod-cli").write output
    output = Utils.safe_popen_read("#{bin}/cod-cli", "shell-completion", "zsh")
    (zsh_completion/"_cod-cli").write output
  end

  def caveats
    return if OS.linux?

    "cod-cli depends on aws-vault being installed.  You can install it with `brew install --cask aws-vault`."
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/cod"))
  end
end
