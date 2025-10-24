Return-Path: <bpf+bounces-72103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681EC06A16
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BA819A41D7
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102F31E11F;
	Fri, 24 Oct 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+blk7eJ"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1752DEA6A;
	Fri, 24 Oct 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314913; cv=none; b=cj6hwmwu7nM1n0KnBYsTsfah42ibSIAFlFOd+7HdPqnSxXOmBe+9r69QdZInIslT8rJ+Yjo9pvdlUJNEwp95BgAjOAiWcuN2nOgXBxRq91cqs4rJ5l8Fq0Z/Ug2Nlq2xOc5xtTrw4RrvdYpV50S6jggXvuJbTv265+9a0F50HsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314913; c=relaxed/simple;
	bh=3n6Mg9W03EyoIK8pagxfBsueUo1hZrfz9Lq0Z8X3N7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxBJ9kaTjEdsbu7lLbbi42IQX/Sdmkm0xThLzxktozvMCWhfhrQ+zsIJ+8J+hadRP9Ytg0c9iao3QuN/+6MLUugXuUViK+RAfoB+Y44vPUS2Hf9wDhQc6WFsTm78NWMAlJA9sAgNVWxi+dFQVv1sOXD+pYIpu3uyZLFSH5epGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+blk7eJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Goq8YxHBPNs6f2rYuSxbbsHycF8mgkQfSZw+JTwSmhM=; b=X+blk7eJmCwk6pY0VoWEtox47s
	gBivRCzUAGh95sLhc3XnbTW0bnWByeRIzr13TsRc7sKaSG8pQzazWgKwY2nJA7Nx/LP5gOp512BAE
	MgLCpmJEEIU8B6og849pb1XrdKiWffeAviGZyckVZxON0ct4etrkE4AMJ+edbE16raYUkeqOk5iOu
	VlcgpVDjVUkiCzvXRgKq0apJr+BQ0eOncnlNQ1qOrNSow3NWr/48LW3nu+FrVo2c1NosSmuhjkVE4
	+WLK7s8ViN2zgViEvppABvDtVXGIR4KRz2iu15x+pJtFTaI/WYuDLuO+5hrGyg9FfeWCnG/RwGcXj
	BYIu9WBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHb7-00000002Jc9-3khN;
	Fri, 24 Oct 2025 13:12:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 548A7300323; Fri, 24 Oct 2025 16:08:15 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:08:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>

On Fri, Oct 24, 2025 at 03:58:20PM +0200, Jens Remus wrote:
> Hello Peter!
> 
> On 10/24/2025 12:41 PM, Peter Zijlstra wrote:
> > On Fri, Oct 24, 2025 at 11:29:26AM +0200, Peter Zijlstra wrote:
> >> On Thu, Oct 23, 2025 at 05:00:02PM +0200, Peter Zijlstra wrote:
> >>
> >>> Trouble is, pretty much every unwind is 510 entries long -- this cannot
> >>> be right. I'm sure there's a silly mistake in unwind/user.c but I'm too
> >>> tired to find it just now. I'll try again tomorrow.
> >>
> >> PEBKAC
> > 
> > Anyway, while staring at this, I noted that the perf userspace unwind
> > code has a few bits that are missing from the new shiny thing.
> > 
> > How about something like so? This add an optional arch specific unwinder
> > at the very highest priority (bit 0) and uses that to do a few extra
> > bits before disabling itself and falling back to whatever lower prio
> > unwinder to do the actual unwinding.
> 
> unwind user sframe does not need any of this special handling, because
> it knows for each IP whether the SP or FP is the CFA base register
> and whether the FP and RA have been saved.

It still can't unwind VM86 stacks. But yes, it should do lots better
with that start of function hack.

> Isn't this actually specific to unwind user fp?  If the IP is at
> function entry, then the FP has not been setup yet.  I think unwind user
> fp could handle this using an arch specific is_uprobe_at_func_entry() to
> determine whether to use a new frame_fp_entry instead of frame_fp.  For
> x86 the following frame_fp_entry should work, if I am not wrong:
> 
> #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)	\
> 	.cfa_off	=  1*(ws),		\
> 	.ra_off		= -1*(ws),		\
> 	.fp_off		= 0,			\
> 	.use_fp		= false,
> 
> Following roughly outlines the required changes:
> 
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> 
> -static int unwind_user_next_fp(struct unwind_user_state *state)
> +static int unwind_user_next_common(struct unwind_user_state *state,
> +                                  const struct unwind_user_frame *frame,
> +                                  struct pt_regs *regs)
> 
> @@ -71,6 +83,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
>         state->sp = sp;
>         if (frame->fp_off)
>                 state->fp = fp;
> +       state->topmost = false;
>         return 0;
>  }
> @@ -154,6 +167,7 @@ static int unwind_user_start(struct unwind_user_state *state)
>         state->sp = user_stack_pointer(regs);
>         state->fp = frame_pointer(regs);
>         state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
> +       state->topmost = true;
> 
>         return 0;
>  }
> 
> static int unwind_user_next_fp(struct unwind_user_state *state)
> {
> 	const struct unwind_user_frame fp_frame = {
> 		ARCH_INIT_USER_FP_FRAME(state->ws)
> 	};
> 	const struct unwind_user_frame fp_entry_frame = {
> 		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
> 	};
> 	struct pt_regs *regs = task_pt_regs(current);
> 
> 	if (state->topmost && is_uprobe_at_func_entry(regs))
> 		return unwind_user_next_common(state, &fp_entry_frame, regs);
> 	else
> 		return unwind_user_next_common(state, &fp_frame, regs);
> }
> 
> diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
> @@ -43,6 +43,7 @@ struct unwind_user_state {
>         unsigned int                            ws;
>         enum unwind_user_type                   current_type;
>         unsigned int                            available_types;
> +       bool                                    topmost;
>         bool                                    done;
>  };
> 
> What do you think?

Yeah, I suppose that should work. Let me rework things accordingly.

