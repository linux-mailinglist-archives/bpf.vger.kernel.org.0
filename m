Return-Path: <bpf+bounces-77143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D10CCF216
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D8A301D60B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9BE2F28E3;
	Fri, 19 Dec 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQV+57sR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E162C030E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136483; cv=none; b=E1Sdrvf7i0BBFmSDgLxGo3q+5Jbai0qoclMFFQfs3kyxcOMZ4vHUHGLKAJ6jkULpmNJczsQZnSBfQS+xHBImOpLJr4myNzwOOIHAvqLzv2Ixth6ucfrxn1vQ7LX4h/8GtNYfKTslzEkyYWzzceTouCBplFzbMu0AAGTjoev1DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136483; c=relaxed/simple;
	bh=0AlBx06Eu21z/jJ57GZXbgjr3e6fq7+/15ATFqwEuB0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz3pGFmQo3wFadGmdQ9cXFq6Gxa2UQQVu9SZU83EE2nKyT+DBJhhZMIAU1+VnEu85lsLLizsng8Y0ES1XOZwSgphisVSfUrI09yy9HQU4ArYfn24hmFp5gRGecfOM/2EWZnU2Re6EQmdFf8B9gp/YLwZvkFYIrseZioFvbjHjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQV+57sR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb3801f7eso806256f8f.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136479; x=1766741279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9oGgjLnB4BRLCSerYoS0OtPGacv8L+vjRrbT/ZyiNdM=;
        b=YQV+57sRTQ/ldOL6/G4LlgWF7CuVRaLm64AUqtMWJ5/mMJUA5oX+5sqdz3xopepMmY
         clJLtazQo7UKQlNYDM8W6S2nP46Huamz9/cCxFzvUxK3noTKB+rWQJjk65vzhZelNG8m
         XFCQ3ZPG/ex/v9NTEsnytoY+KIzeuEsReHfTnNqBWLaYP03Woba8fR5ypC0zWFVC9lkQ
         tRVBfR7W6HY/r0UFxuixQliERqJ0Lwv9S6C08Mh6Qen7AtZcDDkDXRhg5R7VybPJJAxc
         nSGzZIyJJ2Aw8XHILreaG7W0cAfouAnYnt5JPWqn8Rba0A7v08a9gGmDbDSfjBCszZzy
         LrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136479; x=1766741279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oGgjLnB4BRLCSerYoS0OtPGacv8L+vjRrbT/ZyiNdM=;
        b=fuszDFP/lhUm5CiM16jQFU0ziQ702E3yDjGpZjihhIwToB2II4hW0J85MlkZm06E8f
         H52sLmuozRBRfaez7E1EFgfM/WxdzOC8couZsfoJuoO/5o6AB4YnOuWcJGkLXYlYHMcY
         8tIqTilldK7EUT2d14oWqj5Gl70eIExaZq18sYs02C2zCLg+sTFKtODmjR4Dgs9NUaKw
         B1mopBUh7Mart7XbOMNa81w6aIt1eiBMDu0u312cha2dOFOFLOmF2m+LG0u0hqpzO7/n
         C58TFp5EKFC3Zi0jAKATgWTbw9K2H9Q5kcxFeqa3+g+4r/8xU5NjNMmnbuGaPlpg7OH3
         JUEg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7GPfZ8M0MmMhdnm1HlC+uGXrEAL/zQHxJdbSOirlAQq9gnCiSELT3RwBpz+v06ltFlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi37qnb5eL1CIRvoMkYMQiE0/2Suqy3SbznZOuJQXkil6pQzNk
	Arz+eolxbDPlvVBHEokkKT7dOl5yP6rfFVSvrY9Pgo9fe3KrArMScws+
X-Gm-Gg: AY/fxX78+meDne1oqNOyQQYK+B+5I0l5xFnf0llZtJN+m5g4hL5mNbnGHXP/6sz1IDU
	UknlRzNdPkyan5T0keC/qpg+9ZuqZWwEUpEJv0ja6soU5MYGQzQI3oPVk3VZHdlFHgdi7oLN1hb
	Ea31lA4mbLHayj4qayKEHAtPuU55iWKHc1PFy9ReleK5WQOgAEUGNW5wgMWZ/9x3KZ17gVFtFbf
	s20cUdB+8y5WbF6QSupIJ78ct+HBgHfVNR2/eWy1bCxpDuoThSrd9dmfD8Rpsj1SQRTh3HAf3a/
	iPvaDkKpoJsbhetyPlA0JiIVuzKg0uc4LQBdv+uMF4bjXvg+JEMPJuVmjA4PGQtOmwS73+4rZG0
	q9aJqUgqvGb1vfiZQRQAeyHgtO9467uK4Vm3kXIftX5UI20QkxScAfFMWZpy4
