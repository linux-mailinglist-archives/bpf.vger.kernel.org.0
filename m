Return-Path: <bpf+bounces-59120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1993AC6178
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7047A91A0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8320DD4D;
	Wed, 28 May 2025 05:56:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E3382;
	Wed, 28 May 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411799; cv=none; b=sBrs2XZ3BOIRRpFMgoWwmUjRc0uiliPXxCcWEy0NF5dXJuYtcuts+nkl07NbkUQ5gk2pxxisCQfmqEeB6L8iRP5k/TQ+Z9lh+QTQTuim6tdwefFvzzWyGXaHrapLI1rF9owvtyCgYELN857dB2XEMRuW2phPBe2msjwc397d7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411799; c=relaxed/simple;
	bh=X99puUxvPH/bppFqEF/37i/DLRj5Pyc7gUk5/d2kbZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXPzY4BQROjl6bRtEZFKhtcPALbYdEwYlIfdZmLqG4cx+siqlSNhOf3sL7wVo+mfXg5ZczzD4AzQ4e8MozdS/tYkAgx2oauj0HslxAOLQyoJ/z4TFqhbE/R4QV2BqEwgQghEKFgaE2YS8sPWgpQ+gHuQVfmebUYXgiFPecdLb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e4-6836a58e1e56
Date: Wed, 28 May 2025 14:56:25 +0900
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
Subject: Re: [PATCH v2 08/16] page_pool: rename
 __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Message-ID: <20250528055625.GC9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-9-byungchul@sk.com>
 <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGeXfOzo7LyXGZvSqUzSKStBLNt5CUqHgLgsrqR0U18tRWOmVT
	UyNQk6SV86NAm7O21LZMmMzSabJ0iRaV2tKcqSmr/KNZag0/0nKOyH8X93M/XM+PhyaEOq4/
	LZUls3KZOF5E8Un+N09dSH7ldsnWpkYCaYzVFHo8nYb0w2Yu0lTVAfRzpp+HplrbKVSucy42
	OnNI9Ms4S6CvbQ4eGno4QqKm3HoCOfJfUigvZ45A2WYDB3XVqbjozmwlgeozh3nofaOGQp+q
	/3DRiDWPRK/Uj0g0pIpBbVpf5Hw9BlCrsZ6DnLfKKHTbpqXQ55whgGwvHCQqzVIBZLTYuWhu
	WkPFrMNPHvVxcIN6kIe1phRcawjGSruNwKaqGxQ2TRbx8MCHJgq/LJkjcYN5ioPzro1TeOLr
	RxJ/t/RQ2Pikh8RvtK08PGVac4g5wY+KY+Olqax8y66zfMn10WZO0sTKNMfzcioTtHkpgQcN
	mXBYUaviKAG9xD8GY10xyWyABZ11lIspZiO022cIF/swm2CFpZDrYoIZ4sIOzUUXr2SSYXv3
	+FJfwERCu8Gy2OHTQsYA4Py0heceeMNXd7+Q7uWN8Pc9G+HyEkwA1C/Q7ngtvPa0dMnlwRyG
	ZdX2JV7FBMHmunaO+2QzDXvfhrnZD7YY7GQB8FYvM6iXGdT/DeplBi0gq4BQKktNEEvjw0Ml
	6TJpWui5xAQTWHych1d/nzSDya5YK2BoIPIU4JoIiZArTlWkJ1gBpAmRjyA7ertEKIgTp2ew
	8sQz8pR4VmEFATQpWi0Ic16OEzIXxMnsJZZNYuX/phzawz8T6DO8rtqC9wUGzyij5hXKQqtz
	oCTy+BXf4gJd2B6/WfpgYonfA+93OzzuNB+o2bXe1B1yk8oodxSMPZataB6tOVXa25Pb0a8f
	Oc/sLuqT1bZEF+7NqgiSC9OeZQfmLnhGb546U0+HiTMdxfuLdfyoiKz+Y0d3Zh3p6j99VJVw
	P9spIhUS8bZgQq4Q/wU3diWLNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX9P9+u49nMO35WNHWYYZROfZMSMr/6wjKV57Jbf3Ol6cJd2
	hS11xKnj8AfXZZeUSnMJPVg76TlM5GHnsXal2SiVnshTVzP999rn/f68Pv98eFp+gvXhNTHx
	oi5GpVVyUka6JSh1iTl3hdq/f8AfbI4iDm4MG+B6WzkLtsJSBP3f30rgW20DBznZgzTYmo0M
	DDh+0PCx3i2B1rxOBirTymhwn23kIMM4QkNKeT4FNVlNLDwtNbNw8UcuDWXJbRJ4fs/GwYei
	Pyx0Vmcw0GQtYKDVHAz19hkw+OgLglpHGQWD6VkcXGixc9BubEXQUuNmIPO4GYHD6WJhZNjG
	BSvJnYLXFKmwvpcQe8lhcjt/ETG5WmhSUniaIyV95yXk3atKjjReGmFIRfk3imSkdnOk9+Mb
	hnx1vuRIzqceijjuvGTIY3utJHTqTunq/aJWkyDq/NZESNUnP1dRcb3TDO77OVwyqvc2IZ7H
	wnLc836bCXnxjDAfn2su5TzMCQuwy/Wd9rBCWIivOS2sh2mhlcVPbAc9PE2Ixw0vusf6MmEl
	duU7RztSXi7kI/xr2CkZD6bipssdzPjyAvzzSgvtuUsLvvj6b358PBun3s0cu+UlbMVZRa4x
	ni7MxVWlDdQ55G2dYLJOMFn/m6wTTHbEFCKFJiYhWqXRBizVR6kTYzSGpZGx0SVo9Dnyjv20
	lKP+55uqkcAj5RQZKQ5Qy1lVgj4xuhphnlYqZClrV6jlsv2qxCRRF7tPd1gr6quRL88oZ8pC
	dogRcuGAKl6MEsU4UfcvpXgvn2TUGOl7lDJp0rol7fWxdHbVMNwqPq1NCNmN807WiXV7tyn2
	rd+ekWReP4fuCzNEnDI/bju/ymLURhknz9uz8UbX2ewhPzqooMsyY12cJjyvwnBIfjUlLC5t
	gz1zV5fPsUfdD5iOM43h4YHEsnjzrPSbQ9vfHn826chvb9O60CTFw0Alo1erli2idXrVXx7P
	cGYYAwAA
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:21:32PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > Now that __page_pool_release_page_dma() is for releasing netmem, not
> > struct page, rename it to __page_pool_release_netmem_dma() to reflect
> > what it does.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  net/core/page_pool.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index fb487013ef00..af889671df23 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
> >         netmem_set_pp(netmem, NULL);
> >  }
> >
> > -static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> > -                                                        netmem_ref netmem)
> > +static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
> > +                                                          netmem_ref netmem)
> >  {
> >         struct page *old, *page = netmem_to_page(netmem);
> >         unsigned long id;
> > @@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
> >         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> >                 put = pool->mp_ops->release_netmem(pool, netmem);
> >         else
> > -               __page_pool_release_page_dma(pool, netmem);
> > +               __page_pool_release_netmem_dma(pool, netmem);
> >
> >         /* This may be the last page returned, releasing the pool, so
> >          * it is not safe to reference pool afterwards.
> > @@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
> >                 }
> >
> >                 xa_for_each(&pool->dma_mapped, id, ptr)
> > -                       __page_pool_release_page_dma(pool, page_to_netmem(ptr));
> > +                       __page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
> 
> I think this needs to remain page_to_netmem(). This static cast should

Do you mean to ask to revert the casting patch of page_to_netmem()?

Or leave page_to_netmem(ptr) unchanged?

I added the casting '(struct page *)ptr' above to avoid compliler
warning..  Do you see another warning on it?

	Byungchul

> generate a compiler warning since netmem_ref is a __bitwise.
> 
> -- 
> Thanks,
> Mina

