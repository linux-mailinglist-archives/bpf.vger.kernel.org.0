Return-Path: <bpf+bounces-5570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5BF75BBEB
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01731C2157F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7354391;
	Fri, 21 Jul 2023 01:44:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A5363
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:44:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68CC186
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 18:44:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6XRj5t7rz4f3vfg
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:44:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXsRsP47lkIYu4Ng--.45930S2;
	Fri, 21 Jul 2023 09:44:50 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist
 during prefill
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
References: <cover.1689885610.git.zhuyifei@google.com>
 <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com>
Date: Fri, 21 Jul 2023 09:44:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXsRsP47lkIYu4Ng--.45930S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZryrWryUKw17Wr48Ww4DArb_yoW5XF1fpF
	47KFykZFs5ZF17uaya934IkFyFyw1ktry7GayDX34vvr1FgryDGr4kJF9rWFy5urZ5CF45
	ArsYgrn3tayUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/2023 4:44 AM, YiFei Zhu wrote:
> Sometimes during prefill all precpu chunks are full and atomic
> __alloc_percpu_gfp would not allocate new chunks. This will cause
> -ENOMEM immediately upon next unit_alloc.
>
> Prefill phase does not actually run in atomic context, so we can
> use this fact to allocate non-atomically with GFP_KERNEL instead
> of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
> unit_alloc runs in atomic context, even from map item allocation in
> syscalls, due to rcu_read_lock, so we can't do non-atomic
> workarounds in unit_alloc.
>
> Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_alloc.")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Make sense to me, so

Acked-by: Hou Tao <houtao1@huawei.com>

But I don't know whether or not it is suitable for bpf tree.
> ---
>  kernel/bpf/memalloc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 0668bcd7c926..016249672b43 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -154,13 +154,17 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
>  }
>  
>  /* Mostly runs from irq_work except __init phase. */
> -static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  {
>  	struct mem_cgroup *memcg = NULL, *old_memcg;
>  	unsigned long flags;
> +	gfp_t gfp;
>  	void *obj;
>  	int i;
>  
> +	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
> +	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
> +
>  	memcg = get_memcg(c);
>  	old_memcg = set_active_memcg(memcg);
>  	for (i = 0; i < cnt; i++) {
> @@ -183,7 +187,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>  			 * will allocate from the current numa node which is what we
>  			 * want here.
>  			 */
> -			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
> +			obj = __alloc(c, node, gfp);
>  			if (!obj)
>  				break;
>  		}
> @@ -321,7 +325,7 @@ static void bpf_mem_refill(struct irq_work *work)
>  		/* irq_work runs on this cpu and kmalloc will allocate
>  		 * from the current numa node which is what we want here.
>  		 */
> -		alloc_bulk(c, c->batch, NUMA_NO_NODE);
> +		alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
>  	else if (cnt > c->high_watermark)
>  		free_bulk(c);
>  }
> @@ -367,7 +371,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>  	 * prog won't be doing more than 4 map_update_elem from
>  	 * irq disabled region
>  	 */
> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
> +	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>  }
>  
>  /* When size != 0 bpf_mem_cache for each cpu.


