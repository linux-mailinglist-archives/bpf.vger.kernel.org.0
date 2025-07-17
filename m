Return-Path: <bpf+bounces-63578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5171B08878
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 10:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB583BA51F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE52853E3;
	Thu, 17 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxaOg8tM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54574283C82
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742341; cv=none; b=IjXw7oh/iNmLWUcvXnVhQudO/CFFCjWxe6S4NBe2wZfH4fsGfJP2Lrm5IE1mN/2tWBtu0H1ZQx769MWpSoIstsQIH6R5CTOK3T5+JFSgYdKCi65sb0FSdOyVc7n4tBSe06yA+EtW8aY5xFHh8E8I2Tv4PnJn9JUaO1EcKW/mxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742341; c=relaxed/simple;
	bh=KkswHqk9jjkMaN9OOEsS84E8u/1x4csIDpZUWX/l7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nue6LpwGnyOS6B+s1auzHT2I5dcohyd0NUyf17oDR83EozIH4b+l29ezVh85JACv7FPX4/F10HPigmgD2E2U9K/qgW4WR8tEiC/iAS/B/1A3RWwgvRDO3+rSgUib0a8Z1nWAXXejtdMsHRA732Gfy9ZaL62ecqqzFCjrdaXsugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxaOg8tM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752742337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f0/2xy7vv3lUPkCKcWlEZdvdOOc1dFZHCFBVBsNJG+I=;
	b=GxaOg8tMMy6oq46VNLsMQZ62+CsGxiycnZghtV5DXkFtTunHQCvkGpB+IXVNksG5uz5fsx
	O9c0B6p+Rcu0igiAV/rmqkMWmdKkBn1/KGzVHL2BAGSJPTOH68yUJRjP7CicXQd6ilyIBZ
	cQy/FhMJiejDadNKSM/BGINKb6yj7pQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-VQHeN0G0PvOaFJB_qz5yxg-1; Thu, 17 Jul 2025 04:52:15 -0400
X-MC-Unique: VQHeN0G0PvOaFJB_qz5yxg-1
X-Mimecast-MFC-AGG-ID: VQHeN0G0PvOaFJB_qz5yxg_1752742334
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so443702f8f.2
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 01:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752742334; x=1753347134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0/2xy7vv3lUPkCKcWlEZdvdOOc1dFZHCFBVBsNJG+I=;
        b=j6x/5a3pXxesnPutvysRZN/WesROR/QW8GgTnspN44AAazLK6/LGHJ0psNAPSyImfy
         JOpFnRVMKRTXYI2ljzWbYLEIwkyTJAjSZcnQ0yxo7UchtKKNHu1sZHj5BasDophWTSLP
         SJmXYTP6P16nBb4jjn8YY3ufpRT6mlgl5LRedIcmdzI53dLRlc/L0iPDitVwmVKXcOrg
         f80nnqqeo1ylbg//BsfQ10V0u5sJMmgKNibnVC6DR/b426SNnXAVJNF375X9/jJqgl+4
         ISNw59wORWjmM/ZVPP+Nb2N6wBe8UXClgfspmPbzYBEp81w0F20br1HPMRpCtu+lbuie
         Ly5g==
X-Forwarded-Encrypted: i=1; AJvYcCW1AU6oIaUtHyRmiHlzXGTdCH98W9r//F6Wugn5yu0zjcWUmlsPw+9vjnwbP9mbbhVzvHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywT6djoDLTT0REAiuswIo99uWLl2RkQWK3RM0pN9/BqSfQwKiY
	UCmUU4+sloRxdbw5vKlFTfNOr4uZrfn5FQCsvq6OxMd072oqNu6WrnkOw5gXghFmD3nHa6v5V2k
	cNNKgyhzNxmcvyWIO901uGZ2C9d85QBZbsSzBYcCuByNWHJiY1vaXAg==
X-Gm-Gg: ASbGncsiYBx/r06PVX0mj3HuIQzrchCFyhb6Dxy+lwZamNvhD+YyUAAipbzxlNPDBem
	XAXmJ1UrM0YuZJWQJDrdLvOp/frhXRt+MCeCZXkypwuII2VFT5jZR2a+BkOEXZVccc5xLo5wqqz
	kn0Bscnc29Gc5BQHLmAQbnrb5BqAgqfKh4kgw+GBALhImrgxQJGyKELSQpKYUZbEEWaaid4K0ao
	a3Dmg8J7Fc7HpTRLhKY8iep+Gi6CZEqCx+zU/2UoP2+/oZVedqZnpaP4yky3XKlkDfvB6eu2xE7
	6f6M7CxATTeKp2vW+/dOc5VWf2HdysgnSStS+KkL4LxT+5my2vNn6RJWvtE+6PQ9pil+utN/iLU
	bxrHbA3FCYrDslAJrbnY56UO7EapxXqJCSRjre4Hm3oNqhYNi7dSTXw9ZLIrIq6rw
