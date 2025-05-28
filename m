Return-Path: <bpf+bounces-59168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E3AC67BE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFF44E271F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961227A44C;
	Wed, 28 May 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYTjBW9f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDE24469C;
	Wed, 28 May 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429605; cv=none; b=PM5MwgPH5r+kVF18IJG1911vRChLSKIJP364Rk6lofqPJjQxrIaF8yWrCM21MgnHbac2C/Mucba5OYbv2kFO8zBmQev/waEgvtmrUMQgLk27DiRByMzb4jMUsCrGqfETNIuITzDX8Upa0GTwomWcYHOpOV9y/5UpEBHJl08RlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429605; c=relaxed/simple;
	bh=0DTV0Ky9bIM8bS7kyApFrZI3E0D6TUzFXijk1QKkznk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwGFXtaMHtWe7WfeCQq7gmYR5O+gAnWQc5/npWzzi8sspLKXxxQXR33nHS+oOmOdoTRzveEjiK48fAcAhyJ8ryFpGU3QEQS5TQI2ynqY0tgSE0oC0NLTIReacBuEQ3hJNffqnhz8FM4tQEJj0YTx4FCdgQd6C4Jll5dyyDvMJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYTjBW9f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad89333d603so282503166b.2;
        Wed, 28 May 2025 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748429601; x=1749034401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOl96J3LmgA6Ak3DKn38V5XEN+41BOvGEplgp1Zan1A=;
        b=FYTjBW9fNBdmYWit21d1zPTcLE1M1ZmRFzcNUNnKR7L7kGBUpBJqQ04NOcyZVfnCvD
         KQCPAATQJGi97uw8iv9rilOcf/M9kDqPkhVoQkw7Kgs+dnNBVq3oitXPzZ7Aj8YBv7ej
         CVZamFh0936Rr/mXgEzXpXIUUSv5j2SdGWzZ1Wf2z+xcGaQ9vrg9g5Wi4jfGZVLoxHv+
         DBN/7pmyufk6KMBA26n7RGYLdCcTH89d+G53r+ZEOQVkIkPpHTHlxcbCSFeW1ZGfw62Y
         5E4VjNGQ68JR9E9Eu8iExnC0dy2U1DyMFkB61WT9OuiPQRAUPkom0u05SHqQO2S/6L/+
         pQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748429601; x=1749034401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOl96J3LmgA6Ak3DKn38V5XEN+41BOvGEplgp1Zan1A=;
        b=RvgVpcIeley+nKR6wApVqa3UUlr7Qstk/rxHWWinnnz3BAq9EEm/kQhA4lSnLvaR7U
         1hOhrHtZ2/2l1B9+wkYi6o8iCA1SjrmkzRpdp6HZ2aBbpPUPYizawo0zbsB8hAyCeW5p
         GLyGq932+ADaZ3+oOkKY2btCmddP1OmAHGo3pV1Xngx6hQ/ZsVUNHplQuCwuzltI+62t
         qqnwzxmP25e8rN5ZRfPM/VAXeDvy9h/YQVHCLrLmLkGTFdYcLvRTM05zzr99CHeAwVzn
         7YneWhzYUlh4sqPVdjIeB1Nwf8WUZzNYqezid03zrwQ7mufUMjW4uPfaE842QD6vEQVN
         NvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7e2eNDS1S4gEQ50iSR2j5du9rfgf88HVnA/hvSDwVI+M9VtEPFwjGq0eluIIlQEdI1O3FcJd3wgBTYQ==@vger.kernel.org, AJvYcCVImI3Kh+50Kpy2lZJ8QwJKpAWVE6Dmn6ouziBnacuouTyy7lUwJCbLa0VafGfBm9vNp4g+6hsOn708qNS0@vger.kernel.org, AJvYcCVXIrcYb8LBOids6pAHwyOjyDSgjbWxTAAo/DmGMXd2oXuaKHY8DC0hqNYiXIbyBOMtbOY=@vger.kernel.org, AJvYcCWavx4uumLVoZ5CAP1z1zgfXFDuk/kN29Hdp+yBQd9xi7U8aTS+mPFz0tAvURIz/h52GygYSyvu@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYOjzEHVr73bNve4IGz0MKOU6G8TUtKSGvgZQIU6OLNBVij/j
	mAZNksPE/BIVQaRjmdo4Shr/KJztLSdukkkoHcSZXgczYb/IpYHSiXF8
X-Gm-Gg: ASbGncvA3WujFl53HTHaP9M+YthJ53Tp9/3xhHRAgN42wnuOPXTC/byHQSGRMpwLgmP
	wp+GaNRCtIbmahxgSTpOT2d9Y7SntxG1ruotuUkx5bS0e2cE1jO9M6NB531a9m5Hnsth0kc0ZHv
	5+QcQ/RLKMUiJpnMhz/vLm7Hj0UeyFIXxUf9kChynuC3mA3s/penEtzNTn5SmK4ITvU7SVikDKg
	vIbBXoeh87ldxCht/1wD3xdmRGMSs0fj8k8C1WgCVN+bRpsD0/lalg4JJJ4SIAWDi+a+HPqD2Hz
	6u41XP0NxKRUEkgwqfr8Hf2s01b19urwNWYGNovohRMy/ucr/TnsifRmmoXkKwWZUbESpO2WsA=
	=
