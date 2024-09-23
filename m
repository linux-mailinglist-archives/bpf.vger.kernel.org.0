Return-Path: <bpf+bounces-40188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6C97E723
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C71F21832
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418E4F215;
	Mon, 23 Sep 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB8n/+Jx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422A328B6;
	Mon, 23 Sep 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078709; cv=none; b=fRqa//ZMPeVCBL6xg3P26QxnDDGBaOLtk1Urgqz/0Pe4RABM3Y7p96A4cKL1x13NvHhM5oiYdAZLV+ZCIDUFspgTqMs5eK6PJrMyv+EtT2TbPSk0bkieAQGvpnZHjfoicvfKG1HH+gSPxc2BmMKJ+Chfcx178RmNZ1X7ZI1X04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078709; c=relaxed/simple;
	bh=fgsj38cD67sfVPCcSfaaFPhCe0yNKWv9YMJd8S2eu/c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEvOcmxkesQ8QiPTApHANH9Jp5KAE2uWDKNYR13muOti7Es9z9uohm2TiEwqviB0HY9jPjXsDweU9nsZmZ2raIHXAu7e671nZ1yNWsd7PXCnCvwtVi+acwYmAROJdilFxXk9EfbpM8gS+p4HYi+c2Y+KbwvsrwbU32vUnRz25NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB8n/+Jx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb2191107so31526785e9.1;
        Mon, 23 Sep 2024 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727078706; x=1727683506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBegKfYAQsHe1fbtP41O6gYPyvmtlusn/3Xx6RlKeXQ=;
        b=kB8n/+JxhSRpEBpHEogyNw4K0aBXbqr9gHeOjxaqzhoxZ3YJJh1PBkXIsS0eIztPt6
         FFpunWvpvRA6beQPnjdjwyoU+uqzMS9n1hMuDZozmdER6S3KjhnYRNj2ci+yGecvdMSx
         PT8W6/SRK2+FbjAXpNB3e6cAkkSyoj3GUL42E/eu3ggZyuoQZ7rmEVPednTQeLX1yUxp
         EpRI938rmUWzh5DL/Cc2smDFDMqyOLAFK+g5dS539ADEKrUiYswAFZHQ0WP22Oxa49Ld
         U8q9+c7oBr3LWPogw8EnywJJWJ8V2g1yVbu2OE/sqrfj1Q6NV4V/GNNb5UneNFl1T2qN
         k9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078706; x=1727683506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBegKfYAQsHe1fbtP41O6gYPyvmtlusn/3Xx6RlKeXQ=;
        b=HBz227WceSiArFrtkKE+CK/FIEKL0NJD6oTHxYVRgTBTLwm2/qJjOHcY96rURCJEfh
         Blqcsdmv55f/5vx03EzqklzyscJ6WMl+9b2o8TbJEXdL4Khb0O/ifFWP3geDohlbIkOo
         OT8AWS5JjgvUlLqYjy6reS6YP90WiWjcTgArqcIcruCIyAaVFaaq2MpgQusyGmpbWZV9
         q5ewfUs533LmKrHMipdm7BQJrsjEmEhMQk4TaqGjH3VBY2LB9sAPVpW7sRCbMz0Afc9B
         k7H5iVJcTXnU9T48GL0tszMwmBI0m/dFy/Mupk1rLrElx3NI9O4bkFb4+P3u/2oGUuc4
         qTtw==
X-Forwarded-Encrypted: i=1; AJvYcCVW+4PWEN8TlJtOkrIeWjlkO/sMMMlNeMx8gW3YsYcoiuOrnKqaVTvsfYa3GPRX0QVWHRF7gS7MiEik8V070KKTHB7Y@vger.kernel.org, AJvYcCWARRXfy1JPiY57+Lh0Gn04DtsXasFRKzGeBq45zQ7WNshvP40wmPIGRRp4HBPwUseDd5eaO9qLc5SZnuFN@vger.kernel.org, AJvYcCWJX65Xt4Gd8JO5nB9UCk5BCfbHCpWVRsXJXoqcGGooZgVeDJmAsdrKJJQURvvBfglfA+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzjiJXI6zaKw8gQ1stafCQcQmBQjiXWPMafpqT/wdVEg1rgTg
	3oGZVpX1zzauk0pYJwij1iYFFqR3p3YQ3a60CmFvUF96aBvD6idYy9KBbHGJ
X-Google-Smtp-Source: AGHT+IE8fJNwit7PLPN9rrBBzWIlIsTAED1aiV5ueKln2qa4bH8j61JWC/UVxZ2qI1o5k+AlCsqIBA==
X-Received: by 2002:a05:600c:4705:b0:42b:af1c:66e with SMTP id 5b1f17b1804b1-42e7c165b37mr62896795e9.9.1727078705710;
        Mon, 23 Sep 2024 01:05:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7affa701sm94494955e9.43.2024.09.23.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:05:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 10:05:03 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <ZvEhL114tyhLmfB1@krava>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
 <Zul7UCsftY_ZX6wT@krava>
 <20240922152722.GA12833@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922152722.GA12833@redhat.com>

