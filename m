Return-Path: <bpf+bounces-74766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B30C653AE
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210AF4E725D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE72F25F4;
	Mon, 17 Nov 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4mLEid5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2D2F068F;
	Mon, 17 Nov 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398039; cv=none; b=aoGhyOf7jLKJMeYe7eBV6wWxaYHoprUnLhNtBqn/XD71OmV1V9uMp7lTofZ1ZqPa6kJEhNL0YSr6grWvuuOCGtgpKy7eL3Ghw+ERsQ16ewJJ8AWSobHmsCjcLIXRpssVYIYWC9ayRJpzfn+Zr24931CrBwtrtpc1FqbPNGONJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398039; c=relaxed/simple;
	bh=VDPU8WBpaSMdog+Adn5C5R/6IBPWeQhuaPBSI4eT7Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAsAYPEaQjJEAOlb8qYfBp+dHLWMMeBcO3WBARYh5YacGJws6ma3E+kL1UZgUaoq/ezXZCqPOLBJXoXUmtlCugw8FJXXJBoMZhrMTB1OGQ3ZVd9J592Dz4L4YCU8bkWl8ETymCLZZlPjD1rPefLzNGgKfT62KUtXAO9R5kH18Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4mLEid5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818FDC4AF0B;
	Mon, 17 Nov 2025 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398039;
	bh=VDPU8WBpaSMdog+Adn5C5R/6IBPWeQhuaPBSI4eT7Ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I4mLEid5UB2vfOwQXMYCyyiehnTm4dhzeg8ijCEtfD2upmwu1wXdOEhJ+MLKn5PyL
	 XWjEQLi4Gkzt61V91UBFEXN4IvveVwebdp3HmwNGmDyTT3QB4mXI5bbIo+K+MmoMNn
	 LgsO/tTrW0XgeARy9TG+bmFaCZbslP/UdD/1PnRitn2CLZfBffpDBprSsOJ/9yJEL0
	 5G7QezrhBDd/ytSQhI+YTKE0+c7cXgDd5CnuaNKFtHucUrNJE4J+3snXSh/O5y+7ju
	 5mJjRxcNDM8F9XTrK87uvomDx9F2hDcRKfm4olTCbOTtGNf6+tq4xFxicNH+bG1uM4
	 6zkTWIT+Y7vaQ==
Message-ID: <e470c73a-9867-4387-9a9a-a63cd3b2654f@kernel.org>
Date: Mon, 17 Nov 2025 17:47:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
References: <20251117052041.52143-1-byungchul@sk.com>
 <f25a95a4-5371-40bd-8cc8-d5f7ede9a6ac@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <f25a95a4-5371-40bd-8cc8-d5f7ede9a6ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.11.25 17:02, Jesper Dangaard Brouer wrote:
> 
> On 17/11/2025 06.20, Byungchul Park wrote:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 600d9e981c23..01dd14123065 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
>>    #ifdef CONFIG_MEMCG
>>    			page->memcg_data |
>>    #endif
>> -			page_pool_page_is_pp(page) |
>>    			(page->flags.f & check_flags)))
>>    		return false;
>>    
>> @@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>    	if (unlikely(page->memcg_data))
>>    		bad_reason = "page still charged to cgroup";
>>    #endif
>> -	if (unlikely(page_pool_page_is_pp(page)))
>> -		bad_reason = "page_pool leak";
>>    	return bad_reason;
>>    }
> 
> This code have helped us catch leaks in the past.
> When this happens the result is that the page is marked as a bad page.
> 
>>    
>> @@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
>>    		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>    		folio->mapping = NULL;
>>    	}
>> -	if (unlikely(page_has_type(page)))
>> +	if (unlikely(page_has_type(page))) {
>> +		/* networking expects to clear its page type before releasing */
>> +		WARN_ON_ONCE(PageNetpp(page));
>>    		/* Reset the page_type (which overlays _mapcount) */
>>    		page->page_type = UINT_MAX;
>> +	}
>>    
>>    	if (is_check_pages_enabled()) {
>>    		if (free_page_is_bad(page))
> 
> What happens to the page? ... when it gets marked with:
>     page->page_type = UINT_MAX
> 
> Will it get freed and allowed to be used by others?
> - if so it can result in other hard-to-catch bugs

Yes, just like most other use-after-free from any other subsystem in the 
kernel :)

The expectation is that such BUGs are found early during testing 
(triggering a WARN) such that they can be fixed early.

But we could also report a bad page here and just stop (return false).

-- 
Cheers

David

