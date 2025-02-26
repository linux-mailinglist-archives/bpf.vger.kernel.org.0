Return-Path: <bpf+bounces-52648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331FA463A3
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DA91894BA7
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BB2236FC;
	Wed, 26 Feb 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ7B01W+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431D212FB4;
	Wed, 26 Feb 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581330; cv=none; b=Roovr+qFccLfMF4boe72DLoIPAWaa+QMnfHbUTdQHhBi/05LauIPwWc8vLpXmDwJx/GnTMDhXcbedJc4xCEHbS5ZS3zmTR72Z0L3MZAdWd6al7jOI6z2Lgysf8X0GwlXtVVVmGMEQ3GYs8NaGimTftMwevFWUmGsMtkwF4ujRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581330; c=relaxed/simple;
	bh=gLpXpt/oNQG+cEDy1hm4zqtSmcdqyW5EeSzyAxZ0V9o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KMl9nAZ9pKnfuZbDad888/4FVqgckJbnIPHTsSU/wDs4rB2VGBdurTptopsXfFmYZQ/TpuD0NjWDOdHpF7oRA+8Hj8Fxl/Xjr95QsaXU09UHYX1wQ67B2o4e6yNfZYYGKSKJAJ0mSDjuCkORTJ2SNYMybO9ayWTsg4sNZKWfNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ7B01W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA497C4CED6;
	Wed, 26 Feb 2025 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581329;
	bh=gLpXpt/oNQG+cEDy1hm4zqtSmcdqyW5EeSzyAxZ0V9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJ7B01W+mbrEcbxVnT29sGrNuF70RyfeH5tA9BH9uG4p4L4pvobeAtOVeOYYxOGbL
	 QaHIvLgwp2XQyL4AcVkPAq2GwMs0kZYUHdnzNq6FMKcgkAvhxXYG8OIprZtFzh+8Ra
	 HbNd48dvOtfMNqJCyeCRON0ePQe2R5WnjlbGvlLMJg+W13UsAcOrpPEikHOUp3Kc03
	 s39xRJQ4G7wCURYmuluIMiQu3IiP326gpaijSLJMF5YbYD37ISfNqvahT9V2Iyxap0
	 czvH/JqVsIMzLaNA5lZMq3nNFCndr0ccxpTIf0Cri6N/l1qmU4stYRnaBTtrJsYPlv
	 MersOB2KFfqzQ==
Date: Wed, 26 Feb 2025 23:48:46 +0900
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
Subject: Re: [PATCH v3 1/4] ftrace: Add print_function_args()
Message-Id: <20250226234846.2525cef803717aa5acfb8f36@kernel.org>
In-Reply-To: <20250225222653.550619678@goodmis.org>
References: <20250225222601.423129938@goodmis.org>
	<20250225222653.550619678@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 17:26:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Add a function to decode argument types with the help of BTF. Will
