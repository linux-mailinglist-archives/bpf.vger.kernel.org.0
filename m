Return-Path: <bpf+bounces-45823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6B9DB688
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF60B21A32
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A94192B83;
	Thu, 28 Nov 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SzFK5SEo"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56713A865
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793604; cv=none; b=Vh0HbXqmybIO9z6hZU9uI4MlvsuClekA53ZYDgUIGQKEGqSOwoPq2Z2T0M27pMo00NMJfJ055sGoW3tBlErKy8fKDQ3v501Kqog4pB4bvXzOcfGRNXd+OamJMO+xWepNZ1Rk36cBFJUwMqimkhKAjp2dBqTkrSx721KHaYeEGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793604; c=relaxed/simple;
	bh=MUG7iGprFM0xCXceGgO4KggyARRE0UHBaBKMtVeEgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKPVX/DDi+55zIst2TwKJIGMP1IpwsLj8bN7RB2Z8UgNrf9VqcGODScDE8XvA1eNpeyob0SzUYyQb0u4q+HHjlQC1awgXgRuHkvtavhYuj/aZYXa4SSiZj1uxFAvXLQBfKUbFUidCr1cU520qLAZJ1lcgB2MqUcXdSeM9fqhYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SzFK5SEo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vqvFXmXryBhLWIQ/9pDsoU96v4bsAIxEJk6Lrt8hZNA=; b=SzFK5SEosBXboYPVbgmovt5EXr
	oTogYoigdXRQOjNEefU6zxteAOBDVTEngdBjruQZt+bL1jsKIrbfmtHdFT8PxR5yLqSQikVI1xhx3
	Hwl0/ZCG6i84ySJKLRVV6tXQ2BPCE1s4v1eM4I/xxNefBbjYxI8FMA2kcZ1BgrE2m0eXMq7vsIoBr
	NPxdZz3BfOHt8Ook3/K0LiUSD+1HXyXWC1vBNU9YSWiiOMbYbXMtAUmcvLk27jmzdOblaPvLd8xUP
	R7Re2dQ/13Tf+J43fyfuRp8BUFsYlFsKr1tlPNWOaDFW35k8HJ1x8MXaqvhLP6ql7pVDwzKnpPMZI
	jGZr9pPg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcln-00000001as0-3JlZ;
	Thu, 28 Nov 2024 11:33:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 16BF4300271; Thu, 28 Nov 2024 12:33:15 +0100 (CET)
Date: Thu, 28 Nov 2024 12:33:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
Message-ID: <20241128113315.GB12500@noisy.programming.kicks-ass.net>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241122113409.GV24774@noisy.programming.kicks-ass.net>
 <CAEf4BzYa5_jOhY3oDgJ-R4jhX7K+EmhcKQAt0VdDeNnpXicJ4g@mail.gmail.com>
 <20241128112734.GD35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128112734.GD35539@noisy.programming.kicks-ass.net>

On Thu, Nov 28, 2024 at 12:27:34PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 26, 2024 at 10:12:57AM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 22, 2024 at 3:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
> > > > This patchset adds 2 kfuncs to provide a way to precisely measure the
> > > > time spent running some code. The first patch provides a way to get cpu
> > > > cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
> > > > architecture it is effectively rdtsc_ordered() function while on other
> > > > architectures it falls back to __arch_get_hw_counter(). The second patch
> > > > adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
> > > > constants discovered by kernel. The main use-case for this kfunc is to
> > > > convert deltas of timestamp counter values into nanoseconds. It is not
> > > > supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
> > > > JIT version is done for x86 for now, on other architectures it falls
> > > > back to slightly simplified version of vdso_calc_ns.
> > >
> > > So having now read this. I'm still left wondering why you would want to
> > > do this.
> > >
> > > Is this just debug stuff, for when you're doing a poor man's profile
> > > run? If it is, why do we care about all the precision or the ns. And why
> > > aren't you using perf?
> > 
> > No, it's not debug stuff. It's meant to be used in production for
> > measuring durations of whatever is needed. Like uprobe entry/exit
> > duration, or time between scheduling switches, etc.
> > 
> > Vadim emphasizes benchmarking at scale, but that's a bit misleading.
> > It's not "benchmarking", it's measuring durations of relevant pairs of
> > events. In production and at scale, so the unnecessary overhead all
> > adds up. We'd like to have the minimal possible overhead for this time
> > passage measurement. And some durations are very brief,
> 
> You might want to consider leaving out the LFENCE before the RDTSC on
> some of those, LFENCE isn't exactly cheap.
> 
> > so precision
> > matters as well. And given this is meant to be later used to do
> > aggregation and comparison across large swaths of production hosts, we
> > have to have comparable units, which is why nanoseconds and not some
> > abstract "time cycles".
> > 
> > Does this address your concerns?
> 
> Well, it's clearly useful for you guys, but I do worry about it. Even on
> servers DVFS is starting to play a significant role. And the TSC is
> unaffected by it.
> 
> Directly comparing these numbers, esp. across different systems makes no
> sense to me. Yes putting them all in [ns] allows for comparison, but
> you're still comparing fundamentally different things.
> 
> How does it make sense to measure uprobe entry/exit in wall-clock when
> it can vary by at least a factor of 2 depending on DVFS. How does it
> make sense to compare an x86-64 uprobe entry/exit to an aaargh64 one?
> 
> Or are you trying to estimate the fraction of overhead spend on
> instrumentation instead of real work? Like, this machine spends 5% of
> its wall-time in instrumentation, which is effectively not doing work?
> 
> The part I'm missing is how using wall-time for these things makes
> sense.
> 
> I mean, if all you're doing is saying, hey, we appear to be spending X
> on this action on this particular system Y doing workload Z (irrespecive
> of you then having like a million Ys) and this patch reduces X by half
> given the same Y and Z. So patch must be awesome.
> 
> Then you don't need the conversion to [ns], and the DVFS angle is more
> or less mitigated by the whole 'same workload' thing.
> 
> 

Anyway, latest patches are functionally good and Changelogs are fair.



