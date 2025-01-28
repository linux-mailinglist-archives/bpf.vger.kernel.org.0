Return-Path: <bpf+bounces-49920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242BA2024F
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 01:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B277A2253
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528B19E7F7;
	Tue, 28 Jan 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVMdUUsP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623C33CFC;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022797; cv=none; b=czQx09cJQyQSZBP1BGgcNSPDnT/33NLH458yGgYegrxzEkMlKIWHpoEiTAZ81pp0GgYXFyfn2bx+1M2nBKPqio9+O9McP1ALYdDeIrCoR2S9pBV33Hu9yjghdInZOAMNq5+aqlc8LYgOqjeumxcERC58NaqefZZ9Ri/y5OdRAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022797; c=relaxed/simple;
	bh=x0APBPBQWrivChaCg4k0Jly7N3L+drRwEE2afrYm3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG7vhzPeB2x/+yDwbNhJFIvm2jB/JWVTv+koS8hxTDg5Z8vqsXUMFlVaWKj0c1vnGe3Ib5tI8WY+a0QWCU7JGNxXNd2ZOTeL6JU+kenOZTLGkalPyzF3gOL/8SADA4mtZH/PNqc1Qu9OOsNupeiDlZQVhQmePYu7Rk4kIqicx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVMdUUsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0CDC4CEE7;
	Tue, 28 Jan 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022796;
	bh=x0APBPBQWrivChaCg4k0Jly7N3L+drRwEE2afrYm3Ko=;
	h=From:To:Cc:Subject:Date:From;
	b=YVMdUUsPMxPbkAk4qEzxydaiheiKgPq0V/bec3NjHqtsuNI4LbgEBDEej9+LgNza+
	 ljIEnlJ8dOW66epiiZtLELOhM7CI9Xmfl04mwJsxOPi5DZqupGOzyLYI8OrEB0YMLK
	 2aabCdo/efDt+1ketrNTclboOiYMqtBF3chVGB2EMC4yfr4ULHJGHphSkN/9c0uXJr
	 2zeCibWgf8wkOz10yK0tDHg/2UyTNfnmjDli87oee4K3CFTkaD0PhvQA9VygWXf7kB
	 Qo1Ry12uzmRsVIoEnhnI2jD01cboTneK2GBz8V4u2Zk1oJeS56JxjuAeS7Lo5BEMUu
	 9jWWaNQP5ViKg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7h-0000000DRKO-2KyQ;
	Tue, 28 Jan 2025 01:06:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-hardening@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC v2 00/38] Improve ABI documentation generation
Date: Tue, 28 Jan 2025 01:05:49 +0100
Message-ID: <cover.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon/Greg,

That's the second version of my RFC patches meant to modenize the ABI
parser that I wrote in Perl.

I originally started it due to some issues I noticed when searching for
ABI symbols. While I could just go ahead and fix the already existing
script, I noticed that the script maintainance didn't have much care over
all those years, probably because it is easier to find Python programmers
those days.

Also, the code is complex and was not using modules or classes and
were using lots of global variables.

