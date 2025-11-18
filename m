Return-Path: <bpf+bounces-74934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99212C689F8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E36114E4B2B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548193218BA;
	Tue, 18 Nov 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaA+AYng"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4D30EF74;
	Tue, 18 Nov 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458926; cv=none; b=DOR6e41diBfPo0/R8ayEBOV6H6iUfYG9q3UlkZDP56htZk8PdUFR/kE9Z0Lvl5CDR24/RuKPn0Z3vPHVOWMukKmIVtYwYZqIdgK1rm4/iw9jde5lrHqFYYzs1J8TOVyftrXmv+fjiOdAc4oMpbvW1Xnmahdi1Iw+mMVfaQ2RWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458926; c=relaxed/simple;
	bh=XyKAd9WucePUC1o/tFCBrcsIQcxe4TH5h4/fR4SzmsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktfqvEFWIS1M4HgbGW1Oh7rle55SsUiM/EpFOENadaEa+4WGv6gBfDaEumueRSic/T0ZFHGTUks0OIL51W2+sNx9Bs68RzaQsjd4JxyctYa+EQYOUFLa1v4TYwZ2kgn5yx6SL9iCX5NjxVOBZwfGl9ZuegRZYje4CibzJiEmO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaA+AYng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBD7C2BCB4;
	Tue, 18 Nov 2025 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763458926;
	bh=XyKAd9WucePUC1o/tFCBrcsIQcxe4TH5h4/fR4SzmsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iaA+AYnggzz+CZqxx89XQw14uDM8FmexD7ADNtIFpDkZZsEo8nGRYo1cnrQQ6eT4G
	 6B0l0HscHNkDSEOQ7srUciuf8b7DO3nhjEtpWM9zOdZBJcgyj/np08+4nMGYKmsg6k
	 HeRCsMeqoyn8imUAqYCsfCT3ZlbBGtAw55n4Y2QnqgdlU1x3Z/W+qIYX6nPP9LLmSF
	 SmyYM8rXRXIVacLyyHPRQzhDot45uG9g7Fq5Smro3mnkgviJ4PHq+rYuHEY+2ub9W9
	 zf/HNuqQadKct23H1zSUg+W3WuZJVmNLO8KKQ1rWolFkgWgn6/S8tWonQonFbCtQFt
	 5WJUgDQrtjMKA==
Message-ID: <ea294b1d-7698-4f67-abd5-a7b9b67db6bb@kernel.org>
Date: Tue, 18 Nov 2025 10:41:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
To: Byungchul Park <byungchul@sk.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
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
 <e470c73a-9867-4387-9a9a-a63cd3b2654f@kernel.org>
 <20251118010735.GA73807@system.software.com>
 <20251118011831.GA7184@system.software.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251118011831.GA7184@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 18/11/2025 02.18, Byungchul Park wrote:
> On Tue, Nov 18, 2025 at 10:07:35AM +0900, Byungchul Park wrote:
>> On Mon, Nov 17, 2025 at 05:47:05PM +0100, David Hildenbrand (Red Hat) wrote:
>>> On 17.11.25 17:02, Jesper Dangaard Brouer wrote:
>>>>
>>>> On 17/11/2025 06.20, Byungchul Park wrote:
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 600d9e981c23..01dd14123065 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
>>>>>     #ifdef CONFIG_MEMCG
>>>>>                       page->memcg_data |
>>>>>     #endif
>>>>> -                    page_pool_page_is_pp(page) |
>>>>>                       (page->flags.f & check_flags)))
>>>>>               return false;
>>>>>
>>>>> @@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>>>>       if (unlikely(page->memcg_data))
>>>>>               bad_reason = "page still charged to cgroup";
>>>>>     #endif
>>>>> -    if (unlikely(page_pool_page_is_pp(page)))
>>>>> -            bad_reason = "page_pool leak";
>>>>>       return bad_reason;
>>>>>     }
>>>>
>>>> This code have helped us catch leaks in the past.
>>>> When this happens the result is that the page is marked as a bad page.
>>>>
>>>>>
>>>>> @@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
>>>>>               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>>>               folio->mapping = NULL;
>>>>>       }
>>>>> -    if (unlikely(page_has_type(page)))
>>>>> +    if (unlikely(page_has_type(page))) {
>>>>> +            /* networking expects to clear its page type before releasing */
>>>>> +            WARN_ON_ONCE(PageNetpp(page));
>>>>>               /* Reset the page_type (which overlays _mapcount) */
>>>>>               page->page_type = UINT_MAX;
>>>>> +    }
>>>>>
>>>>>       if (is_check_pages_enabled()) {
>>>>>               if (free_page_is_bad(page))
>>>>
>>>> What happens to the page? ... when it gets marked with:
>>>>      page->page_type = UINT_MAX
>>>>
>>>> Will it get freed and allowed to be used by others?
>>>> - if so it can result in other hard-to-catch bugs
>>>
>>> Yes, just like most other use-after-free from any other subsystem in the
>>> kernel :)
>>>
>>> The expectation is that such BUGs are found early during testing
>>> (triggering a WARN) such that they can be fixed early.
>>>
>>> But we could also report a bad page here and just stop (return false).

I agree, that we want to catch these bugs early by triggering a WARN.
The bad_page() call also triggers dump_stack() and have a burst limiter,
which I like.  We are running with CONFIG_DEBUG_VM=y in production (as
the measured overhead was minimal) to monitor these kind of leaks.

For the case with page_pool, we *could* recover more gracefully, by
returning the page to the page_pool (page->pp) instance.  But I'm
reluctant to taking this path, as that puts less pressure on fixing the
leak as we "recovered", as this becomes are warning and not a bug.
Opinions are welcomed, should we recover or do bad_page() ?


>>
>> I think the WARN_ON_ONCE() makes the problematic situation detectable.
>> However, if we should prevent the page from being used on the detection,
>> sure, I can update the patch.
> 
> I will respin with the following diff folded on the top.

LGTM

> 	Byungchul
> ---
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 01dd14123065..5ae55a5d7b5d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1377,7 +1377,10 @@ __always_inline bool free_pages_prepare(struct page *page,
>   	}
>   	if (unlikely(page_has_type(page))) {
>   		/* networking expects to clear its page type before releasing */
> -		WARN_ON_ONCE(PageNetpp(page));
> +		if (unlikely(PageNetpp(page))) {
> +			bad_page(page, "page_pool leak");
> +			return false;
> +		}
>   		/* Reset the page_type (which overlays _mapcount) */
>   		page->page_type = UINT_MAX;
>   	}
> 
>>
>> Thanks,
>> 	Byungchul
>>
>>>
>>> --
>>> Cheers
>>>
>>> David

--Jesper

