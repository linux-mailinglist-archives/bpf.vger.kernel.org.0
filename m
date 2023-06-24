Return-Path: <bpf+bounces-3364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0373C9EC
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 11:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EDE281FE6
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B13FFE;
	Sat, 24 Jun 2023 09:12:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3A230F2;
	Sat, 24 Jun 2023 09:12:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C60118;
	Sat, 24 Jun 2023 02:12:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp7fb520cz4f3tY3;
	Sat, 24 Jun 2023 17:12:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXZud1s5Zk2WVfMQ--.33175S2;
	Sat, 24 Jun 2023 17:12:24 +0800 (CST)
Subject: Re: [PATCH bpf-next 11/12] bpf: Introduce bpf_mem_free_rcu() similar
 to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-12-alexei.starovoitov@gmail.com>
 <eee33106-21ef-9f0b-86e7-137deefc6f50@huaweicloud.com>
 <20230622032330.3allcf7legl6vhp5@macbook-pro-8.dhcp.thefacebook.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <05cde576-e480-46e1-1228-7f54497a6252@huaweicloud.com>
Date: Sat, 24 Jun 2023 17:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230622032330.3allcf7legl6vhp5@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXZud1s5Zk2WVfMQ--.33175S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3Ary3Zr1fJr1DZFWrXwb_yoWrtF48pF
	WxK3WUArs5ZFsFkw1xXw4xua95tr9Yqa43Wa48XFyYvrn0k34vgFsrKrWfuFyF9rWkWw4a
	vrn0kryjga4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/22/2023 11:23 AM, Alexei Starovoitov wrote:
> On Wed, Jun 21, 2023 at 08:26:30PM +0800, Hou Tao wrote:
>>>  	
SNIP
>>>  				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
>>> +				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>> I got a oops in rcu_tasks_invoke_cbs() during stressing test and it
>> seems we should do atomic_read(&call_rcu_in_progress) first, then do
>> atomic_read(&call_rcu_ttrace_in_progress) to fix the problem. And to
> yes. it's a race. As you find out yourself changing the order won't fix it.
>
>> The introduction of c->tgt make the destroy procedure more complicated.
>> Even with the proposed fix above, there is still oops in
>> rcu_tasks_invoke_cbs() and I think it happens as follows:
> Right. That's another issue.
>
> Please send bench htab test and your special stress test,
> so we can have a common ground to reason about.
> Also please share your bench htab numbers before/after.
Will send htab-mem benchmark next week and update the benchmark results
accordingly.

There is no peculiarity in my local stress test. I just hacked htab to
use bpf_mem_cache_free_rcu() and ran multiple tests_maps, map_perf_test
and htab_mem benchmark simultaneously.
>
> I'm thinking to fix the races in the following way.
> Could you please test it with your stress test?
> The idea is to set 'draining' first everywhere that it will make all rcu
> callbacks a nop.
> Then drain all link lists. At this point nothing races with them.
> And then wait for single rcu_barrier_tasks_trace() that will make sure
> all callbcaks done. At this point the only thing they will do is
> if (c->draining) goto out;
> The barriers are needed to make 'c' access not uaf.
As I replied in the v2, I don't think the lockless checking of
c->draining will work. And I will test it anyway.
>
> ...
>
> >From e20782160166d4327c76b57af160c4973396e0d0 Mon Sep 17 00:00:00 2001
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Wed, 21 Jun 2023 20:11:33 -0700
> Subject: [PATCH bpf-next] bpf: Fix races.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/memalloc.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 4d1002e7b4b5..75c553b15deb 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -99,6 +99,7 @@ struct bpf_mem_cache {
>  	int low_watermark, high_watermark, batch;
>  	int percpu_size;
>  	struct bpf_mem_cache *tgt;
> +	bool draining;
>  
>  	/* list of objects to be freed after RCU GP */
>  	struct llist_head free_by_rcu;
> @@ -264,7 +265,10 @@ static void __free_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
>  
> +	if (unlikely(c->draining))
> +		goto out;
>  	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
> +out:
>  	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>  }
>  
> @@ -353,8 +357,11 @@ static void __free_by_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>  	struct bpf_mem_cache *tgt = c->tgt;
> -	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
> +	struct llist_node *llnode;
>  
> +	if (unlikely(c->draining))
> +		goto out;
> +	llnode = llist_del_all(&c->waiting_for_gp);
>  	if (!llnode)
>  		goto out;
>  
> @@ -568,10 +575,9 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
>  	 * using rcu_trace_implies_rcu_gp() as well.
>  	 */
> -	rcu_barrier(); /* wait for __free_by_rcu() */
> -	rcu_barrier_tasks_trace(); /* wait for __free_rcu() via call_rcu_tasks_trace */
> +	rcu_barrier_tasks_trace();
>  	if (!rcu_trace_implies_rcu_gp())
> -		rcu_barrier(); /* wait for __free_rcu() via call_rcu */
> +		rcu_barrier();
>  	free_mem_alloc_no_barrier(ma);
>  }
>  
> @@ -616,6 +622,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  
>  	if (ma->cache) {
>  		rcu_in_progress = 0;
> +		for_each_possible_cpu(cpu) {
> +			c = per_cpu_ptr(ma->cache, cpu);
> +			c->draining = true;
> +		}
>  		for_each_possible_cpu(cpu) {
>  			c = per_cpu_ptr(ma->cache, cpu);
>  			/*
> @@ -639,6 +649,13 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>  	}
>  	if (ma->caches) {
>  		rcu_in_progress = 0;
> +		for_each_possible_cpu(cpu) {
> +			cc = per_cpu_ptr(ma->caches, cpu);
> +			for (i = 0; i < NUM_CACHES; i++) {
> +				c = &cc->cache[i];
> +				c->draining = true;
> +			}
> +		}
>  		for_each_possible_cpu(cpu) {
>  			cc = per_cpu_ptr(ma->caches, cpu);
>  			for (i = 0; i < NUM_CACHES; i++) {


