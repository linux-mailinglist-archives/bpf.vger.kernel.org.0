Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F66F3B22
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 01:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEAX7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 19:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjEAX7a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 19:59:30 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DA35AC
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 16:59:26 -0700 (PDT)
Message-ID: <8e801bce-6ee2-fc9e-0c4a-9d0e2f851562@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682985564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIbB9X6GlBEHv6K2Bt2Cy6Fgauc010RYguB63Du79U0=;
        b=NeP+84tBz7QVOt3C184JHYLD7wmWRTTl8R0ZhLTkHPG6WWlFGjGV3b62Vi9RojaRn556Ag
        wW33M2Whnz04/k2G5OWhltY0vvQDozyMxygi1P0PyfYELzAKUAbvD+I8iN7DPjv1JJcKYO
        1IdlrfrcfsAtgB17VlDb+ELQu8QTYBg=
Date:   Mon, 1 May 2023 16:59:18 -0700
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230429101215.111262-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/29/23 3:12 AM, Hou Tao wrote:
> +static void bpf_ma_prepare_reuse_work(struct work_struct *work)
> +{
> +	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, reuse_work);
> +	struct llist_node *head, *tail, *llnode, *tmp;
> +	struct bpf_reuse_batch *batch;
> +	unsigned long flags;
> +	bool do_free;
> +
> +	local_irq_save(flags);
> +	/* When CPU is offline, the running CPU may be different with
> +	 * the CPU which submitted the work. When these two CPUs are the same,
> +	 * kworker may be interrupted by NMI, so increase active to protect
> +	 * again such concurrency.
> +	 */
> +	if (c->cpu == smp_processor_id())
> +		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
> +	raw_spin_lock(&c->reuse_lock);
> +	head = __llist_del_all(&c->prepare_reuse_head);
> +	tail = c->prepare_reuse_tail;
> +	c->prepare_reuse_tail = NULL;
> +	c->prepare_reuse_cnt = 0;
> +	if (c->cpu == smp_processor_id())
> +		local_dec(&c->active);
> +
> +	/* Try to free elements in reusable list. Before these elements are
> +	 * freed in RCU cb, these element will still be available for reuse.
> +	 */
> +	do_free = bpf_ma_try_free_reuse_objs(c);
> +	raw_spin_unlock(&c->reuse_lock);
> +	local_irq_restore(flags);
> +
> +	if (do_free)
> +		call_rcu_tasks_trace(&c->rcu, bpf_ma_free_reusable_cb);
> +
> +	llist_for_each_safe(llnode, tmp, llist_del_all(&c->free_llist_extra)) {
> +		if (!head)
> +			tail = llnode;
> +		llnode->next = head;
> +		head = llnode->next;
> +	}
> +	/* Draining is in progress ? */
> +	if (!head) {
> +		/* kworker completes and no RCU callback */
> +		atomic_dec(&c->reuse_cb_in_progress);
> +		return;
> +	}
> +
> +	batch = kmalloc(sizeof(*batch), GFP_KERNEL);
> +	if (!batch) {
> +		synchronize_rcu_expedited();
> +		bpf_ma_add_to_reuse_ready_or_free(c, head, tail);
> +		/* kworker completes and no RCU callback */
> +		atomic_dec(&c->reuse_cb_in_progress);
> +		return;
> +	}
> +
> +	batch->c = c;
> +	batch->head = head;
> +	batch->tail = tail;
> +	call_rcu(&batch->rcu, bpf_ma_reuse_cb);
> +}
> +
> +static void notrace wait_gp_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	/* In case a NMI-context bpf program is also freeing object. */
> +	if (local_inc_return(&c->active) == 1) {
> +		bool try_queue_work = false;
> +
> +		/* kworker may remove elements from prepare_reuse_head */
> +		raw_spin_lock(&c->reuse_lock);
> +		if (llist_empty(&c->prepare_reuse_head))
> +			c->prepare_reuse_tail = llnode;
> +		__llist_add(llnode, &c->prepare_reuse_head);
> +		if (++c->prepare_reuse_cnt > c->high_watermark) {
> +			/* Zero out prepare_reuse_cnt early to prevent
> +			 * unnecessary queue_work().
> +			 */
> +			c->prepare_reuse_cnt = 0;
> +			try_queue_work = true;
> +		}
> +		raw_spin_unlock(&c->reuse_lock);
> +
> +		if (try_queue_work && !work_pending(&c->reuse_work)) {
> +			/* Use reuse_cb_in_progress to indicate there is
> +			 * inflight reuse kworker or reuse RCU callback.
> +			 */
> +			atomic_inc(&c->reuse_cb_in_progress);
> +			/* Already queued */
> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))

queue_work will be called from a bpf program (e.g. bpf_mem_cache_free -> 
unit_free -> queue_work). Is it safe from recursion and deadlock?
eg. what if a tracing bpf prog is attached to some functions in workqueue.c 
after acquiring a workqueue related spin lock and that tracing bpf prog is doing 
unit_free?
Not a workqueue expert. Asking because it is not obvious to me considering there 
is a lot of ground to cover in workqueue.c.

I wonder what happen to the current bpf memalloc approach to postpone work to 
irq work. v2 mentioned it does not work well. Did you figure out why?

> +				atomic_dec(&c->reuse_cb_in_progress);
> +		}
> +	} else {
> +		llist_add(llnode, &c->free_llist_extra);
> +	}
> +	local_dec(&c->active);
> +	local_irq_restore(flags);
> +}
> +
>   /* Though 'ptr' object could have been allocated on a different cpu
>    * add it to the free_llist of the current cpu.
>    * Let kfree() logic deal with it when it's later called from irq_work.
>    */
> -static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
> +static void notrace immediate_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
>   {
> -	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
>   	unsigned long flags;
>   	int cnt = 0;
>   
> -	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
> -
>   	local_irq_save(flags);
>   	if (local_inc_return(&c->active) == 1) {
>   		__llist_add(llnode, &c->free_llist);
> @@ -633,6 +910,18 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
>   		irq_work_raise(c);
>   }
>   
> +static inline void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
> +{
> +	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
> +
> +	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
> +
> +	if (c->flags & BPF_MA_REUSE_AFTER_RCU_GP)
> +		wait_gp_reuse_free(c, llnode);
> +	else
> +		immediate_reuse_free(c, llnode);
> +}
> +

