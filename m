Return-Path: <bpf+bounces-77096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA0CCE321
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD7B830136D4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE212271470;
	Fri, 19 Dec 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJxedJom"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAC5CDF1;
	Fri, 19 Dec 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109473; cv=none; b=JlaLp17BgwshK0wrIjeskLqfIJV0lxhsofMYZ1b9x7kzHktMyxhJlitNscuvNAwPJmZQBosOguCjypwy5fumqE477DtnnOSpulINgw2GDLG2CYHDJirr2Xs5n3UmcI1SDKVRlXrzpdVoHRkqw/4TmeUZbZS8GS07Vh6p9c6t5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109473; c=relaxed/simple;
	bh=lpaMlxIEhJyEwIqqwTuJLYxojKd02q4oQzpXRDvwzC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THSHKaQCRwoedJw4vYy+059pC5v/8DS63bEugU/xIh8S/qWhbjocSXLnV4k/XW2SVB6c/NOUqrEp7V+F5FmQLV2ICXYjKMHAJtW0Y3tD6pK23yocaLl7mCZMTaro8golMr7CZWrLK9A+FNa/HnNmY1JNpKGq9O6CGVp54iagxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJxedJom; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U6luMjLnrIscrnqepE5K+dRE9Z44TEkLP++iEyfwA0=;
	b=UJxedJomCyWAMEgs1NejrEqLXTo5Jqm2WZUTVer7ty00Uny3pw+ZayADVWGuyRuIN/0Bdu
	siYU4F+TCETjQn/GqUHQBHfFrT0qgIIwbiCEnWm/DQ+4YgkrMmfmqpRYkMFsw9Ej5TDm3Z
	dpuHkBgKmEAE3CeIkw/4CLf1xCIPwWk=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 mhiramat@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 liujing40 <liujing.root@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, liujing40@xiaomi.com
Subject:
 Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
Date: Fri, 19 Dec 2025 09:57:37 +0800
Message-ID: <24197762.6Emhk5qWAg@7940hx>
In-Reply-To: <20251218130629.365398-3-liujing40@xiaomi.com>
References:
 <20251218130629.365398-1-liujing40@xiaomi.com>
 <20251218130629.365398-3-liujing40@xiaomi.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/18 21:06 liujing40 <liujing.root@gmail.com> write:
> When fprobe is not available, provide a fallback implementation of
> kprobe_multi using the traditional kretprobe API.
> 
> Uses kretprobe's entry_handler and handler callbacks to simulate fprobe's
> entry/exit functionality.
> 
> Signed-off-by: Jing Liu <liujing40@xiaomi.com>
> ---
>  kernel/trace/bpf_trace.c | 307 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 295 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1fd07c10378f..426a1c627508 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2274,12 +2274,44 @@ struct bpf_session_run_ctx {
>  	void *data;
>  };
>  
> -#ifdef CONFIG_FPROBE
> +#if defined(CONFIG_FPROBE) || defined(CONFIG_KRETPROBES)
> +#ifndef CONFIG_FPROBE
> +struct bpf_kprobe {
> +	struct bpf_kprobe_multi_link *link;
> +	u64 cookie;
> +	struct kretprobe rp;
> +};
> +
> +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> +{
> +	for (int i = 0; i < cnt; i++)
> +		unregister_kretprobe(&kps[i].rp);
> +}
> +
> +static int bpf_kprobe_register(struct bpf_kprobe *kps, u32 cnt)
> +{
> +	int ret = 0, i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = register_kretprobe(&kps[i].rp);
> +		if (ret < 0) {
> +			bpf_kprobe_unregister(kps, i);
> +			break;
> +		}
> +	}
> +	return ret;
> +}

Hi, Jing. I don't see the point of the fallback logic. If we want to
use the kprobe-multi, we enable CONFIG_FPROBE. Is there any reason
that we can't enable CONFIG_FPROBE? As you said, for a "old kernel",
I think we don't introduce new feature for an old kernel.

Besides, did you measure the performance of attaching bench?
You will register a kretprobe for each of the target. AFAIK, the
kprobe will use ftrace for optimization if we hook the entry of the
target function. So I suspect it will be quite slow here.

Thanks!
Menglong Dong

