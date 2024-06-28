Return-Path: <bpf+bounces-33320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74791B502
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 04:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272FEB21CD5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28884182DB;
	Fri, 28 Jun 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOU867ca"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448D17C64
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541194; cv=none; b=dk8mNaOaLzjho3kPEA4/zHm+3jqgrDnBWBwjFpGYZay92O4ZycbWbXT616kXktWnvTPORbj6hqazbUOrAqvecj6MUq8zk/SVc/GZuj5WxNdQMoqf82btKzjkVAvnGJLvzxLFZeieohZv5KW/F7s4w3F4hmoxHFwIfVvvqZzKP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541194; c=relaxed/simple;
	bh=fS9/cFuMgM0lZ8ejH+LXiAGmaBNxW0h/VZBmYDdLhe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oucmsBAmVxH4zVUlmu+SG8LNOdjpsoBpkwqG0SP+21mUgt95UZ3YmjRWVqYJ2uzcsrIWu3murvS2qlm0xKYf1jRWcvSVAxaUAxNxAIqnN625OHIeIonG2K/42j4xVG1cCJPG3I/yeuIXe3U08e3+zKw1P2RXiWUPjGlRY/FN2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOU867ca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFtsipCPOP/jakTRLVMoqNYxm8v6uKh7kTQGbc/1cIY=;
	b=bOU867calIPhBoF5pXpVD8TJBlMGkR6xINCyidLVIRzBWiVdnHrcXiugh6PBymoN06//3w
	hpdm0FB7Axa3sVopcs2cJFKQ2V8CG69EOhNMSxiL3vwR+oNZnT91RaV5vFxM8hp8amc0Jr
	6LrYb6tMVzVs9ZWXWknf+vYudxoeZuM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Ta19ATTINjuPVjXtZoGL_w-1; Thu, 27 Jun 2024 22:19:48 -0400
X-MC-Unique: Ta19ATTINjuPVjXtZoGL_w-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f9d1ec47f9so185237a34.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 19:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541186; x=1720145986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFtsipCPOP/jakTRLVMoqNYxm8v6uKh7kTQGbc/1cIY=;
        b=vEw5uKRaMsU6xHcawfI4ZkWEQ39GQcBpzA3RdYtj//2lXlVUfAQ6q9euV84phZPByB
         CeYZJ4H77j2617WmWijz7mpfQCzoxORevn/QeS1eJdea8m/85Ga1JkAdkCSzdn4Sfc2p
         TrPvEXXOkJt/jWQ6DVfl0gtr+9F5RxDgOl4kW8hODKcs+meYlo5M32x7Ev4kCMPCpnfb
         icKYpKcalx65WBjrXmxCDZzlTYgq/muEZUJsvo762dNHRDFQ+0Uxu7SmrWt+h3sQC2/C
         NusQi6+NQTsonrVgSgAoaXjgGnH2pnk/I+vvXhm4IhBF+smjC8Q18adzzRHLeDgce/EW
         85ig==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+cJ5QWbMXLtDrQb7kHdXEZV6wcMZlGE5G/J1B1OjJLUgVc2an/eTojQzVVF58lDHHNREeH0ZfmD0GNtyXurirmuT
X-Gm-Message-State: AOJu0YzutfWox1B28dKa7ZcoWRQ/7OoGwHH4R/KCk/nMYmonx7MeBG9J
	JXBCnUijLBX3AjKCRDTrnQnGeHJdOE1s0bTpUfYfbvxe7mlEoKHqBhwqhHje/n+NQIQQuMDpgdq
	wwyQoVUNmedGpUv730+IqacAohaOSc6Scth3N/CAioZ+l2Ca1mWO3JUhIGUbaJgwgEThUbqdGbe
	lYmjwp/PiSal2KO8texBcqu29p
X-Received: by 2002:a9d:760b:0:b0:6f9:6161:56d6 with SMTP id 46e09a7af769-700b118801amr16478940a34.3.1719541186328;
        Thu, 27 Jun 2024 19:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0cy9whsZGzhAzpp3vFWkjbwHKyu4q8WjSFEbZ4m1R5IwigdKQPr7kxsvvcJH5teLIRbMAoIj3o3ESGwRVCsA=
X-Received: by 2002:a9d:760b:0:b0:6f9:6161:56d6 with SMTP id
 46e09a7af769-700b118801amr16478922a34.3.1719541185825; Thu, 27 Jun 2024
 19:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:34 +0800
Message-ID: <CACGkMEtPwA2EN3xEH_T67cOQAWyZfYESso8LzeFDocJKYoXmTw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/10] virtio_net: xsk: bind/unbind xsk for rx
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 133 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index df885cdbe658..d8cce143be26 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -25,6 +25,7 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
> +#include <net/xdp_sock_drv.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -348,6 +349,13 @@ struct receive_queue {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> +
> +       struct {
> +               struct xsk_buff_pool *pool;
> +
> +               /* xdp rxq used by xsk */
> +               struct xdp_rxq_info xdp_rxq;
> +       } xsk;

I don't see a special reason for having a container struct here.


>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -4970,6 +4978,129 @@ static int virtnet_restore_guest_offloads(struct =
virtnet_info *vi)
>         return virtnet_set_guest_offloads(vi, offloads);
>  }
>
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct rece=
ive_queue *rq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D rq - vi->rq;
> +
> +       if (pool) {
> +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qinde=
x, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0)
> +                       goto unreg;
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +       }
> +
> +       virtnet_rx_pause(vi, rq);
> +
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
> +
> +               pool =3D NULL;
> +       }
> +
> +       rq->xsk.pool =3D pool;
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       if (pool)
> +               return 0;
> +
> +unreg:
> +       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +                                  struct xsk_buff_pool *pool,
> +                                  u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct receive_queue *rq;
> +       struct device *dma_dev;
> +       struct send_queue *sq;
> +       int err;
> +
> +       /* In big_packets mode, xdp cannot work, so there is no need to
> +        * initialize xsk of rq.
> +        */
> +       if (vi->big_packets && !vi->mergeable_rx_bufs)
> +               return -ENOENT;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       /* For the xsk, the tx and rx should have the same device. The af=
-xdp
> +        * may use one buffer to receive from the rx and reuse this buffe=
r to
> +        * send by the tx. So the dma dev of sq and rq should be the same=
 one.
> +        *
> +        * But vq->dma_dev allows every vq has the respective dma dev. So=
 I
> +        * check the dma dev of vq and sq is the same dev.

Not a native speaker, but it might be better to say "xsk assumes ....
to be the same device". And it might be better to replace "should"
with "must".

Others look good.

Thanks


