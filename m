Return-Path: <bpf+bounces-50949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32600A2E8F9
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0365D188B0F7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B351DE3CA;
	Mon, 10 Feb 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX0+CSSl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2361C68A6;
	Mon, 10 Feb 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182704; cv=none; b=j+5Ec3I5e8ZwSPl10H8WO6Wx5VGnGA+98uTJi6GYASy6NykD0guxHr/R3WynguYN5wKTtDAgQQoXdQozOrqdy2pRFPayuC25Yv8nqG9c6u7QjtYq6aVCB7BpEQrR350gl6rRNEQNDjULkzwjZ0e6RNgESEFhlSKHS7+b5BLl+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182704; c=relaxed/simple;
	bh=p8iRm7Gznn3ekKIRR91V/psR21ij9bK+0II7DymWAjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSgn0I/gDmkRJrmgJoypVHV/o6sYc3/UEzm5QukM40winVb7dBBdDIOMlNQ8BZXGSc/XB7qEnpHRry4j/fcBaRxsC3whfdJuN4cV9ho+2CXhhzcOrJ6/BjyHp3TiN2Od0CCK44E83hOTtGXwDG4g6m/N/uAL+lzYTXbIP8fwho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX0+CSSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D2C4CEE6;
	Mon, 10 Feb 2025 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182703;
	bh=p8iRm7Gznn3ekKIRR91V/psR21ij9bK+0II7DymWAjA=;
	h=From:To:Cc:Subject:Date:From;
	b=PX0+CSSljZXtmDbUPsW3q/1UEAZkcJHQHMj/eR0Q8uSPrNmrv7jqsd3H+YWo1xOM/
	 HjMrHdx6LlY4VekopfJmqAvseecf+sebvVrDYeBP2E4GKMMrmkGAF7v22e90DTf2Ge
	 mjxsRdCf7qv3lINGQIUrTR/CKUR1x2WI5IgNnSnIRO7tiHp3FFc+3cqvsj/9hsWnKh
	 QUvK4DWNq98U6G9Jmn/ZLIwMSS34I6YncKIZUQdrGDo3GiokB90neYSGG7qvgPEeX+
	 u8zr8PFfVeA+4pAnIe0oPCCKpjgmBbYQ3zyMgD9kNY5qkMBCxcJD7jQPVUsrPO+vlG
	 qr78nANSqX06Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thQrt-00000006Ci9-3Zgs;
	Mon, 10 Feb 2025 11:18:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Chao Yu <mchehab+huawei@kernel.org>,
	Jaegeuk Kim <mchehab+huawei@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	bpf@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 00/27] Improve ABI documentation generation
Date: Mon, 10 Feb 2025 11:17:49 +0100
Message-ID: <cover.1739182025.git.mchehab+huawei@kernel.org>
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

This series replace get_abi.pl with a Python version.

I originally started it due to some issues I noticed when searching for
ABI symbols. While I could just go ahead and fix the already existing
script, I noticed that the script maintainance didn't have much care over
all those years, probably because it is easier to find Python programmers
those days.

Also, the code is complex and was not using modules or classes and
were using lots of global variables.

So, I decided to rewrite it in Python. I started with a manual conversion
for each function. Yet, to avoid future maintainership issues, I opted to
divide the main code on three classes, each on a sepaparate file.

Just like the original RFC, I opted to keep the Sphinx kernel-abi module
on three different phases:

- call get_abi.py as an exec file;
- import AbiParser on a minimal integration scenario;
- cleanup the code to avoid needing to parse line numbers from the text.

This way, if something goes wrong, it would be easier to just revert any
offending patches, It also provides a better rationale about what each
logical change is doing.

The initial patches on this series do some preparation work and
cleans some ABI symbol bugs that lack ":" delimiter.

I opted to place on this series the Sphinx and Python version updates.

I still have ~10 patches here with additional cleanups, from the original
series I sent as RFC but let's get the main changes merged first.

Mauro Carvalho Chehab (27):
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
  scripts/lib/abi/abi_parser.py: optimize parse_abi() function
  scripts/lib/abi/abi_parser.py: use an interactor for ReST output
  docs: sphinx/kernel_abi: use AbiParser directly
  docs: sphinx/kernel_abi: reduce buffer usage for ABI messages
  docs: sphinx/kernel_abi: properly split lines
  scripts/get_abi.pl: Add filtering capabilities to rest output
  scripts/get_abi.pl: add support to parse ABI README file
  docs: sphinx/kernel_abi: parse ABI files only once
  docs: admin-guide/abi: split files from symbols
  docs: sphinx/automarkup: add cross-references for ABI
  docs: sphinx/kernel_abi: avoid warnings during Sphinx module init
  scripts/lib/abi/abi_parser.py: Rename title name for ABI files
  scripts/lib/abi/abi_parser.py: make it backward-compatible with Python
    3.6
  scripts/get_abi.py: add support for undefined ABIs
  scripts/get_abi.pl: drop now obsoleted script

 Documentation/ABI/removed/sysfs-class-rfkill  |    2 +-
 Documentation/ABI/stable/sysfs-class-rfkill   |   12 +-
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
 Documentation/sphinx/automarkup.py            |   47 +
 Documentation/sphinx/kernel_abi.py            |  162 ++-
 Documentation/sphinx/kerneldoc.py             |   14 +-
 Documentation/sphinx/kernellog.py             |   22 -
 Documentation/sphinx/kfigure.py               |   81 +-
 scripts/documentation-file-ref-check          |    2 +-
 scripts/get_abi.pl                            | 1103 -----------------
 scripts/get_abi.py                            |  214 ++++
 scripts/lib/abi/abi_parser.py                 |  628 ++++++++++
 scripts/lib/abi/abi_regex.py                  |  234 ++++
 scripts/lib/abi/helpers.py                    |   38 +
 scripts/lib/abi/system_symbols.py             |  378 ++++++
 29 files changed, 1830 insertions(+), 1322 deletions(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete-files.rst
 create mode 100644 Documentation/admin-guide/abi-readme-file.rst
 create mode 100644 Documentation/admin-guide/abi-removed-files.rst
 create mode 100644 Documentation/admin-guide/abi-stable-files.rst
 create mode 100644 Documentation/admin-guide/abi-testing-files.rst
 delete mode 100644 Documentation/sphinx/kernellog.py
 delete mode 100755 scripts/get_abi.pl
 create mode 100755 scripts/get_abi.py
 create mode 100644 scripts/lib/abi/abi_parser.py
 create mode 100644 scripts/lib/abi/abi_regex.py
 create mode 100644 scripts/lib/abi/helpers.py
 create mode 100644 scripts/lib/abi/system_symbols.py

-- 
2.48.1



