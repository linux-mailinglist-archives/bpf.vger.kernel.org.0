Return-Path: <bpf+bounces-62967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A3B00B6D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834E93B4916
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3D2FCFD2;
	Thu, 10 Jul 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6TBkXCj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9762FCE1A
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172190; cv=none; b=Ufh7+nwwh3X+BMbllsHMLMsg/nlEBnXxlaFI/DlzC4Z3ct5Hvf1JCP+rbrEJEr4NojvhZYJWm+6JM9Nmm+HyhfPBEnKOs2dKJy+O5NLgIs68W+yLeSQBpRtxeGVk8X2FiWGNzF0p6P+ajlbYpulrzETLZ5PSzGcRiU/lWeyBOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172190; c=relaxed/simple;
	bh=XhzeOVnGG90EuOKlpcIA49U19NvJeJfXJnX6bYAZwwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOmwRDKm/QkN/niKmyamXtdG31Jit+0bdpmXIE84AXNln50lScs14BE8cB6BtqEpe7tmtpf1azYPTDivuzyHjdEOgiDU/B2pYOWVBr4oZ9zdCgwSM04L4pe35XcIgUnvsGf1ucPMY8vnR690eSRNZqJDhf9cS8B0578U8RGnfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6TBkXCj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e389599fso32365ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752172188; x=1752776988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro/pNusaSjsWEAeWpTTGWyr6dzux21WEDh0Yp0DuJJc=;
        b=h6TBkXCjIsIV5dQNID5gQEOPO0lCDvYKZbhkTuLlDQx0Zooy3DR4x9Erf3DpUOV4MJ
         K+uMuJOnrIQqVyfBpAQKzzuqYH70sJFs7znUg0ApjSN79Gw0vorG3ghvE6TBYl4I8pw+
         goDouEajQBH1lBPeOqAdRpHlIJ9aKc120R1fmb2eWIoech8A8nes8DBBXWeh6TOA/cPb
         i5CuA9oG27Rtd/dWQlCBopV9+XsigaDwScnP2oh08ia2/kSrQRA4Y7BZFS6b0YCGGObC
         UsDtAh0nscLBEPwgD6E1/IoFfoE02Xu1k+TwpkkHDtD/4X7YQYWIxW+FpbfFsiIsRksA
         4iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172188; x=1752776988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro/pNusaSjsWEAeWpTTGWyr6dzux21WEDh0Yp0DuJJc=;
        b=Kec0oRQn9BeG7vHrHYN607Wn4M44vB+yXPO6LMuZ7CTtVfRYy2Xt0ar2J3FEN2/KVT
         aNFQtgnqYSYEBiSYKBAUXpC/9I4ThXXHFwBMeESYsoTaONjrOvE9pvPuRiQxW92KqGO7
         VZm6OGWPloAk1/7ZjLVsjPmQgxPRlKlkXt5ZawTC0oKpVMFmWTk1s+GlhGQ68PkhtC79
         jTN+p6LTknvF7qlZ5mCWRUtLvMbpzNoq+FTcBvSGr9sKG/rNqOWc5MLm4U8rwzZmq2C/
         Kl3g5Bh1dfWsIioArYhKnwdRu+KGSqB4FsLHYE4k9bggC7/+kpPzYoh0CyWamkyEHOo8
         1zMw==
X-Forwarded-Encrypted: i=1; AJvYcCVxULwAgpYOU3bn2yH6CkUdwucuRASx4efy6aBxTOQG8UTEgbmA4zFFSi1eNqCVbjk23Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwMq7oWvDPUcAPVA9I/OgBjGWJDkp5ZB8OqdtzFA/AdAAjiqA
	oeXP6UWfuSSkQzfjY65hMVft2IZk4dcYObbJXhZx/fWIOqUSQ8I2EEccEV4OWbWjjyfhzz0Wo94
	UVhrniypN95ZPE8MDWG+wlNKaMv9zNo4wT88KQ79k
X-Gm-Gg: ASbGncu/DGUIy084bby8r/bw1XU/u20JkJhpRzVwkVorZYADpkONanrrnaIJwLcnH0P
	BMkSeP4DmG+JWxiQek8SliQvZklKzRQXVLarQEf0u/n3/t4RxdyjRzo2u9E0Z1pEyC6j/aqvs5P
	CHuPo/dEXVHnP4+kko53l7qDFeYy+7Mpf8nygPPS4UgMyBYg4V1rjCeZpQMLLLxkNN0G1+Np8=
