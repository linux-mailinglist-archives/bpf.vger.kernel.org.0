Return-Path: <bpf+bounces-59148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2901AC6596
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7099189F7C2
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE4275854;
	Wed, 28 May 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fofja7hj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC04275842;
	Wed, 28 May 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423967; cv=none; b=RJ5jz/3pvKbBj8zWNpobn1FxsYu00GaISxLgI2i4pzpoz9rRswkHeboG4enNELg0hZXW7NuPJZpuTtFRd+R/obbuYRChJDjrQJ1+zVnwtZPrLYq2U9h9gishrFx606wMURFwEuDx+NoxkvuZ2d2v4iF9Ixi4cS4ZGYY6p5D6wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423967; c=relaxed/simple;
	bh=0nqBvlClGGVftjhIj76UIA4iGWi8W5biejuedgY8s7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilJImwNlp3lOt4R6Y/UPo7FeyiIZUe3ZakMOy8q0kPfDvFULvh82HiJBsnDv0lIxXpkO7Z/fMtcQK1I7q4Dj02HiuHJbxDU5cmqO1vXUZE9rIMJ+JGuZyrq8iH5AX0HyfP16YRyhQRHgPpDli/dYwwIIV73NGjsEcq8Z4YpiSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fofja7hj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604e299b5b6so1352719a12.0;
        Wed, 28 May 2025 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748423963; x=1749028763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlRiXiMydg8Ng6zdXcXHZ9C9WqC7917J7z9TLlV4E6Y=;
        b=fofja7hjod2Nuf5AGVgGgmsHIXE0wuNbuZXhUDZghBuF2D3YrvNBitDRMOXagsgxFs
         xerA3ss1eyIUrm5qd/r3LXIi74Mn7nYFPR9PkYe5bsYOSlIhy1QmbteaTARLcy3dQg9v
         8mgR9qRVRpPSaopVtH9Z14QJS0lt99FuCYEfMwUgw4+RbysUbmFZA1fOFA0N8fpJNaWC
         caTahAqDI+qIUb7S6/Wx7YbmX8HhlnA2ce8vHmxqonEwK1Onnr0KxbGpg4CrSeaFkFIs
         3r1WbKcGKzzXomREkHE3gOQJxtmTQT+vQhS75BsZC+UhKrsgwQXTC2tImGmskuxfxlHA
         h5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423963; x=1749028763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlRiXiMydg8Ng6zdXcXHZ9C9WqC7917J7z9TLlV4E6Y=;
        b=CA0htJApZ5CP6uyF6D0EC0t/ygyENF+c6e/+VBfBnTyXHw8G+oShPwIc4hQjwc1gLH
         1YbRuF17GeiCCelYfcANGg5u1I7Hv763nVRjhYte+twsqE4ubp1KZBBvZc6MEPgdR6eI
         RDpoTpZjtQFQzF1g5TWKlOvrZPqzUhtelyYmGX4TiS/DzmCEdEzXeQBlyGnKz9GS2RNh
         ZSce6dcfz0F8dLHX/HHTyFVV5kCK/U6jGQ1H7hzzr1ueQWfKaFdS+UiRytwVKxQkD7ET
         zySj0GR49+GMzR06N2GE3zfk6TDSTjKVFF6cPa06105qMK90UBzY99GJTmwpdmcZU4YJ
         2FFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWfQJHNHVy25qb1UenI+E6AWfhnKZp4hm4r8kij6LXp/L7ARUX15lk2fF3PkoeYFKQEL55rmARpb6Wqg==@vger.kernel.org, AJvYcCXcE8GcisVDTs12cGuWnd32bhdut0TrTO1NIt6wr23Ofd17yxqC+0KYRILtHgIB5K48CPh9XyHUSydzKbY7@vger.kernel.org, AJvYcCXia8bYPKbYzn5cS2ze2XL/uulPoI5Ym/Lj5CKpwwrKC5CHxV7Lg34aOlft35uORMpU0m2fTvA3@vger.kernel.org, AJvYcCXmarxevsGQNBW/V5jnm5lgUFDpynA/Dk+Apnc5xEO5w4gTfeHwGHx1iiVTMeE/huMgYI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibO2faaMDsEdn4+X5bK2UPRpdCjnMBJY2bHVk7g9i0NiPgf6v
	zmNoTPWJAx0ZgunrkXfdsiNQMS7Nxb1wVmwWnb7GdmMtYLanpIrWE3FdpBI3xUwk
