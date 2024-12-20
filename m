Return-Path: <bpf+bounces-47412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D09F923A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DBB16A4EC
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF5206299;
	Fri, 20 Dec 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppZDZjhx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F01A2642
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697798; cv=none; b=JM8WcPbEI0+66o8xs2dgHFV4vRmusHp07qTCQ4Dqnjk/0f5LW4nWJl6fkToIe24YFWXFzXYQKMtHHiE8EMgX6oyLymIX4GFiIQ5Mp9wsSYydj2X/4tn96LAMlnhQQCvkSvFC7mMeb0k3OnW24Fhe/Zl8JVTP+M3QkRn0NJGEG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697798; c=relaxed/simple;
	bh=66CvT6ns+hHH6BDz1EEtJ1zFnpF+MWdHM0cUPxVKIZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8nFKcAhGx5Cd1cyEnxgZaiWKoAf7wgFot2LUwg+ODrw1/UVBBb+PFAlthJaxoJMK4Au8R9qJOok6gQ6cgkfdwb+r7Oyp1xlbmEv4fqsVgYulQg3QcAJRAuKfXuxx5gPR5/d4buAeix/yiYkO1nKj5pcLT+gMryu/bP6WUrAmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ppZDZjhx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ebe19368so1390746276.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 04:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697796; x=1735302596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VmRCmaPkLkPswmKEyB/ZICUJHMBmUsSjq9Yct5NQ1ro=;
        b=ppZDZjhxB3N7WSspD6BavgGwANaKs4GCgU2/GX4iWnzqxjKuQPpfAnrcb0n+NJZQe9
         hjlF2ocPlEbN2GFg8uhM1kkQfVDevqS6QjA9f/yiLin5KJCmeYvtBPbqdiuxpI44MaJR
         kPrIVBnRJ621HA+fDJkJofG7Li8oUrYR5oxajpzu/44Q+9K1WNJttN4BPBHVSJEXrD6x
         iW5n70M8++Z3C2Y8tLr2cgNJKTSNqXyClZ5u1X9/S+xNLNZKmTREFO+ni5WpoiyZOfz7
         9SRDuhtyxOWaeah7ds1eV3Amx3JOq4pAAMg/iuh/8HdZjxuYCCUSQU92yj5Q5wy5LRHy
         kFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697796; x=1735302596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmRCmaPkLkPswmKEyB/ZICUJHMBmUsSjq9Yct5NQ1ro=;
        b=L1XN9nTUWUz8tMCRnQAYiEuAyK1JYk0OF8diLwEcDIT9rFhUXldcv+sFeio9BER/TE
         MCd/w+nIzw0/RWWpSTI1p5/buKcA79fT880K/9iZy0foX+SukN7x9w9VxRULW/YR+pmJ
         0IclqClUFV3RO0sDr/IP0Oa6Tdq/Im06x50bWQtJDhRuTPfXYm00MzQOOmUqxk98jm46
         CN2ilyHBaZh0U/GnRIl673fvcjyv6v5dl/8qUIiILPXdygRhEdt2i5iLl5DFCSFmxe6O
         3O2PHZBaLm5fqyrlzvirh54Wg3DbySUeZQ+x39eQie9NfynvETBRdAMTGT6WSD1/iKqs
         bC3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZEtHJWlxgEHfyzmWvr/UYHkSzCrpbeKLh4ZnK7BktFKmJHCril9O0XkvlMpNY4aqFJuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjbsv7igYTQRhGNp1mH7r4m35Cv+K0QoPrjDmp6oSIgvgKc9s
	magassZZtTFIZM5TOyKBAtuCmdaU8bdbGi3CS+6aXYpFEZ6mT3mJdu1AA9vnzR8IqonJ7fdsPSg
	mGyJyndC8iT4hYLngC2CTCf4MKLO+ju7wQarNig==
X-Gm-Gg: ASbGnctypmoDDickULLEBO2FpdmChRdyf8NHS8OtgOvajWAbW/4Hq1iED47lEI6rrmY
	axWr/MQicV8i6qnRn10lrthnpW/c/1ghE5VYOMw==
X-Google-Smtp-Source: AGHT+IGSsUG4iSnRRcdUuCq27bUw63jRg+t86G+uWqSkEhiBTf+pNCH23b3m4irAGr9UmyGYIOuuYUx3ncEVJac77D0=
X-Received: by 2002:a05:6902:982:b0:e3c:8ec9:c896 with SMTP id
 3f1490d57ef6-e538c350d10mr1981319276.34.1734697795572; Fri, 20 Dec 2024
 04:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213122739.4050137-1-linyunsheng@huawei.com> <20241213122739.4050137-2-linyunsheng@huawei.com>
