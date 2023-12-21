Return-Path: <bpf+bounces-18509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A081B07E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C8F1F238AE
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFD171D5;
	Thu, 21 Dec 2023 08:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3251802F
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SwkSm4VnSz4f3kFY
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 16:42:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6CF8A1A0186
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 16:42:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCH4EBn+oNlsFpeEQ--.58510S2;
	Thu, 21 Dec 2023 16:42:19 +0800 (CST)
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231221045954.1969955-1-yonghong.song@linux.dev>
 <20231221050010.1971932-1-yonghong.song@linux.dev>
 <58e11994-6f73-20de-eab8-f4d7a4f71d80@huaweicloud.com>
 <ea395971-25f0-4b5c-8303-1620154e9b9d@linux.dev>
 <2c6e0258-8ecf-4acd-9cb9-8b9ac6222794@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c6d1f8a8-90dc-be35-b7de-d0b60195a293@huaweicloud.com>
Date: Thu, 21 Dec 2023 16:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2c6e0258-8ecf-4acd-9cb9-8b9ac6222794@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCH4EBn+oNlsFpeEQ--.58510S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1rXr1UCF15tryxWFy7Awb_yoWfXFW8pr
	1kJF1UJry5Jrn7Jw1Utr1UJryUtr1UXw1UJr1UJF1UAr47Xr1jqr1UXr1j9r1UJr48JF1U
	Jr1UXr17Zr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/21/2023 3:52 PM, Yonghong Song wrote:
>
> On 12/20/23 11:16 PM, Yonghong Song wrote:
>>
>> On 12/20/23 10:26 PM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 12/21/2023 1:00 PM, Yonghong Song wrote:
>>>> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem
>>>> allocation")
>>>> added support for non-fix-size percpu memory allocation.
>>>> Such allocation will allocate percpu memory for all buckets on all
>>>> cpus and the memory consumption is in the order to quadratic.
>>>> For example, let us say, 4 cpus, unit size 16 bytes, so each
>>>> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256
>>>> bytes.
>>>> Then let us say, 8 cpus with the same unit size, each cpu
>>>> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024
>>>> bytes.
>>>> So if the number of cpus doubles, the number of memory consumption
>>>> will be 4 times. So for a system with large number of cpus, the
>>>> memory consumption goes up quickly with quadratic order.
>>>> For example, for 4KB percpu allocation, 128 cpus. The total memory
>>>> consumption will 4KB * 128 * 128 = 64MB. Things will become
>>>> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
>>>>
>>>> In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
>>>> done in boot time, so for system with large number of cpus, the
>>>> initial
>>>> percpu memory consumption is very visible. For example, for 128 cpu
>>>> system, the total percpu memory allocation will be at least
>>>> (16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
>>>>    * 128 * 128 = ~138MB.
>>>> which is pretty big. It will be even bigger for larger number of cpus.
>>> SNIP
>>>> +
>>>>   static void drain_mem_cache(struct bpf_mem_cache *c)
>>>>   {
>>>>       bool percpu = !!c->percpu_size;
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index f13008d27f35..08f9a49cc11c 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -12141,20 +12141,6 @@ static int check_kfunc_call(struct
>>>> bpf_verifier_env *env, struct bpf_insn *insn,
>>>>                   if (meta.func_id ==
>>>> special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>>>>                       return -ENOMEM;
>>>>   -                if (meta.func_id ==
>>>> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>>>> -                    if (!bpf_global_percpu_ma_set) {
>>>> -                        mutex_lock(&bpf_percpu_ma_lock);
>>>> -                        if (!bpf_global_percpu_ma_set) {
>>>> -                            err =
>>>> bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>>>> -                            if (!err)
>>>> -                                bpf_global_percpu_ma_set = true;
>>>> -                        }
>>>> - mutex_unlock(&bpf_percpu_ma_lock);
>>>> -                        if (err)
>>>> -                            return err;
>>>> -                    }
>>>> -                }
>>>> -
>>>>                   if (((u64)(u32)meta.arg_constant.value) !=
>>>> meta.arg_constant.value) {
>>>>                       verbose(env, "local type ID argument must be
>>>> in range [0, U32_MAX]\n");
>>>>                       return -EINVAL;
>>>> @@ -12175,6 +12161,26 @@ static int check_kfunc_call(struct
>>>> bpf_verifier_env *env, struct bpf_insn *insn,
>>>>                       return -EINVAL;
>>>>                   }
>>>>   +                if (meta.func_id ==
>>>> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>>>> +                    if (!bpf_global_percpu_ma_set) {
>>>> +                        mutex_lock(&bpf_percpu_ma_lock);
>>>> +                        if (!bpf_global_percpu_ma_set) {
>>>> +                            err =
>>>> bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
>>> Because ma->objcg is assigned as get_obj_cgroup_from_current(), so I
>>> think the memory account will be incorrect, right ? Maybe we should
>>> pass
>>> objcg to bpf_mem_alloc_percpu_init() explicit. For root memcg, I think
>>> the objcg is NULL.
>>
>> You are correct. Calling bpf_mem_alloc_percpu_init() in init stage
>> is exactly the reason to have proper root memcg for objcg. Sorry I
>> missed it.
>>
>> I remembered I indeed traced it a few days ago and indeed it is NULL.
>> There are three ways to resolve this:
>>    1 Just do 'ma->objcg = NULL' unconditionally in
>> bpf_mem_alloc_percpu_init().
>>    2 Second, we can remember objcg = bpf_mem_alloc_percpu_init() at
>> init stage,
>>      e.g., in bpf_global_ma_init() init function (core.c), and later
>> it can
>>      be used in bpf_mem_alloc_percpu_init().
>>    3 Still do bpf_mem_alloc_percpu_init() at init stage to initialize
>> ma->objcg
>>      properly. But delay __alloc_percpu_gfp() later when verifier
>> found a call
>>      to bpf_percpu_obj_new(). We could add a call
>> bpf_mem_alloc_percpu_init_caches()
>>      to do __alloc_percpu_grp().
>>
>> I prefer option 3, what do you think?
>
> The option 4 below:
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 984c83ecace9..f90989cc9cbc 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -122,6 +122,7 @@ struct bpf_mem_caches {
>  };
>  
>  static const u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256,
> 512, 1024, 2048, 4096};
> +static struct obj_cgroup *objcg_at_init __ro_after_init;
>  
>  static struct llist_node notrace *__llist_del_first(struct llist_head
> *head)
>  {
> @@ -590,7 +591,7 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc
> *ma)
>         ma->percpu = true;
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -       ma->objcg = get_obj_cgroup_from_current();
> +       ma->objcg = objcg_at_init;
>  #else
>         ma->objcg = NULL;
>  #endif
> @@ -1015,3 +1016,10 @@ void notrace *bpf_mem_cache_alloc_flags(struct
> bpf_mem_alloc *ma, gfp_t flags)
>  
>         return !ret ? NULL : ret + LLIST_NODE_SZ;
>  }
> +
> +static int __init find_objcg_at_init(void)
> +{
> +       objcg_at_init = get_obj_cgroup_from_current();
> +       return 0;
> +}
> +late_initcall(find_objcg_at_init);
>
> It seems this is better?

It seems that you are worried about the objcg of root memcg may change
from NULL to something else one day, right ? If it is the case, I think
both option 3 and 4 are fine. But I still think passing the desired
objcg to bpf_mem_alloc_percpu_init() directly is better. If the objcg of
root memcg is not NULL afterwards, we can update the passed parameter
accordingly.
>
>>
>>>> +                            if (!err)
>>>> +                                bpf_global_percpu_ma_set = true;
>>>> +                        }
>>>> + mutex_unlock(&bpf_percpu_ma_lock);
>>>> +                        if (err)
>>>> +                            return err;
>>>> +                    }
>>>> +
>>>> +                    mutex_lock(&bpf_percpu_ma_lock);
>>>> +                    err =
>>>> bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
>>>> +                    mutex_unlock(&bpf_percpu_ma_lock);
>>>> +                    if (err)
>>>> +                        return err;
>>>> +                }
>>>> +
>>>>                   struct_meta = btf_find_struct_meta(ret_btf,
>>>> ret_btf_id);
>>>>                   if (meta.func_id ==
>>>> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>>>>                       if (!__btf_type_is_scalar_struct(env,
>>>> ret_btf, ret_t, 0)) {
>>>
>>


