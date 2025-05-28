Return-Path: <bpf+bounces-59150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FFAC6643
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C54E3605
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E3278E6A;
	Wed, 28 May 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkiktXZ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D01D47B4;
	Wed, 28 May 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425822; cv=none; b=Hmh4lXHj6bfQG22I5nywG3OcYpMEcMKlthPgsj4ORc5/bikZN6yH3VxlYNz3RJYJl9SoOrxLVVp7zNiGXag7a5uD8bQ9WQUxiQ4Oxm2gVSbLYqjA3nDnug4Ut2C1d435TG9tzlT9DdgeXfI4Amq8WEijnbdn5hjY3NwFlOuxshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425822; c=relaxed/simple;
	bh=uXLKxbZMGyPQIhzmIxYiHPJggnsUBGMt+mRIvq+k2ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYzqTvoNE2bgtjtG9dpW7FE3UNwptNwFOZLusvSl2BTEV1v9cnD/TP0rK5lK0SsCnxNf33nFnc73ulrrh49JEEXQs7AKmkfJBSF7zNXczeMtStY3pCIXLzgikctnkDx1IypDeWBQLiPsKC5hC2d6YA7t4W7IcCTE1h6VaLNSAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkiktXZ2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6045b95d1feso7258704a12.1;
        Wed, 28 May 2025 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748425818; x=1749030618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U154eK3ddwaPqm55ZRdw1sQb9SuIUnfO5tNkP86wnH0=;
        b=dkiktXZ2ICbVFaVjQFr+BJONEu3yGJH7RtL+96TN6vvDkNNpKurGpkqOY02rCn2bU7
         GEMOMJRdhSNVOoESrLiQukmPMvhUTYTX9Yr0Bur+FS5e8CPxL6rGHwwbcu/2dTUYv0/o
         PxaONM4LmGwyFkOoSiLdVf4pBcejcfslhjTz+6PFnbROaS+Yj4fte236k+Lm/9N5yZGh
         85RIdVpC/tJHX6VVRTe47v4BEbptLFqfShHKjOjVoNdeahYBbY8g1uWJQMgwVDZXTu00
         BAH596Nu/SigCPC2HCLQxlcMuD6ULAIqaWqmh5AsIbJal6xy6JamjVQVZXmkaYF8dtDc
         FhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748425818; x=1749030618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U154eK3ddwaPqm55ZRdw1sQb9SuIUnfO5tNkP86wnH0=;
        b=Txs+ZjVDi/OwIcqg2XVmpPrhU0Yw/+5HtMg4vL3En+cNzjqATN3rkPaCRWpW54IgGQ
         BXUxMhce5+elC6HZImwQMLNg27e9J4O+hqgE//9QHtoMsa7t0OAXZ1ubLozO2zBVPIn8
         87RPJqcj7oYApqgu/aZamR4vC6EkJiMNY8d9YEuRpY3oAFgrX8AIxtNlrqlu3bN150KX
         bXzjo23sYfGe1ZnlnDN9qwtUW4STi3mFEo4auo0S3iTZXBxmAnGezf4/kYPGY7REeuNy
         FCS1EhE8zrn1ftvVrd5LZcP8RwjUyuppYxe8jhKaDomaI63u471V1w/fD9tUNT4gMVQ1
         Cwpw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOIyVtJUKOEazW/nJPHzT2prNu04mxbPuwbW/ikr/PZQg8BlW9SkOvGi32xDtKpfLKv+cMyLTJEC5bk/E@vger.kernel.org, AJvYcCWofrpj6fcyw5gkf5j/7o0DuqbOLTv/xvTqs9XI6QYM0ZY0glTw1E38fpvJ1n2LiHes+Xw=@vger.kernel.org, AJvYcCWx3QU6iwiWXhGq80gmw/PE5e33IaIVjxOhg+NZIqmChnjLSG4QmB5M1EkAhW8n76PGn8SAOszZUAIm2w==@vger.kernel.org, AJvYcCX+I9M9db9UlUh7I5Q7iRcEzl9GpornlB9EFEysuDqgJR/09bIkvQVm6BWw0i5frJcI/9YOvWSA@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqmJ2BN+hgHaL/3/vLpwXH6siNUfX+vM7BlHEpgwCAuHRDB09
	oddPT/LHTAOtpYC1qGVnniWi2fuLEkArwBB9fKy0SEg2jxgHxs+wdhP/
