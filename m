Return-Path: <bpf+bounces-38624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B74966CF9
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229831C22C8F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23AE18F2CF;
	Fri, 30 Aug 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZl0cxYI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3815C150
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061373; cv=none; b=D6xPv0Fpek0vncgc2DNsObufafhNK4wKw3mhBDBocOHdhaODpM21ZHDG9+OrWmEfiPZbOhcH7jBzANmsxNeBf8EQQ+/MLOloAMthBtuAjZMm27CeW9KHKEaCdxoD0O9Kjq90XMft8Ew7rbIeTXUrV0wpwBREmy5wSKpycXkJt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061373; c=relaxed/simple;
	bh=tmRQGlxyD6UPBbvBGBnhQJTxWh7cvIkbz3ME9Gd0HU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUqTFxKKQ6zN77fEptMKDsPUj3pYQFjdqjGtShIVxSbqjvyFNaGaos76KSa3LTGsHxiYhWzis6hAASGX2bh55c7c33SXG+ncfqv43vlH/etx5We+CHU3Xr9TY+iSgot7WCmXX29eusc+IuaMYYq3zZUuUzdO2R4p6Lb5aogNCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZl0cxYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CF6C4CEC2;
	Fri, 30 Aug 2024 23:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725061373;
	bh=tmRQGlxyD6UPBbvBGBnhQJTxWh7cvIkbz3ME9Gd0HU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZl0cxYI/jP9nLYfPCVNOxmET4pC9Hnkle3144/dKF6bBUJOhUO6aZjuodw67/ucc
	 sc9OqoRTskZm5YjdzDfPqtuYHIu1PdEENbLfb3nUbOXlfx8QObnpklRYPAQ/6np2H6
	 Ust6pJFSSO1s0fxlItzWp9qJtkcqwo+xuCg1heGk03j83LjmMP5fH1eTpgDXqDalB3
	 yd59tsnYlueRjZ793Gy6wsekAB76x5RTH7oNQedc2UjAPPd39dE5rH/6mzP/IfLycN
	 RtJfdR0dF2M46TC7JVjeuBaw8QpCIRRQ2b+0CIMohIf1jQ2SYB58NSKvJdg/Iex0vL
	 euIwWOEGrdF3A==
Date: Fri, 30 Aug 2024 20:42:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	mykolal@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h
 unnecessarily
Message-ID: <ZtJY-jd0ATcFV-nS@x1>
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
 <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
 <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
 <68c211f8-48a3-415c-a7d1-5b3ee2074f45@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c211f8-48a3-415c-a7d1-5b3ee2074f45@oracle.com>

On Fri, Aug 30, 2024 at 10:03:40PM +0100, Alan Maguire wrote:
> On 30/08/2024 21:34, Andrii Nakryiko wrote:
> > On Wed, Aug 28, 2024 at 3:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >>
> >> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
> >>> %.bpf.o objects depend on vmlinux.h, which makes them transitively
> >>> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> >>> actually change as often.
> >>>
> >>> When generating vmlinux.h, compare it to a previous version and update
> >>> it only if there are changes.
> >>>
> >>> Example of build time improvement (after first clean build):
> >>>   $ touch ../../../lib/bpf/bpf.h
> >>>   $ time make -j8
> >>> Before: real  1m37.592s
> >>> After:  real  0m27.310s
> >>>
> >>> Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
> >>>
> >>> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=A8aTVxpsCzD=p1jdTfKC7i0XVuYoHUQ@mail.gmail.com
> >>>
> >>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> >>> ---
> >>
> >> Unfortunately, I think that this is a half-measure.
> >> E.g. the following command forces tests rebuild for me:
> >>
> >>   touch ../../../../kernel/bpf/verifier.c; \
> >>   make -j22 -C ../../../../; \
> >>   time make test_progs
> >>
> >> To workaround this we need to enable reproducible_build option:
> >>
> >>     diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> >>     index b75f09f3f424..8cd648f3e32b 100644
> >>     --- a/scripts/Makefile.btf
> >>     +++ b/scripts/Makefile.btf
> >>     @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      += --skip_encoding_btf_inconsis
> >>      else
> >>
> >>      # Switch to using --btf_features for v1.26 and later.
> >>     -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> >>     +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build
> >>
> >>      ifneq ($(KBUILD_EXTMOD),)
> >>      module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
> >>
> >> Question to the mailing list: do we want this?
> > 
> > Alan, can you please give us a summary of what are the consequences of
> > the reproducible_build pahole option? In terms of performance and
> > otherwise.
> >
> 
> Sure. The original context was that the folks trying to do reproducible
> builds were being impacted by the fact that BTF generation was
> non-deterministic when done in parallel; i.e. same kernel would give
> different BTF ids when rebuilding vmlinux BTF; the reason was largely as
> I understand it that when pahole partitioned CUs between multiple
> threads, that partitioning could vary. If it varied, when BTF was merged
> across threads we could end up with differing id assignments. Since BTF
> then was baked into the vmlinux binary, unstable BTF ids meant
> non-identical vmlinux.
> 
> The first approach to solve this was to remove parallel BTF generation
> to support reproducibility. Arnaldo however added support that retained
> parallelism while supporting determinism through using the DWARF CU
> order. He did some great analysis on the overheads for vmlinux
> generation too [1]; summary is that the overhead in runtime is approx
> 33% versus parallel non-reproducible encoding. Those numbers might not
> 100% translate to the vmlinux build during kernel since it was a
> detached pahole generation and the options might differ slightly, but
> they give a sense of things. I don't _think_ there should be additional
> memory overheads during pahole generation (we really can't afford any
> more memory usage), since it's really more about making order of CU
> processing consistent.
> 
> Would be good to get Arnaldo's perspective too if we're considering
> switching this on by default, as he knows this stuff much better than I do.

You described it nicely! And on top of that there was recent work that
will be available in 1.28 to reduce the memory footprint of pahole,
using it to find things to pack in itself, reducing the number of
allocations, not keeping unreferenced CUs around (you did it), part of
the work to have it working on 32-bit architectures, where we had
reports of it not working.

There is certainly more optimizations to be made to reduce its memory
footprint while allowing it to run in parallel, but at this point it
seems to have addressed the problems that were reported.

More people trying it and measuring the impacts, to confirm the tests
and analysis we did and you alluded too can be only a good thing in
getting us all informed and confortable with using this option by
default.

BTW, we have now a tests/ directory with a regression test for this
feature and another for the --prettify feature in pahole (use DWARF or
BTF to pretty print raw data with several tricks on finding the right
data structure based on enumerations when the conventions used in a
project allow for that, that is the case with tools/perf, also for using
header sizes to traverse variable sized records, etc), please see:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/tests

And:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=fd14dc67cb6aaead553074afb4a1ddad10209892
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=be638365781ed0c843249c5bcebe90a01e74b2fe

This should help us in detecting problems earlier, brownie point to
whoever gets this hooked up in CI systems, existing or new 8-)

Thanks,

- Arnaldo
 
> [1]
> https://lore.kernel.org/dwarves/20240412211604.789632-12-acme@kernel.org/

