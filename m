Return-Path: <bpf+bounces-74913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52CC67ACA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 349F729FCE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9BC2DECB2;
	Tue, 18 Nov 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRXD9yL+"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F02DCF61
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446496; cv=none; b=XfuDbZ17CWNuMU/9mFKLulM8q+aUnw3gEQM6LftK6tgyF+c75P0NpCtsd8eeuYUi413q/uBdx1vlLMEwokW54dqCoWKeOKdYdopFdHR3FvxR9z5w4x2RgJEASpgg0NBl4xouz4enw6f4pbts9LjojODYQv7jSOkYH/OM7Hfj+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446496; c=relaxed/simple;
	bh=bZKhC/9pHM2OhW9A8oqEw1f724OyL72cSiaQ5mv6xfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRi0F8RaJUHit70GwT3AKJbFgE0/QGaNWMTF5fPK13Z2rdwyziEGux94itcGe/46R38M+fXNMilMV1Htk+aYH/Ji2BDXzKL7KdK2ejWKVA9mXvoBtr1Gkq4Hii7Wu3cDstgILIfULmw9kocuq82OdLtWXYFGFXHptG61LRp9EUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRXD9yL+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763446482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+uJWaOSYPKggGl3M3hqwySeOMhBjwZn0c/x2/Zzb4JM=;
	b=iRXD9yL+FFqXZWeZA2HtW0dPUQR9fnJcgmdGr3Dnh53y1dP/xbnVmpE7m5lnVn5c8gRjI+
	v5y0WPwbxpqgP3vIhqZrfGtBrXsAu4JTpcNlQInGg3HuN9Gdb52WJo0SCwuXpGPdQYBFxP
	fCz7duZ5E9V/mAMKrF9wdeRNzZtYW9k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
Date: Tue, 18 Nov 2025 14:14:32 +0800
Message-ID: <4693872.LvFx2qVVIh@7950hx>
In-Reply-To: <20251118141934.ddf14aabf371d0939415b588@kernel.org>
References:
 <20251117034906.32036-1-dongml2@chinatelecom.cn>
 <20251117034906.32036-2-dongml2@chinatelecom.cn>
 <20251118141934.ddf14aabf371d0939415b588@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/18 13:19, Masami Hiramatsu wrote:
> On Mon, 17 Nov 2025 11:49:01 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > For now, the "nop" will be replaced with a "call" instruction when a
> > function is hooked by the ftrace. However, sometimes the "call" can break
> > the RSB and introduce extra overhead. Therefore, introduce the flag
> > FTRACE_OPS_FL_JMP, which indicate that the ftrace_ops should be called
> > with a "jmp" instead of "call". For now, it is only used by the direct
> > call case.
> > 
> > When a direct ftrace_ops is marked with FTRACE_OPS_FL_JMP, the last bit of
> > the ops->direct_call will be set to 1. Therefore, we can tell if we should
> > use "jmp" for the callback in ftrace_call_replace().
> > 
> 
> nit: Is it sure the last bit is always 0?

AFAIK, the function address is 16-bytes aligned for x86_64, and
8-bytes aligned for arm64, so I guess it is.

In the feature, if there is a exception, we can make ftrace_jmp_set,
ftrace_jmp_get arch-specification.

> At least register_ftrace_direct() needs to reject if @addr
> parameter has the last bit.

That make sense, I'll add such checking in the next version.

Thanks!
Menglong Dong

> 
> Thanks,
> 
> 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/ftrace.h | 33 +++++++++++++++++++++++++++++++++
> >  kernel/trace/Kconfig   | 12 ++++++++++++
> >  kernel/trace/ftrace.c  |  9 ++++++++-
> >  3 files changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 07f8c309e432..015dd1049bea 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -359,6 +359,7 @@ enum {
> >  	FTRACE_OPS_FL_DIRECT			= BIT(17),
> >  	FTRACE_OPS_FL_SUBOP			= BIT(18),
> >  	FTRACE_OPS_FL_GRAPH			= BIT(19),
> > +	FTRACE_OPS_FL_JMP			= BIT(20),
> >  };
> >  
> >  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > @@ -577,6 +578,38 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
> >  						 unsigned long addr) { }
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> > +static inline bool ftrace_is_jmp(unsigned long addr)
> > +{
> > +	return addr & 1;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> > +{
> > +	return addr | 1UL;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> > +{
> > +	return addr & ~1UL;
> > +}
> > +#else
> > +static inline bool ftrace_is_jmp(unsigned long addr)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> > +{
> > +	return addr;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> > +{
> > +	return addr;
> > +}
> > +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_JMP */
> > +
> >  #ifdef CONFIG_STACK_TRACER
> >  
> >  int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d2c79da81e4f..4661b9e606e0 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -80,6 +80,12 @@ config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> >  	  If the architecture generates __patchable_function_entries sections
> >  	  but does not want them included in the ftrace locations.
> >  
> > +config HAVE_DYNAMIC_FTRACE_WITH_JMP
> > +	bool
> > +	help
> > +	  If the architecture supports to replace the __fentry__ with a
> > +	  "jmp" instruction.
> > +
> >  config HAVE_SYSCALL_TRACEPOINTS
> >  	bool
> >  	help
> > @@ -330,6 +336,12 @@ config DYNAMIC_FTRACE_WITH_ARGS
> >  	depends on DYNAMIC_FTRACE
> >  	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  
> > +config DYNAMIC_FTRACE_WITH_JMP
> > +	def_bool y
> > +	depends on DYNAMIC_FTRACE
> > +	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +	depends on HAVE_DYNAMIC_FTRACE_WITH_JMP
> > +
> >  config FPROBE
> >  	bool "Kernel Function Probe (fprobe)"
> >  	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 59cfacb8a5bb..a6c060a4f50b 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5951,7 +5951,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
> >  	for (i = 0; i < size; i++) {
> >  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> >  			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> > -			if (del && del->direct == addr) {
> > +			if (del && ftrace_jmp_get(del->direct) ==
> > +				   ftrace_jmp_get(addr)) {
> >  				remove_hash_entry(direct_functions, del);
> >  				kfree(del);
> >  			}
> > @@ -6018,6 +6019,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  
> >  	mutex_lock(&direct_mutex);
> >  
> > +	if (ops->flags & FTRACE_OPS_FL_JMP)
> > +		addr = ftrace_jmp_set(addr);
> > +
> >  	/* Make sure requested entries are not already registered.. */
> >  	size = 1 << hash->size_bits;
> >  	for (i = 0; i < size; i++) {
> > @@ -6138,6 +6142,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  
> >  	lockdep_assert_held_once(&direct_mutex);
> >  
> > +	if (ops->flags & FTRACE_OPS_FL_JMP)
> > +		addr = ftrace_jmp_set(addr);
> > +
> >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> >  	ftrace_ops_init(&tmp_ops);
> >  	tmp_ops.func_hash = ops->func_hash;
> 
> 
> 





