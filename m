Return-Path: <bpf+bounces-52260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E0A40BC6
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 22:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C23189828C
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0C2045B9;
	Sat, 22 Feb 2025 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUmftls8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFE8828;
	Sat, 22 Feb 2025 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740260112; cv=none; b=A8A0rVCYiQEAoHm5ctelVwHBiQzXZkupnd1b/B1Zknxlqag4JP4sgEUwMgPH3u7vpSYOsHPGJX7njWrcV2tAVP/+IPRWnosCDEfoHqq/u8y9N8mJ+BX9xAt7px2STz2yov4T7nMlAQSVwr5P1vGotCC0MNfwaoT4w8rW+CugOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740260112; c=relaxed/simple;
	bh=hutpFYmwMXgC77Hfh27TmC3ghETHcgXDOGC7YWZS57E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBmmCC2VCZenTPgBo99QRAMqSFgw8EI9wss/MEO8cCpEy9K6Ca/VurpAq+/dh5urHPM8wmI6CGW3DFpI0AasEsDR6SKi4aB2SFF6/I+I7nVI6b001CxsCqB7tQJVAbn7+cRvJnWiboe9ytJib1fXFfxnvrLv57xBNpZSS5tPJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUmftls8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB43C4CED1;
	Sat, 22 Feb 2025 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740260111;
	bh=hutpFYmwMXgC77Hfh27TmC3ghETHcgXDOGC7YWZS57E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUmftls821xa/7W7aBu3iLffC1zaNyPwCJw+HPPbKm3CYb63S9Mw4a4262Q+/5OwG
	 Scimr8KzAz8T9qwj19PKZaaZxyYIqjObXZIItF9HrvB6PvoT4U6OFJKzWiN/15gSxH
	 jAESOQt4z6d09c6gf18LfAz5ZxQ32ng7tcYF3nRmHb46nCMRxmLYn8O78z6So7PZaO
	 OEIT67e0d+jQvN5srPtHoUXOBjsr67Dy59YLrk+b5jFegsnnR44vdcPveBmOtJlziK
	 eRdbD7EDlCWBtcQMJVM2DemKsYM+NYDz2XwzWjRi/AcEogwxYBPVso8L9sD8nO+Xq2
	 eqFVokkPFLlHg==
Date: Sat, 22 Feb 2025 22:35:07 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7je7Kryipdq6AV4@bombadil.infradead.org>

On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
> On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
> > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
> > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > > >
> > > > > Add support for a module error injection tool. The tool
> > > > > can inject errors in the annotated module kernel functions
> > > > > such as complete_formation(), do_init_module() and
> > > > > module_enable_rodata_after_init(). Module name and module function are
> > > > > required parameters to have control over the error injection.
> > > > >
> > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > > > > brd module:
> > > > >
> > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
> > > > > --error=-22 --trace
> > > > > Monitoring module error injection... Hit Ctrl-C to end.
> > > > > MODULE     ERROR FUNCTION
> > > > > brd        -22   module_enable_rodata_after_init()
> > > > >
> > > > > Kernel messages:
> > > > > [   89.463690] brd: module loaded
> > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> > > > > ro_after_init data might still be writable
> > > > >
> > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > > ---
> > > > >  tools/bpf/Makefile            |  13 ++-
> > > > >  tools/bpf/moderr/.gitignore   |   2 +
> > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
> > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
> > > > 
> > > > The tool looks useful, but we don't add tools to the kernel repo.
> > > > It has to stay out of tree.
> > > 
> > > For selftests we do add random tools.
> > > 
> > > > The value of error injection is not clear to me.
> > > 
> > > It is of great value, since it deals with corner cases which are
> > > otherwise hard to reproduce in places which a real error can be
> > > catostrophic.
> > > 
> > > > Other places in the kernel use it to test paths in the kernel
> > > > that are difficult to do otherwise.
> > > 
> > > Right.
> > > 
> > > > These 3 functions don't seem to be in this category.
> > > 
> > > That's the key here we should focus on. The problem is when a maintainer
> > > *does* agree that adding an error injection entry is useful for testing,
> > > and we have a developer willing to do the work to help test / validate
> > > it. In this case, this error case is rare but we do want to strive to
> > > test this as we ramp up and extend our modules selftests.
> > > 
> > > Then there is the aspect of how to mitigate how instrusive code changes
> > > to allow error injection are. In 2021 we evaluated the prospect of error
> > > injection in-kernel long ago for other areas like the block layer for
> > > add_disk() failures [0] but the minimal interface to enable this from
> > > userspace with debugfs was considered just too intrusive.
> > > 
> > > This effort tried to evaluate what this could look like with eBPF to
> > > mitigate the required in-kernel code, and I believe the light weight
> > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
> > > suffices to my taste.
> > > 
> > > So, perhaps the tools aspect can just go in:
> > > 
> > > tools/testing/selftests/module/
> > 
> > but why would it be module-specific?
> 
> Gotta start somewhere.
> 
> > Based on its current implementation
> > and discussion about inject.py it seems to be generic enough to be
> > useful to test any function annotated with ALLOW_ERROR_INJECTION().
> > 
> > As xe driver maintainer, it may be interesting to use such a tool:
> > 
> > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
> > 
> > How does this approach compare to writing the function name on debugfs
> > (the current approach in xe's testsuite)?
> > 
> > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
> > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
> > 
> > If you decide to have the tool to live somewhere else, then kmod repo
> > could be a candidate.
> 
> Would we install this upon install target?
> 
> Danny can decide on this :)
> 
> > Although I think having it in kernel tree is
> > simpler maintenance-wise.
> 
> I think we have at least two users upstream who can make use of it. If
> we end up going through tools/testing/selftests/module/ first, can't
> you make use of it later?

What are the features in debugfs required to be useful for xe that we can
port to an eBPF version? I see from the link provided the use of probability,
interval, times and space but these are configured to allways trigger the error.
Is that right?

> 
>   Luis

