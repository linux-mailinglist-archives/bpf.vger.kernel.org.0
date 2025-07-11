Return-Path: <bpf+bounces-62993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23187B010DB
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361497636F4
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086113FD86;
	Fri, 11 Jul 2025 01:33:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EA1442F4;
	Fri, 11 Jul 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197590; cv=none; b=I4JQz1ybXungPbAfYMZLqBdSRuOjMUT9c2s3NDSQzTc1cz4WdwBTze1LrKrO9mbU8vkm5Hl5zQsGtRYip+/cGHZa8iYagu7IPwG+Ddc1524CkKXoJvfEjJMHhiWKKU3z+SGHRS6UCBFIqEg5EztyWHckW3V1XUR3bAtaJ1ATvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197590; c=relaxed/simple;
	bh=NScB+8edl/OfbllKDX5iUijzY0vdcggfvUYRRo63cuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/dGj0/i4x/NXeHYzIksfdv76e1cAC7tXormmsGM7JP5UyoeVSKrh1OUzDX0RTBuhZfe9WonMZOHPvZ3AAQeliSsYQmoJRLIiQ5gQIPJyCy2DQi91qvF1tWnea5DjZmWvL80tnOxXPjXqF/qpkRLQW5/RZ5VnepHhkOL1KcIK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-68-687069ce6d1f
Date: Fri, 11 Jul 2025 10:32:57 +0900
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
Subject: Re: [PATCH net-next v9 6/8] mlx4: use netmem descriptor and APIs for
 page pool
