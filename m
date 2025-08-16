Return-Path: <bpf+bounces-65812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A06B28D81
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2720C1C808EE
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6A92D7D2E;
	Sat, 16 Aug 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL15tGnf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D523504B;
	Sat, 16 Aug 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755345344; cv=none; b=fcbJmp4SJMN3YYxZoXHJ5H4z8uEF3dm5wOiGZ7l7abWapvINCxxv5MiClaLFmLtPmuhGdJCtLV/okCpzIWxWTYpiHYYIubjcBIspat7vcoEjx3d+/Xo9Ayy1OiyYKDzdJm7AwKWM8ctdZu71jMG7ZQ/6PCKLe4O86fSsgunZ6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755345344; c=relaxed/simple;
	bh=ANncU8lgObSWtg5ScydN7E+de1qMSShz6qNo14jNZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1gwhw5YBEtbJrp0m/+TGQxZKsg//3P8hZgh6yG7eptbAigb35z3iBQcJ78NoSptPtLgZ18W32BQJ/+sTAkWQezcwz7bWFZDp/6kNSfrVC2BmynDIvzfwJj6dHpdPjcZQ3Y8ELMMmQ163cSxbwCdTJfBozboRJWNdYx6QqizuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL15tGnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E83C4CEEF;
	Sat, 16 Aug 2025 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755345342;
	bh=ANncU8lgObSWtg5ScydN7E+de1qMSShz6qNo14jNZhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cL15tGnft5wKH0WmD8E3AMOGQ3MhXAEIExnCsgqEIQxXM1rrubwGeS8vRnLLwmc8c
	 wLUBI+LBT2w6kPkzeBlVqPJvRnSJsx28L7Euj5H3cjhRPMI7uRdAOzZwyjjitFfxta
	 eCA47ClZG2uzJMWmq3mZtPYkWdnJYKtkA/+ORP04qjgYWnhSVKTWcQP4w/kqI1mupO
	 CW2x/MOwljaPR7TQTuyArGf7+qD7F/aoYncnIaSPO28awPBlr2poNMe/JFIb+phWC/
	 pOLplEpO7rKt+M1qp8BTVJwDw1JdkQDhdusAexdUsoCl/QJweg2YnPlTvGi2u24Yhm
	 uc03nl/ptghfQ==
Date: Sat, 16 Aug 2025 13:55:38 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: bpf@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250816135538.733b80d3@foz.lan>
In-Reply-To: <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 16 Aug 2025 14:06:43 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [-CC most folks]
> 
> Hi Mauro,
> 
> On Fri, 15 Aug 2025 13:36:16 +0200, Mauro Carvalho Chehab wrote:
> > Hi Jon,
> > 
> > This series touch only on three files, and have a small diffstat:
> > 
> >    Documentation/Makefile     |    4 -
> >    Documentation/conf.py      |  106 +++++++++++++++++++++----------------
> >    scripts/sphinx-pre-install |   41 +++++++++++---
> >    3 files changed, 96 insertions(+), 55 deletions(-)
> > 
> > Yet, it took a lot of my time.  Basically, it addresses lots of problems  related
> > with building PDF docs:
> > 
> > - Makefile has a wrong set of definitions for paper size. It was
> >   using pre-1.7 Sphinx nomenclature for some conf vars;
> > - The LaTeX options a conf.py had lots of issues;
> > - Finally, some PDF package dependencies for distros were wrong.
> > 
> > I wrote an entire testbench to test this and doing builds on every
> > platform mentioned at sphinx-pre-install. 
> > 
> > After the change *most* PDF files are built on *most* platforms. 
> > 
> > 
> > Summary
> > =======
> >   PASSED - AlmaLinux release 9.6 (Sage Margay) (7 tests)
> >   PASSED - Amazon Linux release 2023 (Amazon Linux) (7 tests)
> >   FAILED - archlinux (1 tests)
> >   PASSED - CentOS Stream release 9 (7 tests)
> >   PARTIAL - Debian GNU/Linux 12 (7 tests)
> >   PARTIAL - Devuan GNU/Linux 5 (7 tests)
> >   PASSED - Fedora release 42 (Adams) (7 tests)
> >   PARTIAL - Gentoo Base System release 2.17 (7 tests)
> >   PASSED - Kali GNU/Linux 2025.2 (7 tests)
> >   PASSED - Mageia 9 (7 tests)
> >   PARTIAL - Linux Mint 22 (7 tests)
> >   PARTIAL - openEuler release 25.03 (7 tests)
> >   PARTIAL - OpenMandriva Lx 4.3 (7 tests)
> >   PASSED - openSUSE Leap 15.6 (7 tests)
> >   PASSED - openSUSE Tumbleweed (7 tests)
> >   PARTIAL - Oracle Linux Server release 9.6 (7 tests)
> >   FAILED - Red Hat Enterprise Linux release 8.10 (Ootpa) (7 tests)
> >   PARTIAL - Rocky Linux release 8.9 (Green Obsidian) (7 tests)
> >   PARTIAL - Rocky Linux release 9.6 (Blue Onyx) (7 tests)
> >   FAILED - Springdale Open Enterprise Linux release 9.2 (Parma) (7 tests)
> >   PARTIAL - Ubuntu 24.04.2 LTS (7 tests)
> >   PASSED - Ubuntu 25.04 (7 tests)
> > 
> > The failed distros are:
> > 
> > - archlinux. This is some problem on recent lxc containers. Unrelated
> >   with pdf builds;
> > - RHEL 8: paywall issue: some packages required by Sphinx require a repository
> >   that it is not openly available. I might have using CentOS repos, but, as we're
> >   already testing it, I opted not do do it;
> > - Springdale 9.2: some broken package dependency.
> > 
> > Now, if you look at the full logs below, you'll see that some distros come with
> > XeLaTeX or LaTeX troubles, causing bigger and/or more complex docs to
> > fail. It is possible to fix those, but they depend on addressing distro-specific
> > LaTeX issues like increasing maximum memory limits and maximum number
> > of idented paragraphs.  
> 
> No, the trouble is failed conversion of SVG --> PDF by convert(1) + rsvg-convert(1).
> Failed conversions trigger huge raw SVG code to be included literally into LaTeX
> sources, which results in code listings too huge to be rendered in a page; and
> overwhelms xelatex.