X-Received: by 2002:a5d:584d:0:b0:3b3:9c85:6b17 with SMTP id ffacd0b85a97d-3b60e4f2bf4mr4155413f8f.34.1752742334307;
        Thu, 17 Jul 2025 01:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkkzBW3YSl1lHB7iAKBbzRxlBHDxQxqY5m1/VmqOSNtiKiVbHmjCOplubn6zmDVDgAzE8zIA==
X-Received: by 2002:a5d:584d:0:b0:3b3:9c85:6b17 with SMTP id ffacd0b85a97d-3b60e4f2bf4mr4155361f8f.34.1752742333742;
        Thu, 17 Jul 2025 01:52:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d77asm20534293f8f.58.2025.07.17.01.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:52:13 -0700 (PDT)
Message-ID: <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
Date: Thu, 17 Jul 2025 10:52:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.07.25 05:09, Yafang Shao wrote:
> On Wed, Jul 16, 2025 at 6:42 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.06.25 09:35, Yafang Shao wrote:
>>
>> Sorry for not replying earlier, I was caught up with all other stuff.
>>
>> I still consider this a very interesting approach, although I think we
>> should think more about what a reasonable policy would look like
>> medoium-term (in particular, multiple THP sizes, not always falling back
>> to small pages if it means splitting excessively in the buddy etc.)
> 
> I find it difficult to understand why we introduced the mTHP sysfs
> knobs instead of implementing automatic THP size switching within the
> kernel. I'm skeptical about its practical utility in real-world
> workloads.
> 
> In contrast, XFS large folio (AKA. File THP) can automatically select
> orders between 0 and 9. Based on our verification, this feature has
> proven genuinely useful for certain specific workloads—though it's not
> yet perfect.

I suggest you do some digging about the history of these toggles and the 
plans for the future (automatic), there has been plenty of talk about 
all that.

[...]

>>>
>>> - THP allocator
>>>
>>>     int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
>>>
>>>     The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
>>>     indicating whether THP allocation should be performed synchronously
>>>     (current task) or asynchronously (khugepaged).
>>>
>>>     The decision is based on the current task context, VMA flags, and TVA
>>>     flags.
>>
>> I think we should go one step further and actually get advises about the
>> orders (THP sizes) to use. It might be helpful if the program would have
>> access to system stats, to make an educated decision.
>>
>> Given page fault information and system information, the program could
>> then decide which orders to try to allocate.
> 
> Yes, that aligns with my thoughts as well. For instance, we could
> automate the decision-making process based on factors like PSI, memory
> fragmentation, and other metrics. However, this logic could be
> implemented within BPF programs—all we’d need is to extend the feature
> by introducing a few kfuncs (also known as BPF helpers).

We discussed this yesterday at a THP upstream meeting, and what we 
should look into is:

(1) Having a callback like

unsigned int (*get_suggested_order)(.., bool in_pagefault);

Where we can provide some information about the fault (vma 
size/flags/anon_name), and whether we are in the page fault (or in 
khugepaged).

Maybe we want a bitmap of orders to try (fallback), not sure yet.

(2) Having some way to tag these callbacks as "this is absolutely 
unstable for now and can be changed as we please.".

One idea will be to use this mechanism as a way to easily prototype 
policies, and once we know that a policy works, start moving it into the 
core.

In general, the core, without a BPF program, should be able to continue 
providing a sane default behavior.

> 
>>
>> That means, one would query during page faults and during khugepaged,
>> which order one should try -- compared to our current approach of "start
>> with the largest order that is enabled and fits".
>>
>>>
>>> - THP reclaimer
>>>
>>>     int (*reclaimer)(bool vma_madvised);
>>>
>>>     The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
>>>     determining whether memory reclamation is handled by the current task or
>>>     kswapd.
>>
>> Not sure about that, will have to look into the details.
> 
> Some workloads allocate all their memory during initialization and do
> not require THP at runtime. For such cases, aggressively attempting
> THP allocation is beneficial. However, other workloads may dynamically
> allocate THP during execution—if these are latency-sensitive, we must
> avoid introducing long allocation delays.
> 
> Given these differing requirements, the global
> /sys/kernel/mm/transparent_hugepage/defrag setting is insufficient.
> Instead, we should implement per-workload defrag policies to better
> optimize performance based on individual application behavior.

We'll be very careful about the callbacks we will offer. Maybe the 
get_suggested_order() callback could itself make a decision and not 
suggest a high order if allocation would require comapction.

Initially, we should keep it simple and see what other callbacks to add 
/ how to extend get_suggested_order(), to cover these cases.

-- 
Cheers,

David / dhildenb


