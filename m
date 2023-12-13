Return-Path: <bpf+bounces-17657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C3810F58
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C94B20D40
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF523742;
	Wed, 13 Dec 2023 11:03:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BE9C
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:03:52 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sqszl5FQbz4f3k6Y
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:03:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F33C51A0392
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:03:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDni0qRj3ll+JOODg--.34691S2;
	Wed, 13 Dec 2023 19:03:48 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/5] bpf: Allow per unit prefill for non-fix-size
 percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223050.2137647-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ab1146fa-db28-c1a3-bfef-3dc7b1575738@huaweicloud.com>
Date: Wed, 13 Dec 2023 19:03:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212223050.2137647-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDni0qRj3ll+JOODg--.34691S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fuw1UWw4DGr1fGr4xCrg_yoW3tw1kpF
	Z7KryrArn0qFZrWw1Sgan7CFyFq340gF18K343Zry8ur4fWrn7Wr4vyryfZF98Cr4kGa17
	tFyv9r47uFWUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/13/2023 6:30 AM, Yonghong Song wrote:
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
>   * 128 * 128 = ~138MB.
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
>  include/linux/bpf_mem_alloc.h |  5 +++
>  kernel/bpf/memalloc.c         | 62 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c         | 23 +++++--------
>  3 files changed, 75 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index bb1223b21308..b049c580e7fb 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -21,8 +21,13 @@ struct bpf_mem_alloc {
>   * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
>   * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
>   * the returned object is given by the size argument of bpf_mem_alloc().
> + * If percpu equals true, error will be returned in order to avoid
> + * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
> + * should be used to do on-demand per-cpu allocation for each size.
>   */
>  int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
> +/* The percpu allocation is allowed for different unit size. */
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
>  void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>  
>  /* kmalloc/kfree equivalent: */
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 75068167e745..84987e97fd0a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -526,6 +526,9 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  	struct bpf_mem_cache *c, __percpu *pc;
>  	struct obj_cgroup *objcg = NULL;
>  
> +	if (percpu && size == 0)
> +		return -EINVAL;
> +
>  	/* room for llist_node and per-cpu pointer */
>  	if (percpu)
>  		percpu_size = LLIST_NODE_SZ + sizeof(void *);
> @@ -625,6 +628,65 @@ static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
>  	drain_mem_cache(c);
>  }
>  
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
> +{
> +	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};

Why duplicate the sizes array ? It is better to move it out of these
functions and share it between both bpf_mem_alloc_ini() and
bpf_mem_alloc_percpu_unit_init().

> +	int cpu, i, err, unit_size, percpu_size = 0;
> +	struct bpf_mem_caches *cc, __percpu *pcc;
> +	struct obj_cgroup *objcg = NULL;
> +	struct bpf_mem_cache *c;
> +
> +	/* room for llist_node and per-cpu pointer */
> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
> +
> +	if (ma->caches) {
> +		pcc = ma->caches;
> +	} else {
> +		ma->percpu = true;
> +		pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL | __GFP_ZERO);
> +		if (!pcc)
> +			return -ENOMEM;
> +		ma->caches = pcc;
> +	}

It is a little weird to me that a single API does two things:
initialization and incremental refill. How about introducing two APIs to
reduce the memory usage of global per-cpu ma: one API to initialize the
global per-cpu ma in bpf_global_ma_init(), and another API to
incremental refill global per-cpu ma accordingly ?

> +
> +	err = 0;
> +	i = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
> +	if (i < 0) {
> +		err = -EINVAL;
> +		goto out;
> +	}
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
>  static void check_mem_cache(struct bpf_mem_cache *c)
>  {
>  	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d1755db1b503..0c55fe4451e1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -43,7 +43,6 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>  };
>  
>  struct bpf_mem_alloc bpf_global_percpu_ma;
> -static bool bpf_global_percpu_ma_set;
>  
>  /* bpf_check() is a static code analyzer that walks eBPF program
>   * instruction by instruction and updates register/stack state.
> @@ -12071,20 +12070,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>  					return -ENOMEM;
>  
> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> -					if (!bpf_global_percpu_ma_set) {
> -						mutex_lock(&bpf_percpu_ma_lock);
> -						if (!bpf_global_percpu_ma_set) {
> -							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> -							if (!err)
> -								bpf_global_percpu_ma_set = true;
> -						}
> -						mutex_unlock(&bpf_percpu_ma_lock);
> -						if (err)
> -							return err;
> -					}
> -				}
> -
>  				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>  					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
>  					return -EINVAL;
> @@ -12105,6 +12090,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  					return -EINVAL;
>  				}
>  
> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					mutex_lock(&bpf_percpu_ma_lock);
> +					err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
> +					mutex_unlock(&bpf_percpu_ma_lock);
> +					if (err)
> +						return err;
> +				}
> +
>  				struct_meta = btf_find_struct_meta(ret_btf, ret_btf_id);
>  				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>  					if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {


