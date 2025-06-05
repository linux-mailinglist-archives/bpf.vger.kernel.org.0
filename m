Return-Path: <bpf+bounces-59695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D883ACE7A5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 02:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDE4189709D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDC381C4;
	Thu,  5 Jun 2025 00:54:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB043C2F;
	Thu,  5 Jun 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749084843; cv=none; b=T1PN5NTNGn22yLwOptGOeSWhTco8PZ7F/+psuYOEBSe2DH6BNEXpkOuqhxp3DAdNi5z8b77iG/E2I65ERH1cSXgNTDEVXw6HK0P9jYSoRxMlT+qgMb3TrHdAASxLjLQCG8eJ7jCQZX7u4FOSDhVb+yYeAT8lvysCF0QlhROTsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749084843; c=relaxed/simple;
	bh=AWmbqXr8HmHhWDjBHzH3d9h3bQexph0OE6Cl//0txsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz+uAWejEB+FKJLs+loo+9GtxwsxnY/Dh6YmCMEW58M8shBtxmPTBc3MIbqbFXFC1+4mCgqZFyCJZJiUvH1X5i6rHR/hy/f0TFwwqAzUYfodv1CW5MG6ulGkdXgYrkTes5ph1r7I1RUmvypEOP8OasQQX04W0zMm9M+c2nvzPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-13-6840eaa26553
Date: Thu, 5 Jun 2025 09:53:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 02/18] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
Message-ID: <20250605005349.GA37659@system.software.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-3-byungchul@sk.com>
 <CAJuCfpFCtGFRip72x8HadTfuv_2d+e19qZ2xJowaLa6V9JOGHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCtGFRip72x8HadTfuv_2d+e19qZ2xJowaLa6V9JOGHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+++cnR2Xq9O6/U0qWmViZBeC3ihUiOAEFVlkdIEcemrLabLp
	mkGgaUgjV2l0WUtWI1tTmS4vS2LmGt66KIvkdNUsg8IKnYk6L3mUyG8P7/O8z+/98NKE/K54
	Ca1Oy+C0aUqNgpKS0p+h99bZfsSpNnz3kGBxllFQOmSAB11uMVgcNQgGht9LIOBrosB2d5AA
	S1seCX+cIwT0NHZLoLPkGwlP8msJ6L7cTEFBXpCA8267CNprTGK4NnKfgNrsLgm8rrNQ8Kls
	QgzfvAUktJgfktBpioNG6yIYfN6LwOesFcHgpTsUFPmtFHzJ60Tgf9ZNwu0cEwKnhxdDcMhC
	xa1gqx6+FbGPzR8lrNWVyT6yR7FG3k+wLsdFinX1F0rYDx1PKLb5ZpBkH7sDIrYg9xfF9vW8
	I9nfnjcU66x6Q7IvrD4JG3At28cckW5P5jRqPaddH5MoVQUaikTpL+UGT2OvJBuNhRpRCI2Z
	zbipzkYYET2lv5RHCJJkVmFTQ7yQoJg1mOeHCUEvYKJwUeADZURSmmC6xfhesAIJxnzmMK7k
	eZGwK2MA/2pRCRk5Y0e4vbWHEjIyZh5uufWVFDQxWTpa7J/CEkw4fjBOT4+X49zq21OsECYe
	D09UT8UXMivx05omkdCJmac0Lq58QUyfH4Yb7Dx5Bc0zz0CYZyDM/xHmGQgrIh1Irk7TpyrV
	ms3Rqqw0tSE66XSqC00+Tsm50aNu1N9+wIsYGilCZYnxcSq5WKnXZaV6EaYJxQJZ4o9YlVyW
	rMw6y2lPH9dmajidF4XTpGKxbNPgmWQ5c1KZwaVwXDqn/eeK6JAl2eiUes+hYGvd6l1Gf1A1
	UW8rT8q/f9UxKzM5Z7Qf+7gbhTvm9s2WBUoiYq57FdTH/dHIvXNsq/uEodQW9p5fKx+rj9wW
	+fmKZ0ssLx4f33BnZKk65QJR8SohPcFzbE6Za+3eek8kOtlqqN7dljiamzGAupqfJ0Weqb7s
	ijjYoV+hIHUq5cYoQqtT/gXxo/aRNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe885OzsuJ8dldVLEWlEySSsKHkhy9MW3oMs+dSFsKw9tOGds
	aSpUmtJl5LooXeaqpZiXtOUyLxGiU9RpVkyKldZipYiJVjNzruuKyG9/nv/v+T1fHoaUFAoi
	GY3uCK/XqbRSWkSJtm8sWF02JlevqfTLwGKrpeHOTDZUvm0WgKWmEcGUf1AIvs5uGspvTZNg
	eVpIwRfbLAnDXV4heG6PUPDodBMJ3vM9NBQVBkg42VxFQMd1pwCeNZoEUDJbQUJT3lshDDy0
	0PCm9qcARhxFFDjN1RR4THLosi6C6b5xBJ22JgKmz12nodhlpeFdoQeBq8NLQWm+CYGt1S2A
	wIyFlktxQ/VLAreYXwux1Z6J71fJsNHtIrG95iyN7Z8vCfHQi0c07rkaoHBLs4/ARQUTNP40
	/IrCk63PaVw++pHAtobnFH5s7RTuDN8rSkzltZosXp+wSSlS+9qLicP9kuzWrnFhHvoeakQM
	w7HruXd1K4ORYldwpnaFEYUwNLuKc7v9ZDBHsDKu2DdEG5GIIVmvgCsL3EPBYgG7h6t3u4ng
	rpgFbsKpDjIStgpxz3qH6SAjZsM557X3VDCTv6XfbrjIIE+yUVzlD+bvOIYreFD651YIq+D8
	Px/8wReyy7m2xm7iAgozzzGZ55jM/03mOSYrompQhEaXla7SaDfEG9LUOTpNdvzBjHQ7+v0b
	t499u9iMpgaSHYhlkDRUrFTI1RKBKsuQk+5AHENKI8TKsSS1RJyqysnl9Rn79Zla3uBAUQwl
	XSzeuotXSthDqiN8Gs8f5vX/WoIJicxDy9t3nLIndVwObVn3ZV/cHWe0Qj6au6MvZmAs8mZd
	lPNMyivTtq0pCWGl5OJ5KR/COBSrGPmaX/1j/kT08YB1mqpb+iHWt7k/VXL6flrFsqNm113p
	vZyh2SuewdndpxoSp3pj8/N8qYnaA0RJXMxaZf2kd0tjm2PJPmrek/pk3YkZKWVQq9bKSL1B
	9QvNR7qxFwMAAA==
