Return-Path: <bpf+bounces-34041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C7929C53
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A46280F22
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B017545;
	Mon,  8 Jul 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnpZhXPr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46E125AC
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420628; cv=none; b=K5do0L5phfEMcanowbHgF2FOPUCIFkIkPSPlpotWdwUw3tFUTI1a6EDL+kcUOA6HDLo1K6QtDynY0AkqUtjYqaOISVrYaNGWW1/rrbDLN/ihffz9TeOmzie2E4QzSMacMtYtDPG1AM8+15PZLsma6uVjUiC80tR3WugIujnUmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420628; c=relaxed/simple;
	bh=pVx1F0zlWrx9DLmbJp6pr9g/PqB7QQJH0tCPKUZ6gIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsztlreHQgFiU8sObrMEvEVE0tY8Hzv6BWivsux/x6P3rhGsbq/cB5jqKdaN62jhMSjV4rFtzSfm0cOX/nGtCXN+U6scAP7NEtg5nK+P0IiuKHRqtLzo4DzFl4rp6xbJ6S6L8rKDnTQ9vg/JRMYQTpLY2f8FjwPEadlLY+OERfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnpZhXPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720420626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=td2LS94WMnQRQc26m/n7PwwhPL7oKCXn1M0Y41ufmns=;
	b=QnpZhXPrvjQgJirjC2dS1vQUQJFIB25sqIDFO5T7CQvYacqrcp7mTUUUaMPgRu4xL9B+bP
	yTKjK/+Uhxj18nonIwOIuCyyGK8Rm1r9e/DQK0A0deql+vGLtSM+Oaan5/G9PBTVWB3Dbb
	kolw5bre8kMwmTRUTomGJSGG/L8Qp9I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-iqPB180FMKu8M67HSkxFRA-1; Mon, 08 Jul 2024 02:37:04 -0400
X-MC-Unique: iqPB180FMKu8M67HSkxFRA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fb294a0915so32132635ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Jul 2024 23:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420624; x=1721025424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td2LS94WMnQRQc26m/n7PwwhPL7oKCXn1M0Y41ufmns=;
        b=n0UFZSzIeT+ArdkOABtl4RU354mY7ggZwBjBlrJVIfudi3HZ+boQKm+7+AtOjR+dU7
         idMdHfENO8GkQmdwfvFhfsrzYoPnwZmngh6Th+TC7m9xi44QSdebeixhjWk7viWR/hYn
         8V4AsXB/9ATxcfYcQ7rnDKjb8t0kIZyAl2LfM/YzeCtwwvnZsLPoiuidZ3ArEanJ74jS
         bf94ZG2NjasPPSMd6NCLJ2R6+dmHVxl4I+aZ4S7rdRYhRjoZhY5sFtZ4XgoxdAVDkP9P
         ECNLaI7PUeDnWTKheqJpn9ZOkX4qCUtBbOq5CvJYIXPxa9PDpdTexw3WZfALR7ENKx8p
         LkFw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZM3j2f2W4Q9aamq0Msv/Im1LxED2CzB7foZKX4O3w3sBgDrXDuogqDKXx5aAN6fORh7IvHzCuqf29RehhhHL678X
X-Gm-Message-State: AOJu0YyzYFFMtPhiugGUQ1M9jIekVypT3B+sCUFqfqIpjXipjXzF+wbl
	ODTPmF5C1eqdj8qJSD1GCyofxndjqmuNxhHVXSWrcZGs0qY0TEc757z7HJTKBmkYuLgIkoEyuvd
	jTXIDwOE3Juj1UuOoSmkkPdhmY+TeUbgG9CjoUomSleryXoZRup1PRm8F9ItoJ+y8rHb0/QnASL
	r4l754yXmTF34A40zSRAQfgN6n
X-Received: by 2002:a17:902:c402:b0:1fb:15ff:8499 with SMTP id d9443c01a7336-1fb3700d240mr170145165ad.4.1720420623760;
        Sun, 07 Jul 2024 23:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgLDGLsNuvY7Y1CElM5YYLKX4FgQDMdRKPdIjjrlLfBf3G6j00b+bCV72mON6Sx9MTqtH82BSVcoCb3d6TO3Y=
X-Received: by 2002:a17:902:c402:b0:1fb:15ff:8499 with SMTP id
 d9443c01a7336-1fb3700d240mr170144945ad.4.1720420623343; Sun, 07 Jul 2024
 23:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:36:52 +0800
Message-ID: <CACGkMEscqKn6Wt76qZpWeiG=9Tj6LpzUq_0fqJb32AXEdiKMgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/10] virtio_net: xsk: bind/unbind xsk for rx
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>     1. remove a container struct for xsk
>     2. update comments
>     3. add check between hdr_len and xsk headroom
>
>  drivers/net/virtio_net.c | 134 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3c828cdd438b..cd87b39600d4 100644
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
> @@ -348,6 +349,11 @@ struct receive_queue {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> +
> +       struct xsk_buff_pool *xsk_pool;
> +
> +       /* xdp rxq used by xsk */
> +       struct xdp_rxq_info xsk_rxq_info;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -5026,6 +5032,132 @@ static int virtnet_restore_guest_offloads(struct =
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
> +               err =3D xdp_rxq_info_reg(&rq->xsk_rxq_info, vi->dev, qind=
ex, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk_rxq_info,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0)
> +                       goto unreg;
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk_rxq_info);
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
> +       rq->xsk_pool =3D pool;
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       if (pool)
> +               return 0;
> +
> +unreg:
> +       xdp_rxq_info_unreg(&rq->xsk_rxq_info);
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
> +       if (vi->hdr_len > xsk_pool_get_headroom(pool))
> +               return -EINVAL;
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
> +       /* xsk assumes that tx and rx must have the same dma device. The =
af-xdp
> +        * may use one buffer to receive from the rx and reuse this buffe=
r to
> +        * send by the tx. So the dma dev of sq and rq must be the same o=
ne.
> +        *
> +        * But vq->dma_dev allows every vq has the respective dma dev. So=
 I
> +        * check the dma dev of vq and sq is the same dev.
> +        */
> +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> +               return -EPERM;

I think -EINVAL is better.

> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +       if (!dma_dev)
> +               return -EPERM;

-EINVAL seems to be better.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

THanks


