Return-Path: <bpf+bounces-40239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C6983F2F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 09:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F31A1C218EF
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E5147C91;
	Tue, 24 Sep 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THYHvx0K"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A6146D6F
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163322; cv=none; b=PcmJssopC7Aa6RgZJogERu0c04yjqUvPCAIkPQKuEEo++03EpqJvMg3VCrvG9PHI9FjzRhtq/hWmNtyQB0xu12nJXtviXmFbmbu3qw6nO0TeIiLk4KvmTpyCb8CB8l7+dK5g7nFDR+nqAS5LOcyTbZcqPAFd4iy3z5Pawpja1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163322; c=relaxed/simple;
	bh=gd9TLfoZx2F+kEdm7NZ/WMO9UVX62rFrq7W3T+xr/gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7CvXVunaZ+UOmF/fpCFD4r5hdVM+9zELQkny8bJfPdOHt/kPEfBkAo8N7/iJzhFte9uXcXHbll5lrr19j/aOqc31aqLsKBrZj/LGCSIP2aWnepIq+HFePKKxdtcXhNUTYKrn/qSM75ww29/nx/WJC1fMpeRb+VsSASb1cY2rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THYHvx0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
	b=THYHvx0KevfmAqLhpoFUO6SityNuYmIsD2seQEuqne5zkLJbv+ZZEkVcRj/+yja4EWJTSr
	Ftsz5lCBXu0S/98GqMWBgO9/3ri5w+pLlXTYuBe6K4qyH2lCIpJUvqp12rcYcAnPBW5EoM
	HH3Pnulm3dryC8IqXfANMkpJ5EdKxew=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-yvWTo0YrPDmFk7RVp0WJJQ-1; Tue, 24 Sep 2024 03:35:17 -0400
X-MC-Unique: yvWTo0YrPDmFk7RVp0WJJQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7198667a879so5004573b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163316; x=1727768116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
        b=hYAvcIXN71yys32lKOamfhr5DW0jjQjHKGvkUzTfLdpmzT4OcsUsblZDyJhKOPXH/4
         rTvEdMQIFC7Ow5/w6Y+eMOCj7FyHTspE326F5dr2rABML5tvdJbLOwFRlUriSU3lwqGh
         t1xO8EIOGfKhyDzanWAR3UIM+ufKJehOD0Qbl++MBVNGyFndZdbXTJWN2Kj2YEJnz8vy
         eTAx+CQwDGoPWhZqV0XWD3FrT45QIdLeNe9LMlzUUZyP/rJpui1ekSbvRtM7vS8QORsY
         LXf3kPTr0IkLMNLj0AvLkm5cLFKXLpxcM1pUE/TwCROlnKndoiflIhPyEZNXQcirCj87
         h+kg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ictWbd0y7QXU68zNHwD6aVR6P8Gv/6G+kgQuV2NiUKF/DnaAOar8lL7h0OXjiNmJfso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlxoujJe6rkqHavTz4M+QJN1UqDIbIymJFXukrIMjlI5abYug
	D3uQVJhp7a0ZcU+arIa6IZTaZ6C6DnIP0lZSxurY0V1JXoF0Jqe6WVr2uvIw+ade0vKyOldcjRw
	0hUC9bCZWPoz1mEWYOXQW7QRVQP0LEgQanUNivxJl5LbHBiBziKUURO0cxSOME3NW1Ov/IRxJqQ
	u3iMPocoLToGDTz0fE1D/9hHi4
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d30a9fb7b3mr19470591637.32.1727163315959;
        Tue, 24 Sep 2024 00:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx/soIIabkJ0QhCDlDO4PjZWR1FTyoTbioUpQfhFh0yWY1kmlQ/qO18q1LS4ki5NKSTFvtS8mDzJ3BNF/H4wk=
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id
 adf61e73a8af0-1d30a9fb7b3mr19470570637.32.1727163315542; Tue, 24 Sep 2024
 00:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:03 +0800
Message-ID: <CACGkMEtbNrwbxhRbjHGiEQeQbWUb2iL0ZtyosXs4_+GoZY-Gsw@mail.gmail.com>
Subject: Re: [RFC net-next v1 07/12] virtio_net: refactor the xmit type
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Because the af-xdp will introduce a new xmit type, so I refactor the
> xmit type mechanism first.
>
> In general, pointers are aligned to 4 or 8 bytes.

I think this needs some clarification, the alignment seems to depend
on the lowest common multiple between the alignments of all struct
members. So we know both xdp_frame and sk_buff are at least 4 bytes
aligned.

If we want to reuse the lowest bit of pointers in AF_XDP, the
alignment of the data structure should be at least 4 bytes.

> If it is aligned to 4
> bytes, then only two bits are free for a pointer. But there are 4 types
> here, so we can't use bits to distinguish them. And 2 bits is enough for
> 4 types:
>
>     00 for skb
>     01 for SKB_ORPHAN
>     10 for XDP
>     11 for af-xdp tx
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 630e5b21ad69..41a5ea9b788d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG                BIT(0)
> -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> -
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -512,34 +509,35 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>
> -static bool is_xdp_frame(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> -}
> +enum virtnet_xmit_type {
> +       VIRTNET_XMIT_TYPE_SKB,
> +       VIRTNET_XMIT_TYPE_SKB_ORPHAN,
> +       VIRTNET_XMIT_TYPE_XDP,
> +};
>
> -static void *xdp_to_ptr(struct xdp_frame *ptr)
> -{
> -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> -}
> +/* We use the last two bits of the pointer to distinguish the xmit type.=
 */
> +#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
>
> -static struct xdp_frame *ptr_to_xdp(void *ptr)
> +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)

Nit: not a native speaker but I think something like pack/unpack might
be better.

With those changes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


