Return-Path: <bpf+bounces-54630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7AA6F257
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B13188DD36
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9A254AE8;
	Tue, 25 Mar 2025 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSmI4cfR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234701FC111;
	Tue, 25 Mar 2025 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902003; cv=none; b=Cr2WgSFY7NNIuo01NutuIK3acOZ577f/hJBMZvdGgJyhD0OxpQDTxn6RmhaForSbl5NsZSHLHVsLfsW+cnIjSWKZ/9wtylPCzZAPdbLiESztKdsThO+qlkEGTRZnSmzIzAb+xhEZ+Gy+1FQhsezskopCXlGedA7r4FJ/flE+4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902003; c=relaxed/simple;
	bh=17lGbFEAJ1ty/woWfnYd6oAcPxVl3pgPP0W1h/+Gop0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPjpr4Zv1WIw1ZC8V8Pc9KjJPZrRBpe2ZuCutPgRjnnnGWkd3xiaH9zIuWhESJo7jQqpO5/xcNO9qHgbxamwR1w6n32e0M9AIxZgKL+wljmpVToj6zdOjCr7xQDjTn9fjORXzzW9yHqQIoeT8LfEhJMA0ERrfo98lqiu3r3Ebjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSmI4cfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2739C4CEE4;
	Tue, 25 Mar 2025 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902002;
	bh=17lGbFEAJ1ty/woWfnYd6oAcPxVl3pgPP0W1h/+Gop0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSmI4cfRgxNxIdZ+3CF6vmFS1IeAWJ35hwV5+EXZgJUKUrLZEkoXGjFO+0FUHm/K+
	 hBSCDP59FLFdfB1y/cVroWA8zvvlJ4Hwuk66y8TMIObAyJY1oxBaVFMTmwEiwHkNPO
	 7tl5VXBHGLZwEJsLPedt9t7IjL0cM/SW1v3UEVksuo69MRP8vz50ZEY1YltbsAXmov
	 lqWSn0eGM6AUJCC+JPdWfI/ae5odoY8Mu0ulx9jLi6jXY9zEJ13xUihr5kV3HY8KR2
	 pv97MjE8CbLuj8Dq7ncnkT8SbPq9KBBf6BwtAX70VOxLOiNILxG59wN0uRsnV9KNnw
	 rTVFmivXj+qCA==
Date: Tue, 25 Mar 2025 12:26:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-KS7H6666PZ3eKv@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
 <20250324113304.GB14944@noisy.programming.kicks-ass.net>
 <Z-JsJruueRgLQ8st@gmail.com>
 <20250325103047.GH36322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325103047.GH36322@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 25, 2025 at 09:41:10AM +0100, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Mar 24, 2025 at 08:53:31AM +0100, Eric Dumazet wrote:
> > > 
> > > > BTW the atomic_cond_read_acquire() part is never called even during my
> > > > stress test.
> > > 
> > > Yes, IIRC this is due to text_poke_sync() serializing the state, as that
> > > does a synchronous IPI broadcast, which by necessity requires all
> > > previous INT3 handlers to complete.
> > > 
> > > You can only hit that case if the INT3 remains after step-3 (IOW you're
> > > actively writing INT3 into the text). This is exceedingly rare.
> > 
> > Might make sense to add a comment for that.
> 
> Sure, find below.
> 
> > Also, any strong objections against doing this in the namespace:
> > 
> >   s/bp_/int3_
> > 
> > ?
> > 
> > Half of the code already calls it a variant of 'int3', half of it 'bp', 
> > which I had to think for a couple of seconds goes for breakpoint, not 
> > base pointer ... ;-)
> 
> It actually is breakpoint, as in INT3 raises #BP. For complete confusion
> the things that are commonly known as debug breakpoints, those things in
> DR7, they raise #DB or debug exceptions.

Yeah, it's a software breakpoint, swbp, that raises the #BP trap.

'bp' is confusingly aliased (in my brain at least) with 'base pointer' 
register naming and assembler syntax: as in bp, ebp, rbp.

So I'd prefer if it was named consistently:

  text_poke_int3_batch()
  text_poke_int3_handler()
  ...

Not the current mishmash of:

  text_poke_bp_batch()
  poke_int3_handler()
  ...

Does this make more sense?

> > Might as well standardize on int3_ and call it a day?
> 
> Yeah, perhaps. At some point you've got to know that INT3->#BP and
> DR7->#DB and it all sorta makes sense, but *shrug* :-)

Yeah, so I do know what #BP is, but what the heck disambiguates the two 
meanings of _bp and why do we have the above jungle of an inconsistent 
namespace? :-)

Picking _int3 would neatly solve all of that.

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index bf82c6f7d690..01e94603e767 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2749,6 +2749,13 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  
>  	/*
>  	 * Remove and wait for refs to be zero.
> +	 *
> +	 * Notably, if after step-3 above the INT3 got removed, then the
> +	 * text_poke_sync() will have serialized against any running INT3
> +	 * handlers and the below spin-wait will not happen.
> +	 *
> +	 * IOW. unless the replacement instruction is INT3, this case goes
> +	 * unused.
>  	 */
>  	if (!atomic_dec_and_test(&bp_desc.refs))
>  		atomic_cond_read_acquire(&bp_desc.refs, !VAL);

Thanks! I stuck this into tip:x86/alternatives, with your SOB.

	Ingo

