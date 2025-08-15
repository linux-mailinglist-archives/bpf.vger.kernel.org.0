Return-Path: <bpf+bounces-65765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC43B27F56
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DE41BC72B8
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30131301023;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ5MDXz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED528852D;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=cKv5k4TDb6gPgJe0ca/UU2msDn06cwOc/UrzdCiovuXF+wdOZBFaAJqZgc8m3gY/I1zgtaNiqqTfFyXuE9Vr3n+mGpMfqp9roNhSrUx/KWpgqRsi23ct+lfCRzDk+V+aA+iHqbJIF2IWENjmV8mRsQApDr4CKD09ScNVvb3NQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=41pClSqrGKyS+WUV3sXkeu12bzUgmg2ZeJUiAXxatDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1O3krRxVIOb1f6sP9tnvsPp146/dvLpvNygOQbww1hG6AMN4HS6qhOlyIIcdMucIiu5yOlYAOHs23itSAb3IpCPRcjA+SclXj3GmhhRKkcZWarWTtDO6U6v/CBcaYYBTD2Usz1cM8xeT6cETBz5B4EkjFLbitFtUIq85qDjffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ5MDXz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F008DC4AF09;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=41pClSqrGKyS+WUV3sXkeu12bzUgmg2ZeJUiAXxatDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQ5MDXz2tJyeUjch/T6OPRGT4o34nT48A42+kY36KmVHeLiGieCK31KQafsAXm/DD
	 wWHE+zJ/RjPQwg1qzn5HYcrtfRg9LxETAJswKLIf16l2CpjgDgMWzZgAmCtJJOXy0J
	 hY3qX81ARZ1apcHhOj+8co/3kUZEau+UNueZyOa9ltlBrh712aHFyR19aJAAN9EICZ
	 Hm0oX98GXiR7qSG7PCO3DqMvLjZVbAoT/elL00F2AxC5pwbPc/SutnhdlRtok6l2m4
	 H+k6N3JEt0dlitmv2xitt6abN2RDAsXaTgoexWFTE3DZT+iYB4Iqdaqf7Cq47Stno2
	 YAdrYgx+Jm7jQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TL-0XzB;
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH 07/11] scripts: sphinx-pre-install: add missing gentoo pdf dependencies
Date: Fri, 15 Aug 2025 13:36:23 +0200
Message-ID: <3772eb51d1af3653dcd05b4d31cca8e52bad974b.1755256868.git.mchehab+huawei@kernel.org>
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

There are two packages that are required to build PDF at gentoo:

	dev-texlive/texlive-latexextra
	media-fonts/lm

Place latex_dependencies on a list to make it easier to maintain
and add the missing ones.

With that, most PDF documents now build on Gentoo:

Gentoo Base System release 2.17:
--------------------------------
    PASSED: OS detection: Gentoo Base System release 2.17
    SKIPPED (Sphinx Sphinx 8.2.3): System packages
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 5:28, return code: 0
    PARTIAL: Build PDF documentation: Test failed (Build time: 9:19, return code: 2)

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
      FAILED: userspace-api: Build failed (FAILED)
      PASSED: spi: pdf/spi.pdf
      PASSED: networking: pdf/networking.pdf
      PASSED: virt: pdf/virt.pdf
      PASSED: nvme: pdf/nvme.pdf
      FAILED: translations: Build failed (FAILED)
      PASSED: input: pdf/input.pdf
      PASSED: tee: pdf/tee.pdf
      PASSED: doc-guide: pdf/doc-guide.pdf
      PASSED: cdrom: pdf/cdrom.pdf
      FAILED: gpu: Build failed (FAILED)
      FAILED: i2c: Build failed (FAILED)
      FAILED: RCU: Build failed (FAILED)
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
      FAILED: arch: Build failed (FAILED)
      PASSED: pcmcia: pdf/pcmcia.pdf
      PASSED: scsi: pdf/scsi.pdf
      PASSED: netlabel: pdf/netlabel.pdf
      PASSED: sound: pdf/sound.pdf
      PASSED: security: pdf/security.pdf
      PASSED: accounting: pdf/accounting.pdf
      PASSED: admin-guide: pdf/admin-guide.pdf
      FAILED: core-api: Build failed (FAILED)
      PASSED: fb: pdf/fb.pdf
      PASSED: peci: pdf/peci.pdf
      PASSED: trace: pdf/trace.pdf
      PASSED: misc-devices: pdf/misc-devices.pdf
      PASSED: kernel-hacking: pdf/kernel-hacking.pdf
      PASSED: hwmon: pdf/hwmon.pdf

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b24a6f91ec0a..f987abfec802 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -1058,12 +1058,19 @@ class SphinxDependencyChecker(MissingCheckers):
         """
         Provide package installation hints for Gentoo.
         """
+        texlive_deps = [
+            "dev-texlive/texlive-latexextra",
+            "dev-texlive/texlive-xetex",
+            "media-fonts/dejavu",
+            "media-fonts/lm",
+        ]
+
         progs = {
             "convert":       "media-gfx/imagemagick",
             "dot":           "media-gfx/graphviz",
             "rsvg-convert":  "gnome-base/librsvg",
             "virtualenv":    "dev-python/virtualenv",
-            "xelatex":       "dev-texlive/texlive-xetex media-fonts/dejavu",
+            "xelatex":       " ".join(texlive_deps),
             "yaml":          "dev-python/pyyaml",
             "python-sphinx": "dev-python/sphinx",
         }
-- 
2.50.1


