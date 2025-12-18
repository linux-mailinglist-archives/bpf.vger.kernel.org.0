Return-Path: <bpf+bounces-77001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA25CCCD1E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52A43065AE0
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C1358D18;
	Thu, 18 Dec 2025 16:24:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E163587CE;
	Thu, 18 Dec 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075078; cv=none; b=i5BmPz2d3DSj039/0LSot0J02lFE9e6txviS8IyfyoDgkzuIXqyBHawYS08lYz5M9L4lvn+7INH37AQWqTL0ISci+Z8ZhbMQOcvaU6tTXaCuiXDjXiPNyvVi23cnIatkEzdyU/oyFLIPqkjga3iIOYl5v0BalW2NTen6MSRoCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075078; c=relaxed/simple;
	bh=ZpbNHDl1Wg9CETvXIpYfsYLVB92j2AUgonJFYXChFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbUkl6wkGsD52AGOyZt1Hl3cvE6Awoc86CXhNMI3P+LplgjykTRWkfrhoSYpO3VIRNiwOEM+OAQi66FzhKiY79eXpNT98iznwYvtpES1VT1Vtl5grPUcvrA8JVkjXSEGK8r1Q0JefYK8gn+ZCv1aMxtUKgpqkkZ3bPRqS/fc2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2B4B9B7B78;
	Thu, 18 Dec 2025 16:24:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 8900A1C;
	Thu, 18 Dec 2025 16:24:30 +0000 (UTC)
Date: Thu, 18 Dec 2025 11:26:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu
 <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 9/9] bpf,x86: Use single ftrace_ops for
 direct calls
Message-ID: <20251218112608.11a14a4a@gandalf.local.home>
In-Reply-To: <20251215211402.353056-10-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-10-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8900A1C
X-Stat-Signature: 3rg4m8mdk7kgyuoy3wyzqdfchtb4ba1o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Wxinr2kUG5CTEFtGPiQEqKdXtzEHugmk=
X-HE-Tag: 1766075070-774710
X-HE-Meta: U2FsdGVkX1+8ZGfxzw4Y/vqIa2d/4fxCwUbZfKeSYVcJoZDdMq3rOm8wvy7D4hgCnCXD7wK4d21iApT/7BDlEHVk1IomY5EpCExqf/kM3Brmztf5zyulMLyHoVMzreUynhZ6pl6QtFWW6ERofSsY+/WdVSFWZWoEmYkB+F/DmIN/oJmZpfiq1XefUSS2gB/45FzdF5jL4QvP6uMYwS2c2tBDMbjUKD7CyJlh+GWd0eivAMyrj7EWwgPwE2AXnlBQZAHtcYISu0kQNuNQ2RPWxQ5AcTYw8HzA6Jx02OiehlfO6okqmhJMiwumFl5eHvZ3kVzoiTYPjkIR5nsfYZy/QyrsVhkxSxtb

On Mon, 15 Dec 2025 22:14:02 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Using single ftrace_ops for direct calls update instead of allocating
> ftrace_ops object for each trampoline.
> 
> With single ftrace_ops object we can use update_ftrace_direct_* api
> that allows multiple ip sites updates on single ftrace_ops object.
> 
> Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
> each arch that supports this.
> 
> At the moment we can enable this only on x86 arch, because arm relies
> on ftrace_ops object representing just single trampoline image (stored
> in ftrace_ops::direct_call). Ach that do not support this will continue

My back "Ach" and doesn't support me well. ;-)

> to use *_ftrace_direct api.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/Kconfig        |   1 +
>  kernel/bpf/trampoline.c | 195 ++++++++++++++++++++++++++++++++++------
>  kernel/trace/Kconfig    |   3 +
>  kernel/trace/ftrace.c   |   7 +-
>  4 files changed, 177 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 17a107cc5244..d0c36e49e66e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -335,6 +335,7 @@ config X86
>  	select SCHED_SMT			if SMP
>  	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>  	select ARCH_SUPPORTS_SCHED_MC		if SMP
> +	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS

You can remove the "&& DYNAMIC_FTRACE_WITH_DIRECT_CALLS" part by having the
config depend on it (see below).

>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 17af2aad8382..02371db3db3e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -33,12 +33,40 @@ static DEFINE_MUTEX(trampoline_mutex);
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
>  
> +#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS

Make this:

 #ifdef CONFIG_SINGLE_FTRACE_DIRECT_OPS

for the suggested modification in the Kconfig below.

