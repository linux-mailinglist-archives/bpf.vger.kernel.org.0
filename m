Return-Path: <bpf+bounces-22258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE0F85A559
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 15:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6F1F248C2
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390537162;
	Mon, 19 Feb 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jedCcVnU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7380374CB;
	Mon, 19 Feb 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351483; cv=none; b=d3Zcq2zeX/op1fV0TYyKBhgP1We4ldPGk6ax4eDOOaFBKzey/QetTzhJGuuBN7fJk56LelK3oq/AoXoAe2S5Cno+K87db8EDD97B5lLUKQPraBZNY0+9lUbtFIUBeE8GCpvb+TDUP7aM3/prMBfJOhDd7Pza33ackTZJM9Ejp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351483; c=relaxed/simple;
	bh=MIUwjUjiAAu1+q/+I/qDOmSpFjx0udf6D1AQ0UhEV0k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Moko6YmUs9VBaJe3gswYATlz21uLWzHzJd6tGzdnuR2BppuRkoK3FoAFu/0C04n3/yikxEIfBBG9xXmCoTq8wRyPz5mjx/pdA0ZRnHjlbpK3PbGCJ2QRIUGTHk1qQCNXu1komn4YBTWZrIFAvupLeXd83BFax2Yvz9i+KLLeLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jedCcVnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69997C433F1;
	Mon, 19 Feb 2024 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708351482;
	bh=MIUwjUjiAAu1+q/+I/qDOmSpFjx0udf6D1AQ0UhEV0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jedCcVnUuRu7WsgBTsb7EkozXwzEc3q772jGzsuk/FFQmz1tgYk50Mc2U2wZx/91y
	 WbyV4CYns7fJxNb3T8sbT12ZpsxAvz2UMK8HNJHAexd4YIf8Hs2kCUnCPh9LjJA5i9
	 +hn23n7mOO5tHgEfkBrZgFCR2JEFmex5DzGDmSxO+YbV1llrm+6ORSDZrT3eMEfBRX
	 agBkU5jq7zX0iCu9JbIUWEkodqBPYXRWjjT9cerlSRJrTQNy15NwcypdqVWi+pqJ0s
	 garRRcf/WFr8bICdloI03C9IvteoR/FOsb4rhi1IkfFqsHafVmJeun6ny9xToBXma0
	 5+xmyVcvS+AFA==
Date: Mon, 19 Feb 2024 23:04:35 +0900
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
Message-Id: <20240219230435.3158a36f60c20dcf2112cf0f@kernel.org>
In-Reply-To: <20240218115328.c95bfe7001b7260071e6b674@kernel.org>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
	<20240215110404.4e8c5a94@gandalf.local.home>
	<20240216175108.79a256a20c89ed1d672c7e14@kernel.org>
	<20240218115328.c95bfe7001b7260071e6b674@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

On Sun, 18 Feb 2024 11:53:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 16 Feb 2024 17:51:08 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > > @@ -798,10 +798,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> > > >  
> > > >  	*index += FGRAPH_RET_INDEX;
> > > >  	*ret = ret_stack->ret;
> > > > -	trace->func = ret_stack->func;
> > > > -	trace->calltime = ret_stack->calltime;
> > > > -	trace->overrun = atomic_read(&current->trace_overrun);
> > > > -	trace->depth = current->curr_ret_depth;
> > > 
> > > There's a lot of information stored in the trace structure. Why not pass
> > > that to the new retregfunc?
> > > 
> > > Then you don't need to separate this code out.
> > 
> > Sorry, I couldn't catch what you meant, Would you mean to call
> > ftrace_pop_return_trace() before calling retregfunc()?? because some of the
> > information are found from ret_stack, which is poped from shadow stack.
> 
> Ah, sorry I got what you said. I think this `trace` is not usable for the new
> interface. Most of the information is only used for the function-graph tracer.
> For example, trace->calltime and trace->overrun, trace->depth are used only
> for the function-graph tracer, but not for the other tracers.
> 
> But yeah, this idea is considerable. It also allows us to just update
> entryfunc() and retfunc() to pass fgraph_regs and return address.

The reason why I didn't use the those for *regfunc() is not only those
have unused information, but those does not have some params.

 - ftrace_graph_ent only have current `func`, but entryregfunc()
    needs `parent_ip` (== return address)
 - ftrace_graph_ret only have current `func`, but retregfunc()
    needs `ret` (== return address) too.

If I update the ftrace_graph_ent/ret to add 'retaddr', we can just pass
ftrace_graph_ent/ret, ftrace_regs, and fgraph_ops to *regfunc().
Moreover, maybe we don't need *regfunc, but just update entryfunc/retfunc
to pass ftrace_regs *, which will be NULL if it is not supported.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

