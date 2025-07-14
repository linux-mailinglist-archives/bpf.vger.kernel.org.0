Return-Path: <bpf+bounces-63166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE393B03DE4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D8E7A5EB3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3A2472AA;
	Mon, 14 Jul 2025 11:59:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A21E5018;
	Mon, 14 Jul 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494351; cv=none; b=dsOekOtGk2/2G940CJfHUjWPi9wL/m1zwfxN3WhWR3fTDc7HDcim66/h80Gmub+I9/Chk1ckqMPFv2ydfJsFzrghDs8fZWnN0N4QRsYaNSBJDqg9PUW98RAYvqQuHGrmLzMqpZR4lcdh4h652ho1O63/qDJJadOR/m3bzY+Cvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494351; c=relaxed/simple;
	bh=+8kGNKX/cS17HIoZdLxG+aIihYIgBAWGehSLPSD24hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3Q5LBZtwTaXXT4QFSNtym3f/KE+KudzBHz61KWsnW6CxuBdWQ3kPCr058dA3uZnMeomICwn8rNEzphdY7BdhHlyCfU5EoTIGImzIWwNAiXHhsyvlqeuW2AQcfEKMr4EGUOmvxcrabO3W5qXko2Ygx9uzHr36cnUC87bPxojBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-47-6874f10695f3
