Return-Path: <bpf+bounces-61304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B9AE4B96
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3FB3B8480
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAB529C328;
	Mon, 23 Jun 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbSGZMR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D01C07C4;
	Mon, 23 Jun 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698318; cv=none; b=hj4pAN7Q6A4g6NGFyWE7Yy15topesnWvKREf6QVKYxYq5ZgqrK5+aWm3Z5WCzN3+6O8q4gz2H846jDNIRut6Zf+8mXZnnzB+SpQP74IiSuayYhhpqWyIkWgnoXlfTexDykjeZV/E3B4Na9BgBeMnM1h3ObZQjUDFMTXo/JE0wlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698318; c=relaxed/simple;
	bh=6nZoOQkZs6C4FQYLUnskHM0GHFTQYyosqeO+/BXGQdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHzgKFfD8Pra6UJpKDrMwWCiNnLtRETUBuCWRNQVtsJ3WWe6BrGVNWwrJ5GQ78Z5Aqs8IBS68GclR1td/d7xLZfdpyA4KmkxJ+YUSf4HKCcZPcizhJf48YNns3uxAfZLdttZvKZ1JFrCnLl5URkPyUSFFqVP3mml3Vjt48SZkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbSGZMR+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ade48b24c97so777429566b.2;
        Mon, 23 Jun 2025 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750698315; x=1751303115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi3M8vSwwyPlCy0ds+MLiPgrDsER6WDeUbD1bJQq8OE=;
        b=JbSGZMR+hZdXtyQMne2CDCoNWZQzxY0TJDPU/VdJi7nmNTgcTCbgtgRt+7obTDtTQe
         ZnvqZAfjSmskm2CSoONCcdllsVZol48CQZJYvSiQ/+4jm7eLUbtDV+RmhpQP4HVVV+cm
         a2x/NgHG6/KHhGBQeh3PdL9ktBvUQbmIuWK/zoWnhrXjYuJ4qojgfCJuJPE38OWIj1uC
         Z/MgJSxAPuO6S+avdx0zxBxfuoPZmVBf+6BkXntLyf4zGJUCbWsNbgM2gNDrIVc8SIS5
         VBwKlvGT/TmzhHVKg1toueJBX0AfXrUI8nNPmU7Sx5KyfohSe/JRNu+MQxk31G7jOPun
         N7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750698315; x=1751303115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi3M8vSwwyPlCy0ds+MLiPgrDsER6WDeUbD1bJQq8OE=;
        b=ioWaLotzJ5vJIafUZn1rMeLvvLl+EuudI4DTPGf3rda+bOxwTigYyjJt+oJPmnZyvC
         1sftT9cbDo/0PIGNm77yBNrgDWO33iT43xAAn0nHn7lCVtEtTvzWe+4RjSA1R3Nuek55
         jlW+Q7leSOzI6oQ9KEIe6TUPJjBok6APlXCoc22JwqVeP8YuyWVwgQkUhoB4n4DP4iTW
         4+SdHP8+krfYYdef6CfuFsLNgRYnbpZP40sIsIABTOY/98jv1E+ljBPyMLPX9OoP56av
         mVInY7aV6LrXBRHFZxnVFcD+UcHdotvJDLozEJNBejapDjKCxtli1JXTwg8OssnbJp63
         Q4lw==
X-Forwarded-Encrypted: i=1; AJvYcCUeFbpClIPOufHSSFvvxqjkBMV2aa74KZVZQQ9y4Z+I2136XI1yfmo5EhI3IhW8NFJsvXlY08klUi0fhQSN@vger.kernel.org, AJvYcCUqAxhq4hONFmLSja5/30IHB9ORvko+wW8ZaQVstTJiDHLvbzWuonoQsmQEOGqRExDOxCzjOAQp@vger.kernel.org, AJvYcCVBpAkROhg93jcE7WIfU+CQUmbM4slRIwTZa7hARBvXsoDpPpl5URXl4mxxLFV7o5P/X9OYw26pDKI8Dw==@vger.kernel.org, AJvYcCVJ7XFAwzTFQt57RmzUwkHEcPUtiIOWr1ds9iuNsVOyvyjn2ePsoUrOf/zheU6im91H8D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH339qAf779nAfj+DcJ72+IJgMGHbJvO8VQZm1OVJDiCE1zv+R
	ilvPk9gU4+bxuH/rcGY375lpPykwctLgUrKBnHWYUnHNtkYNFkpnzACt