X-CFilter-Loop: Reflected

On Wed, Jun 04, 2025 at 08:14:18AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 3, 2025 at 7:53 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To eliminate the use of struct page in page pool, the page pool code
> > should use netmem descriptor and APIs instead.
> >
> > As part of the work, introduce netmem alloc APIs allowing the code to
> > use them rather than the existing APIs for struct page.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  net/core/netmem_priv.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> > index cd95394399b4..32e390908bb2 100644
> > --- a/net/core/netmem_priv.h
> > +++ b/net/core/netmem_priv.h
> > @@ -59,4 +59,18 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
> >         magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
> >         __netmem_clear_lsb(netmem)->pp_magic = magic;
> >  }
> > +
> > +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> > +                                           unsigned int order)
> > +{
> > +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> > +}
> > +
> > +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> > +                                                   unsigned long nr_netmems,
> > +                                                   netmem_ref *netmem_array)
> > +{
> > +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> > +                       (struct page **)netmem_array);
> > +}
> 
> Note: if you want these allocations to be reported in a separate line
> inside /proc/allocinfo you need to use alloc_hooks() like this:

Ah, it looks better to use alloc_hooks().  Thanks.

	Byungchul

> 
> static inline unsigned long alloc_netmems_bulk_node_noprof(gfp_t gfp, int nid,
>                                                    unsigned long nr_netmems,
>                                                    netmem_ref *netmem_array)
> {
>        return alloc_pages_bulk_node_noprof((gfp, nid, nr_netmems,
>                        (struct page **)netmem_array);
> }
> 
> #define alloc_netmems_bulk_node(...) \
>         alloc_hooks(alloc_netmems_bulk_node_noprof(__VA_ARGS__))
> 
> 
> 
> >  #endif
> > --
> > 2.17.1
> >