On Sun, Sep 22, 2024 at 05:27:23PM +0200, Oleg Nesterov wrote:
> Damn, sorry for delay :/
> 
> And sorry, still can't understand, see below...
> 
> On 09/17, Jiri Olsa wrote:
> >
> > On Tue, Sep 17, 2024 at 02:03:17PM +0200, Oleg Nesterov wrote:
> > >
> > > To me this code should do:
> > >
> > > 		if (!uc->ret_handler || UPROBE_HANDLER_REMOVE || UPROBE_HANDLER_IGNORE)
> > > 			continue;
> > >
> > > 		if (!ri)
> > > 			ri = alloc_return_instance();
> > >
> > > 		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE)
> > > 			ri = push_consumer(...);
> > >
> > > And,
> > >
> > > >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> > > ...
> > > >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > > >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > > > +		ric = return_consumer_find(ri, &ric_idx, uc->id);
> > > > +		if (ric && ric->rc == UPROBE_HANDLER_IGNORE)
> > > > +			continue;
> > > >  		if (uc->ret_handler)
> > > > -			uc->ret_handler(uc, ri->func, regs);
> > > > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> > > >  	}
> > >
> > > the UPROBE_HANDLER_IGNORE check above and the new ric->rc member should die,
> > >
> > > 		if (!uc->ret_handler)
> > > 			continue;
> > >
> > > 		ric = return_consumer_find(...);
> > > 		uc->ret_handler(..., ric ? &ric->cookie : NULL);
> > >
> > > as we have already discussed, the session ret_handler(data) can simply do
> > >
> > > 		// my ->handler() wasn't called or it didn't return
> > > 		// UPROBE_HANDLER_IWANTMYCOOKIE
> > > 		if (!data)
> > > 			return;
> > >
> > > at the start.
> > >
> > > Could you explain why this can't work?
> >
> > I'll try ;-) it's for the case when consumer does not use UPROBE_HANDLER_IWANTMYCOOKIE
> >
> > let's have 2 consumers on single uprobe, consumer-A returning UPROBE_HANDLER_IGNORE
> > and the consumer-B returning zero, so we want the return uprobe installed, but we
> > want just consumer-B to be executed
> >
> >   - so uprobe gets installed and handle_uretprobe_chain goes over all consumers
> >     calling ret_handler callback
> >
> >   - but we don't know consumer-A needs to be ignored, and it does not
> >     expect cookie so we have no way to find out it needs to be ignored
> 
> How does this differ from the case when consumer-A returns _REMOVE but another
> consumer returns 0?
> 
> But what I really can't understand is
> 
> 	and it does not
> 	expect cookie so we have no way to find out it needs to be ignored
> 
> If we change the code as I suggested above, push_consumer() won't be called
> if consumer-A returns UPROBE_HANDLER_IGNORE.
> 
> This means that handle_uretprobe_chain() -> return_consumer_find() will
> return NULL, so handle_uretprobe_chain() won't pass the valid cookie to
> consumer-A's ret_handler callback, it will pass data => NULL.
> 
> So, again, why can't consumer-A's ret_handler callback do
> 
> 	// my ->handler() wasn't called or it didn't return
> 	// UPROBE_HANDLER_IWANTMYCOOKIE
> 	if (!data)
> 		return;

ok, I think I understand the issue now.. it all depends on 'handler' to return
either UPROBE_HANDLER_IGNORE or UPROBE_HANDLER_IWANTMYCOOKIE

my idea was to make the interface more generic, so some future uprobe user won't
depend on handler callback to return UPROBE_HANDLER_IWANTMYCOOKIE and can just
return 0, but we can do that as follow up if it's ever needed

change below should do what you proposed originally

also on top of that.. I discussed with Andrii the possibility of dropping
the UPROBE_HANDLER_IWANTMYCOOKIE completely and setup cookie for any consumer
that has both 'handler' and 'ret_handler' defined, wdyt?

thanks,
jirka


---
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bb265a632b91..5221080b1f5a 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -23,8 +23,20 @@ struct inode;
 struct notifier_block;
 struct page;
 
+/*
+ * Allowed return values from uprobe consumer's handler callback
+ * with following meaning:
+ *
+ * UPROBE_HANDLER_REMOVE
+ * - Remove the uprobe breakpoint from current->mm.
+ * UPROBE_HANDLER_IGNORE
+ * - Ignore ret_handler callback for this consumer.
+ * UPROBE_HANDLER_IWANTMYCOOKIE
+ * - Store cookie and pass it to ret_handler (if defined).
+ */
 #define UPROBE_HANDLER_REMOVE		1
-#define UPROBE_HANDLER_MASK		1
+#define UPROBE_HANDLER_IGNORE		2
+#define UPROBE_HANDLER_IWANTMYCOOKIE	3
 
 #define MAX_URETPROBE_DEPTH		64
 
@@ -44,6 +56,8 @@ struct uprobe_consumer {
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
+
+	__u64 id;	/* set when uprobe_consumer is registered */
 };
 
 #ifdef CONFIG_UPROBES
