Return-Path: <bpf+bounces-61635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBFBAE940C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 04:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216C11C236DB
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617341EBA14;
	Thu, 26 Jun 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLG1K6g+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B7224F6
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905259; cv=none; b=ZFzXGLVblaB04iBciCe5aL4HHyeZ3bOis7TmtqNB+aL6E9Ev3uk7Q8+EY8DsBCMzMGpCq+EdPictPh2372qZN8t0V1zgZGur5rwfYwNidZ6IO5uKAz0GG08/tNBog/y733La9BtRAi6Slcj3ZBthklmpQNVybOr0Ln7o1DmmJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905259; c=relaxed/simple;
	bh=Ywnfk5CtunwDSKI5ePQke6zvKrlORy5MiO0skNTlXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laiu0Z0eW/1xTVIn3WTX1dmRHen+mvdVP2aKgLRs5M/GgoN/aEbr9hUDl5I92ukbbz7YAWF1ekLUATBVr2K2mA2arIhgkt8CIa3QSzbrCFD7ckJ9kKwj7hPHxvuHX+glb+JSsk4pDt2byPFBndVXp1tV5/zaLMeLDcsez1ymi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLG1K6g+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
	b=JLG1K6g+r2O3+iQYnyichwjSTXIAks7C8XSwkFUNBGQqNDurzHucsJ8cvTX6BHn4MkFblS
	WAmompLUz2b8jQFODZFRR2yFGJF88J+FRxQ5facSpZfUoyT6LsWyMVed5ozod9Q2UWc4/o
	vOYF5pfYiQdZQYRfYX+Fqhi2AbcTSfM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Sinp8lG8O2W8WbTJF0WMVA-1; Wed, 25 Jun 2025 22:34:15 -0400
X-MC-Unique: Sinp8lG8O2W8WbTJF0WMVA-1
X-Mimecast-MFC-AGG-ID: Sinp8lG8O2W8WbTJF0WMVA_1750905255
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso613659a91.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905255; x=1751510055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
        b=epRYdwrDFFu2DNkNiZtaYGu7Rm5NEiZTFmK3EiZpURSpPEiI8KhWJOtl7+MtjmUw5f
         Gffo2Dn0It3/OeTsnuJeZ0kYyAIJ+aX8X+wTMfaSeL+G2mLhUKdHGgRkVFJkdpPapxLu
         xkRRAlM9WGdehSsoScG5K5g+HB46+H0qoF/nauksWl0dwzSmDvoFFBoob6YXLQBVIFi2
         ussdjf8jY7w6iEoFcxDbkmg5V0e0mfI91zk3tdJ75waqnq7AC8YlpSL10GdluD0jeZLW
         xhPtFnCjYyGxEMe6TuqOlxc326HIgw6sUttIYd/zl2uvZTO997TuT505FMcDNzt0w670
         lP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWtIO/4kRuaR0fWBlA80/Sr/535FbUjxv4Te5o5lkitTA5A9sRXH4mEL29UDvLb4MbMaXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4XhftQG9LHoQJJjTKc67J8y4r1fmA91h3zt2iXPGK1dY0DbK
	r7H0H8DQHwyY5+G03d1Syz5blVmfRMtzeTDBea6B9xXHWn2JKBbfznVfHExXz9gWopmWmFugmhx
	BRVaqefwaPicqXGjirEdYa1RHY8xcH8Zd4o9jA3+8Uwq5rTNWZnAwUb2dSRISNdmtGOcV/Yg4pr
	bXijuFz4m/XY85o629H87r43RFYZAt
X-Gm-Gg: ASbGncvt50xrPYa3rAXyK5BNwD1ZQTBRC3EgcYuD6J7N+64Kkuq1/kxsjSw0ffXDyqV
	sCbOA/ykYBobq552p4KhCxc9qpVXC2sUIRRsDzkM5vrZbSWa2qybWJB0A+Yv7mQ52BZWuhJ4dI2
	Uj3dTS
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-315f26192efmr8661952a91.15.1750905254640;
        Wed, 25 Jun 2025 19:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmWZ20ylBufEuyD8a4snrfN5wLqjOc1AW3vCQs60y21v0vOw3rVlavg03klPFzZsn8v3UuQzPZyDKXt277yE0=
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-315f26192efmr8661917a91.15.1750905254221; Wed, 25 Jun 2025
 19:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-2-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:34:02 +0800
X-Gm-Features: Ac12FXyruohJ57b6kb7ijE0xoMHh_6UYned9b5xz_RKi13myHBKADRrN7NPxO3A
Message-ID: <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")

I think we should cc stable.

> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..2a130a3e50ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct vir=
tnet_info *vi)
>   * across multiple buffers (num_buf > 1), and we make sure buffers
>   * have enough headroom.
>   */
> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> +static struct page *xdp_linearize_page(struct net_device *dev,
> +                                      struct receive_queue *rq,
>                                        int *num_buf,
>                                        struct page *p,
>                                        int offset,
> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct rec=
eive_queue *rq,
>         page_off +=3D *len;
>
>         while (--*num_buf) {
> -               unsigned int buflen;
> +               unsigned int headroom, tailroom, room;
> +               unsigned int truesize, buflen;
>                 void *buf;
> +               void *ctx;
>                 int off;
>
> -               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> +               buf =3D virtnet_rq_get_buf(rq, &buflen, &ctx);
>                 if (unlikely(!buf))
>                         goto err_buf;
>
>                 p =3D virt_to_head_page(buf);
>                 off =3D buf - page_address(p);
>
> +               truesize =3D mergeable_ctx_to_truesize(ctx);

This won't work for receive_small_xdp().

> +               headroom =3D mergeable_ctx_to_headroom(ctx);
> +               tailroom =3D headroom ? sizeof(struct skb_shared_info) : =
0;
> +               room =3D SKB_DATA_ALIGN(headroom + tailroom);
> +
> +               if (unlikely(buflen > truesize - room)) {
> +                       put_page(p);
> +                       pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
> +                                dev->name, buflen,
> +                                (unsigned long)(truesize - room));
> +                       DEV_STATS_INC(dev, rx_length_errors);
> +                       goto err_buf;
> +               }

I wonder if this issue only affect XDP should we check other places?

> +
>                 /* guard against a misconfigured or uncooperative backend=
 that
>                  * is sending packet larger than the MTU.
>                  */
> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                 headroom =3D vi->hdr_len + header_offset;
>                 buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -               xdp_page =3D xdp_linearize_page(rq, &num_buf, page,
> +               xdp_page =3D xdp_linearize_page(dev, rq, &num_buf, page,
>                                               offset, header_offset,
>                                               &tlen);
>                 if (!xdp_page)
> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>          */
>         if (!xdp_prog->aux->xdp_has_frags) {
>                 /* linearize data for XDP */
> -               xdp_page =3D xdp_linearize_page(rq, num_buf,
> +               xdp_page =3D xdp_linearize_page(vi->dev, rq, num_buf,
>                                               *page, offset,
>                                               XDP_PACKET_HEADROOM,
>                                               len);
> --
> 2.43.0
>


