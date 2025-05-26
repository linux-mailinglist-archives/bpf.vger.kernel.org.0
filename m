Return-Path: <bpf+bounces-58913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD53AC37A8
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 03:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5151D3B4E3E
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792CD86349;
	Mon, 26 May 2025 01:15:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3272632;
	Mon, 26 May 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748222154; cv=none; b=m3z0iN8SH2c3zeJgmIbT8Gul5UZXet24hEeoLbDjZaeqUIFgL3PuBsmgYsU2yMo8JO3N2i65eKyMGk5d835NPQgoAgGsWTW/SRewKju4y5vgFQUnI23fw7TllaVoSyKs8j+xEF7kSMmwaqygn/wjLDEhlmkMtEPaOQhw5Xis2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748222154; c=relaxed/simple;
	bh=KnP9D4nEn84ADjghm0wYPiimIQxnyGqc/x5TYmetFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1AzmUUcVCe70efAANyf46tfgWTYg72FVvDaOzxSzYpNDSWN6WzQQ60EPRG5Ibg5j+tjNTijwZjfqQsvVd6XI8M64KklUYvIwu7pxzk5kCjaL6mdFJRvXM/9nrw2VoAQGG81y17QpBzJpWOKyC/PfKb3fkqZ0cuLGUdOI8KypyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0f-6833c0c0b097
Date: Mon, 26 May 2025 10:15:39 +0900
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
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250526011539.GB74632@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <CAHS8izPYrMMcqKiF1DmNqWW_=92joVrPE55rQTqGWaJ2=itHaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPYrMMcqKiF1DmNqWW_=92joVrPE55rQTqGWaJ2=itHaw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sf0zMYRzAcc99f9y3023fTvSoljkjZYiafYbR+sOemT8U/ulsuumbO66y
	u6QYizKkkmrKt692d36dNKerrstaOyfSGC3D+VkLYYqRWvqBrtb032vPZ8/n/fzxcJTKygRz
	+rQMwZimNahZBa3o97csd7ujdVHdrqUg2WtYuDGcBde6XQxI1U4Ev36/lsNAaxsLlyxDFEhP
	8mgYtI9Q8PF+jxy6rvbS0HyykYKesw9YKMwbpeC4yyaDDmcRA2UjVyhozOmWw9PbEgvvav4y
	0OsppKFdvE5DV1Es3DfPg6GHfQha7Y0yGCq4yEJpp5mF93ldCDrv9tBQeawIgb3Fy8DosMTG
	LiT111/KSJP4Vk7MjgOkzhZJ8r2dFHFUn2aJ42eJnLx53sySBxWjNGlyDchIYe43lvz4+Iom
	31uescRe/4wmj8ytcjLgCNvKJyrWJwsGfaZgXLkhSaFzfora3xee9bTWw+Sg8uB85MdhPgZ/
	+FIkm7btvWXSNL8YW04Vsz6zfDj2en9TPgfyEfhyyznGZ4rvYvBjaa/Pc3gDtpaO0T4recBf
	O9zyfKTgVLwN4bbBUnZqEIDbL3ygpy6H47Gqzoml3IRD8LU/3NTxApzbUDnZ8uPj8fi7kknP
	5Rdht7NN5tuJ+XoOj58fZKYePR/fsXnpYhQgzkiIMxLi/4Q4I2FGdDVS6dMyU7V6Q8wKXXaa
	PmvF7vRUB5r4OVePjGlc6GfHNg/iOaT2Vyapo3UqRptpyk71IMxR6kBlqBSlUymTtdmHBGP6
	LuMBg2DyoBCOVgcpVw8dTFbxe7QZwj5B2C8Yp6cyzi84B8UdtZauV3W4IOhw/+yKFBle6Y7Q
	3zxRrvuruGLXfA6VNOPHrZvLNNHZiXFrDeHLEm5Z238dXBK90+hXsyPsRa8mfdbG1wVSbfH2
	ecn2MwniybrKdZ8snjUDQQ3lVfGbSiKqiSfjXt1wiunMluAvwtHAxHvii5iouGKxzpPyijjV
	tEmnXRVJGU3af2EOoSQ1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sf0zMYRzAcc/3dzfHtxOeVbJdI7VJhu2zMTR/eNg0/jArjW76csd12h2p
	pknlV5Qow3W4kx9X4tbJdVmS01RjatfO8iNZlFbKj5JSpNNM/732fPa8P/98BFpxhPUXNLp9
	kl6n0io5GSOLWp65sKZmiTrCYxHBZCvl4NZQMtx852TBVOJAMDD8mof+2joOiiyDNJgasxj4
	bvtJQ8eTdh7abnQyUHWsgob20/Uc5GSN0JDhtFLw+FIDC02OXBYKfl6noSL9HQ/N900cvC0d
	Y6HTlcNAg7GYgbbc1fDEPAsGn35CUGuroGDw1CUO8t1mDt5ntSFwP25noPBwLgJbdQsLI0Mm
	brWSlBe/pEilsZUnZvt+ctcaRrJb3DSxl5zgiP3bWZ68eVHFkfoLIwypdPZTJCezjyNfO14x
	5HO1hyNFXV8oYiv3MOSZuZbf6BsjWxEvaTVJkn7RyjiZ2vExIvFTSHJzmYtNR+f9s5GPgMWl
	2PreQnnNiPOw5Xge5zUnhuCWlmHaaz8xFF+rPsN6TYttLH5u2u31DFGLr+aPMl7LRcA9TTV8
	NpIJCtGKcN33fG5i4IsbLn5gJj6H4NHL7vGoMO4AfPO3MPE8F2feK/y7y0fchH+9PfvXM8Vg
	XOOoo/LQNOOkknFSyfi/ZJxUMiOmBPlpdEkJKo12WbhhjzpFp0kO37E3wY7Gj+NG2ugZJxpo
	XutCooCUU+VxyiVqBatKMqQkuBAWaKWfPNAUoVbI41UpqZJ+73b9fq1kcKEAgVHOlq/fIsUp
	xF2qfdIeSUqU9P+mlODjn44OrJnPZ2+ICXoQW1VgsU95dTCwkZxrD9QHKXsVzTOE7gtTiuf0
	xT7cftLg6PNAt7W+9Ue0bmBdSs+2ptYHj6KnqwdDIwuLy/gh2bdIQ1d1UUbd2DG/nf3JOC3D
	Hf75qGdzecJwTLBv7+1Dq7ZW9t6pWvqVyki9onXGVm49EbQgilEyBrVqcRitN6j+ABfPTRkY
	AwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 10:00:55AM -0700, Mina Almasry wrote:
> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, reusing struct net_iov that already mirrored struct page.
> >
> > While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mm_types.h |  2 +-
> >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 56d07edd01f9..873e820e1521 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -120,13 +120,13 @@ struct page {
> >                         unsigned long private;
> >                 };
> >                 struct {        /* page_pool used by netstack */
> > +                       unsigned long _pp_mapping_pad;
> >                         /**
> >                          * @pp_magic: magic value to avoid recycling non
> >                          * page_pool allocated pages.
> >                          */
> >                         unsigned long pp_magic;
> >                         struct page_pool *pp;
> > -                       unsigned long _pp_mapping_pad;
> 
> Like Toke says, moving this to the beginning of this struct is not
> allowed. The first 3 bits of pp_magic are overlaid with page->lru so
> the pp makes sure not to use them. _pp_mapping_pad is overlaid with
> page->mapping, so the pp makes sure not to use it. AFAICT, this moving
> of _pp_mapping_pad is not necessary for this patch. I think just drop
> it.

Sure, I will.  Thanks.

> >                         unsigned long dma_addr;
> >                         atomic_long_t pp_ref_count;
> >                 };
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 386164fb9c18..08e9d76cdf14 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -31,12 +31,41 @@ enum net_iov_type {
> >  };
> >
> >  struct net_iov {
> > -       enum net_iov_type type;
> > -       unsigned long pp_magic;
> > -       struct page_pool *pp;
> > -       struct net_iov_area *owner;
> > -       unsigned long dma_addr;
> > -       atomic_long_t pp_ref_count;
> > +       /*
> > +        * XXX: Now that struct netmem_desc overlays on struct page,
> > +        * struct_group_tagged() should cover all of them.  However,
> > +        * a separate struct netmem_desc should be declared and embedded,
> > +        * once struct netmem_desc is no longer overlayed but it has its
> > +        * own instance from slab.  The final form should be:
> > +        *
> > +        *    struct netmem_desc {
> > +        *         unsigned long pp_magic;
> > +        *         struct page_pool *pp;
> > +        *         unsigned long dma_addr;
> > +        *         atomic_long_t pp_ref_count;
> > +        *    };
> > +        *
> > +        *    struct net_iov {
> > +        *         enum net_iov_type type;
> > +        *         struct net_iov_area *owner;
> > +        *         struct netmem_desc;
> > +        *    };
> > +        */
> 
> I'm unclear on why moving to this format is a TODO for the future. Why
> isn't this state in the comment the state in the code? I think I gave
> the same code snippet on the RFC, but here again:
> 
> struct netmem_desc {
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
>                        unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
> };
> 
> (Roughly):
> 
> struct page {
>    ...
>   struct {        /* page_pool used by netstack */
>      struct netmem_desc;

This is unnecessary since it will be removed shortly.

>   };
>   ...
> };
> 
> struct net_iov {
>     enum net_iov_type type;
>     struct netmem_desc;

This requires a huge change in a single commit since all the code
referring to any of the page pool fields, struct net_iov, and maybe
io_uring(?) should be altered at once.

Plus, much more changes are required since struct netmem_desc would not
overlay on struct page with what you suggest, which breaks the
assumption that struct netmem_desc overlays on struct page in the
current code.

So at least, the work should be started once the code doesn't need the
assumption.

Thoughts?

	Byungchul

>     struct net_iov_area *owner;
> }
> 
> AFAICT, this should work..?
> 
> -- 
> Thanks,
> Mina

