Return-Path: <bpf+bounces-77461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCCCE51DC
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 16:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A56E300E013
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE92D23B8;
	Sun, 28 Dec 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFU1AlsO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AE1E3DDB
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766935346; cv=none; b=NPBS4vSlnKfhfcDQ3sE/F/8x9sU2UG9kLGEVO6LIxBjWdYK49z4i21aGQGAM0gCmzR0b9gwmjUz+3N3NDMTyt+4vTGpahjMYbqXvpLGBroUcn8N3FihHuKTtIBr5MOLNSINLWj3v6/6TVRHCkvRv3Iac1QrDiOdUEeQ5fuYBVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766935346; c=relaxed/simple;
	bh=7HJbwUk2ZGqu+uA512nise2xEYrzwcAenAr6GCm9QW0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnsfWlPnoi6XizhOXlC5Mv/gITzn+NtykBiutpKqnDk2Qz5XbBfMs1HFSTkxN9zz2Xi78FH5mxTGV3TltAXxrR6qStqeMpmndlb4eMIqMdjF1JwcpsjCK+nkWmTsCepd02BTIqCZJgOh3ZI0SbNRrGzdl0RLPwIlWodpnFaj0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFU1AlsO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb5810d39so4932139f8f.2
        for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766935341; x=1767540141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0JsthEvCkVhqHu4jZiKgW0AI5w7ORfH/FYCDkFLi2k=;
        b=SFU1AlsOomQmhX4dnxjwRLvgoBfjfJlhky97TtesR286STeZ7Q5MGanAQsF9LeWYVk
         Xd/TZ2bm0KByBS05s6g7oGRs41j2VBfwmphJ4ERyfS4HNoXRtNIMDYVpimcW2l5tUnDp
         M6+ficCr/+/mY+CERXnh494n0hvU+9W4pCa2V3xjBer45fDY0Zjg2jKBd95q7zCMC87R
         EWyQ4xp/AngTjISv9/LhPcsAZmD0mtL8EjabekBTbM2M0XMV83/7VJjgyPtiTJAHxGKc
         VV1rDS0mirWDFCBdBGLOXjduofyU1mnpb++eGnYhkUwB04uC5Pi2jpSJCl56CNZoqg3B
         3oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766935341; x=1767540141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0JsthEvCkVhqHu4jZiKgW0AI5w7ORfH/FYCDkFLi2k=;
        b=Sw8wqlJT/6o8Uih+MtZ3eM/dv03ga67w09kEGVYKeoZ64v5LFnn4piIWBndSw3VINQ
         TgxyXrmvgfCJYJF7eXLuoBND8O2q4eeR8G+RcGmvRnmy6igN0a37/CTq915E/rI6myYW
         IGJOlsLaFallKibnfUJ0ULrBx1oK5TpBGHrEcN2IuLfdgOgxst6dhysXrjYq+jL3bThK
         HsHjYeMlytSAfOYTdgtSSbeJ0uXNYDIktPVAgReONpzbFKOZy6qdg6SOTsI75SbeEF9m
         r4L4U6GIEku3IcAQ9lOtX4rc9YKzdM8gv1a7O6NSFf4MziI/kmMK2XZF+68AF9+tGC3R
         gaAA==
X-Forwarded-Encrypted: i=1; AJvYcCXt3iFJKsUhxoA/A2NNfe7sYYcV41iv2d/kZ2wC+dmkFXznkCaYPqyDlGHx1nDBUn4Kymg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1ILw75dNPNWh3cxGcRJTNABB6XH4mA3lXjY8pJ543OlGgMpG
	mlEXGMm0fQ7FaY84X3IO4NIiO86AYW4lmFi7ZuZuQ1o5r3I8BRsnV7YB
