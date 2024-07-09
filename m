Return-Path: <bpf+bounces-34258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF992BF77
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B5BB28B43
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75D19E7F6;
	Tue,  9 Jul 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pkMfWZI9"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5319E7D1;
	Tue,  9 Jul 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541450; cv=none; b=bOa0Q4Xx/ZZAiq6XXV7fxjzVlewEzNv5Et5syEaynx86BSpR9HeojFX0CYnlUw8HmJZdPFU9tBlO9b4JTI0HNq/nXxYRXeu+acNGWYLqvVHj/BwHhjL0/Qmp4sTGEaWm1/WXqPdMvp4T/XtBGXuNwhoAgtWiVITb9g0OVToajPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541450; c=relaxed/simple;
	bh=dgC6tmtgrbQlFS4J2iYnZJ7iHw/grcAUBzAVqZ6jQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+JVByKRF3pTMZw0Hh6TynMkJi9m/AHZYV66KToBHY7tpzfQFZYcWJWN3EYMaAlKKJSMPOQM1Lymz61xQliglUCd0SOk8xXzf1AzaSX0MFLAHe2HHW704tWnU9FExtpaOBpghERSWC6YmpsH4eqGFuNYJ0FdR7GUF0yTc4aSPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pkMfWZI9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LnWIqChk4eTwYt1NcOMi/u0QVSohlymD7QkWGfATE+g=; b=pkMfWZI9YY6pgUaFUThC3X3Lai
	DDNYdlTMoPovZjS1u0TxpFAhZHLmGD/vwicLPLFMrpEs045b1XsY343XZ7bOa0ZKLYmzKGFqUIuNW
	Cbk/WR/i9G2ziZiuDC8bxp+VnlDDjqgmFsSgCNSD3traCbat7oWYF3aVjcXpEbzy6knS6/X5ym7Nb
	FNhWeNWbpg53gKuB7rsYg0RoiZFKFJBFYMOSEXHHnJZGZbWAztGjfyWXOmI5Yu9mS3jPYX7kJ9O5q
	o1pPl5yLdAvveDqnKk01eb8g2Xl05U9LSZr2Fgk7TpGXOtgzLR5GksqFP4lyNpdTVh87Uj4z2y3Fm
	0S3S3Imw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDQS-0000000831E-45TG;
	Tue, 09 Jul 2024 16:10:45 +0000
Date: Tue, 9 Jul 2024 17:10:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709142943.GL27299@noisy.programming.kicks-ass.net>

On Tue, Jul 09, 2024 at 04:29:43PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 09, 2024 at 07:11:23AM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 09, 2024 at 11:01:53AM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> > > 
> > > > Quick profiling for the 8-threaded benchmark shows that we spend >20%
> > > > in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> > > > that's what would prevent uprobes from scaling linearly. If you have
> > > > some good ideas on how to get rid of that, I think it would be
> > > > extremely beneficial. 
> > > 
> > > That's find_vma() and friends. I started RCU-ifying that a *long* time
> > > ago when I started the speculative page fault patches. I sorta lost
> > > track of that effort, Willy where are we with that?

Probably best to start with lock_vma_under_rcu() in mm/memory.c.

> > > Specifically, how feasible would it be to get a simple RCU based
> > > find_vma() version sorted these days?
> > 
> > Liam's and Willy's Maple Tree work, combined with Suren's per-VMA locking
> > combined with some of Vlastimil's slab work is pushing in that direction.
> > I believe that things are getting pretty close.
> 
> So I fundamentally do not believe in per-VMA locking. Specifically for
> this case that would be trading one hot line for another. I tried
> telling people that, but it doesn't seem to stick :/

SRCU also had its own performance problems, so we've got problems one
way or the other.  The per-VMA lock probably doesn't work quite the way
you think it does, but it absoutely can be a hot cacheline.

I did propose a store-free variant at LSFMM 2022 and again at 2023,
but was voted down.  https://lwn.net/Articles/932298/

I don't think the door is completely closed to a migration to that,
but it's a harder sell than what we've got.  Of course, data helps ...

> Per VMA refcounts or per VMA locks are a complete fail IMO.
> 
> I suppose I should go dig out the latest versions of those patches to
> see where they're at :/

Merged in v6.4 ;-P

