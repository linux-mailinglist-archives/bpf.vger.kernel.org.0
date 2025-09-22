Return-Path: <bpf+bounces-69185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4307DB8F64A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92273A2F18
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5102F747A;
	Mon, 22 Sep 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJaUQL+9"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18A2F90E2
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528092; cv=none; b=CaRQ69d1K8ss3D7WeuxzK/dhYmrehgfXmyPjfm2hj77NUAWWtyWObQUFLk+4rwpWHC9e3u7spiIUAB8xRnNIFnlm441RR0RK6Z1Dm6uzmBXIHq08ymvf4xXxEm0Ze1n67kmWcFk6qG10N+qr1l69uV2KR8cWOqjax51gU+EyKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528092; c=relaxed/simple;
	bh=tNlpG+9RSRfVOzhoE75w1gSvYEFTE68gc0kd3RJAPcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/fc2lB3jIo584eR0sjIfyYUu692/lyURsbF4gDG9OPhhGh4zXbiP/KxXy6uC4QktryNoJkPzq1/bERqpSNtrnvzimYWtf4v43yNdzaSHDfjj9n8tbhh+vfAj8x8EYhIAno1iW/d9xAY5qPEa+rGPtw4WMd1lLEm7eh4OEVLwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJaUQL+9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758528087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB4wVTq4PE7QI4UvE98apEAlUKHfwg3wd7rVHhsBMbY=;
	b=eJaUQL+9BgZzluZAZg8wV5hZSO+oWVE+XDJ6vISKAFmAYMDSfMLZC97pU9A4gliWWoMrzJ
	wDFcmbzFF0CHZFAr3NGbPcQHS0M4KMZa5k/l/qA0Zuyli6j3+6iPgUU+bYhH7p2CsnhSeP
	Ciu56xGlxBkF2WsCHl7yuhEMRtARvTY=
From: menglong.dong@linux.dev
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@kernel.org>, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kees@kernel.org, samitolvanen@google.com, rppt@kernel.org,
 luto@kernel.org, mhiramat@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] tracing: fgraph: Protect return handler from recursion
 loop
Date: Mon, 22 Sep 2025 16:01:17 +0800
Message-ID: <3373807.aeNJFYEL58@7940hx>
In-Reply-To: <175852292275.307379.9040117316112640553.stgit@devnote2>
References:
 <175852291163.307379.14414635977719513326.stgit@devnote2>
 <175852292275.307379.9040117316112640553.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/22 14:35 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
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
> 
> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  Changes in v2:
>   - Do not warn on failing ftrace_test_recursion_trylock() because it
>     allows one-level nest.
> ---
>  kernel/trace/fgraph.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 1e3b32b1e82c..484ad7a18463 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	unsigned long bitmap;
>  	unsigned long ret;
>  	int offset;
> +	int bit;
>  	int i;

The bpf bench testings work fine on this version :)

Tested-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Menglong Dong <menglong8.dong@gmail.com>

Thanks!
Menglong Dong

>  
>  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	if (fregs)
>  		ftrace_regs_set_instruction_pointer(fregs, ret);
>  
> +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> +	/*
> +	 * This can fail because ftrace_test_recursion_trylock() allows one nest
> +	 * call. If we are already in a nested call, then we don't probe this and
> +	 * just return the original return address.
> +	 */
> +	if (unlikely(bit < 0))
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
> 
> 
> 





