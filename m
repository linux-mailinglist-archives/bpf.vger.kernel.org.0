Return-Path: <bpf+bounces-46514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B209EB2E2
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F49281774
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D461AAA38;
	Tue, 10 Dec 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxPCTBLi"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D71AA1D9
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840059; cv=none; b=mZtiK6+t+T5hxi5DuLtJMR9SnCfSP+4PzL6ybRL75NmliGLDP8e78KD7YMgLLdUR1MrNOL9xu+dLmWcMOaw9Zlr+8Lxbz5XsJZ2UCPsiyOMeAsg9elUdQzhD7GlkaqRPlYuRjkhIcZj7veKfnPwRQR5ui8LRPKs0e+mEmcxX+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840059; c=relaxed/simple;
	bh=UrSPzPHHDB9v9w7hpzXGmoVMLtkLyKlzUMarigCagdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD8T3VmpFOpvGrmcXXdanu1KfNHo5QzSDSekmsA3meHQEmo7xovA2vTpdWOIu1PDlyd/nXOp7jH6wKyLLyba9eYwJD0xcvFtUl4wZQEhwgVjgYB8jHwBcABLLztruKmdoRzLqEed0oWffY0QgqTmA4J0usfJ+AK5UJe4G/HnXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxPCTBLi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ASWkrN0/ze08wbmgUD4WHloG48XWx6MGaMC09Q1fcxg=; b=SxPCTBLiL6ViF2SvLOluHbKNMF
	jIAeISBt+86vL79NiDCDWKtsDod+ARvkj0r6SsrryYaXjhvQN7bxT4ubSsos9ZpVagVN4mXLVdzhr
	GKicxnh+J+Ys+FhZHVY+339KYE6GV7qemy+eAkVXuzjSMnmxdAZuKpEaxFwrGKF1a3v0zoiFryZZc
	0AcqXCsfY6ZXZ236okIFO3MeGD6mwujWFGa4tSL3kmt8zAZE7ThYbocJJny2SWjjDDgglmBZXrulG
	gLe5UnqFgeSpyHx9rWNMy0KmkSbLXMU9/6eng+/EF8q1e/aYUht8cmDAme4REO4DT1n/Mm5mcV7Xz
	VQ8P7aig==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL109-00000003h13-37aB;
	Tue, 10 Dec 2024 14:14:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4ED7E30035F; Tue, 10 Dec 2024 15:14:13 +0100 (CET)
Date: Tue, 10 Dec 2024 15:14:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Saqib <usama.saqib@datadoghq.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
	bigeasy@linutronix.de, torvalds@linux-foundation.org
Subject: Re: BPF and lazy preemption.
Message-ID: <20241210141413.GT35539@noisy.programming.kicks-ass.net>
References: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
 <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com>

On Tue, Dec 10, 2024 at 02:25:20PM +0100, Usama Saqib wrote:
> [ Adding x86 / scheduler folks to Cc given PREEMPT_LAZY as-is would cause
>   serious regressions for us. ]
> 
> On 11/18/24 10:14 AM, Usama Saqib wrote:
> > Hello,
> >
> > I hope everyone is doing well. It seems that work has started to
> > introduce a new preemption model in the linux kernel PREEMPT_LAZY [1].
> > According to the mailing list, the maintainers intend for this to
> > replace PREEMPT_NONE and PREEMPT_VOLUTARY as the default preemption
> > model.
> >
> >  From the changeset, it looks like PREEMPT_LAZY allows
> > irqentry_exit_cond_resched() to get called on IRQ exit. This change,
> > similar to PREEMPT_FULL, can get two bpf programs attached to a kprobe
> > or tracepoint running in user context, to nest. This currently causes
> > the nesting program to miss. I have been able to get these misses to
> > happen on top of this new patch.
> >
> > This behavior is currently not possible with the default preemption
> > model used in most distributions, PREEMPT_VOLUNTARY. For many products
> > using BPF for tracing/security, this would constitute a regression in
> > terms of reliability.
> >
> > My question is whether there is any ongoing work to fix this behavior
> > of kprobes and tracepoints, so they do not miss on nesting. I have
> > previously been told that there is ongoing work related to
> > bpf-specific spinlocks to resolve this problem [2]. Will that be
> > available by the time this is merged into the mainline, and the
> > current defaults deprecated?

I have no idea about the whole BPF thing, but if behaviour is as
PREEMPT_FULL, then there is nothing to fix from a scheduler PoV.

Note that most distros already build with PREEMPT_DYNAMIC, which allows
users/admins to dynamically select the preemption model (either at boot
or at runtime through debugfs).

If certain BPF stuff cannot deal with full preemption, then I would have
to call it broken.

