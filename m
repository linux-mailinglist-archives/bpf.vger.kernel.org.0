Return-Path: <bpf+bounces-17997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F7814A59
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85460282668
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053C430D0B;
	Fri, 15 Dec 2023 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtVlphBe"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611830FAC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2a42641-d9a7-47c4-9993-9a35555ed6bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702650016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZxL8Tk1yD/nTvYGSN/fril/iXJOq1cOKZEKqT/xzMk=;
	b=JtVlphBe+eC/+InCNcZVBbnryYZBWZbMawU0xZ7NiFLxOeyt8IDoPSHSjouxLppzqj+tVP
	Pku9amxlg+CrdmXsFexlvZmQ/iVFWdwLWbLlvjLnUM3V8T01kBy4KnIP8RxExQQzXM1KT6
	DMnaAJNOgPv5SnmUNEF3eeSL6N63Kdc=
Date: Fri, 15 Dec 2023 06:20:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001209.3252729-1-yonghong.song@linux.dev>
 <a8856c91-b8af-2293-3505-7a20d79cc89c@huaweicloud.com>
 <d22fb5f7-9b51-47c4-93d2-69064f2fb550@linux.dev>
 <752bd167-b28a-47f3-90bb-8b3b1ffa2c74@linux.dev>
 <ee755de6-b86c-a80f-271d-4e34ee7d0f94@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ee755de6-b86c-a80f-271d-4e34ee7d0f94@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/14/23 11:40 PM, Hou Tao wrote:
> Hi,
>
> On 12/15/2023 3:27 PM, Yonghong Song wrote:
>> On 12/14/23 10:50 PM, Yonghong Song wrote:
>>> On 12/14/23 7:19 PM, Hou Tao wrote:
>>>> On 12/15/2023 8:12 AM, Yonghong Song wrote:
>>>>> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem
>>>>> allocation")
>>>>> added support for non-fix-size percpu memory allocation.
>>>>> Such allocation will allocate percpu memory for all buckets on all
>>>>> cpus and the memory consumption is in the order to quadratic.
>>>>> For example, let us say, 4 cpus, unit size 16 bytes, so each
>>>>> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256
>>>>> bytes.
>>>>> Then let us say, 8 cpus with the same unit size, each cpu
>>>>> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024
>>>>> bytes.
>>>>> So if the number of cpus doubles, the number of memory consumption
>>>>> will be 4 times. So for a system with large number of cpus, the
>>>>> memory consumption goes up quickly with quadratic order.
>>>>> For example, for 4KB percpu allocation, 128 cpus. The total memory
>>>>> consumption will 4KB * 128 * 128 = 64MB. Things will become
>>>>> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
> SNIP
>>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>>> +    objcg = get_obj_cgroup_from_current();
>>>>> +#endif
>>>>> +    for_each_possible_cpu(cpu) {
>>>>> +        cc = per_cpu_ptr(pcc, cpu);
>>>>> +        c = &cc->cache[i];
>>>>> +        if (cpu == 0 && c->unit_size)
>>>>> +            goto out;
>>>>> +
>>>>> +        c->unit_size = unit_size;
>>>>> +        c->objcg = objcg;
>>>>> +        c->percpu_size = percpu_size;
>>>>> +        c->tgt = c;
>>>>> +
>>>>> +        init_refill_work(c);
>>>>> +        prefill_mem_cache(c, cpu);
>>>>> +
>>>>> +        if (cpu == 0) {
>>>>> +            err = check_obj_size(c, i);
>>>>> +            if (err) {
>>>>> +                bpf_mem_alloc_destroy_cache(c);
>>>> It seems drain_mem_cache() will be enough. Have you considered setting
>>> At prefill stage, looks like the following is enough:
>>>      free_all(__llist_del_all(&c->free_llist), percpu);
>>> But I agree that drain_mem_cache() is simpler and is
>>> easier for future potential code change.
>>>
>>>> low_watermark as 0 to prevent potential refill in unit_alloc() if the
>>>> initialization of the current unit fails ?
>>> I think it does make sense. For non-fix-size non-percpu prefill,
>>> if check_obj_size() failed, the prefill will fail, which include
>>> all buckets.
>>>
>>> In this case, if it fails for a particular bucket, we should
>>> make sure that bucket always return NULL ptr, so setting the
>>> low_watermark to 0 does make sense.
>> Thinking again. If the initialization of the current unit
>> failed, the verification will fail and the corresponding
>> bpf program will not be able to do memory alloc, so we
>> should be fine.
>>
>> But it is totally possible that some prog later may
>> call bpf_mem_alloc_percpu_unit_init() again with the
>> same size/bucket. So we should simply reset bpf_mem_cache
>> to 0 during the previous failed bpf_mem_alloc_percpu_unit_init()
>> call. Is it possible that check_obj_size() may initially
>> returns an error but sometime later something in
>> the kernel changed and the check_obj_size() with the
>> same size could return true?
> Resetting bpf_mem_cache as 0 is much simpler and easier to understand
> than resetting low_watermark as 0. For per-cpu allocation, the return
> value of pcpu_alloc_size() is stable and I don't think it will change
> like ksize() does(), so it is not possible that the previous
> check_obj_size() failed, but the new check_obj_size() for the same
> unit_size succeeds.

Thanks for clarification. Let me just do resetting bpf_mem_cache to 0 then.

>
>>
>>>>> +                goto out;
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +out:
>>>>> +    return err;
>>>>> +}
>>>>> +
>>>>>    static void check_mem_cache(struct bpf_mem_cache *c)
>>>>>    {
>>>>> WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
>>>>>
>>>> .
>>>>

