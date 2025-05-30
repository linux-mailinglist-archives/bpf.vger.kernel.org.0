Return-Path: <bpf+bounces-59339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BC5AC85F4
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 03:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DDC3AC075
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D256155CB3;
	Fri, 30 May 2025 01:16:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9328DDD2;
	Fri, 30 May 2025 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748567795; cv=none; b=lGxBTpQi6Bqc+DsdQhFyqQuLvy/0lpVO17KxAw156nw8qLWVrCfJCvfiy/EmhAhbC7VhYTdOsChxi2QzEEHtAC9Y/nTp7SxbXWBk+4r/88TbPJMk7JZevyevwCEI+Zv2IyXhj1A5v0TFGeP7hhiETTSWIy2uzD17wnj1M8LBAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748567795; c=relaxed/simple;
	bh=Lq69HU9VSQKm1QHJcQ61SXHbJZcHgg5Fm9b9W0DNrYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ape0cWA5+KlXcH/8SlIgea4eQF1IMyaLWArBEw6vtfe/TXBZvgD+67dQDdtnqEQWXOcO1meQauh+D26bqOKbwsqzCXefUOEZ7NBdhxQFuPUTWuh74OQfr4hp39RY9GwShpkhp+14LPcDyMXjakS8iDpdl3eGvQU+68qsOjDbDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-62-683906ea504f
