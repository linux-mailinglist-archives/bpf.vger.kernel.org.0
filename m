Return-Path: <bpf+bounces-3013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A87383B8
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AAD1C208E9
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CF168BF;
	Wed, 21 Jun 2023 12:26:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68ADC147;
	Wed, 21 Jun 2023 12:26:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492781712;
	Wed, 21 Jun 2023 05:26:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmN606SpTz4f468s;
	Wed, 21 Jun 2023 20:26:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAHKDJ27JJk6J4qLg--.12588S2;
	Wed, 21 Jun 2023 20:26:33 +0800 (CST)
Subject: Re: [PATCH bpf-next 11/12] bpf: Introduce bpf_mem_free_rcu() similar
 to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-12-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <eee33106-21ef-9f0b-86e7-137deefc6f50@huaweicloud.com>
Date: Wed, 21 Jun 2023 20:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230621023238.87079-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAHKDJ27JJk6J4qLg--.12588S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KFWrGr1DAryUXr48tF4fKrg_yoW8JFW5uo
	WfCr15JF1rJF1xCw1qkryUCFnxKF1jg34DArs5Gry3Za4jqrW5t3yIyFW5J3y7WF18GFs8
	Z3WUta1UGFW8JFy3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/21/2023 10:32 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> objects into free_by_rcu_ttrace list where they are waiting for RCU
