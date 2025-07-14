Return-Path: <bpf+bounces-63184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3ACB03E52
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738AB3A8BA4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F9254AF3;
	Mon, 14 Jul 2025 12:06:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747C248F56;
	Mon, 14 Jul 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494790; cv=none; b=qa0ylw7aU5XSCh+0pszopbQX9eeNJHRiUjewr9i+wM+0iY1W171hxQMgZjV99HXYoDfSzNA+NPWi8btoSYaztzo9bcn0i9hDhFhhi8rJreKJnwnNX1PH8SOoxCBfNgB8xi9yzuOo4e1BT6yZpFCbfM5p+GkIbCGHl7APbIuA96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494790; c=relaxed/simple;
	bh=Bw5K9Z6DSYdTf3NBvOviPDx7IVtplNK1PwEYeKD7k74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7pq1HHAEd5DPB3BQLQVZFmA2FNfshGvfmZ2iZ7Z5CtiQIf6NQciAjwX/VHDm2ShPwdRWrQ9zr5jTnkl+sldq7da1k2R8A7ucg5YWY2fXEzyECYg+Z5fXcouAfbYvLFdIfUVGMrmy47t0JQuv1BR8RUG7O9tUtqZwC25eV4c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a8-6874f2bee77b
Date: Mon, 14 Jul 2025 21:06:17 +0900
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
Message-ID: <20250714120617.GA36228@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
 <20250713230752.GA7758@system.software.com>
 <5ee839d6-2734-41c5-b34c-8d686c910bc8@gmail.com>
 <20250714100551.GA44803@system.software.com>
 <ac59fba9-4f39-4691-afae-aa7a0b1270af@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac59fba9-4f39-4691-afae-aa7a0b1270af@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z//2TnH5eK4zP5pQawrVnb98EIXqk/HsntRFKQjD221rZiX
	XFCsEqyRKyrI5oIt0bzlYto8iVkt80JSYVrLrJWZdLFZZqYuNNeF+vbwPA+/9/3wcFh5URbN
	aQ2potGg1qkYOS3/FO6cW9ObqpnfUzUV7K5SBkoGMuDKK0kG9mIPgr7B5yx8ra1nIM/Zj8H+
	MJOGb64hDG/rOlgoca8Ff0EXDdVZlRg6TjcwkJ0ZxHBzMMDCMamQgkceqwzOD+VjqDS/YuFx
	lZ2Bl6UjMujyZtPQaCuiwW9dAXWOKOi/342g1lVJQf+pSwyca3Yw8CbTj6D5bgcNuUetCFw1
	PhkEB0YZufdesiumCXe7e7BQUfSMEm7YXrCCw50mlBfGChZfMxbcxScZwd17lhXan1QzQkNO
	kBZuSF8pIft4gBG+vG2jhZ6aVkZwVbTSQpOjlt0QsUO+NFnUadNF47zlSXJNXyV34AnJ6Mux
	YzPKVVpQGEf4xaTlug3/1beul9EWxHE0P51cNZtCNsPPJD7f4K9KJD+bfHzqZS1IzmE+hyFl
	rwuYUDCOTySfL3iokFbwQL55mlCopOSfUuTB2at/ggjSeLGTDmnMxxLf8HsqdAzzMeTKMBey
	w/hlRKo7+qsynp9KbnvqqRCH8BJH3P4A9fvRieROoY8+g3jbf1jbf1jbP6wD4WKk1BrS9Wqt
	bnGcxmTQZsTt3q93o9HBFBz+sVNCvY82exHPIVW4Aj6kapQydXqKSe9FhMOqSMWHF0aNUpGs
	Nh0SjfsTjWk6McWLYjhaNUGxsP9gspLfo04V94niAdH4N6W4sGgzmrD6sf/EWByYY94VmKge
	Kmtrz08KVsePkTpjjqyJnT3jUEJWfMW1vFXNEZP36jaF6ZfEXFpqSthqbciL2vLdGOHUz5mS
	dKct2BLv7J1xkxRFr/NLs6zTT04q735TNm69tMhi6OgMpCnj30WO+OpHug6fLky4vDEvzukq
	Lrdt2x61UkWnaNQLYrExRf0Tfe6G0SwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe897ds5xNDguqxcNhEkERlcKHioloegtKaoPRRboqFNbqck2
	RYtIU6lWalmQzQWLSs1yg1VzdjGd5bI7iroyL5lKTTOzZepCc1HUtx//y/N8+QtY6WdDBW2y
	QdIlqxNVnJyVb1qZvaB62KBZnHtKBLPtJgc3RtOhtMspA3O5A4FvrI2Hb4/cHFy5PILB/CqH
	he+2cQy99d083LBvhM6SPhbuH6/E0F3whIO8HD+GB2ODPBxzljFQd6lBBq8d+TI4P34NQ2Vm
	Fw9Nd80cdNyclEGfK4+FBtN1FjrzV0O9ZRaMPBtA8MhWycDI6UscnGu0cPAhpxNBY103C8VZ
	+Qhs1R4Z+EenbhQ/7uBXz6V1A18wvX39DUOrTO08tdhT6a2ySGr0NGJqLz/JUftwIU/ftdzn
	6JMiP0urnN8Ympc9yNGvvW9Z+qW6maNXPg4x1Ha7md2sjJOv2iMlatMk3aLoBLnGVymktJB0
	X5EZZ6JipREFCURcRh7esbJGJAisOJdUZGYEZE6cRzyeMRzgEHE+6W918UYkF7BYxBHr+xIu
	YMwQ48nQBQcTYIUI5LvjOQqElGIrQ14WVvwxgknDxR42wFiMJJ6JT0zgGRbDSOmEEJCDxCji
	rM/6HZkpRpAah5s5gxSm/9qm/9qmf20LwuUoRJuclqTWJi5fqD+gyUjWpi/cfTDJjqYmUXLk
	51kn8jWtcyFRQKrpCvAaNEqZOk2fkeRCRMCqEIW3XadRKvaoMw5JuoPxutRESe9CYQKrmq3Y
	sF1KUIr71AbpgCSlSLq/LiMEhWaiGvtnt3uXbH9KkJ+KWU+37A2PuzrAmwd9R0+UhG9tk3U0
	5a5J6ZqcsOYfjogwLi2oNW8uHOohxwzRsVGvOoP7Y3KaOdy2zTvjbtGncO/j0dTYhmBv74va
	ndZ77m37z4aNKTw7qqdVpc2Jsf7YuQJGZo6GbJK3IP16y0RwwtpQn4rVa9RLIrFOr/4F5NvG
	lA4DAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 12:45:17PM +0100, Pavel Begunkov wrote:
