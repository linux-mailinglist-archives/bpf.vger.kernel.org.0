Return-Path: <bpf+bounces-58959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F5AC45CF
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 03:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505C8189BB88
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95C3C465;
	Tue, 27 May 2025 01:02:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56969136E;
	Tue, 27 May 2025 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748307766; cv=none; b=KGdbh7Zgwv1cwndd7h3V0kbJ82KYlUts5K++0pk5zxYYf7ANizKj5Ut6JEXDZCTfRhDt6iGOICU6LwNYjFfeaKLlIVptP/4AUESqv5xTQpT34hUNqJddCnWq/BCmu0aoBihWN2zDeTf4moLY7lOwNx3D6QxyOH59jSUoZYcZb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748307766; c=relaxed/simple;
	bh=rEmIUfYVSDi/CfZYPU5fVUEXDY2MADcse0UeERj6OCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqTn/ZuVMuOS1mEX7YKSjHsJhlkS7Sh1t86kjff2tBCe3yoxdee25s4Hu1rACe/ZqPCM+xv+ZYt/VqWCOpH9i8vceu2Rlun3wHGHy+wQYQAY6wQGRXHyW+3UlnNKBCuGehEJMpwBUDd72Julzc08oggFp45TWumsi5I/QAzffLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-bf-68350f2723b5
