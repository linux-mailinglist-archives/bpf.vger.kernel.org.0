Return-Path: <bpf+bounces-68938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12716B8A47F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AD34E0622
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB213191DD;
	Fri, 19 Sep 2025 15:26:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3F31813F;
	Fri, 19 Sep 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295605; cv=none; b=Kj9xD6NZuovg8hWmrKnT3wexsHm80HaA+mRRKa0yLtc9Ns8vQbpKllptpj8CfF/FKcD2e2PY8BzLMkpX3A7iNbbYtmxzFuXgfJv9cg/P71GyIpHF0qhqzAVoUFTFYB59zRwbKDuPVVg8XPQjK4MUM7oj93RcHXWgssNasmAp9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295605; c=relaxed/simple;
	bh=Ot5AWc2cOtHpOR605EtLUH9ddgtXMMhC2NVrDEB1sgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7ST4Wt4xs8qZ1CE5iRXZ/Ac5UdAEvvSauMGpFzYzJDM601wtrPYCIdiIErnMPN5pmdg+VgNJQkrI3r5LfkuzcC+/XJfxqmziz83HJxckPYNLqZ+U2brLfetasM1AGoQBIpyotNat9WCqXr4vsqu1cN3fgzyVG5xS6OlSCuXvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A5B41C06F3;
	Fri, 19 Sep 2025 15:26:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id E5E5020026;
	Fri, 19 Sep 2025 15:26:35 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:27:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <20250919112746.09fa02c7@gandalf.local.home>
In-Reply-To: <175828305637.117978.4183947592750468265.stgit@devnote2>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uju6gemxdjzzxrbni6owfwzggyjmzyd7
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E5E5020026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+EmSphq/kZv9gnziFEVTi8jXD3oWa6Njs=
X-HE-Tag: 1758295595-286850
X-HE-Meta: U2FsdGVkX1/QKPmBrti2d6QA5vCDvCGlltvv8KOQymEJHcVLCn9z7tQdSlDkMx0mWg7nM02FJFLE/KavMbyC++gg9G3il93RP22csb+AciNt45EJXgfCdkEMK7eule26KSubI/oYQ8X9n9WqBblOu90FbrTBMz991I6Ar39CoYXOoceuF0xfEKRRKx2Dz61YaMtqmUSQWSSBtW9G3OGHaY+GXcK9v5i2sekDHFbf9MOlQQER0QeEWI7v7KHDluxRpshM84uQiVFtUQrM9gbUo0fh+0cehNqgsWV7MeyWFzTidgcQ3TV65UjbdNvY8WZEnG48cD03/jt4zi0NirAkkF78yDD1lHtadPuCFDe+FWGgldMWRzSAjw==

On Fri, 19 Sep 2025 20:57:36 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> function_graph_enter_regs() prevents itself from recursion by
> ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> which is called at the exit, does not prevent such recursion.
> Therefore, while it can prevent recursive calls from
> fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> This can lead an unexpected recursion bug reported by Menglong.
> 
>  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
>   -> kprobe_multi_link_exit_handler -> is_endbr.  

So basically its if the handler for the return part calls something that it
is tracing, it can trigger the recursion?

> 
> To fix this issue, acquire ftrace_test_recursion_trylock() in the
> __ftrace_return_to_handler() after unwind the shadow stack to mark
> this section must prevent recursive call of fgraph inside user-defined
> fgraph_ops::retfunc().
> 
> This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> fprobe on function-graph tracer"), because before that fgraph was
> only used from the function graph tracer. Fprobe allowed user to run
> any callbacks from fgraph after that commit.

I would actually say it's because before this commit, the return handler
callers never called anything that the entry handlers didn't already call.
If there was recursion, the entry handler would catch it (and the entry
tells fgraph if the exit handler should be called).

The difference here is with fprobes, you can have the exit handler calling
functions that the entry handler does not, which exposes more cases where
recursion could happen.

> 
> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fgraph.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 1e3b32b1e82c..08dde420635b 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	unsigned long bitmap;
>  	unsigned long ret;
>  	int offset;
> +	int bit;
>  	int i;
>  
>  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	if (fregs)
>  		ftrace_regs_set_instruction_pointer(fregs, ret);
>  
> +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> +	/*
> +	 * This must be succeeded because the entry handler returns before
> +	 * modifying the return address if it is nested. Anyway, we need to
> +	 * avoid calling user callbacks if it is nested.
> +	 */
> +	if (WARN_ON_ONCE(bit < 0))

I'm not so sure we need the warn on here. We should probably hook it to the
recursion detection infrastructure that the function tracer has.

The reason I would say not to have the warn on, is because we don't have a
warn on for recursion happening at the entry handler. Because this now is
exposed by fprobe allowing different routines to be called at exit than
what is used in entry, it can easily be triggered.

-- Steve



> +		goto out;
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	trace.retval = ftrace_regs_get_return_value(fregs);
>  #endif
> @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  		}
>  	}
>  
> +	ftrace_test_recursion_unlock(bit);
> +out:
>  	/*
>  	 * The ftrace_graph_return() may still access the current
>  	 * ret_stack structure, we need to make sure the update of