Date: Mon, 14 Jul 2025 20:58:57 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250714115857.GA31302@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-2-byungchul@sk.com>
 <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
 <20250714042346.GA68818@system.software.com>
 <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjH97nvz27d9u0UH2VsJ2NRYf3x2Pw29p1ms7AMm676rju6aldS
	DQtZ3LqENrnOXKwrdTo7ra6k6frpx0iJi1JKhQjh9OOK7prx32vP+/289vzxsIQ0n/JllXFJ
	gjpOHiujxaT4s+f1QPpbkmLlz9Jg0JtNNJSOpUBRr5UCfUkFgh/jrxn43tBMw40CBwH6pxkk
	/DRPEDDQ1MdAqWUH9BgHSajJrCSg73wLDdqMSQLujY8wcMpaLILWimwKcicKCahM72WgvVpP
	wxvTbwoGbVoSHuhuktCTvRGaDHPB8egTggZzpQgcWVdpuNRmoKE/owdBW30fCfknsxGYa+0U
	TI7NOPIb3zAb/fn6T18Ivvxmp4iv0nUzvMFyhL9THMBr7G0Ebyk5R/OW0YsM3/WihuZb8iZJ
	vsr6XcRrT4/Q/LeBVyT/pbaD5s3lHST/2NDA7PTaJ14bLcQqkwV18PoIseLUdB1KeLYl5WTZ
	BSodfQ3RIA8WcyE401JO/OXBRhPpYpJbgjtH291Mc0ux3T7u7nhzy/HwSxujQWKW4PJoXPbW
	SLuCOZwcP3RmuxckHOD3xmHkKkk5B8J52kZqNvDCD668c5cILgDbpz+INIidYT9cNM26xh7c
	Ojz0RO+u+HCL8f2KZpHLgzkri+0TufTspfNxXbGdzEGc7j+t7j+t7p/WgIgSJFXGJavkytiQ
	IEVqnDIlKCpeZUEzL2M87txvRaOtu2yIY5HMUwIfkxRSSp6cmKqyIcwSMm/Jx261QiqJlqem
	Cer4g+ojsUKiDfmxpGyeZLXjaLSUi5EnCYcFIUFQ/01FrIdvOoopW1Ft8tkT2eTsUGyaWkVp
	c5xN+9StU5tNw4oaw4KRNeJl2+NVv593a0KP91H528LTshZa94aF+6d3/zpzTbfFGdYyoCmo
	uFt9Wfe6JTI36mD87gEYK2BUix7eqgrddfZATKaMezaFhyNu3d4anaEqDHT+GurfcOLQsRyj
	X5d3oIxMVMhXBRDqRPkf8I3lSi4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zdnY2WpzWrIN+m0WgZQUGL2giRPWnNKKb1JdceWjDK5ua
	BoU3EC1XVpitDdbNO42mblNUavPazVLKWd5t5q3MS6KzLGdEfvvxPM/v/fQypPQX5c2o4hJ5
	dZwiRk6LKfGRoMwd9HSicpe7ywf0pgoayhdSoHjAJgB9mQXB3OInIcw2ttDw8P48Cfr2LAp+
	mNwkuJqHhFBuDof+ohEK6rKtJAxdb6UhL2uJhPrFb0LIsJUQ4DC0CeCtRSuA2+7HJFjTBoTQ
	Waunoa/itwBG7HkUtOlKKejXhkKzcRPMv5xE0GiyEjB/zUDDrQ4jDcNZ/Qg6HEMU3EvXIjA1
	OAWwtLBy415TnzB0K3ZMTpG4qrSbwDW6XiE2mpNwZYkfznV2kNhclkNj88xNIe75UEfj1sIl
	CtfYZgmcl/mNxtOujxSeanhP44ej3wlsqnpPHZWeEQdH8TGqZF69MyRSrMxYfo4S3u1LSX+S
	L0hD3wNzkYjh2EBupKmC8jDFbuW6ZzpXmWa3cU7nIulhGevPTXTZhblIzJBsIc09GSyiPcVG
	VsG9+KldFSQscKNFE8gzkrLziCvMaxL8LTZwbXc/r45I1o9zLo8RuYhZYR+ueJnxxCJ2L/fl
	jX514sX6cs8sLcQNJNGtsXVrbN1/24jIMiRTxSXHKlQxewI00crUOFVKwPn4WDNaeYqiyz/z
	bWiu86AdsQySr5PAeKJSKlAka1Jj7YhjSLlMMt6rVkolUYrUS7w6/qw6KYbX2JEPQ8k3Sw5F
	8JFS9oIikY/m+QRe/a8lGJF3GnJ5b9HSY5WZ51peHxPNbWdDDxcsaAPennTh4kFD9vGL4Y9O
	Pnh0R2RQ3zKJrLVeE9Yt+wN7UtOcEUfawqoP1AU/tTD5rijT8qkrHWFXq3P8C5D/bV9DvaXU
	/eVpiN/60zL73RO8Mah92hH74NVQ+c2vMp+FwxuGzaHXwg6e0hCVckqjVOz2I9UaxR9qCeNy
	EAMAAA==
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 12:30:12PM +0100, Pavel Begunkov wrote:
> On 7/14/25 05:23, Byungchul Park wrote:
> > On Sat, Jul 12, 2025 at 03:39:59PM +0100, Pavel Begunkov wrote:
> > > On 7/10/25 09:28, Byungchul Park wrote:
> > > > To simplify struct page, the page pool members of struct page should be
> > > > moved to other, allowing these members to be removed from struct page.
> > > > 
> > > > Introduce a network memory descriptor to store the members, struct
> > > > netmem_desc, and make it union'ed with the existing fields in struct
> > > > net_iov, allowing to organize the fields of struct net_iov.
> > > 
> > > FWIW, regardless of memdesc business, I think it'd be great to have
> > > this patch, as it'll help with some of the netmem casting ugliness and
> > > shed some cycles as well. For example, we have a bunch of
> > > niov -> netmem -> niov casts in various places.
> > 
> > If Jakub agrees with this, I will re-post this as a separate patch so
> > that works that require this base can go ahead.
> 
> I think it'd be a good idea. It's needed to clean up netmem handling,
> and I'll convert io_uring and get rid of the union in niov.
> 
> The diff below should give a rough idea of what I want to use it for.
> It kills __netmem_clear_lsb() to avoid casting struct page * to niov.
> And saves some masking for zcrx, see page_pool_get_dma_addr_nmdesc(),
> and there are more places like that.
> 
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 535cf17b9134..41f3a3fd6b6c 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -247,6 +247,8 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>        return page_to_pfn(netmem_to_page(netmem));
>  }
> 
> +#define pp_page_to_nmdesc(page)        ((struct netmem_desc *)(page))
> +
>  /* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
>   * common fields.
>   * @netmem: netmem reference to extract as net_iov.
> @@ -262,11 +264,18 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>   *
>   * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
>   */
> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +static inline struct net_iov *__netmem_to_niov(netmem_ref netmem)
>  {
>        return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>  }
> 
> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)

I removed netmem_to_nmdesc() and its users, while I was working for v10.
However, You can add it if needed for your clean up.

I think I should share v10 now, to share the decision I made.

	Byungchul

