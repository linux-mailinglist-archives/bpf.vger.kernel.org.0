Return-Path: <bpf+bounces-48405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBEAA07BCF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A40E3AB7CC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8127721CA1F;
	Thu,  9 Jan 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+aSG3jn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959D219A97;
	Thu,  9 Jan 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436151; cv=none; b=WpunDbJmBeqPJiuecENOrZWJ2UbW53tf8CjAXaIZj3pPFwIcU5EELUnzSSfc2+54/zvWo3x7s/hsWvfvtVTLOvQLK2IrKADTUAILMRCNGPbgLP1uCl/sF7diFgdM+yAeI8r9mH82wamBQTufC9tDVDEF81sJvyu7FMr5HFkrKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436151; c=relaxed/simple;
	bh=deHBZmmhZJQ1mB96LT50et1dZHJDRyTgJ1K59XCtvHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z21lWDU+VAymhGRzt47cw3jGvJcCF/YzXLiHgL939g8I4UJafbgwzxlSrHK3tTepLVX+STLrtWg5OzN4LCm/3iBzQaVXU9PbQpFM/XWB3zg09S3Ftns7MQxdtYAVbaK6wnkdXT4bKe9UzAAyYsryNMEeExL6XPpbBG0vDgw/eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+aSG3jn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dce7263beaso9519276d6.3;
        Thu, 09 Jan 2025 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736436148; x=1737040948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fcg3/DfftZTPey65NfLlkT9BL5qUIuwyMqfC8or7FBA=;
        b=l+aSG3jnne+74k1qATakYaopgMJtA0AU9qvU7VNNm0W6xJfeAWuXIvaTQDAGCHrET5
         ihSGPOKDZ+aZsARrU62IYKaqcCrrC0oISCk5itI5PrJofmPyufzG48o6imzmNtntqlXv
         7+pB4Dbu0HzRksyfUnhKupEiSvB9cbxxTj63ZDCxv66ilhlurs8pS936CjfsbG8tlWGz
         OifGCS0e/tiLdXH/A7Tiufm9+Dv896KjJfiso3fN8QfM6KKwmIf5jnZRg2x62Lwo2k6Y
         ldCFrDboxEf8g3m2cI4ZiJW07XZqqcN+b7/yu7Xe4NI/3mFIe0Vm4yI6zqNe+WNsjMq8
         7MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736436148; x=1737040948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcg3/DfftZTPey65NfLlkT9BL5qUIuwyMqfC8or7FBA=;
        b=DLk/eIFC5gjRIk7Yu6I+zqRNzHpwjglFGplEeRjGBsRuJ/Q5VaipWAqVgiUG3ZecP1
         aW78rogULBxC1MFzSq5bXuM8KmZhHGtrjD1fovDjmnziY2A1IU4aArvk+mpwK+cA0MXr
         zTm802lUfDQn11lYtOscY7wqgvVgXODGU/byTmNQCmXgl5Gd3FZovIx5uOTRWTBUkvKe
         CiDnv2kOYQNSnWPc6hngFM/MvyGMK2R3cwi2w9OIGw+g2hO2Uu6xIWPFuLCCPUPnGM5A
         gVO74zz6cjekNUPxWl4btWGrGnGYKn9avLGgIsJwYICZ5pOzy3cPVOQeqdk2xQzhiR28
         dm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR9FSbeR4Qcwi0zGjcjFuYBBprYb30pekkWageQ27cIqsGpLgl76dJu/mdQ6GRpSbwNEc=@vger.kernel.org, AJvYcCXrlEfv1t35teAwmZo4jN6/0/Z6PoWo64yQMW+UvAlTwzCODuFMdTr56C+hKKBUZFSCVypFseuhoSCjwwEV@vger.kernel.org
X-Gm-Message-State: AOJu0YzJG9h9MuokiUrSHMXS4q8LIYYcQ+mmy/agB3HmVG72+Zphi41S
	uLd9Uc5xyBpqteF9iSA2xyCPzLe5U0baCOmsD1AfA96sF+FegiwK8G8wL1ToGxgO0LpRdUFfVaR
	0j2dfXCgn7wH7Q0gMpAKV+ATSe64=
X-Gm-Gg: ASbGncseg6+FS7cbC+47Obv+jCPJ+4QyVIYhj3oyEmL9tzLd4exqXpxq7pkW6H410dA
	GPC22J+z+mPltPTSj6ofvFL+X3ZDAHxdGgacUUw==
X-Google-Smtp-Source: AGHT+IGtc8B05KJhD7xy2xdv1NbTLL6qgEF2fS/9anHBEUYll0detRjgRUi5idu/CfzHA5R40YHpLPMnELv0MemNIhY=
X-Received: by 2002:ad4:5c68:0:b0:6d8:9065:2033 with SMTP id
 6a1803df08f44-6df9b285eb0mr113381566d6.31.1736436148035; Thu, 09 Jan 2025
 07:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109003436.2829560-1-sdf@fomichev.me>