Date: Tue, 27 May 2025 10:02:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250527010226.GA19906@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
 <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUiTYRiGe79/p6vPpfZaoLWKSslKTJ4oZWd9CEGQdFBBjfxqozltmmkk
	rGZJptN+iJyrVlH5R4O55iZitUYqGumymqVZlnqQJqlJ+VNtSuTZxXM/7309By9Hyu7Qyzm1
	NlvUaZUaOSOhJCMhtzeuX7JVtfnaUDCYrbUM1PzMhQcfnTSYqx0IJn69Z2Hc08zA3duTJJhf
	FlDwwzpFwsDzfhb67g9S0FhYT0J/aQsDJQXTJJx1VhLQ4TDScHXqHgn1+o8svGowM/Ch9g8N
	g+4SClpNVRT0GRXw3BIBk23DCDzWegImi28wcMVrYeBzQR8C77N+CirOGBFYm3w0TP80M4pV
	gr2qmxBcpl5WsNhOCHWVMUKRz0sKtuoLjGAbu8wKPW8aGaHl+jQluJzjhFBi+MYI3wfeUcJo
	02tGsNpfU0K7xcMK47ao3fw+yY40UaPOEXWbkg9JVLNFGzOnIdfVWUfo0aP1RSiIw3wC7vW8
	IP+xvteIAkzxa3Hhw1kmwAy/Dvt8v+Z2wvhY/PWtmy1CEo7kh2lsLXRQgWApn4q7PpWzAZby
	gPtrXERgScZfJHB3g5eeD0Jxa/mXuQekv3Xmptffyvl5BX7wm5sfR2PDo4o5WRCfhEc6z891
	hvOr8RNHMzF/qJ3DzVXb5zkSP630UWUo1LTAYFpgMP03mBYYLIiqRjK1NiddqdYkxKnytOrc
	uMMZ6Tbk/zn382f2O9FYxx434jkkD5F2iAkqGa3MycpLdyPMkfIwqaPMP5KmKfNOibqMg7oT
	GjHLjVZwlHyZNH7yZJqMP6rMFo+JYqao+5cSXNByPUqqDfWNboVzLnuuYdFXj7cmpaddf2ks
	KrnFLY9vTDkbbndH7C3+cXr3Gjbx0EpfcMWGW6HfbgVPGUoT63baFYpBWYWKll7b1nVKbOiM
	GFq2OOi9zRjJXd7Xvud4lW8mOn9bWbweycIUqROpbU5NZvKR2MXJWsOA7MAu9LjwUpycylIp
	t8SQuizlX+OrG+I1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed67o9WbeXnQD8UsLEMr0jhRRhjhQ4QUSNEFcuhLG84pm4oG
	gTVRtGZ2o5yrFkNNzRZe5pQhNmcpRdnKUstrGkL3m3jrshmR3378/+f8zpcj0P4FbIig1mZK
	Oq1So+BkjCxhmyEyfFmMauPjkWgw225zUDudA1UjDhbMNXYE32de8fDN/YAD680pGsxP8hn4
	YZulYeL+GA/DlW8ZcBY20zB2rosDY/4cDacdtyjouNbNQo+9hIVLsxU0NOeN8PCs1czB0O3f
	LLx1GRnoNlUzMFyyE+5bgmDq4XsEblszBVNnr3Fw0WPh4E3+MAJPxxgD5adKENja+liYmzZz
	OxWksbqfIi2mQZ5Y6rNIw60IUtznoUl9TRFH6r9e4MnrF06OdF2dY0iL4xtFjIaPHPkyMcCQ
	T229HLFOfqaIrbGXIY8sbn7f8sOy7SmSRp0t6TbsSJKpfhZHZsxBTsvTBioPNa0tRn4CFqNx
	3mAJ8jEjrsGFd35yPubEcNzXN0P7OEBcj9+9dPHFSCbQ4nsW2wrtjK9YISbi56NlvI/lIuCx
	2hbKN+QvnqFwf6uH/Vssx91l4wsLtNc6f93jtQpeDsVVv4S/8UpsaCpfOOYnxuIPTwsWnIFi
	GG63P6BK0VLTIpNpkcn032RaZLIgpgYFqLXZaUq1JiZKn6rK1apzopLT0+qR9zsqT86fd6Dv
	z+JdSBSQYom8R4pW+bPKbH1umgthgVYEyO2l3kieosw9IenSj+myNJLehUIFRhEs33NQSvIX
	jyszpVRJypB0/1pK8AvJQ2d6GmYCu65oOjsPOc2jVmP86vi9l6sHzzpi7g47T8WlpMaN3nAm
	/tZaraW7Ruv2fYw94Nkx8M6QvCX1qCc8aB3f32u6ewJvNoR92mqcdJ9eVVYbvH/3kU5hKCox
	Lmbbk/byulb7uP5ewtKDk51JjyqmrzTWNG1wz5O6MLy3q8hvrYLRq5SbImidXvkHCzqGkRkD
	AAA=
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 05:58:10PM +0100, Pavel Begunkov wrote:
> On 5/26/25 02:37, Byungchul Park wrote:
> > On Fri, May 23, 2025 at 10:55:54AM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > Now that all the users of the page pool members in struct page have been
> > > > gone, the members can be removed from struct page.
> > > > 
> > > > However, since struct netmem_desc might still use the space in struct
> > > > page, the size of struct netmem_desc should be checked, until struct
> > > > netmem_desc has its own instance from slab, to avoid conficting with
> > > > other members within struct page.
> > > > 
> > > > Remove the page pool members in struct page and add a static checker for
> > > > the size.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >   include/linux/mm_types.h | 11 -----------
> > > >   include/net/netmem.h     | 28 +++++-----------------------
> > > >   2 files changed, 5 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > index 873e820e1521..5a7864eb9d76 100644
> > > > --- a/include/linux/mm_types.h
> > > > +++ b/include/linux/mm_types.h
> > > > @@ -119,17 +119,6 @@ struct page {
> > > >                           */
> > > >                          unsigned long private;
> > > >                  };
> > > > -               struct {        /* page_pool used by netstack */
> > > > -                       unsigned long _pp_mapping_pad;
> > > > -                       /**
> > > > -                        * @pp_magic: magic value to avoid recycling non
> > > > -                        * page_pool allocated pages.
> > > > -                        */
> > > > -                       unsigned long pp_magic;
> > > > -                       struct page_pool *pp;
> > > > -                       unsigned long dma_addr;
> > > > -                       atomic_long_t pp_ref_count;
> > > > -               };
> > > >                  struct {        /* Tail pages of compound page */
> > > >                          unsigned long compound_head;    /* Bit zero is set */
> > > >                  };
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index c63a7e20f5f3..257c22398d7a 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -77,30 +77,12 @@ struct net_iov_area {
> > > >          unsigned long base_virtual;
> > > >   };
> > > > 
> > > > -/* These fields in struct page are used by the page_pool and net stack:
> > > > - *
> > > > - *        struct {
> > > > - *                unsigned long _pp_mapping_pad;
> > > > - *                unsigned long pp_magic;
> > > > - *                struct page_pool *pp;
> > > > - *                unsigned long dma_addr;
> > > > - *                atomic_long_t pp_ref_count;
> > > > - *        };
> > > > - *
> > > > - * We mirror the page_pool fields here so the page_pool can access these fields
> > > > - * without worrying whether the underlying fields belong to a page or net_iov.
> > > > - *
> > > > - * The non-net stack fields of struct page are private to the mm stack and must
> > > > - * never be mirrored to net_iov.
> > > > +/* XXX: The page pool fields in struct page have been removed but they
> > > > + * might still use the space in struct page.  Thus, the size of struct
> > > > + * netmem_desc should be under control until struct netmem_desc has its
> > > > + * own instance from slab.
> > > >    */
> > > > -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> > > > -       static_assert(offsetof(struct page, pg) == \
> > > > -                     offsetof(struct net_iov, iov))
> > > > -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> > > > -NET_IOV_ASSERT_OFFSET(pp, pp);
> > > > -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> > > > -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > > > -#undef NET_IOV_ASSERT_OFFSET
> > > > +static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > > > 
> > > 
> > > Removing these asserts is actually a bit dangerous. Functions like
> > > netmem_or_pp_magic() rely on the fact that the offsets are the same
> > > between struct page and struct net_iov to access these fields without
> > 
> > Worth noting this patch removes the page pool fields from struct page.
> 
> static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> {
> 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> }
> 
> static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
> {
> 	return &__netmem_clear_lsb(netmem)->pp_ref_count;
> }
> 
> That's a snippet of code after applying the series. So, let's say we
> take a page, it's casted to netmem, then the netmem (as it was before)
> is casted to net_iov. Before it relied on net_iov and the pp's part of
> the page having the same layout, which was checked by static asserts,
> but now, unless I'm mistaken, it's aligned in the exactly same way but
> points to a seemingly random offset of the page. We should not be doing
> that.

