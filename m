Return-Path: <bpf+bounces-17947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B63814090
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 04:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3713B219F7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8750525E;
	Fri, 15 Dec 2023 03:19:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBED46B1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Srvb10mF7z4f3jMB
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:19:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F80F1A0928
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:19:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3EUK6xXtlc8ckDw--.55005S2;
	Fri, 15 Dec 2023 11:19:26 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001209.3252729-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a8856c91-b8af-2293-3505-7a20d79cc89c@huaweicloud.com>
Date: Fri, 15 Dec 2023 11:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215001209.3252729-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3EUK6xXtlc8ckDw--.55005S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fuw1UAr13AFyUAw4fKrg_yoWxXF13pF
	WxGry8Ar4qvFZrW3WxXan7CFySq340gF1jg3y5ury09rs3Wr1kGF4ktry3ZF98ur4DGa13
	tFZYgr1xuFWUZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 12/15/2023 8:12 AM, Yonghong Song wrote:
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
SNIP
> index bb1223b21308..43e635c67150 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -21,8 +21,15 @@ struct bpf_mem_alloc {
>   * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
>   * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
>   * the returned object is given by the size argument of bpf_mem_alloc().
> + * If percpu equals true, error will be returned in order to avoid
> + * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
> + * should be used to do on-demand per-cpu allocation for each size.
>   */
>  int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
> +/* Initialize a non-fix-size percpu memory allocator */
> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma);
> +/* The percpu allocation with a specific unit size. */
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
>  void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>  
>  /* kmalloc/kfree equivalent: */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c34513d645c4..4a9177770f93 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -64,8 +64,8 @@
>  #define OFF	insn->off
>  #define IMM	insn->imm
>  
> -struct bpf_mem_alloc bpf_global_ma;
> -bool bpf_global_ma_set;
> +struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> +bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>  
>  /* No hurry in this branch
>   *
> @@ -2938,7 +2938,9 @@ static int __init bpf_global_ma_init(void)
>  
>  	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>  	bpf_global_ma_set = !ret;
> -	return ret;
> +	ret = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
> +	bpf_global_percpu_ma_set = !ret;
> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>  }
>  late_initcall(bpf_global_ma_init);
>  #endif
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 472158f1fb08..aea4cd07c7b6 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -121,6 +121,8 @@ struct bpf_mem_caches {
>  	struct bpf_mem_cache cache[NUM_CACHES];
>  };
>  
> +static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};

Is it better to make it being const ?
> +
>  static struct llist_node notrace *__llist_del_first(struct llist_head *head)
>  {
>  	struct llist_node *entry, *next;
> @@ -520,12 +522,14 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>   */
>  int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  {
> -	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
>  	int cpu, i, err, unit_size, percpu_size = 0;
>  	struct bpf_mem_caches *cc, __percpu *pcc;
>  	struct bpf_mem_cache *c, __percpu *pc;
>  	struct obj_cgroup *objcg = NULL;
>  
> +	if (percpu && size == 0)
> +		return -EINVAL;
> +
>  	/* room for llist_node and per-cpu pointer */
>  	if (percpu)
>  		percpu_size = LLIST_NODE_SZ + sizeof(void *);
> @@ -625,6 +629,68 @@ static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
>  	drain_mem_cache(c);
>  }
>  
> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
> +{
> +	struct bpf_mem_caches __percpu *pcc;
> +
> +	pcc = __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL | __GFP_ZERO);
> +	if (!pcc)
> +		return -ENOMEM;

__GFP_ZERO is not needed. __alloc_percpu_gfp() will zero the returned
area by default.
> +
> +	ma->caches = pcc;
> +	ma->percpu = true;
> +	return 0;
> +}
> +
> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
> +{
> +	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
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

It seems drain_mem_cache() will be enough. Have you considered setting
low_watermark as 0 to prevent potential refill in unit_alloc() if the
initialization of the current unit fails ?
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
>
.


