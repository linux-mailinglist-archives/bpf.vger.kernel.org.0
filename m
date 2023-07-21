Return-Path: <bpf+bounces-5572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8C75BC3F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 04:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831831C215B8
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03762E;
	Fri, 21 Jul 2023 02:24:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845F38F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:24:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F3211B
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:24:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6YKQ0Yn8z4f3k6P
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 10:24:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDXvgxX7LlkP6atNQ--.33671S2;
	Fri, 21 Jul 2023 10:24:26 +0800 (CST)
Subject: Re: [PATCH bpf 2/2] bpf/memalloc: Schedule highprio wq for non-atomic
 alloc when atomic fails
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
References: <cover.1689885610.git.zhuyifei@google.com>
 <3516fa9cc4bdbaeb90f208f5c970e622ba76be3e.1689885610.git.zhuyifei@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <87874222-1d01-b08b-87e5-a94d90167e94@huaweicloud.com>
Date: Fri, 21 Jul 2023 10:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3516fa9cc4bdbaeb90f208f5c970e622ba76be3e.1689885610.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXvgxX7LlkP6atNQ--.33671S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWUGr1UZrWDJFWrGrW7Jwb_yoWxuF1DpF
	4ftF1rArs5ZF47Ww4xW3WxAasakr18t3W7G3y8W34S9rWFgr1DKa1qkry2qFy5urZrGa13
	Ar4DKryxGF4UZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/21/2023 4:44 AM, YiFei Zhu wrote:
