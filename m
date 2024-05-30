Return-Path: <bpf+bounces-30888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B18D43B4
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 04:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F1C2834FC
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52761CD3B;
	Thu, 30 May 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4x9UyXL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043F1C693
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717036005; cv=none; b=gk3RcVlYn4UPbCM3zFb6sH6fSgIPH+GnsobC5b4cERejPGV66obZIJzYPTwn815+efSz7kgMECKqZQLs547u01BkjdvmokAdAHLKiBMFrKifg0fue7zOFZzlMoCCuepubzanWQh88gFqFSFP6S8XJmhRZHHB0IjCT2DvpJZHb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717036005; c=relaxed/simple;
	bh=ttvT3Ah8wGJXvc1wF+zv6cWjUvrcFWayTzZSGPdzpVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPIomS1ff1z6gSIzt5d9WDwMw44Culo//ZZUishsZfenStjiMKKOOzwJAW7HewQ5BeurfHrmL6PS4o21PJa2CqqJcKuX3b+sQXX3Tk5sRXgFGuFB3yxAFgG988QEZk6yKdZn2q1a+Ek5XHO5CY71UnHhknyy6foq7eHAOT825NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4x9UyXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717036002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnXsZTwwCzxzslifQa2+0cYHA7NTq6cDJZpAlg9suAg=;
	b=C4x9UyXLWCeMWJNFgi58E+6kIlI1Ce9HrRuxJwMW6cobmWR6SXNBFdsOPmdMwKiL3JTxxz
	YFpxJRwDytr4asl4p1kqfOYd8z2z5bys2+ltpisBwJl7Yc/btVI48A72CI1VQIzzzrd4fJ
	wR8jDpFoQRNeywdgJhayqXxQKbzGPDQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-gfZmEbEpOuOaK_h62h8mJA-1; Wed, 29 May 2024 22:26:41 -0400
X-MC-Unique: gfZmEbEpOuOaK_h62h8mJA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bdeed3b720so338298a91.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 19:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717036000; x=1717640800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnXsZTwwCzxzslifQa2+0cYHA7NTq6cDJZpAlg9suAg=;
        b=k7K2g68q5EpCKLXVnC0ivHN40SV5MpBvid12lQwmR/m5UUlyv/pwtLrQw1FeGbS1rk
         0yVlIvhVijYoleRax+Ix2a2GJLhdIha5X5ojIfrZTHikZtzyOYhe/z5n3w4A90UsmWBd
         CCNZFIZ6H9v+PQkSiVAYg0ZrIS8VwXWlLPPgVT/2TmT1OEtwczaNexslHpEfNxukrgag
         bGVUlAwWIwndEF2vZfVwI1M7yRlk41aDqDvjraSOn1SYucgBTNujUEz/tSkwJ0mz91Bz
         tfukCrhw/iEGrkoEvX8awsRO6yUuSePkBCS8TM7ZcOTWn9CjJ8N3wLEqIogiypCOFgir
         ezug==
X-Forwarded-Encrypted: i=1; AJvYcCUqNvgRVH3/u0ATV0MCUwEChrGaJXFNDBPPfuPfZhxXnlWmtlkfZyP23YRHirv9YrXz0pH9+VXA/vZB9IlzWzw9zraH
X-Gm-Message-State: AOJu0YyWALxrbvHcV1VP24E2tet6Y9FJ1mMAXsTJ7Z6frjzEMttXzG5w
	Yr5OSll6gdx2x0r1Pdzh9rkPtMSblrNy41lodV/6+38H00uTR/hiF6J1wRx0DfOJaDwYaY/PEpH
	XYZ121ob0nXOIF/Nw1SE6ibJcIUUUqkYCfNT5+lS1rVw+Q9VWN+OEen84XrbF08TTG5AzOwy+UT
	ASBJgEPdBrrUoqdYqi4kn4YHY5
X-Received: by 2002:a17:90a:f195:b0:2bd:d42a:f84e with SMTP id 98e67ed59e1d1-2c1abc06547mr875952a91.7.1717035999545;
        Wed, 29 May 2024 19:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8dBx7RLFwBbNLz/cVRtFvFW6wntNsZHbddxuYrQboeaA2JoWMYRdJDPzA+vve9b7jk9Fg1IkiIYjLozfohWs=
X-Received: by 2002:a17:90a:f195:b0:2bd:d42a:f84e with SMTP id
 98e67ed59e1d1-2c1abc06547mr875939a91.7.1717035999145; Wed, 29 May 2024
 19:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717026141-25716-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1717026141-25716-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 10:26:27 +0800
Message-ID: <CACGkMEugdcKjxMA_3+-gfh4wKOP5vTvYOb2V+MP7VxDiZ6EhiA@mail.gmail.com>
Subject: Re: [PATCH] net: tap: validate metadata and length for XDP buff
 before building up skb
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com, 
	boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 8:54=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> The cited commit missed to check against the validity of the length
> and various pointers on the XDP buff metadata in the tap_get_user_xdp()
> path, which could cause a corrupted skb to be sent downstack. For
> instance, tap_get_user() prohibits short frame which has the length
> less than Ethernet header size from being transmitted, while the
> skb_set_network_header() in tap_get_user_xdp() would set skb's
> network_header regardless of the actual XDP buff data size. This
> could either cause out-of-bound access beyond the actual length, or
> confuse the underlayer with incorrect or inconsistent header length
> in the skb metadata.
>
> Propose to drop any frame shorter than the Ethernet header size just
> like how tap_get_user() does. While at it, validate the pointers in
> XDP buff to avoid potential size overrun.
>
> Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()=
")
> Cc: jasowang@redhat.com
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/net/tap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index bfdd3875fe86..69596479536f 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1177,6 +1177,13 @@ static int tap_get_user_xdp(struct tap_queue *q, s=
truct xdp_buff *xdp)
>         struct sk_buff *skb;
>         int err, depth;
>
> +       if (unlikely(xdp->data < xdp->data_hard_start ||
> +                    xdp->data_end < xdp->data ||
> +                    xdp->data_end - xdp->data < ETH_HLEN)) {
> +               err =3D -EINVAL;
> +               goto err;
> +       }

For ETH_HLEN check, is it better to do it in vhost-net? It seems
tuntap suffers from this as well.

And for the check for other xdp fields, it deserves a BUG_ON() or at
least WARN_ON() as they are set by vhost-net.

Thanks

> +
>         if (q->flags & IFF_VNET_HDR)
>                 vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
>
> --
> 2.39.3
>