X-Google-Smtp-Source: AGHT+IGDUh9i2QR+OkMh4fD77Cn7MdjzQa4MMPj+bj7Pxco//T5atBLGYHjMI7EeJmWwYCLX+z0Vvq1jG9YvLKt6WQc=
X-Received: by 2002:a17:902:e846:b0:235:e8da:8e1 with SMTP id
 d9443c01a7336-23dee27d5famr281145ad.18.1752172187759; Thu, 10 Jul 2025
 11:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-7-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-7-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:29:35 -0700
X-Gm-Features: Ac12FXzeYcyI9Q9DAscC8V1bkRMOGnCRm09FJHP9wMGxc_EiuS0WSo5wKouz6uY
Message-ID: <CAHS8izM9FO01kTxFhM8VUOqDFdtA80BbY=5xpKDM=S9fMcd3YA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/8] mlx4: use netmem descriptor and APIs for
 page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in mlx4 code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 48 +++++++++++---------
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 ++--
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  4 +-
>  3 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/eth=
ernet/mellanox/mlx4/en_rx.c
> index b33285d755b9..7cf0d2dc5011 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -62,18 +62,18 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *p=
riv,
>         int i;
>
>         for (i =3D 0; i < priv->num_frags; i++, frags++) {
> -               if (!frags->page) {
> -                       frags->page =3D page_pool_alloc_pages(ring->pp, g=
fp);
> -                       if (!frags->page) {
> +               if (!frags->netmem) {
> +                       frags->netmem =3D page_pool_alloc_netmems(ring->p=
p, gfp);
> +                       if (!frags->netmem) {
>                                 ring->alloc_fail++;
>                                 return -ENOMEM;
>                         }
> -                       page_pool_fragment_page(frags->page, 1);
> +                       page_pool_fragment_netmem(frags->netmem, 1);
>                         frags->page_offset =3D priv->rx_headroom;
>
>                         ring->rx_alloc_pages++;
>                 }
> -               dma =3D page_pool_get_dma_addr(frags->page);
> +               dma =3D page_pool_get_dma_addr_netmem(frags->netmem);
>                 rx_desc->data[i].addr =3D cpu_to_be64(dma + frags->page_o=
ffset);
>         }
>         return 0;
> @@ -83,10 +83,10 @@ static void mlx4_en_free_frag(const struct mlx4_en_pr=
iv *priv,
>                               struct mlx4_en_rx_ring *ring,
>                               struct mlx4_en_rx_alloc *frag)
>  {
> -       if (frag->page)
> -               page_pool_put_full_page(ring->pp, frag->page, false);
> +       if (frag->netmem)
> +               page_pool_put_full_netmem(ring->pp, frag->netmem, false);
>         /* We need to clear all fields, otherwise a change of priv->log_r=
x_info
> -        * could lead to see garbage later in frag->page.
> +        * could lead to see garbage later in frag->netmem.
>          */
>         memset(frag, 0, sizeof(*frag));
>  }
> @@ -440,29 +440,33 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_=
priv *priv,
>         unsigned int truesize =3D 0;
>         bool release =3D true;
>         int nr, frag_size;
> -       struct page *page;
> +       netmem_ref netmem;
>         dma_addr_t dma;
>
>         /* Collect used fragments while replacing them in the HW descript=
ors */
>         for (nr =3D 0;; frags++) {
>                 frag_size =3D min_t(int, length, frag_info->frag_size);
>
> -               page =3D frags->page;
> -               if (unlikely(!page))
> +               netmem =3D frags->netmem;
> +               if (unlikely(!netmem))
>                         goto fail;
>
> -               dma =3D page_pool_get_dma_addr(page);
> +               dma =3D page_pool_get_dma_addr_netmem(netmem);
>                 dma_sync_single_range_for_cpu(priv->ddev, dma, frags->pag=
e_offset,
>                                               frag_size, priv->dma_dir);
>
> -               __skb_fill_page_desc(skb, nr, page, frags->page_offset,
> -                                    frag_size);
> +               __skb_fill_netmem_desc(skb, nr, netmem, frags->page_offse=
t,
> +                                      frag_size);
>
>                 truesize +=3D frag_info->frag_stride;
>                 if (frag_info->frag_stride =3D=3D PAGE_SIZE / 2) {
> +                       struct page *page =3D netmem_to_page(netmem);

This cast is not safe, try to use the netmem type directly.

--=20
Thanks,
Mina

