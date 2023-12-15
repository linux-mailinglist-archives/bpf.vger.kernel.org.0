Return-Path: <bpf+bounces-17941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152581402B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566E01C2219A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC90110C;
	Fri, 15 Dec 2023 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PcdcQUGf"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29865ED6
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44612e98-ff40-432e-80db-510c8817bd13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702608306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uWWowtw4c/3hHhxWlhjRTNOaDG7K2WX6j+cSmxNuQc=;
	b=PcdcQUGf4KJdwldmtJ8jAyezDjqfKFA1EcTvV2tpQVBZWEYPjpWJCqPRX6qbjGPbz1STDh
	HAMWK/2n6hOalFnXkhsQC8vxnwvhhPs//AebN7RtrBGTxwwsqcwvv3HxOkiw3YSib+Vpd+
	WIC0+8nzQAqlR5pKUkjqPSPU6+MVO5A=
Date: Thu, 14 Dec 2023 18:45:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001209.3252729-1-yonghong.song@linux.dev>
In-Reply-To: <20231215001209.3252729-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/14/23 4:12 PM, Yonghong Song wrote:
> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem allocation")
> added support for non-fix-size percpu memory allocation.
> Such allocation will allocate percpu memory for all buckets on all
> cpus and the memory consumption is in the order to quadratic.
> For example, let us say, 4 cpus, unit size 16 bytes, so each
> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256 bytes.
> Then let us say, 8 cpus with the same unit size, each cpu
> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024 bytes.
> So if the number of cpus doubles, the number of memory consumption
> will be 4 times. So for a system with large number of cpus, the
> memory consumption goes up quickly with quadratic order.
> For example, for 4KB percpu allocation, 128 cpus. The total memory
> consumption will 4KB * 128 * 128 = 64MB. Things will become
> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
>
> In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
> done in boot time, so for system with large number of cpus, the initial
> percpu memory consumption is very visible. For example, for 128 cpu
> system, the total percpu memory allocation will be at least
> (16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
>    * 128 * 128 = ~138MB.
> which is pretty big. It will be even bigger for larger number of cpus.
>
> Note that the current prefill also allocates 4 entries if the unit size
> is less than 256. So on top of 138MB memory consumption, this will
> add more consumption with
> 3 * (16 + 32 + 64 + 96 + 128 + 196 + 256) * 128 * 128 = ~38MB.
> Next patch will try to reduce this memory consumption.
>
> Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
> at init stage") moved the non-fix-size percpu memory allocation
> to bpf verificaiton stage. Once a particular bpf_percpu_obj_new()
> is called by bpf program, the memory allocator will try to fill in
> the cache with all sizes, causing the same amount of percpu memory
> consumption as in the boot stage.
>
> To reduce the initial percpu memory consumption for non-fix-size
> percpu memory allocation, instead of filling the cache with all
> supported allocation sizes, this patch intends to fill the cache
> only for the requested size. As typically users will not use large
> percpu data structure, this can save memory significantly.
> For example, the allocation size is 64 bytes with 128 cpus.
> Then total percpu memory amount will be 64 * 128 * 128 = 1MB,
> much less than previous 138MB.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   include/linux/bpf.h           |  2 +-
>   include/linux/bpf_mem_alloc.h |  7 ++++
>   kernel/bpf/core.c             |  8 +++--
>   kernel/bpf/memalloc.c         | 68 ++++++++++++++++++++++++++++++++++-
>   kernel/bpf/verifier.c         | 28 ++++++---------
>   5 files changed, 91 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c87c608a3689..f1f16449fbc4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -60,7 +60,7 @@ extern struct idr btf_idr;
>   extern spinlock_t btf_idr_lock;
>   extern struct kobject *btf_kobj;
>   extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> -extern bool bpf_global_ma_set;
> +extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>   
>   typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>   typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index bb1223b21308..43e635c67150 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -21,8 +21,15 @@ struct bpf_mem_alloc {
>    * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
>    * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
>    * the returned object is given by the size argument of bpf_mem_alloc().
> + * If percpu equals true, error will be returned in order to avoid
> + * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
> + * should be used to do on-demand per-cpu allocation for each size.
>    */
>   int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
> +/* Initialize a non-fix-size percpu memory allocator */
> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma);
> +/* The percpu allocation with a specific unit size. */
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
>   void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>   
>   /* kmalloc/kfree equivalent: */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c34513d645c4..4a9177770f93 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -64,8 +64,8 @@
>   #define OFF	insn->off
>   #define IMM	insn->imm
>   
> -struct bpf_mem_alloc bpf_global_ma;
> -bool bpf_global_ma_set;
> +struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> +bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>   
>   /* No hurry in this branch
>    *
> @@ -2938,7 +2938,9 @@ static int __init bpf_global_ma_init(void)
>   
>   	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>   	bpf_global_ma_set = !ret;
> -	return ret;
> +	ret = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
> +	bpf_global_percpu_ma_set = !ret;
> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>   }
>   late_initcall(bpf_global_ma_init);
>   #endif
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 472158f1fb08..aea4cd07c7b6 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -121,6 +121,8 @@ struct bpf_mem_caches {
>   	struct bpf_mem_cache cache[NUM_CACHES];
>   };
>   
> +static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
> +
>   static struct llist_node notrace *__llist_del_first(struct llist_head *head)
>   {
>   	struct llist_node *entry, *next;
> @@ -520,12 +522,14 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>    */
>   int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>   {
> -	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
>   	int cpu, i, err, unit_size, percpu_size = 0;
>   	struct bpf_mem_caches *cc, __percpu *pcc;
>   	struct bpf_mem_cache *c, __percpu *pc;
>   	struct obj_cgroup *objcg = NULL;
>   
> +	if (percpu && size == 0)
> +		return -EINVAL;
> +
>   	/* room for llist_node and per-cpu pointer */
>   	if (percpu)
>   		percpu_size = LLIST_NODE_SZ + sizeof(void *);
> @@ -625,6 +629,68 @@ static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
>   	drain_mem_cache(c);
>   }
>   
> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
> +{
> +	struct bpf_mem_caches __percpu *pcc;
> +
> +	pcc = __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL | __GFP_ZERO);
> +	if (!pcc)
> +		return -ENOMEM;
> +
> +	ma->caches = pcc;
> +	ma->percpu = true;
> +	return 0;
> +}
> +
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
> +{
> +	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};

