Return-Path: <bpf+bounces-3355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EDA73C690
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E144C1C213A6
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD9635;
	Sat, 24 Jun 2023 03:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394207F;
	Sat, 24 Jun 2023 03:28:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB4170B;
	Fri, 23 Jun 2023 20:28:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp0283bP0z4f48sy;
	Sat, 24 Jun 2023 11:28:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBHohztYpZkFFjpLg--.17657S2;
	Sat, 24 Jun 2023 11:28:49 +0800 (CST)
Subject: Re: [PATCH bpf-next 07/12] bpf: Add a hint to allocated objects.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-8-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <280a8fd5-6bc6-7924-30e3-412d5bc3c3e0@huaweicloud.com>
Date: Sat, 24 Jun 2023 11:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230621023238.87079-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBHohztYpZkFFjpLg--.17657S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF15Zr4UZFW8Zw1xJw4kCrg_yoWxGr47pF
	WfGr1kJrs5AF429w12qrsrCrZ3Zw1FqFW7K3yUu34Skr15Zwn0qF47Cry7WFy5urZ7Z3yf
	Ar1DKr1xGF4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/21/2023 10:32 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> To address OOM issue when one cpu is allocating and another cpu is freeing add
> a target bpf_mem_cache hint to allocated objects and when local cpu free_llist
> overflows free to that bpf_mem_cache. The hint addresses the OOM while
> maintaing the same performance for common case when alloc/free are done on the
> same cpu.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 4fd79bd51f5a..8b7645bffd1a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -98,6 +98,7 @@ struct bpf_mem_cache {
>  	int free_cnt;
>  	int low_watermark, high_watermark, batch;
>  	int percpu_size;
> +	struct bpf_mem_cache *tgt;
>  
>  	/* list of objects to be freed after RCU tasks trace GP */
>  	struct llist_head free_by_rcu_ttrace;
> @@ -189,18 +190,11 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>  
>  	for (i = 0; i < cnt; i++) {
>  		/*
> -		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
> -		 * IRQ works on the same CPU are called sequentially, so it is
> -		 * safe to use __llist_del_first() here. If alloc_bulk() is
> -		 * invoked by the initial prefill, there will be no running
> -		 * refill_work(), so __llist_del_first() is fine as well.
> -		 *
> -		 * In most cases, objects on free_by_rcu_ttrace are from the same CPU.
> -		 * If some objects come from other CPUs, it doesn't incur any
> -		 * harm because NUMA_NO_NODE means the preference for current
> -		 * numa node and it is not a guarantee.
> +		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
> +		 * done only by one CPU == current CPU. Other CPUs might
> +		 * llist_add() and llist_del_all() in parallel.
>  		 */
> -		obj = __llist_del_first(&c->free_by_rcu_ttrace);
> +		obj = llist_del_first(&c->free_by_rcu_ttrace);
According to the comments in llist.h, when there are concurrent
llist_del_first() and llist_del_all() operations, locking is needed.
>  		if (!obj)
>  			break;
>  		add_obj_to_free_list(c, obj);
> @@ -274,7 +268,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
>  	 * Nothing races to add to free_by_rcu_ttrace list.
>  	 */
> -	if (__llist_add(llnode, &c->free_by_rcu_ttrace))
> +	if (llist_add(llnode, &c->free_by_rcu_ttrace))
>  		c->free_by_rcu_ttrace_tail = llnode;
>  }
>  
> @@ -286,7 +280,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  		return;
>  
>  	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
> -	llnode = __llist_del_all(&c->free_by_rcu_ttrace);
> +	llnode = llist_del_all(&c->free_by_rcu_ttrace);
>  	if (llnode)
>  		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
>  		 * It doesn't race with llist_del_all either.
> @@ -299,16 +293,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  	 * If RCU Tasks Trace grace period implies RCU grace period, free
>  	 * these elements directly, else use call_rcu() to wait for normal
>  	 * progs to finish and finally do free_one() on each element.
> +	 *
> +	 * call_rcu_tasks_trace() enqueues to a global queue, so it's ok
> +	 * that current cpu bpf_mem_cache != target bpf_mem_cache.
>  	 */
>  	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
>  }
>  
>  static void free_bulk(struct bpf_mem_cache *c)
>  {
> +	struct bpf_mem_cache *tgt = c->tgt;
>  	struct llist_node *llnode, *t;
>  	unsigned long flags;
>  	int cnt;
>  
> +	WARN_ON_ONCE(tgt->unit_size != c->unit_size);
> +
>  	do {
>  		if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  			local_irq_save(flags);
> @@ -322,13 +322,13 @@ static void free_bulk(struct bpf_mem_cache *c)
>  		if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  			local_irq_restore(flags);
>  		if (llnode)
> -			enque_to_free(c, llnode);
> +			enque_to_free(tgt, llnode);
>  	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
>  
>  	/* and drain free_llist_extra */
>  	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
> -		enque_to_free(c, llnode);
> -	do_call_rcu_ttrace(c);
> +		enque_to_free(tgt, llnode);
> +	do_call_rcu_ttrace(tgt);
>  }
>  
>  static void bpf_mem_refill(struct irq_work *work)
> @@ -427,6 +427,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c->unit_size = unit_size;
>  			c->objcg = objcg;
>  			c->percpu_size = percpu_size;
> +			c->tgt = c;
>  			prefill_mem_cache(c, cpu);
>  		}
>  		ma->cache = pc;
> @@ -449,6 +450,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c = &cc->cache[i];
>  			c->unit_size = sizes[i];
>  			c->objcg = objcg;
> +			c->tgt = c;
>  			prefill_mem_cache(c, cpu);
>  		}
>  	}
> @@ -467,7 +469,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>  	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
>  	 * on these lists, so it is safe to use __llist_del_all().
>  	 */
> -	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
> +	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
>  	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
>  	free_all(__llist_del_all(&c->free_llist), percpu);
>  	free_all(__llist_del_all(&c->free_llist_extra), percpu);
> @@ -599,8 +601,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>  	local_irq_save(flags);
>  	if (local_inc_return(&c->active) == 1) {
>  		llnode = __llist_del_first(&c->free_llist);
> -		if (llnode)
> +		if (llnode) {
>  			cnt = --c->free_cnt;
> +			*(struct bpf_mem_cache **)llnode = c;
> +		}
>  	}
>  	local_dec(&c->active);
>  	local_irq_restore(flags);
> @@ -624,6 +628,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
>  
>  	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
>  
> +	/*
> +	 * Remember bpf_mem_cache that allocated this object.
> +	 * The hint is not accurate.
> +	 */
> +	c->tgt = *(struct bpf_mem_cache **)llnode;
> +
>  	local_irq_save(flags);
>  	if (local_inc_return(&c->active) == 1) {
>  		__llist_add(llnode, &c->free_llist);