Date: Fri, 30 May 2025 10:16:21 +0900
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
Subject: Re: [RFC v3 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <20250530011621.GB3093@system.software.com>
References: <20250529031047.7587-1-byungchul@sk.com>
 <20250529031047.7587-19-byungchul@sk.com>
 <CAHS8izNyXM_KQiySAw4hZQ+FU8yxAZmcqvjsO7P3pM0HNy0STA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNyXM_KQiySAw4hZQ+FU8yxAZmcqvjsO7P3pM0HNy0STA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH+97zfZ57Ot32OIdv2ZizFm0Siz62Fv+wx+a3fwzDcc/c5era
	XVLGnApzUyiG68olqqt028lVtEpFUtQutUu4dpTNohGtRHSl6b/33p/3+/P6/PFhKdltOojV
	xCUI+jilVsFIsORzQN7yT8xadbi3Nhws9lIGSkaSoLC3kgZLsRPB99EeMQw1NjGQnzdMgaUt
	DcMP+08K+p56xeAp6MdQfb6CAu+lZwykp41RkFJZJIJ2ZwYNV3/epaDC2CuGjocWBt6V/qGh
	vz4dQ7PZhsGTsR6eWufBcMsAgkZ7hQiGL+YwkOWyMvA+zYPA1eDFkH0mA4G9xk3D2IiFWb+Y
	L7d1i/gq81sxb3Uc4+8XhfImt4viHcUXGN7xLVPMv+mqZvhnN8YwX1U5JOLTU78w/Ne+15gf
	rOlkeHt5J+ZbrY1ifsixcDu3RxKlErSaREG/IvqgRN1tM1LxvfOSPme/oYzonMyE/FnCRRBj
	/3N6Wnv6r01qzAUTb1Ot2KcZLoS43aOUT8u5ZeROzZXJDMV5aPLSEmNCLDuH05HmqnifLeUi
	iaPq+kRcwsq4QkQ6Bz7SU4PZpPnmBzzVDSG/cl2Ur0txC0jhODtlLyKpD7InUf7cDlI0Pj4Z
	n8stIXXOJpFvJ+HKWdJlefTv5kDyuMiNL6PZ5hkI8wyE+T/CPANhRbgYyTRxibFKjTYiTJ0c
	p0kKO6yLdaCJzyk49WtvJfrWvqsecSxSBEjDo0Eto5WJhuTYekRYSiGXpqxbo5ZJVcrkE4Je
	d0B/TCsY6tECFivmS1cNH1fJuCPKBOGoIMQL+umpiPUPMiLtp/s7W6NUr8y6TQyJ1h0SBd8K
	LvHbsqEnaGmbsqTheIwhZZ9T5RownYpsf6ePPHL15EqXOD/rxe4ttjJyxq8u5+y9lrx1+0MO
	5wYmlp5vl5fMSm0SnZY34w7Htq2b5Z0ZvxWXXS8HV7v6ejLxCfVGQ1jZhSdzQu8wJuetwblj
	1QpsUCtXhlJ6g/Ivt6oqCjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0iTYRjHe/cd9jlbfC6zFw2C2bCig6HZ07mb6KWgEqLEi3TkR1vNKZua
	RsFKU7LUrFZrLl1ZnjIGy9SFWZjkpLCaGVrqbHnofNLEmlhNibz78z/8npuHo2QnmGBOrU0R
	dFqlRs5KaMn2tZlL37OrVeFXs+eDxVbNwo2xdCjvq2fAUlWLYOTnKzEMN7ewUHpllALLkywa
	fth+UTDw0CMGd9kgDQ05dRR4Cpws5GV5KTheXyGCB5dbGXham8/A+V/XKagz9Imh/Y6Fhd7q
	3wwMNuXR0GqupMGdvwkeWoNg9NFHBM22OhGMnr7MwjmXlYU3WW4ErgceGoqO5SOwNXYy4B2z
	sJvkpKayS0Qc5h4xsdpTya2KxSS300URe9VJlti/nxWT7hcNLHGavDRx1A+LSF7mZ5Z8G3hJ
	ky+NHSwpfftVRGw1HTR5bG0W7wyIlaxLEDTqNEG3fEO8RNVVaaCS+4LSPxV1UwaULctFfhzm
	I7F70Mj4NM0rsKflntinWT4Md3b+pHw6kF+ErzUWTnYo3s3gNsuBXMRxs/kk3OpI9tlSfhW2
	Oy7+rUs4GV+OcMfHIWYqCMCtl/rpqW0YHi92Ub4txYfg8gluyp6PM28XTZ7y46NxxcTEZH0O
	H4rv17aIzqBZ5mkk8zSS+T/JPI1kRXQVClRr0xKVas3KZfqDqgytOn3ZvqREO/r7HGVHxwvr
	0Uj7libEc0g+UwqbQSVjlGn6jMQmhDlKHig9vjFKJZMmKDMOC7qkOF2qRtA3oRCOls+Vbt0j
	xMv4/coU4aAgJAu6f6mI8ws2oN4CTVzEctGOuuLXNv/EhUdOXzN/sA4tiHbtjYg03LowGnXo
	N1Xl/9zGGElMz6zIU86Y9TeZhiXnn4W4VIr349vahkJr5oXHlHiNgTNmGgaOGXcPV5SYAt7F
	m3oj7eG75q3ZSu9WKGy4MCfhTGj/YAGzwDQWGxTLFcuUZMldp7+c1quUKxZTOr3yD4i/9+QY
	AwAA
X-CFilter-Loop: Reflected

On Thu, May 29, 2025 at 12:54:31PM -0700, Mina Almasry wrote:
> On Wed, May 28, 2025 at 8:11 PM Byungchul Park <byungchul@sk.com> wrote:
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
> > ---
> >  include/linux/mm.h   | 12 ------------
> >  include/net/netmem.h | 14 ++++++++++++++
> >  mm/page_alloc.c      |  1 +
> >  3 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8dc012e84033..de10ad386592 100644
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
> > index f05a8b008d00..9e4ed3530788 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -53,6 +53,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> >   */
> >  static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> >
> > +#ifdef CONFIG_PAGE_POOL
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +       struct netmem_desc *desc = (__force struct netmem_desc *)page;
> > +
> 
> Is it expected that page can be cast to netmem_desc freely? I know it
> works now since netmem_desc and page have the same layout, but how is
> it going to continue to work when page is shrunk and no longer has

This should be updated once struct netmem_desc has its own instance from
slab.  As Pavel mentioned, that should be done another way.

> 'pp_magic' inside of it? Is that series going to fixup all the places
> where casts are done?
> 
> Is it also allowed that we can static cast netmem_desc to page?
> 
> Consider creating netmem_desc_page helper like ptdesc_page.

Do we need casting netmem_desc to page?

> 
> I'm not sure the __force is needed too.

Ah, I will remove it.

	Byungchul
> 
> -- 
> Thanks,
> Mina