> +#endif
> +
>  struct bpf_kprobe_multi_link {
>  	struct bpf_link link;
> +#ifdef CONFIG_FPROBE
>  	struct fprobe fp;
>  	unsigned long *addrs;
>  	u64 *cookies;
> +#else
> +	struct bpf_kprobe *kprobes;
> +#endif
>  	u32 cnt;
>  	u32 mods_cnt;
>  	struct module **mods;
> @@ -2287,7 +2319,11 @@ struct bpf_kprobe_multi_link {
>  
>  struct bpf_kprobe_multi_run_ctx {
>  	struct bpf_session_run_ctx session_ctx;
> +#ifdef CONFIG_FPROBE
>  	struct bpf_kprobe_multi_link *link;
> +#else
> +	struct bpf_kprobe *kprobe;
> +#endif
>  	unsigned long entry_ip;
>  };
>  
> @@ -2304,7 +2340,11 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
>  	struct bpf_kprobe_multi_link *kmulti_link;
>  
>  	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +#ifdef CONFIG_FPROBE
>  	unregister_fprobe(&kmulti_link->fp);
> +#else
> +	bpf_kprobe_unregister(kmulti_link->kprobes, kmulti_link->cnt);
> +#endif
>  	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
>  }
>  
> @@ -2313,8 +2353,12 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>  	struct bpf_kprobe_multi_link *kmulti_link;
>  
>  	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +#ifdef CONFIG_FPROBE
>  	kvfree(kmulti_link->addrs);
>  	kvfree(kmulti_link->cookies);
> +#else
> +	kvfree(kmulti_link->kprobes);
> +#endif
>  	kfree(kmulti_link->mods);
>  	kfree(kmulti_link);
>  }
> @@ -2326,6 +2370,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
>  	struct bpf_kprobe_multi_link *kmulti_link;
>  	u32 ucount = info->kprobe_multi.count;
> +	bool kallsyms_show = kallsyms_show_value(current_cred());
>  	int err = 0, i;
>  
>  	if (!uaddrs ^ !ucount)
> @@ -2336,7 +2381,12 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>  	info->kprobe_multi.count = kmulti_link->cnt;
>  	info->kprobe_multi.flags = kmulti_link->link.flags;
> +#ifdef CONFIG_FPROBE
>  	info->kprobe_multi.missed = kmulti_link->fp.nmissed;
> +#else
> +	for (i = 0; i < kmulti_link->cnt; i++)
> +		info->kprobe_multi.missed += kmulti_link->kprobes[i].rp.nmissed;
> +#endif
>  
>  	if (!uaddrs)
>  		return 0;
> @@ -2345,6 +2395,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  	else
>  		ucount = kmulti_link->cnt;
>  
> +#ifdef CONFIG_FPROBE
>  	if (ucookies) {
>  		if (kmulti_link->cookies) {
>  			if (copy_to_user(ucookies, kmulti_link->cookies, ucount * sizeof(u64)))
> @@ -2357,7 +2408,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  		}
>  	}
>  
> -	if (kallsyms_show_value(current_cred())) {
> +	if (kallsyms_show) {
>  		if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
>  			return -EFAULT;
>  	} else {
> @@ -2366,6 +2417,16 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  				return -EFAULT;
>  		}
>  	}
> +#else
> +	for (i = 0; i < ucount; i++) {
> +		if (ucookies && put_user(kmulti_link->kprobes[i].cookie, ucookies + i))
> +			return -EFAULT;
> +
> +		if (put_user(kallsyms_show ? (uintptr_t)kmulti_link->kprobes[i].rp.kp.addr : 0,
> +					uaddrs + i))
> +			return -EFAULT;
> +	}
> +#endif
>  	return err;
>  }
>  
> @@ -2374,21 +2435,32 @@ static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
>  					 struct seq_file *seq)
>  {
>  	struct bpf_kprobe_multi_link *kmulti_link;
> +	unsigned long kprobe_multi_missed = 0;
>  
>  	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +#ifdef CONFIG_FPROBE
> +	kprobe_multi_missed =  kmulti_link->fp.nmissed;
> +#else
> +	for (int i = 0; i < kmulti_link->cnt; i++)
> +		kprobe_multi_missed += kmulti_link->kprobes[i].rp.nmissed;
> +#endif
>  
>  	seq_printf(seq,
>  		   "kprobe_cnt:\t%u\n"
>  		   "missed:\t%lu\n",
>  		   kmulti_link->cnt,
> -		   kmulti_link->fp.nmissed);
> +		   kprobe_multi_missed);
>  
>  	seq_printf(seq, "%s\t %s\n", "cookie", "func");
>  	for (int i = 0; i < kmulti_link->cnt; i++) {
> -		seq_printf(seq,
> -			   "%llu\t %pS\n",
> -			   kmulti_link->cookies[i],
> -			   (void *)kmulti_link->addrs[i]);
> +#ifdef CONFIG_FPROBE
> +		u64 cookie = kmulti_link->cookies[i];
> +		void *addr = (void *)kmulti_link->addrs[i];
> +#else
> +		u64 cookie = kmulti_link->kprobes[i].cookie;
> +		void *addr = (void *)kmulti_link->kprobes[i].rp.kp.addr;
> +#endif
> +		seq_printf(seq, "%llu\t %pS\n", cookie, addr);
>  	}
>  }
>  #endif
> @@ -2445,17 +2517,22 @@ static bool has_module(struct modules_array *arr, struct module *mod)
>  	return false;
>  }
>  
> -static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
> +static int get_modules_for_addrs(struct bpf_kprobe_multi_link *link)
>  {
>  	struct modules_array arr = {};
>  	u32 i, err = 0;
>  
> -	for (i = 0; i < addrs_cnt; i++) {
> +	for (i = 0; i < link->cnt; i++) {
>  		bool skip_add = false;
>  		struct module *mod;
> +#ifdef CONFIG_FPROBE
> +		unsigned long addr = link->addrs[i];
> +#else
> +		unsigned long addr = (unsigned long)link->kprobes[i].rp.kp.addr;
> +#endif
>  
>  		scoped_guard(rcu) {
> -			mod = __module_address(addrs[i]);
> +			mod = __module_address(addr);
>  			/* Either no module or it's already stored  */
>  			if (!mod || has_module(&arr, mod)) {
>  				skip_add = true;
> @@ -2483,10 +2560,11 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>  	}
>  
>  	/* or number of modules found if everything is ok. */
> -	*mods = arr.mods;
> +	link->mods = arr.mods;
>  	return arr.mods_cnt;
>  }
>  
> +#ifdef CONFIG_FPROBE
>  struct user_syms {
>  	const char **syms;
>  	char *buf;
> @@ -2843,7 +2921,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		       link);
>  	}
>  
> -	err = get_modules_for_addrs(&link->mods, addrs, cnt);
> +	err = get_modules_for_addrs(link);
>  	if (err < 0) {
>  		bpf_link_cleanup(&link_primer);
>  		return err;
> @@ -2866,6 +2944,211 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	return err;
>  }
>  #else /* !CONFIG_FPROBE */
> +static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
> +{
> +	struct bpf_kprobe_multi_run_ctx *run_ctx;
> +
> +	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
> +				   session_ctx.run_ctx);
> +	return run_ctx->kprobe->cookie;
> +}
> +
> +static __always_inline int
> +kprobe_multi_link_prog_run(struct bpf_kprobe *kprobe, unsigned long entry_ip,
> +			struct pt_regs *regs, bool is_return, void *data)
> +{
> +	struct bpf_kprobe_multi_link *link = kprobe->link;
> +	struct bpf_kprobe_multi_run_ctx run_ctx = {
> +		.session_ctx = {
> +			.is_return = is_return,
> +			.data = data,
> +		},
> +		.kprobe = kprobe,
> +		.entry_ip = entry_ip,
> +	};
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err;
> +
> +	cant_sleep();
> +
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +		bpf_prog_inc_misses_counter(link->link.prog);
> +		err = 1;
> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	migrate_disable();
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
> +	err = bpf_prog_run(link->link.prog, regs);
> +	bpf_reset_run_ctx(old_run_ctx);
> +	migrate_enable();
> +	rcu_read_unlock();
> +
> + out:
> +	__this_cpu_dec(bpf_prog_active);
> +	return err;
> +}
> +
> +static int
> +kprobe_multi_link_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> +{
> +	struct kretprobe *rp = get_kretprobe(ri);
> +	struct bpf_kprobe *kprobe;
> +	int err;
> +
> +	if (unlikely(!rp))
> +		return 1;
> +
> +	kprobe = container_of(rp, struct bpf_kprobe, rp);
> +	err = kprobe_multi_link_prog_run(kprobe, get_entry_ip((uintptr_t)rp->kp.addr),
> +							  		 regs, false, ri->data);
> +	return is_kprobe_session(kprobe->link->link.prog) ? err : 0;
> +}
> +
> +static int
> +kprobe_multi_link_exit_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> +{
> +	struct kretprobe *rp = get_kretprobe(ri);
> +	struct bpf_kprobe *kprobe;
> +
> +	if (unlikely(!rp))
> +		return 0;
> +
> +	kprobe = container_of(rp, struct bpf_kprobe, rp);
> +	kprobe_multi_link_prog_run(kprobe, get_entry_ip((uintptr_t)rp->kp.addr),
> +							   regs, true, ri->data);
> +	return 0;
> +}
> +
> +int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_kprobe_multi_link *link = NULL;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_kprobe *kprobes = NULL;
> +	u32 flags, cnt;
> +	u64 __user *ucookies;
> +	unsigned long __user *uaddrs;
> +	unsigned long __user *usyms;
> +	int err, i;
> +
> +	/* no support for 32bit archs yet */
> +	if (sizeof(u64) != sizeof(void *))
> +		return -EOPNOTSUPP;
> +
> +	if (attr->link_create.flags)
> +		return -EINVAL;
> +
> +	if (!is_kprobe_multi(prog))
> +		return -EINVAL;
> +
> +	/* Writing to context is not allowed for kprobes. */
> +	if (prog->aux->kprobe_write_ctx)
> +		return -EINVAL;
> +
> +	flags = attr->link_create.kprobe_multi.flags;
> +	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> +		return -EINVAL;
> +
> +	uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
> +	usyms = u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
> +	if (!!uaddrs == !!usyms)
> +		return -EINVAL;
> +
> +	cnt = attr->link_create.kprobe_multi.cnt;
> +	if (!cnt)
> +		return -EINVAL;
> +	if (cnt > MAX_KPROBE_MULTI_CNT)
> +		return -E2BIG;
> +
> +	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
> +	kprobes = kvcalloc(cnt, sizeof(*kprobes), GFP_KERNEL);
> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
> +	if (!link || !kprobes) {
> +		err = -ENOMEM;
> +		goto error;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		unsigned long addr;
> +
> +		if (uaddrs) {
> +			if (__get_user(addr, uaddrs + i)) {
> +				err = -EFAULT;
> +				goto error;
> +			}
> +		} else {
> +			unsigned long __user usymbol;
> +			char buf[KSYM_NAME_LEN];
> +
> +			if (__get_user(usymbol, usyms + i)) {
> +				err = -EFAULT;
> +				goto error;
> +			}
> +			err = strncpy_from_user(buf, (const char __user *) usymbol, KSYM_NAME_LEN);
> +			if (err == KSYM_NAME_LEN)
> +				err = -E2BIG;
> +			if (err < 0)
> +				goto error;
> +
> +			addr = kallsyms_lookup_name(buf);
> +			if (!addr)
> +				goto error;
> +		}
> +		if (prog->kprobe_override && !within_error_injection_list(addr)) {
> +			err = -EINVAL;
> +			goto error;
> +		}
> +		if (ucookies && __get_user(kprobes[i].cookie, ucookies + i)) {
> +			err = -EFAULT;
> +			goto error;
> +		}
> +
> +		kprobes[i].link = link;
> +		kprobes[i].rp.kp.addr = (kprobe_opcode_t *)addr;
> +
> +		if (!(flags & BPF_F_KPROBE_MULTI_RETURN))
> +			kprobes[i].rp.entry_handler = kprobe_multi_link_handler;
> +		if ((flags & BPF_F_KPROBE_MULTI_RETURN) || is_kprobe_session(prog))
> +			kprobes[i].rp.handler = kprobe_multi_link_exit_handler;
> +		if (is_kprobe_session(prog))
> +			kprobes[i].rp.data_size = sizeof(u64);
> +	}
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_KPROBE_MULTI,
> +		      &bpf_kprobe_multi_link_lops, prog, attr->link_create.attach_type);
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto error;
> +
> +	link->kprobes = kprobes;
> +	link->cnt = cnt;
> +	link->link.flags = flags;
> +
> +	err = get_modules_for_addrs(link);
> +	if (err < 0) {
> +		bpf_link_cleanup(&link_primer);
> +		return err;
> +	}
> +	link->mods_cnt = err;
> +
> +	err = bpf_kprobe_register(kprobes, cnt);
> +	if (err) {
> +		kprobe_multi_put_modules(link->mods, link->mods_cnt);
> +		bpf_link_cleanup(&link_primer);
> +		return err;
> +	}
> +
> +	return bpf_link_settle(&link_primer);
> +
> +error:
> +	kvfree(kprobes);
> +	kfree(link);
> +	return err;
> +}
> +#endif
> +#else  /* !CONFIG_FPROBE && !CONFIG_KRETPROBES*/
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.25.1
> 
> 
> 





