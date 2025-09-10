Return-Path: <bpf+bounces-68016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075CB51882
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E283B1A1E
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1292320A3B;
	Wed, 10 Sep 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dhFFIoIi"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6A320A36
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512674; cv=none; b=EL5GqO6rtw5Ng8m/xpC2L/EVCQqFEsNc6+4ZKwmiwCeoLgnIMWAtbSZnVkkHtWiOVZYn7FJZJpr7k50pgerPtFX95Ux2tszjGfLRPid+oIgtYEmNxYSFB8RlOjjClM54s70QdqQiaj0W69scXuOUA1ZVBcT6hVtEb6aL2LHj2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512674; c=relaxed/simple;
	bh=yVe9U9geFB5iyxU7D0dM8xT+Qqgu7g+qNAf6Aw8yL2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyB4auqa7gZ8odQlOIOVoA4knh7vde3+dUiJvhKm0sy95uK1kvsMzdWl0Iukqw+RTfrEfzLNqa74H0B43slZtXmsI1nrYSmfOBmr29G+LQhG8UMz6kkTpYKkfSYo1Fs7wpqHKFyYPEzwQ1G0bFXqXMnxEmCH1mVjAJVtJgJD7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dhFFIoIi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757512660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QC748CIWajxw/7iZYNCHx4/C+cp4Fd9J30JGsoguRxU=;
	b=dhFFIoIie+p/VEsPvypd9s5MRxg2Lb9DUmuYfQ3f2LNIuyyMPc8At2WhkWe6StPF30dk7u
	v6OjCUU+DwT0iZzkJbWGizycjetKlqt3SBsVAYC9YuPs1MoLzK+mAcKvJLbNN5dVynBoGm
	FRxJrDXHxeuBtNJXB9r2Fr/5sBnC5cM=
Date: Wed, 10 Sep 2025 21:56:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com,
 shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
 <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/10 20:54, Lance Yang wrote:
> On Wed, Sep 10, 2025 at 8:42 PM Lance Yang <lance.yang@linux.dev> wrote:
>>
>> Hey Yafang,
>>
>> On Wed, Sep 10, 2025 at 10:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
>>> THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
>>> programs to influence THP order selection based on factors such as:
>>> - Workload identity
>>>    For example, workloads running in specific containers or cgroups.
>>> - Allocation context
>>>    Whether the allocation occurs during a page fault, khugepaged, swap or
>>>    other paths.
>>> - VMA's memory advice settings
>>>    MADV_HUGEPAGE or MADV_NOHUGEPAGE
>>> - Memory pressure
>>>    PSI system data or associated cgroup PSI metrics
>>>
>>> The kernel API of this new BPF hook is as follows,
>>>
>>> /**
>>>   * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
>>>   * @vma: vm_area_struct associated with the THP allocation
>>>   * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
>>>   *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
>>>   *            neither is set.
>>>   * @tva_type: TVA type for current @vma
>>>   * @orders: Bitmask of requested THP orders for this allocation
>>>   *          - PMD-mapped allocation if PMD_ORDER is set
>>>   *          - mTHP allocation otherwise
>>>   *
>>>   * Return: The suggested THP order from the BPF program for allocation. It will
>>>   *         not exceed the highest requested order in @orders. Return -1 to
>>>   *         indicate that the original requested @orders should remain unchanged.
>>>   */
>>> typedef int thp_order_fn_t(struct vm_area_struct *vma,
>>>                             enum bpf_thp_vma_type vma_type,
>>>                             enum tva_type tva_type,
>>>                             unsigned long orders);
>>>
>>> Only a single BPF program can be attached at any given time, though it can
>>> be dynamically updated to adjust the policy. The implementation supports
>>> anonymous THP, shmem THP, and mTHP, with future extensions planned for
>>> file-backed THP.
>>>
>>> This functionality is only active when system-wide THP is configured to
>>> madvise or always mode. It remains disabled in never mode. Additionally,
>>> if THP is explicitly disabled for a specific task via prctl(), this BPF
>>> functionality will also be unavailable for that task.
>>>
>>> This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
>>> enabled. Note that this capability is currently unstable and may undergo
>>> significant changes—including potential removal—in future kernel versions.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>> [...]
>>> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
>>> new file mode 100644
>>> index 000000000000..525ee22ab598
>>> --- /dev/null
>>> +++ b/mm/huge_memory_bpf.c
>>> @@ -0,0 +1,243 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * BPF-based THP policy management
>>> + *
>>> + * Author: Yafang Shao <laoar.shao@gmail.com>
>>> + */
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/huge_mm.h>
>>> +#include <linux/khugepaged.h>
>>> +
>>> +enum bpf_thp_vma_type {
>>> +       BPF_THP_VM_NONE = 0,
>>> +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
>>> +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
>>> +};
>>> +
>>> +/**
>>> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
>>> + * @vma: vm_area_struct associated with the THP allocation
>>> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
>>> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
>>> + *            neither is set.
>>> + * @tva_type: TVA type for current @vma
>>> + * @orders: Bitmask of requested THP orders for this allocation
>>> + *          - PMD-mapped allocation if PMD_ORDER is set
>>> + *          - mTHP allocation otherwise
>>> + *
>>> + * Return: The suggested THP order from the BPF program for allocation. It will
>>> + *         not exceed the highest requested order in @orders. Return -1 to
>>> + *         indicate that the original requested @orders should remain unchanged.
>>
>> A minor documentation nit: the comment says "Return -1 to indicate that the
>> original requested @orders should remain unchanged". It might be slightly
>> clearer to say "Return a negative value to fall back to the original
>> behavior". This would cover all error codes as well ;)
>>
>>> + */
>>> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
>>> +                          enum bpf_thp_vma_type vma_type,
>>> +                          enum tva_type tva_type,
>>> +                          unsigned long orders);
>>
>> Sorry if I'm missing some context here since I haven't tracked the whole
>> series closely.
>>
>> Regarding the return value for thp_order_fn_t: right now it returns a
>> single int order. I was thinking, what if we let it return an unsigned
>> long bitmask of orders instead? This seems like it would be more flexible
>> down the road, especially if we get more mTHP sizes to choose from. It
>> would also make the API more consistent, as bpf_hook_thp_get_orders()
>> itself returns an unsigned long ;)
> 
> I just realized a flaw in my previous suggestion :(
> 
> Changing the return type of thp_order_fn_t to unsigned long for consistency
> and flexibility. However, I completely overlooked that this would prevent
> the BPF program from returning negative error codes ...
> 
> Thanks,
> Lance
> 
>>
>> Also, for future extensions, it might be a good idea to add a reserved
>> flags argument to the thp_order_fn_t signature.
>>
>> For example thp_order_fn_t(..., unsigned long flags).
>>
>> This would give us aforward-compatible way to add new semantics later
>> without breaking the ABI and needing a v2. We could just require it to be
>> 0 for now.
>>
>> Thanks for the great work!
>> Lance


Forgot to add:

Noticed that if the hook returns 0, bpf_hook_thp_get_orders() falls
back to 'orders', preventing us from dynamically disabling mTHP
allocations.

Honoring a return of 0 is critical for our use case, which is to
dynamically disable mTHP for low-priority containers when memory gets
low in mixed workloads.

And then re-enable it for them when memory is back above the low
watermark.

