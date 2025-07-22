Return-Path: <bpf+bounces-63976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802DB0CF3F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A0D7B217B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691A1B4F08;
	Tue, 22 Jul 2025 01:43:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAD136352;
	Tue, 22 Jul 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148618; cv=none; b=OKPsSGjLuCq9NDM2OJx6/5dex5EV2v/qAtGTMZH7UAwHV9Jzi0BgMrj3NR6oUxoYX3El2hD1YdJIqK4y44pO7ttj/8KO7gBPUUlQcTY26hE/vQyN/ypwZ3jmBH2hAwQQbXtTdWuyAIeJ9wQGDdn+VcOEMXRxlcu2xrNmIQ4ElFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148618; c=relaxed/simple;
	bh=O0f72AeS2+d8kuid8fIMbCgnJiDK2N8K0JsBhWYe+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR1e7yTfo3Dl7LMFLxFwhnQMndTAR9CUJGY6lzdITfl8PVxsYbHGsLMmfHjJOKdnBceHdMJSSCeIhoj5wXzpCn9X/YrNzzRQw6yc8y2f9pvKBUZrfMhqX+6tdoaoaoJh2xmS7rwkV6efB69HmlB8eaS/1kSNSOu+uJkJy6ci8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c0-687ee811fc6c
Date: Tue, 22 Jul 2025 10:23:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	David Hildenbrand <david@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250722012324.GA63367@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
 <20250717030858.GA26168@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717030858.GA26168@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe897ds5xOTqt25t9iWVURmUR8RQlSRQnQgqCsKLLIQ9tNJds
	zktlrDQqzRUZpHPBKvIyq8UUnWWWy7xkkBnmSs3Q1OwyTW14Kc0pUd/+/B7+P/4fHg4rs2RB
	nEYXK+l1olbFyGn598CbK5SfT6tDe67TYHXcZaBgKAFyP7pkYLUXIxgcbmZhoLKagds3fRis
	r1Jo+OkYwdBZ1c5CgTMC2nK6aCg7X4Kh/XINA+kpoxgeD3tZOOvKo6C+2CyDayN3MJSYPrLw
	5qGVgQ93x2XQ5U6nodaST0ObeTNU2eaCr+4bgkpHCQW+SzcYyGiwMdCR0oag4Vk7DdlnzAgc
	5R4ZjA5NOLKff2A3BwvPvvVioSj/HSWUWlpZweY0CoV5IUKqpwELTvtFRnD2X2WFlrdljFCT
	OUoLpa4BSkhP9jLCj873tNBb3sgIjqJGWnhpq2R3zdwn3xglaTVxkn5V2GG5+ndWD46p2JIw
	ONyNTah/TSoK4Ai/llwoq2P/5suWC8ifaX4x6fRmTHKGX0I8nmHsz7P55eRrk3uSY76JITnO
	sFTEcbP4BGKvY/xYwQO5cm+QSkVyTsmXUsTUNUZNHWaS2qxP9FQ3hHjGeih/F/MLSO4Y58cB
	/HrS2uydnDCHX0SeFldPeghfxpGe5GQ8tXM+qcjz0FcQb/lPa/lPa/mntSFsR0qNLi5a1GjX
	rlQn6jQJK48cj3aiiYfJSfq134X663e7Ec8hVaBioem0WikT4wyJ0W5EOKyarfA9mkCKKDHx
	hKQ/fkhv1EoGN1rA0ap5ijW++Cglf1SMlY5JUoyk/3uluIAgEwoPI2JaZH2n+eQXh3jgYPrL
	dTr9/T7vtIubHgRuUMSEu3b4moL3J41at32PtG7a87oNFf7O39u+s7wwfvv0oWUd+XWatODe
	s1Wv+rZ2Zxorbp2ruT9irql9YYwNHV/9qSU87UmjQTnmTDSff2y0Tn9duHCFprv5lNYekYR7
	l86oKlLRBrW4OgTrDeIf+ikpuSwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z//2dlxODgus0NG1LpiaSUJbyZmiHgQzC4fggpy6KEt54xt
	6pYZq4RqeSsjcmmsLKtpjJbpNBWb9/xgLKpVlqJ5K9Eua6gryxlR3x5+D7+H98NLY4mXXEor
	VFperZIppZSIFO3afiY0YOykfLP72TIos1ZTUDWtgzsDdgGUWWoRuGfeCuFbWycFFTc8GMp6
	80j4bp3FMNwxKIQqWyL0V46Q0Hi2DsNgURcFBXleDE0zk0I4bb9LQGt5twCe1RYK4PLsbQx1
	hgEhPG8oo+B99S8BjDgKSOg23SOhvzAGOsxB4OmZQNBmrSPAk19OQYnTTMFQXj8CZ+sgCddO
	FSKwNrsE4J2e37jW/l4Ys4ZrnZjCXM291wRXb3on5My2TO7h3RDO6HJizmY5T3G2r5eEXN/L
	RorruuoluXr7N4IrODNJcV+G35DcVPMLiqsY+0xw1poX5G7JAVFUKq9UZPHqTdHJIvnP0nF8
	7Emszj0zig3oa7gR+dEss5UtMp1Dvkwya9jhyRKhL1PMOtblmsG+HMhsYD+9cixwzLyi2Epb
	tBHR9CJGx1p6KB8WM8AW33cTRiSiJUw9wRpG5og/RQDbXfqB/OOGsK65ccLnYiaYvTNH+7Af
	s41993Zy4YTFzCq2pbaTKEZi03+26T/b9M82I2xBgQpVVrpMoYwI06TJ9SqFLiwlI92G5l+i
	MvfHRTtyP493IIZGUn/xCsNJuUQgy9Lo0x2IpbE0UOx5PI/EqTL9cV6dcVidqeQ1DhRMk9Il
	4oT9fLKEOSLT8mk8f4xX/20J2m+pAQX2xo/lSx9pG77soFN2XpDGmde3ez5GHtw1pcxpSQmK
	OpTB74vXX99bHj6bO5bgbexOXPnAnfRUs8qQfSppKKm603mz1Ju91qHbbo3Fe66PXmm1xFWs
	PkEmRIaOZxst7vJm87S+aXnOLWf48q6ACEKbqN14dJ9xSXvoFf8+byWWkhq5bEsIVmtkvwGE
	lkgtDgMAAA==