Message-ID: <20250711013257.GE40145@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-7-byungchul@sk.com>
 <CAHS8izM9FO01kTxFhM8VUOqDFdtA80BbY=5xpKDM=S9fMcd3YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM9FO01kTxFhM8VUOqDFdtA80BbY=5xpKDM=S9fMcd3YA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SSUxTURSGc/tGKjWPinKFhUkFDERxiCEnapSdd2PU4EaJQ5WnrTI0LSCg
	JiDEoQoOmIilkIcDVCA2VqFIlGipCI6IwRSVQRAhWkVEGgGntoTI7sv5z/2/s7g8pbzJhPLa
	lDRRn6JOUrFyWv4lsHzJc61Os8z5KQbM1hoWqn9mQmVvPQPmqjoEP8bfcjDqfMTClXIPBeYX
	+TSMWScoGGju46DatgF6Kj7ScPe4nYK+My0sFORPUnBv/CsHR+stMmirK2TgwsQ1Cuw5vRy8
	ajCz0F3zl4GPjgIaWk3XaegpjINmaR54nrgROK12GXhOl7JQ1C6x0J/fg6C9qY+GktxCBNZG
	FwOTP70dJQ+7ubhw0uQepsjt650ycsfUxRHJlk5uWaKJ0dVOEVvVSZbYvp/nyLvXd1nSUjxJ
	kzv1ozJSkPeVJSMDb2gy3NjBEuvtDpo8lZzcpqBt8jWJYpI2Q9QvXbtLrpGM83VvwzPfj+Ac
	9DvEiAJ4LKzEJ9wXZNPc+WOQ8jEtROCGU3bkY1ZYhF2ucf88WIjCVxvPMUYk5ynBxOKOhj7a
	F8wRtuKi3MeMjxUC4Aa7S+ZbUgoWhI3SkGwqCMKtlz74H1De1l9l7d5W3sthuPIPPzVegPNq
	S/yyAGEzHu8p8q/PFRbi+3WP/J1YaOGx1VLBTV09Hz+wuOizKMg0Q2GaoTD9V5hmKCREVyGl
	NiUjWa1NWhmjyUrRZsbsSU22Ie9HqjjyK6EefW+LdyCBR6pARVx1qkbJqDMMWckOhHlKFay4
	sUGnUSoS1VnZoj51pz49STQ4UBhPq0IUKzwHE5XCPnWaeEAUdaJ+OpXxAaE56ERpBJ/wrbV/
	7LhdMxEcGttWu2SdZNquGGrpdBtq/xQRZ3FTyaFZf7X7+aGRW2WnAjcpB3PXOrp0e92Xox9G
	fv4kvjj8IIFabx4dO7ZqdVNb2MXhWYt3rD4vryk+Hcw3bslb846L9Vif7S6LlJrf2DZGRmkG
	nVGzX3oSmMzs+MHtKtqgUS+PpvQG9T+HrZnjRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed7bXkeTt2X1pkS0ssjSLhScMkryQw+VkVBGEuSoNzdyc2wq
	GiSmC2mpZXaxabKozKk0WOqW5hK1iwVdVtZMc2rZjVDLZV6zTYn89uP8/+d3vhyWlBbQgaxS
	nSRo1fIEGSOmxLvDs0KfKTWKNQ2eICi2VDJQMZwKt7rsNBSX1yDwjLSLYLD5EQPXrw2RUPxc
	T8EvyygJvQ97RFBhjQJ36ScK7mXbSOg5+5iBXP0YCfUjfSLItJcR0HS1hYYXNXk0XBi9SYIt
	o0sEr2qLGeisnKThU2MuBS1GMwXuvAh4aJoHQ0+/I2i22AgYyrnKQIHTxMAHvRuBs6mHgqKT
	eQgsDhcNY8NeR9GDTlFEMG763k/iKnMbge8a34uwyZqM75SFYIPLSWJr+WkGW3+eF+GON/cY
	/LhwjMJ37YMEzs3qY/CP3ncU7ne0Mvj6lwECW6paqT3SWPHmI0KCMkXQrt4SJ1aYDAs07UtT
	u3/wGWhivgH5sTy3nm/zfCZ9THHBfO0ZG/Ixwy3nXa6RqXkAt4K/4cinDUjMkpyR4Vtreyhf
	MIc7wBecfEL7WMIBX2tzEb6SlCtDvMH0hZgOZvMtVz5OLZBe63iJ02tlvRzE3/rDTo8X8VnV
	RVPH/LhofsRdMFWfyy3hG2oeEeeQv3GGyTjDZPxvMs4wmRBVjgKU6hSVXJmwIUx3TJGmVqaG
	HU5UWZH3VUpPjOfbkefV9kbEsUg2SxJRkaiQ0vIUXZqqEfEsKQuQ3I7SKKSSI/K044I28ZA2
	OUHQNaIglpLNl+zYL8RJuXh5knBMEDSC9l9KsH6BGWjft6iG7vpdq/wnyCquu26ysP1D08Lk
	3pc3nnVyMZsuf83v37Dy4ERp/dv4cO7tmtLshbH4dUlmx+vurR8jf1eZnaub24qctptmWUm8
	I6lfH7JY4386OjrmvlkVGla3czI/xL888tSlnL3agXXL0ivUn+0Xt82r1jt729OlR6NKNlpk
	lE4hXxtCanXyv0FOTGwmAwAA
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 11:29:35AM -0700, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > Use netmem descriptor and APIs for page pool in mlx4 code.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 48 +++++++++++---------
> >  drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 ++--
> >  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  4 +-
> >  3 files changed, 32 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index b33285d755b9..7cf0d2dc5011 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -62,18 +62,18 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
> >         int i;
> >
> >         for (i = 0; i < priv->num_frags; i++, frags++) {
> > -               if (!frags->page) {
> > -                       frags->page = page_pool_alloc_pages(ring->pp, gfp);
> > -                       if (!frags->page) {
> > +               if (!frags->netmem) {
> > +                       frags->netmem = page_pool_alloc_netmems(ring->pp, gfp);
> > +                       if (!frags->netmem) {
> >                                 ring->alloc_fail++;
> >                                 return -ENOMEM;
> >                         }
> > -                       page_pool_fragment_page(frags->page, 1);
> > +                       page_pool_fragment_netmem(frags->netmem, 1);
> >                         frags->page_offset = priv->rx_headroom;
> >
> >                         ring->rx_alloc_pages++;
> >                 }
> > -               dma = page_pool_get_dma_addr(frags->page);
> > +               dma = page_pool_get_dma_addr_netmem(frags->netmem);
> >                 rx_desc->data[i].addr = cpu_to_be64(dma + frags->page_offset);
> >         }
> >         return 0;
> > @@ -83,10 +83,10 @@ static void mlx4_en_free_frag(const struct mlx4_en_priv *priv,
> >                               struct mlx4_en_rx_ring *ring,
> >                               struct mlx4_en_rx_alloc *frag)
> >  {
> > -       if (frag->page)
> > -               page_pool_put_full_page(ring->pp, frag->page, false);
> > +       if (frag->netmem)
> > +               page_pool_put_full_netmem(ring->pp, frag->netmem, false);
> >         /* We need to clear all fields, otherwise a change of priv->log_rx_info
> > -        * could lead to see garbage later in frag->page.
> > +        * could lead to see garbage later in frag->netmem.
> >          */
> >         memset(frag, 0, sizeof(*frag));
> >  }
> > @@ -440,29 +440,33 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
> >         unsigned int truesize = 0;
> >         bool release = true;
> >         int nr, frag_size;
> > -       struct page *page;
> > +       netmem_ref netmem;
> >         dma_addr_t dma;
> >
> >         /* Collect used fragments while replacing them in the HW descriptors */
> >         for (nr = 0;; frags++) {
> >                 frag_size = min_t(int, length, frag_info->frag_size);
> >
> > -               page = frags->page;
> > -               if (unlikely(!page))
> > +               netmem = frags->netmem;
> > +               if (unlikely(!netmem))
> >                         goto fail;
> >
> > -               dma = page_pool_get_dma_addr(page);
> > +               dma = page_pool_get_dma_addr_netmem(netmem);
> >                 dma_sync_single_range_for_cpu(priv->ddev, dma, frags->page_offset,
> >                                               frag_size, priv->dma_dir);
> >
> > -               __skb_fill_page_desc(skb, nr, page, frags->page_offset,
> > -                                    frag_size);
> > +               __skb_fill_netmem_desc(skb, nr, netmem, frags->page_offset,
> > +                                      frag_size);
> >
> >                 truesize += frag_info->frag_stride;
> >                 if (frag_info->frag_stride == PAGE_SIZE / 2) {
> > +                       struct page *page = netmem_to_page(netmem);
> 
> This cast is not safe, try to use the netmem type directly.

Can it be net_iov?  It already ensures it's a page-backed netmem.  Why
is that unsafe?

With netmem, page_count() and page_to_nid() cannot be used, but needed.
Or checking 'page == NULL' after the casting works for you?

	Byungchul

> --
> Thanks,
> Mina

