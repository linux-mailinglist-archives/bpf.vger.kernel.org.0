Return-Path: <bpf+bounces-59143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64481AC652E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE464E04D6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97422749CE;
	Wed, 28 May 2025 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjfKKxw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E951E0DBA;
	Wed, 28 May 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423206; cv=none; b=m2nBtv2qgfNKdVYSlLb669WmB1iHfreaIMhLgEL0NeuEMqWA1Q74PBl7KsbeCMNJKe0Foegf1zipZ51z07fokIdxAWWbpkPuDyYxz0k+4d6mxoz03qVxVOCpltzQ0jfcmKpR54JD+ViDG00VO3XX/qtXKajLXYtWXFxaygb6WE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423206; c=relaxed/simple;
	bh=kOXKXYBm0pp28YtkaxvHzV7xrXjXU6/FZ4rd0x7+0rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3oz28GbLOALIrUFJQa5UqzJWCA5Y7aSTZ7dAnFzIlEBvBWgstv64QrjPy7kH8VaXM9e8JZqwUL1JAOQmhD4LrtNGNGmTDlQQuw4QspeYrMI4HmzureJYEcujc/EyVDZOSPRty0E0ZPcWywGpy1rWJrkrDITRZaqvd2ogjMIdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjfKKxw9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acbb85ce788so853256266b.3;
        Wed, 28 May 2025 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748423203; x=1749028003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrHG2O5BYtb3YtvsVKxTKKGZHaxoCb1RYr5BGkq1In0=;
        b=SjfKKxw9aCyq2O2rJnC6/sLZWWY8XvldqAMTqL4ZZbPAM5R7TL+r7EHZd6VaTlOrJW
         6GdZE29EyU/F9o+BcPSc7yGssAT3ZDRDoLFbkYzUUWz8+LOGyxZQHXn38xuUmib/S1bX
         DmmOWdnie25fHO2OEePCFboyCtdyYu0f4w3CwpIcAn93ef2g3Q9OZVUxar+2kxNjcVAK
         IJfn/vxg1lXyw38uWkQ4m91nnafvFbzvzEvtF06eWlQy3/BIq6f+RipnaIU0JRg1HVK2
         gVpMo/l3OcS65RUWwJiZxyfli/NE7/NV0nLJbcAhK41K7tHbsSs47CLqcc+MzBkDJU6F
         fErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423203; x=1749028003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrHG2O5BYtb3YtvsVKxTKKGZHaxoCb1RYr5BGkq1In0=;
        b=wn6OKhll23QO2/doG7sgkaTK9GLxd8rYf1cqrl5mJNV+lcTM8q2rKoly5gDkIpcrBh
         84MPEQ2yZstIVSCOkrLGvJPqxRBNRJXUHHMG7ucroAG2GQJnQGKOlvxR86P+Yhcnv8hC
         u6eEb9JUwbhPOo6jVrwrWNqZjSrBcDniqUHz0I6NlCaSM+R+UJjTKzX6ibowXZcBHaey
         OP1He5XcfNxKVabO7Crrz6fRaDmZKRiOItg5JWoJG8VqwF8RFHwrZbDGUfO3kkyO+61c
         MJVef9jGvrbJzW3bfxz3RTmFvAJkTBWocVHThvCdXV+dG9i55pdH2FOWrsQTXolCSjYH
         VUwA==
X-Forwarded-Encrypted: i=1; AJvYcCUjgybyGTmuT2kcUk/kSZcY9VZ3CMmkteSrSoVh81GRI4IB2wm6JX7hBf1qhPshq5W40MY=@vger.kernel.org, AJvYcCUjjhys2INpyqGSI7y1S7dDPRGxMGveQ1J0pOPagcLiYvbebfvNpuLYl4/CQefiMXlk+ThZJouM@vger.kernel.org, AJvYcCVfzUWy4JElFcgdaSOHhke4LBJJjI3jLWw4KhariPlP09P1IqhOdv+g3q+rKCiu8DyHHSejcQILpru+1oMC@vger.kernel.org, AJvYcCX49d5U1mwu9IerlUzoG6K0R7au1RtMn0UfzQoKLJ+eVEMhawBVgcEMiLDUl7PzZBkKhxU1Vv5FNmKYMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhHNgBSJ96VhrgQsygehE3HDTkO5kY40xXzOpKheyf8U+FWaX
	qrPWZEuJoCwKLo81NzbeKzdbrtiLFul1uNawiAmAVDxmYwmdqa6uCpAP