X-Google-Smtp-Source: AGHT+IFl2szXlrHSULap4BBtRF/o7UsYp3zfggM0fI3SQpbqWNjjL70eotggPkLeDniNhGFRNl34Jw==
X-Received: by 2002:a05:6000:2404:b0:42f:bb3f:c5f1 with SMTP id ffacd0b85a97d-4324e506738mr2441194f8f.44.1766136478888;
        Fri, 19 Dec 2025 01:27:58 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm3845068f8f.8.2025.12.19.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:56 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
Message-ID: <aUUanPijlWsDlS0X@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-10-jolsa@kernel.org>
 <20251218112608.11a14a4a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218112608.11a14a4a@gandalf.local.home>

On Thu, Dec 18, 2025 at 11:26:08AM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:14:02 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Using single ftrace_ops for direct calls update instead of allocating
> > ftrace_ops object for each trampoline.
> > 
> > With single ftrace_ops object we can use update_ftrace_direct_* api
> > that allows multiple ip sites updates on single ftrace_ops object.
> > 
> > Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
> > each arch that supports this.
> > 
> > At the moment we can enable this only on x86 arch, because arm relies
> > on ftrace_ops object representing just single trampoline image (stored
> > in ftrace_ops::direct_call). Ach that do not support this will continue
> 
> My back "Ach" and doesn't support me well. ;-)

heh, should have been 'Archs' ;-)

> 
> > to use *_ftrace_direct api.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/Kconfig        |   1 +
> >  kernel/bpf/trampoline.c | 195 ++++++++++++++++++++++++++++++++++------
> >  kernel/trace/Kconfig    |   3 +
> >  kernel/trace/ftrace.c   |   7 +-
> >  4 files changed, 177 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 17a107cc5244..d0c36e49e66e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -335,6 +335,7 @@ config X86
> >  	select SCHED_SMT			if SMP
> >  	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> >  	select ARCH_SUPPORTS_SCHED_MC		if SMP
> > +	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> 
> You can remove the "&& DYNAMIC_FTRACE_WITH_DIRECT_CALLS" part by having the
> config depend on it (see below).

...

