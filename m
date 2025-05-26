Return-Path: <bpf+bounces-58916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEEAC37BE
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 03:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7016318908D2
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284713B58C;
	Mon, 26 May 2025 01:37:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B8171A1;
	Mon, 26 May 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223477; cv=none; b=aPz8oiBkqSPRlSJGHCYOCxDPh+X5Yw2bBcB/ki2THtoZ9d/SMq26Zia46dgtL6WcRSAVkY0l/f7afJhLOxTda9/F2tq452FZ6kUfk99DbWiAUqEXscWCW6PnUW1bVY0S4aBXzAAFJ7sw6+UACd0qCrmy11miA6xiAA4zpp/4wW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223477; c=relaxed/simple;
	bh=CRkglTFzeN4mS0UL21XGK1rVp2NKgKPLfbhZx7oMuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKQ/tgVWf3JRC2htKO/duJf8cjR5E+94K4AsqL43mv4XZBBGSthAUiXcA4GXUm7rdeGnFdpYuS4e4lzJ6l4OYumk/evxR2lKm+oiw0/g/P9Ew0lpJ95yx05UlltdtANmdLfAWCX+qPl6YgYR//8hNiZbvHGuBpE9J1WIQWYYqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-23-6833c5ed816f
Date: Mon, 26 May 2025 10:37:44 +0900
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
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250526013744.GD74632@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nueeebh1P59e3H0pniSKR2WdGzvzzbJYx/KFsdatn7rjS
	7pI7P7aoaaJUGJ3DCf2S3XZd3YWFin6wnFCHKFHZUn7EVVdDVzP999r783m/358/PgwpKRT4
	MMqkFF6dJFdJaRElGvAsXD7wKEIR7ipYDAZTOQ23RrRQ3GUTgKGsCsHP0bdCGKpvoOH6NScJ
	hmcZFPwyuUjoedwthM6iXgruZVpJ6D7TSEN2xhgJx20lBNircgRwznWTBGtalxBe3DHQ8L78
	jwB6a7MpaNKXUtCZI4PHxnngfPIFQb3JSoDz9GUazrYaafiY0Ymgta6bgkvHchCYahwCGBsx
	0LJAzlL6muCq9e+EnNF8gKsoCeGyHK0kZy47SXPmH/lCrqPtHs01XhyjuGrbEMFlpw/S3Pee
	NxT3teYVzZksryjuqbFeyA2Z/bey0aJ1CbxKmcqrV0TGiRQt9yvo5PNh2pO5w3QaehSYhTwY
	zK7GZ4sHBP/45XCf0M0UG4TzmysJN9NsMHY4Rkk3z2GX4hs1eZP7JNspwC2GvW6eze7ALz8U
	THrFLOAO0zjKQiJGwpYi3G8pIKYGXrip4BM1ZQ7G41daJ0KZCfbFxb+ZKTkAp1dempQ92G3Y
	WSRzy3PZRfhBVQPhjsSshcF1w6+FUzd744clDioXeemnNeinNej/N+inNRgRVYYkyqTURLlS
	tTpMoUtSasPi9yea0cTnFB0dj7GhH/bttYhlkNRTHCeNUEgE8lSNLrEWYYaUzhH7GcIVEnGC
	XHeIV++PVR9Q8Zpa5MtQ0vniVc6DCRJ2jzyF38fzybz635RgPHzSkF/jpjL7Olu095qG5vFl
	5apdzxcFv/gg8/P3fpNZtzO0r/Jwig8R/ylAezvUcqTrgmu3b2BMs89djf3USjrg15Z5X+Py
	Ykc8549uXj+s8/vGW6PTP0dtgMwZC6L2zUo+ro25ao9vnxkpO7Z9xpITg+0bq2v2LizVtQUG
	Wdfq+1lXvb+U0ijkK0NItUb+F/ggX2Q1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX9P9+vm7Nc5fCePZ57a5JmPMfIHvvOHsRmWTd3qN3d0lTt3
	ykQpw03JYXRddp5Ksd12UsduV65nTCnZUSpFWKXoWQ2dZvrvtfd779dfb56Wn2Gn85qoo6Iu
	ShWp5KSMdMf6pCWdpSvVy9yXFWC1P+Dg/mAsZDc7WbDm5iPoHaqXQE9JOQe3b/bTYK1KZqDP
	/pOGT2UtEmjKamPAdbaAhpaLFRykJA/TcNp5j4LizEoWqvNTWbjy8y4NBQnNEqh9YuWg8cFv
	Fto8KQxUWnIYaEoNhjLbVOh/3oGgxF5AQf+FTA4u19g4aE1uQlBT3MJARmIqArvby8LwoJUL
	VpK8nLcUeWx5LyE2h4E8vBdITN4amjhyz3PE8cMsIQ1vXBypuD7MkMfOHoqkJH3jyPdP7xjS
	5a7jyO0v3RSx59Ux5IWtRLLTP0S6IUKM1BhF3dKNYVL1y8KHXMzVoNjzaQNcAiqda0J+PBZW
	4dcDnyU+ZoT52PzsEeVjTliIvd4h2scKYTG+477E+pgWmlj80nrIx5OF3fj1h/S/W5kAuME+
	gkxIysuFHITb89KpscIfV6Z/ZMbGC/HIjZpRKT/KATj7Fz8Wz8ZJjzL+xn7CLtyfFeyLpwjz
	cFF+OZWGJlnGiSzjRJb/Iss4kQ0xuUihiTJqVZrI1UH6w+q4KE1sUHi01oFGz5EVP3LJiXpr
	t3mQwCPlRFmYcqVazqqM+jitB2GeVipkM6zL1HJZhCruuKiLDtUZIkW9BwXwjHKabPteMUwu
	HFQdFQ+LYoyo+9dSvN/0BGSaoE05HT0xbc9657p6177WmY2JinNV2Uf8R9aWmdacKmyfHR/t
	H1Kt7TwUvsi9et0xV9WJW7Hm6lmtDTO6Q9FW44Gia1uKSId1gUH61Gx437wgPt5R+LXPu2bt
	RVrcP6fNUyukmjedmR8aM+nVRjy4uWDTdUOXqruVORkiXdHYZ1IyerVqeSCt06v+AH/V+y0Y
	AwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 10:55:54AM -0700, Mina Almasry wrote:
> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > Now that all the users of the page pool members in struct page have been
> > gone, the members can be removed from struct page.
> >
> > However, since struct netmem_desc might still use the space in struct
> > page, the size of struct netmem_desc should be checked, until struct
> > netmem_desc has its own instance from slab, to avoid conficting with
> > other members within struct page.
> >
> > Remove the page pool members in struct page and add a static checker for
> > the size.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mm_types.h | 11 -----------
> >  include/net/netmem.h     | 28 +++++-----------------------
> >  2 files changed, 5 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 873e820e1521..5a7864eb9d76 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -119,17 +119,6 @@ struct page {
> >                          */
> >                         unsigned long private;
> >                 };
> > -               struct {        /* page_pool used by netstack */
> > -                       unsigned long _pp_mapping_pad;
> > -                       /**
> > -                        * @pp_magic: magic value to avoid recycling non
> > -                        * page_pool allocated pages.
> > -                        */
> > -                       unsigned long pp_magic;
> > -                       struct page_pool *pp;
> > -                       unsigned long dma_addr;
> > -                       atomic_long_t pp_ref_count;
> > -               };
> >                 struct {        /* Tail pages of compound page */
> >                         unsigned long compound_head;    /* Bit zero is set */
> >                 };
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index c63a7e20f5f3..257c22398d7a 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -77,30 +77,12 @@ struct net_iov_area {
> >         unsigned long base_virtual;
> >  };
> >
> > -/* These fields in struct page are used by the page_pool and net stack:
> > - *
> > - *        struct {
> > - *                unsigned long _pp_mapping_pad;
> > - *                unsigned long pp_magic;
> > - *                struct page_pool *pp;
> > - *                unsigned long dma_addr;
> > - *                atomic_long_t pp_ref_count;
> > - *        };
> > - *
> > - * We mirror the page_pool fields here so the page_pool can access these fields
> > - * without worrying whether the underlying fields belong to a page or net_iov.
> > - *
> > - * The non-net stack fields of struct page are private to the mm stack and must
> > - * never be mirrored to net_iov.
> > +/* XXX: The page pool fields in struct page have been removed but they
> > + * might still use the space in struct page.  Thus, the size of struct
> > + * netmem_desc should be under control until struct netmem_desc has its
> > + * own instance from slab.
> >   */
> > -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> > -       static_assert(offsetof(struct page, pg) == \
> > -                     offsetof(struct net_iov, iov))
> > -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> > -NET_IOV_ASSERT_OFFSET(pp, pp);
> > -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> > -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > -#undef NET_IOV_ASSERT_OFFSET
> > +static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> >
> 
> Removing these asserts is actually a bit dangerous. Functions like
> netmem_or_pp_magic() rely on the fact that the offsets are the same
> between struct page and struct net_iov to access these fields without

Worth noting this patch removes the page pool fields from struct page.

However, yes, I will keep necessary assertions with some changes applied
so that it can work even after removing the page pool fields like:

NET_IOV_ASSERT_OFFSET(lru, pp_magic);
NET_IOV_ASSERT_OFFSET(mapping, _pp_mapping_pad);

> worrying about the type of the netmem. What we do in these helpers is
> we we clear the least significant bit of the netmem, and then  access
> the field. This works only because we verified at build time that the
> offset is the same.
> 
> I think we have 3 options here:
> 
> 1. Keep the asserts as-is, then in the follow up patch where we remove
> netmem_desc from struct page, we update the asserts to make sure
> struct page and struct net_iov can grab the netmem_desc in a uniform

Ah.  It's worth noting that I'm removing the page pool fields all the
way from strcut page, instead of placing a place-holder that I did in
RFC as Matthew requested.

> way.
> 
> 2. We remove the asserts, but all the helpers that rely on
> __netmem_clear_lsb need to be modified to do custom handling of
> net_iov vs page. Something like:
> 
> static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> {
>   if (netmem_is_net_iov(netmem)
>      netmem_to_net_iov(netmem)->pp_magic |= pp_magic;
>   else
>     netmem_to_page(netmem)->pp_magic |= pp_magic;

struct page should not have pp_magic field once the page pool fields are
gone.

	Byungchul
> }
> 
> Option #2 requires extra checks, which may affect the performance
> reported by page_pool_bench_simple that I pointed you to before.
> 
> 3. We could swap out all the individual asserts for one assert, if
> both page and net_iov have a netmem_desc subfield. This will also need
> to be reworked when netmem_desc is eventually moved out of struct page
> and is slab allocated:
> 
> NET_IOV_ASSERT_OFFSET(netmem_desc, netmem_desc);
> 
> -- 
> Thanks,
> Mina

