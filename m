Return-Path: <bpf+bounces-74745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED73C65088
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61924364341
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5352BFC73;
	Mon, 17 Nov 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRN9ah8J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CF275112;
	Mon, 17 Nov 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395356; cv=none; b=jSDtHw/hdbkl6T7c5Dc6HUHPxnEZrpa2Cj5uMFUeoDBJ7EvP2sRN5HgjGc9803MPawbwjcKN8M7rBCxq2423TWWt663Oa/hR2aJHWRNtxWV8aoTx0W+QiOcrj7Y3m2jjLoLi+efgrSQm4dxxayRsYkizS/t5Nlmudb+Jclcn6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395356; c=relaxed/simple;
	bh=Jkvmu4Q+7pA4zSpi9OFk7bJIcNsGVtBgomWoRKHdM8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiOgSsI2eqbl74C4bSuy/TPaZTkMRXo/4xY7Z8GI1w2F788Cb2YwXBG61+3gwQ+Hxxo+C4JBctF9ZT0nW16cy9taYfEegJ3hkilbIqEjJES7qjcaFTpZfP46+m86Ah20yV7O0DopogY9DbvwpPZfmi8CyOQUl960R1kn4USabnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRN9ah8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B502C113D0;
	Mon, 17 Nov 2025 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395356;
	bh=Jkvmu4Q+7pA4zSpi9OFk7bJIcNsGVtBgomWoRKHdM8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HRN9ah8J0i3UDd6igt5wSrmwF/x03+POYYvvNYin0MqGa7LWADEznY83zaPtwUDRs
	 ScnopSM94D7deN4mSE1KVPZzP934yzIg+LXrta6j2nrouhyFH8av2u/a0qRtna5hcS
	 25x8yxJl/uczThIH67MpaOJdwwfBJbiJeFru+UKaP8JGt3PlkKh4hRQ652Cb9cKrPs
	 E2r8M8rZOR3hxKd5EgzdfshSFNvH8gXZCEuOUMYRte20uezKAeZzYovSXDLoq6Ifp0
	 HcHsxX7esNJloZeJSP6iRggCBQFjamV20khnzZ5sVK1x/n1QLcw8tOqAiGCv274hvX
	 8cuBHc5tDmKWQ==
Message-ID: <f25a95a4-5371-40bd-8cc8-d5f7ede9a6ac@kernel.org>
Date: Mon, 17 Nov 2025 17:02:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
References: <20251117052041.52143-1-byungchul@sk.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251117052041.52143-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/11/2025 06.20, Byungchul Park wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 600d9e981c23..01dd14123065 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
>   #ifdef CONFIG_MEMCG
>   			page->memcg_data |
>   #endif
> -			page_pool_page_is_pp(page) |
>   			(page->flags.f & check_flags)))
>   		return false;
>   
> @@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>   	if (unlikely(page->memcg_data))
>   		bad_reason = "page still charged to cgroup";
>   #endif
> -	if (unlikely(page_pool_page_is_pp(page)))
> -		bad_reason = "page_pool leak";
>   	return bad_reason;
>   }

This code have helped us catch leaks in the past.
When this happens the result is that the page is marked as a bad page.

>   
> @@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
>   		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>   		folio->mapping = NULL;
>   	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		/* networking expects to clear its page type before releasing */
> +		WARN_ON_ONCE(PageNetpp(page));
>   		/* Reset the page_type (which overlays _mapcount) */
>   		page->page_type = UINT_MAX;
> +	}
>   
>   	if (is_check_pages_enabled()) {
>   		if (free_page_is_bad(page))

What happens to the page? ... when it gets marked with:
   page->page_type = UINT_MAX

Will it get freed and allowed to be used by others?
- if so it can result in other hard-to-catch bugs

--Jesper


