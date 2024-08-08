Return-Path: <bpf+bounces-36710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB394C4DD
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12735B24D1F
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990C1474A7;
	Thu,  8 Aug 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdnjlDYt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094F1465A0
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142970; cv=none; b=aoMkBmTngskkXsA/ZH/Ox54M0AW9/YwHqqd5w9ld437x73GhHyQMtu0cxqy+SuP1upeeqMDHsHt8nF1wrc5Iz2kCBln0ySC6Pwg26b3/W5zyKcCvf3mL5sQnE/+eBecEDfnjsAP7mOyccF4fBbdzsC+DmnfQQZgeponrNFcPrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142970; c=relaxed/simple;
	bh=IjU4h6npF6cq7qMUXRe03/4YICLachpFsiSmcw9tA8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9VyxOgun9YdHH9bPhTCeDmDHx6fy5F5TVgsnmAm1e/zS2v6IefvPdcOn1WWR77yFhhotMQqHWqD1q3MLVPa7FgkbZDip6cR0vrHQvmG1kWTwcjmkQYRXjwciK1HPdA19GoZZ4PKfpNysmPqdC3+RDuEYOhJT8aSEpXNJmFhc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdnjlDYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723142967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qbhyU+StH+cGdpSsqEyWgSvoW2+/cVXlfie9rEmFyg=;
	b=CdnjlDYtmKvpOYFazBwt7rqbhOOJwipcyTekRqT9Eo/Xp/54YhNzfH6UZYM6U0T7qeKct/
	Mjr2dlz1i0YiZMMkaff5frafKCaQrC+39HUzWEsbm8SWfY3I/Zzc6dhTFySD4VSNRNSil/
	TqxMrqJH8kJAUOF2msUSZE71saUMAcU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-nP7fcQ7KND69qVR5qYz89w-1; Thu,
 08 Aug 2024 14:49:23 -0400
X-MC-Unique: nP7fcQ7KND69qVR5qYz89w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CE2A19775F6;
	Thu,  8 Aug 2024 18:49:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 64B3419560A3;
	Thu,  8 Aug 2024 18:49:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 20:49:19 +0200 (CEST)
Date: Thu, 8 Aug 2024 20:49:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for
 performance
Message-ID: <20240808184911.GH8020@redhat.com>
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Liao,

To be honest I didn't even try to look at your patch, sorry.

Because I think it would be better to delay it in an case. Until Andrii
finishes/pushes his optimization changes which (in particular) include
find_active_uprobe_rcu/etc.

Then you can rebease and re-benchmark your patch on top of these changes.

Oleg.


