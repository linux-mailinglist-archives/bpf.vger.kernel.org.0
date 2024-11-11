Return-Path: <bpf+bounces-44530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE179C42C6
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9AE286E6B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A531A9B37;
	Mon, 11 Nov 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQHwRzWj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D471A257C
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343198; cv=none; b=LHihi3CsDH7vs6dFL4wLxcyv0DwnrscpogJyHjzCwhumCuvprNz4t5lgcNwzH1lg7/pKcIjCQ2qz9fIsd0nEGAnk2rpkyp+VErwnqYyYHFgpr4dOf8ZXXXfCPBm8kAe45gNBwcYAA15TmcfiUutbevKj0VAGHj5wN/FECVXlv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343198; c=relaxed/simple;
	bh=o486AYVqM7xqcbFT+XOIbCGL5DWZlP8FUBorEWAX/zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIqO7YJ/JPjAoatL7+gfh7gRHbMOGIeRVs43XTegVHH1f8tK8tdjrFTw3VkXTnpekRQQfo7qqFeKqJEO0ISOjousbLJdg3oOiEhHaVKDK5r8SOlh1dU/orHH5XzewIV1SXbzAc6A5crmK8pJXwvORjp5XSNyS86or8qOmoysN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQHwRzWj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731343196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKgW3LE84SWafFn65FDrfQSl/9TIfSGFANwG6EcBo18=;
	b=QQHwRzWjYm04Y3zWdNULmeHHm0jj1IB4loaUlQXWKUvuAGUfSNULMrS6jy2iZEfeLSEZZv
	2KOdeBG9isTHyW1WW4v9UpYUU+LRbZW8Tkf6Vg6+cDFTrWOrjVVvIzQkgcBvigcAAYqPB4
	JPHJcBBKqXGRQyALhBZQA1UkPU0pxVU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-OvWMBMAKNz2AKDOia_so1Q-1; Mon, 11 Nov 2024 11:39:54 -0500
X-MC-Unique: OvWMBMAKNz2AKDOia_so1Q-1
X-Mimecast-MFC-AGG-ID: OvWMBMAKNz2AKDOia_so1Q
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so371051966b.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 08:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343193; x=1731947993;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKgW3LE84SWafFn65FDrfQSl/9TIfSGFANwG6EcBo18=;
        b=Hx3F8MLdxE5+nD42D/mMs8uKBno0cJyaMa+6/AyYiaZqQPo/mTrYJc7cFEcnaQ2HZJ
         8i8Jj4T0d9ZeX6Ji5OsviQT5dtBOxKHxZcd0Qp1S5oMwowqufUi6rdlTAhauNn1iNX5Y
         EtvfhAyeX5ZoTbY1a03CYuYCJ+9uzfPID5elL/fMTgnRtMtf6UWecI13qKsAEs/Bula6
         B+0W1WV5iEXolTeKprISHsS3mBoNUhwKOuem0EoDUzQQutmPQFUUWKsiy78NWXFYEqiC
         7ylLRZeoQQNUlUXxumyxmMdZ84y0iIDi1rVCCReZkYWtfoY+4zvQ+b+eUvM3sNC5Mik5
         AohA==
X-Forwarded-Encrypted: i=1; AJvYcCUatgFbZ1xezxh08Ry32w0xjBcwwpIWlqvbZjPI3ATxVQrmr4GH3llW9+RZH82eo6gFFxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaia91VT8cparojm9tn+dbjCc4eu07/kcMLuF61YFiauvjItEd
	EDABL4Apdo3VoivlP/Giai71RtZiETjBXmzdvKT7GPZBz7pasccHmOGIfxV8LX6n+cEL0ln8LRS
	/wp1gBMDZhaaLFOICYPeYPnNL9kcruGqOW0f3oS5SXiPYxUOpCw==
X-Received: by 2002:a17:906:ef08:b0:a99:e939:d69e with SMTP id a640c23a62f3a-a9ef0024349mr1298336466b.51.1731343193116;
        Mon, 11 Nov 2024 08:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3n8Roc+Mnu9kSawt8yE+qVV+ccGpVO4yEHKrFfI04/JcX8ndj08Z6F74oPMyb6gsKndsDZA==
X-Received: by 2002:a17:906:ef08:b0:a99:e939:d69e with SMTP id a640c23a62f3a-a9ef0024349mr1298333066b.51.1731343192716;
        Mon, 11 Nov 2024 08:39:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0ad2d9dsm610552266b.91.2024.11.11.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:39:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2D95E164CC6E; Mon, 11 Nov 2024 17:39:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/19] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241107161026.2903044-13-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241107161026.2903044-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Nov 2024 17:39:51 +0100
Message-ID: <875xot67xk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
> using napi_build_skb() and make use of the available xdp_rxq pointer to
> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
> be recycled, as every PP user's been switched to recycle skbs.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/xdp.h |  1 +
>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 4c19042adf80..b0a25b7060ff 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>  void xdp_warn(const char *msg, const char *func, const int line);
>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>  
> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					   struct sk_buff *skb,
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index b1b426a9b146..3a9a3c14b080 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>  
> +/**
> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
> + * @xdp: &xdp_buff to convert to an skb
> + *
> + * Perform common operations to create a new skb to pass up the stack from
> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
> + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
> + * Rx queue index, protocol and update frags info.
> + *
> + * Return: new &sk_buff on success, %NULL on error.
> + */
> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
> +{
> +	const struct xdp_rxq_info *rxq = xdp->rxq;
> +	const struct skb_shared_info *sinfo;
> +	struct sk_buff *skb;
> +	u32 nr_frags = 0;
> +	int metalen;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp))) {
> +		sinfo = xdp_get_shared_info_from_buff(xdp);
> +		nr_frags = sinfo->nr_frags;
> +	}

Why this separate branch at the start of the function? nr_frags is no
used until the other branch below, so why not just make that branch on
xdp_buff_has_frags() and keep everything frags-related together in one
block?

-Toke


