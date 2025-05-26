Return-Path: <bpf+bounces-58949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBB6AC4331
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5CE3AEE1C
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653F23E34D;
	Mon, 26 May 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z05gML5/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBE258A;
	Mon, 26 May 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748278623; cv=none; b=H0u1hsnR/lE7WJVRO2uBpqDwCdk17FTjKWD4VBDLWxb3J8EJ2/Qp+ne1PiAX5a+ywtWrvWYh4fhAGDekQZ7MVO0adyr+WLRgFI+m9Ep2510M+AgM//NIOWlmC9qqi6yeGmfFAjlwcWhBC1WIhfZzfUijeKL8eQXnZD2lWEHhYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748278623; c=relaxed/simple;
	bh=1l8lnc7L4jN1keZKVH38PKDpIBVamt8y+Pd2Q8GjsZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctzQ8GL8P87z0hJqxizfu3EvAXAmnrKcJECFozcoJxgDhBrDPySHcCkhHbov02bpm5yu9XHRKJBMVaR+AtK7enTRTm43Q8OctjYDq6RCNQcsgF3DRyiXtgUjdU6qhn8kjAnCp56veH9wKeYfrdxD7Iuy5QYJq1Q3laJgU95mckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z05gML5/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60462000956so2330613a12.0;
        Mon, 26 May 2025 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748278619; x=1748883419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtI2+wIxxv2aUKRPo8uX1bj6NM14E537wEMghl0q2io=;
        b=Z05gML5/WZzqrTOnY79aMt4HsfyXOVi9ks2zW+CE4Oj6NC/J8WNoieJLXDoeTdrwj0
         sVEtwRYq+840KymDhEPy1S5j5Ei+wvlZwP/oqtTXRzj8yiKfJiUoUPaeo7SZzTv9qo9a
         d0e0AmgW2OMiYLMJq5H428pvZHMiCfOWgzGidHNsUed3dZMnGUrDwYW5TA8gXwTVkrfs
         kJxgFYTnjqJrYGEA9hq3lLkwAeifgv3MeUGExGrJAmzNk1Qfb/S08D4GBCQPSs8WUkjj
         XcwxgzqP80Q+Kh+4DM3I8NOnCRTcbbIKmcglLgbl8Lel2/K2HESD5Z9Fr6XXkOVlIvaz
         hkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748278619; x=1748883419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtI2+wIxxv2aUKRPo8uX1bj6NM14E537wEMghl0q2io=;
        b=fyJlYKWwPRzVtTgHrsDT90YiNEl9N/1U72cM5zEbbNt4ZJ9EO4b5Dt58ndq58QDLHw
         A9aq81/o1baY5m1gBCGSow5MVoIhaD/9GXYH9Eeyw6uENE23LcW1yDt4GwG2bM3THkVu
         DJhDDwlRkk9UEDIrC9/95W/xFhBPKkmJiPDJIct3Azv92cxWeJuKsIaVKaRhENkRehgT
         rPWq4Pc50oYPSnKlw5iBbMHw9fI/iPeSI46sTDXjbKReDusg6J8Lf7qM+kgwyW/cK43h
         zk57lyYdh8cvhVQxzO5C037Fq1uaQj98wtK+vyRwN/9m9sWRSBDW+cixDJDz1hLnResm
         K0gg==
X-Forwarded-Encrypted: i=1; AJvYcCUTSSZfsjKesqKtx16pIJ8wPp5RMj19GGdWWPjzWKy/rZQdnr2CLfqB6raNOAchkx05tlbSLrJ2hK/6iw==@vger.kernel.org, AJvYcCVtEG7uuRg/kQGR0StnBjgeaj3wES5ApLIkFCXT0MVtN+9+dvVZjoOBj6/xqNmDoQ39pqQ0WAqG@vger.kernel.org, AJvYcCWiPQWhRjbHtqUZqCZd+FhMp/nduWbqXEAIZFZidQeVbLobvOhGitPrhCFXV58RZszv8NSUsIS4rKzFBsJ4@vger.kernel.org, AJvYcCXS0pL9VHjxdTaewv4jZ4aGX1SKeq6fsjUxeOT2SsRbjPqEzuPmjiqjN2nlrqlRGddA+d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOqmKTkCm/vIDyhO7G9t7J0KtOBUQ7R/xdIX0kfmDDDO2BzdN
	Hapq6+hnehn8jO2SJ9t0xKlqP/98uPzfGPn2AvtmhEsjmDZDSTMx6Ltb
X-Gm-Gg: ASbGncueO5WzYxVZZ8om318TzFoYwFGWvzrm/APNxzck5Bdbt7xdpKOc+SuDyNTDoDm
	DksoXazP9/0WqXTDX8g+Deqn/3UZyAAjCAsYMq1gcWaEV0ziIxuJEhaLEL22GkwqDO4SVgm0oMK
	yVvVLjkflwvDMBDXF6JRvZVlOH69fGfClZk88FtWI5KMgzf2zCdnGxVjndsfo3mt7hNuEk2GRh5
	EJtSMHJLZpzJVfrBDMoFB1PzBEDvp1mutVbhwJE8Fek2jeaoK2yaA+F8xULaN08MRDQsXXMfUF5
	gvE1rKTtwh98JTR3PfFN1AKcbylE06Vprcm685UXW8ETVwllmO3QyfsWJR42
X-Google-Smtp-Source: AGHT+IHIU4hwSe/lUANY7Ot/pQUZbeTO+/Y8j+ii+4Tvkv/qi38bDUgS2PtlnL+W0MaH1RZhir1pXQ==
X-Received: by 2002:a05:6402:26c1:b0:5ff:addb:653e with SMTP id 4fb4d7f45d1cf-602da304c36mr7451507a12.23.1748278619230;
        Mon, 26 May 2025 09:56:59 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.132.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-604533ace77sm3390798a12.6.2025.05.26.09.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 09:56:58 -0700 (PDT)
