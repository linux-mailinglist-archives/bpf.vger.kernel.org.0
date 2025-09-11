Return-Path: <bpf+bounces-68081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA5B526D6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 05:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D971BC410C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9792921019C;
	Thu, 11 Sep 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mq1KZfJy"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602B19C54B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559920; cv=none; b=FVYGwB0yuYChDArSUkyB9sYEKOuIwQHy89CoXGk/2L09ga4x35My+IIZAEiwEI/edXqPUo6XAu+gXmQ7FSjb726UE0UchR5y516ij87RP9iI8cSzPZ7raqn+Nz1/fRgfUrtrHt2dRccmA+ESQ7ICuSYOsEWd6Nqv58H7KzXmQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559920; c=relaxed/simple;
	bh=HMnumFLvNGXbXkmzpFc98aXEhY6M+nuGVu7h1AVxYjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yey1tzjv4QHu03zlBFJh6sRGNJxoO+gNGWOSZJeVEu4WhGoMwsfzW9K2Pg06GcLc9AcV5slahvLWYHKGFT1hSLhjIClzY5Uohvkss36rMUiiYGSNgTephZHS0KwUD/OSDh9YpHmiVxgJldnrMuB/vSlcHGiTMMSkQ6zA+Ou6ki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mq1KZfJy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1b2fe3d-e8d4-47a7-b369-ee826fec0e7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757559913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T9VUgZB4FkXCXqmZCRFSIgZN/NB+DPn0gz88Z9lruY=;
	b=mq1KZfJySR1GsrdLS/vyU1/YzvGVT859oA5mxcagNE4baLrGHdnZHnTOwg/0IGaV075piA
	RATnyx24do8iwRkHvAEVXabMu0YLLSWSz2uR6KaKXiP+rxVO8WxCS8kFcxHvsdzsaWlaCD
	1vz/9+SZQcqDilMFaMIE2QeNQD6fpLM=
Date: Thu, 11 Sep 2025 11:04:58 +0800
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
 <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
 <CALOAHbAfzDNdx5LTUhH+eMgVfdG35gAM5subeByP97x53=CWLw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CALOAHbAfzDNdx5LTUhH+eMgVfdG35gAM5subeByP97x53=CWLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/11 10:48, Yafang Shao wrote:
> On Wed, Sep 10, 2025 at 9:57 PM Lance Yang <lance.yang@linux.dev> wrote:
[...]
>>>>> +/**
>>>>> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
>>>>> + * @vma: vm_area_struct associated with the THP allocation
>>>>> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
>>>>> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
>>>>> + *            neither is set.
>>>>> + * @tva_type: TVA type for current @vma
>>>>> + * @orders: Bitmask of requested THP orders for this allocation
>>>>> + *          - PMD-mapped allocation if PMD_ORDER is set
>>>>> + *          - mTHP allocation otherwise
>>>>> + *
>>>>> + * Return: The suggested THP order from the BPF program for allocation. It will
>>>>> + *         not exceed the highest requested order in @orders. Return -1 to
>>>>> + *         indicate that the original requested @orders should remain unchanged.
>>>>
>>>> A minor documentation nit: the comment says "Return -1 to indicate that the
>>>> original requested @orders should remain unchanged". It might be slightly
>>>> clearer to say "Return a negative value to fall back to the original
>>>> behavior". This would cover all error codes as well ;)
> 
> will change it.

Please feel free to change it ;)

> 
>>>>
[...]
>>>>
>>>> Also, for future extensions, it might be a good idea to add a reserved
>>>> flags argument to the thp_order_fn_t signature.
>>>>
>>>> For example thp_order_fn_t(..., unsigned long flags).
>>>>
>>>> This would give us aforward-compatible way to add new semantics later
>>>> without breaking the ABI and needing a v2. We could just require it to be
>>>> 0 for now.
> 
> That makes sense. However, as Lorenzo mentioned previously, we should
> keep the interface as minimal as possible.

Got it.

[...]
>> Forgot to add:
>>
>> Noticed that if the hook returns 0, bpf_hook_thp_get_orders() falls
>> back to 'orders', preventing us from dynamically disabling mTHP
>> allocations.
> 
> Could you please clarify what you mean by that?
> 
> +       thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
> +       if (thp_order < 0)
> +               goto out;
> 
> In my implementation, it only falls back to @orders if the return
> value is negative. If the return value is 0, it uses BIT(0):

My bad, I completely misread the code last night ...

I see now that returning 0 forces a base page (order-0)

> 
> +       if (thp_order <= highest_order(orders))
> +               thp_orders = BIT(thp_order);

Yes, this is exactly the behavior we need. It will allow us to dynamically
disable mTHP for low-priority containers when we need to, which is perfect
for our use case!

> 
>>
>> Honoring a return of 0 is critical for our use case, which is to
>> dynamically disable mTHP for low-priority containers when memory gets
>> low in mixed workloads.
>>
>> And then re-enable it for them when memory is back above the low
>> watermark.
> 
> Thank you for detailing your use case; that context is very helpful.

Cheers,
Lance

