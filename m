Return-Path: <bpf+bounces-42592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50759A6363
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAEA1C21C36
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9881E7C06;
	Mon, 21 Oct 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L8K452Ew"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22A1E47A8;
	Mon, 21 Oct 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506719; cv=none; b=sb+G2p+JhpvLR8IwWcctVgGz7wA2zFOtmxR90lpWfyh3BTbWDGrj/fX1GCIkwiACvFXv+unBON3J/PqcePrAYQJR0URN1b91lcPYG9psinBreXGIQKDmvpfYtBmGsRASADar9ys8bf0CFfcOSZuVODYnew8plT/bynE8vXSYhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506719; c=relaxed/simple;
	bh=YZCUVyUfC9oHB1G3sSi+PNeE6ieKKL19wAfEIPQup68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKxd9lZOIT/0LGwYFGAxIXqCISMEr62SdHNg6S1S6tm3Y26Q8GGUVTusJBf5fDMFC4YhZl6kO2gfc5Ats6mVbtWT30tJMJoWgH8UJLTEYMa9TG+jA5EvoLV657RBs+ApyCy+O14i6ktb/MV0SgyLNVnCFGzdNT5bxKvHWhCvyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L8K452Ew; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wi9e0+QnD1dTbzyWBEfkmQr/IejLdT70yHhTQuDJUYc=; b=L8K452Ewo82ZQfKAONe56ZGczR
	22Yv4qFuuagkbhjGhDEgrCLL7cGoAXgtMs4a0H52VGFEdTmbECF5lUvTdXJ2hAUcn9vloNnLBwaEx
	6511cxJ7EY72BqI3paOA8f+1gDgARpZnCvXHFEUFinMcFAHjH/W19QNU7dnBjdVqNq9CgugNJXhGO
	BjQRxYQcCa6IicjOiOCvxRl8nvtc1yuFa7lfSMDvD0PTnOXl6ETALMDXADZG+FQcO9Zxj0j7W+Qqh
	rWQbhB6LAAfm04mHFjn6/eTiLKREofnu5zcjbAbfZkwwSEm4AGQNfCC2IMsTey6uw2UF6t8ki4RO5
	vekOssQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2phY-00000007t8k-3IUM;
	Mon, 21 Oct 2024 10:31:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00A4830073F; Mon, 21 Oct 2024 12:31:51 +0200 (CEST)
Date: Mon, 21 Oct 2024 12:31:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 1/2] uprobes: allow put_uprobe() from
 non-sleepable softirq context
Message-ID: <20241021103151.GB6791@noisy.programming.kicks-ass.net>
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-2-andrii@kernel.org>
 <20241018082605.GD17263@noisy.programming.kicks-ass.net>
 <CAEf4Bzb3xjTH7Qh8c_j95jEr4fNxBgG11a0sCe4hoF9chwUtYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb3xjTH7Qh8c_j95jEr4fNxBgG11a0sCe4hoF9chwUtYg@mail.gmail.com>

On Fri, Oct 18, 2024 at 11:22:00AM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 18, 2024 at 1:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 07, 2024 at 05:25:55PM -0700, Andrii Nakryiko wrote:
> > > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> > > makes it unsuitable to be called from more restricted context like softirq.
> >
> > This is delayed_uprobe_lock, right?
> 
> Not just delated_uprobe_lock, there is also uprobes_treelock (I forgot
> to update the commit message to mention that). Oleg had concerns (see
> [0]) with that being taken from the timer thread, so I just moved all
> of the locking into deferred work callback.
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240915144910.GA27726@redhat.com/

Right, but at least that's not a sleeping lock. He's right about it
needing to become a softirq-safe lock though. And yeah, unfortunate
that.

> > So can't we do something like so instead?
> 
> I'll need to look at this more thoroughly (and hopefully Oleg will get
> a chance as well), dropping lock from delayed_ref_ctr_inc() is a bit
> scary, but might be ok.

So I figured that update_ref_ctr() is already doing the
__update_ref_ctr() thing without holding the lock, so that lock really
is only there to manage the list.

And that list is super offensive... That really wants to be a per-mm
rb-tree or somesuch.

AFAICT the only reason it is a mutex, is because doing unbouded list
iteration under a spinlock is a really bad idea.

> But generally speaking, what's your concern with doing deferred work
> in put_uprobe()? It's not a hot path by any means, worst case we'll
> have maybe thousands of uprobes attached/detached.

Mostly I got offended by the level of crap in that code, and working
around crap instead of fixing crap just ain't right.