Sorry, a oversight here. The above should be removed. Will fix in the next revision.

> +	int cpu, i, err, unit_size, percpu_size = 0;
> +	struct bpf_mem_caches *cc, __percpu *pcc;
> +	struct obj_cgroup *objcg = NULL;
> +	struct bpf_mem_cache *c;
> +
> +	/* room for llist_node and per-cpu pointer */
> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
> +
> +	i = bpf_mem_cache_idx(size);
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	err = 0;
> +	pcc = ma->caches;
> +	unit_size = sizes[i];
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +	objcg = get_obj_cgroup_from_current();
> +#endif
> +	for_each_possible_cpu(cpu) {
> +		cc = per_cpu_ptr(pcc, cpu);
> +		c = &cc->cache[i];
> +		if (cpu == 0 && c->unit_size)
> +			goto out;
> +
> +		c->unit_size = unit_size;
> +		c->objcg = objcg;
> +		c->percpu_size = percpu_size;
> +		c->tgt = c;
> +
> +		init_refill_work(c);
> +		prefill_mem_cache(c, cpu);
> +
> +		if (cpu == 0) {
> +			err = check_obj_size(c, i);
> +			if (err) {
> +				bpf_mem_alloc_destroy_cache(c);
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> +
>   static void check_mem_cache(struct bpf_mem_cache *c)
>   {
>   	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
[...]

