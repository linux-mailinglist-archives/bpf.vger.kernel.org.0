Return-Path: <bpf+bounces-59115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E45CAC6109
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615ED1BC1DF3
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4441F582E;
	Wed, 28 May 2025 05:04:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283822F2F;
	Wed, 28 May 2025 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408641; cv=none; b=o6yOKr7svL+6oXtp/3sptgclJB4vSBEO4gJ+FI4r79IsPcaWy21xQOt+k8yeWvRAsv8ZXKZTFNZG1Ht5J7/+7akI9b4yKfrISsXyrS95oL0++ccvPQG+3l/IsKXp7seqiEVnlhsY8SozJqHDiAhWYjZsdioiYh4O+swOyQBahBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408641; c=relaxed/simple;
	bh=dt+569Mi8I/WnFbEt5T0NVUFcQVTHyRkAy3g66451z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SonbDvYq+Eyyk6H08GD6jFjGk8YRbmwOEoEHa5Q+S0l1shQflP9OhgqU7aIKi8N5NpQ2q1pV7gV+qwOuDNqn/yocVMTozAQ6WZivDbIqzMwKO7Kn1iwGA4xSNm0RIRY+251FHgmkO+bCxwDhAs5thY9hWrxAOXugLVlQ0WfvN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fa-68369938ff3b