> task trace grace period to be freed into slab.
>
> The life cycle of objects:
> alloc: dequeue free_llist
> free: enqeueu free_llist
> free_rcu: enqueue free_by_rcu -> waiting_for_gp
> free_llist above high watermark -> free_by_rcu_ttrace
> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf_mem_alloc.h |   2 +
>  kernel/bpf/memalloc.c         | 118 ++++++++++++++++++++++++++++++++--
>  2 files changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index 3929be5743f4..d644bbb298af 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -27,10 +27,12 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>  /* kmalloc/kfree equivalent: */
>  void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
>  void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
> +void bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
>  
>  /* kmem_cache_alloc/free equivalent: */
>  void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
>  void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
> +void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
>  void bpf_mem_cache_raw_free(void *ptr);
>  void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
>  
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 10d027674743..4d1002e7b4b5 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -100,6 +100,15 @@ struct bpf_mem_cache {
>  	int percpu_size;
>  	struct bpf_mem_cache *tgt;
>  
> +	/* list of objects to be freed after RCU GP */
> +	struct llist_head free_by_rcu;
> +	struct llist_node *free_by_rcu_tail;
> +	struct llist_head waiting_for_gp;
> +	struct llist_node *waiting_for_gp_tail;
> +	struct rcu_head rcu;
> +	atomic_t call_rcu_in_progress;
> +	struct llist_head free_llist_extra_rcu;
> +
>  	/* list of objects to be freed after RCU tasks trace GP */
>  	struct llist_head free_by_rcu_ttrace;
>  	struct llist_node *free_by_rcu_ttrace_tail;
> @@ -340,6 +349,56 @@ static void free_bulk(struct bpf_mem_cache *c)
>  	do_call_rcu_ttrace(tgt);
>  }
>  
> +static void __free_by_rcu(struct rcu_head *head)
> +{
> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +	struct bpf_mem_cache *tgt = c->tgt;
> +	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
> +
> +	if (!llnode)
> +		goto out;
> +
> +	if (llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace))
> +		tgt->free_by_rcu_ttrace_tail = c->waiting_for_gp_tail;
> +
> +	/* Objects went through regular RCU GP. Send them to RCU tasks trace */
> +	do_call_rcu_ttrace(tgt);
> +out:
> +	atomic_set(&c->call_rcu_in_progress, 0);
> +}
> +
> +static void check_free_by_rcu(struct bpf_mem_cache *c)
> +{
> +	struct llist_node *llnode, *t;
> +
> +	if (llist_empty(&c->free_by_rcu) && llist_empty(&c->free_llist_extra_rcu))
> +		return;
> +
> +	/* drain free_llist_extra_rcu */
> +	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
> +		if (__llist_add(llnode, &c->free_by_rcu))
> +			c->free_by_rcu_tail = llnode;
> +
> +	if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
> +		/*
> +		 * Instead of kmalloc-ing new rcu_head and triggering 10k
> +		 * call_rcu() to hit rcutree.qhimark and force RCU to notice
> +		 * the overload just ask RCU to hurry up. There could be many
> +		 * objects in free_by_rcu list.
> +		 * This hint reduces memory consumption for an artifical
> +		 * benchmark from 2 Gbyte to 150 Mbyte.
> +		 */
> +		rcu_request_urgent_qs_task(current);
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
> +
> +	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
> +	c->waiting_for_gp_tail = c->free_by_rcu_tail;
> +	call_rcu_hurry(&c->rcu, __free_by_rcu);
> +}
> +
>  static void bpf_mem_refill(struct irq_work *work)
>  {
>  	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
> @@ -354,6 +413,8 @@ static void bpf_mem_refill(struct irq_work *work)
>  		alloc_bulk(c, c->batch, NUMA_NO_NODE);
>  	else if (cnt > c->high_watermark)
>  		free_bulk(c);
> +
> +	check_free_by_rcu(c);
>  }
>  
>  static void notrace irq_work_raise(struct bpf_mem_cache *c)
> @@ -482,6 +543,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>  	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
>  	free_all(__llist_del_all(&c->free_llist), percpu);
>  	free_all(__llist_del_all(&c->free_llist_extra), percpu);
> +	free_all(__llist_del_all(&c->free_by_rcu), percpu);
> +	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
> +	free_all(llist_del_all(&c->waiting_for_gp), percpu);
>  }
>  
>  static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
> @@ -494,8 +558,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
>  
>  static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  {
> -	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
> -	 * still execute. Wait for it now before we freeing percpu caches.
> +	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
> +	 * might still execute. Wait for them.
>  	 *
>  	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
>  	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> @@ -504,9 +568,10 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
>  	 * using rcu_trace_implies_rcu_gp() as well.
>  	 */
> -	rcu_barrier_tasks_trace();
> +	rcu_barrier(); /* wait for __free_by_rcu() */
> +	rcu_barrier_tasks_trace(); /* wait for __free_rcu() via call_rcu_tasks_trace */
Using rcu_barrier_tasks_trace and rcu_barrier() is not enough, the
objects in c->free_by_rcu_ttrace may be leaked as shown below. We may
need to add an extra variable to notify __free_by_rcu() to free these
elements directly instead of trying to move it into
waiting_for_gp_ttrace as I did before. Or we can just drain
free_by_rcu_ttrace twice.

destroy process       __free_by_rcu

llist_del_all(&c->free_by_rcu_ttrace)

                        // add to free_by_rcu_ttrace again
                        llist_add_batch(..., &tgt->free_by_rcu_ttrace)
                            do_call_rcu_ttrace()
                                // call_rcu_ttrace_in_progress is 1, so
xchg return 1
                                // and it will not be moved to
waiting_for_gp_ttrace
                               
atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)

// got 1
atomic_read(&c->call_rcu_ttrace_in_progress)
>  	if (!rcu_trace_implies_rcu_gp())
> -		rcu_barrier();
> +		rcu_barrier(); /* wait for __free_rcu() via call_rcu */
>  	free_mem_alloc_no_barrier(ma);
>  }
>  
> @@ -565,6 +630,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  			irq_work_sync(&c->refill_work);
>  			drain_mem_cache(c);
>  			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
> +			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>  		}
>  		/* objcg is the same across cpus */
>  		if (c->objcg)
> @@ -580,6 +646,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  				irq_work_sync(&c->refill_work);
>  				drain_mem_cache(c);
>  				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
> +				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
I got a oops in rcu_tasks_invoke_cbs() during stressing test and it
seems we should do atomic_read(&call_rcu_in_progress) first, then do
atomic_read(&call_rcu_ttrace_in_progress) to fix the problem. And to
prevent memory reordering in non-x86 host, a memory barrier (e.g.,
smp_mb__before_atomic) is also needed between these two reads. Otherwise
it is possible there are inflight RCU callbacks, but we don't wait for
these callbacks as shown in the scenario below:

destroy process     __free_by_rcu

// got  0
atomic_read(&c->call_rcu_ttrace_in_progress)
                    do_call_rcu_ttrace()                                  
                        atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)
                       
                    atomic_set(&c->call_rcu_in_progress, 0)
// also got 0
atomic_read(&c->call_rcu_in_progress)

The introduction of c->tgt make the destroy procedure more complicated.
Even with the proposed fix above, there is still oops in
rcu_tasks_invoke_cbs() and I think it happens as follows:

bpf_mem_alloc_destroy           free_by_rcu for c1

// both of in_progress counter is 0
read c0->call_rcu_in_progress
read c0->call_rcu_ttrace_in_progress

                                // c1->tgt = c0
                                // c1->call_rcu_in_progress == 1
                                add c0->free_by_rcu_ttrace
                                xchg(c0->call_rcu_ttrace_in_progress, 1)
                                call_rcu_tasks_trace(c0)
                                c1->call_rcu_in_progress = 0

// both of in_progress counter is 0
read c1->call_rcu_in_progress
read c1->call_rcu_ttrace_in_progress

// BAD! There is still inflight tasks trace RCU callback
free_mem_alloc_no_barrier()

My original though is trying to do "rcu_in_progress +=
atomic_read(c->tgt->call_rcu_ttrace_in_progress)" after "rcu_in_progress
+= atomic_read(&c->call_rcu_ttrace_in_progress)" in
bpf_mem_alloc_destroy(), but c->tgt is changed in unit_free(), so c->tgt
may have been changed to B after the setting of
A->call_rcu_ttrace_in_progress. I think we could read 
c->call_rcu_ttrace_in_progress for all bpf_mem_cache again when the
summary of c->call_rcu_in_progress and c->call_rcu_ttrace_in_progress
for all bpf_mem_cache is 0, because when rcu_in_progress is zero, it
means the setting of c->tgt->call_rcu_ttrace_in_progress must have been
completed.
>  			}
>  		}
>  		if (c->objcg)
> @@ -664,6 +731,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
>  		irq_work_raise(c);
>  }
>  
> +static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
> +{
> +	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
> +	unsigned long flags;
> +
> +	c->tgt = *(struct bpf_mem_cache **)llnode;
> +
> +	local_irq_save(flags);
> +	if (local_inc_return(&c->active) == 1) {
> +		if (__llist_add(llnode, &c->free_by_rcu))
> +			c->free_by_rcu_tail = llnode;
> +	} else {
> +		llist_add(llnode, &c->free_llist_extra_rcu);
> +	}
> +	local_dec(&c->active);
> +	local_irq_restore(flags);
> +
> +	if (!atomic_read(&c->call_rcu_in_progress))
> +		irq_work_raise(c);
> +}
> +
>  /* Called from BPF program or from sys_bpf syscall.
>   * In both cases migration is disabled.
>   */
> @@ -697,6 +785,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
>  	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
>  }
>  
> +void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +	int idx;
> +
> +	if (!ptr)
> +		return;
> +
> +	idx = bpf_mem_cache_idx(ksize(ptr - LLIST_NODE_SZ));
> +	if (idx < 0)
> +		return;
> +
> +	unit_free_rcu(this_cpu_ptr(ma->caches)->cache + idx, ptr);
> +}
> +
>  void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
>  {
>  	void *ret;
> @@ -713,6 +815,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
>  	unit_free(this_cpu_ptr(ma->cache), ptr);
>  }
>  
> +void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +	if (!ptr)
> +		return;
> +
> +	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
> +}
> +
>  /* Directly does a kfree() without putting 'ptr' back to the free_llist
>   * for reuse and without waiting for a rcu_tasks_trace gp.
>   * The caller must first go through the rcu_tasks_trace gp for 'ptr'