X-Gm-Gg: AY/fxX5Eyp+Txx0YNb3+ZlO6YHEOpnpGUD3cgZVNo44eNqmIBt/jPRB1aOOt5V3uRWd
	ZA5WlFjT5K6iq5ZVmFN1EhBZh8afQZKAZQc+nNy58aXf/65mprcgRuzPz5/vMXQs5GDRJOqacXT
	Fngl3rpNLY9UK/wW8U6sAqahbpsNeo55S9Gubp9ZqQnwmcrRekEAYNs4ChmuGqxvaB6LLAM96Cj
	vr7qx5atgoPaA3DvemOm96LyJADRt42clEzxGaJP5I9L6ygWL/hC5Y1b4KYWqk4HiMFjPfqvVFz
	Cjd4zIe1BlO812vNAZRVY+ESM3uNaPx18qFLTnrZf8TCv3aRZQEwAiGlEEVkIzi/GuC+9urQrYB
	ddR38SIzzZzJ6rPaZVRRDnjei7Aozya5hfjSfthYguhBUMCVu5SGP2y1mjBXA
X-Google-Smtp-Source: AGHT+IHPFPBsAIDT66UxfHwERHI9gdpoiahi8vYWrXU9Jwa5noosDFz27xahiNIPSDggzd0DkhI3xQ==
X-Received: by 2002:a05:6000:2907:b0:429:b751:7935 with SMTP id ffacd0b85a97d-4324e704a80mr36209592f8f.56.1766935340977;
        Sun, 28 Dec 2025 07:22:20 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm56939366f8f.3.2025.12.28.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:22:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 Dec 2025 16:22:18 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
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
Message-ID: <aVFLKgZ56wt5aLci@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-10-jolsa@kernel.org>
 <20251218112608.11a14a4a@gandalf.local.home>
 <aUUanPijlWsDlS0X@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUUanPijlWsDlS0X@krava>

On Fri, Dec 19, 2025 at 10:27:56AM +0100, Jiri Olsa wrote:

> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 4661b9e606e0..1ad2e307c834 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
> > >  config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >  	bool
> > >  
> > > +config HAVE_SINGLE_FTRACE_DIRECT_OPS
> > > +	bool
> > > +
> > 
> > Now you could add:
> > 
> >   config SINGLE_FTRACE_DIRECT_OPS
> > 	bool
> > 	default y
> > 	depends on HAVE_SINGLE_FTRACE_DIRECT_OPS && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> 
> ok, the dependency is more ovbvious, will change
> 
> thanks,
> jirka

actualy, it seems that having it the original way with adding the rest
of the wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS case is
easier AFAICS

jirka