On 08/08, Liao, Chang wrote:
>
> Hi Andrii and Oleg.
>
> This patch sent by me two weeks ago also aim to optimize the performance of uprobe
> on arm64. I notice recent discussions on the performance and scalability of uprobes
> within the mailing list. Considering this interest, I've added you and other relevant
> maintainers to the CC list for broader visibility and potential collaboration.
>
> Thanks.
>
> 在 2024/7/27 17:44, Liao Chang 写道:
> > The profiling result of single-thread model of selftests bench reveals
> > performance bottlenecks in find_uprobe() and caches_clean_inval_pou() on
> > ARM64. On my local testing machine, 5% of CPU time is consumed by
> > find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() take
> > about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >
> > This patch introduce struct uprobe_breakpoint to track previously
> > allocated insn_slot for frequently hit uprobe. it effectively reduce the
> > need for redundant insn_slot writes and subsequent expensive cache
> > flush, especially on architecture like ARM64. This patch has been tested
> > on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
> > bench and Redis GET/SET benchmark result below reveal obivious
> > performance gain.
> >
> > before-opt
> > ----------
> > trig-uprobe-nop:  0.371 ± 0.001M/s (0.371M/prod)
> > trig-uprobe-push: 0.370 ± 0.001M/s (0.370M/prod)
> > trig-uprobe-ret:  1.637 ± 0.001M/s (1.647M/prod)
> > trig-uretprobe-nop:  0.331 ± 0.004M/s (0.331M/prod)
> > trig-uretprobe-push: 0.333 ± 0.000M/s (0.333M/prod)
> > trig-uretprobe-ret:  0.854 ± 0.002M/s (0.854M/prod)
> > Redis SET (RPS) uprobe: 42728.52
> > Redis GET (RPS) uprobe: 43640.18
> > Redis SET (RPS) uretprobe: 40624.54
> > Redis GET (RPS) uretprobe: 41180.56
> >
> > after-opt
> > ---------
> > trig-uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
> > trig-uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
> > trig-uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
> > trig-uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
> > trig-uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
> > trig-uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
> > Redis SET (RPS) uprobe: 43939.69
> > Redis GET (RPS) uprobe: 45200.80
> > Redis SET (RPS) uretprobe: 41658.58
> > Redis GET (RPS) uretprobe: 42805.80
> >
> > While some uprobes might still need to share the same insn_slot, this
> > patch compare the instructions in the resued insn_slot with the
> > instructions execute out-of-line firstly to decides allocate a new one
> > or not.
> >
> > Additionally, this patch use a rbtree associated with each thread that
> > hit uprobes to manage these allocated uprobe_breakpoint data. Due to the
> > rbtree of uprobe_breakpoints has smaller node, better locality and less
> > contention, it result in faster lookup times compared to find_uprobe().
> >
> > The other part of this patch are some necessary memory management for
> > uprobe_breakpoint data. A uprobe_breakpoint is allocated for each newly
> > hit uprobe that doesn't already have a corresponding node in rbtree. All
> > uprobe_breakpoints will be freed when thread exit.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  include/linux/uprobes.h |   3 +
> >  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 211 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index f46e0ca0169c..04ee465980af 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -78,6 +78,9 @@ struct uprobe_task {
> >
> >  	struct return_instance		*return_instances;
> >  	unsigned int			depth;
> > +
> > +	struct rb_root			breakpoints_tree;
> > +	rwlock_t			breakpoints_treelock;
> >  };
> >
> >  struct return_instance {
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2c83ba776fc7..3f1a6dc2a327 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -33,6 +33,7 @@
> >  #define MAX_UPROBE_XOL_SLOTS		UINSNS_PER_PAGE
> >
> >  static struct rb_root uprobes_tree = RB_ROOT;
> > +
> >  /*
> >   * allows us to skip the uprobe_mmap if there are no uprobe events active
> >   * at this time.  Probably a fine grained per inode count is better?
> > @@ -886,6 +887,174 @@ static bool filter_chain(struct uprobe *uprobe,
> >  	return ret;
> >  }
> >
> > +static struct uprobe_task *get_utask(void);
> > +static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr);
> > +static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp);
> > +
> > +struct uprobe_breakpoint {
> > +	struct rb_node		rb_node;
> > +	refcount_t		ref;
> > +	unsigned long		slot;
> > +	unsigned long		vaddr;
> > +	struct uprobe		*uprobe;
> > +};
> > +
> > +static void put_ubp(struct uprobe_breakpoint *ubp)
> > +{
> > +	if (refcount_dec_and_test(&ubp->ref)) {
> > +		put_uprobe(ubp->uprobe);
> > +		kfree(ubp);
> > +	}
> > +}
> > +
> > +static struct uprobe_breakpoint *get_ubp(struct uprobe_breakpoint *ubp)
> > +{
> > +	refcount_inc(&ubp->ref);
> > +	return ubp;
> > +}
> > +
> > +#define __node_2_ubp(node) rb_entry((node), struct uprobe_breakpoint, rb_node)
> > +
> > +struct __ubp_key {
> > +	unsigned long bp_vaddr;
> > +};
> > +
> > +static int ubp_cmp(const unsigned long bp_vaddr,
> > +		   const struct uprobe_breakpoint *ubp)
> > +{
> > +	if (bp_vaddr < ubp->vaddr)
> > +		return -1;
> > +
> > +	if (bp_vaddr > ubp->vaddr)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __ubp_cmp_key(const void *k, const struct rb_node *b)
> > +{
> > +	const struct __ubp_key *key = k;
> > +
> > +	return ubp_cmp(key->bp_vaddr, __node_2_ubp(b));
> > +}
> > +
> > +static int __ubp_cmp(struct rb_node *a, const struct rb_node *b)
> > +{
> > +	const struct uprobe_breakpoint *ubp = __node_2_ubp(a);
> > +
> > +	return ubp_cmp(ubp->vaddr, __node_2_ubp(b));
> > +}
> > +
> > +static void delete_breakpoint(struct uprobe_task *utask)
> > +{
> > +	struct rb_node *node;
> > +
> > +	write_lock(&utask->breakpoints_treelock);
> > +	node = rb_first(&utask->breakpoints_tree);
> > +	while (node) {
> > +		rb_erase(node, &utask->breakpoints_tree);
> > +		write_unlock(&utask->breakpoints_treelock);
> > +
> > +		put_ubp(__node_2_ubp(node));
> > +
> > +		write_lock(&utask->breakpoints_treelock);
> > +		node = rb_next(node);
> > +	}
> > +	write_unlock(&utask->breakpoints_treelock);
> > +}
> > +
> > +static struct uprobe_breakpoint *alloc_breakpoint(struct uprobe_task *utask,
> > +						  struct uprobe *uprobe,
> > +						  unsigned long bp_vaddr)
> > +{
> > +	struct uprobe_breakpoint *ubp;
> > +	struct rb_node *node;
> > +
> > +	ubp = kzalloc(sizeof(struct uprobe_breakpoint), GFP_KERNEL);
> > +	if (!ubp)
> > +		return NULL;
> > +
> > +	ubp->vaddr = bp_vaddr;
> > +	ubp->uprobe = uprobe;
> > +	/* get access + creation ref */
> > +	refcount_set(&ubp->ref, 2);
> > +	ubp->slot = UINSNS_PER_PAGE;
> > +
> > +	write_lock(&utask->breakpoints_treelock);
> > +	node = rb_find_add(&ubp->rb_node, &utask->breakpoints_tree, __ubp_cmp);
> > +	write_unlock(&utask->breakpoints_treelock);
> > +
> > +	/* Two or more threads hit the same breakpoint */
> > +	if (node) {
> > +		WARN_ON(uprobe != __node_2_ubp(node)->upobre);
>
> A stupid typo.
>
> s/upobre/uprobe/g
>
> > +		kfree(ubp);
> > +		return get_ubp(__node_2_ubp(node));
> > +	}
> > +
> > +	return ubp;
> > +}
> > +
> > +static struct uprobe_breakpoint *find_breakpoint(struct uprobe_task *utask,
> > +						 unsigned long bp_vaddr)
> > +{
> > +	struct rb_node *node;
> > +	struct __ubp_key key = {
> > +		.bp_vaddr = bp_vaddr,
> > +	};
> > +
> > +	read_lock(&utask->breakpoints_treelock);
> > +	node = rb_find(&key, &utask->breakpoints_tree, __ubp_cmp_key);
> > +	read_unlock(&utask->breakpoints_treelock);
> > +
> > +	if (node)
> > +		return get_ubp(__node_2_ubp(node));
> > +
> > +	return NULL;
> > +}
> > +
> > +static struct uprobe_breakpoint *find_active_breakpoint(struct pt_regs *regs,
> > +							unsigned long bp_vaddr)
> > +{
> > +	struct uprobe_task *utask = get_utask();
> > +	struct uprobe_breakpoint *ubp;
> > +	struct uprobe *uprobe;
> > +	int is_swbp;
> > +
> > +	if (unlikely(!utask))
> > +		return NULL;
> > +
> > +	ubp = find_breakpoint(utask, bp_vaddr);
> > +	if (ubp)
> > +		return ubp;
> > +
> > +	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> > +	if (!uprobe) {
> > +		if (is_swbp > 0) {
> > +			/* No matching uprobe; signal SIGTRAP. */
> > +			force_sig(SIGTRAP);
> > +		} else {
> > +			/*
> > +			 * Either we raced with uprobe_unregister() or we can't
> > +			 * access this memory. The latter is only possible if
> > +			 * another thread plays with our ->mm. In both cases
> > +			 * we can simply restart. If this vma was unmapped we
> > +			 * can pretend this insn was not executed yet and get
> > +			 * the (correct) SIGSEGV after restart.
> > +			 */
> > +			instruction_pointer_set(regs, bp_vaddr);
> > +		}
> > +		return NULL;
> > +	}
> > +
> > +	ubp = alloc_breakpoint(utask, uprobe, bp_vaddr);
> > +	if (!ubp) {
> > +		put_uprobe(uprobe);
> > +		return NULL;
> > +	}
> > +
> > +	return ubp;
> > +}
> > +
> >  static int
> >  install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
> >  			struct vm_area_struct *vma, unsigned long vaddr)
> > @@ -1576,9 +1745,8 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
> >  /*
> >   *  - search for a free slot.
> >   */
> > -static unsigned long xol_take_insn_slot(struct xol_area *area)
> > +static __always_inline int xol_take_insn_slot(struct xol_area *area)
> >  {
> > -	unsigned long slot_addr;
> >  	int slot_nr;
> >
> >  	do {
> > @@ -1590,34 +1758,48 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
> >  			slot_nr = UINSNS_PER_PAGE;
> >  			continue;
> >  		}
> > -		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
> > +		wait_event(area->wq,
> > +			   (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
> >  	} while (slot_nr >= UINSNS_PER_PAGE);
> >
> > -	slot_addr = area->vaddr + (slot_nr * UPROBE_XOL_SLOT_BYTES);
> > -	atomic_inc(&area->slot_count);
> > +	return slot_nr;
> > +}
> > +
> > +static __always_inline unsigned long
> > +choose_insn_slot(struct xol_area *area, struct uprobe_breakpoint *ubp)
> > +{
> > +	if ((ubp->slot == UINSNS_PER_PAGE) ||
> > +	    test_and_set_bit(ubp->slot, area->bitmap)) {
> > +		ubp->slot = xol_take_insn_slot(area);
> > +	}
> >
> > -	return slot_addr;
> > +	atomic_inc(&area->slot_count);
> > +	return area->vaddr + ubp->slot * UPROBE_XOL_SLOT_BYTES;
> >  }
> >
> >  /*
> >   * xol_get_insn_slot - allocate a slot for xol.
> >   * Returns the allocated slot address or 0.
> >   */
> > -static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
> > +static unsigned long xol_get_insn_slot(struct uprobe_breakpoint *ubp)
> >  {
> >  	struct xol_area *area;
> >  	unsigned long xol_vaddr;
> > +	struct uprobe *uprobe = ubp->uprobe;
> >
> >  	area = get_xol_area();
> >  	if (!area)
> >  		return 0;
> >
> > -	xol_vaddr = xol_take_insn_slot(area);
> > +	xol_vaddr = choose_insn_slot(area, ubp);
> >  	if (unlikely(!xol_vaddr))
> >  		return 0;
> >
> > -	arch_uprobe_copy_ixol(area->pages[0], xol_vaddr,
> > -			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
> > +	if (memcmp((void *)xol_vaddr, &uprobe->arch.ixol,
> > +		   sizeof(uprobe->arch.ixol)))
> > +		arch_uprobe_copy_ixol(area->pages[0], xol_vaddr,
> > +				      &uprobe->arch.ixol,
> > +				      sizeof(uprobe->arch.ixol));
>
> Perhaps, should i move memcmp() to the arch_uprobe_copy_ixol() provided by the architecture
> code?
>
> >
> >  	return xol_vaddr;
> >  }
> > @@ -1717,8 +1899,7 @@ void uprobe_free_utask(struct task_struct *t)
> >  	if (!utask)
> >  		return;
> >
> > -	if (utask->active_uprobe)
> > -		put_uprobe(utask->active_uprobe);
> > +	delete_breakpoint(utask);
> >
> >  	ri = utask->return_instances;
> >  	while (ri)
> > @@ -1739,8 +1920,11 @@ void uprobe_free_utask(struct task_struct *t)
> >   */
> >  static struct uprobe_task *get_utask(void)
> >  {
> > -	if (!current->utask)
> > +	if (!current->utask) {
> >  		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
> > +		current->utask->breakpoints_tree = RB_ROOT;
> > +		rwlock_init(&current->utask->breakpoints_treelock);
> > +	}
> >  	return current->utask;
> >  }
> >
> > @@ -1921,7 +2105,8 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >
> >  /* Prepare to single-step probed instruction out of line. */
> >  static int
> > -pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
> > +pre_ssout(struct uprobe *uprobe, struct pt_regs *regs,
> > +	  struct uprobe_breakpoint *ubp)
> >  {
> >  	struct uprobe_task *utask;
> >  	unsigned long xol_vaddr;
> > @@ -1931,12 +2116,12 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
> >  	if (!utask)
> >  		return -ENOMEM;
> >
> > -	xol_vaddr = xol_get_insn_slot(uprobe);
> > +	xol_vaddr = xol_get_insn_slot(ubp);
> >  	if (!xol_vaddr)
> >  		return -ENOMEM;
> >
> >  	utask->xol_vaddr = xol_vaddr;
> > -	utask->vaddr = bp_vaddr;
> > +	utask->vaddr = ubp->vaddr;
> >
> >  	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
> >  	if (unlikely(err)) {
> > @@ -2182,32 +2367,19 @@ bool __weak arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
> >   */
> >  static void handle_swbp(struct pt_regs *regs)
> >  {
> > +	struct uprobe_breakpoint *ubp;
> >  	struct uprobe *uprobe;
> >  	unsigned long bp_vaddr;
> > -	int is_swbp;
> >
> >  	bp_vaddr = uprobe_get_swbp_addr(regs);
> >  	if (bp_vaddr == get_trampoline_vaddr())
> >  		return handle_trampoline(regs);
> >
> > -	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> > -	if (!uprobe) {
> > -		if (is_swbp > 0) {
> > -			/* No matching uprobe; signal SIGTRAP. */
> > -			force_sig(SIGTRAP);
> > -		} else {
> > -			/*
> > -			 * Either we raced with uprobe_unregister() or we can't
> > -			 * access this memory. The latter is only possible if
> > -			 * another thread plays with our ->mm. In both cases
> > -			 * we can simply restart. If this vma was unmapped we
> > -			 * can pretend this insn was not executed yet and get
> > -			 * the (correct) SIGSEGV after restart.
> > -			 */
> > -			instruction_pointer_set(regs, bp_vaddr);
> > -		}
> > +	ubp = find_active_breakpoint(regs, bp_vaddr);
> > +	if (!ubp)
> >  		return;
> > -	}
> > +
> > +	uprobe = ubp->uprobe;
> >
> >  	/* change it in advance for ->handler() and restart */
> >  	instruction_pointer_set(regs, bp_vaddr);
> > @@ -2241,12 +2413,11 @@ static void handle_swbp(struct pt_regs *regs)
> >  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >  		goto out;
> >
> > -	if (!pre_ssout(uprobe, regs, bp_vaddr))
> > -		return;
> > +	pre_ssout(uprobe, regs, ubp);
> >
> >  	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
> >  out:
> > -	put_uprobe(uprobe);
> > +	put_ubp(ubp);
> >  }
> >
> >  /*
> > @@ -2266,7 +2437,6 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
> >  	else
> >  		WARN_ON_ONCE(1);
> >
> > -	put_uprobe(uprobe);
> >  	utask->active_uprobe = NULL;
> >  	utask->state = UTASK_RUNNING;
> >  	xol_free_insn_slot(current);
>
> --
> BR
> Liao, Chang
>


