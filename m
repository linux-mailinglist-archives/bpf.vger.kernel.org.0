Return-Path: <bpf+bounces-59123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E798EAC6191
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD064A0246
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06287210F4B;
	Wed, 28 May 2025 06:07:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DD1A262D;
	Wed, 28 May 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412446; cv=none; b=eegECh2RDOD6S6CsLDZBXPqU8IUoRhhLCrffQjoGVKX6H2a7vq4dduJ3cVz7L2tKwAiIhQjzQ+77QtriO4k6giz3NiUGJ2UC4b4AysK5Eo9IREolnhE2EyrThLKowGTunmr7ESWqnUNAsByWumyyCfgcbpNnHtijYhOp9yWN4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412446; c=relaxed/simple;
	bh=fVL6Ph/WHENDhIDbOIHvEp2LxfqkRuIHqktgIJHhWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMxhoeHzf+knspsAi/cHSUocEp8dpTPVUexEXgVExlxmNxgGXwGI+LCOTZZfTUef7GvXgHBF0BwWLcYuXJ7Lspf1Ne5EFKQr0ogxmy/lq2aAYw2SJQtEyCAJGG3jUOtGKvp5RoSKLrjT+x4H3nYMY8VZ+PjBBLxYxLCcRtnaF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-66-6836a818f72e