X-Gm-Gg: ASbGncsEID06bfKzTmIou2kVVfggWPL+eBxvt9s+xCnhRyaldcrvCnOCOE8nh89Hu16
	SAOe49r7dsSGancXdZfu2aYG15r42Yc/pHF1i2qRol0hfWdw4IUZjIxN5hVbSWg8YSmUIxpfPhv
	rqNRmnw5z5A+Q3+QV5S2wQuikXuDtl8mYaqfYZhcvRYUQx0whqwvYLvlsU0LN3maOj0EITOQ79M
	aEo4LLULiqSuGAk7MEk7DyoCaAUY/Jcx9QUJvF8v2mpmZcHhXI7wbVP5OSGrmu/h5TO85lCATM5
	E69f5PVBLjUA0kpyoDpcz028Ejl7tFfrRQ6aHGTaUdIJya/VFuCySk34pmHJeCew+j+kpL4bhBA
	=
X-Google-Smtp-Source: AGHT+IFkMr16MZMhGYOEMve0k+oWilXDkDPpSQstoYWVNutXXp/lz9Oc+tMJS730MOiqaVVD0hEmBQ==
X-Received: by 2002:a17:907:3f18:b0:ade:4339:9367 with SMTP id a640c23a62f3a-ae057a222b4mr1293806966b.26.1750698314880;
        Mon, 23 Jun 2025 10:05:14 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::2ef? ([2620:10d:c092:600::1:85c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054082d25sm728555966b.88.2025.06.23.10.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 10:05:14 -0700 (PDT)
Message-ID: <41e68e52-5747-4b18-810d-4b20ada01c9a@gmail.com>
Date: Mon, 23 Jun 2025 18:06:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 15:58, David Hildenbrand wrote:
> On 23.06.25 13:13, Zi Yan wrote:
>> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
>>
>>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>>> To simplify struct page, the effort to separate its own descriptor from
>>>>> struct page is required and the work for page pool is on going.
>>>>>
>>>>> To achieve that, all the code should avoid directly accessing page pool
>>>>> members of struct page.
>>>>>
>>>>> Access ->pp_magic through struct netmem_desc instead of directly
>>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
>>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
>>>>> without header dependency issue.
>>>>>
>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>>> ---
>>>>>    include/linux/mm.h   | 12 ------------
>>>>>    include/net/netmem.h | 14 ++++++++++++++
>>>>>    mm/page_alloc.c      |  1 +
>>>>>    3 files changed, 15 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>     */
>>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>
>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>> -{
>>>>> -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>> -}
>>>>> -#else
>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>> -{
>>>>> -     return false;
>>>>> -}
>>>>> -#endif
>>>>> -
>>>>>    #endif /* _LINUX_MM_H */
>>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>>>> --- a/include/net/netmem.h
>>>>> +++ b/include/net/netmem.h
>>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>>>>     */
>>>>>    static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>>>>
>>>>> +#ifdef CONFIG_PAGE_POOL
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +     struct netmem_desc *desc = (struct netmem_desc *)page;
>>>>> +
>>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>> +}
>>>>> +#else
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +     return false;
>>>>> +}
>>>>> +#endif
>>>>
>>>> I wonder how helpful this cleanup is long-term.
>>>>
>>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>>>
>>> Yes.
>>>
>>>> There, we want to make sure that no pagepool page is ever returned to
>>>> the buddy.
>>>>
>>>> How reasonable is this sanity check to have long-term? Wouldn't we be
>>>> able to check that on some higher-level freeing path?
>>>>
>>>> The reason I am commenting is that once we decouple "struct page" from
>>>> "struct netmem_desc", we'd have to lookup here the corresponding "struct
>>>> netmem_desc".
>>>>
>>>> ... but at that point here (when we free the actual pages), the "struct
>>>> netmem_desc" would likely already have been freed separately (remember:
>>>> it will be dynamically allocated).
>>>>
>>>> With that in mind:
>>>>
>>>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>>>> could check that instead, so we don't have to cast from pages to
>>>> netmem_desc at all.

As you said, it's just a sanity check, all page pool pages should
be freed by the networking code. It checks the ownership with
netmem_is_pp(), which is basically the same as page_pool_page_is_pp()
but done though some aliasing.

static inline bool netmem_is_pp(netmem_ref netmem)
{
	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
}

I assume there is no point in moving the check to skbuff.c as it
already does exactly same test, but we can probably just kill it.

-- 
Pavel Begunkov