X-Gm-Gg: ASbGncsww0xNT2VLkjpzAJp/BOc9YYUBB+HVcEB1jqoZgTYwYOlO+MnQCTsaWOCCSN4
	tkpRzKM0KUpExhYDOciuFcb1SATA+ljfFDqppoDvvffU+2bogPL9IdairGQLvFyQZfBVjRCaSD/
	N61ivvGoZ07kXRTpQFrKpnnFurvM3aZXolmFzB2e3GZqOzXmEnf8pzg5EwUN2A8DR4KzobC6m+E
	2fAIJf4lx7cHgu1YU4xj1hxijE4vqx8Nmq/LSFQUpze9DEibE94aKSco4SHJBYm4Pe9JceCV85Y
	cpC75rM/4zUn6OvuFjAE6hIm2x34bGF+S2lOZWwIKfFHozlYugzB4uOlV78lItHxSVZ3j8q0ug=
	=
X-Google-Smtp-Source: AGHT+IEq6tM8RdZXXvDSkGfL6LGlhKbzABi9NzIAuOCCNVVdVvH3+0hfCaQJlqqdguwEgPZkuM1QBw==
X-Received: by 2002:a17:907:7f91:b0:ad5:4cde:fb97 with SMTP id a640c23a62f3a-ad898a1de29mr346968866b.29.1748423962900;
        Wed, 28 May 2025 02:19:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1a1323bsm75303366b.84.2025.05.28.02.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:19:17 -0700 (PDT)
Message-ID: <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
Date: Wed, 28 May 2025 10:20:29 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528091416.GA54984@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 10:14, Byungchul Park wrote:
> On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
>> On 5/28/25 09:14, Byungchul Park wrote:
>>> On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
>>>> On 5/26/25 03:23, Byungchul Park wrote:
>>>>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>>>>>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>>>>>
>>>>>>> To simplify struct page, the effort to seperate its own descriptor from
>>>>>>> struct page is required and the work for page pool is on going.
>>>>>>>
>>>>>>> To achieve that, all the code should avoid accessing page pool members
>>>>>>> of struct page directly, but use safe APIs for the purpose.
>>>>>>>
>>>>>>> Use netmem_is_pp() instead of directly accessing page->pp_magic in
>>>>>>> page_pool_page_is_pp().
>>>>>>>
>>>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>>>> ---
>>>>>>>     include/linux/mm.h   | 5 +----
>>>>>>>     net/core/page_pool.c | 5 +++++
>>>>>>>     2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 8dc012e84033..3f7c80fb73ce 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>>>     #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>>>
>>>>>>>     #ifdef CONFIG_PAGE_POOL
>>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>> -{
>>>>>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>>>> -}
>>>>>>
>>>>>> I vote for keeping this function as-is (do not convert it to netmem),
>>>>>> and instead modify it to access page->netmem_desc->pp_magic.
>>>>>
>>>>> Once the page pool fields are removed from struct page, struct page will
>>>>> have neither struct netmem_desc nor the fields..
>>>>>
>>>>> So it's unevitable to cast it to netmem_desc in order to refer to
>>>>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>>>>>
>>>>> Thoughts?
>>>>
>>>> Once the indirection / page shrinking is realized, the page is
>>>> supposed to have a type field, isn't it? And all pp_magic trickery
>>>> will be replaced with something like
>>>>
>>>> page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
>>>
>>> Agree, but we need a temporary solution until then.  I will use the
>>> following way for now:
>>
>> The question is what is the problem that you need another temporary
>> solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
> 
> I prefer using the place-holder, but Matthew does not.  I explained it:
> 
>     https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/
> 
> Now, I'm going with the same way as the other approaches e.g. ptdesc.

Sure, but that doesn't change my point

-- 
Pavel Begunkov

