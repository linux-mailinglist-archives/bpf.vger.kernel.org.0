Return-Path: <bpf+bounces-18305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC8818B7A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EAF1F24D16
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902E1CABC;
	Tue, 19 Dec 2023 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEayn6jZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063D1CA9D;
	Tue, 19 Dec 2023 15:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95728C433C7;
	Tue, 19 Dec 2023 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703000747;
	bh=GcnM/9qUtAiC1oXsREg0xuwm28B5TD507+XDSxGomi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEayn6jZWrmFBgWClezgVIOZ5CYCSEBzpSLcXmNUs5mR5N+BGMDr0iAYV1ICzZ/jN
	 xPol13YhrAVCxkwldtSDFXItV9bVuIO+6iTdjlnyKnkagKypwiON0swg0HG+g8mKss
	 RDqzq1PZ81nDV/CJx7cTEg5kmnAsvmNDkXHU+ak1r0/v8trWwCYt8dPX5Tu+1CbZjq
	 pgjj9msNHdAHAv6kD9zUTTwUQt0wukgKALUQcimrE7ZrRE7Cxd4K5L5uWRENKkDODp
	 lC2POex1m/PQV9FWPUoOedLOULtm0OtiMmZgL/4fy9JcY8SPMI1dPl7kIQcjLj42tl
	 7dN2Y/H9pNoeQ==
Date: Wed, 20 Dec 2023 00:45:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 06/34] function_graph: Allow multiple users to attach
 to function graph
Message-Id: <20231220004540.0af568c69ecaf9170430a383@kernel.org>
In-Reply-To: <ZYGZWWqwtSP82Sja@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290516454.220107.14775763404510245361.stgit@devnote2>
	<ZYGZWWqwtSP82Sja@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 14:23:37 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Dec 18, 2023 at 10:12:45PM +0900, Masami Hiramatsu (Google) wrote:
> 
> SNIP
> 
> >  /* Both enabled by default (can be cleared by function_graph tracer flags */
> >  static bool fgraph_sleep_time = true;
> >  
> > @@ -126,9 +247,34 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  	calltime = trace_clock_local();
> >  
> >  	index = current->curr_ret_stack;
> > -	RET_STACK_INC(current->curr_ret_stack);
> > +	/* ret offset = 1 ; type = reserved */
> > +	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
> >  	ret_stack = RET_STACK(current, index);
> > +	ret_stack->ret = ret;
> > +	/*
> > +	 * The unwinders expect curr_ret_stack to point to either zero
> > +	 * or an index where to find the next ret_stack. Even though the
> > +	 * ret stack might be bogus, we want to write the ret and the
> > +	 * index to find the ret_stack before we increment the stack point.
> > +	 * If an interrupt comes in now before we increment the curr_ret_stack
> > +	 * it may blow away what we wrote. But that's fine, because the
> > +	 * index will still be correct (even though the 'ret' won't be).
> > +	 * What we worry about is the index being correct after we increment
> > +	 * the curr_ret_stack and before we update that index, as if an
> > +	 * interrupt comes in and does an unwind stack dump, it will need
> > +	 * at least a correct index!
> > +	 */
> >  	barrier();
> > +	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
> > +	/*
> > +	 * This next barrier is to ensure that an interrupt coming in
> > +	 * will not corrupt what we are about to write.
> > +	 */
> > +	barrier();
> > +
> > +	/* Still keep it reserved even if an interrupt came in */
> > +	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
> 
> seems like this was set already few lines above?

Yeah, there is a trick (trap) for interrupts between writes. We can not do
atomically write the last stack entry and increment stack index. But it must
be done for shadow unwinding insinde interrupts. Thus,

(1) write a reserve type entry on the new stack entry
(2) increment curr_ret_stack to the new stack entry
(3) rewrite the new stack entry again

If an interrupt happens between (1) and (2), stack unwinder can find the
correct latest shadow stack frame from the curr_ret_stack. This interrupts
can store their shadow stack so... wait something went wrong.

If the interrupt *overwrites* the shadow stack and (3) recovers it,
if another interrupt before (3), the shadow stack will be corrupted...

OK, I think we need a "rsrv_ret_stack" index. Basically new one will do;

(1) increment rsrv_ret_stack
(2) write a reserve type entry
(3) set curr_ret_stack = rsrv_ret_stack

And before those,

(0) if rsrv_ret_stack != curr_ret_stack, write a reserve type entry at
    rsrv_ret_stack for the previous frame (which offset can be read
    from curr_ret_stack)

Than it will never be broken.
(of course when decrement curr_ret_stack, rsrv_ret_stack is also decremented)

Thank you,

> 
> jirka
> 
> > +
> >  	ret_stack->ret = ret;
> >  	ret_stack->func = func;
> >  	ret_stack->calltime = calltime;
> > @@ -159,6 +305,12 @@ int function_graph_enter(unsigned long ret, unsigned long func,
> >  			 unsigned long frame_pointer, unsigned long *retp)
> >  {
> >  	struct ftrace_graph_ent trace;
> > +	int offset;
> > +	int start;
> > +	int type;
> > +	int val;
> > +	int cnt = 0;
> > +	int i;
> >  
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  	/*
> 
> SNIP
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