---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..53bf2cf7ff6f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -336,6 +336,7 @@ config X86
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e5a0d58ed6dc..a8b3f510280a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -33,12 +33,40 @@ static DEFINE_MUTEX(trampoline_mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	struct hlist_head *head_ip;
+	struct bpf_trampoline *tr;
+
+	mutex_lock(&trampoline_mutex);
+	head_ip = &trampoline_ip_table[hash_64(ip, TRAMPOLINE_HASH_BITS)];
+	hlist_for_each_entry(tr, head_ip, hlist_ip) {
+		if (tr->ip == ip)
+			goto out;
+	}
+	tr = NULL;
+out:
+	mutex_unlock(&trampoline_mutex);
+	return tr;
+}
+#else
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	return ops->private;
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+
 static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 				     enum ftrace_ops_cmd cmd)
 {
-	struct bpf_trampoline *tr = ops->private;
+	struct bpf_trampoline *tr;
 	int ret = 0;
 
+	tr = direct_ops_ip_lookup(ops, ip);
+	if (!tr)
+		return -EINVAL;
+
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
 		/* This is called inside register_ftrace_direct_multi(), so
 		 * tr->mutex is already locked.
@@ -137,6 +165,159 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+/*
+ * We have only single direct_ops which contains all the direct call
+ * sites and is the only global ftrace_ops for all trampolines.
+ *
+ * We use 'update_ftrace_direct_*' api for attachment.
+ */
+struct ftrace_ops direct_ops = {
+	.ops_func = bpf_tramp_ftrace_ops_func,
+};
+
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	tr->fops = &direct_ops;
+	return 0;
+}
+
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+
+static struct ftrace_hash *hash_from_ip(struct bpf_trampoline *tr, void *ptr)
+{
+	unsigned long ip, addr = (unsigned long) ptr;
+	struct ftrace_hash *hash;
+
+	ip = ftrace_location(tr->ip);
+	if (!ip)
+		return NULL;
+	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!hash)
+		return NULL;
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	if (!add_ftrace_hash_entry_direct(hash, ip, addr)) {
+		free_ftrace_hash(hash);
+		return NULL;
+	}
+	return hash;
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_add(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_del(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *addr, bool lock_direct_mutex)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_mod(tr->fops, hash, lock_direct_mutex);
+	free_ftrace_hash(hash);
+	return err;
+}
+#else
+/*
+ * We allocate ftrace_ops object for each trampoline and it contains
+ * call site specific for that trampoline.
+ *
+ * We use *_ftrace_direct api for attachment.
+ */
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+	if (!tr->fops)
+		return -ENOMEM;
+	tr->fops->private = tr;
+	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+	return 0;
+}
+
+static void direct_ops_free(struct bpf_trampoline *tr)
+{
+	if (tr->fops) {
+		ftrace_free_filter(tr->fops);
+		kfree(tr->fops);
+	}
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *ptr)
+{
+	unsigned long addr = (unsigned long) ptr;
+	struct ftrace_ops *ops = tr->fops;
+	int ret;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+
+	ret = ftrace_set_filter_ip(ops, tr->ip, 0, 1);
+	if (ret)
+		return ret;
+	return register_ftrace_direct(ops, addr);
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	return unregister_ftrace_direct(tr->fops, (long)addr, false);
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
+{
+	unsigned long addr = (unsigned long) ptr;
+	struct ftrace_ops *ops = tr->fops;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	if (lock_direct_mutex)
+		return modify_ftrace_direct(ops, addr);
+	return modify_ftrace_direct_nolock(ops, addr);
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+#else
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	return 0;
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
+{
+	return -ENODEV;
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	return -ENODEV;
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 {
 	struct bpf_trampoline *tr;
@@ -154,16 +335,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
-	if (!tr->fops) {
+	if (direct_ops_alloc(tr)) {
 		kfree(tr);
 		tr = NULL;
 		goto out;
 	}
-	tr->fops->private = tr;
-	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
-#endif
 
 	tr->key = key;
 	tr->ip = ftrace_location(ip);
@@ -206,7 +382,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
+		ret = direct_ops_del(tr, old_addr);
 	else
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
@@ -220,15 +396,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed) {
-		unsigned long addr = (unsigned long) new_addr;
-
-		if (bpf_trampoline_use_jmp(tr->flags))
-			addr = ftrace_jmp_set(addr);
-
-		if (lock_direct_mutex)
-			ret = modify_ftrace_direct(tr->fops, addr);
-		else
-			ret = modify_ftrace_direct_nolock(tr->fops, addr);
+		ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
 						   new_addr);
@@ -251,15 +419,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		unsigned long addr = (unsigned long) new_addr;
-
-		if (bpf_trampoline_use_jmp(tr->flags))
-			addr = ftrace_jmp_set(addr);
-
-		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		if (ret)
-			return ret;
-		ret = register_ftrace_direct(tr->fops, addr);
+		ret = direct_ops_add(tr, new_addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
@@ -910,10 +1070,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist_key);
 	hlist_del(&tr->hlist_ip);
-	if (tr->fops) {
-		ftrace_free_filter(tr->fops);
-		kfree(tr->fops);
-	}
+	direct_ops_free(tr);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index bfa2ec46e075..d7042a09fe46 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	bool
 
+config HAVE_SINGLE_FTRACE_DIRECT_OPS
+	bool
+
 config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	bool
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 02030f62d737..4ed910d3d00d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2631,8 +2631,13 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr = READ_ONCE(ops->direct_call);
+	unsigned long addr;
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+	addr = ftrace_find_rec_direct(ip);
+#else
+	addr = READ_ONCE(ops->direct_call);
+#endif
 	if (!addr)
 		return;
 

