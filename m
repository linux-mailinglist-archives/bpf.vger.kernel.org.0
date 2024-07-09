Return-Path: <bpf+bounces-34247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB392BD20
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107F71F222FF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4319E7E2;
	Tue,  9 Jul 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxzu8OwO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0319CCEC;
	Tue,  9 Jul 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535802; cv=none; b=VmooLimx1VSjs0rZ98Hy4F8ZrROa1hHdXnV0uqyetxraDiBkij9rgfpLt7izP9e1aqulEDo73f9HIlPd7BEPjFrUfjCPn6LyUdVU1XOMdSWEknUVVA5RLUBmlaGsvLzX3bNk6OC8GEUNjbbJgqB8EzDTfuBUKC9tMKWP/8HS1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535802; c=relaxed/simple;
	bh=Ov0srpBaT9P15rCvWPd9Vp2vvzJ/AjJaoZJNDs6J6Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFQJ2Uez0KJmt05pSsAtXj7qDyO0LCWdckwq0yODiTxnNKzz6JX7I4Ktg1Cdqw95z1rTwzwfjHwfNUKktW7mFtJGQXNW3aR2+D3bdzL2kGoZW+/wEQ/GVMamrRB/UC6fBsOGs7dKBpYpvswHvhKoVQgpHPY8YtZVE6GEnb6/7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxzu8OwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C04FC3277B;
	Tue,  9 Jul 2024 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720535802;
	bh=Ov0srpBaT9P15rCvWPd9Vp2vvzJ/AjJaoZJNDs6J6Nk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Sxzu8OwOAP96QOFwzBZHiirYoWrVK6UmthfDyhKxbpNyKZz56vcwjz8f+5FJLR9Xv
	 9Q+N67iVPo8jeKGHj+xyGeseGti2ceLQWLbSGA8uJ2WO9br8ADZ8I8RQ7DDeD883Q+
	 u8FCJdmsUryJJZ3SLMutvGdzn5n0jkALLGBk0Y1KTzZAf5+dPirIFbUn8XrsFARWtV
	 rzy+1LutSWbX4Qtru4d87/b4cdZ1Us9GqDwpxKwL7tPXHc606iH8A4hkeqUmZkfBU8
	 uRHygDY8DFRTtk9VOgiVF45Q/4DaNuTpUPCbZaTWH4i4TE+QNRnyLufNVDjyzOB89M
	 znZVFO420Wr3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE8B5CE09F8; Tue,  9 Jul 2024 07:36:41 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:36:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <445aed81-a845-4f5d-8b20-70eced3ce4f8@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> > > 
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
> 
> Per VMA refcounts or per VMA locks are a complete fail IMO.

Not even to allow concurrent updates of the address space by different
threads of a process?

For me, per-VMA locking's need to RCU-protect the VMA is a good step
towards permitting RCU-protected scans of the Maple Tree, which then
gets lockless lookup.

> I suppose I should go dig out the latest versions of those patches to
> see where they're at :/

It would not be a bad thing to get another set of eyes on it.

							Thanx, Paul

