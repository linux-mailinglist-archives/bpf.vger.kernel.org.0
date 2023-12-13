Return-Path: <bpf+bounces-17660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53194810F7F
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8236B1C20AAC
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108C23753;
	Wed, 13 Dec 2023 11:09:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04BCEB
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:09:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sqt6b1mGnz4f3jHZ
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:09:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 77FB81A036D
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:09:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXvEr1kHllz_qODg--.37860S2;
	Wed, 13 Dec 2023 19:09:44 +0800 (CST)
Subject: Re: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for
 bpf_global_percpu_ma allocation
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223100.2138537-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d44e41c2-9c59-c7a3-87a4-bf20ce779b6a@huaweicloud.com>
Date: Wed, 13 Dec 2023 19:09:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212223100.2138537-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXvEr1kHllz_qODg--.37860S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1xWrW5uw1DGFWkCr17ZFb_yoW8ZFWUp3
	97GF90yF1qvrsxWw13ta17Ary5X3y0g3W7K3y5A34ayrsaqwn2gF4vkry5Zry5Kr48Ga1I
	yryjvrWav3y7ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/13/2023 6:31 AM, Yonghong Song wrote:
> For percpu data structure allocation with bpf_global_percpu_ma,
> the maximum data size is 4K. But for a system with large
> number of cpus, bigger data size (e.g., 2K, 4K) might consume
> a lot of memory. For example, the percpu memory consumption
> with unit size 2K and 1024 cpus will be 2K * 1K * 1k = 2GB
> memory.
>
> We should discourage such usage. Let us limit the maximum data
> size to be 512 for bpf_global_percpu_ma allocation.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0c55fe4451e1..e5cb6b7526b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -43,6 +43,8 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>  };
>  
>  struct bpf_mem_alloc bpf_global_percpu_ma;
> +#define LLIST_NODE_SZ sizeof(struct llist_node)
> +#define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  (512 - LLIST_NODE_SZ)

It seems for per-cpu allocation the extra subtraction is not needed, we
could use all allocated space in per-cpu pointer. Maybe we could update
bpf_mem_alloc() firstly to use size instead of size + sizeof(void *) to
select cache.
>  
>  /* bpf_check() is a static code analyzer that walks eBPF program
>   * instruction by instruction and updates register/stack state.
> @@ -12091,6 +12093,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				}
>  
>  				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
> +						verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
> +							ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
> +						return -EINVAL;
> +					}
>  					mutex_lock(&bpf_percpu_ma_lock);
>  					err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
>  					mutex_unlock(&bpf_percpu_ma_lock);


