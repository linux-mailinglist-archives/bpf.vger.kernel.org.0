Return-Path: <bpf+bounces-9911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFD79EAA4
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BB52817F8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE861F175;
	Wed, 13 Sep 2023 14:11:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721761A706
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:11:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1F59E5
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:11:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rm2Rh3w1xz4f3lVV
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 22:10:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBHqFfuwgFlsr5lAQ--.54465S2;
	Wed, 13 Sep 2023 22:10:58 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b20658c4-b7b8-6bf4-7598-4acd5a07717e@huaweicloud.com>
Date: Wed, 13 Sep 2023 22:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230827152734.1995725-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBHqFfuwgFlsr5lAQ--.54465S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5CrW7Gr1xAr45Wr48JFb_yoWrXr4xpF
	s7JF1Fyr4jqFs7Ww17Jw4kAF1Fqwn5WF1xKa43Zry8Zr4Sqrn7Gr4ktryfZF9I9r4qkF4r
	tF95WF13uayUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi,

On 8/27/2023 11:27 PM, Yonghong Song wrote:
> This is needed for later percpu mem allocation when the
> allocation is done by bpf program. For such cases, a global
> bpf_global_percpu_ma is added where a flexible allocation
> size is needed.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  4 ++--
>  kernel/bpf/core.c     |  8 +++++---
>  kernel/bpf/memalloc.c | 14 ++++++--------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 12596af59c00..144dbddf53bd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -55,8 +55,8 @@ struct cgroup;
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
>  extern struct kobject *btf_kobj;
> -extern struct bpf_mem_alloc bpf_global_ma;
> -extern bool bpf_global_ma_set;
> +extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> +extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>  
>  typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>  typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0f8f036d8bd1..95599df82ee4 100644
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
> @@ -2921,7 +2921,9 @@ static int __init bpf_global_ma_init(void)
>  
>  	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>  	bpf_global_ma_set = !ret;
> -	return ret;
> +	ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> +	bpf_global_percpu_ma_set = !ret;
> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>  }
>  late_initcall(bpf_global_ma_init);
>  #endif
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 9c49ae53deaf..cb60445de98a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -499,15 +499,16 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  	struct obj_cgroup *objcg = NULL;
>  	int cpu, i, unit_size, percpu_size = 0;
>  
> +	/* room for llist_node and per-cpu pointer */
> +	if (percpu)
> +		percpu_size = LLIST_NODE_SZ + sizeof(void *);
> +
>  	if (size) {
>  		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
>  		if (!pc)
>  			return -ENOMEM;
>  
> -		if (percpu)
> -			/* room for llist_node and per-cpu pointer */
> -			percpu_size = LLIST_NODE_SZ + sizeof(void *);
> -		else
> +		if (!percpu)
>  			size += LLIST_NODE_SZ; /* room for llist_node */
>  		unit_size = size;
>  
> @@ -527,10 +528,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  		return 0;
>  	}
>  
> -	/* size == 0 && percpu is an invalid combination */
> -	if (WARN_ON_ONCE(percpu))
> -		return -EINVAL;
> -
>  	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
>  	if (!pcc)
>  		return -ENOMEM;
> @@ -543,6 +540,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c = &cc->cache[i];
>  			c->unit_size = sizes[i];
>  			c->objcg = objcg;
> +			c->percpu_size = percpu_size;
>  			c->tgt = c;
>  			prefill_mem_cache(c, cpu);
>  		}

It would trigger the WARN_ON_ONCE in free_bulk().  Because for per-cpu
ptr returned by bpf memory allocator, ksize() in bpf_mem_free() will
return 16 constantly, so it will be unmatched with the unit_size of the
source bpf_mem_cache. Have not found a good solution for the problem yet
except disabling the warning for per-cpu bpf memory allocator, because
now per-cpu allocator doesn't have an API to return the size of the
returned ptr. Could we make the verifier to remember the size of the
allocator object and pass it to bpf memory allocator ?


