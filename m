Return-Path: <bpf+bounces-52864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEB5A49504
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED86171EE7
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48F258CD7;
	Fri, 28 Feb 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWWvpTC6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12B257428;
	Fri, 28 Feb 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734840; cv=none; b=kXa6u4OHnbQ/pm30O/RXw35fDmJFjFvvZLifNn9PYx9/XSmvDKwXDnVDjDPJWP6DpLZc3Roq5xozOOAko9HXY9j5xPcisaLgu9HSqGZK29fCHudW/69eLNLEee3lM/32VIDzeTYM91Bcx+m+LWHeK9fc8da1LPY+1IuOVUcMOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734840; c=relaxed/simple;
	bh=lz8ax6F0htmAbSQ5MPFNimyF74qU75QJLASs1fvZ70s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcBEz471f388H5UNZ/ekAuV+XYfnAsyOz/fjzDuoQeUMXypR3uIzkDZ39b7iQLhvufKB+WkhoeZUb3RooAIe8Wr6qzMjrqugyNF2Y0ghnjDW0dzSGTu8DTv9ffYzj7PGeSfciHSPxjrrAliTl/lLN1+/MQDzL8h+KXoVia9JT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWWvpTC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27921C4CED6;
	Fri, 28 Feb 2025 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740734839;
	bh=lz8ax6F0htmAbSQ5MPFNimyF74qU75QJLASs1fvZ70s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWWvpTC6vMdZyaSwQiykIe3gqqQZidfdmEHVIYMReiu37txvRLr0LXPkZc+XwA+Wt
	 lJla9ubjKAskk+ri3L9Y03xe3ZESzU/b9+PeUd1McaNPE1VKevdKv8xC4OumgqtJTt
	 oR93Pt1qR4uYXrgnZn3JblY5r2KKTJrM4lVVyWEDOrJ2ngEBV6kCe1C2hEW5aFqhCD
	 uBYekxvi7/ffFBmxHEDal9pvvnXaiaqnt23/Htd0BPks/JFtYN5KioFvHOUWJEFhnL
	 u8nVdXsy12IhiqYmY6alEB7ZqEGDFSOfHyuCgqlGjAmt4FqdqpstyRmRFpW02XaZ9I
	 AgaP0ex3AGuDw==
Date: Fri, 28 Feb 2025 10:27:17 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
 <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>

