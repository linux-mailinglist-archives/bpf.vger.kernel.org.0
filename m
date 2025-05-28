Return-Path: <bpf+bounces-59118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318ABAC6141
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2358C1BC2EC4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3678D20C00C;
	Wed, 28 May 2025 05:27:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBC1FFC41;
	Wed, 28 May 2025 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748410023; cv=none; b=BIxhm9QOFbBimhTGodS2MHDFekpf0EZniSY3ulo0+bszljYYI/fN92bLvt0yegxiFYYnT/CklJUV8z3qiXrwb2MUcX0GuqL/YxEf5QAAbwhuT11psCp+i4PK9U/HvtXVT2iU8YRkm8xKTOap09f0TOJ63s5N5XPLKGv3nuPccbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748410023; c=relaxed/simple;
	bh=vlDhKjejOD4pBwO+Mqai5sYH1ZPgWIOBUfvckYb9ao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyNrAGQtFwWO8jWuCvlL0pfkWTb4e1lm0XruCVqVdtehfPiVENSywWaB6UUObwcIBGh93C2LiIeIAL1NfddGcIylQSwyGvTos9fVG/RjYQ/587/vpEPzI2f2drSui2esSilaIKC1RneES4OWDZmJTDZMjvFnxTvTEUq41Y+mlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e8-68369e9f1f62
Date: Wed, 28 May 2025 14:26:50 +0900
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
Subject: Re: [PATCH v2 02/16] netmem: introduce netmem alloc APIs to wrap
 page alloc APIs
