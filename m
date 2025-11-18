Return-Path: <bpf+bounces-74907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F05C678AA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B4F0A2A260
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482782D94BD;
	Tue, 18 Nov 2025 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDiebEdZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211D2D9ED7;
	Tue, 18 Nov 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443181; cv=none; b=POC5JmOLuOcmd0+HKxExu05s84C7J60T0qKAyF7x9EB3mVVX3lSYc/QrhpM6rAWBPwdRdr1JtOP8Dl9SbWU8RcdkAFdVdcOdqO9ww+DdJ4apkl9x7x1C5+giCruajDEkbNRc7CaGilE0wybGXdXwAkJZKs0tAvyUUzT9gG6fasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443181; c=relaxed/simple;
	bh=/YPyjtmS64rqD8F/37sAXvIOgLg0opOwbtldDJY85/w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BalYTGPeWcoFzQRh+SKQOO7X4z/ThF+rYZmZcxsg523wMA0mTQwafrYW9O6/dhJlq1Vw9HHkwXl6YG06HPVBAH87UWtcJbZHOXqmjZkX3dUAptozZOR7JXF576a/1Q3r0dncK0qM2xZDc47J/ZgKyJtV1iAQlzpjJXIAFLMVCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDiebEdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88228C4CEF1;
	Tue, 18 Nov 2025 05:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763443181;
	bh=/YPyjtmS64rqD8F/37sAXvIOgLg0opOwbtldDJY85/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TDiebEdZoU4qXG0Nhd8ffcMViKp2wgqy+xh2/9cssPBEZiDYOeD/76J56TH2C8gUO
	 QZavxwl304j5vLz9b5DG/OkATMV/6x080MUrL3WX3TqJrFdLM0v2oRps+jQtHtIhrY
	 fJxk6rh6d443TfCpeem9b3sJ3IM3hZ+usY/2Hmux0bZG9jaUmCeETYrueWkFlauBbU
	 eZ9JCRDSFXRV3mCWaxTHvk5sreOYyI3DY+b0G1tiIWV4rxTyorTz0uVTZY46RoQS++
	 z2HKKHlJq0Y4YQprRW9MIO6kRl7maqvjg3piENKgbwXpD3eDudEzENONDeA0HQxb2Y
	 MtBOuh0FNVtUA==
Date: Tue, 18 Nov 2025 14:19:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
Message-Id: <20251118141934.ddf14aabf371d0939415b588@kernel.org>
In-Reply-To: <20251117034906.32036-2-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
	<20251117034906.32036-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 11:49:01 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, the "nop" will be replaced with a "call" instruction when a
> function is hooked by the ftrace. However, sometimes the "call" can break
> the RSB and introduce extra overhead. Therefore, introduce the flag
> FTRACE_OPS_FL_JMP, which indicate that the ftrace_ops should be called
> with a "jmp" instead of "call". For now, it is only used by the direct
> call case.
> 
> When a direct ftrace_ops is marked with FTRACE_OPS_FL_JMP, the last bit of
> the ops->direct_call will be set to 1. Therefore, we can tell if we should
> use "jmp" for the callback in ftrace_call_replace().
> 

nit: Is it sure the last bit is always 0?
At least register_ftrace_direct() needs to reject if @addr
parameter has the last bit.

Thanks,


> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/ftrace.h | 33 +++++++++++++++++++++++++++++++++
>  kernel/trace/Kconfig   | 12 ++++++++++++
>  kernel/trace/ftrace.c  |  9 ++++++++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 07f8c309e432..015dd1049bea 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -359,6 +359,7 @@ enum {
>  	FTRACE_OPS_FL_DIRECT			= BIT(17),
>  	FTRACE_OPS_FL_SUBOP			= BIT(18),
>  	FTRACE_OPS_FL_GRAPH			= BIT(19),
> +	FTRACE_OPS_FL_JMP			= BIT(20),
>  };
>  
>  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> @@ -577,6 +578,38 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
>  						 unsigned long addr) { }
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> +static inline bool ftrace_is_jmp(unsigned long addr)
> +{
> +	return addr & 1;
> +}
> +
> +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> +{
> +	return addr | 1UL;
> +}
> +
> +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> +{
> +	return addr & ~1UL;
> +}
> +#else
> +static inline bool ftrace_is_jmp(unsigned long addr)
> +{
> +	return false;
> +}
> +
> +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> +{
> +	return addr;
> +}
> +
> +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> +{
> +	return addr;
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_JMP */
> +
>  #ifdef CONFIG_STACK_TRACER
>  
>  int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d2c79da81e4f..4661b9e606e0 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -80,6 +80,12 @@ config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  	  If the architecture generates __patchable_function_entries sections
>  	  but does not want them included in the ftrace locations.
>  
> +config HAVE_DYNAMIC_FTRACE_WITH_JMP
> +	bool
> +	help
> +	  If the architecture supports to replace the __fentry__ with a
> +	  "jmp" instruction.
> +
>  config HAVE_SYSCALL_TRACEPOINTS
>  	bool
>  	help
> @@ -330,6 +336,12 @@ config DYNAMIC_FTRACE_WITH_ARGS
>  	depends on DYNAMIC_FTRACE
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  
> +config DYNAMIC_FTRACE_WITH_JMP
> +	def_bool y
> +	depends on DYNAMIC_FTRACE
> +	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	depends on HAVE_DYNAMIC_FTRACE_WITH_JMP
> +
>  config FPROBE
>  	bool "Kernel Function Probe (fprobe)"
>  	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 59cfacb8a5bb..a6c060a4f50b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5951,7 +5951,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
>  			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> -			if (del && del->direct == addr) {
> +			if (del && ftrace_jmp_get(del->direct) ==
> +				   ftrace_jmp_get(addr)) {
>  				remove_hash_entry(direct_functions, del);
>  				kfree(del);
>  			}
> @@ -6018,6 +6019,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	mutex_lock(&direct_mutex);
>  
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);
> +
>  	/* Make sure requested entries are not already registered.. */
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {
> @@ -6138,6 +6142,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	lockdep_assert_held_once(&direct_mutex);
>  
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);
> +
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
>  	tmp_ops.func_hash = ops->func_hash;
> -- 
> 2.51.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

