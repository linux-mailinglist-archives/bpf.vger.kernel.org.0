Return-Path: <bpf+bounces-23038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A81D86C742
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415CB28AEBB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2A7AE42;
	Thu, 29 Feb 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z64QMlFX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70F7A734
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203731; cv=none; b=SbwVWRCGWM/D6M85w8iFSC2miC7ztb7B4PEGblRsj8kYmZOd17VlXPhxCf6dunAW4RfE//3CgOXY95ROWvNYBXZGPPxGAniICW0KSuKnjdm/opo+xCErCmhbZaeu7RKJfya/1wKN1tbpJ2vYt/QUjcSnfulzlAOw70TTC2UOv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203731; c=relaxed/simple;
	bh=XzS6fq+Giqw0RPzHm79wubDPq4isDpcarVDTGC+dOx0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kn5vJVlSTtqYkRBTP2FQqvHX0tnXNzpNRFUgHTvhIm8x+aGmtikm/dOp6jv/9bQ6HWGnvnrvCe8hdZi+7N7rFDuMYiKXdhvmJ0vJBQqxzSzCBMeL5fb7eNqOFg6FDMcd9/C8PbN+cH3+L9+ChhLBrkFH8F+ZA9iENTuoEEs9Tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z64QMlFX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709203729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kTQNgwDYWMu50d3fX4YnqzUpTcfqlF52qDT1Uxsy8p8=;
	b=Z64QMlFXQYLfYGMCmZ1uelNFEee9LfKRnEMg1W0lXn6RmsM1XN6wl4/lp7inDihwjoeO2J
	jVoDsW2hgMUlVX1IbR0eZPx6UGvKGn5a9XWsv9fOYJ1/l87NG6hmIOmxTDIZOE9NrD2naD
	7xBvPBWGbdFH2E8U13aph8U+RshMAGY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-hNNYWXQNNt6SsBw7UOspew-1; Thu, 29 Feb 2024 05:48:47 -0500
X-MC-Unique: hNNYWXQNNt6SsBw7UOspew-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5132987ccfaso52202e87.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203726; x=1709808526;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTQNgwDYWMu50d3fX4YnqzUpTcfqlF52qDT1Uxsy8p8=;
        b=ai5HP0UctreLxsvTz1tgb5GuHVAhYzs4zMd1fbbSP3S1Zw798yM0pbfKvgnA9S3f5+
         QHQiKDuGM8/S+yxvvOn7z/F5VgPHQp6M3/7Ne+LsfCeW/h14J5fyBHzB2XZVqhXV668B
         15t6WY3ItWE3PiP4EfbNnIUw5Ur9NRE+jBLvY0eAKXwJH0QiP9ZEAu7ZQm2U9UtB41CY
         eOWqLzm1SnibJ7gykVX5uDYUTnyFjZ6U0aQSMcka/Dryu8/awqSI8fKae2ceNnx7dHgb
         mSbEEmAk8q4tm1caSum8BZhK+U9ciRujaFMVkXDLucMu64Aqh88E9x/oYMr3yKjuaJvt
         Rxpg==
X-Gm-Message-State: AOJu0YwzpjdMnMtK5/EP20zSH6gziL7nQoziCU511Tay5AkVsqtt7EoP
	8NnpW/raFM2iGjGN+qnUUXZpZc+Sf3WxRg7Vqpv/qWWZ2LrPW4vuQkPW+wrTn2cs0NZh84jpvNe
	rgqGLEv+B2lwR+OTItADMKjH7F20DpM2dEvo5o8Sk5j0pCbv9Rw==
X-Received: by 2002:a05:6512:3b89:b0:511:9ea2:f589 with SMTP id g9-20020a0565123b8900b005119ea2f589mr1463625lfv.0.1709203726277;
        Thu, 29 Feb 2024 02:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS5gieFTKdIGG4SJuTQlGR8TPXmC/tE8BJ9sq2UItrPbXs/wsObrdj9Ky7fDTCqAnBObdqLg==
X-Received: by 2002:a05:6512:3b89:b0:511:9ea2:f589 with SMTP id g9-20020a0565123b8900b005119ea2f589mr1463595lfv.0.1709203725888;
        Thu, 29 Feb 2024 02:48:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm1159217wrb.115.2024.02.29.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:48:45 -0800 (PST)
Message-ID: <94bd28f625f7ca066e8f2b2686c2493cfab386bd.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] vhost_net: Call peek_len when using xdp
From: Paolo Abeni <pabeni@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kvm@vger.kernel.org,
 virtualization@lists.linux.dev, xudingke@huawei.com,  liwei395@huawei.com
Date: Thu, 29 Feb 2024 11:48:43 +0100
In-Reply-To: <1709118344-127812-1-git-send-email-wangyunjian@huawei.com>
References: <1709118344-127812-1-git-send-email-wangyunjian@huawei.com>
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

On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> If TUN supports AF_XDP TX zero-copy, the XDP program will enqueue
> packets to the XDP ring and wake up the vhost worker. This requires
> the vhost worker to call peek_len(), which can be used to consume
> XDP descriptors.
>=20
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/vhost/net.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..077e74421558 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -207,6 +207,11 @@ static int vhost_net_buf_peek_len(void *ptr)
>  	return __skb_array_len_with_tag(ptr);
>  }
> =20
> +static bool vhost_sock_xdp(struct socket *sock)
> +{
> +	return sock_flag(sock->sk, SOCK_XDP);
> +}
> +
>  static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
>  {
>  	struct vhost_net_buf *rxq =3D &nvq->rxq;
> @@ -214,6 +219,13 @@ static int vhost_net_buf_peek(struct vhost_net_virtq=
ueue *nvq)
>  	if (!vhost_net_buf_is_empty(rxq))
>  		goto out;
> =20
> +	if (ptr_ring_empty(nvq->rx_ring)) {
> +		struct socket *sock =3D vhost_vq_get_backend(&nvq->vq);
> +		/* Call peek_len to consume XSK descriptors, when using xdp */
> +		if (vhost_sock_xdp(sock) && sock->ops->peek_len)
> +			sock->ops->peek_len(sock);

This really looks like a socket API misuse. Why can't you use ptr-ring
primitives to consume XSK descriptors? peek_len could be constified
some day, this code will prevent such (good) thing.

Cheers,

Paolo


