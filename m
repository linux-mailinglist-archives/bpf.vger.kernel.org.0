Return-Path: <bpf+bounces-50033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C53A22149
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFAA1884DEA
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFBF1DF960;
	Wed, 29 Jan 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCc7PtcT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0F1DEFDD;
	Wed, 29 Jan 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167000; cv=none; b=BVwyomfgfs0Kkv3Qsyk/sKFexy6pJNLdfk49ZmLvqlpYvfOTYXFtD70249xkrfxwxAqZbjw63ZPlZMdXkjU0HZkH5/LJNKK6ie5mLuOKN363QSWuBO4sZMxYlj+T3asmvBm4cjmDfzokWUOdhPAebbUwxz3b9MoCc3EytNs5k1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167000; c=relaxed/simple;
	bh=wrF7qMccEyKNan3FB8Tt10O3BrSPD0Q4GiM29XidLhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssLyoRJzI6n8rVBm8T6YxkhXMQQHqru5qM1VoIbk1YzEMzYMU2unowA9eKU6q3sA+H0X/JiM9kimuZEuBzz/Os1GqklE1C0Z0jWjasVK611oDx9VEE/7ndT0EK2xByyY1sBNgHipAxiP5xyy/GzMlNOoL0QYnkRmif8ePcS4qdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCc7PtcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D64C4CEDF;
	Wed, 29 Jan 2025 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738166999;
	bh=wrF7qMccEyKNan3FB8Tt10O3BrSPD0Q4GiM29XidLhM=;
	h=From:To:Cc:Subject:Date:From;
	b=NCc7PtcTasnn+/Ta9YKRefURozpAQ4hFxrEPwv4ko4vmtQBT6SEP/sOVk4mELGsRv
	 xm2LN1dltCLvSrTHkE8BzKDFcYYTjMZjS5x4xivc4foKeM58dIkgi6a8aFbq+FOHw2
	 SjWh7e1T/gxlqFEd/+T2U2POwsTpESGh2LmTKYAKwoFVNzfj2u7v2ZL7IB9agF/hv8
	 wBKYE0cgXb8eIcylKUcPSQBnTOgTQIbln9tSAkZ604PgaZS8JASqgNxjsSKOIOOirb
	 PBKgeKgUNkjG8yKlo50UXP9tY1dTetqVDm+ZWlHesMlwvv7CrvGXjRxFSYqX/meNLC
	 5+lHInqObjqNA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdAdZ-00000004PEH-1WJn;
	Wed, 29 Jan 2025 17:09:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	workflows@vger.kernel.org
Subject: [RFC 0/6] Raise the bar with regards to Python and Sphinx requirements
Date: Wed, 29 Jan 2025 17:09:31 +0100
Message-ID: <cover.1738166451.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This series comes after https://lore.kernel.org/linux-doc/87a5b96296.fsf@trenco.lwn.net/T/#t
It  increases the minimal requirements for Sphinx and Python.

Sphinx release dates:

	Release 2.4.0 (released Feb 09, 2020)
	Release 2.4.4 (released Mar 05, 2020) (current minimal requirement)
	Release 3.4.0 (released Dec 20, 2020)
	Release 3.4.3 (released Jan 08, 2021)

	(https://www.sphinx-doc.org/en/master/changes/index.html)

In terms of Python, we're currently at 3.5:

	Python	Release date 
	3.5	2015-09-13    (current minimal requirement)
	3.6	2016-12-23
	3.7 	2018-06-27
	3.8 	2019-10-14
	3.9 	2020-10-05
	3.10	2021-10-04

	(according with https://en.wikipedia.org/w/index.php?title=History_of_Python)

The new minimal requirements are now:
	- Sphinx 3.4.3;
	- Python 3.9

The new Sphinx minimal requirement allows dropping all backward-compatible code
we have at kernel-doc and at Sphinx extensions.

The new Python minimal requirement matches the current required level for
all scripts but one (*). The one that doesn't match is at tools/net/sunrpc/xdrgen.

Those matches a 4-years old toolchain, which sounds a reasonable period
of time, as Python/Sphinx aren't required for the Kernel build.

Mauro Carvalho Chehab (6):
  scripts/get_abi.py: make it backward-compatible with Python 3.6
  docs: extensions: don't use utf-8 syntax for descriptions
  docs: automarkup: drop legacy support
  scripts/kernel-doc: drop Sphinx version check
  docs: changes: update Sphinx minimal version to 3.4.3
  doc: changes: update Python minimal version

 Documentation/conf.py                       |   2 +-
 Documentation/process/changes.rst           |   4 +-
 Documentation/sphinx/automarkup.py          |  32 ++---
 Documentation/sphinx/cdomain.py             |   7 +-
 Documentation/sphinx/kernel_abi.py          |   6 +-
 Documentation/sphinx/kernel_feat.py         |   4 +-
 Documentation/sphinx/kernel_include.py      |   4 +-
 Documentation/sphinx/kerneldoc.py           |   5 -
 Documentation/sphinx/kfigure.py             |  10 +-
 Documentation/sphinx/load_config.py         |   2 +-
 Documentation/sphinx/maintainers_include.py |   4 +-
 Documentation/sphinx/rstFlatTable.py        |  10 +-
 scripts/get_abi.py                          |  16 ++-
 scripts/kernel-doc                          | 129 +++-----------------
 14 files changed, 58 insertions(+), 177 deletions(-)

-- 
2.48.1



