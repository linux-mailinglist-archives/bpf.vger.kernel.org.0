Return-Path: <bpf+bounces-65762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11828B27F5C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CA5AE62DC
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5E3002DE;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USYkRbnE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA62877DA;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=lZIxnBcFchywbkFpW4tU9J5FdhssVk9DQpUlJRVL4mtgbGHSAQNcRJAOpEp7Iu/ekFds5ljwx9cYhhJI5NDx8DyQWEf4wWV0HwK4V/tvOAK8dnOBgvFwX8WLjM1QwYJJ1TY5MNqlVw+n52wCJctfEV6eo8vnyYFB5A+IO0iqVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=U/g86Ig1pMFruBqlvyzjZIHjO9UsMDLq3GNFDgoQFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMG+TBVhOK8OZdjAyAoknQgHQScZ+cyDcV9H4yd7gw1Wf+BV+aKsKvG9rbvbr/wbIusvnu4ZOAphtl8lY8z2vPpc+1QVMFZzq4dAkhIMpyHojz22qzWHka7OS1hzXtFb7dWZcoum/nd3uVNA9qr8hcNaJVqcLE0DV0LamhmcW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USYkRbnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8744C4CEF8;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=U/g86Ig1pMFruBqlvyzjZIHjO9UsMDLq3GNFDgoQFww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USYkRbnEwnF4+qENTLbHftnrPtONckoKAuM+TucKwcCuz5bN7omBDrfEGRp65OBcC
	 4k3sDdAZQraKoYZK79ZqgX+lcSjl0CXwaYkUo9hE/l81D8U8iVlMV8w5cLZdu0Qu2x
	 ukY/+FKMNF66kCL3htCyMnVwkeZ+s/Zh+3IyVY9h7iw9c0B3IE9cc4NX7s1FfX2DRI
	 pldxzF88fiCsWy9D9M0ypnb64DAcv2iZX6kisk6iWGwRGHgcn6wT4adr3WQd0H74rv
	 m6qa5Tl3YNl+w/Oh6vmlSv3EsHDg3sJN/zvFpPl8hiNTsa2siTyUxkRMJasclVI+rM
	 eBNwOude/Ewew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TH-0QUu;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 06/11] scripts: sphinx-pre-install: fix PDF build issues on Ubuntu
Date: Fri, 15 Aug 2025 13:36:22 +0200
Message-ID: <a888d353ac1eb0d558fda5482c6955d6c4a29f23.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

PDF output with current Debian-based distros require other
packages for it to work. The main one is pzdr.tfm. Without
that, \sphinxhyphen{} won't work, affecting multiple docs.

For CJK, tex-gyre is required.

Add the missing packages to the list.

After the change, all PDF files build on latest Ubuntu:

Ubuntu 25.04:
-------------
    PASSED: OS detection: Ubuntu 25.04
    SKIPPED (Sphinx Sphinx 8.1.3): System packages
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 3:28, return code: 0
    PASSED: Build PDF documentation: Build time: 11:08, return code: 0

  PDF docs:
  ---------
      PASSED: dev-tools: pdf/dev-tools.pdf
      PASSED: tools: pdf/tools.pdf
      PASSED: filesystems: pdf/filesystems.pdf
      PASSED: w1: pdf/w1.pdf
      PASSED: maintainer: pdf/maintainer.pdf
      PASSED: process: pdf/process.pdf
      PASSED: isdn: pdf/isdn.pdf
      PASSED: fault-injection: pdf/fault-injection.pdf
      PASSED: iio: pdf/iio.pdf
      PASSED: scheduler: pdf/scheduler.pdf
      PASSED: staging: pdf/staging.pdf
      PASSED: fpga: pdf/fpga.pdf
      PASSED: power: pdf/power.pdf
      PASSED: leds: pdf/leds.pdf
      PASSED: edac: pdf/edac.pdf
      PASSED: PCI: pdf/PCI.pdf
      PASSED: firmware-guide: pdf/firmware-guide.pdf
      PASSED: cpu-freq: pdf/cpu-freq.pdf
      PASSED: mhi: pdf/mhi.pdf
      PASSED: wmi: pdf/wmi.pdf
      PASSED: timers: pdf/timers.pdf
      PASSED: accel: pdf/accel.pdf
      PASSED: hid: pdf/hid.pdf
      PASSED: userspace-api: pdf/userspace-api.pdf
      PASSED: spi: pdf/spi.pdf
      PASSED: networking: pdf/networking.pdf
      PASSED: virt: pdf/virt.pdf
      PASSED: nvme: pdf/nvme.pdf
      PASSED: translations: pdf/translations.pdf
      PASSED: input: pdf/input.pdf
      PASSED: tee: pdf/tee.pdf
      PASSED: doc-guide: pdf/doc-guide.pdf
      PASSED: cdrom: pdf/cdrom.pdf
      PASSED: gpu: pdf/gpu.pdf
      PASSED: i2c: pdf/i2c.pdf
      PASSED: RCU: pdf/RCU.pdf
      PASSED: watchdog: pdf/watchdog.pdf
      PASSED: usb: pdf/usb.pdf
      PASSED: rust: pdf/rust.pdf
      PASSED: crypto: pdf/crypto.pdf
      PASSED: kbuild: pdf/kbuild.pdf
      PASSED: livepatch: pdf/livepatch.pdf
      PASSED: mm: pdf/mm.pdf
      PASSED: locking: pdf/locking.pdf
      PASSED: infiniband: pdf/infiniband.pdf
      PASSED: driver-api: pdf/driver-api.pdf
      PASSED: bpf: pdf/bpf.pdf
      PASSED: devicetree: pdf/devicetree.pdf
      PASSED: block: pdf/block.pdf
      PASSED: target: pdf/target.pdf
      PASSED: arch: pdf/arch.pdf
      PASSED: pcmcia: pdf/pcmcia.pdf
      PASSED: scsi: pdf/scsi.pdf
      PASSED: netlabel: pdf/netlabel.pdf
      PASSED: sound: pdf/sound.pdf
      PASSED: security: pdf/security.pdf
      PASSED: accounting: pdf/accounting.pdf
      PASSED: admin-guide: pdf/admin-guide.pdf
      PASSED: core-api: pdf/core-api.pdf
      PASSED: fb: pdf/fb.pdf
      PASSED: peci: pdf/peci.pdf
      PASSED: trace: pdf/trace.pdf
      PASSED: misc-devices: pdf/misc-devices.pdf
      PASSED: kernel-hacking: pdf/kernel-hacking.pdf
      PASSED: hwmon: pdf/hwmon.pdf

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b8474848df4e..b24a6f91ec0a 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -764,9 +764,6 @@ class SphinxDependencyChecker(MissingCheckers):
 
         if self.pdf:
             pdf_pkgs = {
-                "texlive-lang-chinese": [
-                    "/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty",
-                ],
                 "fonts-dejavu": [
                     "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
                 ],
@@ -775,6 +772,15 @@ class SphinxDependencyChecker(MissingCheckers):
                     "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
                     "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc",
                 ],
+                "tex-gyre": [
+                    "/usr/share/texmf/tex/latex/tex-gyre/tgtermes.sty"
+                ],
+                "texlive-fonts-recommended": [
+                    "/usr/share/texlive/texmf-dist/fonts/tfm/adobe/zapfding/pzdr.tfm",
+                ],
+                "texlive-lang-chinese": [
+                    "/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty",
+                ],
             }
 
             for package, files in pdf_pkgs.items():
-- 
2.50.1


