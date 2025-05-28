Return-Path: <bpf+bounces-59124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9092AC6197
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393D57AD219
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9057212D7C;
	Wed, 28 May 2025 06:07:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D11E8331;
	Wed, 28 May 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412473; cv=none; b=d3nGrt0XA7Uq99DywNy4v3a8q6/CQtPj/N3+jXIrcUxv/jh3EcnqY+UQFoMXem17xbZ3OEWFpVHxGqxMB/0niPr5NCKdNfuZQKAPW7MnAuVyA6300Jz34bHneQMd9vgTr1ju15Y2EKnKE3u5epScDkajlXe2sLWx1CrMft5DRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412473; c=relaxed/simple;
	bh=FD/vRrr0K61/ryvWyfuUqQQl+H5RGKY7HCqtiLqKHdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP3vem5QRU0NwUT7E3eJNwiXBnw4+G9mr8w4gm4yhtzPo54cxor+XHEsltV/P50IF6WNqUaRlRI2BkeNa0opupNOUn9HObu6oAPvdlfBU7yeBsPXZTUpPOOP4AMekls5qXDCU1bQKtygCa5mq5Yr9zIF4PrMcUhyRsb8G9UxPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-9b-6836a8356a99
Date: Wed, 28 May 2025 15:07:44 +0900
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
Subject: Re: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page
 pool
