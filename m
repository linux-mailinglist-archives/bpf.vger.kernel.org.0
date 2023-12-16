Return-Path: <bpf+bounces-18076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A58156A3
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 04:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BAD284D0B
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526D187B;
	Sat, 16 Dec 2023 03:12:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8831869
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SsWN24rshz4f3jJH
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:12:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BB06E1A0892
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:12:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAXGxGEFX1lve8WDw--.48666S2;
	Sat, 16 Dec 2023 11:12:07 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231216023004.3738749-1-yonghong.song@linux.dev>
 <20231216023015.3741144-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ca0512d6-fa01-9d94-017f-a717756dcf86@huaweicloud.com>
Date: Sat, 16 Dec 2023 11:12:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231216023015.3741144-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAXGxGEFX1lve8WDw--.48666S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF18CFyktw18XF1fJr4kCrg_yoW5Gr43pF
	W2g3s7Ars5ZrZrWw1fX3Z2vF93t34FgF1jq3y5CrykurnxWr1DCr40yry7uFZ5ursrJa17
	tFZ5Wr17uFyqvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

On 12/16/2023 10:30 AM, Yonghong Song wrote:
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

SNIP
> +__init int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
> +{
> +	struct bpf_mem_caches __percpu *pcc;
> +
> +	pcc = __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL);
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
> +	int cpu, i, err = 0, unit_size, percpu_size;
> +	struct bpf_mem_caches *cc, __percpu *pcc;
> +	struct obj_cgroup *objcg;
> +	struct bpf_mem_cache *c;
> +
> +	i = bpf_mem_cache_idx(size);
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	/* room for llist_node and per-cpu pointer */
> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
> +
> +	pcc = ma->caches;
> +	unit_size = sizes[i];
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +	objcg = get_obj_cgroup_from_current();
> +#endif

For bpf_global_percpu_ma, we also need to account the allocated memory
to root memory cgroup just like bpf_global_ma did, do we ? So it seems
that we need to initialize c->objcg early in bpf_mem_alloc_percpu_init ().
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
> +				drain_mem_cache(c);
> +				memset(c, 0, sizeof(*c));

I also forgot about c->objcg. objcg may be leaked if we do memset() here.
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> +
>  
.


