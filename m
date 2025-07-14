Return-Path: <bpf+bounces-63159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09951B03B99
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B81894C09
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBEF244660;
	Mon, 14 Jul 2025 10:06:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA780B;
	Mon, 14 Jul 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487565; cv=none; b=P1g7xtNFh8vlqu8sfxBzpcb3oesqbGZM7KVYVSSRKRPK9JPEmFnFYU1KEVUmwCFZuyZQA7khWIaWCMVeUVveUdOrkxBaejy4++dFqclIMm+/1opYWd3UVdTwXbjA+Mn690xNXwQ7R0uTw1OwuKI09DgDwjSiykd0CKN7UW/11jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487565; c=relaxed/simple;
	bh=wW+uBxRxSh7drtS3oHUktaTkC7UxagpwSUmVuFGOxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ1PgIX+ovqhx2uOhzJI9lMfAMe1D8BF+F6hlKzqqaT1zlI/+MY6S8sS3mBOKmRAmoe6o1b0QVZXKI9Z2J6hd42cBeUmsG24SPM5epNCIwlcYTaatmmRez3wB3b5Mxhj965gC02pG2WCXOSkClNrSCJ/qqZRqXSw/6sG182XHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-07-6874d685ba14
Date: Mon, 14 Jul 2025 19:05:51 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
Message-ID: <20250714100551.GA44803@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
 <20250713230752.GA7758@system.software.com>
 <5ee839d6-2734-41c5-b34c-8d686c910bc8@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee839d6-2734-41c5-b34c-8d686c910bc8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzjkOF8d5e0soWImkZBZWD1ER1YcD0QWCKPtgo53caF7Y
	1FykaFmZqWWL0mWxLpo6cbLETV1mc06li2Zo66ZmallmpaWZpTlF6tuP5/88P/4fHoaQ6IWL
	GGVMPK+OkamklIgUffa8seJUZ7wirGXEGwpMZRQYfybBnR6rEApKqxB8n3hFw6ijiYJbN8YI
	KGhNJ+GH6RcB/c5eGozmHdBdNECC7YyFgN7zzRRkp08ScG9imIYT1mIBtFXlCOHSr0ICLKk9
	NDyrKaCgq2xaCAP2bBJa9CUkdOdsBqfBD8YeDiFwmCwCGMu6RoGu3UDBu/RuBO0NvSRcTctB
	YKpzCWHy54zjamMXvXkZ1zD0heAqS14IuGr9G5ozmBO4u8XBXKarneDMpWcpzjxykeZed9oo
	rjlvkuSqraMCLvvkMMV9639Jcl/qOijOVNlBco8MDnq3V4Rog5xXKRN59cpNB0WK5vcWMq5i
	SVKLy0KlonH/TOTBYDYcm5xO4Txfv185yyQbiAfbvpFuptgg7HJNEG72YUPwp+d2OhOJGILN
	o3D52yLKHXizkfjrlSqBm8UsYON3C+lekrA/EHbUfyDmAi/ckt83ayXYYOyaGpw5YGY4AN+Z
	YtxjD3Yj7rtcMVvCl12K66uaBHPlbAzOGtLO8UL8oNhFXkCs/j+r/j+r/p/VgIhSJFHGJEbL
	lKrwUIU2RpkUeig22oxmPqYo+fcBKxpp22NHLIOknmJXpUYhEcoSNdpoO8IMIfURf3yjVkjE
	cpn2GK+OjVQnqHiNHQUwpNRfvHrsqFzCRsni+SM8H8er51MB47EoFRkzAmsLi1M22GrKI54W
	PUHVgzudOr/9awwhy3XbkroOx29v3OLndV4+bsnND5IfG96ybt/jgHUZ28LO/VkzXq+Li2ww
	eS4OSovKXVvf2Zd4pqe5r6w2q+n285SwBcb12qzpPx3SC62OQl9/61bbh9MhN/fW5iZvykg9
	Xv7KtlinCt4lJTUK2apgQq2R/QX/hLe1LQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec95d85xNDouy5Mm0UICoysJD90Q/NAxukGJGJQtPbjltU3H
	DALTQTTT7repZYjzSltrbVpqsnmZ+GGlVDMzzSytRK28ZlmbEfXtx/N/fn+eDw9DSn/iIEaZ
	miGoUuXJMkqMxfu25a7TvchQbHSWbYUiUw0F1TNaKO+vFUFRlQ3BxGwPDd+a2ygovTtFQpFb
	h2HS9J2E960DNFRb9kKf8QOG+rN2EgYuuCjI182R0DA7SkNObQUBzuJ2ETy1FYjg6vcyEuzZ
	/TR0PSqi4E3NLxF8cORjaDdUYugriIDWkmUw1TGCoNlkJ2DqfDEFVzpLKHin60PQ6RzAUHim
	AIGp0SOCuRlvR2HLGzoilHeOjJG8tbKb4OsMvTRfYsnkH1SE8XpPJ8lbqs5RvOXrZZp//aKe
	4l035zBfV/uN4PNzRyn+y/tXmB9rfE7xpcPjBG+yPscHpIfF2xOEZKVGUG3YeUyscA3Zcbp5
	pbbdY6ey0XSgHvkxHLuFu/3EKvIxZkO5j0+/YB9T7BrO45klfRzAruU+v3TQeiRmSPYmxd17
	a6R8wRI2jhu/YSN8LGGBq56wY9+SlJ1EXHPTMPkn8Ofabw0utJJsGOeZ/+gVGC8Hc+XzjG/s
	x+7gBq+bF45Yyq7mmmxtxEUkMfxnG/6zDf/sEkRWoQBlqiZFrkwOX69OUmSlKrXr49NSLMj7
	FMbTPy7VoomuXQ7EMki2SOKxqhVSkVyjzkpxII4hZQGST70qhVSSIM86JajS4lSZyYLagYIZ
	LAuU7I4RjknZRHmGkCQI6YLqb0owfkHZqDB2vmNsxLnfnR3fUxU1P5wXVRodEynfE8ekh0R3
	Pcxzhxeu7banxAbc6cZtM+acIyfuO1cuqfO/MGrsn+w2y6bii4c01x6s2KzXtDSsWt71zP14
	/OtQjv6Whq4/OJ04sLi/yf/t8UhXToL25KHxEO3R4mizsDoE9BEtzY9j0s7IsFoh3xRGqtTy
	36w7ufIQAwAA
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 10:43:35AM +0100, Pavel Begunkov wrote:
> On 7/14/25 00:07, Byungchul Park wrote:
> > On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
> > > On 7/10/25 09:28, Byungchul Park wrote:
> > > ...> +
> > > >    static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> > > >    {
> > > >        if (netmem_is_net_iov(netmem))
> > > > @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> > > >        return page_to_netmem(compound_head(netmem_to_page(netmem)));
> > > >    }
> > > > 
> > > > +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
> > > > +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> > > > +     struct netmem_desc * :          (struct page *)(nmdesc)))
> > > 
> > > Considering that nmdesc is going to be separated from pages and
> > > accessed through indirection, and back reference to the page is
> > > not needed (at least for net/), this helper shouldn't even exist.
> > > And in fact, you don't really use it ...
> > > > +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> > > > +{
> > > > +     VM_BUG_ON_PAGE(PageTail(page), page);
> > > > +     return (struct netmem_desc *)page;
> > > > +}
> > > > +
> > > > +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> > > > +{
> > > > +     return page_address(nmdesc_to_page(nmdesc));
> > > > +}
> > > 
> > > ... That's the only caller, and nmdesc_address() is not used, so
> > > just nuke both of them. This helper doesn't even make sense.
> > > 
> > > Please avoid introducing functions that you don't use as a general
> > > rule.
> > 
> > I'm sorry about making you confused.  I should've included another patch
> > using the helper like the following.
> 
> Ah, I see. And still, it's not a great function. There should be
> no way to extract a page or a page address from a nmdesc.
> 
> For the diff below it's same as with the mt76 patch, it's allocating
> a page, expects it to be a page, using it as a page, but for no reason
> keeps it wrapped into netmem. It only adds confusion and overhead.
> A rule of thumb would be only converting to netmem if the new code
> would be able to work with a netmem-wrapped net_iovs.

