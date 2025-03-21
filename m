Return-Path: <bpf+bounces-54560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F9A6C648
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 00:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C008480ABB
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398D1E3DE0;
	Fri, 21 Mar 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRNc6Zr+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1F1E51FF
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598813; cv=none; b=jNr8glnmLt5gnX7Gyo6y/Nttmunf05j0hg9FzZSW7mPuEHmGm6FKsB8bSnsx0JNE7uGCAnvbL1Shd1Jxuc1dGqE1hvujSkm8yLw+WIZcG1hd/nxpQUCAXcHnzSvPxJtmbTaBpq2UIRenlWPIkhHN7JLe7PPUNfSq+ujc73bTrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598813; c=relaxed/simple;
	bh=uFn9cls7wPw1ExWDyl25jEWNwCiGXwygOKPkcriR1wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDZZYb+mRnvLIKpuB9Vlz+NYEljoDlsl249Rf4u3ihrKFL1vll8RqFVSdiLrmAckyaeD9JVs7y2lwdYjzNgNd3NUtM42A6oz0/YRcrJFYENdy8vHTqq+zMDIl43irryyKv2ZXERlcswDapo0FGaY6Us1SwaH58SJ1r4YiCnEmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRNc6Zr+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240aad70f2so83345ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742598810; x=1743203610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbvnD5haxTLytS47gBGUy0pWnlYckQ3OAvL7U1cwfUA=;
        b=hRNc6Zr+J2FR/l+FdbH6+wHqEmNWj1AgvX/7VCBHNbn6TGlNtqjMPswbjvaENJvuHe
         w5jQYuTqbMdCOJiNti3cDrUjdn7D83i+2oOfkNjKywerYNoNElg8oIgapMu18DnvEoYh
         ik48aJHTiRvWDl4dkN25gIuEq0qK1ccIqolUEopL8p+I2usOgXRdCkHIxEjPbuawhr2a
         pz9TnUnCkpyMV/p9TcnfYNTx5xLIqhYdigOkDZnTGqe7FGisvadvpRuqsH4kQ7xHx6eq
         aHZS5DmkRQWwdaDn4pZaVu50h13iOoLteyObxOY/ytQOco4otttVVZx5lYMm/h9lBvn6
         OR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742598810; x=1743203610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbvnD5haxTLytS47gBGUy0pWnlYckQ3OAvL7U1cwfUA=;
        b=DFqS3heepWGty1dZ03CZi2qRgCnx635fF4ZUddLVIdc5DCZyD7/XS6jBxU3CyZ79oF
         UOkKHrgAucquzIL70ccq4ionTxoI/TpAXcBqNHxdQT02j5tkZPp6l1Sl/jt+U8RYJMd+
         iny/3cW6otJdPGZ568lYdZlR4n3QYWZsBRdwJdVQfXLIGmMhlUMXOjJieg4/K8YzFHRa
         6gHT+T8+wnmM571wabvDfVKbb8t9ieFVYa7N6vK9BFzPM/xopJ2ZdnDSqj9HuHoF9avS
         0K/1Rm048BrItk8JC7Esd7YP7zo2+obNpG997qXSzVBwR+anolYQypplgHQhQ7HqDxbd
         cWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXZanHZ9dAolvG0VBxvr5KRCzyZ00qAAlR6HwO/vJBvYM6FCynb2bltlOUiZ9r3Ykb6FZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/On3hf64Eh1DW6ZBSsu5g/Lxcec5EA2co6FA28zUspa1j+CR
	3CsUjyXrC9PVE5mMWT3raZDr7chxSqAhrHeHaIrnjH6xTDyafsagxO812EyMKvwwa0H+54Nak97
	xXCtw2XfM/h69YuC6/DvD8e7Pa3etEgQyXsh0
X-Gm-Gg: ASbGnctUBVuEu/LKaPKrPmp+Pkj5Tm/12Ppzuh+wKCZU0uM0ZOlThMUM97IiTuF4opl
	z0y5y702LF2vSuOJgI8nfqbBEkkrzibz9CmD7rnzUmaOBGriQkNuEft5e/F1JXs24LBOw7tuU21
	XvD1S7RpvTdMPSsFQgqN8vCsrOcL9lhy0lTiMPtFTQqIX31r2v4yRvduQ=
X-Google-Smtp-Source: AGHT+IGJfNj+BTaeUb7CmreHUKO1/d5/Yp0KjN22BdNR7eOnswfJOKqQxGDzzhLFJBXAju2i6SyYA+NISPX0wGE5064=
X-Received: by 2002:a17:903:234f:b0:21f:465d:c588 with SMTP id
 d9443c01a7336-227982bcf17mr1141275ad.14.1742598809765; Fri, 21 Mar 2025
 16:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com> <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 16:13:17 -0700
