Return-Path: <bpf+bounces-39203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E0970860
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EB91F219F4
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95117332A;
	Sun,  8 Sep 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0uHsgcR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61D1487F1;
	Sun,  8 Sep 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808642; cv=none; b=X+PaZsvHdkDGKGNi8eC9HUnUoD1V0A+A9/j4Wu/1VsR+/fxsF4dwdVA4335uk1vReFbEGj4VjqQ+6Y+FnhtAxQypttZgki2ZktIfn1sz+8tX9UFztc8EPIorgKdDfGMsZw8dlTdX+rkJKbwpzojUlipcPOXalIJfaF8h0tejnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808642; c=relaxed/simple;
	bh=hVjgUKusbVBPprpt143SVZ7B/OMrtw61kI00W3VV/Zc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t2/0dJNF2v2lcjG9kZ8UoDn9KloSDVmVn53Ki89fGGEr5o1jAfyvou+cTkOs0KAohLcxqV+z6Uz3jVFJQNRwIpe+HaUhC0fD2Ro98KlNByO/O2ItLs7Zm1XykS66K/8bsEtYN+gKPP7kL8ZKrfnkJb39B+GKMXvO3oPmELiFeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0uHsgcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179FFC4CEC5;
	Sun,  8 Sep 2024 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808642;
	bh=hVjgUKusbVBPprpt143SVZ7B/OMrtw61kI00W3VV/Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0uHsgcRFn6NfT8z80S67WbbKSEKby8GbTb/NitaCzghveveOrd97FvMJbsnUbDaM
	 6Msvttf1R/8B25RXk6Eu8DYsw4NurmerwEwaUI5+BztmmCgfPokW8F/bif0ukwaWQg
	 /nWx+3EQmFIpxhoV8XG+QPE3wjtbHsf3s0R+2WKX+OPJgOsh2QDieI7dg8SYDNP/1g
	 dubytga6H+iq/cqSNnmZDyez9afAjWT1Nl/b6vEaQJv2ZbPzap0NJBQDysY+v37pkg
	 jnAkvOeT4x8YGBSTYWgRO32vrlLnQud1tYuFMd9EDo6r4Aa3UQW90Nkk0JKiNHgjGF
	 OyeftEpA2U4Fg==
Date: Mon, 9 Sep 2024 00:17:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 4/7] Add print_function_args()
Message-Id: <20240909001718.ffbfc2ac8b7888a94735720f@kernel.org>
In-Reply-To: <20240904065908.1009086-5-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-5-svens@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 08:58:58 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Add a function to decode argument types with the help of BTF. Will
> be used to display arguments in the function and function graph
> tracer.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/trace/trace_output.c | 68 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.h |  9 +++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index d8b302d01083..70405c4cceb6 100644
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
> @@ -669,6 +672,71 @@ int trace_print_lat_context(struct trace_iterator *iter)
>  	return !trace_seq_has_overflowed(s);
>  }
>  
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
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
> +	if (!ftrace_regs_has_args(fregs))
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
> +		arg = ftrace_regs_get_argument(fregs, i);
> +
> +		param_name = btf_name_by_offset(btf, param[i].name_off);
> +		if (param_name)
> +			trace_seq_printf(s, "%s = ", param_name);
> +		t = btf_type_skip_modifiers(btf, param[i].type, &tid);
> +		if (!t)
> +			continue;
> +		switch (BTF_INFO_KIND(t->info)) {
> +		case BTF_KIND_PTR:
> +			trace_seq_printf(s, "0x%lx", arg);
> +			break;
> +		case BTF_KIND_INT:
> +			trace_seq_printf(s, "%ld", arg);

Don't we check the size and signed? :)

> +			break;
> +		case BTF_KIND_ENUM:
> +			trace_seq_printf(s, "%ld", arg);

nit: %d? (enum is equal to the int type)

BTW, this series splits the patches by coding, not functionality.
For the first review, it is OK. But eventually those should be merged.

Thank you,

> +			break;
> +		default:
> +			trace_seq_printf(s, "0x%lx (%d)", arg, BTF_INFO_KIND(param[i].type));
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
> index dca40f1f1da4..a21d8ce606f7 100644
> --- a/kernel/trace/trace_output.h
> +++ b/kernel/trace/trace_output.h
> @@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
>  #define SEQ_PUT_HEX_FIELD(s, x)				\
>  	trace_seq_putmem_hex(s, &(x), sizeof(x))
>  
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
> +			 unsigned long func);
> +#else
> +static inline void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
> +				       unsigned long func) {
> +	trace_seq_puts(s, "()");
> +}
> +#endif
>  #endif
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