I remember we had some cases of too large items on media uAPI. There,
the problem were mostly on tables. The fix was to add several LaTeX
specific commands:

	$ git grep -i "raw:: latex" Documentation/userspace-api/media/|wc -l
	201

Currently, they all are just changing font size, but 

We also use less-ugly things like Sphinx PDF builder specific
classes:

	.. cssclass:: longtable

So, one alternative would be to look at techniques to auto-scale
image, like:

	\usepackage{pdfpages}
	...
	\includepdf{image.png}

as proposed here:

	https://tex.stackexchange.com/questions/39147/scale-image-to-page-width

Yet, we tried something like that before to auto-scale tables,
overriding Sphinx Latex macros. It worked for a couple of sphinx versions, 
but maintaining it was hard, as newer versions of Sphinx came with different
macro names or different behaviors.

Heh, if you check:
	https://www.sphinx-doc.org/en/master/latex.html#additional-css-like-sphinxsetup-keys

You'll see that sphinx latex builder have been suffering lots of changes
over time.

> IIUC, kfigure.py does such fallbacks of failed PDF conversions.  Mightn't it be
> better to give up early in the latexdocs stage?

Makes sense to me.

> > It follows full results per distro.  
> 
> [Ignoring lengthy list of results...]
> 
> I think all you need to test build against are the limited list of:
> 
>     - arch.pdf
>     - core-api.pdf
>     - doc-guide.pdf
>     - gpu.pdf
>     - i2c.pdf
>     - RCU.pdf
>     - translations.pdf
>     - userspace-api.pdf
> 
> All of them have figures in SVG, and latexdocs tries to convert them
> into PDF.
> 
> Probably, recommending Inkscape rather than ImageMagick would be the right
> thing, at least where it is provided as a distro package.

Works for me, but let's do it on a separate series. I still have more
than 100 patches on my pile to be merged. This series is focused on
making at least some PDFs to build where possible, addressing major
problems at conf.py that are causing LaTeX to not work on several
distros and to fix wrong package dependencies(*).

I'll add a TODO item on my queue to replace fom ImageMagick to
Inkscape on a separate series.

(*) One of such problem you blamed sphinx-build-wrapper, but 
    the issue is actually addressed on this series with fixes to conf.py: 
    there are currently several troubles at latex_documents list and at
    latex_elements.

    Those are causing wrong font detection on LaTeX. Maybe the corrupted
    font issues you got are related to it.

    It took me a lot of time to set latex_elements in a way that
    it now works fine. The main keys related to it are those:

	"passoptionstopackages": dedent(r"""
	        \PassOptionsToPackage{svgnames}{xcolor}
	        % Avoid encoding troubles when creating indexes
	        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
	    """),
	"fontenc": "",
	'fontpkg': dedent(r'''
	        \usepackage{fontspec}
	        \setmainfont{DejaVu Serif}
	        \setsansfont{DejaVu Sans}
	        \setmonofont{DejaVu Sans Mono}
	        \newfontfamily\headingfont{DejaVu Serif}
	'''),

    You can't imagine how much hours it took to get the above
    lines right ;-)

    Basically, "fontenc" and "fontpkg" are two different ways
    that LaTeX use to include true-type fonts. We need to disable the 
    first, as otherwise it will try to use both, which may result in 
    incompatible fonts (On Debian, LaTeX build reports corrupted fonts 
    on T1 fontenc set - preventing PDF builds). The actual messge there
    is:

	! Corrupted NFSS tables

    Btw, just disabling fontenc there was not enough, as babel was still
    trying to load a T1 Polish font indirectly used by Sphinx hyphenation
    macros. I had to add \newfontfamily to fix such issue.

Thanks,
Mauro