X-Google-Smtp-Source: AGHT+IGGeaG2q6yiRCGKlMaEsjWEAbQ2Wph3QFfKs9+YPs2wDpdHuzbueeZ4on9DqutvyWs9sW0vQg==
X-Received: by 2002:a17:907:c0d:b0:ad8:8ac5:c75e with SMTP id a640c23a62f3a-ad88ac5c8efmr521637866b.60.1748429601091;
        Wed, 28 May 2025 03:53:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b477bfsm86531666b.129.2025.05.28.03.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 03:53:20 -0700 (PDT)
Message-ID: <11568ebd-4c00-463e-a2ca-5c75dbd625ef@gmail.com>
Date: Wed, 28 May 2025 11:54:32 +0100
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
References: <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
 <20250528081403.GA28116@system.software.com>
 <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
 <20250528091416.GA54984@system.software.com>
 <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
 <20250528093303.GB54984@system.software.com>
 <5494b37d-1af0-488e-904b-2d3cbd0e7dcf@gmail.com>
 <20250528104440.GA13050@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528104440.GA13050@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 11:44, Byungchul Park wrote:
> On Wed, May 28, 2025 at 10:51:29AM +0100, Pavel Begunkov wrote:
>> On 5/28/25 10:33, Byungchul Park wrote:
>>> On Wed, May 28, 2025 at 10:20:29AM +0100, Pavel Begunkov wrote:
>>>> On 5/28/25 10:14, Byungchul Park wrote:
>>>>> On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
>>>>>> On 5/28/25 09:14, Byungchul Park wrote:
>>>>>>> On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
>>>>>>>> On 5/26/25 03:23, Byungchul Park wrote:
>>>>>>>>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>>>>>>>>>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> To simplify struct page, the effort to seperate its own descriptor from
>>>>>>>>>>> struct page is required and the work for page pool is on going.
>>>>>>>>>>>
>>>>>>>>>>> To achieve that, all the code should avoid accessing page pool members
>>>>>>>>>>> of struct page directly, but use safe APIs for the purpose.
>>>>>>>>>>>
>>>>>>>>>>> Use netmem_is_pp() instead of directly accessing page->pp_magic in
>>>>>>>>>>> page_pool_page_is_pp().
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       include/linux/mm.h   | 5 +----
>>>>>>>>>>>       net/core/page_pool.c | 5 +++++
>>>>>>>>>>>       2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>>>>>> index 8dc012e84033..3f7c80fb73ce 100644
>>>>>>>>>>> --- a/include/linux/mm.h
>>>>>>>>>>> +++ b/include/linux/mm.h
>>>>>>>>>>> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>>>>>>>       #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>>>>>>>
>>>>>>>>>>>       #ifdef CONFIG_PAGE_POOL
>>>>>>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>>>>>> -{
>>>>>>>>>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>>>>>>>> -}
>>>>>>>>>>
>>>>>>>>>> I vote for keeping this function as-is (do not convert it to netmem),
>>>>>>>>>> and instead modify it to access page->netmem_desc->pp_magic.
>>>>>>>>>
>>>>>>>>> Once the page pool fields are removed from struct page, struct page will
>>>>>>>>> have neither struct netmem_desc nor the fields..
>>>>>>>>>
>>>>>>>>> So it's unevitable to cast it to netmem_desc in order to refer to
>>>>>>>>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>>>>>>>>>
>>>>>>>>> Thoughts?
>>>>>>>>
>>>>>>>> Once the indirection / page shrinking is realized, the page is
>>>>>>>> supposed to have a type field, isn't it? And all pp_magic trickery
>>>>>>>> will be replaced with something like
>>>>>>>>
>>>>>>>> page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
>>>>>>>
>>>>>>> Agree, but we need a temporary solution until then.  I will use the
>>>>>>> following way for now:
>>>>>>
>>>>>> The question is what is the problem that you need another temporary
>>>>>> solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
>>>>>
>>>>> I prefer using the place-holder, but Matthew does not.  I explained it:
>>>>>
>>>>>       https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/
>>>>>
>>>>> Now, I'm going with the same way as the other approaches e.g. ptdesc.
>>>>
>>>> Sure, but that doesn't change my point
>>>
>>> What's your point?  The other appoaches do not use place-holders.  I
>>> don't get your point.
>>>
>>> As I told you, I will introduce a new struct, netmem_desc, instead of
>>> struct_group_tagged() on struct net_iov, and modify the static assert on
>>> the offsets to keep the important fields between struct page and
>>> netmem_desc.
>>>
>>> Then, is that following your point?  Or could you explain your point in
>>> more detail?  Did you say other points than these?
>>
>> Then please read the message again first. I was replying to th
>> aliasing with "lru", and even at the place you cut the message it
>> says "for example", which was followed by "You should be able to
>> do the same with the overlay option.".
> 
> With struct_group_tagged() on struct net_iov, no idea about how to.
> However, it's doable with a new separate struct, struct netmem_desc.

static inline bool page_pool_page_is_pp(struct page *page)
{
	pp_magic = page_to_netdesc(page)->pp_magic;
	return pp_magic == ...;
}

page_to_netdesc() is either casting directly in case of full page
overlays, or "&page->netdesc" for the placeholder option.

-- 
Pavel Begunkov


