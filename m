Return-Path: <bpf+bounces-12983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8CD7D2CB3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5BD1C20837
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE393125A6;
	Mon, 23 Oct 2023 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOgYybI0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7363A8;
	Mon, 23 Oct 2023 08:28:47 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4DC0;
	Mon, 23 Oct 2023 01:28:46 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d501d3ffbso4128726d6.1;
        Mon, 23 Oct 2023 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698049725; x=1698654525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2el5B3d/edYoPLgmuwr9Mwa8TFkiwQOhj/8O9ejoqY=;
        b=TOgYybI0y26eHxeLQXU428Y5rHs+FxelewBBDru5zT96U0BUmkkpttoEyne8p2sjOu
         44rIGpMPqadFjU6bxAJHHmaTaqC7KdgU6sNZKJJaIPvpG9VkTD3wNm78Gc26qxfKtjdF
         XX8+L03Mi+zA4c4c8Ui+8yumVx3/QuyVDkCW3uNAnlKZChv9Fu79TqlbPpW32BH6zlse
         IEp5t917ig3yE8S3B+zkoLoWcj+pSauMStcr+hL5wCY8p9RoJtO0m5OZD6SYAi/d94q5
         hSsQJaBtbVN9zM85i7tpcClsBCrDZSBryW+9R7hSVm+p+zS1A/Th4r+HwRJIzS72jvNd
         bcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049725; x=1698654525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2el5B3d/edYoPLgmuwr9Mwa8TFkiwQOhj/8O9ejoqY=;
        b=G7b/4BShyNmSdnqBe1XKDOpZ+Ax1ohbpBoinnFBmfgoHyoUWv8F5hVu9znbCgYMv9i
         HeIbMEuFb0ZDVvIWdi14c7ewCRaufJtVFugvgij5nw2UqZJgnfh/8lbVXiwYBoNdR6Ku
         +8qRZfyg+G1PRn8V+7FFdoTFahLqfjqt0UbgcEofQb/Bnlsh+wii5Ky2i4xR1z0U1zcH
         CNt2aiK42zm3Cxh32QtTJxZDMneFTosSngSokA4ucchZmrkE/WqBc8Yy8fBXljU5u4lZ
         oDu1CcHgXpeVenXT3EzwkHyufwUkzeOyXu3yuaQzDuS3HHl1Ju/g/7Gepjdf82wabOZY
         K+QA==
X-Gm-Message-State: AOJu0YyYl/G8zd+0lHf/odInFbXPFMnke321kIQdQbv1GWun/psA4JLB
	12kylQ2MGqFbMpr8QK380xWFP0J9FlVLm69TAs4=
X-Google-Smtp-Source: AGHT+IHhPrK/U8eNAivjutwIZ6a0dSrVffu9c59zy7YXF145ShDpJhts5S/cHlmYEa+giKYUdhUQrzTtIgPEjBf6upQ=
X-Received: by 2002:a05:6214:21ec:b0:66a:d2c1:992d with SMTP id
 p12-20020a05621421ec00b0066ad2c1992dmr8742598qvj.0.1698049725097; Mon, 23 Oct
 2023 01:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-2-sdf@google.com>
In-Reply-To: <20231019174944.3376335-2-sdf@google.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Oct 2023 10:28:33 +0200
Message-ID: <CAJ8uoz3BXFWmA1imhSCZnmRp-+whrE6ge0T3QbA9gqqeb6deCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 19:50, Stanislav Fomichev <sdf@google.com> wrote:
>
> For zerocopy mode, tx_desc->addr can point to the arbitrary offset

nit: the -> an

