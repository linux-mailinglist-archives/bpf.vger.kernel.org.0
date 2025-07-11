Return-Path: <bpf+bounces-62989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20CB01089
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A491CA2B04
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA5481A3;
	Fri, 11 Jul 2025 01:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB4DDBC;
	Fri, 11 Jul 2025 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195787; cv=none; b=fHFwGxdWbhhEFBO4uO9vux3nnucioDHNgxggZ+FdykQ+HWwy+OeNv3HUHM1SnvNoDt2WQ/+0pOzzA+E/69JomcnXx9rXaQdTIROUGxsUCw331YTmMD6sAdQjBdyzuF+m8kkdl7p8GKYI1Z498CehD8G96nW0/2rJAtMffUgt2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195787; c=relaxed/simple;
	bh=jgthuvUu1Lw7rJCAYQk4VlnMNLSOEHxEc/VMepaFkuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrICApQBxGTlcnKTRNZixJwVwKq4iG7vMelGQxtMDJzcNdfx9TZXBjFrC4SakP5zibTC0VBHED5RQH97sOmYvZtrKhoertQ2OIfTx+2C0+VEzj4HmoLNlpdOF7w7SI+qQPI3wyCOQdI2qpkEaYHqzInI6qzBEIazLnGJTW6IVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-f4-687062c211be
Date: Fri, 11 Jul 2025 10:02:53 +0900
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
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
Message-ID: <20250711010253.GB40145@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2yLYRTHPX2va/byroaHLUhnwZLNCHIkwiIiDyFxSSTDMmUvbbZ1TTez
	CkkxEWXD3LuijK27UMq6rZmx7ioIyqjrpowPrOa27MJYLWLffvmfk//vfDg8pbjKjOM12gxJ
	r1WlKFk5Le8IPh/t3qBTx3YUzAGLvYyF0u4sKGqrZMBS4kTwvecFB9/qm1goONdFgeV+Ng0/
	7L0UtDf6OCh1LIPWwvc0VO+toMB3sJmFnOw+Cm70+DnYVWmTwQNnLgNHey9SUGFs4+CRy8LC
	67LfDLx359Bw21xMQ2tuHDRaR0PXnU8I6u0VMug6cJqFIx4rC2+zWxF46nw05O/MRWCv8TLQ
	1z3Qkd/wmoubROo+fabI9eJnMlJlfsURq2MLuWaLIiavhyKOkn0scXzN48jLJ9UsaT7ZR5Oq
	ym8ykrPbz5Iv7c9p8rmmhSX26y00uWut55aHrJHPTZJSNJmSftq89XL1h/J+RueLznru7+eM
	qCHChIJ4LM7Eriu13D++c+wxbUI8T4uRuMUYGYhZcTL2enuoAIeKU/GFmsOMCcl5SjSzuMXl
	owODkWIi7jzhlAVYEAFX1LrYACtEG8L+82gwD8G3T737u08NlP4846ECLkoMw0X9/GA8Ae8u
	z//rChJXYG+5iwnwKDEC33I2yQJeLN7lcXfnR3bw5rG41ualD6EQ8xCFeYjC/F9hHqKwIroE
	KTTazFSVJmVmjNqg1WTFbExLdaCBRyrc8XNtJfr6YJUbiTxSBgtxpWlqBaPKTDekuhHmKWWo
	cHmZTq0QklSGbZI+LVG/JUVKd6MwnlaOEWZ0bU1SiJtVGVKyJOkk/b+pjA8aZ0SWjoTW2SPy
	hq3bmxeWQLgp5OryBfuPm7QRvmTbvhjXh00Rhl1PBeHmjLNFTv3cY9pHTTmrOxdGv5hgDJ5v
	2NzLxedPLIsMPVtHEjeEf88Qyz6Gz9qj06DGeM8PgZqaca/6Uuz8Jv+i2MJRB4RT93Hq8KXT
	tz9c0jB+ePfNX+Er3yxW0ulq1fQoSp+u+gNj84kCRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9cHc6Oy+yUabQyUdQKMl4oxA9Fh8CoLwVS6MpDm206NhXt
	Qiuli6h5qaxt1tIydeJopTNT0VlOMbrMjKXVZJklzFuWZIrlishvP57n5fd8eWlMXEqspuWp
	6bw6VaqQkEJcuHd7TpTtiEq2eXg0GAzmOhJMP7Lg3lATAYbaRgTfZgcpmH5iJ6Hy9gwGhhe5
	OHw3/8TgU5ebApMlHlxVIzi0XLBi4L7cTUJB7hwGrbPjFJxrqhZAZ3kPAS8bCwm48vMuBlbt
	EAV9zQYSPtT9ImDEVoBDj64GB1dhHHQZA2Gm14PgidkqgJn8chJKHUYSPua6EDg63TjozxYi
	MLc5CZj7sejQP/1AxYVynZ4JjHtY81bAPdK9pzijJYN7UB3B5TkdGGepvURylq8lFPfuTQvJ
	dV+fw7lHTdMCriBnnOSmPg3g3ERbP8lVfpkUcOaH/fg+cYJwRzKvkGfy6k2xSULZ54YFQuWO
	yhoYX6C06On6PORDs8xWtvfqazwP0TTOhLL92lBvTDJhrNM5i3k5gAln77QVE3lISGOMjmT7
	m924t1jOJLKTZY0CL4sYYK0dzaSXxUw1Yscr0N/cn+25MfznHluUzt90YN4tjAli7y3Qf+O1
	bE6D/s+WD7OfdTY0E15ewaxn2xvtgiLkp1ti0i0x6f6bdEtMRoTXogB5aqZSKlfERGuOy7JT
	5VnRR9OUFrT4KlWn54ub0Le+3TbE0EjiK4ozpcnEhDRTk620IZbGJAGi+niVTCxKlmaf4NVp
	ieoMBa+xoSAal6wU7TnIJ4mZY9J0/jjPq3j1v1ZA+6zWogpfZ0p4X8tY8Kl1hpEWP+p+pf5a
	zMYNa/JPRW63u6zKgcOxZ74eOH9JP1H6jC25Zb+aEhHvjlZkPLDIX66ylYdMPz+xbEvkq1se
	8ejHsOEEeJy9reN6Ue988rMxdevQrrLJoItJpf6SAzeNh+oD3YM7TUEno9qvhPhKN3YPxnqm
	vkhwjUy6JQJTa6S/Acklu/gmAwAA
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 11:11:51AM -0700, Mina Almasry wrote:
> 
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To eliminate the use of the page pool fields in struct page, the page
> > pool code should use netmem descriptor and APIs instead.
> >
> > However, some code e.g. __netmem_to_page() is still used to access the
> > page pool fields e.g. ->pp via struct page, which should be changed so
> > as to access them via netmem descriptor, struct netmem_desc instead,
> > since the fields no longer will be available in struct page.
> >
> > Introduce utility APIs to make them easy to use struct netmem_desc as
> > descriptor.  The APIs are:
> >
> >    1. __netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
> >       but unsafely without checking if it's net_iov or system memory.
> >
> >    2. netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
> >       safely with checking if it's net_iov or system memory.
> >
> >    3. nmdesc_to_page(), to convert struct netmem_desc to struct page,
> >       assuming struct netmem_desc overlays on struct page.
> >
> >    4. page_to_nmdesc(), to convert struct page to struct netmem_desc,
> >       assuming struct netmem_desc overlays on struct page, allowing only
> >       head page to be converted.
> >
> >    5. nmdesc_adress(), to get its virtual address corresponding to the
> >       struct netmem_desc.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 535cf17b9134..ad9444be229a 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -198,6 +198,32 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
> >         return __netmem_to_page(netmem);
> >  }
> >
> > +/**
> > + * __netmem_to_nmdesc - unsafely get pointer to the &netmem_desc backing
> > + * @netmem
> > + * @netmem: netmem reference to convert
> > + *
> > + * Unsafe version of netmem_to_nmdesc(). When @netmem is always backed
> > + * by system memory, performs faster and generates smaller object code
> > + * (no check for the LSB, no WARN). When @netmem points to IOV, provokes
> > + * undefined behaviour.
> > + *
> > + * Return: pointer to the &netmem_desc (garbage if @netmem is not backed
> > + * by system memory).
> > + */
> > +static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
> > +{
> > +       return (__force struct netmem_desc *)netmem;
> > +}
> > +
> 
> Does a netmem_desc represent the pp fields shared between struct page
> and struct net_iov, or does netmem_desc represent paged kernel memory?
> If the former, I don't think we need a safe and unsafe version of this
> helper, since netmem_ref always has netmem_desc fields underneath. If

