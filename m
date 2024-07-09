Return-Path: <bpf+bounces-34307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D092C62F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3F81C2268E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DF18786D;
	Tue,  9 Jul 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN8s7vlH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2A149C79;
	Tue,  9 Jul 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563449; cv=none; b=M3d5xMqUyCDZuou3nbYoqxkbJl5Pxt7NUmcHMDi9yX5UhVcQCRiYlujMIOA+DpjYUncOmkW5bE4UTgcci8GYrMuUZBW0odcecP1GpPNvswScsr1zahJvg6sd6eObS5qcxntkFr7H8SXZ3UGi2BUqEqSydhuQEz+72hQgRT8Pid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563449; c=relaxed/simple;
	bh=M7bxLOB6w9LZKOrld68ER7p3bT8mFFNBNOJZa41XOQ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OUfx4DTYFVjr/hM9xGj6jzJ99m2zkkrzVQkz8vgUcljhEqCVxPMocqE+qeAGUjC+/Yrgs8mL39RylSL7U2JId58VLMciwld0beM7u2DnzTTrH0YkqC3aBK8gPbYId7wcZoketEgK9hhW5cF46t6VCS81887p87VMLK6S7CYFOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN8s7vlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47A3C3277B;
	Tue,  9 Jul 2024 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720563448;
	bh=M7bxLOB6w9LZKOrld68ER7p3bT8mFFNBNOJZa41XOQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cN8s7vlHZ/NUwEkX/YeMELj0IjzweDvMEzSnKucKfWzvectpvljp+IE0dOA+ZRW84
	 u2hRM/VYz9XqQnQpPPYAjY0f3dcuDQ97B1GAOd9CCf41ZAuVBgmlu5iZ+/jtEXdhBN
	 nPSJCM+3xBsDAAVWKUKC53M6pIXTm24VvMLA/appTqXbQTwMo8PTYqaItMzpfVSbow
	 ZwtQUn78L+UnmQ3c7k5MSOKkONMzQ33dTTZB2XETp8jl3b7BnMa2Rl0oEO7f8tsG3W
	 iSoBNIwvh6e+Kw+4jzXD5Aq/c+FTHq4aK7klQd8AefdHuPs316Q5Rxs3YphJDacLuE
	 XJvM6i6VVaKpA==
Date: Wed, 10 Jul 2024 07:17:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Francis Laniel
 <flaniel@linux.microsoft.com>, Nikolay Kuratov <kniv@yandex-team.ru>,
 bpf@vger.kernel.org
Subject: Re: [PATCH for-next v4] tracing/kprobes: Add symbol counting check
 when module loads
Message-Id: <20240710071724.dada783db147d4aab6980041@kernel.org>
In-Reply-To: <172048347679.185217.9457864992619792356.stgit@devnote2>
References: <172048347679.185217.9457864992619792356.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 09:04:36 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Currently, kprobe event checks whether the target symbol name is unique
> or not, so that it does not put a probe on an unexpected place. But this
> skips the check if the target is on a module because the module may not
> be loaded.
> 
> To fix this issue, this patch checks the number of probe target symbols
> in a target module when the module is loaded. If the probe is not on the
> unique name symbols in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Instead of version up, let me send a fix.

Thanks,

