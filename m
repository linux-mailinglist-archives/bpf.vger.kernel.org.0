Return-Path: <bpf+bounces-17532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDD80EE1E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ADD1F21623
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178B6F63A;
	Tue, 12 Dec 2023 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMQO8Pg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C97AD;
	Tue, 12 Dec 2023 05:52:01 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f68824694so9154885a.0;
        Tue, 12 Dec 2023 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702389120; x=1702993920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DSj9HArsmUWrWsZkgJ2wfKDN+jx83el0yD5kZAUyJ0=;
        b=KMQO8Pg6O4qnOc3UVRcHGJM/D/ulII5GJ7sw4tluES9b92iaFzoIOrwN/gyx1dn6JV
         Gza51wuAZ80oRf1eoq6exQ05ADj8ttnucfp0RYfEqesC9r5xDniTjGxZOdEypA9Zha3K
         eCwbYm0atvL19/UO/PYxMAy+k4K8nm+GTudNynRKac0lNa4ms38n7tAEgwFBkLyE3jb8
         Pu3FTxE5X9FLEbXZrHbdAJ0d/bec5vWio2ENBwMXl2NtGrWwYa/7IOpr03HdFDYLl1LM
         kXDE86Ej4gnqhqdEtkB3ggrHc5G7sLvoGrBbJB95jxAnB67mWVY3LK3T3AGy8v6YjpOl
         eJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389120; x=1702993920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DSj9HArsmUWrWsZkgJ2wfKDN+jx83el0yD5kZAUyJ0=;
        b=acKP1GTOMQNkzuvG8rtKysi0XX1P9sI4RefJ2U5Q6PoUdD6NEnY3acVZKXJSMTCFtF
         KrSTFN2HRVoNnQrHdsZC/oNmoLmXqP0y+H/P43A4OqQH1rLUyWTYLoCDsCeFBy9AtUn8
         ABoLg9XoLvrKbQBvI1jfHDRLq5iYKPnqI8rMAquw8uznZ1hXT5tTCXuuCiH3VICjT9Ag
         9/rSuDORGMV5ZSZCAkmhzORoSRIaZ1C6aNvACTlNRRJULVdBNGPurSTrYpK0wNwwnu97
         Mo4wesY13BjE+R6J7Y3InnAzwrGeO95L287zCnXrB0O2MEJvw++30Df0nHPoNLJhkr3Z
         GMuw==
X-Gm-Message-State: AOJu0YzmPZHFxEJASWpSUqN+rg/0NomaFiSbwEkrFvkzQxDFV6QjJyBl
	OEwIHYhrj4t19v62wgch/ODaR3XHtUdP0gqhO90=
X-Google-Smtp-Source: AGHT+IH+J0MYsp+6RBByiQFZbj6C5PIVoIcOqafzQfoUnut0QGDo3i1II59DP55FlY3tXJSLxC4pCpZkVSo6mKMfejA=
X-Received: by 2002:ad4:4bd0:0:b0:67a:8957:64b0 with SMTP id
 l16-20020ad44bd0000000b0067a895764b0mr11006405qvw.3.1702389119910; Tue, 12
 Dec 2023 05:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205210847.28460-1-larysa.zaremba@intel.com> <20231205210847.28460-8-larysa.zaremba@intel.com>
In-Reply-To: <20231205210847.28460-8-larysa.zaremba@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 12 Dec 2023 14:51:48 +0100
Message-ID: <CAJ8uoz1dBBtR1id-9a-t3utXSFiSrihmC=S0p+usFVQ6yN2+Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 07/18] xsk: add functions to fill control buffer
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Alexander Lobakin <alexandr.lobakin@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 22:11, Larysa Zaremba <larysa.zaremba@intel.com> wrote:
>
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> Commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk") has added
> a buffer for custom data to xdp_buff_xsk. Particularly, this memory is used
> for data, consumed by XDP hints kfuncs. It does not always change on
> a per-packet basis and some parts can be set for example, at the same time
> as RX queue info.
>
> Add functions to fill all cbs in xsk_buff_pool with the same metadata.

Thanks Larysa and Maciej.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  include/net/xdp_sock_drv.h  | 17 +++++++++++++++++
>  include/net/xsk_buff_pool.h |  2 ++
>  net/xdp/xsk_buff_pool.c     | 12 ++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 81e02de3f453..b62bb8525a5f 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -14,6 +14,12 @@
>
>  #ifdef CONFIG_XDP_SOCKETS
>
> +struct xsk_cb_desc {
> +       void *src;
> +       u8 off;
> +       u8 bytes;
> +};
> +
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
> @@ -47,6 +53,12 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
>         xp_set_rxq_info(pool, rxq);
>  }
>
> +static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
> +                                   struct xsk_cb_desc *desc)
> +{
> +       xp_fill_cb(pool, desc);
> +}
> +
>  static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
>  {
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> @@ -274,6 +286,11 @@ static inline void xsk_pool_set_rxq_info(struct xsk_buff_pool *pool,
>  {
>  }
>
> +static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
> +                                   struct xsk_cb_desc *desc)
> +{
> +}
> +
>  static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
>  {
>         return 0;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 8d48d37ab7c0..99dd7376df6a 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -12,6 +12,7 @@
>
>  struct xsk_buff_pool;
>  struct xdp_rxq_info;
> +struct xsk_cb_desc;
>  struct xsk_queue;
>  struct xdp_desc;
>  struct xdp_umem;
> @@ -135,6 +136,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
>
>  /* AF_XDP ZC drivers, via xdp_sock_buff.h */
>  void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
> +void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc);
>  int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
>                unsigned long attrs, struct page **pages, u32 nr_pages);
>  void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 4f6f538a5462..28711cc44ced 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -125,6 +125,18 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
>  }
>  EXPORT_SYMBOL(xp_set_rxq_info);
>
> +void xp_fill_cb(struct xsk_buff_pool *pool, struct xsk_cb_desc *desc)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < pool->heads_cnt; i++) {
> +               struct xdp_buff_xsk *xskb = &pool->heads[i];
> +
> +               memcpy(xskb->cb + desc->off, desc->src, desc->bytes);
> +       }
> +}
> +EXPORT_SYMBOL(xp_fill_cb);
> +
>  static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  {
>         struct netdev_bpf bpf;
> --
> 2.41.0
>

