Return-Path: <bpf+bounces-61638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36897AE9469
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 04:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF803AF4D0
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68D1F5828;
	Thu, 26 Jun 2025 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz2Jt7+m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D012CDBE
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906279; cv=none; b=KWG4RbwnMaSwPGd1ArM9TkZYcQILg0+0Rg5Y7KqwLjuR/tQusUgWRZrf9pw7OIsl8V1XH0or61ITMD/tHWlxbTlvGUlTjEmBeASjaEo2UKP9m5rY5OG88VvUXxXmnCHiQgSgHPQ7x2zy2X2pLvx+i9ZTH8b5uP8aNiboS1Ffp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906279; c=relaxed/simple;
	bh=AbbTcY3G90uhbAvwfnDrpva8mh1yG4yY6IHShSbbWSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl3YYboEqmaR11Etg2G6X+dMbcd7kOu5pUyu08d7WIRFw9JFpHBZztqDDkcYRL00yJDkOza42pTVkhxZ1Z3iRm4tK1WefSY9NwEoapuKu9bTDm51FlodKCqhpu8TqLLBysWprQWI4EDXj4MF9QxeT/mFXfMYisPkfBFPOXdsS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz2Jt7+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750906275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
	b=Nz2Jt7+mvTxq/JhC/S16hrHNP7hlx8NIoI09U7qJcqHpL+V3oMq+cF4ImMrRE5F5/6Gxx8
	N+0wjE7CLpVmerosqcD6KJOtIza/d3kLrA6mY/XBN/uP2DdWt5F8OovjYHve7Iq9FG3mU6
	XYb5b0UEA2jNMQcIEJemSpt/rVa00Yo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-lxZZmHh3PDm-21cj0u9ctg-1; Wed, 25 Jun 2025 22:51:14 -0400
X-MC-Unique: lxZZmHh3PDm-21cj0u9ctg-1
X-Mimecast-MFC-AGG-ID: lxZZmHh3PDm-21cj0u9ctg_1750906273
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3122368d82bso873411a91.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750906273; x=1751511073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
        b=P2hNu8xWig1zGpdIQ9Wh7LZmgtK6ynYUtwYhUlK5C8ad/3XznCv0t7Jm+aGWbGccnA
         Ncy436sfSQuIeCh2ZzNJ7ZgyZG3LL6JRgBDBjdV0mZJkcGH4fN501UKsSZfjuPB1P7YF
         QBu7vdfioEodJwLcT/p9fUjIwIdFO4QhkWS8X2IF3CTTb8fLCxhnccskL1/aBpC3cKzf
         hilMbGrFaKpLTmtNOelXMogEmDqHK0A/Aq8ae4qqKkTQlyI1PPQ1TknxWcSs2+uwXJ3b
         Sk/WRd+pgcNSvQXynTOJrP4Ul2V96uVhI2hr6h3A1qkjzCzur9nBCf8Z9eHwShuq6NsY
         kJqA==
X-Forwarded-Encrypted: i=1; AJvYcCUNis3UmahhdjonYXYW7dd+NAKTMxSI94mEA8kGix78DucAx/4lrk4N0HaFuHsDFrvu6XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlnpd91XcOwb3BFBhVP+qKC0LRLWSgnejPEsB8dPLPZO4St3J2
	02URqBAHmw0Hh65PX6KCMOi7nlp0RztoxWqQ4qEYml6JqaPLGHXyqctuliB7bOCfYKHvvh0+4hk
	8wNTQ7Gq/cMQMyi91TTCcUrOSKKw9iTGvShHEie+RabmhQphxP6uizoo2o1iocfOF23GVlFvcv+
	gxI8GZBfAMAqS/z4bv8aZe+DEeA2mw
X-Gm-Gg: ASbGncvHGxSdqxZmVlIWomRVyz3LaHZMQwoBpZf/20MW1C/6IZGdsmXXPI7CKmOApC/
	w2Yb4vXlP3dMwGuOVMvmKkClzYgMSC3oDn1C09KksKVANKE/4xKO2bD0iONpF1VwCgBQpfP61Jp
	7VAMgh
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-315f26b3e52mr7507605a91.35.1750906273389;
        Wed, 25 Jun 2025 19:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1oEFNW+pNyBHKxl5UFz4XuW+PyQ5F7+ZNjbo3jFzhfPpd3FRUMNsXAMnW3CCIEXyQmt+3K6tjBWZQ09ordg=
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-315f26b3e52mr7507572a91.35.1750906273025; Wed, 25 Jun 2025
 19:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-5-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-5-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:51:01 +0800
X-Gm-Features: Ac12FXxCVxp6548gkQ8YE-vjFv3IjVZGUSKTIBIUxHnJq7DtVbLHmVNL-WVcg1k
Message-ID: <CACGkMEv-EgkZs6d4MHwxj0t_-pQvxMRLTdgguP7GUijbg-kEoA@mail.gmail.com>
Subject: Re: [PATCH net 4/4] virtio-net: allow more allocated space for
 mergeable XDP
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
> When the mergeable receive buffer is prefilled before XDP is set, it
> does not reserve the space for XDP_PACKET_HEADROOM and skb_shared_info.
> So when XDP is set and this buffer is used to receive frame, we need to
> create a new buffer with reserved headroom, tailroom and copy the frame
> data over. Currently, the new buffer's size is restricted to PAGE_SIZE
> only. If the frame data's length + headroom + tailroom exceeds
> PAGE_SIZE, the frame is dropped.
>
> However, it seems like there is no restriction on the total size in XDP.
> So we can just increase the size of new buffer to 2 * PAGE_SIZE in that
> case and continue to process the frame.
>
> In my opinion, the current drop behavior is fine and expected so this
> commit is just an improvement not a bug fix.

Then this should go for net-next.

>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 844cb2a78be0..663cec686045 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2277,13 +2277,26 @@ static void *mergeable_xdp_get_buf(struct virtnet=
_info *vi,
>                                               len);
>                 if (!xdp_page)
>                         return NULL;
> +
> +               *frame_sz =3D PAGE_SIZE;
>         } else {
> +               unsigned int total_len;
> +
>                 xdp_room =3D SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
>                                           sizeof(struct skb_shared_info))=
;
> -               if (*len + xdp_room > PAGE_SIZE)
> +               total_len =3D *len + xdp_room;
> +
> +               /* This must never happen because len cannot exceed PAGE_=
SIZE */
> +               if (unlikely(total_len > 2 * PAGE_SIZE))
>                         return NULL;
>
> -               xdp_page =3D alloc_page(GFP_ATOMIC);
> +               if (total_len > PAGE_SIZE) {
> +                       xdp_page =3D alloc_pages(GFP_ATOMIC, 1);

I'm not sure it's worth optimizing the corner case here that may bring
burdens for maintenance.

And a good optimization here is to reduce the logic duplication by
reusing xdp_linearize_page().


> +                       *frame_sz =3D 2 * PAGE_SIZE;
> +               } else {
> +                       xdp_page =3D alloc_page(GFP_ATOMIC);
> +                       *frame_sz =3D PAGE_SIZE;
> +               }
>                 if (!xdp_page)
>                         return NULL;
>
> @@ -2291,8 +2304,6 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>                        page_address(*page) + offset, *len);
>         }
>
> -       *frame_sz =3D PAGE_SIZE;
> -
>         put_page(*page);
>
>         *page =3D xdp_page;
> --

Thanks

> 2.43.0
>


