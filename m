Return-Path: <bpf+bounces-12798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823797D08DE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334AC2823E4
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68316CA6A;
	Fri, 20 Oct 2023 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDT+MNOb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD5CA46
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:54:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B840D5A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
	b=eDT+MNObxNsY+KxwuI1rAxALs7IT23vxsa6+Qk+4+znD8oEVKjSHkbVujMenLgfypgyAKE
	oGHHTAhjVX3eZ8ZjcrNAHPkkN6/iKH1cgS/H0vbpieNtO81XApFwHn1CbW1rJ2pqAFI3FA
	ZDEygjDXIlM+R3DNSdpWB/IHeMMUGis=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-5gPDimMqPEyIHzYZy90-MQ-1; Fri, 20 Oct 2023 02:54:11 -0400
X-MC-Unique: 5gPDimMqPEyIHzYZy90-MQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079c865541so431327e87.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784849; x=1698389649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
        b=N+iEOeVHIXp+9EDAXq/Q/cx43E94CNoD+F2++4Ukiy7czDr9Z90ei9sbV5Uhs9kHuv
         1wg6iX/64/TS+dC4gwT/WegNGMxzlOxwBB8pbmlakR2DOcQRrMLOVbU+Rdkgv6S3pViA
         EzF3V1QT+Vzx1r4Av8l/F6X6b307hO54QYYcDWlGOXlqIkLyR9zk5/XR0uQuFsUEKK8C
         IKxGpexC+JnhIHgS8hoVQh8UbPzwPExrS3+ibx9EfRL9yAIioCLSJCv8KaHuyGqZS5vg
         X4eQZA8LzeGN6VWRkW2/m7BBwQGGxSHNhFlAYp2W+Y49z4agWGuPC3KH3/O1YHU+TWxV
         K+GA==
X-Gm-Message-State: AOJu0YxLqd6gUakOWKcIJgvY+vp6wR8oPK/sf78N6+jbXqOZDJhmr3Fn
	lS76ylDAW8E7Xwt43oT+XE1p1GQGmILT+W5U5aGNrk7CLvMcBpI3Jr1qfrgh5lfiqj3EceieaC2
	Y+y1H7SHe9cIm1VFDlSeRDLcF2Xm5
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id i19-20020ac25233000000b00506899d1994mr568149lfl.52.1697784849617;
        Thu, 19 Oct 2023 23:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOn/oJyJJPOYLBOv/fMkCipSGgZNHIW13oOFcOt53IHv46J5tRmnf3LsN5yPokvReRkUsdi5w2tb1PpviVoOo=
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id
 i19-20020ac25233000000b00506899d1994mr568135lfl.52.1697784849320; Thu, 19 Oct
 2023 23:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:53:58 +0800
Message-ID: <CACGkMEvHRcjeomqqxpPQc1wjw64qcthNT=AbDoUJUkMWwgyDag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 14/19] virtio_net: xsk: tx:
 virtnet_sq_free_unused_buf() check xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtnet_sq_free_unused_buf() check xsk buffer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 1a222221352e..58bb38f9b453 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -3876,10 +3876,12 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!virtnet_is_xdp_frame(buf))
> +       if (virtnet_is_skb_ptr(buf))
>                 dev_kfree_skb(buf);
> -       else
> +       else if (virtnet_is_xdp_frame(buf))
>                 xdp_return_frame(virtnet_ptr_to_xdp(buf));
> +
> +       /* xsk buffer do not need handle. */
>  }
>
>  void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> --
> 2.32.0.3.g01195cf9f
>


