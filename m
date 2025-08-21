Return-Path: <bpf+bounces-66155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922AFB2F185
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596CA1BC257A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4D2ECE98;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbcPYVYk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F172EB87A;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=c0nquIv2ufpgujtO2jo5D0/S17Tur9iUP0o1rVRFXApyCB2v8HMRBM4AX/b0JgEKASmELZDvBTu3Q34F4MGN+CqCuRW7ht/cBIirnlDiKY/hwsevobwWPq+xMLOaLk7XYtXlNJEvUtZuJxW3PJ1vX/lOh8EfYer2L3QNzmDFEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=U/g86Ig1pMFruBqlvyzjZIHjO9UsMDLq3GNFDgoQFww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjuKvPhN7LMJKrv4+ibRZpeCET6OJv14nummYVCpQjRXLMwDyCt0Erv8Y+VNPdryM2imVzB4KGfqIT6E87FN5SQv5FPnfo8SpPOZ9Yn+qyvbJ2cBCQShLzLV1fuItRpbkO1NDAZZn3o8/KZ39fzMBCHN8ak6W/bWTjWW5SxgNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbcPYVYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEFFC19425;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=U/g86Ig1pMFruBqlvyzjZIHjO9UsMDLq3GNFDgoQFww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbcPYVYk/bgbxrIyOb7d4rAk1nc+g7NuhoqJ9mZH6AktqL52ZWq04L/TltiU6QefM
	 v/2Gq6yzCNknp77Fgli9s0mAU75edAZ5zRr07CUbMUJDU0iT0GSQ+yvpIa7Kx/aOqW
	 +FgEXnTeju3e4/CRVuFL4aT7GZwBU0ZFmGDluaCGvFIwIkGu39NiH7F2wy7zTitNmr
	 Ynl+hN2c5TB7nvQJOixdAEg2if3xuEQwwp/R+FWKQKdkQ93tkeKWsfZ2A1g2FONIxE
	 biwqHy8zXJySrlP5K2n88+bUSxaoWlez/QkKMNrpL8OMR+qhXDVZh/WCkuAxS9jpGc
	 0UIqj7SEQyDjA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgX-3C09;
	Thu, 21 Aug 2025 10:17:02 +0200
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
Subject: [PATCH v2 08/14] scripts: sphinx-pre-install: fix PDF build issues on Ubuntu
Date: Thu, 21 Aug 2025 10:16:44 +0200
Message-ID: <b5e2e0df68b377b148fdbdd721f6c1cbefe6f861.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
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


