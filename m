Return-Path: <bpf+bounces-73993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13125C424A0
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6147034E8F2
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C812BE64A;
	Sat,  8 Nov 2025 02:25:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B329B8E1;
	Sat,  8 Nov 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568718; cv=none; b=DwcvMuodTdbybpLCYXb+tVkuTr1U8Own1lP7/cojwMq+L3ZvCst8B/WsQY+ksIwCDLXSMMCcZKtaPHNnKpyWFPxKfm/3v30DUg3bcwDeruubkpIF124ivrGovH+d5pF1DfxgCMWAMJPr1Pa5p2aP1NdcWJBjSSZm+FkT1fEUZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568718; c=relaxed/simple;
	bh=IbQzBuHgPKJgX8xgAJOM4Osw65EhhRg43Vwus9DHxHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPJzlJIG2Nl7/M5X9LYCB4QmfJGUknty8p7Z2rd/fhp3Y14Gg2wEwu7qKKPaocg+7J2ipxRSHcIk0O58oROf6tgecuW9/SOTaRhecmTDdpilA6IhWyklDwObLwBIgzY0QgbaE4k2YCQ8vAgSTRGR6HDhod1NRw2RcEmgYTGVC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-94-690eaa002d8e
Date: Sat, 8 Nov 2025 11:24:58 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251108022458.GA65163@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107174129.62a3f39c@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH99zn9rmXjuptB9vjS2JS3ZYQxWk0OSbTYEzMo9HExMwPM8us
	cpUboGCBWlzMyiRzI4IvgCmlmyVGwIoB2403i1HAIqgZwUhuJy/KqsYpLwElQI3I1Rj99sv/
	nPz+58MRsalLt1BUrNmyzWpJMxM9rx+OrVjxiW+e8k37IyN4amsIXJxyQNWDRh1M1zzhwOOr
	R/Bi+r4Asy0hBBPtHQSetY0jOFcxicHzTz4PL2tnMDQ1P0Hwv+sSgUehIQEu+rfDYOVjHoLH
	GjAMnbhJoDA/iqFlekSAXxqr58QBpwDd9UU6KJk5j6HB+UCAu80eAgM1szp43FrIQ6f7Ag9j
	pe0YBouSIOT9HCZvPUfQXtvAweTxPwjcK2vm4O+WewIU93gJ/Jc/iKCnbYiH0le/ESjPK0IQ
	nZpTjpx8oYPyGwNCUiLLU1XC2p6PYvbXhTDHel2neKZe7eJYk7tfYF5/DgtUJ7ACtQczv+93
	wvzjpwXW1xsk7KYryrOmh+tYU+MExwqPjpAd8d/rv02W0xS7bFu5YY8+RS0Ok8zLCxyhrlni
	RIPGAhQjUmkNHe/8k7zn4jt5uACJIi8to56OTC0m0tdUVaexxnFzcX6gjC9AehFLYwJ1qQM6
	bfCZlE3HRp1vlwwS0N7yCU5jkxTgaOTM/He5kXaWRXiNsZRA1ddPOa0LS4to1WtRi2OkVfTs
	04igcby0lF6r7+C0LirNitQ7NYze3bmAXq9W+ZNIcn+kdX+kdX/QehH2IZNitadblLQ1iSm5
	VsWRuC8j3Y/mPqzyyKvdjWi8e2crkkRkjjXsiRoUk85iz8pNb0VUxOY4w1prrGIyJFtyD8u2
	jB9tOWlyVitaJPLmLwyrJw8lm6QDlmw5VZYzZdv7KSfGLHSiEv3wrvqVfW6/cSbnyukfpuoc
	rkhGXVVl8Tq7ca+SFO35efH8oCt1WzjhbumzcuX+dx2JYWFb0qFrwsbwesPZ3Smpd4KB/q11
	q1egfztHCzcs/8rx0LKk+9e1tw/39x3tWpaxP8ri4tGmbPvSzQdDO0s+3VJxcN+VI1v0keBP
	vkvzvjTzWSmWVQnYlmV5A8tDvuVdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97ds5xtXacpkclotmFJCsr6ym7fQg6XYwwKgoqVx7aIV2y
	TdEomCVYI+1iF52TtMjUFqNZ3tII71pSGtrp5kwt6YJZmjS1liuivv34Pc///3x5GKyyyQIZ
	UWcU9DpNrJqSk/ItESdC3UVTxIUvzIvBardRcPN7EtzoLpeBy9ZPgLW4FMGw6yUN7uoGBEN1
	jRR8rP2K4Fr+CAbr41QSvtlHMVRU9iP4kHWLgrcNPTTcdESCs+AdCVVpZRh6zjRRkJ46hqHa
	NUDD8fLCieISEw21uc0yeFKaIYMLo9cxlJm6aXhaaaWgy+aWwbuadBKaLUUkDF6sw+DMWAsN
	eX4w8vATgjp7GQEjp3Mp6MiuJOBudQcNme15FPSmOhG01/aQcHH8JAU5KRkIxr5PVA6cHZZB
	Tn0XvXYBnyJJFF/76TPm7xQ9J/jOrHMkL91vIfgKy2uaz3Mk8CWFIbxZase8o/gUxTu+nqf5
	V51VFN+UNUbyFW+W8xXlQwSffmKA2uq3W74yRogVEwX9gtXRcq2U+ZyKvx2Q1NDipkzI6W1G
	XgzHLuEyW1OwGTEMyc7krI3xHk2xczhJcmEP+07o1JJs0ozkDGYHaS5L6pJ5Bj6skRv8bPq9
	pGCB68wZIjysYksIru+S8o/35pqz+0gPYzaEk36+Jzy3MBvE3fjJeLQXG8Zded9He3gqG8w9
	KG0kziKF5b+05b+05V86D+Fi5CvqEuM0Ymz4fMMhbbJOTJp/4HCcA038UMGx8XPlaPjp+hrE
	Mkg9WRE9phBVMk2iITmuBnEMVvsqwnWTRZUiRpN8RNAf3qdPiBUMNSiIIdX+io07hWgVe1Bj
	FA4JQryg/zslGK9AE1JueVZvvh+1efouu/GH0tm8rHdT+p5VbflDMZmLcsMjZ1zeu43rFpZq
	t0fOC9iQ4I8r868GiQWhgdNcxdlL9+/Y/GOFXfko48LotEnO9tm2j/eUew50+PfWRR1xPzCm
	TfnimqXS9q+LUY6Py7dag49GMMe9H67p9Rl8c1nRtiZg7s5WNWnQasJCsN6g+QV0ynHqPwMA
	AA==
