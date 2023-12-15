Return-Path: <bpf+bounces-17968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A808142AB
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C57B22CA2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7441094D;
	Fri, 15 Dec 2023 07:40:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE590134A2
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ss1NT6tK9z4f3kFJ
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:40:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 88D541A0BE9
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:40:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3EkP4Anxl6e81Dw--.48586S2;
	Fri, 15 Dec 2023 15:40:44 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001209.3252729-1-yonghong.song@linux.dev>
 <a8856c91-b8af-2293-3505-7a20d79cc89c@huaweicloud.com>
 <d22fb5f7-9b51-47c4-93d2-69064f2fb550@linux.dev>
 <752bd167-b28a-47f3-90bb-8b3b1ffa2c74@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ee755de6-b86c-a80f-271d-4e34ee7d0f94@huaweicloud.com>
Date: Fri, 15 Dec 2023 15:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <752bd167-b28a-47f3-90bb-8b3b1ffa2c74@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3EkP4Anxl6e81Dw--.48586S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry3Wr45tryrZryUKFy8Xwb_yoWrAr18pr
	yIgayUt3s5Arn3Jw1jgw18JF9ayw18J3WDXry8uF1jkrsxXr12gr1jqrn09FyDArs7Ga15
	XFWDXr17Zr15ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 12/15/2023 3:27 PM, Yonghong Song wrote:
>
> On 12/14/23 10:50 PM, Yonghong Song wrote:
>>
>> On 12/14/23 7:19 PM, Hou Tao wrote:
>>>
>>> On 12/15/2023 8:12 AM, Yonghong Song wrote:
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

SNIP
>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>> +    objcg = get_obj_cgroup_from_current();
>>>> +#endif
>>>> +    for_each_possible_cpu(cpu) {
>>>> +        cc = per_cpu_ptr(pcc, cpu);
>>>> +        c = &cc->cache[i];
>>>> +        if (cpu == 0 && c->unit_size)
>>>> +            goto out;
>>>> +
>>>> +        c->unit_size = unit_size;
>>>> +        c->objcg = objcg;
>>>> +        c->percpu_size = percpu_size;
>>>> +        c->tgt = c;
>>>> +
>>>> +        init_refill_work(c);
>>>> +        prefill_mem_cache(c, cpu);
>>>> +
>>>> +        if (cpu == 0) {
>>>> +            err = check_obj_size(c, i);
>>>> +            if (err) {
>>>> +                bpf_mem_alloc_destroy_cache(c);
>>> It seems drain_mem_cache() will be enough. Have you considered setting
>>
>> At prefill stage, looks like the following is enough:
>>     free_all(__llist_del_all(&c->free_llist), percpu);
>> But I agree that drain_mem_cache() is simpler and is
>> easier for future potential code change.
>>
>>> low_watermark as 0 to prevent potential refill in unit_alloc() if the
>>> initialization of the current unit fails ?
>>
>> I think it does make sense. For non-fix-size non-percpu prefill,
>> if check_obj_size() failed, the prefill will fail, which include
>> all buckets.
>>
>> In this case, if it fails for a particular bucket, we should
>> make sure that bucket always return NULL ptr, so setting the
>> low_watermark to 0 does make sense.
>
> Thinking again. If the initialization of the current unit
> failed, the verification will fail and the corresponding
> bpf program will not be able to do memory alloc, so we
> should be fine.
>
> But it is totally possible that some prog later may
> call bpf_mem_alloc_percpu_unit_init() again with the
> same size/bucket. So we should simply reset bpf_mem_cache
> to 0 during the previous failed bpf_mem_alloc_percpu_unit_init()
> call. Is it possible that check_obj_size() may initially
> returns an error but sometime later something in
> the kernel changed and the check_obj_size() with the
> same size could return true?

Resetting bpf_mem_cache as 0 is much simpler and easier to understand
than resetting low_watermark as 0. For per-cpu allocation, the return
value of pcpu_alloc_size() is stable and I don't think it will change
like ksize() does(), so it is not possible that the previous
check_obj_size() failed, but the new check_obj_size() for the same
unit_size succeeds.

>
>
>>
>>>> +                goto out;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +out:
>>>> +    return err;
>>>> +}
>>>> +
>>>>   static void check_mem_cache(struct bpf_mem_cache *c)
>>>>   {
>>>> WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
>>>>
>>> .
>>>
>>