> +{
> +       if (netmem_is_net_iov(netmem))
> +               return &__netmem_to_niov(netmem)->desc;
> +       return pp_page_to_nmdesc(__netmem_to_page(netmem));
> +}
> +
>  /**
>   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
>   * @netmem: netmem reference to get the pointer from
> @@ -280,17 +289,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
>  }
> 
>  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_clear_lsb(netmem)->pp;
> +       return netmem_to_nmdesc(netmem)->pp;
>  }
> 
>  static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
>  {
> -       return &__netmem_clear_lsb(netmem)->pp_ref_count;
> +       return &netmem_to_nmdesc(netmem)->pp_ref_count;
>  }
> 
>  static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
> @@ -355,7 +364,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
> 
>  static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
>  {
> -       return __netmem_clear_lsb(netmem)->dma_addr;
> +       return netmem_to_nmdesc(netmem)->dma_addr;
>  }
> 
>  void get_netmem(netmem_ref netmem);
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index db180626be06..002858f3bcb3 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -425,9 +425,9 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
>        page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
>  }
> 
> -static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
> +static inline dma_addr_t page_pool_get_dma_addr_nmdesc(struct netmem_desc *desc)
>  {
> -       dma_addr_t ret = netmem_get_dma_addr(netmem);
> +       dma_addr_t ret = desc->dma_addr;
> 
>        if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>                ret <<= PAGE_SHIFT;
> @@ -435,6 +435,13 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
>        return ret;
>  }
> 
> +static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
> +{
> +       struct netmem_desc *desc = netmem_to_nmdesc(netmem);
> +
> +       return page_pool_get_dma_addr_nmdesc(desc);
> +}
> +
>  /**
>   * page_pool_get_dma_addr() - Retrieve the stored DMA address.
>   * @page:     page allocated from a page pool
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 085eeed8cd50..2e80692d9ee1 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -290,7 +290,7 @@ static void io_zcrx_sync_for_device(const struct page_pool *pool,
>        if (!dma_dev_need_sync(pool->p.dev))
>                return;
> 
> -       dma_addr = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
> +       dma_addr = page_pool_get_dma_addr_nmdesc(&niov->desc);
>        __dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
>                                     PAGE_SIZE, pool->p.dma_dir);
>  #endif
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..97d4beda9174 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -5,19 +5,21 @@
> 
>  static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
>  {
> -       return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
> +       return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
> 
>  static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>  {
> -       __netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> +       netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
>  }
> 
>  static inline void netmem_clear_pp_magic(netmem_ref netmem)
>  {
> -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> +       struct netmem_desc *desc = netmem_to_nmdesc(netmem);
> 
> -       __netmem_clear_lsb(netmem)->pp_magic = 0;
> +       WARN_ON_ONCE(desc->pp_magic & PP_DMA_INDEX_MASK);
> +
> +       desc->pp_magic = 0;
>  }
> 
>  static inline bool netmem_is_pp(netmem_ref netmem)
> @@ -27,13 +29,13 @@ static inline bool netmem_is_pp(netmem_ref netmem)
> 
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
>  {
> -       __netmem_clear_lsb(netmem)->pp = pool;
> +       netmem_to_nmdesc(netmem)->pp = pool;
>  }
> 
>  static inline void netmem_set_dma_addr(netmem_ref netmem,
>                                       unsigned long dma_addr)
>  {
> -       __netmem_clear_lsb(netmem)->dma_addr = dma_addr;
> +       netmem_to_nmdesc(netmem)->dma_addr = dma_addr;
>  }
> 
>  static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
> @@ -43,7 +45,7 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
>        if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>                return 0;
> 
> -       magic = __netmem_clear_lsb(netmem)->pp_magic;
> +       magic = netmem_to_nmdesc(netmem)->pp_magic;
> 
>        return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
>  }
> @@ -51,12 +53,12 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
>  static inline void netmem_set_dma_index(netmem_ref netmem,
>                                        unsigned long id)
>  {
> -       unsigned long magic;
> +       struct netmem_desc *desc;
> 
>        if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>                return;
> 
> -       magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
> -       __netmem_clear_lsb(netmem)->pp_magic = magic;
> +       desc = netmem_to_nmdesc(netmem);
> +       desc->pp_magic |= id << PP_DMA_INDEX_SHIFT;
>  }
>  #endif