> ---
>  Changes in v4:
>   - Hide find_module() in try_module_get_by_name().
>   - Add bpf ML.
>  Changes in v3:
>   - Update the patch description.
>   - Update for latest probe/for-next
>  Updated from last October post, which was dropped by test failure:
>     https://lore.kernel.org/linux-trace-kernel/169854904604.132316.12500381416261460174.stgit@devnote2/
>  Changes in v2:
>   - Fix to skip checking uniqueness if the target module is not loaded.
>   - Fix register_module_trace_kprobe() to pass correct symbol name.
>   - Fix to call __register_trace_kprobe() from module callback.
> ---
>  kernel/trace/trace_kprobe.c |  138 +++++++++++++++++++++++++++++--------------
>  1 file changed, 94 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 7fd0f8576e4c..61a6da808203 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -678,6 +678,21 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  }
>  
>  #ifdef CONFIG_MODULES
> +static int validate_module_probe_symbol(const char *modname, const char *symbol);
> +
> +static int register_module_trace_kprobe(struct module *mod, struct trace_kprobe *tk)
> +{
> +	const char *p;
> +	int ret = 0;
> +
> +	p = strchr(trace_kprobe_symbol(tk), ':');
> +	if (p)
> +		ret = validate_module_probe_symbol(module_name(mod), p + 1);
> +	if (!ret)
> +		ret = __register_trace_kprobe(tk);
> +	return ret;
> +}
> +
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -696,7 +711,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
>  		if (trace_kprobe_within_module(tk, mod)) {
>  			/* Don't need to check busy - this should have gone. */
>  			__unregister_trace_kprobe(tk);
> -			ret = __register_trace_kprobe(tk);
> +			ret = register_module_trace_kprobe(mod, tk);
>  			if (ret)
>  				pr_warn("Failed to re-register probe %s on %s: %d\n",
>  					trace_probe_name(&tk->tp),
> @@ -747,17 +762,81 @@ static int count_mod_symbols(void *data, const char *name, unsigned long unused)
>  	return 0;
>  }
>  
> -static unsigned int number_of_same_symbols(char *func_name)
> +static unsigned int number_of_same_symbols(const char *mod, const char *func_name)
>  {
>  	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
>  
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> +	if (!mod)
> +		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>  
>  	return ctx.count;
>  }
>  
> +static int validate_module_probe_symbol(const char *modname, const char *symbol)
> +{
> +	unsigned int count = number_of_same_symbols(modname, symbol);
> +
> +	if (count > 1) {
> +		/*
> +		 * Users should use ADDR to remove the ambiguity of
> +		 * using KSYM only.
> +		 */
> +		return -EADDRNOTAVAIL;
> +	} else if (count == 0) {
> +		/*
> +		 * We can return ENOENT earlier than when register the
> +		 * kprobe.
> +		 */
> +		return -ENOENT;
> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MODULES
> +/* Return NULL if the module is not loaded or under unloading. */
> +static struct module *try_module_get_by_name(const char *name)
> +{
> +	struct module *mod;
> +
> +	rcu_read_lock_sched();
> +	mod = find_module(name);
> +	if (mod && !try_module_get(mod))
> +		mod = NULL;
> +	rcu_read_unlock_sched();
> +
> +	return mod;
> +}
> +#else
> +#define try_module_get_by_name(name)	(NULL)
> +#endif
> +
> +static int validate_probe_symbol(char *symbol)
> +{
> +	struct module *mod = NULL;
> +	char *modname = NULL, *p;
> +	int ret = 0;
> +
> +	p = strchr(symbol, ':');
> +	if (p) {
> +		modname = symbol;
> +		symbol = p + 1;
> +		*p = '\0';
> +		mod = try_module_get_by_name(modname);
> +		if (!mod)
> +			goto out;
> +	}
> +
> +	ret = validate_module_probe_symbol(modname, symbol);
> +out:
> +	if (p)
> +		*p = ':';
> +	if (mod)
> +		module_put(mod);
> +	return ret;
> +}
> +
>  static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs);
>  
> @@ -881,6 +960,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			trace_probe_log_err(0, BAD_PROBE_ADDR);
>  			goto parse_error;
>  		}
> +		ret = validate_probe_symbol(symbol);
> +		if (ret) {
> +			if (ret == -EADDRNOTAVAIL)
> +				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> +			else
> +				trace_probe_log_err(0, BAD_PROBE_ADDR);
> +			goto parse_error;
> +		}
>  		if (is_return)
>  			ctx.flags |= TPARG_FL_RETURN;
>  		ret = kprobe_on_func_entry(NULL, symbol, offset);
> @@ -893,31 +980,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		}
>  	}
>  
> -	if (symbol && !strchr(symbol, ':')) {
> -		unsigned int count;
> -
> -		count = number_of_same_symbols(symbol);
> -		if (count > 1) {
> -			/*
> -			 * Users should use ADDR to remove the ambiguity of
> -			 * using KSYM only.
> -			 */
> -			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> -			ret = -EADDRNOTAVAIL;
> -
> -			goto error;
> -		} else if (count == 0) {
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			trace_probe_log_err(0, BAD_PROBE_ADDR);
> -			ret = -ENOENT;
> -
> -			goto error;
> -		}
> -	}
> -
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1835,21 +1897,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	char *event;
>  
>  	if (func) {
> -		unsigned int count;
> -
> -		count = number_of_same_symbols(func);
> -		if (count > 1)
> -			/*
> -			 * Users should use addr to remove the ambiguity of
> -			 * using func only.
> -			 */
> -			return ERR_PTR(-EADDRNOTAVAIL);
> -		else if (count == 0)
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			return ERR_PTR(-ENOENT);
> +		ret = validate_probe_symbol(func);
> +		if (ret)
> +			return ERR_PTR(ret);
>  	}
>  
>  	/*
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

