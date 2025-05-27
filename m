Return-Path: <bpf+bounces-58963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD61AC47A2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 07:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C69D1772A7
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 05:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845E1DF252;
	Tue, 27 May 2025 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Z/XuMx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42F13AD3F;
	Tue, 27 May 2025 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748323746; cv=none; b=PY8CunrZzFMURN64SetahfClE/xxcb30pmL6QAoYJNnnBY6R7x0tr8eGwgoHcKox2aCggOV+erWOxPZZI5Edz9s+MjW9Q0ozSKWuYo453jYgpPnhmmvuNG3oPVhPXDw/ilrsnEMfjxrczIJojhO7kcex5oe1DHDvyL2HdXSi+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748323746; c=relaxed/simple;
	bh=C8qkJH3MrAqV9gs5bawr3ON5EFZyUYFn+wmxYKLvcvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiZQYhv35FQA5lDvYjHb4tWX5RGZUJX40u+akfQLpZkLHN1NrsW2uBQy0y8u46XL7EKvtKpqBBG2T674T4oIwg3vs2U0949OHexB10BpUwmiv1WeBi1uOl2oMmG0N9aBzFleG+mwYuA7UZ5vfkrmgxHMSI47y5ayF7H2RZw75CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Z/XuMx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad5394be625so541577266b.2;
        Mon, 26 May 2025 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748323743; x=1748928543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPYBWyOq7r+7W8qExCRG+4zXFY/pJBbil6VcRDPRQGs=;
        b=d0Z/XuMxfrJY2AqROTAIqB0bXKp2y6DzuzkHDbjcVhadF3V3xaFUVI/IlTfdjsnfUJ
         5wqm94+jk+oJgQy/zKaaRWBk59pvM92xBPod9cvBbva+ILkVigFqMnFcO3MR3kYLtdx2
         0hKyf1EO6SLkecB/IvZ8I5390HiJu8YeU1XIzyYH8CFsCsvMSAkwfLtZd/thziQxpQKo
         dWslhs3BH+qV5TfVLsSmDTjz0Ns9Kai4nIBlAkLy/8zB7wNcHw5SGwCuPRAsGioGCU6p
         6rnHLUr7H0OZSgZflwtUpKH5f3Na8bB9MM7FYsYFTt/1lPe6h1j/QWWBpAK5J3bFWqiI
         rkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748323743; x=1748928543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPYBWyOq7r+7W8qExCRG+4zXFY/pJBbil6VcRDPRQGs=;
        b=uj6kJGOqfliDJ6jMwr9lZpArtEhhLKMLlk2qc9OCTFGbKC+4vwZQpC0xje1dY5WyJ1
         FCwWP0x1myTM8wLj3NO4HWdv72eZDalTjx2lNo5DW6tlQhDFYRhv/4Pzhw54KH1rYXhT
         56B1X/emWBT14ctcxTqrNQS30I9XnZ374rXfJfsIBETZ/MVQKnycC98pKlQ8rnhOzGmR
         zX8ZOQX+X/dsNjhSsDD5lhhCMezS21qbENPAlSKYns7dKE1//TKU5sB4VEjlyBMR7eFO
         soF9yxFmWIiOdrvm567xlpE7rn8mHQzCpdOLlx1RhCgmoskhiUaW5hpDnEDoMmTaxFa5
         P7BA==