> On 7/14/25 11:05, Byungchul Park wrote:
> > On Mon, Jul 14, 2025 at 10:43:35AM +0100, Pavel Begunkov wrote:
> > > On 7/14/25 00:07, Byungchul Park wrote:
> > > > On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
> > > > > On 7/10/25 09:28, Byungchul Park wrote:
> > > > > ...> +
> > > > > >     static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> > > > > >     {
> > > > > >         if (netmem_is_net_iov(netmem))
> > > > > > @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> > > > > >         return page_to_netmem(compound_head(netmem_to_page(netmem)));
> > > > > >     }
> > > > > > 
> > > > > > +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
> > > > > > +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> > > > > > +     struct netmem_desc * :          (struct page *)(nmdesc)))
> > > > > 
> > > > > Considering that nmdesc is going to be separated from pages and
> > > > > accessed through indirection, and back reference to the page is
> > > > > not needed (at least for net/), this helper shouldn't even exist.
> > > > > And in fact, you don't really use it ...
> > > > > > +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> > > > > > +{
> > > > > > +     VM_BUG_ON_PAGE(PageTail(page), page);
> > > > > > +     return (struct netmem_desc *)page;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> > > > > > +{
> > > > > > +     return page_address(nmdesc_to_page(nmdesc));
> > > > > > +}
> > > > > 
> > > > > ... That's the only caller, and nmdesc_address() is not used, so
> > > > > just nuke both of them. This helper doesn't even make sense.
> > > > > 
> > > > > Please avoid introducing functions that you don't use as a general
> > > > > rule.
> > > > 
> > > > I'm sorry about making you confused.  I should've included another patch
> > > > using the helper like the following.
> > > 
> > > Ah, I see. And still, it's not a great function. There should be
> > > no way to extract a page or a page address from a nmdesc.
> > > 
> > > For the diff below it's same as with the mt76 patch, it's allocating
> > > a page, expects it to be a page, using it as a page, but for no reason
> > > keeps it wrapped into netmem. It only adds confusion and overhead.
> > > A rule of thumb would be only converting to netmem if the new code
> > > would be able to work with a netmem-wrapped net_iovs.
> > 
> > Thanks.  I'm now working on this job, avoiding your concern.
> > 
> > By the way, am I supposed to wait for you to complete the work about
> > extracting type from page e.g. page pool (or bump) type?
> 
> 1/8 doesn't depend on it, if you're sending it separately. As for

Right.

> the rest, it might need to wait for the PGTY change, which is more

Only 3/8 needs to wait for the PGTY change.  The rest can be merged
regardless of it if acceptable.

	Byungchul

> likely to be for 6.18
> 
> --
> Pavel Begunkov

