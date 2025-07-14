Return-Path: <bpf+bounces-63149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D41B03ACE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684CF171B1F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64419246766;
	Mon, 14 Jul 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVa0mi2l"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB1212B0A;
	Mon, 14 Jul 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485296; cv=none; b=AwUCqbmmiTEDktkpalSA/Gv7qY4JoYGa9WQe3lF1Wj01VAbZYzLRwV3hv8zXFzbft8lU/D34C20YzOk3Ig92DvsLsJgfd+9sTQYkkuyZJ/Ng+ikFgZM2UyFQMlEZ+kFr5x9+L9qQprrYaC3fy0qOh1fX7FxCkfvvbYSN0zMV6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485296; c=relaxed/simple;
	bh=UcGM+zBFfw5hApwah6zCu1OJfPm12qB4yHjkJ8OcAtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqT/vBItuzBYNKBAuwRNuc5v3HWmzhBxnl1oyHcqiCCuI7bn10AbyH5pPj/RHvi0Q4mGTzSvCPe55IDqk0wOSVx74R7dyACPsYiz2ilNy29pUDxmNCf4G9jXMfhnm5cuRwbnAI3wqz1KCvY5qVhk3AG244RK1iHX/ruJX18VSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LVa0mi2l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oDAyTOzytm/Ta/FCvQ1KMe4l1S86teoK1jORJP55q8Q=; b=LVa0mi2luNxhsJs1QHoxek2DPX
	+p3hh2IySqfU948rK7gdr1MRZ15evr6BkkLoWJMsXEVNyd55elX3LAiOaxLxE/r3vNJpOIhneCijj
	Nr4Q4EHt00mxR0JLoQ9S/TQc1n11/aLaqfRaOk5f3Upb6u3AmWPhFsPdOBsoQQIrh/p3mpl75LV/P
	sHHPxNeIaBrN1f+aYJ/lBaDxcIc4VfukITgu73VwOSDKeqEnEgIrr9KUgaz1y/YfF1vcxGRg0CRAL
	el7BXSsdm+qTMLMVKHYtcjpwrPS0mVQU2AgKoki726pACEFeNnbNdpLno3symRvDPRIV6MyImbRh6
	Hh3th5Yw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFTe-00000009jyN-3KVu;
	Mon, 14 Jul 2025 09:28:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6D153001AA; Mon, 14 Jul 2025 11:28:01 +0200 (CEST)
Date: Mon, 14 Jul 2025 11:28:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <20250714092801.GO905792@noisy.programming.kicks-ass.net>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-10-jolsa@kernel.org>
 <20250714173915.b9edd474742de46bcbe9c617@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714173915.b9edd474742de46bcbe9c617@kernel.org>

On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:

> > +SYSCALL_DEFINE0(uprobe)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	unsigned long ip, sp, ax_r11_cx_ip[4];
> > +	int err;
> > +
> > +	/* Allow execution only from uprobe trampolines. */
> > +	if (!in_uprobe_trampoline(regs->ip))
> > +		goto sigill;
> > +
> 
> /*
>  * When syscall from the trampoline, including a call to the trampoline
>  * the stack will be shown as;
>  *  regs->sp[0]: [rax]
>  *          [1]: [r11]
>  *          [2]: [rcx]
>  *          [3]: [return-address] (probed address + sizeof(call-instruction))
>  *
>  * And the `&regs->sp[4]` should be the `sp` value when probe is hit.
>  */
> 
> > +	err = copy_from_user(ax_r11_cx_ip, (void __user *)regs->sp, sizeof(ax_r11_cx_ip));
> > +	if (err)
> > +		goto sigill;
> > +
> > +	ip = regs->ip;
> > +
> > +	/*
> > +	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
> > +	 * - adjust ip to the probe address, call saved next instruction address
> > +	 * - adjust sp to the probe's stack frame (check trampoline code)
> > +	 */
> > +	regs->ax  = ax_r11_cx_ip[0];
> > +	regs->r11 = ax_r11_cx_ip[1];
> > +	regs->cx  = ax_r11_cx_ip[2];
> > +	regs->ip  = ax_r11_cx_ip[3] - 5;
> > +	regs->sp += sizeof(ax_r11_cx_ip);
> > +	regs->orig_ax = -1;
> > +

Would not a structure be more natural?

/*
 * See uprobe syscall trampoline; the call to the trampoline will push
 * the return address on the stack, the trampoline itself then pushes
 * cx, r11 and ax.
 */
struct uprobe_syscall_args {
	unsigned long ax;
	unsigned long r11;
	unsigned long cx;
	unsigned long retaddr;
};

	err = copy_from_user(sys_args, (void __user *)regs->sp, sizeof(sys_args));
	if (err)
		goto sigill;

	ip = regs->ip;

	regs->ax  = sys_args->ax;
	regs->r11 = sys_args->r11;
	regs->cx  = sys_args->cx;
	regs->ip  = sys_args->retaddr - CALL_INSN_SIZE;
	regs->sp += sizeof(sys_args);

etc.. ?