X-Gm-Gg: ASbGncsjZYin804MX4DAFqq4GmAtZ0hFxf+5Ph1R/nfuEJSCa1wrAcSCOphH4skL63y
	9bsRow0K+QaaXAey8JR93xBiNxzSXeA1rOVNeBb2ySztiJKGREjXs+XdEAJdLN0FTOR7LAkz3e0
	+6L0t0jP5xw/Kfhw6Ew9ryyckMSRsSZlhadyqaBzpBUJ+9TYa3pmx0LBnf18o9Y7MLxePDo1A+I
	+zaUB/pAy7OLGHxxN5F+drH5Q//8yqFlL+b34PblVhx5zeC8VhTFWkE0/9bL+FnusDbaLQhmAl5
	hTI3vRBQlKmettonzBfQ/vzPfw4EXbdxg5XJp4YdCm3rAHjgXWxbX6eiTNvlpmo=
X-Google-Smtp-Source: AGHT+IHlRG59ZQ1RE5LCh+OggOjfsmRsw03O6EaDU9OGsaOzsQR2qjNj3W2GDEZEmVgO/2R9EYjTRQ==
X-Received: by 2002:a17:907:8686:b0:ad5:55db:e413 with SMTP id a640c23a62f3a-ad85b1504d9mr1421685166b.26.1748423202406;
        Wed, 28 May 2025 02:06:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b29324sm73175966b.100.2025.05.28.02.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:06:41 -0700 (PDT)
Message-ID: <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
Date: Wed, 28 May 2025 10:07:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access page->pp_magic
 in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
 <20250528081403.GA28116@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528081403.GA28116@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 09:14, Byungchul Park wrote:
> On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
>> On 5/26/25 03:23, Byungchul Park wrote:
>>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>>>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>>>
>>>>> To simplify struct page, the effort to seperate its own descriptor from
>>>>> struct page is required and the work for page pool is on going.
>>>>>
>>>>> To achieve that, all the code should avoid accessing page pool members
>>>>> of struct page directly, but use safe APIs for the purpose.
>>>>>
>>>>> Use netmem_is_pp() instead of directly accessing page->pp_magic in
>>>>> page_pool_page_is_pp().
>>>>>
>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>> ---
>>>>>    include/linux/mm.h   | 5 +----
>>>>>    net/core/page_pool.c | 5 +++++
>>>>>    2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 8dc012e84033..3f7c80fb73ce 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>
>>>>>    #ifdef CONFIG_PAGE_POOL
>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>> -{
>>>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>> -}
>>>>
>>>> I vote for keeping this function as-is (do not convert it to netmem),
>>>> and instead modify it to access page->netmem_desc->pp_magic.
>>>
>>> Once the page pool fields are removed from struct page, struct page will
>>> have neither struct netmem_desc nor the fields..
>>>
>>> So it's unevitable to cast it to netmem_desc in order to refer to
>>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>>>
>>> Thoughts?
>>
>> Once the indirection / page shrinking is realized, the page is
>> supposed to have a type field, isn't it? And all pp_magic trickery
>> will be replaced with something like
>>
>> page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
> 
> Agree, but we need a temporary solution until then.  I will use the
> following way for now:

The question is what is the problem that you need another temporary
solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
can continue using page->netmem_desc->pp_magic as before, and mm folks
will fix it up to page->type when it's time for that. And the compiler
will help by failing compilation if forgotten. You should be able to do
the same with the overlay option.

And, AFAIU, they want to remove/move the lru field in the same way?
In which case we'll get the same problem and need to re-alias it to
something else.

-- 
Pavel Begunkov