In-Reply-To: <20250109003436.2829560-1-sdf@fomichev.me>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 9 Jan 2025 16:22:16 +0100
X-Gm-Features: AbW1kvYG-Dt_dpM4v0JLNFOS4TcDIMxcJ4A-lYMpAUp7D6v_JhnnQusvGrKv9FQ
Message-ID: <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>
Subject: Re: [PATCH net] xsk: Bring back busy polling support
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 01:35, Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> assignment to a later point in time (napi_hash_add_with_id). This breaks
> __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> to busy-poll AF_XDP sockets anymore.
>
> Bring back the ability to busy-poll on XSK by resolving socket's napi_id
> at bind time. This relies on relatively recent netif_queue_set_napi,
> but (assume) at this point most popular drivers should have been converted.
> This also removes per-tx/rx cycles which used to check and/or set
> the napi_id value.
>
> Confirmed by running a busy-polling AF_XDP socket
> (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> from /proc/net/netstat.

Thanks Stanislav for finding and fixing this. As a bonus, the
resulting code is much nicer too.

I just took a look at the Intel drivers and some of our drivers have
not been converted to use netif_queue_set_napi() yet. Just ice, e1000,
and e1000e use it. But that is on us to fix.

From the xsk point of view:
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/net/busy_poll.h    |  8 --------
>  include/net/xdp.h          |  1 -
>  include/net/xdp_sock_drv.h | 14 --------------
>  net/core/xdp.c             |  1 -
>  net/xdp/xsk.c              | 14 +++++++++-----
>  5 files changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index c858270141bc..c39a426ebf52 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -174,12 +174,4 @@ static inline void sk_mark_napi_id_once(struct sock *sk,
>  #endif
>  }
>
> -static inline void sk_mark_napi_id_once_xdp(struct sock *sk,
> -                                           const struct xdp_buff *xdp)
> -{
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> -       __sk_mark_napi_id_once(sk, xdp->rxq->napi_id);
> -#endif
> -}
> -
>  #endif /* _LINUX_NET_BUSY_POLL_H */
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index e6770dd40c91..b5b10f2b88e5 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -62,7 +62,6 @@ struct xdp_rxq_info {
>         u32 queue_index;
>         u32 reg_state;
>         struct xdp_mem_info mem;
> -       unsigned int napi_id;
>         u32 frag_size;
>  } ____cacheline_aligned; /* perf critical, avoid false-sharing */
>
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 40085afd9160..7a7316d9c0da 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -59,15 +59,6 @@ static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
>         xp_fill_cb(pool, desc);
>  }
>
> -static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
> -{
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> -       return pool->heads[0].xdp.rxq->napi_id;
> -#else
> -       return 0;
> -#endif
> -}
> -
>  static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
>                                       unsigned long attrs)
>  {
> @@ -306,11 +297,6 @@ static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
>  {
>  }
>
> -static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
> -{
> -       return 0;
> -}
> -
>  static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
>                                       unsigned long attrs)
>  {
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index bcc5551c6424..2315feed94ef 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -186,7 +186,6 @@ int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
>         xdp_rxq_info_init(xdp_rxq);
>         xdp_rxq->dev = dev;
>         xdp_rxq->queue_index = queue_index;
> -       xdp_rxq->napi_id = napi_id;
>         xdp_rxq->frag_size = frag_size;
>
>         xdp_rxq->reg_state = REG_STATE_REGISTERED;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3fa70286c846..89d2bef96469 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -322,7 +322,6 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>                 return -ENOSPC;
>         }
>
> -       sk_mark_napi_id_once_xdp(&xs->sk, xdp);
>         return 0;
>  }
>
> @@ -908,11 +907,8 @@ static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len
>         if (unlikely(!xs->tx))
>                 return -ENOBUFS;
>
> -       if (sk_can_busy_loop(sk)) {
> -               if (xs->zc)
> -                       __sk_mark_napi_id_once(sk, xsk_pool_get_napi_id(xs->pool));
> +       if (sk_can_busy_loop(sk))
>                 sk_busy_loop(sk, 1); /* only support non-blocking sockets */
> -       }
>
>         if (xs->zc && xsk_no_wakeup(sk))
>                 return 0;
> @@ -1298,6 +1294,14 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>         xs->queue_id = qid;
>         xp_add_xsk(xs->pool, xs);
>
> +       if (xs->zc && qid < dev->real_num_rx_queues) {
> +               struct netdev_rx_queue *rxq;
> +
> +               rxq = __netif_get_rx_queue(dev, qid);
> +               if (rxq->napi)
> +                       __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
> +       }
> +
>  out_unlock:
>         if (err) {
>                 dev_put(dev);
> --
> 2.47.1
>
>

