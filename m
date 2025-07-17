Return-Path: <bpf+bounces-63582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF81B08925
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FA0A478CE
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865EB28B3EE;
	Thu, 17 Jul 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GCQct+zG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F128A406
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744007; cv=none; b=dtlgH0xE5jwjsbIjvHpWRX1e/ISdA7tY7Q3nwFAv4DtDaR4I2EBqjBz43gdGkDIFnqc1dSBI0UjCDg2+9Rfqi1m56r/1XBOYlKG682AMGBoldM07/D1j9THhszrJUTMKaq4hiCmpWb7r07p9FcomV8lTvM/hbGXAQw+zzht6DZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744007; c=relaxed/simple;
	bh=4It3i10W2FunpmCz+Sfp2fYBu5KdHjFA5JJ5PdWIsGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNfZTkVvrmWa4hH3QB0jb1pQqTLvIJtaVPf3D84M0qESK5d8/eDaGJ6bsAt2E5UR8d5Kq7S9h6GDyLcKBMFHW8VuEg28mazGf20ksOVfg9oUHXpcinIW09KeT/0Po9tbZDu2UACIIn37tQSJ4cJ5VzIqLrG2+EVff5iWVkKhuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GCQct+zG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so109111466b.2
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752744002; x=1753348802; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8eVvkHXeO923oNuVhByESesfiOJRGb3nsdgZl+ywT4=;
        b=GCQct+zGQrmgrHQX1uMrSUmlxktfMFevuwpQMoQMFCh2nT3LVUFwzDwWVFH4pxm1gt
         jLgmEegFG8PrxkOBtsNI9XmQ9cMUBz0hvkGzIibZKTj1/ggbtj9z8MFBstOu6Ab/MrNT
         vyuKEIaOrDjRZDoT+1+9WJSqEXE9qXVS0qusnzIoD5vCVZDnL5VdFiZTTCkMMLc7ZtNS
         L5XDYm+D5q2OiSQp+hr9df528PgV2hMTkDyo3MWD3CkDDcpVhrr9Ez9jEKEFRrm0XMBN
         0ACctYoFZaKFpmo1/U8Efp4v1hiaML9onba3l1sSPtdEZkao8Y0XyMJLjkkAuuElegyc
         oUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744002; x=1753348802;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8eVvkHXeO923oNuVhByESesfiOJRGb3nsdgZl+ywT4=;
        b=otlwB+AV5R7ptwKGy2y69Z0c/KUqiVVVn9sqyH8YWTu5z2UyXht10MlF3U0vfHzoez
         nrqnpWEEby1Ew4yZXPz8fy56mhPRpNTA9dRrJTbmWNpinMxuSKaoJPeQz7LbvFNMdCVk
         vmHCH8OtgluZAdE2syeyOrxbmlxRv6eJuIv+AVGks+p5nfV3J8HUPn83EdZJS9AUssEL
         kIqmchQB3yAmtvpkrPx9kKKXXI7hyMZDJ9CetsF+RyWTBjWBWTycDj/5xLIGmQiya8Dz
         n6wjJD4cJSiwU+JEEJkQPVoR/1BJZGOyWk68ORUDDFyOdY0zpkDYlJ9QOedqz8Mji6Vz
         opYQ==
X-Gm-Message-State: AOJu0Yy+mFsQGeXZGqJcrA3mTlbL0yIb9DSLwUiOrRmx7oJ6xkrPzKZP
	uwRFoQlE6aZXBq/d2yGv2y3Nx3dCJky186zSvcBnxtXdYPK8OWAYJjL/WSVQYneaJnc=
X-Gm-Gg: ASbGncuGY9/iX5Ht6XeGX7N513elYOA/w3dRkXwoHYClFdOzEfSzGdmrTjlXKo1jMmj
	I1jTFTCluS00j2Ukw0LL7ySUd5u/vMgMa3fMGSddsfz0gHRd2MCsehk0hhKiMi7qr2agmwQBo3x
	uzHmod+kV8uohjbaDTixsAYDD82muwVmGkg8vRd1ktAtgJIxA57Wy7zSu3YMXuD5OQoALBNhl5V
	V1UtHIwD+Xlk5tFrIpOv3vTAfQsMJZiUBbViXGtgxCW416yU6mwN8Fu+7bhenNw99HL7AwvigYp
	EStbW9OYehZ8TIyh3KOrdz0qazd1NaNgGbjGLuiSG+6i+Im/iKQ8KWaL/hJOcE/Wa49SHwMKTCN
	Xn/ZpC1QS+LjhXg0=
