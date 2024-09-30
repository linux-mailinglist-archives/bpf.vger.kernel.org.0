Return-Path: <bpf+bounces-40554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79A98A0FD
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8BD1C20EB0
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C632B9A5;
	Mon, 30 Sep 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXvcwzer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35ED2F3E;
	Mon, 30 Sep 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696531; cv=none; b=HrxFEB1A/mC/dkmfmiIUa8KusOtRSXY3bWkbaqkNpovkFvbEsSITHAGqlh1I3P6K78kJeJoDci/Q6aEa/dc3xcdToeTc3frovgJSdeR5FIpc4HNUUjJBuuF2qWg3BUus3eKDaQ5H/98HFYLwNlKhOMiXh6tqPM/jISJHvXskfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696531; c=relaxed/simple;
	bh=DWdtx7VmvR1pJiWP7HtF5oWD+pvCkzS0WcTzCY2ZA9Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW85c/s5iwrtklB1SL6L3NzJjuJtTigNQcEh6f5ZW5swzcfROBgs2afkKgcafN4ZJFU89Ri9rSsP3Vh4eCIwhFdW5J99sii3Rmk3jXnO0M8BkNfyp3KDGvJcs0lUHFPu5m7pwOrstwETg3mSNNaECQm4I0qrwvKrGCxOwRkJGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXvcwzer; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so30810385e9.2;
        Mon, 30 Sep 2024 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696527; x=1728301327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF+YAHvW1mNOGImhW9KUCIg7OXTGuT3cjgmUDQRNKyU=;
        b=jXvcwzerF7fPbjE0Zs7RcagF1cWUeQMUAE8GoJL+7hOGPbJnjavJUOG8ohj1YhhOmI
         BrDJC4n7TblfhDb6iZjmX7op6xpe55kxVgBI1ZKuyU1On7ap6iUsuYOPcDWkSZ3e+pQg
         8DTYG1sbTr5cdnxunwSd38HzSimHFtzFpKP8k2xHBLJYDANblaHvxk9gJCKuETbNuyEf
         Ne6vEUk34InVQUVX6N4/b4XTjuPsyp03cjZg4oqjCehbW7ORrHUFf5AJPOlRxStcivbL
         sv4eyH1gKvikDHaJxu6Mf+qp9yurRztf7U6hpEjUbTmr5NgoLoqJWTdIwSwu4+/qVh6S
         0xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696527; x=1728301327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF+YAHvW1mNOGImhW9KUCIg7OXTGuT3cjgmUDQRNKyU=;
        b=bBrWz449EHrjtDUXrKIDquBzJJSa0IGibQZKVCmZXvsYzu1uQq2QF4toau1d6v/dcu
         YOPBJZeUsmXvsluceAl9RdjWzXbZJLTQR7NkZrXrmc1CHRwVnIL76oPdknEN0crvMghX
         OibR5PFr0oepLcLcMYeI873HWrK+0cYkZ5nCa5DfRr3T9UGaHFTkKtMRUZYR/zeENiji
         EP7UjSI9UPa41zP61ZqBEPqW62xTZ35/HPGDd1i8lpVmXBJTpI2h0a7SL2QINrLYC0Uk
         t/jvpCVqoHDialXg3PFS+9yErjYP6tJEjhsGQZij/LoTHn/VI5sxAI5TAcVpqobjfvCj
         JFgw==
X-Forwarded-Encrypted: i=1; AJvYcCUrGnBD2+D38x4InWUaFKqGaqTD8iuEth5X3okBnbS1GYAK5GwOgUyJftGhLekwU0A9xr3awQ5yx9putS721oDL6N1/@vger.kernel.org, AJvYcCV7aU8DRkoEnE99kDgD0E4MrbSP3DQuErQaQzz9QaQrpxKhTj2DE1e7WZniK5608O3CvIg5joTLcHvm5k8o@vger.kernel.org, AJvYcCVU4XCDLovoX4osp+N3CGa+h5GTE2M38W7ceAP3VolQ09Y9CcQATNGl4GBGRk6n93z/i1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOGAs0sygObC6AcvW+okf98lhhSJLS36mqE0nimApkSAOvwGM
	Gavx+8mR68nu++xc6Wep6SIvXpXs5bI7yt2csqQSeG0Kk6MuxFSD
