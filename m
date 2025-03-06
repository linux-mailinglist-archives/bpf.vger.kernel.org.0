Return-Path: <bpf+bounces-53432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01CA53EF1
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2812169974
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A663D;
	Thu,  6 Mar 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U67+dyc8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B192CA6B
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220028; cv=none; b=Sdg3CxuS4RvBFT5KaRZ+si1uOxXqMkW3KaUKaIh8ZhZ3u5kOvEjW5cvOmbQdJ66aU/74MeSk3ViW8txV4VnCuuVmoZME74U/yvyXCn/iRfXxziQZtoZ9oRfhQ+XlPxBGlMjkzNvJHjArgg8sC0/vYqLPy/ZlB4wjqMtiZMHkBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220028; c=relaxed/simple;
	bh=CbB+t2wx8ulyAV+Ao8n/oRFHi5dJ3R8LpSdjZsjgwiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/I3l5hm8a1CAbvTSsyA7NMVxFY/JXrUOd3U6lAP6xf9wmhDc2mVrhO2Q7W9Q2uyVCo6MOhEGmbKppO/hZwnSt1LHrPGSNB5aLWAmmJ/WIkouIZYmbMMKhKUU7RMe8fbI1WoMrYBi/l2z3mjxrPqZnWh3mjgU3RcKSH0RWZcvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U67+dyc8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223722270b7so31185ad.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741220026; x=1741824826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDnLFwEvvEpNYu/pftJLZDDdebALTcuGQmwyzcVj2go=;
        b=U67+dyc8jfBNXe+/9ysSAPv2PeLqNonbT9Fl4bj05uaQ0Ji7wSK9hrFr0c8lNykDCr
         0MdDxN9nT2Y9lBE8WMpehTK6rqm0o8vMqOynoKTRJaz2Duzhi/ZMBTxVENEq4OPyU7Ca
         GTj3v9Cr/jJ974u0mpTny+vQBis/65PDq3aUnCYrSB/x60nwId4Ft5ASRXwWXjuiJZIZ
         mISZK9FIy17/AlAegQZKE7F+djQC6u69g8JZEYCea+KXCqcmpXsUunar5SqhBfQC4jcK
         4xfCWZqTbwYAEVa5CDhrNjZzRvkoNVDoBt1bb/QwhbpDQTHKFAEj0lU0QqRWdXXtlZyq
         gb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220026; x=1741824826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDnLFwEvvEpNYu/pftJLZDDdebALTcuGQmwyzcVj2go=;
        b=Lz3lAyPdyM3M8yw8EExqWjrnI+eeVzQEN4QTchRq10z+MNEMfev5X9XLSj9BxtvtXS
         1bNTrNCjVRujETuN/5AjAjOZUApwFLYShu5f/hEnxYhzovYBdVDvZErxfqSewrDQ1w7o
         Chjy/E4PFt3Ln1ybBysZH5mlyCG39dykUSmllCrwIazqjFgwsByrQ5mq7GlK0p/P8DEU
         U/TTvNK9zQeLZUv5pe9TD6UOW9YWIsa7/2F2XUv5xK71zaaOsNhW4GhUHq78CYVy41lQ
         6/2DkoqgvjvqwWDT5cnczV/Z0mFUJxB6Jg5YQaI3zI7bFJ0NPbqEzC7S1EGIo5/4Mr28
         Db5w==
X-Forwarded-Encrypted: i=1; AJvYcCUlfgxEA4KH10X4KyloDTamb56HOT78A2M9kGDvTnS39qGeZBRbAkeYpE4V730TQyEMpk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjbbNDpO3fc3z2n9rOFuYBDqIi2LAOBISIz0RaxSRulvZq+AY
	36FY2N8zLTYvhT+DX1DIlSIktLJTYZ1lxLyjJq45MMmGM86uWM+HPzodEAHklK8JzNwsVTqbW/i
	XXNweSaRQqF3QJYxj5GhYWpuqX5scfostb7Td
X-Gm-Gg: ASbGncsioSZ2u4sH3ZI1YCXrorQoJyGoyvkdInFUhmIgzOpfiGZYnAAAd0qxc77viy3
	OSpWdtu9UpWz4KU73JoyjQY7ryjYimGfa1eRvHE/U2MdHf8rYIb7vwGAZOBxPujsi7Zwbm5pruQ
	SAl3D9vWG+wIkGRsVkXGMLjd1RXJDVa6Facdh9IOxnBHO61UdNnc/UPClT