Date: Wed, 28 May 2025 15:07:15 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
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
Message-ID: <20250528060715.GE9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-17-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528022911.73453-17-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nueeebt32OMWjMM7MZDrs5LP8qNj4/mMTYdyGo2fuUofr
	ujqbObmJo5Afy7nmjFJXdjxynfSDtMrYSsYOqZQaVqHUqjPpao3/3nt9Pp/X5/PHhyFlGaIQ
	Rqsz8HqdOlFOSyhJT+DNJTMLIjRLR4cR2F3FNBQNpcGdNo8I7E43gl/DH8TQX1NHw62bgyTY
	GywUDLhGSOisbRdDa34XBeUZpSS0n6+nIdPiIyHdU0BAoztLBJdH8kgoNbeJ4XWZnYaW4lER
	dFVnUvDcVkhBa1Y01Dqmw+CLbgQ1rlICBs/l0nCpyUFDh6UVQdOzdgqun8hC4Kr0isA3ZKej
	5+GSwncEfmT7KMYOIQU/KAjDVm8TiQXnGRoLfdli3Py2nMb1OT4KP/L0EzjzZC+Nf3a+p/D3
	yjc0dpW8ofBLR40Y9wtzNrO7JKvj+UStkdcr1u6VaG4LhsPflqddLOklzOjuIisKYDhWyVny
	LNRkviJ0EFbEMBS7gLufE+THNLuQ83qHST8OYhXc2+ydViRhSLZexPlufBH5e6axW7jeqyOE
	P0vZlZzXeXVcKWP3cWeFHDTBp3LPr30e5yQbxnn/fB1fRbKh3J0/jB8HjI2aHVXjymB2PvfE
	XUdMXFbIcFeuqSbyTO5pgZe6gFjbf1bbf1bbP6sDkU4k0+qMSWptojJcY9Jp08L3H0oS0Nh7
	5B/7rfKgvsat1YhlkDxQiu+t0MhEamOyKakacQwpD5KmR0VoZNJ4tekorz+0R5+SyCdXo1CG
	ks+QLh9MjZexB9QG/iDPH+b1k1WCCQgxoyjlcM+UbvfabWSwEJs729TyMJ4oK4rpnntcEVxZ
	V/Gj51XtkfNh6hB5UENVzuIdik3r5KEVKjtWijeejjM2p7RkO/Rxuzs+qoyXGgPXD8yPcVq0
	n+7HJjybevnU9riohSOPw3MDIm2vNwwkdK5JbbzRM8s50LEqMkFuaFvQYFb45FSyRr0sjNQn
	q/8Co+PWFBoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OztbLY5L62DWh0WEgmWR9kChQkIvBdGVSIKcdXTDeWFT
	c0VkakWa5q2wNW1m6jRjNkVnDKspXppiKNq6mKZpWmkXy9SF1ozIb39+z/N7ni9/hpR+pDwZ
	ZUw8r46Rq2S0mBLv25HqyxkDFH5NVm/Qm6pouDeTBOWDFgHoK+sQfJ99JYSp5lYaSoqnSdB3
	pVHwwzRHwkjLkBAGykYpsF6uJ2HoWhsNmWlOElIsRgKaCtsF8KwuSwD5c6Uk1CcPCqHnoZ6G
	N1ULAhi1ZVLQrqugYCArGFoMq2Da/glBs6megOmrhTTkdRtoGE4bQNDdNETBrQtZCEyNDgE4
	Z/R0sAzXVrwgcIOuX4gN5gRcY/TB6Y5uEpsrr9DY/C1XiF/3WWncVuCkcINlisCZqZM0/jry
	ksKfG3tpXDL2hcCm2l4KdxiahfvdQsU7T/EqZSKv3hwYJlbcNcfHfdialFM7SSSj+97pSMRw
	7DbuunmYSEcMQ7EbuAcF7i5Msxs5h2OWdGF3djPXl3ssHYkZkm0TcM7bYwLXzkr2IDd5Y45w
	ZQm7nXNU3qBcWcqGcxnmAvSXu3HtN98tcpL14Rzz44uvSHYNVz7PuLDoj5pseLR40oNdzz2u
	ayWykUS3xNYtsXX/bQMiK5G7MiYxWq5U+W/SRCm0McqkTSdjo83oTwXKzv3KsaDvPbttiGWQ
	bLkEV/srpAJ5okYbbUMcQ8rcJSlBAQqp5JRce4ZXx55QJ6h4jQ2tYSjZasmeo3yYlI2Ux/NR
	PB/Hq/9NCUbkmYw6JzqrzxpV2ihP3BFS/LN7bbHvjNwq0gb2TtoCdq14K70TkkhFPM884NW1
	0jYclFdToD3vt3d4wS+jFT2ZWmY/fNwclI+n47RP+aIJ+vToikj7uvcOD6sxInwhe1x0MctZ
	mmtMa6/PC+3y9Qhu7Dx05FKnv1dXjqe9zDFa1L8gozQK+RYfUq2R/wYu4fp4/gIAAA==
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 11:29:11AM +0900, Byungchul Park wrote:
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
> 
> Use netmem descriptor and APIs for page pool in mt76 code.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
>  .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
>  drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
>  4 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index 35b4ec91979e..cceff435ec4a 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
>  	int nr_frags = shinfo->nr_frags;
>  
>  	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
> -		struct page *page = virt_to_head_page(data);
> -		int offset = data - page_address(page) + q->buf_offset;
> +		netmem_ref netmem = netmem_compound_head(virt_to_netmem(data));
> +		int offset = data - netmem_address(netmem) + q->buf_offset;
>  
> -		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
> +		skb_add_rx_frag_netmem(skb, nr_frags, netmem, offset, len, q->buf_size);
>  	} else {
>  		mt76_put_page_pool_buf(data, allow_direct);
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 5f8d81cda6cd..f075c1816554 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -1795,21 +1795,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
>  int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
>  static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
>  {
> -	struct page *page = virt_to_head_page(buf);
> +	netmem_ref netmem = netmem_compound_head(virt_to_netmem(buf));
>  
> -	page_pool_put_full_page(page->pp, page, allow_direct);

To Mina,

They touch ->pp field.  That's why I thought they use page pool.  Am I
missing something?

	Byungchul

> +	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, allow_direct);
>  }
>  
>  static inline void *
>  mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
>  {
> -	struct page *page;
> +	netmem_ref netmem;
>  
> -	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
> -	if (!page)
> +	netmem = page_pool_dev_alloc_netmem(q->page_pool, offset, &size);
> +	if (!netmem)
>  		return NULL;
>  
> -	return page_address(page) + *offset;
> +	return netmem_address(netmem) + *offset;
>  }
>  
>  static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> index 0a927a7313a6..8663070191a1 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -68,14 +68,14 @@ mt76s_build_rx_skb(void *data, int data_len, int buf_len)
>  
>  	skb_put_data(skb, data, len);
>  	if (data_len > len) {
> -		struct page *page;
> +		netmem_ref netmem;
>  
>  		data += len;
> -		page = virt_to_head_page(data);
> -		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -				page, data - page_address(page),
> -				data_len - len, buf_len);
> -		get_page(page);
> +		page = netmem_compound_head(virt_to_netmem(data));
> +		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> +				       netmem, data - netmem_address(netmem),
> +				       data_len - len, buf_len);
> +		get_netmem(netmem);
>  	}
>  
>  	return skb;
> @@ -88,7 +88,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>  	struct mt76_queue *q = &dev->q_rx[qid];
>  	struct mt76_sdio *sdio = &dev->sdio;
>  	int len = 0, err, i;
> -	struct page *page;
> +	netmem_ref netmem;
>  	u8 *buf, *end;
>  
>  	for (i = 0; i < intr->rx.num[qid]; i++)
> @@ -100,11 +100,11 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>  	if (len > sdio->func->cur_blksize)
>  		len = roundup(len, sdio->func->cur_blksize);
>  
> -	page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
> -	if (!page)
> +	netmem = page_to_netmem(__dev_alloc_pages(GFP_KERNEL, get_order(len)));
> +	if (!netmem)
>  		return -ENOMEM;
>  
> -	buf = page_address(page);
> +	buf = netmem_address(netmem);
>  
>  	sdio_claim_host(sdio->func);
>  	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
> @@ -112,7 +112,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>  
>  	if (err < 0) {
>  		dev_err(dev->dev, "sdio read data failed:%d\n", err);
> -		put_page(page);
> +		put_netmem(netmem);
>  		return err;
>  	}
>  
> @@ -140,7 +140,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>  		}
>  		buf += round_up(len + 4, 4);
>  	}
> -	put_page(page);
> +	put_netmem(netmem);
>  
>  	spin_lock_bh(&q->lock);
>  	q->head = (q->head + i) % q->ndesc;
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index f9e67b8c3b3c..03f0d35981c9 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -478,7 +478,7 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
>  
>  	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
>  	if (SKB_WITH_OVERHEAD(buf_size) < head_room + len) {
> -		struct page *page;
> +		netmem_ref netmem;
>  
>  		/* slow path, not enough space for data and
>  		 * skb_shared_info
> @@ -489,10 +489,10 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
>  
>  		skb_put_data(skb, data + head_room, MT_SKB_HEAD_LEN);
>  		data += head_room + MT_SKB_HEAD_LEN;
> -		page = virt_to_head_page(data);
> -		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -				page, data - page_address(page),
> -				len - MT_SKB_HEAD_LEN, buf_size);
> +		netmem = netmem_compound_head(virt_to_netmem(data));
> +		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> +				       netmem, data - netmem_address(netmem),
> +				       len - MT_SKB_HEAD_LEN, buf_size);
>  
>  		return skb;
>  	}
> -- 
> 2.17.1

