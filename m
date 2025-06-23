Return-Path: <bpf+bounces-61279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A7AE3DDA
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9BE1896723
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230A23ED58;
	Mon, 23 Jun 2025 11:25:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BDAD2C;
	Mon, 23 Jun 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677944; cv=none; b=KqrEs2MjPXcH2QvUPkccMEjLBU5JXgq//xGzARWtqwr6zmfX5FvCOaYMpZ5ev3lgPweR4T9iGiq7rCYhNJLSdKkQIDoxF87WwE7HwdOtY2m1NICwL9ue35EUPmHp6pTXfCSrPpD39b1dBGZt7ZL3xou+dZqC4CxYorgfyh+4OaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677944; c=relaxed/simple;
	bh=AfGEXRx1HFoQszR4uv7ffzuBfSxCOCFfR097o41bj/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE9q6IJUCW2iWWeDkNP1MFuzcRSyWQ4eC1xkoYUVQEnwu+e0n7Xt/uvUgNmZuHyCsm9qf7dgRENlzFzCUcNlH4sg/BsW0oWYPD6QlASDSxaL1+m6AvFbAB72+fc8yXsd+rt2PIhK7y6HO9DO3FjlWsclAGnSy41B4KA0OEsgQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-80-685939af5f24
Date: Mon, 23 Jun 2025 20:25:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, jackmanb@google.com
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250623112530.GA67291@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfec3E5OK7bm1bCKgrpjtETiFQf4hAI0dWKyNVObTSnzLx1
	tZQi03UVclqtxDQtlkud5oVa1jQDxUpnmpqpXTTFmWNeqJwS+e3H/7n8ng8PR8kLaF9Oozsu
	6nVKrYKRYulP7/srzBv2qld/bg6ATPMjBvLdcZDTUUJDZl4xgl8jLSwMVdkZyLrnoiCzLgnD
	sHmUgu7XnSzkW0Kg/UEPhvKLVgo6r1QzkJo0RkHFSD8L50tyJVBfbKDh5mg2BdaEDhbePctk
	oO3RHxp6bKkYaowPMbQbNsJr0xxw1fYhqDJbJeBKuc3AjQYTA1+S2hE0vOzEkHHOgMBc6aBh
	zD2xI+NVG7txsfCyb4ASCh82S4RS4ydWMFmihae5AUKyo4ESLHmXGMHivM4KrY3ljFB9awwL
	pSVDEiE1sZ8RBrs/YmGg8gMjmAs/YOGtqYrd5rNPGqQStZoYUb8qOEyqLsgaxpEXF8f1PvmF
	EtCP+cnIiyN8IDE4UyXJiJtkd85JT4z5JaSt/TvtYYZfShyOEcrDs3g/UmsYn2ApR/GFDHly
	oZH1FGbycWSss2eyScYDybFWTrKcdyOSXRkylfuQmvQu7GGKX05Ki1oZj5eaWJrzm5uK/Uli
	UcbkqBcfTJzJKYyHZ/OLyPNiu8TjJXw1R8rL7kim7p9HXuQ68FXkY5ymME5TGP8rjNMUJoTz
	kFyjiwlXarSBK9XxOk3cysMR4RY08UgPTo/vL0HO+h02xHNI4S0L8w5Vy2llTFR8uA0RjlLM
	ktk271bLZSpl/AlRH3FQH60Vo2zIj8OKubK1rliVnD+qPC4eE8VIUf+vKuG8fBPQwi3SA017
	dDU7034k9W7KLvKveL87xHtR6Fb786D0xFPRdGL9Hzt7ZHvZ4GWtG6s+nr7RGzuybmBBBTNj
	8BvvsyqWX9qRb695nPXG3WKN7N4ubaKO1DVdvhL4NdLrbmPo2TNH026LTl+p09VF26+lrJ/b
	WDacrvq82ly7bFdX86FYBY5SK9cEUPoo5V98/A9vRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo6jyXGtPGkoLCWKsoSiJ5KIoHpJ7OKHLn6xUx7c8tpW
	4orEUoqW85JBNmcpovOWszWdE5OY5iUha6JYmStv2AUrb8xWmVMiv/34/5/n93x5aEKaL/Sj
	lYkXeVUiFy+nxKT4yJ6MrabdpxXbf3+XgcFUQ0G1KxWMHxqFYKhqQDAz/04E020dFJSWzBFg
	6MkkYdb0k4Cx9mERVJsjwFk+TkLzTSsBwzmdFOgy3QQ8nZ8UwfXGCgG0FnUJ4VVDthDu/iwj
	wJr+QQS9TQYKhmoWhDBu15HQpa8kwZm9D9qL18Jc91cEbSarAOayiijIdxRTMJLpROBoHSah
	8Fo2AlPLgBDcrkVH4fMh0b5g3Pr1G4EtlW8E2KZ/L8LF5kv4ScVmrB1wENhcdYvC5qk7IjzY
	30zhzgI3iW2N0wKsy5ik8I+xtyT+1tJH4dKJ7wJssvSRx6RR4rAYPl6Zwqu27T0jVjwunSWT
	bwalfqmbQeno83otommW2cG6jFe0yIsmmWB2yPlJ6GGK2cgODMwTHpYx/mx39q9FFtMEY6HY
	uhv9Ik+xmkll3cPjS0MSBlijtWWJpYwLsWUtEcu5D9t1f5T0MMFsYW31g5TnLrEoNf6hl+NA
	NqO+cGnVi9nLTmmzKA+vYTawzxo6BLnIW7/CpF9h0v836VeYihFZhWTKxJQEThm/M0Qdp9Ak
	KlNDziUlmNHiq5Rf/ZXXiGZ6D9kRQyP5KklF+CmFVMilqDUJdsTShFwmse8/oZBKYjjNZV6V
	FK26FM+r7cifJuW+ksMn+TNSJpa7yMfxfDKv+tcKaC+/dFT7zK+nhObqIrW3w9odj3S6Wlpl
	Dts1FyOHkuM5nxb85WKfAwsf86IdvLXpxbrZAE1kR6/hbOiUZSQvqFl2nmp4520rnKQv2Hzv
	HfTSkOGDac6q8LyXORO8vKBAEJWw6ZDe3VH9AM/8jnVVjFpyHwYe9ePK0npf7++vDFhnlJNq
	BRe6mVCpub9KbC+1JgMAAA==
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 07:13:21AM -0400, Zi Yan wrote:
> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
> > On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
> >> On 20.06.25 06:12, Byungchul Park wrote:
> >>> To simplify struct page, the effort to separate its own descriptor from
> >>> struct page is required and the work for page pool is on going.
> >>>
> >>> To achieve that, all the code should avoid directly accessing page pool
> >>> members of struct page.
> >>>
> >>> Access ->pp_magic through struct netmem_desc instead of directly
> >>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> >>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> >>> without header dependency issue.
> >>>
> >>> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> >>> Reviewed-by: Mina Almasry <almasrymina@google.com>
> >>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> >>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> >>> ---
> >>>   include/linux/mm.h   | 12 ------------
> >>>   include/net/netmem.h | 14 ++++++++++++++
> >>>   mm/page_alloc.c      |  1 +
> >>>   3 files changed, 15 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 0ef2ba0c667a..0b7f7f998085 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >>>    */
> >>>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >>>
> >>> -#ifdef CONFIG_PAGE_POOL
> >>> -static inline bool page_pool_page_is_pp(struct page *page)
> >>> -{
> >>> -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >>> -}
> >>> -#else
> >>> -static inline bool page_pool_page_is_pp(struct page *page)
> >>> -{
> >>> -     return false;
> >>> -}
> >>> -#endif
> >>> -
> >>>   #endif /* _LINUX_MM_H */
> >>> diff --git a/include/net/netmem.h b/include/net/netmem.h
> >>> index d49ed49d250b..3d1b1dfc9ba5 100644
> >>> --- a/include/net/netmem.h
> >>> +++ b/include/net/netmem.h
> >>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> >>>    */
> >>>   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> >>>
> >>> +#ifdef CONFIG_PAGE_POOL
> >>> +static inline bool page_pool_page_is_pp(struct page *page)
> >>> +{
> >>> +     struct netmem_desc *desc = (struct netmem_desc *)page;
> >>> +
> >>> +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >>> +}
> >>> +#else
> >>> +static inline bool page_pool_page_is_pp(struct page *page)
> >>> +{
> >>> +     return false;
> >>> +}
> >>> +#endif
> >>
> >> I wonder how helpful this cleanup is long-term.
> >>
> >> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
> >
> > Yes.
> >
> >> There, we want to make sure that no pagepool page is ever returned to
> >> the buddy.
> >>
> >> How reasonable is this sanity check to have long-term? Wouldn't we be
> >> able to check that on some higher-level freeing path?
> >>
> >> The reason I am commenting is that once we decouple "struct page" from
> >> "struct netmem_desc", we'd have to lookup here the corresponding "struct
> >> netmem_desc".
> >>
> >> ... but at that point here (when we free the actual pages), the "struct
> >> netmem_desc" would likely already have been freed separately (remember:
> >> it will be dynamically allocated).
> >>
> >> With that in mind:
> >>
> >> 1) Is there a higher level "struct netmem_desc" freeing path where we
> >> could check that instead, so we don't have to cast from pages to
> >> netmem_desc at all.
> >
> > I also thought it's too paranoiac.  However, I thought it's other issue
> > than this work.  That's why I left the API as is for now, it can be gone
> > once we get convinced the check is unnecessary in deep buddy.  Wrong?
> >
> >> 2) How valuable are these sanity checks deep in the buddy?
> >
> > That was also what I felt weird on.
> 
> It seems very useful when I asked last time[1]:
> 
> |> We have actually used this at Cloudflare to catch some page_pool bugs.

Indeed..  So I think it'd be better to leave the check as is until we
will be fully convinced on that issue, I ideally agree with David's
opinion tho.

	Byungchul

> [1] https://lore.kernel.org/linux-mm/4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org/
> 
> --
> Best Regards,
> Yan, Zi