@@ -83,14 +97,22 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct return_consumer {
+	__u64	cookie;
+	__u64	id;
+};
+
 struct return_instance {
 	struct uprobe		*uprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			consumers_cnt;
 
 	struct return_instance	*next;		/* keep as stack */
+
+	struct return_consumer	consumers[] __counted_by(consumers_cnt);
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b7e590dc428..0dca2f2ecf9c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -65,7 +65,7 @@ struct uprobe {
 	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
-	unsigned long		flags;
+	unsigned long		flags;		/* "unsigned long" so bitops work */
 
 	/*
 	 * The generic code assumes that it has two members of unknown type
@@ -826,8 +826,11 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	static atomic64_t id;
+
 	down_write(&uprobe->consumer_rwsem);
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
+	uc->id = (__u64) atomic64_inc_return(&id);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -1786,6 +1789,34 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int consumers_cnt)
+{
+	struct return_instance *ri;
+
+	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
+}
+
+#define DEF_CNT 4
+
+static struct return_instance *alloc_return_instance(void)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
+	if (!ri)
+		return ZERO_SIZE_PTR;
+
+	ri->consumers_cnt = DEF_CNT;
+	return ri;
+}
+
+static struct return_instance *dup_return_instance(struct return_instance *old)
+{
+	size_t size = ri_size(old->consumers_cnt);
+
+	return kmemdup(old, size, GFP_KERNEL);
+}
+
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
@@ -1798,11 +1829,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
+		n = dup_return_instance(o);
 		if (!n)
 			return -ENOMEM;
 
-		*n = *o;
 		/*
 		 * uprobe's refcnt has to be positive at this point, kept by
 		 * utask->return_instances items; return_instances can't be
@@ -1895,39 +1925,35 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
+			      struct return_instance *ri)
 {
-	struct return_instance *ri;
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
 
 	if (!get_xol_area())
-		return;
+		goto free;
 
 	utask = get_utask();
 	if (!utask)
-		return;
+		goto free;
 
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
 				current->pid, current->tgid);
-		return;
+		goto free;
 	}
 
 	/* we need to bump refcount to store uprobe in utask */
 	if (!try_get_uprobe(uprobe))
-		return;
-
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		goto fail;
+		goto free;
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto fail;
+		goto put;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1945,7 +1971,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto fail;
+			goto put;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
@@ -1960,9 +1986,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
-fail:
-	kfree(ri);
+put:
 	put_uprobe(uprobe);
+free:
+	kfree(ri);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2114,35 +2141,90 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
+static struct return_instance*
+push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie)
+{
+	if (unlikely(ri == ZERO_SIZE_PTR))
+		return ri;
+
+	if (unlikely(idx >= ri->consumers_cnt)) {
+		struct return_instance *old_ri = ri;
+
+		ri->consumers_cnt += DEF_CNT;
+		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
+		if (!ri) {
+			kfree(old_ri);
+			return ZERO_SIZE_PTR;
+		}
+	}
+
+	ri->consumers[idx].id = id;
+	ri->consumers[idx].cookie = cookie;
+	return ri;
+}
+
+static struct return_consumer *
+return_consumer_find(struct return_instance *ri, int *iter, int id)
+{
+	struct return_consumer *ric;
+	int idx = *iter;
+
+	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
+		if (ric->id == id) {
+			*iter = idx + 1;
+			return ric;
+		}
+	}
+	return NULL;
+}
+
+static bool ignore_ret_handler(int rc)
+{
+	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
+}
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
-	int remove = UPROBE_HANDLER_REMOVE;
-	bool need_prep = false; /* prepare return uprobe, when needed */
-	bool has_consumers = false;
+	bool has_consumers = false, remove = true;
+	struct return_instance *ri = NULL;
+	int push_idx = 0;
 
 	current->utask->auprobe = &uprobe->arch;
 
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		__u64 cookie = 0;
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
-			WARN(rc & ~UPROBE_HANDLER_MASK,
+			rc = uc->handler(uc, regs, &cookie);
+			WARN(rc < 0 || rc > 3,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
-			need_prep = true;
-
-		remove &= rc;
+		remove &= rc == UPROBE_HANDLER_REMOVE;
 		has_consumers = true;
+
+		if (!uc->ret_handler || ignore_ret_handler(rc))
+			continue;
+
+		if (!ri)
+			ri = alloc_return_instance();
+
+		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE)
+			ri = push_consumer(ri, push_idx++, uc->id, cookie);
 	}
 	current->utask->auprobe = NULL;
 
-	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+	if (!ZERO_OR_NULL_PTR(ri)) {
+		/*
+		 * The push_idx value has the final number of return consumers,
+		 * and ri->consumers_cnt has number of allocated consumers.
+		 */
+		ri->consumers_cnt = push_idx;
+		prepare_uretprobe(uprobe, regs, ri);
+	}
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
@@ -2161,14 +2243,16 @@ static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
+	struct return_consumer *ric;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
+	int srcu_idx, ric_idx = 0;
 
 	srcu_idx = srcu_read_lock(&uprobes_srcu);
 	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
 				 srcu_read_lock_held(&uprobes_srcu)) {
+		ric = return_consumer_find(ri, &ric_idx, uc->id);
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
 	}
 	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }

