Return-Path: <bpf+bounces-39606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78F97510E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA49B23F81
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453E186E57;
	Wed, 11 Sep 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVf0NWqL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410F2C190;
	Wed, 11 Sep 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055314; cv=none; b=HLTf/U8O4+coX/TsDaOaRGrisWIEfvdZ5XdEQvfMFrENfSQq9YZsdVYPDi4p7jT3OGEWPXrTrZ1MmjfotZr8N8gfZOrMryZG591JMK8Emagg5msH4PvC7Vdjl/GzZ0Ltpve1nvoIY/4CLjtupOhmMZhe62T1K7EJz9DXjd/FEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055314; c=relaxed/simple;
	bh=HN2CUkkrsm6tTB7zLRVX+/gPtEXsA7aOEO2mkiTLUq4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhDX5F5PKkZCMgWhhOIM/F0UKxNh7WdwMibmrui7e4NF0LzVfSh73vvCu8Das+YovB0Wsu3AoGkJx/5HR6ptAgJhSdBZANdOwZG9pdKQXDZhXhSsh+rjPGxLCpB1qk57ATwIgzA8OV1wGyEpSP65o3E9CpOvuvMRdboPpTDTDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVf0NWqL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso13735031fa.2;
        Wed, 11 Sep 2024 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726055311; x=1726660111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gX20WNEDsCKrV1TgdhPGQxqLaSFljS5O2jlTq9FmXVw=;
        b=iVf0NWqLg4kdZwH2FUmzPqmYoxFokZXncdOCJyB3u9RrovTU/ZWE/k6aQLyaYl1wag
         Bax0sVxYIDFxLoXVOXJlok2YjCgTsYkxtorMfi27/G+i2tJgiJUQocNPyJvk+7/yeNnU
         vNK/xfRLHmKeM0RmAIS72Z8k/5q8nk6R+34rwiek2Qb12zLRrJrMjwCJ200Xq9WtICC/
         B3e8OybX25PsfbHdmSCiTbdgMpjO5RwNrRWiDmxeApKKgYN3mFPUi0W9UHztxhKKjQJ8
         fHtmOtrnE0vY3UNKkHAOArWHaj3W9OZh0jAjoavQbK2OEywpY9NZsVY6x0HNR4B2PhLT
         oe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055311; x=1726660111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX20WNEDsCKrV1TgdhPGQxqLaSFljS5O2jlTq9FmXVw=;
        b=gQEGL19sNR4hTEGqjvcGnHM1Aoh6YHcVOdbza/v8cJRWaM/4LJKA09JlbVhY5yWpYS
         rolnZwopU241fSsbvqyRpto3B9iubPA+fj1OSLmrrFDFThzwyD2v1xmb6oh28hgA7ukv
         u/YNnR8pWzeXndMj7SyLZRxU41b6OhIzswmiOu6qOjWLaX+qHpEwtE1FQQLi3jeii0Pb
         Hrza7iN+s+fKRHZ0uxAgxtu6GnEg1ytvhsar9vnosXap2p1xKUgeVQVYoawgVJ/gKUAG
         2DzK78+wEuVYW1IVmx7gTImKD3SnpAPjl4TvwyEqDoU2cDO/jfs59TPcK/1gRKgDYjGm
         gM3g==
X-Forwarded-Encrypted: i=1; AJvYcCUJrq/MVQfw3TKMmvmxniFeW55B50B4BQCDTOnFxoB1hJVh5hGJY0+rj4XL9cQSussviY0+UBNVIoh6VVUdy2qUkH+O@vger.kernel.org, AJvYcCUbE/3OyIIv8ddP0J07jnBWqxVA2r7jrsXrB4u7XCrmF58S+FfSRftbAaMw+MtS6X+wMv4=@vger.kernel.org, AJvYcCXIXNZVX4YklBieXiDJlZA6m2ZtXmOOy62FbXt7OOuuwbuGGTo7QjwnlhzrojKBNIiLTcs/AqUns2yoQhpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFkB/h7MZaYD7w/OGBwQIwwxlxDONjj4OuDIFFTEg81GNfyNM
	5vWeMajqNqgJTGhrjqQgXsHa9zHTDOflodPiXAwRVC35bFK/eYis