Message-ID: <20250528052650.GA9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-3-byungchul@sk.com>
 <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03SWUxTQRSA4czdemmoXirqCIlLxaAk1AXR82AU3sb44h4jMdjIja0skqJY
	XEJliUoE90RKhSICZYklFUrdUJAA7ohoCgg1ICQqimwNUKNS0MjblzmZ88/D8LS8gPXjNXFH
	RG2cKkbBSRnpN+/84LzcdepVjmwlGC3lHJSN6aD4o50FY6kNwch4hwSG6xs5KMh30WB8ncbA
	qGWCht6Gbgk4i/oYeHCmmobuC00cZKa5aUixmylotmWxcHWikIZq/UcJvL1n5KCr/DcLfXWZ
	DDw1lDDgzAqDBtM8cD3vR1BvqabAdf4GB1daTBz0pDkRtDzpZiDndBYCS42DBfeYkQtbQipL
	2ihy19ApISbrUXLHHEQyHC00sZae44h16LKEfHj/gCNN190MuWsfpkhm6neODPa2M2Sg5h1H
	LJXvGPLCVC8hw9aFW4W90g1RYowmUdSu3Lhfqu5sv0bFt83WpZtrkR6leWcgLx4La3Ht2VLq
	nxszh6fMCMtwW2sP7TEnBGKHY3zKvsIKfKvmEusxLThZ/Mp4yOM5QgRO/1rGeCwT1mPnuYco
	A0l5uWBG2KFvpaYHPvhp9idm+nIg/pnbMrmUn7Q/Lv7FTx8vwqlVOVMtL2Eb1t+3T3musBQ/
	tjVSnp1YsPP4c03X30cvwLVmB3MR+RhmJAwzEob/CcOMhAkxpUiuiUuMVWli1irVSXEanfLA
	4Vgrmvw6Rad+RtjRUPOOOiTwSOEtIxWhajmrSkxIiq1DmKcVvrKUTevUclmUKum4qD0cqT0a
	IybUIX+eUcyXrXEdi5ILB1VHxGhRjBe1/6YU7+WnR8EhO1N06cv3JV8O2MLmKH4NuZexSlvk
	saiOD9EO97aAxcntIW9Wjuw7EJ99LfVzf17XzV2PTuQuLNpq3WxX5qUOmuZa/QdstReedTnH
	d0sUbyqCqrZA6LfWWS+2j42G64rDC1/PCbxk113NfX47rG1PydeOwuYA19vwlyeL/cZ7fnxR
	MAlq1eogWpug+gPFO8XlNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03SW0iTYRjAcd/vtM/h8nNZfmhQTUM0O5L2QCepoJcuwuhCqItc+dlmbspm
	Q4Ng6exgadkBak5bWToPMDHTZSY1JdOiQi2nVqt5JtM8ohmVUyLvfrwP7/+5eVhSeo72Z5Xq
	ZEGjlifIGDElPrAtfd2d/AjFxtnBFWCyljFQOp0CRV9sNJhKqhBMzHSJYLyhkYGCu1MkmN4a
	KJi0/iSh94VLBM7CPgpqz1eT4LrykoEswywJaTYLAfV5TTS8q8qm4cbPByRU67+IoLXGxMDn
	sj809NmzKGgyFlPgzI6EF+blMPVqCEGDtZqAqct5DFxvMTPQbXAiaKl3UZB7NhuBtc5Bw+y0
	iYmU4criDgI/Nn4SYXPFKfzQEoozHS0krii5yOCKsWsi/PFDLYNf3pql8GPbOIGz0ocZPNrb
	SeGRuvcMLhj4QWBr5XsKvzY3iKJ8Dou3xwoJSp2g2bAzRqz41HmTSOrwTsmwPEd6ZPDKRJ4s
	z23hG7PGCbcpbg3f0dZNus1wwbzDMTNvXy6Ev1+XQ7tNck6af2OKd3spd4TP+FZKuS3htvLO
	i09RJhKzUs6CeIe+jVgY+PBNt3uohc/B/K/8lrkoO+cAvug3u/C8kk9/lDu/y5M7yOuf2Oa9
	jAvkn1U1ElfREuOiknFRyfi/ZFxUMiOqBPkq1TqVXJkQvl57UpGqVqasP56oqkBz11F45leO
	DU207rMjjkUyLwkuD1dIablOm6qyI54lZb6StF0RCqkkVp56WtAkHtWcShC0dhTAUjI/yf5o
	IUbKnZAnCycFIUnQ/JsSrKe/HgWO3q/c1L9770hQHO416XJUQ+XtbQX3QgaFmIJQdfj1Hb+P
	1W0I7Apu9vMQHXrjZ8kL8i7sj3oUYv3jkg+Hh6l0fdPfu8ZWx9uj2yNSktcO+aXe3TMmRQEu
	37C4QTM1uFm33f/C3qhJ56r0gZqvKLLVo37FmfPVse+aL63MizP0yCitQr4plNRo5X8B5kAK
	NhkDAAA=
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:11:58PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To eliminate the use of struct page in page pool, the page pool code
> > should use netmem descriptor and APIs instead.
> >
> > As part of the work, introduce netmem alloc APIs allowing the code to
> > use them rather than the existing APIs for struct page.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index a721f9e060a2..37d0e0e002c2 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -177,6 +177,19 @@ static inline netmem_ref page_to_netmem(struct page *page)
> >         return (__force netmem_ref)page;
> >  }
> >
> > +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> > +               unsigned int order)
> > +{
> > +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> > +}
> > +
> > +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> > +               unsigned long nr_netmems, netmem_ref *netmem_array)
> > +{
> > +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> > +                       (struct page **)netmem_array);
> > +}
> > +
> >  /**
> >   * virt_to_netmem - convert virtual memory pointer to a netmem reference
> >   * @data: host memory pointer to convert
> 
> Code looks fine to me, but I'm not sure we want to export these
> helpers in include/net where they're available to the entire kernel
> and net stack. Can we put these helpers in net/core/page_pool.c or at
> least net/core/netmem_priv.h?

Thanks.  I will.

> Also maybe the helpers aren't needed anyway. AFAICT there is only 1
> call site in page_pool.c for each, so maybe we can implement this
> inline.

Sure.

	Byungchul
> 
> -- 
> Thanks,
> Mina

