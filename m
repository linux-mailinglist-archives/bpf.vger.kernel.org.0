Return-Path: <bpf+bounces-68139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E8B53602
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91972162463
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA68340DA6;
	Thu, 11 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tmr60pWJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A033769B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601762; cv=none; b=DdkfUnhbM9HHeiIGQcn0NqZ0CPAxFlZrOWnQ+sVHzWNfBLvpjuJPDQDuAlJD2L33QxuKblW/HDTIJEKxjP6ByBBnxpYeNPFREQLsvemZvpAUoLvuh/RwYrrLomXLqfHlXbV10fPy0MBdrq5ysgotb09XoxLF71j3z9PeDH+fRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601762; c=relaxed/simple;
	bh=eDAE+/Djn8JQtGN9dgiMdtY2cMGPSn6XW3W3XtGgDFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PylkakMD3Q0vOPOwp9J3pGxL2JnCO4yKr0x3A4fLETY668ZBuqIEfFL17efvXme2p8kPZ17ep2lHw+P84GatQ8ZFlgfMM9Zya6/xM84YIiYKApoartnYCWOepzMybRzLNyskzIqQa7Fq7MEzTnXkjhVVnjjyIRrEE0L9giQfRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tmr60pWJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a2a4b59-9368-4185-bd08-74324eebacb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757601757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyNQL/XADmMA8QjSJmXvDYxgTnM2j84ik6oc2UrSO24=;
	b=Tmr60pWJwACqzef1HJGGtGnSoV1/nJPnoK6NuDuZ6dCbpQYtgSh91GFlUn0zC1OB4sldeo
	pgYh606ZBE+ZDGVeZXsgjwUwrWNRvKmvfyMSPPPcC+3R9v9R8y+GWCDCzaXviM5Xfm05BR
	w4sa5d1NNASzGvGoWrlBd34pxB2ZKag=
Date: Thu, 11 Sep 2025 22:42:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
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
 <3b1c6388-812f-4702-bd71-33a6373a381a@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <3b1c6388-812f-4702-bd71-33a6373a381a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/11 22:02, Lorenzo Stoakes wrote:
> On Wed, Sep 10, 2025 at 08:42:37PM +0800, Lance Yang wrote:
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
> I think that adds confusion - as in how an order might be chosen from
> those. Also we have _received_ a bitmap of available orders - and the intent
> here is to select _which one we should use_.

Yep. Makes sense to me ;)

> 
> And this is an experimental feature, behind a flag explicitly labelled as
> experimental (and thus subject to change) so if we found we needed to change
> things in the future we can.

You're right, I didn't pay enough attention to the fact that this is
an experimental feature. So my suggestions were based on a lack of
context ...

> 
>>
>> Also, for future extensions, it might be a good idea to add a reserved
>> flags argument to the thp_order_fn_t signature.
> 
> We don't need to do anything like this, as we are behind an experimental flag
> and in no way guarantee that this will be used this way going forwards.
>>
>> For example thp_order_fn_t(..., unsigned long flags).
>>
>> This would give us aforward-compatible way to add new semantics later
>> without breaking the ABI and needing a v2. We could just require it to be
>> 0 for now.
> 
> There is no ABI.
> 
> I mean again to emphasise, this is an _experimental_ feature not to be relied
> upon in production.
> 
>>
>> Thanks for the great work!
>> Lance
> 
> Perhaps we need to put a 'EXPERIMENTAL_' prefix on the config flag too to really
> bring this home, as it's perhaps not all that clear :)

No need for a 'EXPERIMENTAL_' prefix, it was just me missing
the background. Appreciate you clarifying this!

Cheers,
Lance