X-CFilter-Loop: Reflected

On Fri, Nov 07, 2025 at 05:41:29PM -0800, Jakub Kicinski wrote:
> On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:
> > The offset of page_type in struct page cannot be used in struct net_iov
> > for the same purpose, since the offset in struct net_iov is for storing
> > (struct net_iov_area *)owner.
> 
> owner does not have to be at a fixed offset. Can we not move owner
> to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type
> only has 2 values we can smoosh it with page_type easily.

I'm still confused.  I think you probably understand what this work is
for.  (I've explained several times with related links.)  Or am I
missing something from your questions?

I've answered your question directly since you asked, but the point is
that, struct net_iov will no longer overlay on struct page.

Instead, struct netmem_desc will be responsible for keeping the pp
fields while struct page will lay down the resonsibility, once the pp
fields will be removed from struct page like:

<before> (the current form is:)

   struct page {
 	memdesc_flags_t flags;
 	union {
 		...
 		struct {
 			unsigned long pp_magic;
 			struct page_pool *pp;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
 		};
 		...
 	};
 	unsigned int page_type;
 	...
   };
 
   struct net_iov {
 	union {
 		struct netmem_desc desc;
 		struct
 		{
 			unsigned long _flags;
 			unsigned long pp_magic;
 			struct page_pool *pp;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
 		};
 	};
 	struct net_iov_area *owner;
 	enum net_iov_type type;
   };

<after> (the final form should be, just around the corner:)

   struct page {
 	memdesc_flags_t flags;
 	union {
 		...
		/* pp fields are gone. */
 		...
 	};
 	unsigned int page_type;
 	...
   };
 
   struct net_iov {
 	struct netmem_desc desc;
 	struct net_iov_area *owner;
 	enum net_iov_type type;
   };

After that, struct page and struct net_iov(or struct netmem_desc) will
not share any fields with each other, probably they will be connected
e.i. through some ways between struct page and netmem_desc tho.

	Byungchul
 
> > Yeah, you can tell 'why don't we add the field, page_type, to struct
> > net_iov (or struct netmem_desc)' so as to be like:
> >
> >   struct net_iov {
> >       union {
> >               struct netmem_desc desc;
> >               struct
> >               {
> >                       unsigned long _flags;
> >                       unsigned long pp_magic;
> >                       struct page_pool *pp;
> >                       unsigned long _pp_mapping_pad;
> >                       unsigned long dma_addr;
> >                       atomic_long_t pp_ref_count;
> > +                     unsigned int page_type; // add this field newly
> >               };
> >       };
> >       struct net_iov_area *owner; // the same offet of page_type
> >       enum net_iov_type type;
> >   };
> >
> > I think we can make it anyway but it makes less sense to add page_type
> > to struct net_iov, only for PGTY_netpp.
> >
> > It'd be better to use netmem_desc->pp for that purpose, IMO.

