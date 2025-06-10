Return-Path: <bpf+bounces-60131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B375CAD2B8D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E7816EDF0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9571C5F37;
	Tue, 10 Jun 2025 01:45:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11F10957;
	Tue, 10 Jun 2025 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519913; cv=none; b=N4dDZQMqFOZ4JwqXns+90oh4sl3IAHwTJlCZISe2RPuc9fKcDvAor16koo+x8Drw1b+nLhekabqHMdhB4nOp2Wacl7+LYkSvW4nE070YJ6NTOiFckx/M+q0yaZ2UCv7bcmLYFjsne91k45fMdpvUm+jV9dRXc7CX/Q5b5KiHjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519913; c=relaxed/simple;
	bh=kS12EYAOcFxTZ4qK73JMK7AHOrtNTiMMQDIU+wcqEEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ8yuSbMCauAiVC0kqNWMMsaX2iqvqA4OQzIxbfdBAH3OLSS4ce+mvkLGxI14WcnfF6mq5GC0ZZSf3ErnMwC1v0Dh+B34c+ymAU1R464f6pZYYPvdDME232o3xdkLljUYw6BOKYjpSNPlCpLukk1UX2TaXVpMqnSv2rJR2OI8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f7-68478e213ff4
Date: Tue, 10 Jun 2025 10:45:00 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <20250610014500.GB65598@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-10-byungchul@sk.com>
 <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfO3h2Xg+PKfNOuCwkjTcvo+VCiWHr6ENlFhC7UyENbXpn3
	KJiX1EyXllHNFavMyxJGy3RKSC3T2U2bmbObNtMKupCmWZrllMhvP/7P5fd8eBhKelXoySjj
	k3lVvDxWhsW0+LPrZd9lmnCF/7lMH9AZazBcH0uHyj6zEHSGOgTff74UwXBzK4arl0cp0LXn
	0DBi/EXBQItDBL0VgzTczqunwHHKiqEoZ5yCLHOVADrqNEIo/XWNgnp1nwg6G3UY3tT8EcKg
	pYiGNm01Db2aYGjRz4fRh58QNBvrBTBaeBHDGZseQ39OLwLbPQcNZZkaBMYmuxDGx3Q4eBlX
	W90j4Bq0r0Wc3pTC3axayRXYbRRnMpzAnGnotIh79fw25qznx2muwTws4Iqyv2Du28ALmvva
	1IU5Y20XzT3SN4u4YdPiCHa3eEM0H6tM5VWrgw6IFbkGA0r8vCi9v2REoEZ9HgXIhSFsIOno
	cdD/eMRqRk6mWW/S0mMUORmzK4jd/pNy8jzWh5Q3lQidTLG9QvJEd9jJc9kUktdePN0vYYG0
	5T/ABUjMSNlqRMbHNIKZghtpu/COnhleQSYu2aaWMlPsRSonmZl4Ccm+VTbtcmG3kxH18PSo
	O7uc3KlrFTh3EraWIYUfG/DM0QvI3So7XYzctLMU2lkK7X+FdpZCj2gDkirjU+PkythAP0VG
	vDLd72BCnAlNvU7FsYk9ZjTUsdOCWAbJXCXWzjCFVChPTcqIsyDCULJ5kmpnJImWZxzhVQn7
	VSmxfJIFeTG0zEOyZjQtWsoekifzMTyfyKv+VQWMi6ca7Uj2FO8byp2wbJaoA8WT9XE1F9Uh
	URlM45uNDu3ZcFupV3/yUkuA9v6NrYVpQRFuWZaor99ODthfPhyM2OW9SeK+Xhr5PmRL2NHI
	dWuzfz/23RYz+eG6JnQH7n5VWrUwIv/K4Wdvn27Dfmk+WNR44dbeVd3NJZ5zyn3TrKEFxT+O
	+8voJIU8YCWlSpL/BWPEUSU2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3X7kaLm1pdtIgWoRVaUcLBJCIqLxFRgfSCcuWlrabF5kyL
	ZKWkSa7ZuzlrZbm2rMEynRYjlrmt12L2mPaY7wrKHjrRLTKnRP734XvO93P+OTQedZyMpeXZ
	ObwyW6qQUCJCtH5ZYeJsbZps0auSaDBYayi4NZQHpnY7CQZLHYKB4XcC6G9yUVB1dRAHg7eI
	gKA1hENPc6cAAtW9BDworseh85SbgrKiMA7H7DcxeFTpIeFlnZaEs6EbONRr2gXQ0mig4GPN
	CAm9zjICPHozAQHtCmg2ToPBp18RNFnrMRg8WUnBGZ+Rgq6iAALfo04CKo5qEVgdfhLCQwZq
	hYSrNbdiXIP+g4Az2tTc3ZvzuVK/D+dslhMUZ/t1WsC9f/OA4twXwwTXYO/HuLLCPor72dNG
	cN8drymu6vMPjLPWvia4Z8YmwYYp20SpmbxCnssrFy7PEMmOWyzowLeZeV3lQUyD2qeXIiHN
	MkvZoNuOIkwwc9nmVqsgwhQTz/r9w3iEY5h57HVHORlhnAmQ7AvD3ghHM2q22Ksb2xczwHpK
	nlClSERHMWbEhoe02PhgCuu51E2Ml+PZ35d9o1J6lONY0x96PJ7FFt6rGLslZDayQU3/WHUq
	M4d9WOfCdGiyfoJJP8Gk/2/STzAZEWFBMfLs3CypXJGcpNony8+W5yXt3p9lQ6PfUX3kd7kd
	DbSkORFDI8kksbtljSyKlOaq8rOciKVxSYzYHInEmdL8Q7xy/06lWsGrnCiOJiTTxWs38xlR
	zB5pDr+P5w/wyn9TjBbGapBZvlV8znQ+vMtQ27DAZzE9ThhpSVR9WuKiC9IHErZv6jC12W6n
	dLzVHl618EaB7pR55Z2dM5Y0pugbu5MDyyt0oeeylcH1e4stjur0r78So+eSwtbVO/Dhmpfx
	W641tdmtX97db4DQY8c6dULJQe+xvorGc+SVnC7x2zLvhVRXlYRQyaSL5+NKlfQvyPaoXxkD
	AAA=