X-Google-Smtp-Source: AGHT+IGy6mwqDeE6hP4mW2lNUaQoNEOULztBWV7SpORptZ7wD7ESKPioklawIj1QBzqVCmZgosG173WYV9rdFUAdXf4=
X-Received: by 2002:a17:903:32cb:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-2240e4416eamr531465ad.1.1741220025366; Wed, 05 Mar 2025
 16:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com> <20250305162132.1106080-2-aleksander.lobakin@intel.com>
In-Reply-To: <20250305162132.1106080-2-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Mar 2025 16:13:32 -0800
X-Gm-Features: AQ5f1JpwyS2LgVF_6CQ0Nd6F_1zne96k1n8huufqfHiSYKpnVo2qZ5P3BVu139Y
Message-ID: <CAHS8izNnNJZsEXwZ07zhpn8AjxhGGcm9vyt8uFos1rVvn66qsQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:23=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Back when the libeth Rx core was initially written, devmem was a draft
> and netmem_ref didn't exist in the mainline. Now that it's here, make
> libeth MP-agnostic before introducing any new code or any new library
> users.
> When it's known that the created PP/FQ is for header buffers, use faster
> "unsafe" underscored netmem <--> virt accessors as netmem_is_net_iov()
> is always false in that case, but consumes some cycles (bit test +
> true branch).
> Misc: replace explicit EXPORT_SYMBOL_NS_GPL("NS") with
> DEFAULT_SYMBOL_NAMESPACE.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/libeth/rx.h                       | 22 +++++++------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 14 ++++----
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 33 +++++++++++--------
>  drivers/net/ethernet/intel/libeth/rx.c        | 20 ++++++-----
>  5 files changed, 51 insertions(+), 40 deletions(-)
>
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index ab05024be518..7d5dc58984b1 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>
>  #ifndef __LIBETH_RX_H
>  #define __LIBETH_RX_H
> @@ -31,7 +31,7 @@
>
>  /**
>   * struct libeth_fqe - structure representing an Rx buffer (fill queue e=
lement)
> - * @page: page holding the buffer
> + * @netmem: network memory reference holding the buffer
>   * @offset: offset from the page start (to the headroom)
>   * @truesize: total space occupied by the buffer (w/ headroom and tailro=
om)
>   *
> @@ -40,7 +40,7 @@
>   * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
>   */
>  struct libeth_fqe {
> -       struct page             *page;
> +       netmem_ref              netmem;
>         u32                     offset;
>         u32                     truesize;
>  } __aligned_largest;
> @@ -102,15 +102,16 @@ static inline dma_addr_t libeth_rx_alloc(const stru=
ct libeth_fq_fp *fq, u32 i)
>         struct libeth_fqe *buf =3D &fq->fqes[i];
>
>         buf->truesize =3D fq->truesize;
> -       buf->page =3D page_pool_dev_alloc(fq->pp, &buf->offset, &buf->tru=
esize);
> -       if (unlikely(!buf->page))
> +       buf->netmem =3D page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
> +                                                &buf->truesize);
> +       if (unlikely(!buf->netmem))
>                 return DMA_MAPPING_ERROR;
>
> -       return page_pool_get_dma_addr(buf->page) + buf->offset +
> +       return page_pool_get_dma_addr_netmem(buf->netmem) + buf->offset +
>                fq->pp->p.offset;
>  }
>
> -void libeth_rx_recycle_slow(struct page *page);
> +void libeth_rx_recycle_slow(netmem_ref netmem);
>
>  /**
>   * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
> @@ -126,18 +127,19 @@ void libeth_rx_recycle_slow(struct page *page);
>  static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
>                                           u32 len)
>  {
> -       struct page *page =3D fqe->page;
> +       netmem_ref netmem =3D fqe->netmem;
>
>         /* Very rare, but possible case. The most common reason:
>          * the last fragment contained FCS only, which was then
>          * stripped by the HW.
>          */
>         if (unlikely(!len)) {
> -               libeth_rx_recycle_slow(page);
> +               libeth_rx_recycle_slow(netmem);

I think before this patch this would have expanded to:

page_pool_put_full_page(pool, page, true);

But now I think it expands to:

page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);

Is the switch from true to false intentional? Is this a slow path so
it doesn't matter?