X-CFilter-Loop: Reflected

On Thu, Jul 17, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 02:58:14PM +0100, Pavel Begunkov wrote:
> > On 7/11/25 02:14, Byungchul Park wrote:
> > ...>>> +#ifdef CONFIG_PAGE_POOL
> > > > > +/* XXX: This would better be moved to mm, once mm gets its way to
> > > > > + * identify the type of page for page pool.
> > > > > + */
> > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > +{
> > > > > +       struct netmem_desc *desc = page_to_nmdesc(page);
> > > > > +
> > > > > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > +}
> > > > 
> > > > pages can be pp pages (where they have pp fields inside of them) or
> > > > non-pp pages (where they don't have pp fields inside them, because
> > > > they were never allocated from the page_pool).
> > > > 
> > > > Casting a page to a netmem_desc, and then checking if the page was a
> > > > pp page doesn't makes sense to me on a fundamental level. The
> > > > netmem_desc is only valid if the page was a pp page in the first
> > > > place. Maybe page_to_nmdesc should reject the cast if the page is not
> > > > a pp page or something.
> > > 
> > > Right, as you already know, the current mainline code already has the
> > > same problem but we've been using the werid way so far, in other words,
> > > mm code is checking if it's a pp page or not by using ->pp_magic, but
> > > it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
> > > 
> > > Both the mainline code and this patch can make sense *only if* it's
> > > actually a pp page.  It's unevitable until mm provides a way to identify
> > > the type of page for page pool.  Thoughts?
> > Question to mm folks, can we add a new PGTY for page pool and use
> > that to filter page pool originated pages? Like in the incomplete
> > and untested diff below?
> > 
> > 
> > commit 8fc2347fb3ff4a3fc7929c70a5a21e1128935d4a
> > Author: Pavel Begunkov <asml.silence@gmail.com>
> > Date:   Sat Jul 12 14:29:52 2025 +0100
> > 
> >     net/mm: use PGTY for tracking page pool pages
> > 
> >     Currently, we use page->pp_magic to determine whether a page belongs to
> >     a page pool. It's not ideal as the field is aliased with other page
> >     types, and thus needs to to rely on elaborated rules to work. Add a new
> >     page type for page pool.
> 
> Hi Pavel,
> 
> I need this work to be done to remove ->pp_magic in struct page.  Will
> you let me work on this work?  Or can you please refine and post this

No response I got.  Thus, I started.  I hope you understand.

	Byungchul