> +static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
> +{
> +	struct hlist_head *head_ip;
> +	struct bpf_trampoline *tr;
> +
> +	mutex_lock(&trampoline_mutex);

	guard(mutex)(&trampoline_mutex);

> +	head_ip = &trampoline_ip_table[hash_64(ip, TRAMPOLINE_HASH_BITS)];
> +	hlist_for_each_entry(tr, head_ip, hlist_ip) {
> +		if (tr->ip == ip)

			return NULL;

> +			goto out;
> +	}


> +	tr = NULL;
> +out:
> +	mutex_unlock(&trampoline_mutex);

No need for the above

> +	return tr;
> +}
> +#else
> +static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
> +{
> +	return ops->private;
> +}
> +#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
> +
>  static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
>  				     enum ftrace_ops_cmd cmd)
>  {
> -	struct bpf_trampoline *tr = ops->private;
> +	struct bpf_trampoline *tr;
>  	int ret = 0;
>  
> +	tr = direct_ops_ip_lookup(ops, ip);
> +	if (!tr)
> +		return -EINVAL;
> +
>  	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
>  		/* This is called inside register_ftrace_direct_multi(), so
>  		 * tr->mutex is already locked.
> @@ -137,6 +165,139 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>  			   PAGE_SIZE, true, ksym->name);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS

Replace the above two with:

 #ifdef CONFIG_SINGLE_FTRACE_DIRECT_OPS

> +/*
> + * We have only single direct_ops which contains all the direct call
> + * sites and is the only global ftrace_ops for all trampolines.
> + *
> + * We use 'update_ftrace_direct_*' api for attachment.
> + */
> +struct ftrace_ops direct_ops = {
> +	.ops_func = bpf_tramp_ftrace_ops_func,
> +};
> +
> +static int direct_ops_alloc(struct bpf_trampoline *tr)
> +{
> +	tr->fops = &direct_ops;
> +	return 0;
> +}
> +
> +static void direct_ops_free(struct bpf_trampoline *tr) { }
> +
> +static struct ftrace_hash *hash_from_ip(struct bpf_trampoline *tr, void *ptr)
> +{
> +	unsigned long ip, addr = (unsigned long) ptr;
> +	struct ftrace_hash *hash;
> +
> +	ip = ftrace_location(tr->ip);
> +	if (!ip)
> +		return NULL;
> +	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!hash)
> +		return NULL;
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +	if (!add_hash_entry_direct(hash, ip, addr)) {
> +		free_ftrace_hash(hash);
> +		return NULL;
> +	}
> +	return hash;
> +}
> +
> +static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
> +{
> +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> +	int err = -ENOMEM;
> +
> +	if (hash)
> +		err = update_ftrace_direct_add(tr->fops, hash);
> +	free_ftrace_hash(hash);
> +	return err;
> +}

I think these functions would be cleaner as:

{
	struct ftrace_hash *hash = hash_from_ip(tr, addr);
	int err;

	if (!hash)
		return -ENOMEM;

	err = update_ftrace_direct_*(tr->fops, hash);
	free_ftrace_hash(hash);
	return err;
}


> +
> +static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
> +{
> +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> +	int err = -ENOMEM;
> +
> +	if (hash)
> +		err = update_ftrace_direct_del(tr->fops, hash);
> +	free_ftrace_hash(hash);
> +	return err;
> +}
> +
> +static int direct_ops_mod(struct bpf_trampoline *tr, void *addr, bool lock_direct_mutex)
> +{
> +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> +	int err = -ENOMEM;
> +
> +	if (hash)
> +		err = update_ftrace_direct_mod(tr->fops, hash, lock_direct_mutex);
> +	free_ftrace_hash(hash);
> +	return err;
> +}
> +#else
> +/*
> + * We allocate ftrace_ops object for each trampoline and it contains
> + * call site specific for that trampoline.
> + *
> + * We use *_ftrace_direct api for attachment.
> + */
> +static int direct_ops_alloc(struct bpf_trampoline *tr)
> +{
> +	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
> +	if (!tr->fops)
> +		return -ENOMEM;
> +	tr->fops->private = tr;
> +	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
> +	return 0;
> +}
> +
> +static void direct_ops_free(struct bpf_trampoline *tr)
> +{
> +	if (tr->fops) {
> +		ftrace_free_filter(tr->fops);
> +		kfree(tr->fops);
> +	}
> +}

Why not:

static void direct_ops_free(struct bpf_trampoline *tr)
{
	if (!tr->fops)
		return;

	ftrace_free_filter(tr->fops);
	kfree(tr->fops);
}

 ?

