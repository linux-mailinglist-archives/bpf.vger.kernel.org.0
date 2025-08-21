Return-Path: <bpf+bounces-66152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD1B2F17B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55296003A2
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606152EBDFF;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Rz1CGb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E612EB5CC;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=beqeqj5JNj6ZsMrpANutEy9MJuR5v64bHky4XifJCC1lgJkWx3IY7TW4l4enH/XzEcYFVa9IaBCNCRDlGQ2ogKLZo/oG3GyGpwmTkVY1Gfng+dG8bWKim1wylw7VNdGfk/IdyiuRj3OKkC/PSJXbHx0g71vO6Uh6EdcQ/eBxoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=pCs2a5GtHIUVqWsvAf6JbIDTiB41Hz/jWLA7wnaYB14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+YLi+wlh3SJeyA0HwY2XmlhO+hSAbwPSKA/8yZPdYp9y4JzB48y+wECewKC2V0RTTlMcYUC/ZtprHKs1W2wgsjoxZoOpBNZpiBgJVZT7jw6RrCH6UgtvunQpTF7p5hTRkRp5xB2jM+sdHvYfRCZwyuFKT2IjS4MZva77YIBtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Rz1CGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F032C4CEED;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=pCs2a5GtHIUVqWsvAf6JbIDTiB41Hz/jWLA7wnaYB14=;
	h=From:To:Cc:Subject:Date:From;
	b=k7Rz1CGbqlTAdaRCI72izKdN48N5xxD+9hPKBsJpD4AOKeaHyx8wkhLe1FLGypxsz
	 TKJlTJPc2ngIpap1JM6HttsPDDrxWhQRbLW9tq6DOCiKjIsQaNd2U5F75Ww4ts+5XL
	 14XxrLyZfbuGJBPREYO9vXC3z5Dzi5CE+I+MNrNd0iFC4haHGMGGWDkzhPjKxzRJSx
	 esZIMmQlFhfNHaTLnDkTW9tqOZNStnc3mLQ4O77UbvW17orF5gJmu1QgPGEBNA9zso
	 XjxGx525edh/DsKXwmM+cyfQIKJUxND2tc8+OeDFE1FQM+Ir6oC4z4Riz9VUjAFkez
	 KyyzsIkFlO9+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLg2-2IUN;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 00/14] Fix PDF doc builds on major distros
Date: Thu, 21 Aug 2025 10:16:36 +0200
Message-ID: <cover.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

Here it is the second version of the PDF series. I opted to split one of
the patches in 3, to have a clearer changelog and description.

Also, archlinux LXC image download started working again, so I added
an extra patch addressing texlive packae dependencies.

This series is taking me a way more time than antecipated.

This series as 3 goals:

1. Fix a pre-Sphinx 1.7 PDF variable that got renamed, but
   our Makefile still uses the old one that is not supported
   since Sphinx 1.7;

2. Fix broken or incomplete texlive dependencies on several
   distros;

4. "modernize" conf.py to solve font conflicts related to UTF-8
   and non-UTF fonts from [T1]{fontenc}  LaTeX package.

   Using fontenc with xelatex is problematic, as documented at

	https://www.sphinx-doc.org/en/master/latex.html

Please notice that:

- It doesn't pretend to fix all  PDF issues. It focus only at the
  above;
- there are still distros where PDF builds fail either partially
  or as a hole. On my checks, those are due to problematic
  texlive packages shipped on such distros;
- it doesn't touch/address/alter anyhing related to kfigure.py.
  as such, it doesn't touch/change/improve/drop anything with
  regards ImageMagick and/or Inkscape.

I think we need a separate series addressing kfigure.py:
it currently breaks if either input or output has a char > 127,
meaning that PDF output there may eventually break.

---
v2:
  - one of the conf.py packages were split to help reviewers
    to check the actual changes;
  - added an extra sphinx-pre-install patch for ArchLinux.

Mauro Carvalho Chehab (14):
  docs: Makefile: Fix LaTeX paper size settings
  docs: conf.py: better handle latex documents
  docs: conf.py: fix doc name with SPHINXDIRS
  docs: conf.py: rename some vars at latex_documents logic
  docs: conf.py: use dedent and r-strings for LaTeX macros
  docs: conf.py: fix some troubles for LaTeX output
  docs: conf.py: extra cleanups and fixes
  scripts: sphinx-pre-install: fix PDF build issues on Ubuntu
  scripts: sphinx-pre-install: add missing gentoo pdf dependencies
  scripts: sphinx-pre-install: fix PDF dependencies for openSuse
  scripts: sphinx-pre-install: fix dependencies for OpenMandriva
  scripts: sphinx-pre-install: fix pdf dependencies for Mageia 9
  scripts: sphinx-pre-install: fix PDF dependencies for gentoo
  scripts/sphinx-pre-install: fix Archlinux PDF dependencies

 Documentation/Makefile     |   4 +-
 Documentation/conf.py      | 106 ++++++++++++++++++++++---------------
 scripts/sphinx-pre-install |  46 ++++++++++++----
 3 files changed, 101 insertions(+), 55 deletions(-)

-- 
2.50.1



