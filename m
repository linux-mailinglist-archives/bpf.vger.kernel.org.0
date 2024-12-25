Return-Path: <bpf+bounces-47608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA09FC5CA
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB261611E5
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB071B87D9;
	Wed, 25 Dec 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayl+Ij5J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251D175B1;
	Wed, 25 Dec 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136610; cv=none; b=eINu29eo/XQ9s8QGS9YTxwW9xHFVBGwgMTtjeCNle0qG/7JgYx94S4hH4B1u8RUaISZWQ+78d4m9VygEG14KcPNGmz6rZYNqcy/9SD6Ox9sqMfzVuT659pgOHjHQ8nuL+Qc2REBheK+08bN7Li11/kfgzDv6ChO5SLFBvK0jyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136610; c=relaxed/simple;
	bh=4OOxPSAzydkzDJw7pbYknHnigUuUr0pdHtgx4IAvsRE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bCBRBVHjWE7jDKGfkRjnr16re150wgEl+/kniX/LnqjBNo7ahmguPGVny+ULXXANXPG+pDaG9s+ga/ws/cRFmNWRy6OrrFdpSMrptzbfBCT0eECJH0H5/xFdeu9TdeRuCF9b18IhyTH8VsBxQTc6X9jFAioxAI4YU7uUHz7Hob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayl+Ij5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04ADC4CECD;
	Wed, 25 Dec 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735136609;
	bh=4OOxPSAzydkzDJw7pbYknHnigUuUr0pdHtgx4IAvsRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayl+Ij5JhALGOPNlAIF4cDdCUPB4z3NL+nLpb5Zwdb/aBx2yoDQPD7PCZJ03JRhrm
	 bGZEfFRBd1RNsFTC0pb/Q6/jQ5XzWKW0lKUbcnjaUmbZ1kofoJ1r4qCb3mcFevhxuc
	 V75OorDBxOqbQL6CZHMLEptmc//shAghTsmUjM4+femPAB4PTR1lSVX3JUFBh/+bxM
	 WpIAJ2c7mJrn3Cj+p7V9i/KwADjRs4S4Liu8HFYdh+c4NeoAFEP5hdDIsmyzojBGY/
	 12B0CZjlwMach0mjCTdZSyviUsvtLIIo7kkpFQ1KzqAUNQCnQKuy2rYasvf3Dt2YRf
	 u6RJQ2Yd724jQ==
Date: Wed, 25 Dec 2024 23:23:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ftrace: Have funcgraph-args take affect during
 tracing
Message-Id: <20241225232323.338aa07a3cd04c5253054890@kernel.org>
In-Reply-To: <20241223201542.240760965@goodmis.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201542.240760965@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 15:13:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently, when function_graph is started, it looks at the option
> funcgraph-args, and if it is set, it will enable tracing of the arguments.
> 
> But if tracing is already running, and the user enables funcgraph-args, it
> will have no effect. Instead, it should enable argument tracing when it is
> enabled, even if it means disabling the function graph tracing for a short
> time in order to do the transition.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_functions_graph.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index c8eda9bebdf4..d1ee001f5a8e 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -469,7 +469,7 @@ static int graph_trace_init(struct trace_array *tr)
>  	else
>  		tr->gops->retfunc = trace_graph_return;
>  
> -	/* Make gops functions are visible before we start tracing */
> +	/* Make gops functions visible before we start tracing */
>  	smp_mb();
>  
>  	ret = register_ftrace_graph(tr->gops);
> @@ -480,6 +480,28 @@ static int graph_trace_init(struct trace_array *tr)
>  	return 0;
>  }
>  
> +static int ftrace_graph_trace_args(struct trace_array *tr, int set)
> +{
> +	trace_func_graph_ent_t entry;
> +
> +	if (set)
> +		entry = trace_graph_entry_args;
> +	else
> +		entry = trace_graph_entry;
> +
> +	/* See if there's any changes */
> +	if (tr->gops->entryfunc == entry)
> +		return 0;
> +
> +	unregister_ftrace_graph(tr->gops);
> +
> +	tr->gops->entryfunc = entry;
> +
> +	/* Make gops functions visible before we start tracing */
> +	smp_mb();
> +	return register_ftrace_graph(tr->gops);
> +}
> +
>  static void graph_trace_reset(struct trace_array *tr)
>  {
>  	tracing_stop_cmdline_record();
> @@ -1609,6 +1631,9 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
>  	if (bit == TRACE_GRAPH_GRAPH_TIME)
>  		ftrace_graph_graph_time_control(set);
>  
> +	if (bit == TRACE_GRAPH_ARGS)
> +		return ftrace_graph_trace_args(tr, set);
> +
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

