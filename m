Return-Path: <bpf+bounces-69122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C418B8D492
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 06:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E26189F9A6
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474C29B781;
	Sun, 21 Sep 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTzrlsCR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4D1798F;
	Sun, 21 Sep 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427526; cv=none; b=BJn7w6lk0nL7czQ7lt6dbqEpsU2jG8bK1qPc695h3iFYsNfdVdL4aiTlAIxR9LvCMlJkB2hKuA7DsVJgw4+oRjDQdjAarzW6e5gNj4bdGR64DgfVq30Jo/9mre9GCHYd9ensg3Wk0Tc3LY4QzzhoQ/UcqFgdd+vccLalA1nqBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427526; c=relaxed/simple;
	bh=p/DpiLcskujOfJ4phkL3TIVWHJKpea3P2LvnmymfsLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tOieJkSMXFspAeiQnuDZ3kowoexUbmjznwOBkT3Ko3OQaYM5WDt55FmlkiADM/g7t8kIC0N6/qdVeGVQ7t1Y7sEQNkxd42c3N8pbAy86Q5n1mME54gkwV914rF/A0mp/hH0o9fTkvXRFv0Q2v3pynWHpYN6G2OEMupR3rnWNe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTzrlsCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A383DC4CEE7;
	Sun, 21 Sep 2025 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758427525;
	bh=p/DpiLcskujOfJ4phkL3TIVWHJKpea3P2LvnmymfsLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pTzrlsCRJTCj7GPHUJAsdnA34PvI2QnLRIQlYrtcGRHVa4Bx3/kwTTRORCD8BBb1h
	 tOJpWCNo69hOdtypTqzXsvD0dSSoJD+IizoejsyPScoIB7cUQSHfm6xlzMqCFd9Ebc
	 tBmG5yKDqWoe1JpePWRxLgnFBZE5kGrTBxATeQwd6eIRJc7fOysSEDqorccCYSQp1+
	 KDwI0f5RcXOS4fh4FamK77sGfLuQg+mcA4kglS+KFlt8VebnC6XnwIcYGeYAo2w4sG
	 4C81jAdIn8dB1SXnj+R3HImkuUIbIEK5ibPUZa44JjtwzVSAZQKUf4YfngWV34lJFW
	 lNcKkjx4cpqfw==
Date: Sun, 21 Sep 2025 13:05:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-Id: <20250921130519.d1bf9ba2713bd9cb8a175983@kernel.org>
In-Reply-To: <20250919112746.09fa02c7@gandalf.local.home>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<20250919112746.09fa02c7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 11:27:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 19 Sep 2025 20:57:36 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > function_graph_enter_regs() prevents itself from recursion by
> > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > which is called at the exit, does not prevent such recursion.
> > Therefore, while it can prevent recursive calls from
> > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > This can lead an unexpected recursion bug reported by Menglong.
> > 
> >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> >   -> kprobe_multi_link_exit_handler -> is_endbr.  
> 
> So basically its if the handler for the return part calls something that it
> is tracing, it can trigger the recursion?
> 
> > 
> > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > this section must prevent recursive call of fgraph inside user-defined
> > fgraph_ops::retfunc().
> > 
> > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > fprobe on function-graph tracer"), because before that fgraph was
> > only used from the function graph tracer. Fprobe allowed user to run
> > any callbacks from fgraph after that commit.
> 
> I would actually say it's because before this commit, the return handler
> callers never called anything that the entry handlers didn't already call.
> If there was recursion, the entry handler would catch it (and the entry
> tells fgraph if the exit handler should be called).
> 
> The difference here is with fprobes, you can have the exit handler calling
> functions that the entry handler does not, which exposes more cases where
> recursion could happen.
> 
> > 
> > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fgraph.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 1e3b32b1e82c..08dde420635b 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	unsigned long bitmap;
> >  	unsigned long ret;
> >  	int offset;
> > +	int bit;
> >  	int i;
> >  
> >  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	if (fregs)
> >  		ftrace_regs_set_instruction_pointer(fregs, ret);
> >  
> > +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> > +	/*
> > +	 * This must be succeeded because the entry handler returns before
> > +	 * modifying the return address if it is nested. Anyway, we need to
> > +	 * avoid calling user callbacks if it is nested.
> > +	 */
> > +	if (WARN_ON_ONCE(bit < 0))
> 
> I'm not so sure we need the warn on here. We should probably hook it to the
> recursion detection infrastructure that the function tracer has.

The reason I added WARN_ON here is this should not happen. The recursion
should be detected at the entry, not at exit. The __ftrace_return_to_handler()
is installed only if the entry does NOT detect the recursion. In that case
I think the exit should succeed recursion_trylock().

> 
> The reason I would say not to have the warn on, is because we don't have a
> warn on for recursion happening at the entry handler. Because this now is
> exposed by fprobe allowing different routines to be called at exit than
> what is used in entry, it can easily be triggered.

At the entry, if it detect recursion, it exits soon. But here we have to
process stack unwind to get the return address. This recursion_trylock()
is to mark this is in the critical section, not detect it.

Thank you,

> 
> -- Steve
> 
> 
> 
> > +		goto out;
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >  	trace.retval = ftrace_regs_get_return_value(fregs);
> >  #endif
> > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  		}
> >  	}
> >  
> > +	ftrace_test_recursion_unlock(bit);
> > +out:
> >  	/*
> >  	 * The ftrace_graph_return() may still access the current
> >  	 * ret_stack structure, we need to make sure the update of
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

