Return-Path: <bpf+bounces-22223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF685943F
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 03:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E12830A4
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F94C8B;
	Sun, 18 Feb 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM7W6DOu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B644C61;
	Sun, 18 Feb 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224815; cv=none; b=E1z04ahW74ws/CmtgnuFlDxzfqloV7QprC4/MibyDh1gPkdhTzlFIH9f0K69Sxu5cVouP+RBoCAJctLapcC/LFNLSihDRXmi/2+gh2uSBkAr45JykkFHBtKDFyf8lsKwkNVdsQHEt1aCRRBg6s331SmO/8Vo8GIKHX+U3ZNu9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224815; c=relaxed/simple;
	bh=Z6mSyCCU4tKcRX0vOZ8fMtCaGQGjTOctfFH1c8VECVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hXu6oSP3tr+2cmX1sr46kri+5nwddqaTn69WoISPq0uolGVvuswcee5sVVt4MOnjBADtDAVG8KkBnfi7oyjcLJwYqElFeiaGLFELUEasfvTalZk878x75FhoxUW89WD38zFnJ5ePaohfVySlI6zGMv28cGcC7e4v8YfuYo7V2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM7W6DOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951ECC433F1;
	Sun, 18 Feb 2024 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708224814;
	bh=Z6mSyCCU4tKcRX0vOZ8fMtCaGQGjTOctfFH1c8VECVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AM7W6DOuPWCM8nwpxebXPBIStYkl1tK/Wg4hetT/X071PhOMwYVQPEkERxaH5/tYc
	 OUwTejTp0QjRbQ4rA1PdgmMmykoapOuLzu7gjdb6y1PctfkjY4shg4sz7Rr6UmO0Hx
	 gvYASVXqqGF/3S2lGHxKWWTtBzS6PpWphC2O0HMS52RLsLYhIIff1E/BunynmkVmKf
	 joY+ua8+hAEY4DTcFelL5fM2vUhtzljgip7hPUCXUZoX4wqAUTm4pbr5s8HTBMwwaF
	 Hn3pJUZ2uOwrSRHMs12Ie98tCU7Fw0PpT0KoURm7FRbMJm/GDJ2pgE0LpoV17x4osM
	 n2waArNVXvXFA==
Date: Sun, 18 Feb 2024 11:53:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 23/36] function_graph: Add a new exit handler with
 parent_ip and ftrace_regs
Message-Id: <20240218115328.c95bfe7001b7260071e6b674@kernel.org>
In-Reply-To: <20240216175108.79a256a20c89ed1d672c7e14@kernel.org>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
	<20240215110404.4e8c5a94@gandalf.local.home>
	<20240216175108.79a256a20c89ed1d672c7e14@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 17:51:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > @@ -798,10 +798,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> > >  
> > >  	*index += FGRAPH_RET_INDEX;
> > >  	*ret = ret_stack->ret;
> > > -	trace->func = ret_stack->func;
> > > -	trace->calltime = ret_stack->calltime;
> > > -	trace->overrun = atomic_read(&current->trace_overrun);
> > > -	trace->depth = current->curr_ret_depth;
> > 
> > There's a lot of information stored in the trace structure. Why not pass
> > that to the new retregfunc?
> > 
> > Then you don't need to separate this code out.
> 
> Sorry, I couldn't catch what you meant, Would you mean to call
> ftrace_pop_return_trace() before calling retregfunc()?? because some of the
> information are found from ret_stack, which is poped from shadow stack.

Ah, sorry I got what you said. I think this `trace` is not usable for the new
interface. Most of the information is only used for the function-graph tracer.
For example, trace->calltime and trace->overrun, trace->depth are used only
for the function-graph tracer, but not for the other tracers.

But yeah, this idea is considerable. It also allows us to just update
entryfunc() and retfunc() to pass fgraph_regs and return address.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