In-Reply-To: <20241213122739.4050137-2-linyunsheng@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Dec 2024 14:29:19 +0200
Message-ID: <CAC_iWj+3Q7CAS3xH9+zWA7nXdFNSJ-XMKQB3ZT0YvUQ-Q2gMCQ@mail.gmail.com>
Subject: Re: [PATCH RFCv5 1/8] page_pool: introduce page_pool_to_pp() API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	somnath.kotur@broadcom.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>, 
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Fri, 13 Dec 2024 at 14:35, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> introduce page_pool_to_pp() API to avoid caller accessing
> page->pp directly.
>

I think we already have way too many abstractions, I'd say we need
less not more. I don't know what others think, but I don't see what we
gain from this

Thanks
/Ilias
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c          |  8 +++++---
>  .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |  2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c        |  6 ++++--
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 14 +++++++++-----
>  drivers/net/ethernet/intel/libeth/rx.c             |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  3 ++-
>  drivers/net/netdevsim/netdev.c                     |  6 ++++--
>  drivers/net/wireless/mediatek/mt76/mt76.h          |  2 +-
>  include/net/libeth/rx.h                            |  3 ++-
>  include/net/page_pool/helpers.h                    |  5 +++++
>  net/core/skbuff.c                                  |  3 ++-
>  net/core/xdp.c                                     |  3 ++-
>  12 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1b55047c0237..98fce41d088c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1009,7 +1009,8 @@ static void fec_enet_bd_init(struct net_device *dev)
>                                 struct page *page = txq->tx_buf[i].buf_p;
>
>                                 if (page)
> -                                       page_pool_put_page(page->pp, page, 0, false);
> +                                       page_pool_put_page(page_pool_to_pp(page),
> +                                                          page, 0, false);
>                         }
>
>                         txq->tx_buf[i].buf_p = NULL;
> @@ -1549,7 +1550,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>                         xdp_return_frame_rx_napi(xdpf);
>                 } else { /* recycle pages of XDP_TX frames */
>                         /* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
> -                       page_pool_put_page(page->pp, page, 0, true);
> +                       page_pool_put_page(page_pool_to_pp(page), page, 0, true);
>                 }
>
>                 txq->tx_buf[index].buf_p = NULL;
> @@ -3311,7 +3312,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>                         } else {
>                                 struct page *page = txq->tx_buf[i].buf_p;
>
> -                               page_pool_put_page(page->pp, page, 0, false);
> +                               page_pool_put_page(page_pool_to_pp(page),
> +                                                  page, 0, false);
>                         }
>
>                         txq->tx_buf[i].buf_p = NULL;
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 403f0f335ba6..db5926152c72 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -210,7 +210,7 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
>         if (!page)
>                 return;
>
> -       page_pool_put_full_page(page->pp, page, allow_direct);
> +       page_pool_put_full_page(page_pool_to_pp(page), page, allow_direct);
>         buf_state->page_info.page = NULL;
>  }
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 26b424fd6718..658d8f9a6abb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1050,7 +1050,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
>                              const struct libeth_fqe *rx_buffer,
>                              unsigned int size)
>  {
> -       u32 hr = rx_buffer->page->pp->p.offset;
> +       struct page_pool *pool = page_pool_to_pp(rx_buffer->page);
> +       u32 hr = pool->p.offset;
>
>         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
>                         rx_buffer->offset + hr, size, rx_buffer->truesize);
> @@ -1067,7 +1068,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
>  static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
>                                       unsigned int size)
>  {
> -       u32 hr = rx_buffer->page->pp->p.offset;
> +       struct page_pool *pool = page_pool_to_pp(rx_buffer->page);
> +       u32 hr = pool->p.offset;
>         struct sk_buff *skb;
>         void *va;
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index da2a5becf62f..38ad32678bcc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -385,7 +385,8 @@ static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)
>         if (unlikely(!rx_buf->page))
>                 return;
>
> -       page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
> +       page_pool_put_full_page(page_pool_to_pp(rx_buf->page), rx_buf->page,
> +                               false);
>
>         rx_buf->page = NULL;
>         rx_buf->offset = 0;
> @@ -3097,7 +3098,8 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
>  void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
>                       unsigned int size)
>  {
> -       u32 hr = rx_buf->page->pp->p.offset;
> +       struct page_pool *pool = page_pool_to_pp(rx_buf->page);
> +       u32 hr = pool->p.offset;
>
>         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
>                         rx_buf->offset + hr, size, rx_buf->truesize);
> @@ -3129,8 +3131,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>         if (!libeth_rx_sync_for_cpu(buf, copy))
>                 return 0;
>
> -       dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
> -       src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
> +       dst = page_address(hdr->page) + hdr->offset +
> +               page_pool_to_pp(hdr->page)->p.offset;
> +       src = page_address(buf->page) + buf->offset +
> +               page_pool_to_pp(buf->page)->p.offset;
>         memcpy(dst, src, LARGEST_ALIGN(copy));
>
>         buf->offset += copy;
> @@ -3148,7 +3152,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>   */
>  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
>  {
> -       u32 hr = buf->page->pp->p.offset;
> +       u32 hr = page_pool_to_pp(buf->page)->p.offset;
>         struct sk_buff *skb;
>         void *va;
>
> diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
> index f20926669318..385afca0e61d 100644
> --- a/drivers/net/ethernet/intel/libeth/rx.c
> +++ b/drivers/net/ethernet/intel/libeth/rx.c
> @@ -207,7 +207,7 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, LIBETH);
>   */
>  void libeth_rx_recycle_slow(struct page *page)
>  {
> -       page_pool_recycle_direct(page->pp, page);
> +       page_pool_recycle_direct(page_pool_to_pp(page), page);
>  }
>  EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, LIBETH);
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 94b291662087..78866b5473da 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -716,7 +716,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>                                 /* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
>                                  * as we know this is a page_pool page.
>                                  */
> -                               page_pool_recycle_direct(page->pp, page);
> +                               page_pool_recycle_direct(page_pool_to_pp(page),
> +                                                        page);
>                         } while (++n < num);
>
>                         break;
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 0be47fed4efc..088f4836a0e2 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -632,7 +632,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
>                 if (!ns->page)
>                         ret = -ENOMEM;
>         } else {
> -               page_pool_put_full_page(ns->page->pp, ns->page, false);
> +               page_pool_put_full_page(page_pool_to_pp(ns->page), ns->page,
> +                                       false);
>                 ns->page = NULL;
>         }
>         rtnl_unlock();
> @@ -831,7 +832,8 @@ void nsim_destroy(struct netdevsim *ns)
>
>         /* Put this intentionally late to exercise the orphaning path */
>         if (ns->page) {
> -               page_pool_put_full_page(ns->page->pp, ns->page, false);
> +               page_pool_put_full_page(page_pool_to_pp(ns->page), ns->page,
> +                                       false);
>                 ns->page = NULL;
>         }
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 0b75a45ad2e8..94a277290909 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -1688,7 +1688,7 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
>  {
>         struct page *page = virt_to_head_page(buf);
>
> -       page_pool_put_full_page(page->pp, page, allow_direct);
> +       page_pool_put_full_page(page_pool_to_pp(page), page, allow_direct);
>  }
>
>  static inline void *
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index 43574bd6612f..beee7ddd77a5 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -137,7 +137,8 @@ static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
>                 return false;
>         }
>
> -       page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
> +       page_pool_dma_sync_for_cpu(page_pool_to_pp(page), page, fqe->offset,
> +                                  len);
>
>         return true;
>  }
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 793e6fd78bc5..1659f1995985 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -83,6 +83,11 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  }
>  #endif
>
> +static inline struct page_pool *page_pool_to_pp(struct page *page)
> +{
> +       return page->pp;
> +}
> +
>  /**
>   * page_pool_dev_alloc_pages() - allocate a page.
>   * @pool:      pool from which to allocate
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6841e61a6bd0..54e8e7cf2bc9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1033,7 +1033,8 @@ bool napi_pp_put_page(netmem_ref netmem)
>         if (unlikely(!is_pp_netmem(netmem)))
>                 return false;
>
> -       page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
> +       page_pool_put_full_netmem(page_pool_to_pp(netmem_to_page(netmem)),
> +                                 netmem, false);
>
>         return true;
>  }
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index bcc5551c6424..e8582036b411 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -384,7 +384,8 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
>                 /* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
>                  * as mem->type knows this a page_pool page
>                  */
> -               page_pool_put_full_page(page->pp, page, napi_direct);
> +               page_pool_put_full_page(page_pool_to_pp(page), page,
> +                                       napi_direct);
>                 break;
>         case MEM_TYPE_PAGE_SHARED:
>                 page_frag_free(data);
> --
> 2.33.0
>