I told it in another thread.  My bad.  I will fix it.

> Just to be clear, I think casting pages to struct net_iov *, as it
> currently is, is quite ugly, but that's something netmem_desc and this
> effort can help with.
> 
> What you likely want to do is:
> 
> Patch 1:
> 
> struct page {
> 	unsigned long flags;
> 	union {
> 		struct_group_tagged(netmem_desc, netmem_desc) {
> 			// same layout as before
> 			...
> 			struct page_pool *pp;
> 			...
> 		};

This part will be gone shortly.  The matters come from absence of this
part.

> 	}
> }
> 
> struct net_iov {
> 	unsigned long flags_padding;
> 	union {
> 		struct {
> 			// same layout as in page + build asserts;
> 			...
> 			struct page_pool *pp;
> 			...
> 		};
> 		struct netmem_desc desc;
> 	};
> };
> 
> struct netmem_desc *page_to_netmem_desc(struct page *page)
> {
> 	return &page->netmem_desc;

page will not have any netmem things in it after this, that matters.

> }
> 
> struct netmem_desc *netmem_to_desc(netmem_t netmem)
> {
> 	if (netmem_is_page(netmem))
> 		return page_to_netmem_desc(netmem_to_page(netmem);
> 	return &netmem_to_niov(netmem)->desc;
> }
> 
> The compiler should be able to optimise the branch in netmem_to_desc(),
> but we might need to help it a bit.
> 
> 
> Then, patch 2 ... N convert page pool and everyone else accessing
> those page fields directly to netmem_to_desc / etc.
> 
> And the final patch replaces the struct group in the page with a
> new field:
> 
> struct netmem_desc {
> 	struct page_pool *pp;
> 	...
> };
> 
> struct page {
> 	unsigned long flags_padding;
> 	union {
> 		struct netmem_desc desc;
		^
		should be gone.

	Byungchul
> 		...
> 	};
> };
> 
> net_iov will drop its union in a later series to avoid conflicts.
> 
> btw, I don't think you need to convert page pool to netmem for this
> to happen, so that can be done in a separate unrelated series. It's
> 18 patches, and netdev usually requires it to be no more than 15.
> 
> -- 
> Pavel Begunkov