X-Google-Smtp-Source: AGHT+IFgEwswSoad0QRUcDTwtT9lksr66BmfJK6JYnd1OJ4UVj825ik2KhJgRWjruIAfJbcQuIBRbg==
X-Received: by 2002:a17:907:3d02:b0:ae0:b46b:decd with SMTP id a640c23a62f3a-ae9c9ac13b7mr684620766b.31.1752744001963;
        Thu, 17 Jul 2025 02:20:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294d4fsm1309361266b.129.2025.07.17.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:20:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  lorenzo@kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <borkmann@iogearbox.net>,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  sdf@fomichev.me,  kernel-team@cloudflare.com,
  arthur@arthurfabre.com
Subject: Re: [PATCH bpf-next V2 1/7] net: xdp: Add xdp_rx_meta structure
In-Reply-To: <175146829944.1421237.13943404585579626611.stgit@firesoul>
	(Jesper Dangaard Brouer's message of "Wed, 02 Jul 2025 16:58:19
	+0200")
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<175146829944.1421237.13943404585579626611.stgit@firesoul>
Date: Thu, 17 Jul 2025 11:19:59 +0200
Message-ID: <87v7nrdvi8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 02, 2025 at 04:58 PM +02, Jesper Dangaard Brouer wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Introduce the `xdp_rx_meta` structure to serve as a container for XDP RX
> hardware hints within XDP packet buffers. Initially, this structure will
> accommodate `rx_hash` and `rx_vlan` metadata. (The `rx_timestamp` hint will
> get stored in `skb_shared_info`).
>
> A key design aspect is making this metadata accessible both during BPF
> program execution (via `struct xdp_buff`) and later if an `struct
> xdp_frame` is materialized (e.g., for XDP_REDIRECT).
> To achieve this:
>   - The `struct xdp_frame` embeds an `xdp_rx_meta` field directly for
>     storage.
>   - The `struct xdp_buff` includes an `xdp_rx_meta` pointer. This pointer
>     is initialized (in `xdp_prepare_buff`) to point to the memory location
>     within the packet buffer's headroom where the `xdp_frame`'s embedded
>     `rx_meta` field would reside.
>
> This setup allows BPF kfuncs, operating on `xdp_buff`, to populate the
> metadata in the precise location where it will be found if an `xdp_frame`
> is subsequently created.
>
> The availability of this metadata storage area within the buffer is
> indicated by the `XDP_FLAGS_META_AREA` flag in `xdp_buff->flags` (and
> propagated to `xdp_frame->flags`). This flag is only set if sufficient
> headroom (at least `XDP_MIN_HEADROOM`, currently 192 bytes) is present.
> Specific hints like `XDP_FLAGS_META_RX_HASH` and `XDP_FLAGS_META_RX_VLAN`
> will then denote which types of metadata have been populated into the
> `xdp_rx_meta` structure.
>
> This patch is a step for enabling the preservation and use of XDP RX
> hints across operations like XDP_REDIRECT.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/xdp.h       |   57 +++++++++++++++++++++++++++++++++++------------
>  net/core/xdp.c          |    1 +
>  net/xdp/xsk_buff_pool.c |    4 ++-
>  3 files changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index b40f1f96cb11..f52742a25212 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -71,11 +71,31 @@ struct xdp_txq_info {
>  	struct net_device *dev;
>  };
>  
> +struct xdp_rx_meta {
> +	struct xdp_rx_meta_hash {
> +		u32 val;
> +		u32 type; /* enum xdp_rss_hash_type */
> +	} hash;
> +	struct xdp_rx_meta_vlan {
> +		__be16 proto;
> +		u16 tci;
> +	} vlan;
> +};
> +
> +/* Storage area for HW RX metadata only available with reasonable headroom
> + * available. Less than XDP_PACKET_HEADROOM due to Intel drivers.
> + */
> +#define XDP_MIN_HEADROOM	192
> +
>  enum xdp_buff_flags {
>  	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
>  	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
>  						   * pressure
>  						   */
> +	XDP_FLAGS_META_AREA		= BIT(2), /* storage area available */

Idea: Perhaps this could be called *HW*_META_AREA to differentiate from
the existing custom metadata area:

https://docs.kernel.org/networking/xdp-rx-metadata.html#af-xdp

> +	XDP_FLAGS_META_RX_HASH		= BIT(3), /* hw rx hash */
> +	XDP_FLAGS_META_RX_VLAN		= BIT(4), /* hw rx vlan */
> +	XDP_FLAGS_META_RX_TS		= BIT(5), /* hw rx timestamp */
>  };
>  

[...]