X-Gm-Gg: ASbGncu5i+5F9l17VVwNyBvkwgHg9D+2K8mrDvYMUC2DmXR8y/4PDfasrIOLlLZRfrw
	WejmxAgNzhkBTdfEvK/+pOGVZ5XZPcIFhqY2qQMlbsEkvzdZkgVxiNJcTcLs0LskJp4wjFc93eG
	Izb73Uk7YMWq+bvU1gT0ieygXS7raYKtYkJmmUEv/ctcjpthiMb0APwPRE6nkeAIWsJ0IanAy7y
	9paiHOaoiNv8CGyjbash76YN5gQKEPm1AABNSIgp/WyNMIYiqxpBSF7JwzKNw71JMEsR3XiBili
	sgEQshW2YOddvTzpiLtyqsYFARNRpkqzloVwF2P1P1020pEl9VESQLGZoMrJEQCCe1vSct4+vQ=
	=
X-Google-Smtp-Source: AGHT+IFBpwXe6OYaA+6pIeCAYnPKbCTjWryXK9Qi9lEDBkg++QM3cSR3IC/BzivItjAiaVNDFa3zmw==
X-Received: by 2002:a17:906:c14f:b0:ad8:a4a8:103a with SMTP id a640c23a62f3a-ad8a4a81180mr97835266b.4.1748425818177;
        Wed, 28 May 2025 02:50:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b28908sm78014966b.117.2025.05.28.02.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:50:17 -0700 (PDT)
Message-ID: <5494b37d-1af0-488e-904b-2d3cbd0e7dcf@gmail.com>
Date: Wed, 28 May 2025 10:51:29 +0100
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
 <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
 <20250528091416.GA54984@system.software.com>
 <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
 <20250528093303.GB54984@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528093303.GB54984@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 10:33, Byungchul Park wrote:
> On Wed, May 28, 2025 at 10:20:29AM +0100, Pavel Begunkov wrote:
>> On 5/28/25 10:14, Byungchul Park wrote:
>>> On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
>>>> On 5/28/25 09:14, Byungchul Park wrote:
>>>>> On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
>>>>>> On 5/26/25 03:23, Byungchul Park wrote:
>>>>>>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>>>>>>>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>>>>>>>
>>>>>>>>> To simplify struct page, the effort to seperate its own descriptor from
>>>>>>>>> struct page is required and the work for page pool is on going.
>>>>>>>>>
>>>>>>>>> To achieve that, all the code should avoid accessing page pool members
>>>>>>>>> of struct page directly, but use safe APIs for the purpose.
>>>>>>>>>
>>>>>>>>> Use netmem_is_pp() instead of directly accessing page->pp_magic in
>>>>>>>>> page_pool_page_is_pp().
>>>>>>>>>
>>>>>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>>>>>> ---
>>>>>>>>>      include/linux/mm.h   | 5 +----
>>>>>>>>>      net/core/page_pool.c | 5 +++++
>>>>>>>>>      2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>>>> index 8dc012e84033..3f7c80fb73ce 100644
>>>>>>>>> --- a/include/linux/mm.h
>>>>>>>>> +++ b/include/linux/mm.h
>>>>>>>>> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>>>>>      #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>>>>>
>>>>>>>>>      #ifdef CONFIG_PAGE_POOL
>>>>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>>>> -{
>>>>>>>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>>>>>> -}
>>>>>>>>
>>>>>>>> I vote for keeping this function as-is (do not convert it to netmem),
>>>>>>>> and instead modify it to access page->netmem_desc->pp_magic.
>>>>>>>
>>>>>>> Once the page pool fields are removed from struct page, struct page will
>>>>>>> have neither struct netmem_desc nor the fields..
>>>>>>>
>>>>>>> So it's unevitable to cast it to netmem_desc in order to refer to
>>>>>>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> Once the indirection / page shrinking is realized, the page is
>>>>>> supposed to have a type field, isn't it? And all pp_magic trickery
>>>>>> will be replaced with something like
>>>>>>
>>>>>> page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
>>>>>
>>>>> Agree, but we need a temporary solution until then.  I will use the
>>>>> following way for now:
>>>>
>>>> The question is what is the problem that you need another temporary
>>>> solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
>>>
>>> I prefer using the place-holder, but Matthew does not.  I explained it:
>>>
>>>      https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/
>>>
>>> Now, I'm going with the same way as the other approaches e.g. ptdesc.
>>
>> Sure, but that doesn't change my point
> 
> What's your point?  The other appoaches do not use place-holders.  I
> don't get your point.
> 
> As I told you, I will introduce a new struct, netmem_desc, instead of
> struct_group_tagged() on struct net_iov, and modify the static assert on
> the offsets to keep the important fields between struct page and
> netmem_desc.
> 
> Then, is that following your point?  Or could you explain your point in
> more detail?  Did you say other points than these?

Then please read the message again first. I was replying to th
aliasing with "lru", and even at the place you cut the message it
says "for example", which was followed by "You should be able to
do the same with the overlay option.".

You can still continue to use pp_magic placed in the netmem_desc
until mm gets rid of it in favour of page->type. I hear that you're
saying it's temporary, but it's messy and there is nothing more
persistent than a "temporary solution", who knows where the final
conversion is going to happen.

-- 
Pavel Begunkov