Ah, right.  I missed the point.  I will narrow down into a single safe
helper for that purpose.

> the latter, then this helper should not exist at all. We should not
> allow casting netmem_ref to a netmem_desc without first checking if
> it's a net_iov.
> 
> To be honest the cover letter should come up with a detailed
> explanation of (a) what are the current types (b) what are the new
> types (c) what are the relationships between the types, so these
> questions stop coming up.

I will.  Thanks for the feedback.

> > +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> > +{
> > +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> > +               return NULL;
> > +
> > +       return __netmem_to_nmdesc(netmem);
> > +}
> > +
> >  static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> >  {
> >         if (netmem_is_net_iov(netmem))
> > @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> >         return page_to_netmem(compound_head(netmem_to_page(netmem)));
> >  }
> >
> > +#define nmdesc_to_page(nmdesc)         (_Generic((nmdesc),             \
> > +       const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> > +       struct netmem_desc * :          (struct page *)(nmdesc)))
> > +
> > +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> > +{
> > +       VM_BUG_ON_PAGE(PageTail(page), page);
> > +       return (struct netmem_desc *)page;
> > +}
> > +
> 
> It's not safe to cast a page to netmem_desc, without first checking if
> it's a pp page or not, otherwise you may be casting random non-pp
> pages to netmem_desc...

Agree, but page_to_nmdesc() will be used in page_pool_page_is_pp() to
check if it's a pp page or not:

   static inline bool page_pool_page_is_pp(struct page *page)
   {
	struct netmem_desc *desc = page_to_nmdesc(page);

	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
   }

Hm.. maybe, it'd be better to resore the original code and remove this
page_to_nmdesc() helper.  FYI, the original code was:

   static inline bool page_pool_page_is_pp(struct page *page)
   {
	struct netmem_desc *desc = (struct netmem_desc *)page;

	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
   }

> > +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> > +{
> > +       return page_address(nmdesc_to_page(nmdesc));
> > +}
> > +
> >  /**
> 
> Introduce helpers in the same patch that uses them please. Having to
> cross reference your series to see if there are any callers to this
> (and the callers are correct) is an unnecessary burden to the
> reviewers.

I adopted how Matthew Wilcox worked on this[1], but sure, I will.

[1] https://lore.kernel.org/linux-mm/20230111042214.907030-3-willy@infradead.org/

	Byungchul

> --
> Thanks,
> Mina

