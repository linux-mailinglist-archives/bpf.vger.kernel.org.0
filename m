Return-Path: <bpf+bounces-22085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB68566C6
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087B81C214C3
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D5132C01;
	Thu, 15 Feb 2024 15:01:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F947131E3D;
	Thu, 15 Feb 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009283; cv=none; b=qJten8rPfNtTil7J6xT6AwRjUL3NyiSXj8q1/8Iz2wtG/HoFiKUTslrnjcebcxKZLSfqtjaG5NH2tlzFH+RcvJuCBKDBVhGZYTY6zoj9JOt8r/spuz2FKABA/oGeshO//ikcCgmROkPOxjLCeglGYfgJ4A8bYE5kagpJ7tzaBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009283; c=relaxed/simple;
	bh=idPar8TnYrcn1/ehunJjNHy7HB5Glf8ubsjkXlG3MF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7GVdUPhoW1MZ3jxQayIwDJnuCy3VtlaOaOvhhxuAPnfqMeP00mq58Ln5pZT9PpOO6CYmBOYP2ZG7tb32kaA8C1yrMrfVGXOM2Q1yP8XNSKJyA9EYdzvx04xfYMKh08Y0F+AyETv/7IJ0lB1mxD0P6hmVg30N05C68nYd22mJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CB4C433F1;
	Thu, 15 Feb 2024 15:01:20 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:02:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 21/36] function_graph: Add selftest for passing local
 variables
Message-ID: <20240215100254.2891c5da@gandalf.local.home>
In-Reply-To: <170723228217.502590.6615001674278328094.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723228217.502590.6615001674278328094.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Add boot up selftest that passes variables from a function entry to a
> function exit, and make sure that they do get passed around.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Add reserved size test.
>   - Use pr_*() instead of printk(KERN_*).
> ---
>  kernel/trace/trace_selftest.c |  169 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index f0758afa2f7d..4d86cd4c8c8c 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -756,6 +756,173 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +
> +#define BYTE_NUMBER 123
> +#define SHORT_NUMBER 12345
> +#define WORD_NUMBER 1234567890
> +#define LONG_NUMBER 1234567890123456789LL
> +
> +static int fgraph_store_size __initdata;
> +static const char *fgraph_store_type_name __initdata;
> +static char *fgraph_error_str __initdata;
> +static char fgraph_error_str_buf[128] __initdata;
> +
> +static __init int store_entry(struct ftrace_graph_ent *trace,
> +			      struct fgraph_ops *gops)
> +{
> +	const char *type = fgraph_store_type_name;
> +	int size = fgraph_store_size;
> +	void *p;
> +
> +	p = fgraph_reserve_data(gops->idx, size);
> +	if (!p) {
> +		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
> +			 "Failed to reserve %s\n", type);
> +		fgraph_error_str = fgraph_error_str_buf;
> +		return 0;
> +	}
> +
> +	switch (fgraph_store_size) {
> +	case 1:
> +		*(char *)p = BYTE_NUMBER;
> +		break;
> +	case 2:
> +		*(short *)p = SHORT_NUMBER;
> +		break;
> +	case 4:
> +		*(int *)p = WORD_NUMBER;
> +		break;
> +	case 8:
> +		*(long long *)p = LONG_NUMBER;
> +		break;
> +	}
> +

What would be an interesting test is to run all versions together. That is,
to attach a callback that stores a byte, a callback that stores a short, a
callback that stores a word and a callback that stores a long, and attach
them all to the same function.

I guess we can add that as a separate patch.

-- Steve


> +	return 1;
> +}
> +