X-Forwarded-Encrypted: i=1; AJvYcCX0tsX5JfpLSLmbOq+YOzHOGt1T7btalFo6Mz6lRNHXJKgOlcZ8Pn5B5V8otSAkXAlTZcd9ZvWi@vger.kernel.org, AJvYcCXX9QaPGhuZrVntnTyXWwJnQA853M3b4u0MeNdRnzVOz0pD1IhORaj94GqYE/NlRYRmRKVkVkrysBdHdzcV@vger.kernel.org, AJvYcCXi/Qj0xRuIsl/9IpaHBs/jUKYkkYzxX2+1xeEkY9C8/uUzfXljllwqyMIYnMEsS/hnfLM=@vger.kernel.org, AJvYcCXoRlt7bePvKDOZD6T08DrEHi/VXpjDjvLEvP0l6f+Bm6OmEe3Q7zcUb9ZdwoRDdXVH38zbJ5e9ke//1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSmicNgtAtmUY2n8Prp7ozxVZUrg4gZDnW6OA3T+56keOBlGj
	O8AFzZtS9XWV/YSw2J0dVhAErgDzuTN5GfElfUbkjFQ2edIXkE9h7xnG5SqdcYkU
X-Gm-Gg: ASbGncvDk+TAq47+0Qo1X77YZJGg+FWg0sJefaPD3RXrvSvH9llORTRCS598MRXNdJe
	hTW60dJiadT0wWDRD7YsMAFEav2RGWR5IbqYk9b7jDTOE/bKeRzX2rePeCwkLlFQsVXncBs2VGi
	/fXzHwX9WesUwPVZKITsD5ZQHEgDq/LilUrJJKz7x398XLU333/rtgFTaCY8Wp1hftio9V6tn0s
	oGZj6v4ZRXoHcIWH7w2YU3ZVzkCRnPcBMiEVPMwAHZGABwneNztRHmJKwtMz/ogkvyV8qVyRcVp
	IFWfrnL4oHEF2rAKKdnuWRt93eIyDYEKAyDmJaHGU3Rj8J4LLlM4b08cb4Hr5ND7OtJelYI=
X-Google-Smtp-Source: AGHT+IFyCR8YM6MYHZlh2Co1/HQCHjCvfrUUguXmsb48Z8OwvU5/EiOa5v8Hnhx4fjcjwxRKZC73BA==
X-Received: by 2002:a17:907:97c8:b0:ad2:43be:6f04 with SMTP id a640c23a62f3a-ad85b1d6bb3mr930446566b.51.1748323742493;
        Mon, 26 May 2025 22:29:02 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.132.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d0717c3sm1807896766b.65.2025.05.26.22.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 22:29:01 -0700 (PDT)
Message-ID: <651351db-e3ec-4944-8db5-e63290a578e8@gmail.com>
Date: Tue, 27 May 2025 06:30:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
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
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
 <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
 <20250527010226.GA19906@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250527010226.GA19906@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 02:02, Byungchul Park wrote:
...>> Patch 1:
>>
>> struct page {
>> 	unsigned long flags;
>> 	union {
>> 		struct_group_tagged(netmem_desc, netmem_desc) {
>> 			// same layout as before
>> 			...
>> 			struct page_pool *pp;
>> 			...
>> 		};
> 
> This part will be gone shortly.  The matters come from absence of this
> part.

Right, the problem is not having an explicit netmem_desc in struct
page and not using struct netmem_desc in all relevant helpers.

>> struct net_iov {
>> 	unsigned long flags_padding;
>> 	union {
>> 		struct {
>> 			// same layout as in page + build asserts;
>> 			...
>> 			struct page_pool *pp;
>> 			...
>> 		};
>> 		struct netmem_desc desc;
>> 	};
>> };
>>
>> struct netmem_desc *page_to_netmem_desc(struct page *page)
>> {
>> 	return &page->netmem_desc;
> 
> page will not have any netmem things in it after this, that matters.

Ok, the question is where are you going to stash the fields?
We still need space to store them. Are you going to do the
indirection mm folks want?

AFAIK, the plan is that in the end pages will still have
netmem_desc but through an indirection. E.g.

static inline bool page_pool_page_is_pp(struct page *page)
{
	return page->page_type == PAGE_PP_NET;
}

struct netmem_desc *page_to_netmem_desc(struct page *page)
{
	return page->page_private;
}

-- 
Pavel Begunkov