X-CFilter-Loop: Reflected

On Mon, Jun 09, 2025 at 10:39:06AM -0700, Mina Almasry wrote:
> On Sun, Jun 8, 2025 at 9:32 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > To achieve that, all the code should avoid directly accessing page pool
> > members of struct page.
> >
> > Access ->pp_magic through struct netmem_desc instead of directly
> > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > without header dependency issue.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > ---
> >  include/linux/mm.h   | 12 ------------
> >  include/net/netmem.h | 14 ++++++++++++++
> >  mm/page_alloc.c      |  1 +
> >  3 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index e51dba8398f7..f23560853447 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >   */
> >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >
> > -#ifdef CONFIG_PAGE_POOL
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > -}
> > -#else
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -       return false;
> > -}
> > -#endif
> > -
> >  #endif /* _LINUX_MM_H */
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index d84ab624b489..8f354ae7d5c3 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> >   */
> >  static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> >
> > +#ifdef CONFIG_PAGE_POOL
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +       struct netmem_desc *desc = (struct netmem_desc *)page;
> > +
> > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +}
> > +#else
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> >  /* net_iov */
> >
> >  DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4f29e393f6af..be0752c0ac92 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/delayacct.h>
> >  #include <linux/cacheinfo.h>
> >  #include <linux/pgalloc_tag.h>
> > +#include <net/netmem.h>
> 
> mm files starting to include netmem.h is a bit interesting. I did not
> expect/want dependencies outside of net. If anything the netmem stuff
> include linux/mm.h

That's what I also concerned.  However, now that there are no way to
check the type of memory in a general way but require to use one of pp
fields, page_pool_page_is_pp() should be served by pp code e.i. network
subsystem.

This should be changed once either 1) mm provides a general way to check
the type or 2) pp code is moved to mm code.  I think this approach
should acceptable until then.

> But I don't have a butter suggestion here and I don't see any huge
			^
			lol

	Byungchul

> problems with this off the top of my head, so
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> Lets see if Jakub objects though. To be fair, we did put the netmem
> private stuff in net/core/netmem_priv.h, so technically
> include/net/netmem.h should be exportable indeed.
> 
> -- 
> Thanks,
> Mina