Message-ID: <20250528060744.GF9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-17-byungchul@sk.com>
 <CAHS8izM-hfueYox9Eqti4OsoCafh=pDL2v-6BEJRyt4ay580hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM-hfueYox9Eqti4OsoCafh=pDL2v-6BEJRyt4ay580hQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1CMcRTG/d/bvi3La0v+YsgaQ81I2DgfTOTTnxn3LwYzWXrHrtpiu5vB
	qowpWrcYtq020U1mWdRmmkrSZWqUzWVJF+s2BqFouqxoa4y+/eY8z3me8+HwtDyP9eE1kTGi
	LlIVoeCkjPTrlNwlQYUr1YGncgLBZCnh4MZAAhR021gwFZci+DnYLoG+2noO8nL7aTC1pDDw
	yzJEw/s6pwS68j8wUHGyjAbnmQYO0lOGaUiyFVLQWmpgIWPoOg1l+m4JtN03cdBZ8oeFDzXp
	DDQaixjoMqyFOrM39Dd9QVBrKaOg/3QWBxfsZg7epnQhsD90MpB53IDAUulgYXjAxK2dT+4W
	vaRIubFDQszWWHKn0J+kOew0sRancsTae15CXj+v4EjD5WGGlNv6KJKe3MORH+9fMeRb5TOO
	WO4+Y0izuVZC+qxztwg7pavDxAhNnKhbGrxHqh5pPUUdHJQn3M/LZPUoeVoa8uCxoMRNAxbu
	H3/Pesq6mREW4qttesrNnLAIOxyDtJu9BD98rfLcmIcWulj82HTAzZ7CNtxzaWjMLxNWYX12
	y2imlJcLRQhf7Emhx4XpuPHKO2Z8eRF2ZdtH5/woz8YFI/z4eB5Ovpc5ZvcQtuKPLzrHbpsh
	LMDVpfWUOxMLNh735qRKxo+ehR8UOpizaLpxQoVxQoXxf4VxQoUZMcVIromM06o0EcoAdWKk
	JiFgX5TWikZfJ/+Ia5cN9bZur0ECjxRTZORWkFrOquKiE7U1CPO0wkuWtGalWi4LUyUeFnVR
	obrYCDG6Bs3mGcVM2fL++DC5sF8VI4aL4kFR90+leA8fPcqoq6r226Hl3xx+1LwuY9Lii589
	Q+ITP9kXdPRVyTYr12vOxR/67U1Cbm8KCS+/6Rc+OVsZGuw6sdF5oaFkd/sk40hsz59QtXN9
	oyH35NaANGxw1k4tVu7e8lvtZd74pa3el6p88mvPhqMu116p9zs+d0X9sSCtbPH59BZfWXfG
	nEAFE61WLfOnddGqvyuGtq82AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGe7/TPlfTr6X1lqAw6aDQkbQHkvRP+dKPyAiCimrlh1vqrC1N
	g2I5KbJcWZY1p6xWqctYLZszxGKJKVaKtlpHTTtKqOX5QOWUyH8X930/16+Hp+Un2AW8WnNI
	1GqUyQpOykg3rTUsjSyNUq1oLA4Bs72cg1vDGVDS7mLBbHMi6B95K4G+2iccWK8O0mBuymZg
	wD5Kw+e6Dgm03fzCQPXJSho6ztZzkJs9RkOWq5SCx0UNLDQ7jSzkj96goVLfLoHWB2YOPpT/
	YeGLO5eBBlMZA23GWKizzIXBxh8Iau2VFAyeKeLgQouFg87sNgQtjzsYKDxuRGCv8bIwNmzm
	YhWkouw1RapM7yXE4kgj90ojSI63hSYO2ymOOH6dl5B3L6s5Un95jCFVrj6K5Bq6OfLz8xuG
	9NR4OGL91ksRe4WHIU8ttZLNs7dLoxPEZHW6qF2+bo9U9bv5NHVgRJ7xwFrI6pEhIAf58VhY
	jXuLXrA+ZoSF+FqrnvIxJyzGXu8I7eNAIRxfr8mb3NBCG4ufm/f7eI6wBXdfGp3cy4Q1WF/c
	xOUgKS8XyhC+2J1NTxWzccOVT8zU8WI8XtwykfMTHIxLfvNTcSg23C+cnPsJ8fjrqw+cj4OE
	MPzI+YQ6h/xN00ymaSbTf5NpmsmCGBsKVGvSU5Tq5MhluiRVpkadsWxfaooDTXzHzaPjeS7U
	3xrnRgKPFLNk5E6kSs4q03WZKW6EeVoRKMuKiVLJZQnKzCOiNnW3Ni1Z1LlRMM8o5sk2bhP3
	yIVE5SExSRQPiNp/LcX7LdCjJWc/sh7XzFRNnneQGY33N9j6o2PCi5t6KgZuz7LFdG2gTzmd
	Bcd7OxlLe1eTw+OR4/mrhtQz4yLupu3N/55WlRB5sC487FmWtDHPetfonLGd9DYXJj3N2fAt
	IGpo/Y65P439zYmvd9cvkhx2h8QX7Nwa0vcmbv6x8tCHDUG71kcrGJ1KuTKC1uqUfwEHnLX6
	GQMAAA==
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:32:55PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > Use netmem descriptor and APIs for page pool in mt76 code.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> This patch looks fine to me... but this is converting 1 driver to
> netmem. There are hundreds of other drivers in the tree. Are we
> converting all of them to netmem...?
> 
> The motivating reason for existing drivers to use netmem is because
> it's an abstract memory type that lets the driver support dma-buf
> memory and io_uring memory:
> 
> https://www.kernel.org/doc/Documentation/networking/netmem.rst
> 
> This driver does not use the page_pool, doesn't support dma-buf
> memory, or io_uring memory. Moving it to netmem I think will add
> overhead due to the netmem_is_net_iov checks while providing no
> tangible benefit AFAICT. Is your long term plan to convert all drivers
> to netmem? That maybe thousands of lines of code that need to be
> touched :(
> 
> > ---
> >  drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
> >  drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
> >  .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
> >  drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
> >  4 files changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> > index 35b4ec91979e..cceff435ec4a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/dma.c
> > +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> > @@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
> >         int nr_frags = shinfo->nr_frags;
> >
> >         if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
> > -               struct page *page = virt_to_head_page(data);
> > -               int offset = data - page_address(page) + q->buf_offset;
> > +               netmem_ref netmem = netmem_compound_head(virt_to_netmem(data));
> 
> It may be worth adding virt_to_head_netmem helper instead of doing
> these 2 calls together everywhere.

Sounds good.  I will.

	Byungchul
> 
> -- 
> Thanks,
> Mina