> work?  If you let me, I will go for this as a separate patch from this
> series.
> 
> 	Byungchul
> 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0ef2ba0c667a..975a013f1f17 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4175,7 +4175,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >  #ifdef CONFIG_PAGE_POOL
> >  static inline bool page_pool_page_is_pp(struct page *page)
> >  {
> > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +       return PageNetpp(page);
> >  }
> >  #else
> >  static inline bool page_pool_page_is_pp(struct page *page)
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 4fe5ee67535b..9bd1dfded2fc 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -957,6 +957,7 @@ enum pagetype {
> >        PGTY_zsmalloc           = 0xf6,
> >        PGTY_unaccepted         = 0xf7,
> >        PGTY_large_kmalloc      = 0xf8,
> > +       PGTY_netpp              = 0xf9,
> > 
> >        PGTY_mapcount_underflow = 0xff
> >  };
> > @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> >  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> >  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
> > 
> > +/*
> > + * Marks page_pool allocated pages
> > + */
> > +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> > +
> >  /**
> >   * PageHuge - Determine if the page belongs to hugetlbfs
> >   * @page: The page to test.
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index de1d95f04076..20f5dbb08149 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -113,6 +113,8 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
> >   */
> >  static inline struct page *__netmem_to_page(netmem_ref netmem)
> >  {
> > +       DEBUG_NET_WARN_ON_ONCE(netmem_is_net_iov(netmem));
> > +
> >        return (__force struct page *)netmem;
> >  }
> > 
> > diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> > index cd95394399b4..e38c64da1a78 100644
> > --- a/net/core/netmem_priv.h
> > +++ b/net/core/netmem_priv.h
> > @@ -13,16 +13,11 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> >        __netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> >  }
> > 
> > -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> > -{
> > -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> > -
> > -       __netmem_clear_lsb(netmem)->pp_magic = 0;
> > -}
> > -
> >  static inline bool netmem_is_pp(netmem_ref netmem)
> >  {
> > -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +       if (netmem_is_net_iov(netmem))
> > +               return true;
> > +       return page_pool_page_is_pp(netmem_to_page(netmem));
> >  }
> > 
> >  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 05e2e22a8f7c..52120e2912a6 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -371,6 +371,13 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
> >  }
> >  EXPORT_SYMBOL(page_pool_create);
> > 
> > +static void page_pool_set_page_pp_info(struct page_pool *pool,
> > +                                      struct page *page)
> > +{
> > +       __SetPageNetpp(page);
> > +       page_pool_set_pp_info(page_to_netmem(page));
> > +}
> > +
> >  static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
> > 
> >  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
> > @@ -534,7 +541,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
> >        }
> > 
> >        alloc_stat_inc(pool, slow_high_order);
> > -       page_pool_set_pp_info(pool, page_to_netmem(page));
> > +       page_pool_set_page_pp_info(pool, page);
> > 
> >        /* Track how many pages are held 'in-flight' */
> >        pool->pages_state_hold_cnt++;
> > @@ -579,7 +586,7 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
> >                        continue;
> >                }
> > 
> > -               page_pool_set_pp_info(pool, netmem);
> > +               page_pool_set_page_pp_info(pool, __netmem_to_page(netmem));
> >                pool->alloc.cache[pool->alloc.count++] = netmem;
> >                /* Track how many pages are held 'in-flight' */
> >                pool->pages_state_hold_cnt++;
> > @@ -654,7 +661,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
> >  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> >  {
> >        netmem_set_pp(netmem, pool);
> > -       netmem_or_pp_magic(netmem, PP_SIGNATURE);
> > 
> >        /* Ensuring all pages have been split into one fragment initially:
> >         * page_pool_set_pp_info() is only called once for every page when it
> > @@ -669,7 +675,6 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> > 
> >  void page_pool_clear_pp_info(netmem_ref netmem)
> >  {
> > -       netmem_clear_pp_magic(netmem);
> >        netmem_set_pp(netmem, NULL);
> >  }
> > 
> > @@ -730,8 +735,11 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
> >        trace_page_pool_state_release(pool, netmem, count);
> > 
> >        if (put) {
> > +               struct page *page = netmem_to_page(netmem);
> > +
> >                page_pool_clear_pp_info(netmem);
> > -               put_page(netmem_to_page(netmem));
> > +               __ClearPageNetpp(page);
> > +               put_page(page);
> >        }
> >        /* An optimization would be to call __free_pages(page, pool->p.order)
> >         * knowing page is not part of page-cache (thus avoiding a
> > 
> > --
> > Pavel Begunkov