> be used to display arguments in the function and function graph
> tracer.
> 
> It can only handle simply arguments and up to FTRACE_REGS_MAX_ARGS number
> of arguments. When it hits a max, it will print ", ...":
> 
>    page_to_skb(vi=0xffff8d53842dc980, rq=0xffff8d53843a0800, page=0xfffffc2e04337c00, offset=6160, len=64, truesize=1536, ...)
> 
> And if it hits an argument that is not recognized, it will print the raw
> value and the type of argument it is:
> 
>    make_vfsuid(idmap=0xffffffff87f99db8, fs_userns=0xffffffff87e543c0, kuid=0x0 (STRUCT))
>    __pti_set_user_pgtbl(pgdp=0xffff8d5384ab47f8, pgd=0x110e74067 (STRUCT))
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Donglin Peng <dolinux.peng@gmail.com>
> Cc: Zheng Yejian <zhengyejian@huaweicloud.com>
> Link: https://lore.kernel.org/20241223201541.898496620@goodmis.org
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace_regs.h |  5 +++
>  kernel/trace/Kconfig        |  6 +++
>  kernel/trace/trace_output.c | 85 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.h |  9 ++++
>  4 files changed, 105 insertions(+)
> 
> diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> index bbc1873ca6b8..15627ceea9bc 100644
> --- a/include/linux/ftrace_regs.h
> +++ b/include/linux/ftrace_regs.h
> @@ -35,4 +35,9 @@ struct ftrace_regs;
>  
>  #endif /* HAVE_ARCH_FTRACE_REGS */
>  
> +/* This can be overridden by the architectures */
> +#ifndef FTRACE_REGS_MAX_ARGS
> +# define FTRACE_REGS_MAX_ARGS	6
> +#endif
> +
>  #endif /* _LINUX_FTRACE_REGS_H */
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d570b8b9c0a9..60412c1012ef 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -263,6 +263,12 @@ config FUNCTION_GRAPH_RETADDR
>  	  the function is called. This feature is off by default, and you can
>  	  enable it via the trace option funcgraph-retaddr.
>  
> +config FUNCTION_TRACE_ARGS
> +       bool
> +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> +	depends on DEBUG_INFO_BTF
> +	default y
> +
>  config DYNAMIC_FTRACE
>  	bool "enable/disable function tracing dynamically"
>  	depends on FUNCTION_TRACER
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 03d56f711ad1..4b721cd4f21d 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -12,8 +12,11 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/mm.h>
>  #include <linux/idr.h>
> +#include <linux/btf.h>
> +#include <linux/bpf.h>
>  
>  #include "trace_output.h"
> +#include "trace_btf.h"
>  
>  /* must be a power of 2 */
>  #define EVENT_HASHSIZE	128
> @@ -684,6 +687,88 @@ int trace_print_lat_context(struct trace_iterator *iter)
>  	return !trace_seq_has_overflowed(s);
>  }
>  
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, unsigned long *args,
> +			 unsigned long func)
> +{
> +	const struct btf_param *param;
> +	const struct btf_type *t;
> +	const char *param_name;
> +	char name[KSYM_NAME_LEN];
> +	unsigned long arg;
> +	struct btf *btf;
> +	s32 tid, nr = 0;
> +	int a, p, x;
> +
> +	trace_seq_printf(s, "(");
> +
> +	if (!args)
> +		goto out;
> +	if (lookup_symbol_name(func, name))
> +		goto out;
> +
> +	/* TODO: Pass module name here too */
> +	t = btf_find_func_proto(name, &btf);
> +	if (IS_ERR_OR_NULL(t))
> +		goto out;
> +
> +	param = btf_get_func_param(t, &nr);
> +	if (!param)
> +		goto out_put;
> +
> +	for (a = 0, p = 0; p < nr; a++, p++) {
> +		if (p)
> +			trace_seq_puts(s, ", ");
> +
> +		/* This only prints what the arch allows (6 args by default) */
> +		if (a == FTRACE_REGS_MAX_ARGS) {
> +			trace_seq_puts(s, "...");
> +			break;
> +		}
> +
> +		arg = args[a];
> +
> +		param_name = btf_name_by_offset(btf, param[p].name_off);
> +		if (param_name)
> +			trace_seq_printf(s, "%s=", param_name);
> +		t = btf_type_skip_modifiers(btf, param[p].type, &tid);
> +
> +		switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> +		case BTF_KIND_UNKN:
> +			trace_seq_putc(s, '?');
> +			/* Still print unknown type values */
> +			fallthrough;
> +		case BTF_KIND_PTR:
> +			trace_seq_printf(s, "0x%lx", arg);
> +			break;
> +		case BTF_KIND_INT:
> +			trace_seq_printf(s, "%ld", arg);
> +			break;
> +		case BTF_KIND_ENUM:
> +			trace_seq_printf(s, "%ld", arg);
> +			break;
> +		default:
> +			/* This does not handle complex arguments */
> +			trace_seq_printf(s, "(%s)[0x%lx", btf_type_str(t), arg);
> +			for (x = sizeof(long); x < t->size; x += sizeof(long)) {
> +				trace_seq_putc(s, ':');
> +				if (++a == FTRACE_REGS_MAX_ARGS) {
> +					trace_seq_puts(s, "...]");
> +					goto out_put;
> +				}
> +				trace_seq_printf(s, "0x%lx", args[a]);
> +			}
> +			trace_seq_putc(s, ']');
> +			break;
> +		}
> +	}
> +out_put:
> +	btf_put(btf);
> +out:
> +	trace_seq_printf(s, ")");
> +}
> +#endif
> +
>  /**
>   * ftrace_find_event - find a registered event
>   * @type: the type of event to look for
> diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
> index dca40f1f1da4..2e305364f2a9 100644
> --- a/kernel/trace/trace_output.h
> +++ b/kernel/trace/trace_output.h
> @@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
>  #define SEQ_PUT_HEX_FIELD(s, x)				\
>  	trace_seq_putmem_hex(s, &(x), sizeof(x))
>  
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, unsigned long *args,
> +			 unsigned long func);
> +#else
> +static inline void print_function_args(struct trace_seq *s, unsigned long *args,
> +				       unsigned long func) {
> +	trace_seq_puts(s, "()");
> +}
> +#endif
>  #endif
>  
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

