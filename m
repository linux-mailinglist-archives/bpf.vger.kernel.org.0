Return-Path: <bpf+bounces-47605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED359FC54B
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD64188385B
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEAE1B4148;
	Wed, 25 Dec 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR947iTL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFF13B7BC;
	Wed, 25 Dec 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735132566; cv=none; b=K6Hs7keYYgxiuY0TThoOCpLm6hWaZex5CvMBr1mDIPg1P/rOcmz7d+BnSfYy5XAC/wgobby1VZb6J2RvHl2hDTA4KhW0/HfLUQQMwcG+u/2PWy2/GvQzkgEIVw7Z/qB5AR/w9p4vKy9euNjc9CNv9dJJeqfoTXVDHSbc/eaZA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735132566; c=relaxed/simple;
	bh=q5BNQGeW9LCi3HafFO4y8fWKetca2MbVVSIzF7LA34k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ch0MycjI9jwB9SWG8UvvgfeZncKtnslTKMIdtSClQ2f2mssPHKaDlzfNgq2p9Ts2gL+OttymG3PDdbpj2esF7ma1YgpFSAr2h7TFdfzGThiL5O8I6H2o/UTzBpKlv6FPqk+yGf55WcKUv5McBv+ZmjYN4lkCxy9HfTfsjm1fyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR947iTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC3C4CECD;
	Wed, 25 Dec 2024 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735132565;
	bh=q5BNQGeW9LCi3HafFO4y8fWKetca2MbVVSIzF7LA34k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jR947iTL60tY2z5dzqd/kOXIeuu/raDz6BuYK2r3v1qD0DCeb9DF6w9YvjZS+ot+C
	 oaRoxq4oiuVJgiQlTCG4GHvte3I8ePXdxvsbHOnqJ1ZZLERiu9V1hWyrwDabt6bnWL
	 XERe4K9oJPMlhwT8CWqHM3yFOX2v/xaV/j9PXfa36VDlSJL4f4ukwe1B+hW6g92Pve
	 z0msuytLuJJ6+63M0/h2t+OIKrYnHUXRrSVO6BK8gGDkAuF2zTdb8YB51yQpc/hlxJ
	 FKzB8Lu9fjUQzjIJCU8gVBrvINH7N+iBWasiwlqzovCR6yn5oUoyjUbuiaciJlsBBG
	 oatYHzx+xSdFg==
Date: Wed, 25 Dec 2024 22:15:55 +0900
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
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
Message-Id: <20241225221555.092d66edb15d7693646c7945@kernel.org>
In-Reply-To: <20241223201541.898496620@goodmis.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201541.898496620@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 15:13:48 -0500
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
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240904065908.1009086-5-svens@linux.ibm.com
> 
>  - Added Config option FUNCTION_TRACE_ARGS to this patch
>   (unconditional if dependencies are met)
> 
>  - Changed the print_function_args() function to take an array of
>    unsigned long args and not the ftrace_regs pointer. The ftrace_regs
>    should be opaque from generic code.
> 
>  - Have the function print the name of an BTF type that is not supported.
> 
>  - Added FTRACE_REGS_MAX_ARGS as the number of arguments saved in
>    the event and printed out.
> 
>  - Print "...," if the number of arguments goes past FTRACE_REGS_MAX_ARGS.
> 
>  include/linux/ftrace_regs.h |  5 +++
>  kernel/trace/Kconfig        |  6 +++
>  kernel/trace/trace_output.c | 78 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.h |  9 +++++
>  4 files changed, 98 insertions(+)
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

For using the BTF APIs, we also needs BPF_SYSCALL (DEBUG_INFO_BTF just
compiles the BTF info into the kernel binary.)

Others looks good to me.

Revewied-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> +	default y
> +
>  config DYNAMIC_FTRACE
>  	bool "enable/disable function tracing dynamically"
>  	depends on FUNCTION_TRACER
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index da748b7cbc4d..40d6c7a9e0c4 100644
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
> @@ -680,6 +683,81 @@ int trace_print_lat_context(struct trace_iterator *iter)
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
> +	int i;
> +
> +	trace_seq_printf(s, "(");
> +
> +	if (!args)
> +		goto out;
> +	if (lookup_symbol_name(func, name))
> +		goto out;
> +
> +	btf = bpf_get_btf_vmlinux();
> +	if (IS_ERR_OR_NULL(btf))
> +		goto out;
> +
> +	t = btf_find_func_proto(name, &btf);
> +	if (IS_ERR_OR_NULL(t))
> +		goto out;
> +
> +	param = btf_get_func_param(t, &nr);
> +	if (!param)
> +		goto out_put;
> +
> +	for (i = 0; i < nr; i++) {
> +		/* This only prints what the arch allows (6 args by default) */
> +		if (i == FTRACE_REGS_MAX_ARGS) {
> +			trace_seq_puts(s, "...");
> +			break;
> +		}
> +
> +		arg = args[i];
> +
> +		param_name = btf_name_by_offset(btf, param[i].name_off);
> +		if (param_name)
> +			trace_seq_printf(s, "%s=", param_name);
> +		t = btf_type_skip_modifiers(btf, param[i].type, &tid);
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
> +			trace_seq_printf(s, "0x%lx (%s)", arg, btf_type_str(t));
> +			break;
> +		}
> +		if (i < nr - 1)
> +			trace_seq_printf(s, ", ");
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
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