X-Gm-Features: AQ5f1Jr3pNjB7nwYsq0njhmiKzooW96U1O7ADhvC9S4zs33ypykXN0QQc-_3wro
Message-ID: <CAHS8izNPLnbZ-M=367k7H6OYts7RXbcDpbrWy_p37=62LsYYcg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Change the single-bit booleans for dma_sync into an unsigned long with
> BIT() definitions so that a subsequent patch can write them both with a
> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
> non-netmem providers as well.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  include/net/page_pool/helpers.h | 6 +++---
>  include/net/page_pool/types.h   | 8 ++++++--
>  net/core/devmem.c               | 3 +--
>  net/core/page_pool.c            | 9 +++++----
>  4 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 582a3d00cbe2315edeb92850b6a42ab21e509e45..7ed32bde4b8944deb7fb22e29=
1e95b8487be681a 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -443,6 +443,9 @@ static inline void __page_pool_dma_sync_for_cpu(const=
 struct page_pool *pool,
>                                                 const dma_addr_t dma_addr=
,
>                                                 u32 offset, u32 dma_sync_=
size)
>  {
> +       if (!(READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_CPU))
> +               return;
> +
>         dma_sync_single_range_for_cpu(pool->p.dev, dma_addr,
>                                       offset + pool->p.offset, dma_sync_s=
ize,
>                                       page_pool_get_dma_dir(pool));
> @@ -473,9 +476,6 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_p=
ool *pool,
>                                   const netmem_ref netmem, u32 offset,
>                                   u32 dma_sync_size)
>  {
> -       if (!pool->dma_sync_for_cpu)
> -               return;
> -
>         __page_pool_dma_sync_for_cpu(pool,
>                                      page_pool_get_dma_addr_netmem(netmem=
),
>                                      offset, dma_sync_size);

I think moving the check to __page_pool_dma_sync_for_cpu is fine, but
I would have preferred to keep it as-is actually.

I think if we're syncing netmem we should check dma_sync_for_cpu,
because the netmem may not be dma-syncable. But for pages, they will
likely always be dma-syncable. Some driver may have opted to do a perf
optimizations by calling __page_pool_dma_sync_for_cpu on a dma-addr
that it knows came from a page to save some cycles of netmem checking.

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index df0d3c1608929605224feb26173135ff37951ef8..fbe34024b20061e8bcd1d4474=
f6ebfc70992f1eb 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -33,6 +33,10 @@
>  #define PP_FLAG_ALL            (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |=
 \
>                                  PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNRE=
ADABLE_NETMEM)
>
> +/* bit values used in pp->dma_sync */
> +#define PP_DMA_SYNC_DEV        BIT(0)
> +#define PP_DMA_SYNC_CPU        BIT(1)
> +
>  /*
>   * Fast allocation side cache array/stack
>   *
> @@ -175,12 +179,12 @@ struct page_pool {
>
>         bool has_init_callback:1;       /* slow::init_callback is set */
>         bool dma_map:1;                 /* Perform DMA mapping */
> -       bool dma_sync:1;                /* Perform DMA sync for device */
> -       bool dma_sync_for_cpu:1;        /* Perform DMA sync for cpu */
>  #ifdef CONFIG_PAGE_POOL_STATS
>         bool system:1;                  /* This is a global percpu pool *=
/
>  #endif
>
> +       unsigned long dma_sync;
> +
>         __cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN)=
;
>         long frag_users;
>         netmem_ref frag_page;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 7c6e0b5b6acb55f376ec725dfb71d1f70a4320c3..16e43752566feb510b3e47fbe=
c2d8da0f26a6adc 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -337,8 +337,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>         /* dma-buf dma addresses do not need and should not be used with
>          * dma_sync_for_cpu/device. Force disable dma_sync.
>          */
> -       pool->dma_sync =3D false;
> -       pool->dma_sync_for_cpu =3D false;
> +       pool->dma_sync =3D 0;
>
>         if (pool->p.order !=3D 0)
>                 return -E2BIG;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..d51ca4389dd62d8bc266a9a2b=
792838257173535 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -203,7 +203,7 @@ static int page_pool_init(struct page_pool *pool,
>         memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
>
>         pool->cpuid =3D cpuid;
> -       pool->dma_sync_for_cpu =3D true;
> +       pool->dma_sync =3D PP_DMA_SYNC_CPU;
>

More pedantically this should have been pool->dma_sync |=3D
PP_DMA_SYNC_CPU, but it doesn't matter since this variable is 0
initialized I think.


--
Thanks,
Mina

