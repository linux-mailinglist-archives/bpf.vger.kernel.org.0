Return-Path: <bpf+bounces-69172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5194B8F183
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606243BEC72
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868D265292;
	Mon, 22 Sep 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USGKQsdM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76EF9C1;
	Mon, 22 Sep 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521822; cv=none; b=aMd75sraX5/FQAQy4xQ1OspxqB6RGOU5JrYun8V7R6O2uAQQ8amIREjOrB/9zkcX7hV3rdaeWsEVyJHDzfXTBa+ttfd2oPwhkB3HO0OTGYwyi/SsXY/v+0FrGjV8B51FkQcVv6Q6mbj00m82JraNN8RwZZCYTvE32dgykwKwEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521822; c=relaxed/simple;
	bh=ReX9fghXWIdTSFPdcDsEfBlBggwbg9JPtGadk0nMDQ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IxsaNJIwML6TKwaYonacekUkWELchh8GHaBaxDLJE6Z0umw6estbuMWGI8aOb0Lym7Xqg5gpjr5HVeQxprKI97461hWo7rb6TbrF9c9PuOL/rOEWkBg3atsxYTyV7a/7fo3mUrhKmtAWKY+/4YCNH1pIN/iGFfuyrMls5Us2vRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USGKQsdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7331C4CEF0;
	Mon, 22 Sep 2025 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758521821;
	bh=ReX9fghXWIdTSFPdcDsEfBlBggwbg9JPtGadk0nMDQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USGKQsdMRuCNygvGpPF5ORQFbbq/eSRtbRiwQOnHH0Wly7y8BHrXf70qaUoZsjByO
	 78Wqvw3XHzl1yFmugdmkP/QNsvbP3yPUZCKgvq4MCkEniSTpgH4YeNrKoZoutwh3jW
	 GkF2LKi7+7UCAA8LPdw/SUVej6OysNGhgZxgUyMgSdin+Nk1rbjR9/Ss7syCNMBd3G
	 dfmBICTCi69eVNqKtgt6/cvFfKbfLDoh+OA7T6G8Auurwq/p8fYDwyqcJSKFafareO
	 fK9YwAI5xW+EMYWoyXIPvcKDjnz90fv7SvbYVYXCFEuEedeh83/NS28f0Yu45oOtFC
	 eqvy9kcOTkJjg==
Date: Mon, 22 Sep 2025 15:16:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven
 Rostedt <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-Id: <20250922151655.1792fa0abc6c3a8d98d052c9@kernel.org>
In-Reply-To: <aM5bizfTTTAH5Xoa@krava>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<20250919112746.09fa02c7@gandalf.local.home>
	<aM5bizfTTTAH5Xoa@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 09:45:15 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Sep 19, 2025 at 11:27:46AM -0400, Steven Rostedt wrote:
> > On Fri, 19 Sep 2025 20:57:36 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > function_graph_enter_regs() prevents itself from recursion by
> > > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > > which is called at the exit, does not prevent such recursion.
> > > Therefore, while it can prevent recursive calls from
> > > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > > This can lead an unexpected recursion bug reported by Menglong.
> > > 
> > >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> > >   -> kprobe_multi_link_exit_handler -> is_endbr.  
> > 
> > So basically its if the handler for the return part calls something that it
> > is tracing, it can trigger the recursion?
> > 
> > > 
> > > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > > this section must prevent recursive call of fgraph inside user-defined
> > > fgraph_ops::retfunc().
> > > 
> > > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > > fprobe on function-graph tracer"), because before that fgraph was
> > > only used from the function graph tracer. Fprobe allowed user to run
> > > any callbacks from fgraph after that commit.
> > 
> > I would actually say it's because before this commit, the return handler
> > callers never called anything that the entry handlers didn't already call.
> > If there was recursion, the entry handler would catch it (and the entry
> > tells fgraph if the exit handler should be called).
> > 
> > The difference here is with fprobes, you can have the exit handler calling
> > functions that the entry handler does not, which exposes more cases where
> > recursion could happen.
> 
> so IIUC we have return kprobe multi probe on is_endbr and now we do:
> 	
> 	is_endbr()
> 	{ -> function_graph_enter_regs installs return probe
> 	  ...
> 	} -> __ftrace_return_to_handler
> 	       fprobe_return
> 	         kprobe_multi_link_exit_handler
> 	           is_endbr
> 		   { -> function_graph_enter_regs installs return probe
> 		     ...
> 		   } -> __ftrace_return_to_handler
> 		          fprobe_return
> 		            kprobe_multi_link_exit_handler
> 			      is_endbr
> 			      { -> function_graph_enter_regs installs return probe
> 			        ...
> 			      } -> __ftrace_return_to_handler
> 			           ... recursion
> 
> 
> with the fix:
> 
> 	is_endbr()
> 	{ -> function_graph_enter_regs installs return probe
> 	  ...
> 	} -> __ftrace_return_to_handler
> 	       fprobe_return
> 	         kprobe_multi_link_exit_handler
> 	           ...
> 	           is_endbr
> 		   { ->  function_graph_enter_regs
> 		           ftrace_test_recursion_trylock fails and we do NOT install return probe
>                      ...
> 		   }
> 
> 
> there's is_endbr call also in kprobe_multi_link_handler, but it won't
> trigger recursion, because function_graph_enter_regs already uses
> ftrace_test_recursion_trylock 
> 
> 
> if above is correct then the fix looks good to me
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Hi Jiri,

I found ftrace_test_recursion_trylock() allows one nest level, can you
make sure it is OK?

Thank you,

> 
> thanks,
> jirka
> 
> 
> > 
> > > 
> > > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > > Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> > > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  kernel/trace/fgraph.c |   12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > > index 1e3b32b1e82c..08dde420635b 100644
> > > --- a/kernel/trace/fgraph.c
> > > +++ b/kernel/trace/fgraph.c
> > > @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > >  	unsigned long bitmap;
> > >  	unsigned long ret;
> > >  	int offset;
> > > +	int bit;
> > >  	int i;
> > >  
> > >  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > > @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > >  	if (fregs)
> > >  		ftrace_regs_set_instruction_pointer(fregs, ret);
> > >  
> > > +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> > > +	/*
> > > +	 * This must be succeeded because the entry handler returns before
> > > +	 * modifying the return address if it is nested. Anyway, we need to
> > > +	 * avoid calling user callbacks if it is nested.
> > > +	 */
> > > +	if (WARN_ON_ONCE(bit < 0))
> > 
> > I'm not so sure we need the warn on here. We should probably hook it to the
> > recursion detection infrastructure that the function tracer has.
> > 
> > The reason I would say not to have the warn on, is because we don't have a
> > warn on for recursion happening at the entry handler. Because this now is
> > exposed by fprobe allowing different routines to be called at exit than
> > what is used in entry, it can easily be triggered.
> > 
> > -- Steve
> > 
> > 
> > 
> > > +		goto out;
> > > +
> > >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > >  	trace.retval = ftrace_regs_get_return_value(fregs);
> > >  #endif
> > > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > >  		}
> > >  	}
> > >  
> > > +	ftrace_test_recursion_unlock(bit);
> > > +out:
> > >  	/*
> > >  	 * The ftrace_graph_return() may still access the current
> > >  	 * ret_stack structure, we need to make sure the update of
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