Thanks.  I'm now working on this job, avoiding your concern.

By the way, am I supposed to wait for you to complete the work about
extracting type from page e.g. page pool (or bump) type?

	Byungchul

> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index cef9dfb877e8..adccc7c8e68f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -3266,7 +3266,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
> >                            struct libeth_fqe *buf, u32 data_len)
> >   {
> >       u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
> > -     struct page *hdr_page, *buf_page;
> > +     struct netmem_desc *hdr_nmdesc, *buf_nmdesc;
> >       const void *src;
> >       void *dst;
> > 
> > @@ -3274,10 +3274,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
> >           !libeth_rx_sync_for_cpu(buf, copy))
> >               return 0;
> > 
> > -     hdr_page = __netmem_to_page(hdr->netmem);
> > -     buf_page = __netmem_to_page(buf->netmem);
> > -     dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
> > -     src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
> > +     hdr_nmdesc = __netmem_to_nmdesc(hdr->netmem);
> > +     buf_nmdesc = __netmem_to_nmdesc(buf->netmem);
> > +     dst = nmdesc_address(hdr_nmdesc) + hdr->offset + hdr_nmdesc->pp->p.offset;
> > +     src = nmdesc_address(buf_nmdesc) + buf->offset + buf_nmdesc->pp->p.offset;
> > 
> >       memcpy(dst, src, LARGEST_ALIGN(copy));
> >       buf->offset += copy;
> --
> Pavel Begunkov