> 
> >  
> >  config INSTRUCTION_DECODER
> >  	def_bool y
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 17af2aad8382..02371db3db3e 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -33,12 +33,40 @@ static DEFINE_MUTEX(trampoline_mutex);
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
> >  
> > +#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> 
> Make this:
> 
>  #ifdef CONFIG_SINGLE_FTRACE_DIRECT_OPS
> 
> for the suggested modification in the Kconfig below.
> 
> > +static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
> > +{
> > +	struct hlist_head *head_ip;
> > +	struct bpf_trampoline *tr;
> > +
> > +	mutex_lock(&trampoline_mutex);
> 
> 	guard(mutex)(&trampoline_mutex);

right, will change

> 
> > +	head_ip = &trampoline_ip_table[hash_64(ip, TRAMPOLINE_HASH_BITS)];
> > +	hlist_for_each_entry(tr, head_ip, hlist_ip) {
> > +		if (tr->ip == ip)
> 
> 			return NULL;
> 
> > +			goto out;
> > +	}
> 
> 
> > +	tr = NULL;
> > +out:
> > +	mutex_unlock(&trampoline_mutex);
> 
> No need for the above

yep

> 
> > +	return tr;
> > +}
> > +#else
> > +static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
> > +{
> > +	return ops->private;
> > +}
> > +#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
> > +
> >  static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
> >  				     enum ftrace_ops_cmd cmd)
> >  {
> > -	struct bpf_trampoline *tr = ops->private;
> > +	struct bpf_trampoline *tr;
> >  	int ret = 0;
> >  
> > +	tr = direct_ops_ip_lookup(ops, ip);
> > +	if (!tr)
> > +		return -EINVAL;
> > +
> >  	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
> >  		/* This is called inside register_ftrace_direct_multi(), so
> >  		 * tr->mutex is already locked.
> > @@ -137,6 +165,139 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
> >  			   PAGE_SIZE, true, ksym->name);
> >  }
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> 
> Replace the above two with:
> 
>  #ifdef CONFIG_SINGLE_FTRACE_DIRECT_OPS

...

> 
> > +/*
> > + * We have only single direct_ops which contains all the direct call
> > + * sites and is the only global ftrace_ops for all trampolines.
> > + *
> > + * We use 'update_ftrace_direct_*' api for attachment.
> > + */
> > +struct ftrace_ops direct_ops = {
> > +	.ops_func = bpf_tramp_ftrace_ops_func,
> > +};
> > +
> > +static int direct_ops_alloc(struct bpf_trampoline *tr)
> > +{
> > +	tr->fops = &direct_ops;
> > +	return 0;
> > +}
> > +
> > +static void direct_ops_free(struct bpf_trampoline *tr) { }
> > +
> > +static struct ftrace_hash *hash_from_ip(struct bpf_trampoline *tr, void *ptr)
> > +{
> > +	unsigned long ip, addr = (unsigned long) ptr;
> > +	struct ftrace_hash *hash;
> > +
> > +	ip = ftrace_location(tr->ip);
> > +	if (!ip)
> > +		return NULL;
> > +	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	if (!hash)
> > +		return NULL;
> > +	if (bpf_trampoline_use_jmp(tr->flags))
> > +		addr = ftrace_jmp_set(addr);
> > +	if (!add_hash_entry_direct(hash, ip, addr)) {
> > +		free_ftrace_hash(hash);
> > +		return NULL;
> > +	}
> > +	return hash;
> > +}
> > +
> > +static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
> > +{
> > +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> > +	int err = -ENOMEM;
> > +
> > +	if (hash)
> > +		err = update_ftrace_direct_add(tr->fops, hash);
> > +	free_ftrace_hash(hash);
> > +	return err;
> > +}
> 
> I think these functions would be cleaner as:
> 
> {
> 	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> 	int err;
> 
> 	if (!hash)
> 		return -ENOMEM;
> 
> 	err = update_ftrace_direct_*(tr->fops, hash);
> 	free_ftrace_hash(hash);
> 	return err;
> }

np, will change

> 
> 
> > +
> > +static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
> > +{
> > +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> > +	int err = -ENOMEM;
> > +
> > +	if (hash)
> > +		err = update_ftrace_direct_del(tr->fops, hash);
> > +	free_ftrace_hash(hash);
> > +	return err;
> > +}
> > +
> > +static int direct_ops_mod(struct bpf_trampoline *tr, void *addr, bool lock_direct_mutex)
> > +{
> > +	struct ftrace_hash *hash = hash_from_ip(tr, addr);
> > +	int err = -ENOMEM;
> > +
> > +	if (hash)
> > +		err = update_ftrace_direct_mod(tr->fops, hash, lock_direct_mutex);
> > +	free_ftrace_hash(hash);
> > +	return err;
> > +}
> > +#else
> > +/*
> > + * We allocate ftrace_ops object for each trampoline and it contains
> > + * call site specific for that trampoline.
> > + *
> > + * We use *_ftrace_direct api for attachment.
> > + */
> > +static int direct_ops_alloc(struct bpf_trampoline *tr)
> > +{
> > +	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
> > +	if (!tr->fops)
> > +		return -ENOMEM;
> > +	tr->fops->private = tr;
> > +	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
> > +	return 0;
> > +}
> > +
> > +static void direct_ops_free(struct bpf_trampoline *tr)
> > +{
> > +	if (tr->fops) {
> > +		ftrace_free_filter(tr->fops);
> > +		kfree(tr->fops);
> > +	}
> > +}
> 
> Why not:
> 
> static void direct_ops_free(struct bpf_trampoline *tr)
> {
> 	if (!tr->fops)
> 		return;
> 
> 	ftrace_free_filter(tr->fops);
> 	kfree(tr->fops);
> }

same pattern like above, ok

> 
>  ?
> 
> > +
> > +static int direct_ops_add(struct bpf_trampoline *tr, void *ptr)
> > +{
> > +	unsigned long addr = (unsigned long) ptr;
> > +	struct ftrace_ops *ops = tr->fops;
> > +	int ret;
> > +
> > +	if (bpf_trampoline_use_jmp(tr->flags))
> > +		addr = ftrace_jmp_set(addr);
> > +
> > +	ret = ftrace_set_filter_ip(ops, tr->ip, 0, 1);
> > +	if (ret)
> > +		return ret;
> > +	return register_ftrace_direct(ops, addr);
> > +}
> > +
> > +static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
> > +{
> > +	return unregister_ftrace_direct(tr->fops, (long)addr, false);
> > +}
> > +
> > +static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
> > +{
> > +	unsigned long addr = (unsigned long) ptr;
> > +	struct ftrace_ops *ops = tr->fops;
> > +
> > +	if (bpf_trampoline_use_jmp(tr->flags))
> > +		addr = ftrace_jmp_set(addr);
> > +	if (lock_direct_mutex)
> > +		return modify_ftrace_direct(ops, addr);
> > +	return modify_ftrace_direct_nolock(ops, addr);
> > +}
> > +#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
> > +#else
> > +static void direct_ops_free(struct bpf_trampoline *tr) { }
> 
> This is somewhat inconsistent with direct_ops_alloc() that has:
> 
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> 	if (direct_ops_alloc(tr)) {
> 		kfree(tr);
> 		tr = NULL;
> 		goto out;
> 	}
> #endif
> 
> Now, if you wrap the direct_ops_free() too, we can remove the
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> part with my kconfig suggestion. Otherwise keep the kconfig as is, but I
> would add a stub function for direct_ops_alloc() too.

ah right.. I think let's do the kconfig change you suggest to make
this simpler

> 
> > +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> > +
> >  static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> >  {
> >  	struct bpf_trampoline *tr;
> > @@ -155,14 +316,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> >  	if (!tr)
> >  		goto out;
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > -	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
> > -	if (!tr->fops) {
> > +	if (direct_ops_alloc(tr)) {
> >  		kfree(tr);
> >  		tr = NULL;
> >  		goto out;
> >  	}
> > -	tr->fops->private = tr;
> > -	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
> >  #endif
> >  
> >  	tr->key = key;
> > @@ -206,7 +364,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> >  	int ret;
> >  
> >  	if (tr->func.ftrace_managed)
> > -		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
> > +		ret = direct_ops_del(tr, old_addr);
> 
> Doesn't this need a wrapper too?

yep

> 
> >  	else
> >  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
> >  
> > @@ -220,15 +378,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> >  	int ret;
> >  
> >  	if (tr->func.ftrace_managed) {
> > -		unsigned long addr = (unsigned long) new_addr;
> > -
> > -		if (bpf_trampoline_use_jmp(tr->flags))
> > -			addr = ftrace_jmp_set(addr);
> > -
> > -		if (lock_direct_mutex)
> > -			ret = modify_ftrace_direct(tr->fops, addr);
> > -		else
> > -			ret = modify_ftrace_direct_nolock(tr->fops, addr);
> > +		ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);
> 
> and this.
> 
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
> >  						   new_addr);
> > @@ -251,15 +401,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >  	}
> >  
> >  	if (tr->func.ftrace_managed) {
> > -		unsigned long addr = (unsigned long) new_addr;
> > -
> > -		if (bpf_trampoline_use_jmp(tr->flags))
> > -			addr = ftrace_jmp_set(addr);
> > -
> > -		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> > -		if (ret)
> > -			return ret;
> > -		ret = register_ftrace_direct(tr->fops, addr);
> > +		ret = direct_ops_add(tr, new_addr);
> 
> Ditto.

yes

> 
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
> >  	}
> > @@ -910,10 +1052,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
> >  	 */
> >  	hlist_del(&tr->hlist_key);
> >  	hlist_del(&tr->hlist_ip);
> > -	if (tr->fops) {
> > -		ftrace_free_filter(tr->fops);
> > -		kfree(tr->fops);
> > -	}
> > +	direct_ops_free(tr);
> >  	kfree(tr);
> >  out:
> >  	mutex_unlock(&trampoline_mutex);
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 4661b9e606e0..1ad2e307c834 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
> >  config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  	bool
> >  
> > +config HAVE_SINGLE_FTRACE_DIRECT_OPS
> > +	bool
> > +
> 
> Now you could add:
> 
>   config SINGLE_FTRACE_DIRECT_OPS
> 	bool
> 	default y
> 	depends on HAVE_SINGLE_FTRACE_DIRECT_OPS && DYNAMIC_FTRACE_WITH_DIRECT_CALLS

ok, the dependency is more ovbvious, will change

thanks,
jirka