So, I decided to rewrite it in Python. I started with a manual conversion
for each function. Yet, to avoid future maintainership issues, I opted to
divide the code on three classes. One class for the ABI parser, another
one for regex conversion (used when checking symbols from local hardware,
and an extra class for undefined symbols check.

I opted to change the Sphinx integration gradually using different
patch sets on 4 phases:

1. minimal integration: just execute the new script on a similar way as
   the perl one;
2. the kernel_abi module was changed to import the ABI parser class,
   using it directly;
3. the logic at kernel_abi were rewritten to better integrate. As a bonus,
   Sphinx now imports ReST data symbol by symbol. That solves one of
   the issues I was discomfortable with the original approach: when lots
   of data is sent to Sphinx parser, it stops in the middle of processing.
   This was addressed in the past on a hacky way, but it could cause
   problems in the future as the number of symbols increase;
4. the ABI parser part is now called either by automarkup and kernel_abi.
   This allowed automarkup to solve ABI symbols.

Together with this series, I added some patches fixing issues and warnings
when generating documentation.

Some notes about this new RFC:

- despite being able to generate documentation cross-references with
  auto-markup, the documentation build timt didn't increase on my machine
  (it was actually 5 seconds faster);
- I rewrote some algorithms at the undefined symbol detection code. With
  that, it is now a lot faster than the previous version, at least on my desktop
  (wich has 24 CPU threads). I didn't try it on a server yet;
- the undefined parser can optionally use multiple CPUs. This sounds
  fancier than it seems: Python (up to version 3.12) is really bad with
  multi-CPU support and doesn't have real multi-thread support. Python
  3.13 has now an optional way to address that (although I didn't test yet,
  as it requires Python manual compilation). When such feature becomes
  standard, maybe the undefined symbols detection will be faster.

Btw, I'm opting to send this as an RFC because I'd like to have more
people testing and checking it. In particular, the undefined ABI check
is complex, as it requires lots of tricks to reduce the run time from hours
to seconds.
  
On this series we have:

patches 1 to 11: several bug fixes addressing issues at ABI symbols;
patch 12: a fix for scripts/documentation-file-ref-check
patches 13-15: create new script with rest and search logic and 
  minimally integrate with kernel_abi Sphinx extension(phase 1);
patches 16-19: implement phase 2: class integration (phase 2);
patch 20: fix a bug at kernel_abi: the way it splits lines is buggy;
patches  21-24: rewrite kernel_abi logic to make it simpler and more
  robust;
patches 25-27: add cross-reference support at automarkup;
patches 28-36: several ABI cleanups to cope with the improvements;
patch 37: implement undefined command;
patch 38: get rid of the old Perl script.

To make it easier to review/apply, I may end breaking the next version
on a couple of different patchsets. Still it would be nice to have more
people testing it and providing some feedback.

---
RFC v2:
  - Dropped a patch touching the perl script;
  - Implemented phases 2-4 of the script's logic;
  - Added ABI cross-references via automarkup;
  - Added support for undefined logic;
  - Added more ABI and scripts' fixes;
  - Added undefined logic;
  - Added a patch to remove the old tool.

Mauro Carvalho Chehab (38):
  docs: power: video.rst: fix a footnote reference
  docs: media: ipu3: fix two footnote references
  docs: block: ublk.rst: remove a reference from a dropped text
  docs: sphinx: remove kernellog.py file
  docs: sphinx/kernel_abi: adjust coding style
  docs: admin-guide: abi: add SPDX tags to ABI files
  ABI: sysfs-class-rfkill: fix kernelversion tags
  ABI: sysfs-bus-coresight-*: fix kernelversion tags
  ABI: sysfs-driver-dma-idxd: fix date tags
  ABI: sysfs-fs-f2fs: fix date tags
  ABI: sysfs-power: fix a what tag
  scripts/documentation-file-ref-check: don't check perl/python scripts
  scripts/get_abi.py: add a Python tool to generate ReST output
  scripts/get_abi.py: add support for symbol search
  docs: use get_abi.py for ABI generation
  scripts/get_abi.py: optimize parse_abi() function
  scripts/get_abi.py: use an interactor for ReST output
  docs: sphinx/kernel_abi: use AbiParser directly
  docs: sphinx/kernel_abi: reduce buffer usage for ABI messages
  docs: sphinx/kernel_abi: properly split lines
  scripts/get_abi.pl: Add filtering capabilities to rest output
  scripts/get_abi.pl: add support to parse ABI README file
  docs: sphinx/kernel_abi: parse ABI files only once
  docs: admin-guide/abi: split files from symbols
  docs: sphinx/automarkup: add cross-references for ABI
  docs: sphinx/kernel_abi: avoid warnings during Sphinx module init
  scripts/get_abi.py: Rename title name for ABI files
  docs: media: Allow creating cross-references for RC ABI
  docs: thunderbolt: Allow creating cross-references for ABI
  docs: arm: asymmetric-32bit: Allow creating cross-references for ABI
  docs: arm: generic-counter: Allow creating cross-references for ABI
  docs: iio: Allow creating cross-references ABI
  docs: networking: Allow creating cross-references statistics ABI
  docs: submit-checklist: Allow creating cross-references for ABI README
  docs: translations: Allow creating cross-references for ABI README
  docs: ABI: drop two duplicate symbols
  scripts/get_abi.py: add support for undefined ABIs
  scripts/get_abi.pl: drop now obsoleted script

 Documentation/ABI/removed/sysfs-class-rfkill  |    2 +-
 Documentation/ABI/stable/sysfs-class-rfkill   |   12 +-
 .../ABI/stable/sysfs-devices-system-cpu       |   10 -
 .../ABI/stable/sysfs-driver-dma-idxd          |    4 +-
 .../testing/sysfs-bus-coresight-devices-cti   |   78 +-
 .../testing/sysfs-bus-coresight-devices-tpdm  |   52 +-
 Documentation/ABI/testing/sysfs-fs-f2fs       |    4 +-
 Documentation/ABI/testing/sysfs-power         |    2 +-
 .../admin-guide/abi-obsolete-files.rst        |    7 +
 Documentation/admin-guide/abi-obsolete.rst    |    6 +-
 Documentation/admin-guide/abi-readme-file.rst |    6 +
 .../admin-guide/abi-removed-files.rst         |    7 +
 Documentation/admin-guide/abi-removed.rst     |    6 +-
 .../admin-guide/abi-stable-files.rst          |    7 +
 Documentation/admin-guide/abi-stable.rst      |    6 +-
 .../admin-guide/abi-testing-files.rst         |    7 +
 Documentation/admin-guide/abi-testing.rst     |    6 +-
 Documentation/admin-guide/abi.rst             |   17 +
 Documentation/admin-guide/media/ipu3.rst      |   12 +-
 Documentation/admin-guide/thunderbolt.rst     |    2 +-
 Documentation/arch/arm64/asymmetric-32bit.rst |    2 +-
 Documentation/block/ublk.rst                  |    2 -
 Documentation/driver-api/generic-counter.rst  |    4 +-
 Documentation/driver-api/iio/core.rst         |    2 +-
 Documentation/iio/iio_devbuf.rst              |    2 +-
 Documentation/networking/statistics.rst       |    2 +-
 Documentation/power/video.rst                 |    2 +-
 Documentation/process/submit-checklist.rst    |    2 +-
 Documentation/sphinx/automarkup.py            |   56 +
 Documentation/sphinx/kernel_abi.py            |  162 +-
 Documentation/sphinx/kerneldoc.py             |   14 +-
 Documentation/sphinx/kernellog.py             |   22 -
 Documentation/sphinx/kfigure.py               |   81 +-
 .../it_IT/process/submit-checklist.rst        |    2 +-
 .../sp_SP/process/submit-checklist.rst        |    2 +-
 .../zh_CN/process/submit-checklist.rst        |    2 +-
 .../zh_TW/process/submit-checklist.rst        |    2 +-
 .../userspace-api/media/rc/rc-sysfs-nodes.rst |    2 +-
 scripts/documentation-file-ref-check          |    2 +-
 scripts/get_abi.pl                            | 1103 -------------
 scripts/get_abi.py                            | 1437 +++++++++++++++++
 41 files changed, 1804 insertions(+), 1354 deletions(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete-files.rst
 create mode 100644 Documentation/admin-guide/abi-readme-file.rst
 create mode 100644 Documentation/admin-guide/abi-removed-files.rst
 create mode 100644 Documentation/admin-guide/abi-stable-files.rst
 create mode 100644 Documentation/admin-guide/abi-testing-files.rst
 delete mode 100644 Documentation/sphinx/kernellog.py
 delete mode 100755 scripts/get_abi.pl
 create mode 100755 scripts/get_abi.py

-- 
2.48.1



