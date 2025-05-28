Return-Path: <bpf+bounces-59149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E9AC660E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C5DA232EB
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56C278154;
	Wed, 28 May 2025 09:33:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9D1DF27D;
	Wed, 28 May 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424797; cv=none; b=Qgi/DRcuy9Qb8RWvfq3sEhQo2yVeFd46LsBvBxeut0UHl+qircv1QrgrLSzh5nKNru+XzIWHp6WkuDGwc6xm4CI3xRu2egukjl63fFMV1jQ/e09vs6iC5ek+IYX9HsTAre+TZTqfCFZuvlLnM+xt1GmeJ5VHdn+4RbGenx2hx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424797; c=relaxed/simple;
	bh=CfPnfHr9W94nu2DOrAYlWE0gmLEjs2BufMiWiQgXfQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzfSjXEageBDoiaSIoSJ/+CAhb04droElvPH+HI0EIzyksd3FMRNQwIqLrW9Su0FsIrVk8njFbDWue96N4PyQiIUCkafqrkIVT+XnGFAE5eULaCeD0a4cbEuF9dkArzxn6w0i4EmoEGHUqXrtPqjRDGXyjrESjvWFpPX8Y/a7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ab-6836d855b221
Date: Wed, 28 May 2025 18:33:03 +0900
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
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250528093303.GB54984@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
 <20250528081403.GA28116@system.software.com>
 <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
 <20250528091416.GA54984@system.software.com>
 <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX+/3/3u163bfk7xVebhEMsIUR/P/WXffzyMsWHi6Dd3XFeu
	B6WxpEm3inka1+EwerJdTt1dHhrnUi1LzuIilZBZqZRu1UXcNdN/773fn8/79fnjw9Gym6Ig
	TqVJFLQahVrOShjJd/+bC7e5IpSLSzMngcF0l4WSwRQoaLOJwFBsQfBz6L0Y+h3VLNy64abB
	8DKTgQHTMA1fnreLofVOBwOPsqw0tJ+pYSE300NDhq2QggZLngguDN+mwZreJobXDwwstNwd
	FUGHPZeBWn0RA615UfDcOBncdV0IHCYrBe6cqyycdxpZ+JTZisD5rJ2B/BN5CEyVLhF4Bg1s
	1CxSVtREkQr9BzExmpPI/cJQonM5aWIuzmaJue+cmDS/ecSSmssehlTY+imSe7KbJT++vGNI
	T2UjS0xljQx5YXSISb95+mZ+p2R1jKBWJQvasLV7JcqazhYqvmp6SkH1JZSO+ifrkB+H+WV4
	OLee1iHOp/t6k7w2w8/FlT0DlFez/Dzscg3RXh3AL8Cdb+1iHZJwNN8lwqYsC+MNJvEHcc67
	r6xXS3nA9qwnviEZ/5LG1tJaaiyYiGuvfPYt0H9bR645fWCaD8YFv7kxewY+WZ7vs/34Nbjo
	nr/XDuRn4yeWaspbiXkbhyselrBj90/FTwtdzFk0UT+OoB9H0P8n6McRjIgpRjKVJjlWoVIv
	W6RM1ahSFu2PizWjv59z59jILhvqa9hqRzyH5P5SUrpcKRMpkhNSY+0Ic7Q8QJqxLkIpk8Yo
	Uo8K2rg92iS1kGBHwRwjnyJd6j4SI+MPKBKFQ4IQL2j/pRTnF5SONox+i4z8mV4b9hhZi2Sn
	dqd1WBx7n10MDKei6+uT963fsWvHrwnz3y/fkBGlSimPdrocHu2mLaUhh0NLqjRDoWpnQaTH
	PfO4vqrBVtinnTMtJLyuV9d8MckZZwtpf9WWVrFiXfbHK4FNaXOur7r9dTRt++mm04buPSup
	W69nyDdG3JMzCUrFklBam6D4Ax8ZkRg1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe885OzsOZ8dlekowWEhilBVqD9j9iy8R0ZewJNBRh7byxqai
	RXjNkaStC5FzyiLyDjM1NyXUpnlJSZ1oK0tNmwaad815qZwS+e3P//c8v+fLw5CSu4LdjCIq
	lldGySKktIgSnQ9KO3DRGig/VPiQAJ2hjIbSpQQoHDIJQFdSjWDe3i+EuaYWGl48XyRB15lO
	wYJhmQRb87AQBgtGKXijNpIw/KCVhqz0FRJSTUUENOa1CaCrOlsAT5ZfkmBMHhJCT62OhoGy
	PwIYNWdR0KYtpmAw+xQ0691hsX0CQZPBSMDi/TwaHlv0NIykDyKwNA5TkJuSjcBQZxXAypKO
	PiXFVcWfCFyj/SrE+oo4XFnkizOtFhJXlNyjccXsIyH+0veGxq3PVihcY5ojcFbaJI1nbJ8p
	PFXXS+MXP6YJbKjqpXCHvkl4wTVUdOwaH6GI55V+J8JF8tbxASLmnVdCYctTlIzm3DMRw3Cs
	Pzc7HZeJnBiK9ebqphYIR6bZfZzVaicd2Y3dz41/NAszkYgh2QkBZ1BXUw6wg73B3f88Rjuy
	mAXOrG7YGJKwnSRnLG8jNoEr15bzfWOBXLeu5ltIx2GS9eQKfzOb9R4u7XXuRu3EHueKXzk7
	6p3sXq6huoXQIBftFpF2i0j7X6TdItIjqgS5KaLiI2WKiICDqpvyxChFwsGr0ZEVaP05Cu6s
	PjSh+Z5gM2IZJHUW4/IAuUQgi1clRpoRx5BSN3HqyUC5RHxNlniLV0aHKeMieJUZeTKU1EN8
	NoQPl7DXZbH8TZ6P4ZX/KME47U5G52pH8lI0tqCq0G9r6HRMQvlPe0+ID6/xudSV4moN8u62
	5FROX5kKztPVj9FDBuRT6nHGfOdo/Yz7bPpbYtw/6cj7XX1rS2H2krSMqe02Ineho/P2tsDT
	4mCvXx014S6u/SuT3caMXV6rRXv9SmfaNR8YWwB99NPl9qR8F3WRUUqp5LLDvqRSJfsLmbvC
	rxgDAAA=
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 10:20:29AM +0100, Pavel Begunkov wrote:
> On 5/28/25 10:14, Byungchul Park wrote:
> > On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
> > > On 5/28/25 09:14, Byungchul Park wrote:
> > > > On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
> > > > > On 5/26/25 03:23, Byungchul Park wrote:
> > > > > > On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> > > > > > > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > > > > > 
> > > > > > > > To simplify struct page, the effort to seperate its own descriptor from
> > > > > > > > struct page is required and the work for page pool is on going.
> > > > > > > > 
> > > > > > > > To achieve that, all the code should avoid accessing page pool members
> > > > > > > > of struct page directly, but use safe APIs for the purpose.
> > > > > > > > 
> > > > > > > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > > > > > > > page_pool_page_is_pp().
> > > > > > > > 
> > > > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > > > ---
> > > > > > > >     include/linux/mm.h   | 5 +----
> > > > > > > >     net/core/page_pool.c | 5 +++++
> > > > > > > >     2 files changed, 6 insertions(+), 4 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > index 8dc012e84033..3f7c80fb73ce 100644
> > > > > > > > --- a/include/linux/mm.h
> > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > > > > >     #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > > > > > 
> > > > > > > >     #ifdef CONFIG_PAGE_POOL
> > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > -{
> > > > > > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > -}
> > > > > > > 
> > > > > > > I vote for keeping this function as-is (do not convert it to netmem),
> > > > > > > and instead modify it to access page->netmem_desc->pp_magic.
> > > > > > 
> > > > > > Once the page pool fields are removed from struct page, struct page will
> > > > > > have neither struct netmem_desc nor the fields..
> > > > > > 
> > > > > > So it's unevitable to cast it to netmem_desc in order to refer to
> > > > > > pp_magic.  Again, pp_magic is no longer associated to struct page.
> > > > > > 
> > > > > > Thoughts?
> > > > > 
> > > > > Once the indirection / page shrinking is realized, the page is
> > > > > supposed to have a type field, isn't it? And all pp_magic trickery
> > > > > will be replaced with something like
> > > > > 
> > > > > page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
> > > > 
> > > > Agree, but we need a temporary solution until then.  I will use the
> > > > following way for now:
> > > 
> > > The question is what is the problem that you need another temporary
> > > solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
> > 
> > I prefer using the place-holder, but Matthew does not.  I explained it:
> > 
> >     https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/
> > 
> > Now, I'm going with the same way as the other approaches e.g. ptdesc.
> 
> Sure, but that doesn't change my point

What's your point?  The other appoaches do not use place-holders.  I
don't get your point.

As I told you, I will introduce a new struct, netmem_desc, instead of
struct_group_tagged() on struct net_iov, and modify the static assert on
the offsets to keep the important fields between struct page and
netmem_desc.

Then, is that following your point?  Or could you explain your point in
more detail?  Did you say other points than these?

	Byungchul
> 
> -- 
> Pavel Begunkov