On Mon, Feb 24, 2025 at 08:43:45AM +0100, Lucas De Marchi wrote:
> On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
> > On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
> > > On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
> > > > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
> > > > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
> > > > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > > > > >
> > > > > > > Add support for a module error injection tool. The tool
> > > > > > > can inject errors in the annotated module kernel functions
> > > > > > > such as complete_formation(), do_init_module() and
> > > > > > > module_enable_rodata_after_init(). Module name and module function are
> > > > > > > required parameters to have control over the error injection.
> > > > > > >
> > > > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > > > > > > brd module:
> > > > > > >
> > > > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
> > > > > > > --error=-22 --trace
> > > > > > > Monitoring module error injection... Hit Ctrl-C to end.
> > > > > > > MODULE     ERROR FUNCTION
> > > > > > > brd        -22   module_enable_rodata_after_init()
> > > > > > >
> > > > > > > Kernel messages:
> > > > > > > [   89.463690] brd: module loaded
> > > > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> > > > > > > ro_after_init data might still be writable
> > > > > > >
> > > > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > > > > ---
> > > > > > >  tools/bpf/Makefile            |  13 ++-
> > > > > > >  tools/bpf/moderr/.gitignore   |   2 +
> > > > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> > > > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> > > > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
> > > > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > The tool looks useful, but we don't add tools to the kernel repo.
> > > > > > It has to stay out of tree.
> > > > >
> > > > > For selftests we do add random tools.
> > > > >
> > > > > > The value of error injection is not clear to me.
> > > > >
> > > > > It is of great value, since it deals with corner cases which are
> > > > > otherwise hard to reproduce in places which a real error can be
> > > > > catostrophic.
> > > > >
> > > > > > Other places in the kernel use it to test paths in the kernel
> > > > > > that are difficult to do otherwise.
> > > > >
> > > > > Right.
> > > > >
> > > > > > These 3 functions don't seem to be in this category.
> > > > >
> > > > > That's the key here we should focus on. The problem is when a maintainer
> > > > > *does* agree that adding an error injection entry is useful for testing,
> > > > > and we have a developer willing to do the work to help test / validate
> > > > > it. In this case, this error case is rare but we do want to strive to
> > > > > test this as we ramp up and extend our modules selftests.
> > > > >
> > > > > Then there is the aspect of how to mitigate how instrusive code changes
> > > > > to allow error injection are. In 2021 we evaluated the prospect of error
> > > > > injection in-kernel long ago for other areas like the block layer for
> > > > > add_disk() failures [0] but the minimal interface to enable this from
> > > > > userspace with debugfs was considered just too intrusive.
> > > > >
> > > > > This effort tried to evaluate what this could look like with eBPF to
> > > > > mitigate the required in-kernel code, and I believe the light weight
> > > > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
> > > > > suffices to my taste.
> > > > >
> > > > > So, perhaps the tools aspect can just go in:
> > > > >
> > > > > tools/testing/selftests/module/
> > > >
> > > > but why would it be module-specific?
> > > 
> > > Gotta start somewhere.
> > > 
> > > > Based on its current implementation
> > > > and discussion about inject.py it seems to be generic enough to be
> > > > useful to test any function annotated with ALLOW_ERROR_INJECTION().
> > > >
> > > > As xe driver maintainer, it may be interesting to use such a tool:
> > > >
> > > > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
> > > >
> > > > How does this approach compare to writing the function name on debugfs
> > > > (the current approach in xe's testsuite)?
> > > >
> > > > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
> > > > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
> > > >
> > > > If you decide to have the tool to live somewhere else, then kmod repo
> > > > could be a candidate.
> > > 
> > > Would we install this upon install target?
> > > 
> > > Danny can decide on this :)
> > > 
> > > > Although I think having it in kernel tree is
> > > > simpler maintenance-wise.
> > > 
> > > I think we have at least two users upstream who can make use of it. If
> > > we end up going through tools/testing/selftests/module/ first, can't
> > > you make use of it later?
> > 
> > What are the features in debugfs required to be useful for xe that we can
> > port to an eBPF version? I see from the link provided the use of probability,
> > interval, times and space but these are configured to allways trigger the error.
> > Is that right?
> 
> I don't think we use them... we just set them to "always trigger" and
> then create the conditions for that to happen.  But my question still
> remains:  what is the benefit of using the bpf approach over writing
> these files?

The code to trigger the error injection still needs to exist with both
approaches. My understanding from debugfs and the comment from Luis earlier in
the thread is that with eBPF you can mitigate how intrusive in-kernel code
changes are to allow error injection. Luis added the example here [1] for
debugfs.

[1] https://lore.kernel.org/all/20210512064629.13899-9-mcgrof@kernel.org/

To compare patch 8 in [1] with eBPF approach: the patch describes
all the necessary changes required to allow error injection on the
add_disk() path. With eBPF one would simply annotate the function(s) with
ALLOW_ERROR_INJECTION(), e.g. device_add() and replace the return value
in eBPF code with bpf_override_return() as implemented in moderr tool for
module_enable_rdata_after_init() for example.

New error injection users such modules or block/disk would benefit of the eBPF
approach with having a more simpler in-kernel code for the same purpose. Current
users of debugfs/errorinj would have to remove all the upstream intrusive error
injection related code if they want to adopt the eBPF approach.

Daniel

> 
> Lucas De Marchi
> 
> > 
> > > 
> > >   Luis

