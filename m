Return-Path: <bpf+bounces-34252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EC92BE37
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F90A283575
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AA19D08B;
	Tue,  9 Jul 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apdInNBv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719615DBB9;
	Tue,  9 Jul 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538699; cv=none; b=lz+j8B/I+VQxLDlCZFuuxyV2zak4iomqHQZCCIzJZIWctvI3a12nFssoiZ2UbQtjo++TIMix4zBJ9KsoE/XO6h7oLur0tcbAZdTvE/FUZiJnXWu/JhRhPwZf1DhknT/Z+T9w5hKpDdvFc1anD0F98Ptq4nOWomF4dBIuR8sFkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538699; c=relaxed/simple;
	bh=KNkZbUwSlqEmh/z0WRKnLBiclEyIv6ls2iL1AIaVSSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bugc/QZraV4fEPvVsjj5Bo8A/CdUgGkO2zVMk600e4dXAXilvsX3c8AhIDdFk14E88AO4IMNEMrl0upD23zTA3mWCn2B+Km4t9Sk+RqmkVWETXjO0rMssljJPzxag821LrKJTm+aRucenVLumD1jhYiijROdLLv5UGtPaODPs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=apdInNBv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fjVeGE1OLoB2Eq+rEKI8bISKfyflaQTlJGLTX0ZJU9c=; b=apdInNBv46Upf7hXn8/dgXQmHI
	ltlJyq23ueDKldEZlXq71hpJvFV4JAnA07eSwux7ILhy2/1BWhA+J5klJqYN10zyopd32r7ijth6z
	fCE2elsCyYXeZY4KqXg9TebllwxCfnIeOh6L1aBzeloof+yYyLaoYPLOhZ7JBoDSiBYqmJ4oFYreY
	l4jDjvH235uxXb6MgwbNkyUYeV0PB0CShmdTDQDANxN2LJpnJS2i4jm9EcZcvmdmW0VTPbFsLej9J
	wF1ine9jkQmRXGjXYNPE6OBcUYLs992/TrEmHk0IIoX6TIfP53B8h0Q4aTLFmmKOGrJl3Ox8CG/a6
	Tk+isafg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCi0-00000000lVl-2udR;
	Tue, 09 Jul 2024 15:24:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 558343006B7; Tue,  9 Jul 2024 17:24:48 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:24:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240709152448.GQ27299@noisy.programming.kicks-ass.net>
References: <20240708231127.1055083-1-andrii@kernel.org>
 <20240709101133.GI27299@noisy.programming.kicks-ass.net>
 <20240709231017.e8d5a37c96d126d1f7591a0e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709231017.e8d5a37c96d126d1f7591a0e@kernel.org>

On Tue, Jul 09, 2024 at 11:10:17PM +0900, Masami Hiramatsu wrote:
> On Tue, 9 Jul 2024 12:11:33 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> > > +#ifdef CONFIG_UPROBES
> > > +/*
> > > + * Heuristic-based check if uprobe is installed at the function entry.
> > > + *
> > > + * Under assumption of user code being compiled with frame pointers,
> > > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > > + *
> > > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> > > + * If we get this wrong, captured stack trace might have one extra bogus
> > > + * entry, but the rest of stack trace will still be meaningful.
> > > + */
> > > +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> > > +{
> > > +	struct arch_uprobe *auprobe;
> > > +
> > > +	if (!current->utask)
> > > +		return false;
> > > +
> > > +	auprobe = current->utask->auprobe;
> > > +	if (!auprobe)
> > > +		return false;
> > > +
> > > +	/* push %rbp/%ebp */
> > > +	if (auprobe->insn[0] == 0x55)
> > > +		return true;
> > > +
> > > +	/* endbr64 (64-bit only) */
> > > +	if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
> > > +		return true;
> > 
> > I meant to reply to Josh suggesting this, but... how can this be? If you
> > scribble the ENDBR with an INT3 things will #CP and we'll never get to
> > the #BP.
> 
> Hmm, kprobes checks the instruction and reject if it is ENDBR.
> Shouldn't uprobe also skip the ENDBR too?

Should, yes, but I can't find in a hurry if we actually do.