>                 return false;
>         }
>
> -       page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
> +       page_pool_dma_sync_netmem_for_cpu(netmem_get_pp(netmem), netmem,
> +                                         fqe->offset, len);
>
>         return true;
>  }
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/et=
hernet/intel/iavf/iavf_txrx.c
> index 422312b8b54a..35d353d38129 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -723,7 +723,7 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_r=
ing)
>         for (u32 i =3D rx_ring->next_to_clean; i !=3D rx_ring->next_to_us=
e; ) {
>                 const struct libeth_fqe *rx_fqes =3D &rx_ring->rx_fqes[i]=
;
>
> -               page_pool_put_full_page(rx_ring->pp, rx_fqes->page, false=
);
> +               libeth_rx_recycle_slow(rx_fqes->netmem);
>
>                 if (unlikely(++i =3D=3D rx_ring->count))
>                         i =3D 0;
> @@ -1197,10 +1197,11 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
>                              const struct libeth_fqe *rx_buffer,
>                              unsigned int size)
>  {
> -       u32 hr =3D rx_buffer->page->pp->p.offset;
> +       u32 hr =3D netmem_get_pp(rx_buffer->netmem)->p.offset;
>
> -       skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> -                       rx_buffer->offset + hr, size, rx_buffer->truesize=
);
> +       skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> +                              rx_buffer->netmem, rx_buffer->offset + hr,
> +                              size, rx_buffer->truesize);
>  }
>
>  /**
> @@ -1214,12 +1215,13 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
>  static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer=
,
>                                       unsigned int size)
>  {
> -       u32 hr =3D rx_buffer->page->pp->p.offset;
> +       struct page *buf_page =3D __netmem_to_page(rx_buffer->netmem);
> +       u32 hr =3D buf_page->pp->p.offset;
>         struct sk_buff *skb;
>         void *va;
>
>         /* prefetch first cache line of first page */
> -       va =3D page_address(rx_buffer->page) + rx_buffer->offset;
> +       va =3D page_address(buf_page) + rx_buffer->offset;
>         net_prefetch(va + hr);
>
>         /* build an skb around the page buffer */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/driver=
s/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index eae1b6f474e6..aeb2ca5f5a0a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -1009,7 +1009,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_que=
ue *rx_q, int budget)
>                         break;
>
>  skip_data:
> -               rx_buf->page =3D NULL;
> +               rx_buf->netmem =3D 0;
>
>                 IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
>                 cleaned_count++;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/et=
hernet/intel/idpf/idpf_txrx.c
> index bdf52cef3891..6254806c2072 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -382,12 +382,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport=
 *vport)
>   */
>  static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)
>  {
> -       if (unlikely(!rx_buf->page))
> +       if (unlikely(!rx_buf->netmem))
>                 return;
>
> -       page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
> +       libeth_rx_recycle_slow(rx_buf->netmem);
>
> -       rx_buf->page =3D NULL;
> +       rx_buf->netmem =3D 0;
>         rx_buf->offset =3D 0;
>  }
>
> @@ -3096,10 +3096,10 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *=
rxq, struct sk_buff *skb,
>  void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
>                       unsigned int size)
>  {
> -       u32 hr =3D rx_buf->page->pp->p.offset;
> +       u32 hr =3D netmem_get_pp(rx_buf->netmem)->p.offset;
>
> -       skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
> -                       rx_buf->offset + hr, size, rx_buf->truesize);
> +       skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags, rx_buf->ne=
tmem,
> +                              rx_buf->offset + hr, size, rx_buf->truesiz=
e);
>  }
>
>  /**
> @@ -3122,16 +3122,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_=
fqe *hdr,
>                              struct libeth_fqe *buf, u32 data_len)
>  {
>         u32 copy =3D data_len <=3D L1_CACHE_BYTES ? data_len : ETH_HLEN;
> +       struct page *hdr_page, *buf_page;
>         const void *src;
>         void *dst;
>
> -       if (!libeth_rx_sync_for_cpu(buf, copy))
> +       if (unlikely(netmem_is_net_iov(buf->netmem)) ||
> +           !libeth_rx_sync_for_cpu(buf, copy))
>                 return 0;
>

I could not immediately understand why you need a netmem_is_net_iov
check here. libeth_rx_sync_for_cpu will delegate to
page_pool_dma_sync_netmem_for_cpu which should do the right thing
regardless of whether the netmem is a page or net_iov, right? Is this
to save some cycles?

--
Thanks,
Mina

