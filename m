Return-Path: <bpf+bounces-65763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B8B27F5B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3745E8C91
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B611301004;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/eoI7h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5928850C;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=jyDt/TDC0EIF91KcWT7JwdHp/E/kD2jMdOcaOeVDEo+4S/wT1bEkHhcH9U+Cws9EMlDAu+A1nPQ8C5mL/TfQtL2olvO1o7ots8aido0ZDTUWxK16f4SdF8ytZ84Crq3hotcfXfx7vmj2hFtxYsUfpZH3q9ngLTK0dFcHeeSv1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=+/6Ro+Dnlq3YRqR0pERxWJ2pVEtF9E0U8Tw5zszBXiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6jo03oD2O83igjeBO5VZ6icHA6iulmJE4XlV87OPZZrhgyfWr2ngzP6QT+QdqFiJj/jcuKA+TPvlW3KMbc/ZxUhpTdML0vWphFUwecigg2FOSV4ufhXbj9h++TWfG3iLSdf+LP5jDgu0cb2vAcmTuRIlaLpk1th4JEHknJ2xsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/eoI7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF2FC116C6;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=+/6Ro+Dnlq3YRqR0pERxWJ2pVEtF9E0U8Tw5zszBXiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ/eoI7hgGjAOCA/3mIAwwuH9K9EOlHvwUhndcA3cDo9yKMesrquaJPB6iKLYS8IS
	 D0B/eV+Wgbk996r8FUUaAYpyQafzvqRf2/MRw1j7KJbX9eRI8M0ioSIrK9uXB1XTT8
	 mmkR6xvkpgM2fdoxhFZfvZVVy/tGYYQJMwFZuqdyWgiy6YmsrqT8ooSdjKKr5Z04CL
	 wonNQmhgc1Q+CJtTCkhvnc/bJhPU0nA+BQuGOOc8VDAhFT/EDIBwqA78xFCQVX8ZMi
	 ixhbAcyG5zTEq5XiscEgV9fQNlIrlr2dXUqxFwGTa2O/Mduu9wnwbN6F47U4HwevyN
	 biK2iIIeD2p4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TX-0sw8;
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
Subject: [PATCH 10/11] scripts: sphinx-pre-install: fix pdf dependencies for Mageia 9
Date: Fri, 15 Aug 2025 13:36:26 +0200
Message-ID: <daaaf4633a1cf465c5f904b7716fd445d49a3f6a.1755256868.git.mchehab+huawei@kernel.org>
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