> +
> +static int direct_ops_add(struct bpf_trampoline *tr, void *ptr)
> +{
> +	unsigned long addr = (unsigned long) ptr;
> +	struct ftrace_ops *ops = tr->fops;
> +	int ret;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +
> +	ret = ftrace_set_filter_ip(ops, tr->ip, 0, 1);
> +	if (ret)
> +		return ret;
> +	return register_ftrace_direct(ops, addr);
> +}
> +
> +static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
> +{
> +	return unregister_ftrace_direct(tr->fops, (long)addr, false);
> +}
> +
> +static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
> +{
> +	unsigned long addr = (unsigned long) ptr;
> +	struct ftrace_ops *ops = tr->fops;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +	if (lock_direct_mutex)
> +		return modify_ftrace_direct(ops, addr);
> +	return modify_ftrace_direct_nolock(ops, addr);
> +}
> +#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
> +#else
> +static void direct_ops_free(struct bpf_trampoline *tr) { }

This is somewhat inconsistent with direct_ops_alloc() that has:

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
	if (direct_ops_alloc(tr)) {
		kfree(tr);
		tr = NULL;
		goto out;
	}
#endif

Now, if you wrap the direct_ops_free() too, we can remove the
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
part with my kconfig suggestion. Otherwise keep the kconfig as is, but I
would add a stub function for direct_ops_alloc() too.

> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> +
>  static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
>  {
>  	struct bpf_trampoline *tr;
> @@ -155,14 +316,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
>  	if (!tr)
>  		goto out;
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> -	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
> -	if (!tr->fops) {
> +	if (direct_ops_alloc(tr)) {
>  		kfree(tr);
>  		tr = NULL;
>  		goto out;
>  	}
> -	tr->fops->private = tr;
> -	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
>  #endif
>  
>  	tr->key = key;
> @@ -206,7 +364,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
>  	int ret;
>  
>  	if (tr->func.ftrace_managed)
> -		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
> +		ret = direct_ops_del(tr, old_addr);

Doesn't this need a wrapper too?

>  	else
>  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
>  
> @@ -220,15 +378,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
>  	int ret;
>  
>  	if (tr->func.ftrace_managed) {
> -		unsigned long addr = (unsigned long) new_addr;
> -
> -		if (bpf_trampoline_use_jmp(tr->flags))
> -			addr = ftrace_jmp_set(addr);
> -
> -		if (lock_direct_mutex)
> -			ret = modify_ftrace_direct(tr->fops, addr);
> -		else
> -			ret = modify_ftrace_direct_nolock(tr->fops, addr);
> +		ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);

and this.

>  	} else {
>  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
>  						   new_addr);
> @@ -251,15 +401,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  	}
>  
>  	if (tr->func.ftrace_managed) {
> -		unsigned long addr = (unsigned long) new_addr;
> -
> -		if (bpf_trampoline_use_jmp(tr->flags))
> -			addr = ftrace_jmp_set(addr);
> -
> -		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> -		if (ret)
> -			return ret;
> -		ret = register_ftrace_direct(tr->fops, addr);
> +		ret = direct_ops_add(tr, new_addr);

Ditto.

>  	} else {
>  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
>  	}
> @@ -910,10 +1052,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>  	 */
>  	hlist_del(&tr->hlist_key);
>  	hlist_del(&tr->hlist_ip);
> -	if (tr->fops) {
> -		ftrace_free_filter(tr->fops);
> -		kfree(tr->fops);
> -	}
> +	direct_ops_free(tr);
>  	kfree(tr);
>  out:
>  	mutex_unlock(&trampoline_mutex);
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 4661b9e606e0..1ad2e307c834 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
>  config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	bool
>  
> +config HAVE_SINGLE_FTRACE_DIRECT_OPS
> +	bool
> +

Now you could add:

  config SINGLE_FTRACE_DIRECT_OPS
	bool
	default y
	depends on HAVE_SINGLE_FTRACE_DIRECT_OPS && DYNAMIC_FTRACE_WITH_DIRECT_CALLS

-- Steve


>  config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
>  	bool 
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c2054fe80de7..a0789727b971 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2605,8 +2605,13 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
>  static void call_direct_funcs(unsigned long ip, unsigned long pip,
>  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -	unsigned long addr = READ_ONCE(ops->direct_call);
> +	unsigned long addr;
>  
> +#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> +	addr = ftrace_find_rec_direct(ip);
> +#else
> +	addr = READ_ONCE(ops->direct_call);
> +#endif
>  	if (!addr)
>  		return;
>  


