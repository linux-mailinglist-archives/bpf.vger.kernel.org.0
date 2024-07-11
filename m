Return-Path: <bpf+bounces-34525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C192E2BD
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C51C21B13
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1961527A1;
	Thu, 11 Jul 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GW14cVOm"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFC12BF02;
	Thu, 11 Jul 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687888; cv=none; b=NEU3Djx8MuExeX+KttjoHvZ8Oaf24ljDfDEZhsqSnQAvbfn8M3h1d/NV1DkNFRvuiCCbqWQLNxIn14keMJeXXQKmXnhfWJeQR/Qs1JJLBKlHETFNEQl/5KyNesf31rj4t/uIRcJDq/rEyx5+F7wCHsUKrK0FUhoQNkQupfq1xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687888; c=relaxed/simple;
	bh=O4yibOBKqWqkWqN4pxaomHef+aRPGUQDXFseO15nYXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtaK+N65z/Y9xCWQaI7a48vXIHxJKD1Q/QYDxi1YChUMj4KDF6gmMCmTqI3hvSKnhw2A9R55eJVNax0eBHq8Nlap8bkE0tWWwee1CI42NZK0TWPy7JvMt3B1HiKW221utscKQxSb6vL+7GPUMvYrHNZ8aMp+i2VqgDK6wHikVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GW14cVOm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cqn9i5MsAUEjBWVzzIv2gV9Xacv5KrkAiXudj0N+8jA=; b=GW14cVOmPhpLU2dLssELZc+wwj
	91zrX0HK412yvdMh8FTrUdV3l7sA1jpmsbxP5H/YtIQfWIZOg2K34gpDfK112kHaRVh1hsRIUP8aE
	XoRDwsABLFDTU7WXCG9iF/WppSJg/nMeogqFo8IMlm5rvG2rzE/2BnxmFxD5JhgC1eZAQCxRS4wNs
	8+eT1z5aWArrYw1Iyej2lciLCEHNC8FX+DTi9g6Cy6mwFQy2EeNEE4NMtsSZsbLwe9cJFba3LZQI5
	meB0QJmo/4F9xE5Sf9ii2mKd8ylrixFGryl7oxqQlMapDcKXxCbpItiJtn7giR51xqQLNIl+TUVAK
	gqRficjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRpWJ-000000014By-0yCi;
	Thu, 11 Jul 2024 08:51:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5D3330050D; Thu, 11 Jul 2024 10:51:18 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:51:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
	mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, clm@meta.com,
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240711085118.GH4587@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net>
 <Zo0KX1P8L3Yt4Z8j@krava>
 <20240709101634.GJ27299@noisy.programming.kicks-ass.net>
 <20240710071046.e032ee74903065bddba9a814@kernel.org>
 <20240710101003.GV27299@noisy.programming.kicks-ass.net>
 <20240710235616.5a9142faf152572db62d185c@kernel.org>
 <CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:40:17AM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 10, 2024 at 7:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 10 Jul 2024 12:10:03 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > On Wed, Jul 10, 2024 at 07:10:46AM +0900, Masami Hiramatsu wrote:
> > >
> > > > > FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
> > > > > what gives?
> > > >
> > > > This is managing *probes and related dynamic trace-events. Those has been
> > > > moved from tip. Could you also add linux-trace-kernel@vger ML to CC?
> > >
> > > ./scripts/get_maintainer.pl -f kernel/events/uprobes.c
> > >
> > > disagrees with that, also things like:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=probes/for-next&id=4a365eb8a6d9940e838739935f1ce21f1ec8e33f
> > >
> > > touch common perf stuff, and very much would require at least an ack
> > > from the perf folks.
> >
> > Hmm, indeed. I'm OK to pass those patches (except for trace_uprobe things)
> > to -tip if you can.
> >
> > >
> > > Not cool.
> >
> 
> You were aware of this patch and cc'ed personally (just like
> linux-perf-users@vger.kernel.org) on all revisions of it. I addressed
> your concerns in [0], you went silent after that and patches were
> sitting idle for more than a month.

Yeah, I remember seeing it. But I was surprised it got applied. If I'm
tardy -- this can happen, more so of late since I'm still recovering
from injury and I get far more email than I could hope to process in a
work day -- please ping.

(also, being 'forced' into using a split keyboard means I'm also
re-learning how to type, further slowing me down -- training muscle
memory takes a while)

Taking patches that touch other trees is fairly common, but in all those
cases an ACK is 'required'.

(also also, I'm not the only maintainer there)

> But regardless, if you'd like me to do any adjustments, please let me know.
> 
>   [0] https://lore.kernel.org/all/CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com/
> 

I'll check, it might be fine, its just the surprise of having it show up
in some random tree that set me off.

> > Yeah, the probe things are boundary.
> > BTW, IMHO, there could be dependency issues on *probes. Those are usually used
> > by ftrace/perf/bpf, which are managed by different trees. This means a series
> > can span multiple trees. Mutually reviewing is the solution?
> >
> 
> I agree, there is no one best tree for stuff like this. So as long as
> relevant people and mailing lists are CC'ed we hopefully should be
> fine?

Typically, yeah, that should work just fine.

But if Masami wants to do uprobes, then it might be prudent to add a
MAINTAINERS entry for it. 

A solution might be to add a UPROBES entry and add masami, oleg (if he
wants) and myself as maintainers -- did I forget anyone? Git seems to
suggest it's mostly been Oleg carrying this thing.

That is, one way or another I think we should get
./scripts/get_maintainer.pl to emit more people for the relevant files.

