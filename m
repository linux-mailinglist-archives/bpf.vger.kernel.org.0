Return-Path: <bpf+bounces-32582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36848910192
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79C21F233B4
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B491AB356;
	Thu, 20 Jun 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWUQBk38"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E01AAE34
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879873; cv=none; b=k/RlDjZ5o0HtN9AMKZscm2TfqeXMukVCRLmxiO37otaBZWTmaRGMeNR6hNJ738uSrSTY9irKvFguHOUNtQ1bUrLlxNX5l5QlgA64LFfMlH6vxtqVaTdHqTI3gaV68hiLpnQu6xlxN6kg8WGRoLxwdhbzQ55/9mCjsl1oz9Z4Jn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879873; c=relaxed/simple;
	bh=Oi99r8qR85Ks+LGR0TJS90SsYA0v1gfqYPPtTpmRZ00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMCWC0agy6EnGcj0MO6YEkBAVCns2zohxeXXjQJxgmoVVEdVeVm7Nhjvz0vd732mEAPXJtxWvXChJ3Jp/WASgepzpoA/4EjOyA/AH4NBDxHHlSSqKErzZJHX6qOrl7meM0eFHVAvIAbpg/IC2xXwVdR3xmG0yURQsKs/ZaALsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWUQBk38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718879870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nlu8QP/5OYOEpWVKRQdrBMDqgVkRN85GG8+YUNZ6oro=;
	b=BWUQBk38dYCqubg9oL6/USvcGs1Fu7pLxERFpxZ+W8uqb4gNdNoFkCNA9o6yr9npxFIMOS
	Ng0mzTvqSL0nIB/qW8FosCFv2zOcPZM/Hjsm/wPif6QtkhUoGEeY6gmA9rq3jdR/Uqguhn
	goqKo/i9rkeKXKuI+u66jy2jONW0UmM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-5Egk9ORUNKGRsxiwi7FqYg-1; Thu, 20 Jun 2024 06:37:47 -0400
X-MC-Unique: 5Egk9ORUNKGRsxiwi7FqYg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebda22101eso694431fa.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879866; x=1719484666;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlu8QP/5OYOEpWVKRQdrBMDqgVkRN85GG8+YUNZ6oro=;
        b=b+ejZoxcTi1cmzolux5g4mjOvLTCYHupz0F431N4lzUgqV+JXHSaxos3erAa/qQTsJ
         TS+KdvnFcO+52l/Qnm7pcn1KlqHDzKazs5ys6yEfwEupX5b9rEwjd47i1Dh8RzdjxouZ
         KfW1wHLLMLuB2uv37YieR8BfocPbjPySxZZdOTnF1qLNtfN7cqd0t8j4kI0VSFYeF40o
         xNzGr/d+udTDUJFo870cXyWk5PRs7V7rkUYXbpXyu/F679HVyxihr59UnJBNRYq3bdW6
         ipuQksx0tkLTZEqz3S340xg5xfm/8kU0gSlSJgC99o68quzPB3g7lvD+FmdQdPFpRmxI
         Spmw==
X-Forwarded-Encrypted: i=1; AJvYcCW6xEy85M5aG4wYP/T3TmB8skSKLTg1iZZoGtcAGDzJMnxASwGOENq+XCdNHCwlge6KOJxKZ7hORCKFXRwag3LaZQcP
X-Gm-Message-State: AOJu0YxCOCmreYcFmEYbmf07aduvn6hodOuepwtjK4pJDkdL+JFlVIlK
	dLW/KCuqrtswzL7tRyahh2/9okNIyNSsPclAYLNzjbdH/vp4I41cWN6I+yDzcymU8Q86pSEjsX5
	oMWRv1RulKr9vy5nkt1SkC1LsY/d+YAELfQrKHZa95VDdPWYYBQ==
X-Received: by 2002:a19:5f09:0:b0:52c:9a5a:e16c with SMTP id 2adb3069b0e04-52ccaaa4bf1mr2072561e87.4.1718879865943;
        Thu, 20 Jun 2024 03:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEezAI/KALrnbrWsMcw/at0dbYwbUbnkOwomPZGda/ZO2s0nWd/S14O3sQHMePN6PwK33TW0Q==
X-Received: by 2002:a19:5f09:0:b0:52c:9a5a:e16c with SMTP id 2adb3069b0e04-52ccaaa4bf1mr2072553e87.4.1718879865480;
        Thu, 20 Jun 2024 03:37:45 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b7:b110::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d1e2fc2sm20733025e9.34.2024.06.20.03.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:37:45 -0700 (PDT)
Message-ID: <b3fc84d24bce9ab2997a414cc84ae7e12ba87987.camel@redhat.com>
Subject: Re: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv
 merge mode
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Date: Thu, 20 Jun 2024 12:37:43 +0200
In-Reply-To: <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
	 <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> Support AF-XDP for merge mode.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 06608d696e2e..cfa106aa8039 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_=
prog, struct xdp_buff *xdp,
>  			       struct net_device *dev,
>  			       unsigned int *xdp_xmit,
>  			       struct virtnet_rq_stats *stats);
> +static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +					       struct sk_buff *curr_skb,
> +					       struct page *page, void *buf,
> +					       int len, int truesize);
> =20
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_small(=
struct net_device *dev, struct
>  	}
>  }
> =20
> +static void xsk_drop_follow_bufs(struct net_device *dev,
> +				 struct receive_queue *rq,
> +				 u32 num_buf,
> +				 struct virtnet_rq_stats *stats)
> +{
> +	struct xdp_buff *xdp;
> +	u32 len;
> +
> +	while (num_buf-- > 1) {

Why do you skip the last buffer? I thought it should be dropped, too?!?

Thanks!

Paolo


