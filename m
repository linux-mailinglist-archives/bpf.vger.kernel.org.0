Return-Path: <bpf+bounces-66153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECBB2F171
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE8C3AE084
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880102ECD3F;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bES3ep9F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FF2EB86D;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=Mr7uTKEYOrvzCS5OHhXT+cyDeZo8aOzq2HxoqYGb1Cb8k1bi5k3nUfSU+QkrQEmVWyQRVj/ea7q60WfmsLiHQlek7SICrO3VIrZdC0wCcY0iJG9+fc4i/E6NqMbDqR0NYDG6VfpM8cKgxknx8QiF6eCKrpKli9By1Wrze7oLxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=+/6Ro+Dnlq3YRqR0pERxWJ2pVEtF9E0U8Tw5zszBXiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmiNaVb4t8aJpwqE0kAVNl4kwB8L3suZId5iK2x0sXAHLaadMdUVg+6LoWt4ySH3ztYilwRb7JF+vinUehMkvwYZ97wj52kPRqFJzGEdgZb38kMhThGHUqfTPg2qC+2g8nif4S+Aihg6FessTOBqzzocUteQcjM7AIm188XbcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bES3ep9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624EC2BCB0;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=+/6Ro+Dnlq3YRqR0pERxWJ2pVEtF9E0U8Tw5zszBXiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bES3ep9FYW91fF8p09vin8yjcaW8j7l/TMDDOwbBWw1s0mHeLJJtfVcP5Aequutfz
	 bIgtVKPPBJlofG6piPB3dlN6F/ozQ0k7g/n+Bk+fXHPyV6MQrx0yGnWJu55kIk1Zsw
	 CAFrlzdWeFWjXD4yVace8qT7Eit4ua0ZDmEl9rNTfzMIyudIpy/1GAQ8GxmfgcvohS
	 kcMQMUQ40eAcOrTB5/box3+oyiJAlDswgpp5c70hG0Qa9r3dx8/hdoNrSRieYy9Jpj
	 fwST0vnJyD6YEUG1iaVezTUOZoMHC8cqhHDa1JjzmZXciBicmzY7WgnuUNC3PG/v2T
	 XucUL8or9N7Mw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgn-3eQQ;
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 12/14] scripts: sphinx-pre-install: fix pdf dependencies for Mageia 9
Date: Thu, 21 Aug 2025 10:16:48 +0200
Message-ID: <bd6e03c79b890ad0168493cdb4cdaf610bbc8c45.1755763127.git.mchehab+huawei@kernel.org>
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

On Mageia 9, two packages are missing. Add them.

With that, all PDF packages now build:

Mageia 9:
---------
    PASSED: OS detection: Mageia 9
    PASSED: System packages: Packages installed
    PASSED: Sphinx on venv: Sphinx Sphinx 8.1.3
    PASSED: Sphinx package: Sphinx Sphinx 6.1.3
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 5:17, return code: 0
    PASSED: Build PDF documentation: Build time: 14:28, return code: 0

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

Summary
=======
  PASSED - Mageia 9 (7 tests)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 224db3af17db..758a84ae6347 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -979,6 +979,8 @@ class SphinxDependencyChecker(MissingCheckers):
 
         tex_pkgs = [
             "texlive-fontsextra",
+            "texlive-fonts-asian",
+            "fonts-ttf-dejavu",
         ]
 
         if re.search(r"OpenMandriva", self.system_release):
-- 
2.50.1