X-Google-Smtp-Source: AGHT+IHOg8xnhDpYnkOb1CVJ0Yy1vKnP+17XCzBVa4o018fIcJ7KfqjKMffw1PctKY8zmrRjoRv+Yg==
X-Received: by 2002:a2e:f12:0:b0:2f6:2855:5c8c with SMTP id 38308e7fff4ca-2f75a9884demr100448281fa.20.1726055310195;
        Wed, 11 Sep 2024 04:48:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e7fsm603909666b.109.2024.09.11.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:48:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Sep 2024 13:48:27 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <ZuGDi5ls8rE-WjFj@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240910231023.6b168ca06d98dfc3842cf2eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910231023.6b168ca06d98dfc3842cf2eb@kernel.org>

On Tue, Sep 10, 2024 at 11:10:23PM +0900, Masami Hiramatsu wrote:
> On Mon,  9 Sep 2024 09:45:48 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding support for uprobe consumer to be defined as session and have
> > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> > 
> > The session means that 'handler' and 'ret_handler' callbacks are
> > connected in a way that allows to:
> > 
> >   - control execution of 'ret_handler' from 'handler' callback
> >   - share data between 'handler' and 'ret_handler' callbacks
> > 
> > The session is enabled by setting new 'session' bool field to true
> > in uprobe_consumer object.
> > 
> > We use return_consumer object to keep track of consumers with
> > 'ret_handler'. This object also carries the shared data between
> > 'handler' and and 'ret_handler' callbacks.
> > 
> > The control of 'ret_handler' callback execution is done via return
> > value of the 'handler' callback. This patch adds new 'ret_handler'
> > return value (2) which means to ignore ret_handler callback.
> > 
> > Actions on 'handler' callback return values are now:
> > 
> >   0 - execute ret_handler (if it's defined)
> >   1 - remove uprobe
> >   2 - do nothing (ignore ret_handler)
> > 
> > The session concept fits to our common use case where we do filtering
> > on entry uprobe and based on the result we decide to run the return
> > uprobe (or not).
> 
> OK, so this allows uprobes handler to record any input parameter and
> access it from ret_handler as fprobe's private entry data, right?

at the moment the shared data is 8 bytes.. I explored the way of having
the generic (configured) sized data and it complicates the code a bit
and we have no use case for that at the moment, so I decided to keep it
simple for now

I mentioned that in the cover email, I think it can be done as follow if
it's needed in future:

  - I kept the session cookie instead of introducing generic session
    data, because it makes the change much more complicated, I think
    it can be added as a followup if it's needed

> 
> The code looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> trace_uprobe should also support $argN in retuprobe.

could you please share more details on the use case?

thanks,
jirka

> 
> https://lore.kernel.org/all/170952365552.229804.224112990211602895.stgit@devnote2/
> 
> Thank you,
> 
> > 
> > It's also convenient to share the data between session callbacks.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h                       |  17 ++-
> >  kernel/events/uprobes.c                       | 132 ++++++++++++++----
> >  kernel/trace/bpf_trace.c                      |   6 +-
> >  kernel/trace/trace_uprobe.c                   |  12 +-
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   2 +-
> >  5 files changed, 133 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 2b294bf1881f..557901e04624 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -24,7 +24,7 @@ struct notifier_block;
> >  struct page;
> >  
> >  #define UPROBE_HANDLER_REMOVE		1
> > -#define UPROBE_HANDLER_MASK		1
> > +#define UPROBE_HANDLER_IGNORE		2
> >  
> >  #define MAX_URETPROBE_DEPTH		64
> >  
> > @@ -37,13 +37,16 @@ struct uprobe_consumer {
> >  	 * for the current process. If filter() is omitted or returns true,
> >  	 * UPROBE_HANDLER_REMOVE is effectively ignored.
> >  	 */
> > -	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> > +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
> >  	int (*ret_handler)(struct uprobe_consumer *self,
> >  				unsigned long func,
> > -				struct pt_regs *regs);
> > +				struct pt_regs *regs, __u64 *data);
> >  	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
> >  
> >  	struct list_head cons_node;
> > +	bool session;
> > +
> > +	__u64 id;	/* set when uprobe_consumer is registered */
> >  };
> >  
> >  #ifdef CONFIG_UPROBES
> > @@ -83,14 +86,22 @@ struct uprobe_task {
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
> > index 4b7e590dc428..9e971f86afdf 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -67,6 +67,8 @@ struct uprobe {
> >  	loff_t			ref_ctr_offset;
> >  	unsigned long		flags;
> >  
> > +	unsigned int		consumers_cnt;
> > +
> >  	/*
> >  	 * The generic code assumes that it has two members of unknown type
> >  	 * owned by the arch-specific code:
> > @@ -826,8 +828,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> >  
> >  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >  {
> > +	static atomic64_t id;
> > +
> >  	down_write(&uprobe->consumer_rwsem);
> >  	list_add_rcu(&uc->cons_node, &uprobe->consumers);
> > +	uc->id = (__u64) atomic64_inc_return(&id);
> > +	uprobe->consumers_cnt++;
> >  	up_write(&uprobe->consumer_rwsem);
> >  }
> >  
> > @@ -839,6 +845,7 @@ static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >  {
> >  	down_write(&uprobe->consumer_rwsem);
> >  	list_del_rcu(&uc->cons_node);
> > +	uprobe->consumers_cnt--;
> >  	up_write(&uprobe->consumer_rwsem);
> >  }
> >  
> > @@ -1786,6 +1793,30 @@ static struct uprobe_task *get_utask(void)
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
> > +static struct return_instance *alloc_return_instance(int consumers_cnt)
> > +{
> > +	struct return_instance *ri;
> > +
> > +	ri = kzalloc(ri_size(consumers_cnt), GFP_KERNEL);
> > +	if (ri)
> > +		ri->consumers_cnt = consumers_cnt;
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
> > @@ -1798,11 +1829,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
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
> > @@ -1895,39 +1925,35 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
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
> > @@ -1945,7 +1971,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >  			 * attack from user-space.
> >  			 */
> >  			uprobe_warn(current, "handle tail call");
> > -			goto fail;
> > +			goto put;
> >  		}
> >  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
> >  	}
> > @@ -1960,9 +1986,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
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
> > @@ -2114,35 +2141,78 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> >  	return uprobe;
> >  }
> >  
> > +static struct return_consumer *
> > +return_consumer_next(struct return_instance *ri, struct return_consumer *ric)
> > +{
> > +	return ric ? ric + 1 : &ri->consumers[0];
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
> >  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  {
> >  	struct uprobe_consumer *uc;
> >  	int remove = UPROBE_HANDLER_REMOVE;
> > -	bool need_prep = false; /* prepare return uprobe, when needed */
> > +	struct return_consumer *ric = NULL;
> > +	struct return_instance *ri = NULL;
> >  	bool has_consumers = false;
> >  
> >  	current->utask->auprobe = &uprobe->arch;
> >  
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		__u64 cookie = 0;
> >  		int rc = 0;
> >  
> >  		if (uc->handler) {
> > -			rc = uc->handler(uc, regs);
> > -			WARN(rc & ~UPROBE_HANDLER_MASK,
> > +			rc = uc->handler(uc, regs, &cookie);
> > +			WARN(rc < 0 || rc > 2,
> >  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
> >  		}
> >  
> > -		if (uc->ret_handler)
> > -			need_prep = true;
> > -
> > +		/*
> > +		 * The handler can return following values:
> > +		 * 0 - execute ret_handler (if it's defined)
> > +		 * 1 - remove uprobe
> > +		 * 2 - do nothing (ignore ret_handler)
> > +		 */
> >  		remove &= rc;
> >  		has_consumers = true;
> > +
> > +		if (rc == 0 && uc->ret_handler) {
> > +			/*
> > +			 * Preallocate return_instance object optimistically with
> > +			 * all possible consumers, so we allocate just once.
> > +			 */
> > +			if (!ri) {
> > +				ri = alloc_return_instance(uprobe->consumers_cnt);
> > +				if (!ri)
> > +					return;
> > +			}
> > +			ric = return_consumer_next(ri, ric);
> > +			ric->cookie = cookie;
> > +			ric->id = uc->id;
> > +		}
> >  	}
> >  	current->utask->auprobe = NULL;
> >  
> > -	if (need_prep && !remove)
> > -		prepare_uretprobe(uprobe, regs); /* put bp at return */
> > +	if (ri && !remove)
> > +		prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
> > +	else
> > +		kfree(ri);
> >  
> >  	if (remove && has_consumers) {
> >  		down_read(&uprobe->register_rwsem);
> > @@ -2160,15 +2230,25 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  static void
> >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> >  {
> > +	struct return_consumer *ric = NULL;
> >  	struct uprobe *uprobe = ri->uprobe;
> >  	struct uprobe_consumer *uc;
> > -	int srcu_idx;
> > +	int srcu_idx, iter = 0;
> >  
> >  	srcu_idx = srcu_read_lock(&uprobes_srcu);
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		/*
> > +		 * If we don't find return consumer, it means uprobe consumer
> > +		 * was added after we hit uprobe and return consumer did not
> > +		 * get registered in which case we call the ret_handler only
> > +		 * if it's not session consumer.
> > +		 */
> > +		ric = return_consumer_find(ri, &iter, uc->id);
> > +		if (!ric && uc->session)
> > +			continue;
> >  		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs);
> > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> >  	}
> >  	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >  }
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index ac0a01cc8634..de241503c8fb 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3332,7 +3332,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
> >  }
> >  
> >  static int
> > -uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> > +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			  __u64 *data)
> >  {
> >  	struct bpf_uprobe *uprobe;
> >  
> > @@ -3341,7 +3342,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> >  }
> >  
> >  static int
> > -uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
> > +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
> > +			      __u64 *data)
> >  {
> >  	struct bpf_uprobe *uprobe;
> >  
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index f7443e996b1b..11103dde897b 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
> >  static int register_uprobe_event(struct trace_uprobe *tu);
> >  static int unregister_uprobe_event(struct trace_uprobe *tu);
> >  
> > -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
> > +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			     __u64 *data);
> >  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> > -				unsigned long func, struct pt_regs *regs);
> > +				unsigned long func, struct pt_regs *regs,
> > +				__u64 *data);
> >  
> >  #ifdef CONFIG_STACK_GROWSUP
> >  static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
> > @@ -1500,7 +1502,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
> >  	}
> >  }
> >  
> > -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> > +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> > +			     __u64 *data)
> >  {
> >  	struct trace_uprobe *tu;
> >  	struct uprobe_dispatch_data udd;
> > @@ -1530,7 +1533,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> >  }
> >  
> >  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> > -				unsigned long func, struct pt_regs *regs)
> > +				unsigned long func, struct pt_regs *regs,
> > +				__u64 *data)
> >  {
> >  	struct trace_uprobe *tu;
> >  	struct uprobe_dispatch_data udd;
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 1fc16657cf42..e91ff5b285f0 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -421,7 +421,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
> >  
> >  static int
> >  uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
> > -		   struct pt_regs *regs)
> > +		   struct pt_regs *regs, __u64 *data)
> >  
> >  {
> >  	regs->ax  = 0x12345678deadbeef;
> > -- 
> > 2.46.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

