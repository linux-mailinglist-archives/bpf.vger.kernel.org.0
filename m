Return-Path: <bpf+bounces-51106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C35A30353
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C223A58B0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA01E7C3F;
	Tue, 11 Feb 2025 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TImFix7B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1C26BD8B;
	Tue, 11 Feb 2025 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254775; cv=none; b=Qj+Xv55rpUsXgrlmMot8+Z4ZqUJtRSub0Rqp/LbvOB+yQ7EImAc/p0FEaZl/fWTg1cbUMcX4lIA8Z35FYNksgRyeqhfgWwQC0V3PBYj30UbX9TjaTU85Bh7Pj6KOXnl4I11nmH7fzAPJoFTKKRGhBrOP6dRz9j9h6/vTH6/TA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254775; c=relaxed/simple;
	bh=9gUKRbIH8PW7un4AbT4YS+PykDeaoCnYPWliu3YmUt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUIlZq765QtH23qTrgI7ks8tZ4kE7hZBPcET7YXFynFlEgN1BcZVSG1WYZ0Wk0PxprRw76pfBs48ph+isZk4VlmmPYm/eQfhLjKJJJ++soohK7i8uldS8xRmBybAPdSxKdb79ImOG8FSSZAAW9RmX83RT9NutDcx6EAEIzB3g7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TImFix7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CACCC4CEDD;
	Tue, 11 Feb 2025 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254774;
	bh=9gUKRbIH8PW7un4AbT4YS+PykDeaoCnYPWliu3YmUt4=;
	h=From:To:Cc:Subject:Date:From;
	b=TImFix7B7nuVRUHCPpzaAxs6MfItH/mdJHmyl2+Cw3KmsJy7IBTGnrgMDmTfWMPFw
	 8a3BjgdWSUwRFoSooUum4L+BfpifJyOxWBotIJNbKvpdgcdBFqG59UrQemNfsqjxYY
	 jMdk6iihzNFqf9e3GxakkOkwb/rEsPfi7O4N7pgDYahde+8rpvchAHvV04onrklxsR
	 PPVY5KHbN7hKtXZPKsjosgJe2+Kmju4/XJd7UkcdOK/Etmtqi8lXNHNczYI6jCTOnd
	 uqnehqkQUrtjyl5rCvfVqSv9YMqB2lk1NOJpW1u+vRtQgFR9EaYU1QQ+veOF48WQnE
	 SfKwqnTh778Fw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjcK-00000008Y6S-1mT1;
	Tue, 11 Feb 2025 07:19:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	workflows@vger.kernel.org
Subject: [PATCH 0/4] Raise the bar with regards to Python and Sphinx requirements
Date: Tue, 11 Feb 2025 07:19:00 +0100
Message-ID: <cover.1739254187.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This series  increases the minimal requirements for Sphinx and Python, and
drop some backward-compatible code from Sphinx extension.

Looking at Sphinx release dates:

	Release 2.4.0 (released Feb 09, 2020)
	Release 2.4.4 (released Mar 05, 2020) (current minimal requirement)
	Release 3.4.0 (released Dec 20, 2020)
	Release 3.4.3 (released Jan 08, 2021)

	(https://www.sphinx-doc.org/en/master/changes/index.html)

And Python release dates, we have:

	Python	Release date 
	3.5	2015-09-13    (current minimal requirement)
	3.6	2016-12-23
	3.7 	2018-06-27
	3.8 	2019-10-14
	3.9 	2020-10-05
	3.10	2021-10-04

	(according with https://en.wikipedia.org/w/index.php?title=History_of_Python)

The new minimal requirements are now compatible with the toolset available on Jan, 2021,
e.g.:
	- Sphinx 3.4.3;
	- Python 3.9

The new Sphinx minimal requirement allows dropping all backward-compatible code
we have at kernel-doc and at Sphinx extensions.

The new Python minimal requirement also matches the current required level for
almost  all scripts (*).

Those matches a 4-years old toolchain, which sounds a reasonable period
of time, as Python/Sphinx aren't required for the Kernel build.

(*) Except for a couple scripts inside tools that require python 3.10:

    $ vermin -v $(git ls-files '*.py')|grep 3.10
    !2, 3.10     tools/net/sunrpc/xdrgen/generators/__init__.py
    !2, 3.10     tools/net/sunrpc/xdrgen/generators/program.py
    !2, 3.10     tools/net/sunrpc/xdrgen/subcmds/source.py
    !2, 3.10     tools/net/sunrpc/xdrgen/xdr_ast.py
    !2, 3.10     tools/perf/scripts/python/mem-phys-addr.py
    !2, 3.10     tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

Such scripts aren't required for Kernel builds, so it should be OK to set minimal
python version to 3.9.

Mauro Carvalho Chehab (4):
  docs: changes: update Sphinx minimal version to 3.4.3
  docs: changes: update Python minimal version
  docs: extensions: don't use utf-8 syntax for descriptions
  scripts/kernel-doc: drop Sphinx version check

 Documentation/conf.py                       |   2 +-
 Documentation/process/changes.rst           |   4 +-
 Documentation/sphinx/cdomain.py             |   7 +-
 Documentation/sphinx/kernel_abi.py          |   6 +-
 Documentation/sphinx/kernel_feat.py         |   4 +-
 Documentation/sphinx/kernel_include.py      |   4 +-
 Documentation/sphinx/kerneldoc.py           |   5 -
 Documentation/sphinx/kfigure.py             |  10 +-
 Documentation/sphinx/load_config.py         |   2 +-
 Documentation/sphinx/maintainers_include.py |   4 +-
 Documentation/sphinx/rstFlatTable.py        |  10 +-
 scripts/kernel-doc                          | 129 +++-----------------
 12 files changed, 41 insertions(+), 146 deletions(-)

-- 
2.48.1