X-Google-Smtp-Source: AGHT+IFvrOnZayuN67emsCm2evcbVnTQi6wWj/D0SxhiOLTn32eJp/1kE/fMUi1NNzI9F8Ues+XcTw==
X-Received: by 2002:a05:6000:1c2:b0:37c:cee1:acb2 with SMTP id ffacd0b85a97d-37cd5aaf932mr5383108f8f.10.1727696527125;
        Mon, 30 Sep 2024 04:42:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fa3bsm8875513f8f.70.2024.09.30.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:42:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Sep 2024 13:42:04 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCHv5 bpf-next 02/13] uprobe: Add support for session consumer
Message-ID: <ZvqOjGlyHfQdwFDY@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-3-jolsa@kernel.org>
 <20240930094014.GB18499@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930094014.GB18499@redhat.com>

On Mon, Sep 30, 2024 at 11:40:15AM +0200, Oleg Nesterov wrote:
> Jiri,
> 
> LGTM. But I'm afraid you need to send v6, sorry ;)
> 
> This change has some (trivial) conflicts in prepare_uretprobe() with the
> cleanups I sent yesterday, and Peter is going to queue them.

sure, np.. will wait for any review comments and rebase/resend

thanks,
jirka

> 
> See https://lore.kernel.org/all/20240929144201.GA9429@redhat.com/
> 
> Oleg.
> 
> On 09/29, Jiri Olsa wrote:
> >
> > This change allows the uprobe consumer to behave as session which
> > means that 'handler' and 'ret_handler' callbacks are connected in
> > a way that allows to:
> > 
> >   - control execution of 'ret_handler' from 'handler' callback
> >   - share data between 'handler' and 'ret_handler' callbacks
> > 
> > The session concept fits to our common use case where we do filtering
> > on entry uprobe and based on the result we decide to run the return
> > uprobe (or not).
> > 
> > It's also convenient to share the data between session callbacks.
> > 
> > To achive this we are adding new return value the uprobe consumer
> > can return from 'handler' callback:
> > 
> >   UPROBE_HANDLER_IGNORE
> >   - Ignore 'ret_handler' callback for this consumer.
> > 
> > And store cookie and pass it to 'ret_handler' when consumer has both
> > 'handler' and 'ret_handler' callbacks defined.
> > 
> > We store shared data in the return_consumer object array as part of
> > the return_instance object. This way the handle_uretprobe_chain can
> > find related return_consumer and its shared data.
> > 
> > We also store entry handler return value, for cases when there are
> > multiple consumers on single uprobe and some of them are ignored and
> > some of them not, in which case the return probe gets installed and
> > we need to have a way to find out which consumer needs to be ignored.
> > 
> > The tricky part is when consumer is registered 'after' the uprobe
> > entry handler is hit. In such case this consumer's 'ret_handler' gets
> > executed as well, but it won't have the proper data pointer set,
> > so we can filter it out.
> > 
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  21 +++++-
> >  kernel/events/uprobes.c | 148 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 137 insertions(+), 32 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index bb265a632b91..dbaf04189548 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -23,8 +23,17 @@ struct inode;
> >  struct notifier_block;
> >  struct page;
> >  
> > +/*
> > + * Allowed return values from uprobe consumer's handler callback
> > + * with following meaning:
> > + *
> > + * UPROBE_HANDLER_REMOVE
> > + * - Remove the uprobe breakpoint from current->mm.
> > + * UPROBE_HANDLER_IGNORE
> > + * - Ignore ret_handler callback for this consumer.
> > + */
> >  #define UPROBE_HANDLER_REMOVE		1
> > -#define UPROBE_HANDLER_MASK		1
> > +#define UPROBE_HANDLER_IGNORE		2
> >  
> >  #define MAX_URETPROBE_DEPTH		64
> >  
> > @@ -44,6 +53,8 @@ struct uprobe_consumer {
> >  	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
> >  
> >  	struct list_head cons_node;
> > +
> > +	__u64 id;	/* set when uprobe_consumer is registered */
> >  };
> >  
> >  #ifdef CONFIG_UPROBES
> > @@ -83,14 +94,22 @@ struct uprobe_task {
> >  	unsigned int			depth;
> >  };
> >  
> > +struct return_consumer {
> > +	__u64	cookie;
> > +	__u64	id;
> > +};
> > +
> >  struct return_instance {
> >  	struct uprobe		*uprobe;
> >  	unsigned long		func;
> >  	unsigned long		stack;		/* stack pointer */
> >  	unsigned long		orig_ret_vaddr; /* original return address */
> >  	bool			chained;	/* true, if instance is nested */
> > +	int			consumers_cnt;
> >  
> >  	struct return_instance	*next;		/* keep as stack */
> > +
> > +	struct return_consumer	consumers[] __counted_by(consumers_cnt);
> >  };
> >  
> >  enum rp_check {
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2ba93f8a31aa..76fe535c9b3c 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -65,7 +65,7 @@ struct uprobe {
> >  	struct rcu_head		rcu;
> >  	loff_t			offset;
> >  	loff_t			ref_ctr_offset;
> > -	unsigned long		flags;
> > +	unsigned long		flags;		/* "unsigned long" so bitops work */
> >  
> >  	/*
> >  	 * The generic code assumes that it has two members of unknown type
> > @@ -825,8 +825,11 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> >  
> >  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >  {
> > +	static atomic64_t id;
> > +
> >  	down_write(&uprobe->consumer_rwsem);
> >  	list_add_rcu(&uc->cons_node, &uprobe->consumers);
> > +	uc->id = (__u64) atomic64_inc_return(&id);
> >  	up_write(&uprobe->consumer_rwsem);
> >  }
> >  
> > @@ -1797,6 +1800,34 @@ static struct uprobe_task *get_utask(void)
> >  	return current->utask;
> >  }
> >  
> > +static size_t ri_size(int consumers_cnt)
> > +{
> > +	struct return_instance *ri;
> > +
> > +	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
> > +}
> > +
> > +#define DEF_CNT 4
> > +
> > +static struct return_instance *alloc_return_instance(void)
> > +{
> > +	struct return_instance *ri;
> > +
> > +	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
> > +	if (!ri)
> > +		return ZERO_SIZE_PTR;
> > +
> > +	ri->consumers_cnt = DEF_CNT;
> > +	return ri;
> > +}
> > +
> > +static struct return_instance *dup_return_instance(struct return_instance *old)
> > +{
> > +	size_t size = ri_size(old->consumers_cnt);
> > +
> > +	return kmemdup(old, size, GFP_KERNEL);
> > +}
> > +
> >  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >  {
> >  	struct uprobe_task *n_utask;
> > @@ -1809,11 +1840,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >  
> >  	p = &n_utask->return_instances;
> >  	for (o = o_utask->return_instances; o; o = o->next) {
> > -		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> > +		n = dup_return_instance(o);
> >  		if (!n)
> >  			return -ENOMEM;
> >  
> > -		*n = *o;
> >  		/*
> >  		 * uprobe's refcnt has to be positive at this point, kept by
> >  		 * utask->return_instances items; return_instances can't be
> > @@ -1906,39 +1936,35 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
> >  	utask->return_instances = ri;
> >  }
> >  
> > -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> > +static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
> > +			      struct return_instance *ri)
> >  {
> > -	struct return_instance *ri;
> >  	struct uprobe_task *utask;
> >  	unsigned long orig_ret_vaddr, trampoline_vaddr;
> >  	bool chained;
> >  
> >  	if (!get_xol_area())
> > -		return;
> > +		goto free;
> >  
> >  	utask = get_utask();
> >  	if (!utask)
> > -		return;
> > +		goto free;
> >  
> >  	if (utask->depth >= MAX_URETPROBE_DEPTH) {
> >  		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
> >  				" nestedness limit pid/tgid=%d/%d\n",
> >  				current->pid, current->tgid);
> > -		return;
> > +		goto free;
> >  	}
> >  
> >  	/* we need to bump refcount to store uprobe in utask */
> >  	if (!try_get_uprobe(uprobe))
> > -		return;
> > -
> > -	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> > -	if (!ri)
> > -		goto fail;
> > +		goto free;
> >  
> >  	trampoline_vaddr = uprobe_get_trampoline_vaddr();
> >  	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
> >  	if (orig_ret_vaddr == -1)
> > -		goto fail;
> > +		goto put;
> >  
> >  	/* drop the entries invalidated by longjmp() */
> >  	chained = (orig_ret_vaddr == trampoline_vaddr);
> > @@ -1956,7 +1982,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >  			 * attack from user-space.
> >  			 */
> >  			uprobe_warn(current, "handle tail call");
> > -			goto fail;
> > +			goto put;
> >  		}
> >  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
> >  	}
> > @@ -1971,9 +1997,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >  	utask->return_instances = ri;
> >  
> >  	return;
> > -fail:
> > -	kfree(ri);
> > +put:
> >  	put_uprobe(uprobe);
> > +free:
> > +	kfree(ri);
> >  }
> >  
> >  /* Prepare to single-step probed instruction out of line. */
> > @@ -2125,35 +2152,91 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> >  	return uprobe;
> >  }
> >  
> > +static struct return_instance*
> > +push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie)
> > +{
> > +	if (unlikely(ri == ZERO_SIZE_PTR))
> > +		return ri;
> > +
> > +	if (unlikely(idx >= ri->consumers_cnt)) {
> > +		struct return_instance *old_ri = ri;
> > +
> > +		ri->consumers_cnt += DEF_CNT;
> > +		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
> > +		if (!ri) {
> > +			kfree(old_ri);
> > +			return ZERO_SIZE_PTR;
> > +		}
> > +	}
> > +
> > +	ri->consumers[idx].id = id;
> > +	ri->consumers[idx].cookie = cookie;
> > +	return ri;
> > +}
> > +
> > +static struct return_consumer *
> > +return_consumer_find(struct return_instance *ri, int *iter, int id)
> > +{
> > +	struct return_consumer *ric;
> > +	int idx = *iter;
> > +
> > +	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
> > +		if (ric->id == id) {
> > +			*iter = idx + 1;
> > +			return ric;
> > +		}
> > +	}
> > +	return NULL;
> > +}
> > +
> > +static bool ignore_ret_handler(int rc)
> > +{
> > +	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
> > +}
> > +
> >  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  {
> >  	struct uprobe_consumer *uc;
> > -	int remove = UPROBE_HANDLER_REMOVE;
> > -	bool need_prep = false; /* prepare return uprobe, when needed */
> > -	bool has_consumers = false;
> > +	bool has_consumers = false, remove = true;
> > +	struct return_instance *ri = NULL;
> > +	int push_idx = 0;
> >  
> >  	current->utask->auprobe = &uprobe->arch;
> >  
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		bool session = uc->handler && uc->ret_handler;
> > +		__u64 cookie = 0;
> >  		int rc = 0;
> >  
> >  		if (uc->handler) {
> > -			rc = uc->handler(uc, regs, NULL);
> > -			WARN(rc & ~UPROBE_HANDLER_MASK,
> > +			rc = uc->handler(uc, regs, &cookie);
> > +			WARN(rc < 0 || rc > 2,
> >  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
> >  		}
> >  
> > -		if (uc->ret_handler)
> > -			need_prep = true;
> > -
> > -		remove &= rc;
> > +		remove &= rc == UPROBE_HANDLER_REMOVE;
> >  		has_consumers = true;
> > +
> > +		if (!uc->ret_handler || ignore_ret_handler(rc))
> > +			continue;
> > +
> > +		if (!ri)
> > +			ri = alloc_return_instance();
> > +
> > +		if (session)
> > +			ri = push_consumer(ri, push_idx++, uc->id, cookie);
> >  	}
> >  	current->utask->auprobe = NULL;
> >  
> > -	if (need_prep && !remove)
> > -		prepare_uretprobe(uprobe, regs); /* put bp at return */
> > +	if (!ZERO_OR_NULL_PTR(ri)) {
> > +		/*
> > +		 * The push_idx value has the final number of return consumers,
> > +		 * and ri->consumers_cnt has number of allocated consumers.
> > +		 */
> > +		ri->consumers_cnt = push_idx;
> > +		prepare_uretprobe(uprobe, regs, ri);
> > +	}
> >  
> >  	if (remove && has_consumers) {
> >  		down_read(&uprobe->register_rwsem);
> > @@ -2172,14 +2255,17 @@ static void
> >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> >  {
> >  	struct uprobe *uprobe = ri->uprobe;
> > +	struct return_consumer *ric;
> >  	struct uprobe_consumer *uc;
> > -	int srcu_idx;
> > +	int srcu_idx, ric_idx = 0;
> >  
> >  	srcu_idx = srcu_read_lock(&uprobes_srcu);
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > -		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs, NULL);
> > +		if (uc->ret_handler) {
> > +			ric = return_consumer_find(ri, &ric_idx, uc->id);
> > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> > +		}
> >  	}
> >  	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >  }
> > -- 
> > 2.46.1
> > 
> 