> and carry some TX metadata in the headroom. For copy mode, there
> is no way currently to populate skb metadata.
>
> Introduce new tx_metadata_len umem config option that indicates how many
> bytes to treat as metadata. Metadata bytes come prior to tx_desc address
> (same as in RX case).
>
> The size of the metadata has the same constraints as XDP:
> - less than 256 bytes
> - 4-byte aligned
> - non-zero
>
> This data is not interpreted in any way right now.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/net/xdp_sock.h            |  1 +
>  include/net/xsk_buff_pool.h       |  1 +
>  include/uapi/linux/if_xdp.h       |  1 +
>  net/xdp/xdp_umem.c                |  4 ++++
>  net/xdp/xsk.c                     | 12 +++++++++++-
>  net/xdp/xsk_buff_pool.c           |  1 +
>  net/xdp/xsk_queue.h               | 17 ++++++++++-------
>  tools/include/uapi/linux/if_xdp.h |  1 +
>  8 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 7dd0df2f6f8e..5ae88a00f34a 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -30,6 +30,7 @@ struct xdp_umem {
>         struct user_struct *user;
>         refcount_t users;
>         u8 flags;
> +       u8 tx_metadata_len;
>         bool zc;
>         struct page **pgs;
>         int id;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index b0bdff26fc88..1985ffaf9b0c 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -77,6 +77,7 @@ struct xsk_buff_pool {
>         u32 chunk_size;
>         u32 chunk_shift;
>         u32 frame_len;
> +       u8 tx_metadata_len; /* inherited from umem */
>         u8 cached_need_wakeup;
>         bool uses_need_wakeup;
>         bool dma_need_sync;
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 8d48863472b9..2ecf79282c26 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -76,6 +76,7 @@ struct xdp_umem_reg {
>         __u32 chunk_size;
>         __u32 headroom;
>         __u32 flags;
> +       __u32 tx_metadata_len;
>  };
>
>  struct xdp_statistics {
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 06cead2b8e34..333f3d53aad4 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -199,6 +199,9 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
>         if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
>                 return -EINVAL;
>
> +       if (mr->tx_metadata_len > 256 || mr->tx_metadata_len % 4)
> +               return -EINVAL;

Should be >= 256 since the final internal destination is a u8 and the
documentation says "should be less than 256 bytes".

> +
>         umem->size = size;
>         umem->headroom = headroom;
>         umem->chunk_size = chunk_size;
> @@ -207,6 +210,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
>         umem->pgs = NULL;
>         umem->user = NULL;
>         umem->flags = mr->flags;
> +       umem->tx_metadata_len = mr->tx_metadata_len;
>
>         INIT_LIST_HEAD(&umem->xsk_dma_list);
>         refcount_set(&umem->users, 1);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index ba070fd37d24..ba4c77a24a83 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1265,6 +1265,14 @@ struct xdp_umem_reg_v1 {
>         __u32 headroom;
>  };
>
> +struct xdp_umem_reg_v2 {
> +       __u64 addr; /* Start of packet data area */
> +       __u64 len; /* Length of packet data area */
> +       __u32 chunk_size;
> +       __u32 headroom;
> +       __u32 flags;
> +};
> +
>  static int xsk_setsockopt(struct socket *sock, int level, int optname,
>                           sockptr_t optval, unsigned int optlen)
>  {
> @@ -1308,8 +1316,10 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>
>                 if (optlen < sizeof(struct xdp_umem_reg_v1))
>                         return -EINVAL;
> -               else if (optlen < sizeof(mr))
> +               else if (optlen < sizeof(struct xdp_umem_reg_v2))
>                         mr_size = sizeof(struct xdp_umem_reg_v1);
> +               else if (optlen < sizeof(mr))
> +                       mr_size = sizeof(struct xdp_umem_reg_v2);
>
>                 if (copy_from_sockptr(&mr, optval, mr_size))
>                         return -EFAULT;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 49cb9f9a09be..386eddcdf837 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>                 XDP_PACKET_HEADROOM;
>         pool->umem = umem;
>         pool->addrs = umem->addrs;
> +       pool->tx_metadata_len = umem->tx_metadata_len;
>         INIT_LIST_HEAD(&pool->free_list);
>         INIT_LIST_HEAD(&pool->xskb_list);
>         INIT_LIST_HEAD(&pool->xsk_tx_list);
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 13354a1e4280..c74a1372bcb9 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -143,15 +143,17 @@ static inline bool xp_unused_options_set(u32 options)
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>                                             struct xdp_desc *desc)
>  {
> -       u64 offset = desc->addr & (pool->chunk_size - 1);
> +       u64 addr = desc->addr - pool->tx_metadata_len;
> +       u64 len = desc->len + pool->tx_metadata_len;
> +       u64 offset = addr & (pool->chunk_size - 1);
>
>         if (!desc->len)
>                 return false;
>
> -       if (offset + desc->len > pool->chunk_size)
> +       if (offset + len > pool->chunk_size)
>                 return false;
>
> -       if (desc->addr >= pool->addrs_cnt)
> +       if (addr >= pool->addrs_cnt)
>                 return false;
>
>         if (xp_unused_options_set(desc->options))
> @@ -162,16 +164,17 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>                                               struct xdp_desc *desc)
>  {
> -       u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
> +       u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
> +       u64 len = desc->len + pool->tx_metadata_len;
>
>         if (!desc->len)
>                 return false;
>
> -       if (desc->len > pool->chunk_size)
> +       if (len > pool->chunk_size)
>                 return false;
>
> -       if (addr >= pool->addrs_cnt || addr + desc->len > pool->addrs_cnt ||
> -           xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
> +       if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> +           xp_desc_crosses_non_contig_pg(pool, addr, len))
>                 return false;
>
>         if (xp_unused_options_set(desc->options))
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 73a47da885dc..34411a2e5b6c 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -76,6 +76,7 @@ struct xdp_umem_reg {
>         __u32 chunk_size;
>         __u32 headroom;
>         __u32 flags;
> +       __u32 tx_metadata_len;
>  };
>
>  struct xdp_statistics {
> --
> 2.42.0.655.g421f12c284-goog
>
>