> Atomic refill can fail, such as when all percpu chunks are full,
> and when that happens there's no guarantee when more space will be
> available for atomic allocations.
>
> Instead of having the caller wait for memory to be available by
> retrying until the related BPF API no longer gives -ENOMEM, we can
> kick off a non-atomic GFP_KERNEL allocation with highprio workqueue.
> This should make it much less likely for those APIs to return
> -ENOMEM.
>
> Because alloc_bulk can now be called from the workqueue,
> non-atomic calls now also calls local_irq_save/restore to reduce
> the chance of races.
>
> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>  kernel/bpf/memalloc.c | 47 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 016249672b43..2915639a5e16 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -84,14 +84,15 @@ struct bpf_mem_cache {
>  	struct llist_head free_llist;
>  	local_t active;
>  
> -	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill
> +	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill_*
>  	 * are sequenced by per-cpu 'active' counter. But unit_free() cannot
>  	 * fail. When 'active' is busy the unit_free() will add an object to
>  	 * free_llist_extra.
>  	 */
>  	struct llist_head free_llist_extra;
>  
> -	struct irq_work refill_work;
> +	struct irq_work refill_work_irq;
> +	struct work_struct refill_work_wq;
>  	struct obj_cgroup *objcg;
>  	int unit_size;
>  	/* count of objects in free_llist */
> @@ -153,7 +154,7 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
>  #endif
>  }
>  
> -/* Mostly runs from irq_work except __init phase. */
> +/* Mostly runs from irq_work except workqueue and __init phase. */
>  static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  {
>  	struct mem_cgroup *memcg = NULL, *old_memcg;
> @@ -188,10 +189,18 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  			 * want here.
>  			 */
>  			obj = __alloc(c, node, gfp);
> -			if (!obj)
> +			if (!obj) {
> +				/* We might have exhausted the percpu chunks, schedule
> +				 * non-atomic allocation so hopefully caller can get
> +				 * a free unit upon next invocation.
> +				 */
> +				if (atomic)
> +					queue_work_on(smp_processor_id(),
> +						      system_highpri_wq, &c->refill_work_wq);

I am not a MM expert. But according to the code in
pcpu_balance_workfn(), it will try to do pcpu_create_chunk() when
pcpu_atomic_alloc_failed is true, so the reason for introducing
refill_work_wq is that pcpu_balance_workfn is too slow to fulfill the
allocation request from bpf memory allocator ?
>  				break;
> +			}
>  		}
> -		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
>  			/* In RT irq_work runs in per-cpu kthread, so disable
>  			 * interrupts to avoid preemption and interrupts and
>  			 * reduce the chance of bpf prog executing on this cpu
> @@ -208,7 +217,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  		__llist_add(obj, &c->free_llist);
>  		c->free_cnt++;
>  		local_dec(&c->active);
> -		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
>  			local_irq_restore(flags);
>  	}
>  	set_active_memcg(old_memcg);
> @@ -314,9 +323,9 @@ static void free_bulk(struct bpf_mem_cache *c)
>  	do_call_rcu(c);
>  }
>  
> -static void bpf_mem_refill(struct irq_work *work)
> +static void bpf_mem_refill_irq(struct irq_work *work)
>  {
> -	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
> +	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work_irq);
>  	int cnt;
>  
>  	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
> @@ -332,7 +341,14 @@ static void bpf_mem_refill(struct irq_work *work)
>  
>  static void notrace irq_work_raise(struct bpf_mem_cache *c)
>  {
> -	irq_work_queue(&c->refill_work);
> +	irq_work_queue(&c->refill_work_irq);
> +}
> +
> +static void bpf_mem_refill_wq(struct work_struct *work)
> +{
> +	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work_wq);
> +
> +	alloc_bulk(c, c->batch, NUMA_NO_NODE, false);

Considering that the kworker may be interrupted by irq work, so there
will be concurrent __llist_del_first() operations on free_by_rcu, andI
think it is not safe to call alloc_bulk directly here. Maybe we can just
skip __llist_del_first() for !atomic context.

>  }
>  
>  /* For typical bpf map case that uses bpf_mem_cache_alloc and single bucket
> @@ -352,7 +368,8 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
>  
>  static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>  {
> -	init_irq_work(&c->refill_work, bpf_mem_refill);
> +	init_irq_work(&c->refill_work_irq, bpf_mem_refill_irq);
> +	INIT_WORK(&c->refill_work_wq, bpf_mem_refill_wq);
>  	if (c->unit_size <= 256) {
>  		c->low_watermark = 32;
>  		c->high_watermark = 96;
> @@ -529,7 +546,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  		for_each_possible_cpu(cpu) {
>  			c = per_cpu_ptr(ma->cache, cpu);
>  			/*
> -			 * refill_work may be unfinished for PREEMPT_RT kernel
> +			 * refill_work_irq may be unfinished for PREEMPT_RT kernel
>  			 * in which irq work is invoked in a per-CPU RT thread.
>  			 * It is also possible for kernel with
>  			 * arch_irq_work_has_interrupt() being false and irq
> @@ -537,7 +554,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  			 * the completion of irq work to ease the handling of
>  			 * concurrency.
>  			 */
> -			irq_work_sync(&c->refill_work);
> +			irq_work_sync(&c->refill_work_irq);
> +			cancel_work_sync(&c->refill_work_wq);

cancel_work_sync() may be time-consuming. We may need to move it to
free_mem_alloc_deferred() to prevent blocking the destroy of bpf memory
allocator.
>  			drain_mem_cache(c);
>  			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>  		}
> @@ -552,7 +570,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  			cc = per_cpu_ptr(ma->caches, cpu);
>  			for (i = 0; i < NUM_CACHES; i++) {
>  				c = &cc->cache[i];
> -				irq_work_sync(&c->refill_work);
> +				irq_work_sync(&c->refill_work_irq);
> +				cancel_work_sync(&c->refill_work_wq);
>  				drain_mem_cache(c);
>  				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>  			}
> @@ -580,7 +599,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>  	 *
>  	 * but prog_B could be a perf_event NMI prog.
>  	 * Use per-cpu 'active' counter to order free_list access between
> -	 * unit_alloc/unit_free/bpf_mem_refill.
> +	 * unit_alloc/unit_free/bpf_mem_refill_*.
>  	 */
>  	local_irq_save(flags);
>  	if (local_inc_return(&c->active) == 1) {