Date: Wed, 28 May 2025 14:03:46 +0900
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
Message-ID: <20250528050346.GA59539@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
 <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
 <20250528012152.GA2986@system.software.com>
 <CAHS8izMvRrG2wpE7HEyK3t544-wN_h3SC8nGabCoPWj1qCv_ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMvRrG2wpE7HEyK3t544-wN_h3SC8nGabCoPWj1qCv_ag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2xLYRiA8/V85/SsWTmr4TNBVIQtzCW2vMxl4vb98IOQSEjQ2YmWruPs
	YpNgrCGbte4JVXTDdNOodLOLLLPVzBbCVDZlrLO5hMxto8OW4VjE/j153rx53h8vz2gusBG8
	wZQqSiadUcupsOpDaP50OBOrn2npHQN2t4uDq98z4Ep7BQv24jIEX3+0KqGn7i4HF/ODDNgf
	mjF8c/9k4HV9hxIChW8wVB0qZ6DjSAMHFnMfAwcqnApoKrOycPLnZQbKs9qV8PimnYM21y8W
	3ngtGBptRRgC1niod4yC4L0uBHXucgUE885xcMLn4KDTHEDgu92B4ex+KwJ3tZ+Fvu92Ln4i
	LS16qqCVthdK6vCk0RJnFM31+xjqKc7hqKf7uJI+b6niaMPpPkwrK3oU1JL9kaNfXj/D9FN1
	M0fdpc2Y3nfUKWmPZ/wqYb1qfqJoNKSL0oyFm1X6mpo6dkfP3IzSwn1ZyBmZi0J4IswhOeZe
	lIv4v1xgXS5rLEwmbW+bkcycMIX4/T8YmcOFSHKp+hgrMyMEWPLAvk3mEYKRFJzoxzKrBSAv
	u1yczBrhvoL0Fiwe9GGk8cwrPLg7hfSf9zFylhHGkisD/KCeQLJvnP2rQ4TV5NWxtbIeKUwi
	NWV3FblI9efIUp6c8ubhwevHkFqnHx9FYbYhBduQgu1/wTak4EC4GGkMpvQkncE4J1qfaTJk
	RG9JTvKgP29TuKd/QwXqblrjRQKPtKFqej1Gr2F16SmZSV5EeEYbrj6wKFavUSfqMneLUvIm
	Kc0opnjRWB5rR6tnB3claoStulRxuyjuEKV/UwUfEpGFlJFTR5ZtiFt5/H3LvFGpSwrjWuK+
	BZ5JxLJn7+TOgeiwBcmm6+8/jEuY1itYk6M87/JqB+48WlmZDzubGs+XHB1WcuvJrWjPRinh
	cMbwInPftGut7Ir8eZeWNYSti18RcU04dznUHK6I0K/yrc6sytnWlRZM/7x0eHaTK6G5O0bq
	OKjFKXrdrChGStH9BguV5TsyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyMcRzA97vn5Z6Os8cp/VY222EtG2GyrzHyB35sLKa1aejwrDuulz2X
	umwpV4ZUpELntFP0pjlO6ryl3eWq1YosDr1Jhc28lV503k4z/ffZ57vv5/vPl6MUBsaP08TE
	C2KMSqtkZbRs66q0RVCwQr0kr00GJkslC9fG9FDaa2PAVFGNYHj8lRSG6htYKL48QoGpLZ2G
	b5bvFAw4+6TQUzJIw/3jNRT0nW5kISt9ggKDrUwCjktNDDyuzmYg7/tVCmpSe6Xw9K6Jhe7K
	XwwM2rNoaDKW09CTHQJO82wYaf6AoN5SI4GRzEss5LabWXiT3oOg3dFHw8Wj2QgstS4GJsZM
	bIiSVJW/kJA7xi4pMVsPkVtlC0mGq50i1oqTLLF+PSslnc/us6TxwgRN7tiGJCQr7SNLvgy8
	pMmn2g6WFL/7LCGWqg6atJjrpaEzd8pW7xe0mgRBDFoTKVPX1dUzcUMr9VUlKamoLDADcRzm
	l+Oi7A0ZyIuj+QW4+20H8jDLB2CXa5zysDcfiK/U5jAepvgeBreaDnh4Fq/FRblu2sNyHvDr
	D5WshxV8iwSPFq2b9DNxU0E/PbkbgN2F7ZTnLMX749Kf3KSei9NuX/yrvfhtuD9nh0f78PNw
	XXWD5AyaYZwSMk4JGf+HjFNCZkRXIG9NTEK0SqMNXqw7qE6K0egX74uNtqI/n1GS7M6xoeGn
	G+2I55ByupzcCFYrGFWCLinajjBHKb3lhrUr1Ar5flXSYUGM3SMe0go6O/LnaKWvfHO4EKng
	o1TxwkFBiBPEf1MJ5+WXik60JnqdKfzxIErUNEY4ardUv49P6XPHLt3rxLvYucuCWudMOze6
	1rgh+MdO/yf5m4a50LFxQ+76YlVmsq1r8OHozaC8U7xhe5iz2XzqtHfikfkpUZEhixwnPn9a
	JxSE2V4cu+Z7vj/TnLg3nHTpu+75dObfrWuOeO5oWXL9UbIYsltJ69SqpQspUaf6DRFxYQ4V
	AwAA
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:47:54PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 6:22 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Tue, May 27, 2025 at 01:03:32PM -0700, Mina Almasry wrote:
> > > On Mon, May 26, 2025 at 7:50 PM Byungchul Park <byungchul@sk.com> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 12:25:52PM +0900, Byungchul Park wrote:
> > > > > To simplify struct page, the page pool members of struct page should be
> > > > > moved to other, allowing these members to be removed from struct page.
> > > > >
> > > > > Introduce a network memory descriptor to store the members, struct
> > > > > netmem_desc, reusing struct net_iov that already mirrored struct page.
> > > > >
> > > > > While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> > > > >
> > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > ---
> > > > >  include/linux/mm_types.h |  2 +-
> > > > >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
> > > > >  2 files changed, 37 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > > index 56d07edd01f9..873e820e1521 100644
> > > > > --- a/include/linux/mm_types.h
> > > > > +++ b/include/linux/mm_types.h
> > > > > @@ -120,13 +120,13 @@ struct page {
> > > > >                       unsigned long private;
> > > > >               };
> > > > >               struct {        /* page_pool used by netstack */
> > > > > +                     unsigned long _pp_mapping_pad;
> > > > >                       /**
> > > > >                        * @pp_magic: magic value to avoid recycling non
> > > > >                        * page_pool allocated pages.
> > > > >                        */
> > > > >                       unsigned long pp_magic;
> > > > >                       struct page_pool *pp;
> > > > > -                     unsigned long _pp_mapping_pad;
> > > > >                       unsigned long dma_addr;
> > > > >                       atomic_long_t pp_ref_count;
> > > > >               };
> > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > index 386164fb9c18..08e9d76cdf14 100644
> > > > > --- a/include/net/netmem.h
> > > > > +++ b/include/net/netmem.h
> > > > > @@ -31,12 +31,41 @@ enum net_iov_type {
> > > > >  };
> > > > >
> > > > >  struct net_iov {
> > > > > -     enum net_iov_type type;
> > > > > -     unsigned long pp_magic;
> > > > > -     struct page_pool *pp;
> > > > > -     struct net_iov_area *owner;
> > > > > -     unsigned long dma_addr;
> > > > > -     atomic_long_t pp_ref_count;
> > > > > +     /*
> > > > > +      * XXX: Now that struct netmem_desc overlays on struct page,
> > > > > +      * struct_group_tagged() should cover all of them.  However,
> > > > > +      * a separate struct netmem_desc should be declared and embedded,
> > > > > +      * once struct netmem_desc is no longer overlayed but it has its
> > > > > +      * own instance from slab.  The final form should be:
> > > > > +      *
> > > > > +      *    struct netmem_desc {
> > > > > +      *         unsigned long pp_magic;
> > > > > +      *         struct page_pool *pp;
> > > > > +      *         unsigned long dma_addr;
> > > > > +      *         atomic_long_t pp_ref_count;
> > > > > +      *    };
> > > > > +      *
> > > > > +      *    struct net_iov {
> > > > > +      *         enum net_iov_type type;
> > > > > +      *         struct net_iov_area *owner;
> > > > > +      *         struct netmem_desc;
> > > > > +      *    };
> > > > > +      */
> > > > > +     struct_group_tagged(netmem_desc, desc,
> > > >
> > > > So..  For now, this is the best option we can pick.  We can do all that
> > > > you told me once struct netmem_desc has it own instance from slab.
> > > >
> > > > Again, it's because the page pool fields (or netmem things) from struct
> > > > page will be gone by this series.
> > > >
> > > > Mina, thoughts?
> > > >
> > >
> > > Can you please post an updated series with the approach you have in
> > > mind? I think this series as-is seems broken vis-a-vie the
> > > _pp_padding_map param move that looks incorrect. Pavel and I have also
> > > commented on patch 18 that removing the ASSERTS seems incorrect as
> > > it's breaking the symmetry between struct page and struct net_iov.
> >
> > I told you I will fix it.  I will send the updated series shortly for
> > *review*.  However, it will be for review since we know this work can be
> > completed once the next works have been done:
> >
> >    https://lore.kernel.org/all/20250520205920.2134829-2-anthony.l.nguyen@intel.com/
> >    https://lore.kernel.org/all/1747950086-1246773-9-git-send-email-tariqt@nvidia.com/
> >
> > > It's not clear to me if the fields are being removed from struct page,
> > > where are they going... the approach ptdesc for example has taken is
> >
> > They are going to struct net_iov.

Precisely speaking, to 'struct netmem_desc'.

> Oh. I see. My gut reaction is I'm not sure moving the page_pool fields
> to struct net_iov will work.
> 
> struct net_iov shares some fields with struct page, but abstractly
> it's very different.
> 
> struct page is allocated by the mm stack via things like alloc_pages
> and can be passed to mm apis such as put_page() (called from
> skb_frag_ref) and vm_insert_batch (called from
> tcp_zerocopy_vm_insert_batch_error).
> 
> struct net_iov is kvmalloced by networking code (see
> net_devmem_bind_dmabuf for example), and *must not* be passed to any
> mm apis as it's not a struct page at all. Accidentally calling
> vm_insert_batch on a struct net_iov will cause a kernel crash or some
> memory corruption.
> 
> Thus abstractly different things maybe should not share the same
> in-kernel struct.
> 
> One thing that maybe could work is if struct net_iov has a field in it
> which tells us whether it's actually a struct page that can be passed
> to mm apis, or not a struct page which cannot be passed to mm apis.
> 
> > Or I should introduce another struct
> 
> maybe introducing another struct is the answer. I'm not sure. The net

The final form should be like:

   struct netmem_desc {
      struct page_pool *pp;
      unsigned long dma_addr;
      atomic_long_t ref_count;
   };

   struct net_iov {
      struct netmem_desc;
      enum net_iov_type type;
      struct net_iov_area *owner;
      ...
   };

However, now that overlaying on struct page is required, struct
netmem_desc should be almost same as struct net_iov.  So I'm not sure if
we should introduce struct netmem_desc as a new struct along with struct
net_iov.

> stack today already supports struct page and struct net_iov, with
> netmem_ref acting as an abstraction over both. Adding a 3rd struct and
> adding more checks to test if page or net_iov or something new will
> add overhead.

So I think the current form in this patch is a good option we can take
for now.

> An additional problem is that there are probably hundreds or thousands
> of references to 'page' in the net stack and drivers. I'm not sure
> what you're going to do about those. Are you converting all those to
> netmem or netmem_desc?

No.  I will convert only the references for page pool.

	Byungchul

> 
> -- 
> Thanks,
> Mina