Message-ID: <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
Date: Mon, 26 May 2025 17:58:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250526013744.GD74632@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/25 02:37, Byungchul Park wrote:
> On Fri, May 23, 2025 at 10:55:54AM -0700, Mina Almasry wrote:
>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> Now that all the users of the page pool members in struct page have been
>>> gone, the members can be removed from struct page.
>>>
>>> However, since struct netmem_desc might still use the space in struct
>>> page, the size of struct netmem_desc should be checked, until struct
>>> netmem_desc has its own instance from slab, to avoid conficting with
>>> other members within struct page.
>>>
>>> Remove the page pool members in struct page and add a static checker for
>>> the size.
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> ---
>>>   include/linux/mm_types.h | 11 -----------
>>>   include/net/netmem.h     | 28 +++++-----------------------
>>>   2 files changed, 5 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 873e820e1521..5a7864eb9d76 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -119,17 +119,6 @@ struct page {
>>>                           */
>>>                          unsigned long private;
>>>                  };
>>> -               struct {        /* page_pool used by netstack */
>>> -                       unsigned long _pp_mapping_pad;
>>> -                       /**
>>> -                        * @pp_magic: magic value to avoid recycling non
>>> -                        * page_pool allocated pages.
>>> -                        */
>>> -                       unsigned long pp_magic;
>>> -                       struct page_pool *pp;
>>> -                       unsigned long dma_addr;
>>> -                       atomic_long_t pp_ref_count;
>>> -               };
>>>                  struct {        /* Tail pages of compound page */
>>>                          unsigned long compound_head;    /* Bit zero is set */
>>>                  };
>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>> index c63a7e20f5f3..257c22398d7a 100644
>>> --- a/include/net/netmem.h
>>> +++ b/include/net/netmem.h
>>> @@ -77,30 +77,12 @@ struct net_iov_area {
>>>          unsigned long base_virtual;
>>>   };
>>>
>>> -/* These fields in struct page are used by the page_pool and net stack:
>>> - *
>>> - *        struct {
>>> - *                unsigned long _pp_mapping_pad;
>>> - *                unsigned long pp_magic;
>>> - *                struct page_pool *pp;
>>> - *                unsigned long dma_addr;
>>> - *                atomic_long_t pp_ref_count;
>>> - *        };
>>> - *
>>> - * We mirror the page_pool fields here so the page_pool can access these fields
>>> - * without worrying whether the underlying fields belong to a page or net_iov.
>>> - *
>>> - * The non-net stack fields of struct page are private to the mm stack and must
>>> - * never be mirrored to net_iov.
>>> +/* XXX: The page pool fields in struct page have been removed but they
>>> + * might still use the space in struct page.  Thus, the size of struct
>>> + * netmem_desc should be under control until struct netmem_desc has its
>>> + * own instance from slab.
>>>    */
>>> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
>>> -       static_assert(offsetof(struct page, pg) == \
>>> -                     offsetof(struct net_iov, iov))
>>> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
>>> -NET_IOV_ASSERT_OFFSET(pp, pp);
>>> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
>>> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>> -#undef NET_IOV_ASSERT_OFFSET
>>> +static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>>
>>
>> Removing these asserts is actually a bit dangerous. Functions like
>> netmem_or_pp_magic() rely on the fact that the offsets are the same
>> between struct page and struct net_iov to access these fields without
> 
> Worth noting this patch removes the page pool fields from struct page.

static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
{
	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
}

static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
{
	return &__netmem_clear_lsb(netmem)->pp_ref_count;
}

That's a snippet of code after applying the series. So, let's say we
take a page, it's casted to netmem, then the netmem (as it was before)
is casted to net_iov. Before it relied on net_iov and the pp's part of
the page having the same layout, which was checked by static asserts,
but now, unless I'm mistaken, it's aligned in the exactly same way but
points to a seemingly random offset of the page. We should not be doing
that.

Just to be clear, I think casting pages to struct net_iov *, as it
currently is, is quite ugly, but that's something netmem_desc and this
effort can help with.

What you likely want to do is:

Patch 1:

struct page {
	unsigned long flags;
	union {
		struct_group_tagged(netmem_desc, netmem_desc) {
			// same layout as before
			...
			struct page_pool *pp;
			...
		};
	}
}

struct net_iov {
	unsigned long flags_padding;
	union {
		struct {
			// same layout as in page + build asserts;
			...
			struct page_pool *pp;
			...
		};
		struct netmem_desc desc;
	};
};

struct netmem_desc *page_to_netmem_desc(struct page *page)
{
	return &page->netmem_desc;
}

struct netmem_desc *netmem_to_desc(netmem_t netmem)
{
	if (netmem_is_page(netmem))
		return page_to_netmem_desc(netmem_to_page(netmem);
	return &netmem_to_niov(netmem)->desc;
}

The compiler should be able to optimise the branch in netmem_to_desc(),
but we might need to help it a bit.


Then, patch 2 ... N convert page pool and everyone else accessing
those page fields directly to netmem_to_desc / etc.

And the final patch replaces the struct group in the page with a
new field:

struct netmem_desc {
	struct page_pool *pp;
	...
};

struct page {
	unsigned long flags_padding;
	union {
		struct netmem_desc desc;
		...
	};
};

net_iov will drop its union in a later series to avoid conflicts.

btw, I don't think you need to convert page pool to netmem for this
to happen, so that can be done in a separate unrelated series. It's
18 patches, and netdev usually requires it to be no more than 15.

-- 
Pavel Begunkov


