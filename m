Return-Path: <bpf+bounces-32360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927090C0E8
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 03:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4608B1C20FE6
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA849D299;
	Tue, 18 Jun 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNF68g+g"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AE7484
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672661; cv=none; b=ZzIJ+mtr9bl/x7PJmQt4PwuYOh5ISHjKQfHBPAKhb4pk1AE2x4bG/YT5QGfevzJV4kGMcbnygo8Ki4157dLjYRy3yscAZfy08mVYDJfYG1wnc18etBpMXXl8Bz3uWDeEUZ/7eMsrocQC5qsPFMRbuRPQg2P6PUNUE3KFoe0irrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672661; c=relaxed/simple;
	bh=E1rGrs/QNXf4XbPROpGco58lXSpBUUdLnbooI3IML04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyq3B5KQo6O/jVVfqm61kO9RKMFBNLd0zKrLqZHq4xbM8tvJSqX7Os8eG9fmcpZFUzQqeFBTy4gtc6Ok2bvPTRmrq9vjhxnQhPUArTsjxY9z3Au3rjomTcPcHgcOofaK6TpMUKZthhSkMb/hNasDldKRC/SAAGERFytHjXqq1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNF68g+g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fogfteCXFA3OgE3/+IIVtRDP5+xYgH0Ae3ZLYaDpaKM=;
	b=iNF68g+gdOhjcjrkiN4pTQTmU2ja3Y8qvcxiWO6RWmDe4I7uN21OwihNslzig0XQsrfIoX
	yOUoS9JycU/Izx4UFQNPU56B9IX7iQlXFXrTDvG0BLfHQ6fAEbVgoFnRJ/KkFYrLgZsQkV
	C80P0v6m/PJLl1mVVriwwWVDW1I77Mo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-HC7Kmc48Nz-woR81ciPsow-1; Mon, 17 Jun 2024 21:04:16 -0400
X-MC-Unique: HC7Kmc48Nz-woR81ciPsow-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7041c30c0b4so4538491b3a.2
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 18:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672655; x=1719277455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fogfteCXFA3OgE3/+IIVtRDP5+xYgH0Ae3ZLYaDpaKM=;
        b=KWgJt2QTUI4PHVLKL0myZH7LVk4F+jIC4v2Q7oA0EXj4ZiEHKYLwQYvDvyrPbtDUYn
         pXUqS+lhuM5ExHsyC8YYWQh8MJ1MeYpE9DoKqKj2sYmKmysVLsZNHtAzrJyCRwaHx5ex
         9ydYflc8MvkxTtyK2xvCdzvAeo46HeGiPhqaHoSezdS170XeoygbCRYxLNiYqLW3dENb
         R6P4tP6R/sUpfxJUg8Y5btN1gmjfuznidrmzMDJHOw3pw5RiqpPMRN7UmjLg6mroJ3Zv
         vhgDy1c18lv1ceasZoun3LXoszStvLb2zPQh34Ee/c+7oMJwX+o7wCJ+WlDa9mwQhpQd
         Bixw==
X-Forwarded-Encrypted: i=1; AJvYcCWuJgDHqTCy3DfDNbyawhaFZUmyKj659HWGJ4Vlxgl5QQATgmn2/CkYmLyUUUykch9Ynap8tIYrbNWaR6m7y67W6cZW
X-Gm-Message-State: AOJu0YwNXAKzCLlrCLi6isKVQvgXnkPFZlyMGVDxFGS+kXko2g4LR8sz
	Qz3GoXCiOLuBNcVh8PVIGwcfH4vmXYmik8Tgu7WcAivTaeLTCvlvAVocDbRaWJaHr3CtRJpw3iJ
	YSEhkcR/Wls2Jqt2IHmFPgjnPmG9780g8okcmbhx6KZUBXRjhW1ceH1/clTkKTpXQns3PnN3xQl
	bY9dFaqrDbVNKrnYmMSw9B/Kjh
X-Received: by 2002:a05:6a21:6da8:b0:1b2:b5af:ce67 with SMTP id adf61e73a8af0-1bae82e3564mr11184677637.59.1718672655183;
        Mon, 17 Jun 2024 18:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy7r4Pl26FO/pVoHuFobnp8YuNRODGRxmd/rJHwT+X9hHIMGWg8rn1edutBN1DvMrogNhD9Lb2eftvwnCu93Q=
X-Received: by 2002:a05:6a21:6da8:b0:1b2:b5af:ce67 with SMTP id
 adf61e73a8af0-1bae82e3564mr11184653637.59.1718672654660; Mon, 17 Jun 2024
 18:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-10-xuanzhuo@linux.alibaba.com> <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
 <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:04:03 +0800
Message-ID: <CACGkMEvySjELA_4vU6yzR+sBAX75u9Rv-XmUUbNA8SaaPf-XXg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
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

On Mon, Jun 17, 2024 at 3:49=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 14:19:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 201 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 200 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 88ab9ea1646f..35fd8bca7fcf 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -26,6 +26,7 @@
> > >  #include <net/netdev_rx_queue.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <uapi/linux/virtio_ring.h>
> > > +#include <net/xdp_sock_drv.h>
> > >
> > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > >  module_param(napi_weight, int, 0444);
> > > @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
> > >
> > >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> > >
> > > +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> >
> > Does this mean AF_XDP only supports virtio_net_hdr_mrg_rxbuf but not ot=
hers?
>
> Sorry, this is the old code.
>
> Should be virtio_net_common_hdr.
>
> Here we should use the max size of the virtio-net header.

Better but still suboptimal, for example it could be extended as we're
adding more features?

>
> >
> > > +
> > >  static const unsigned long guest_offloads[] =3D {
> > >         VIRTIO_NET_F_GUEST_TSO4,
> > >         VIRTIO_NET_F_GUEST_TSO6,
> > > @@ -321,6 +324,12 @@ struct send_queue {
> > >         bool premapped;
> > >
> > >         struct virtnet_sq_dma_info dmainfo;
> > > +
> > > +       struct {
> > > +               struct xsk_buff_pool *pool;
> > > +
> > > +               dma_addr_t hdr_dma_address;
> > > +       } xsk;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -372,6 +381,13 @@ struct receive_queue {
> > >
> > >         /* Record the last dma info to free after new pages is alloca=
ted. */
> > >         struct virtnet_rq_dma *last_dma;
> > > +
> > > +       struct {
> > > +               struct xsk_buff_pool *pool;
> > > +
> > > +               /* xdp rxq used by xsk */
> > > +               struct xdp_rxq_info xdp_rxq;
> > > +       } xsk;
> > >  };
> > >
> > >  /* This structure can contain rss message with maximum settings for =
indirection table and keysize
> > > @@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct send_=
queue *sq)
> > >  /* This function must be called immediately after creating the vq, o=
r after vq
> > >   * reset, and before adding any buffers to it.
> > >   */
> > > -static __maybe_unused int virtnet_sq_set_premapped(struct send_queue=
 *sq, bool premapped)
> > > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool prem=
apped)
> > >  {
> > >         if (premapped) {
> > >                 int r;
> > > @@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(str=
uct virtnet_info *vi)
> > >         return virtnet_set_guest_offloads(vi, offloads);
> > >  }
> > >
> > > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct =
receive_queue *rq,
> > > +                                   struct xsk_buff_pool *pool)
> > > +{
> > > +       int err, qindex;
> > > +
> > > +       qindex =3D rq - vi->rq;
> > > +
> > > +       if (pool) {
> > > +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, q=
index, rq->napi.napi_id);
> > > +               if (err < 0)
> > > +                       return err;
> > > +
> > > +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > > +                                                MEM_TYPE_XSK_BUFF_PO=
OL, NULL);
> > > +               if (err < 0) {
> > > +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > +                       return err;
> > > +               }
> > > +
> > > +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > > +       }
> > > +
> > > +       virtnet_rx_pause(vi, rq);
> > > +
> > > +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > > +       if (err) {
> > > +               netdev_err(vi->dev, "reset rx fail: rx queue index: %=
d err: %d\n", qindex, err);
> > > +
> > > +               pool =3D NULL;
> > > +       }
> > > +
> > > +       if (!pool)
> > > +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> >
> > Let's use err label instead of duplicating xdp_rxq_info_unreg() here?
> >
> > > +
> > > +       rq->xsk.pool =3D pool;
> > > +
> > > +       virtnet_rx_resume(vi, rq);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > > +                                   struct send_queue *sq,
> > > +                                   struct xsk_buff_pool *pool)
> > > +{
> > > +       int err, qindex;
> > > +
> > > +       qindex =3D sq - vi->sq;
> > > +
> > > +       virtnet_tx_pause(vi, sq);
> > > +
> > > +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > > +       if (err)
> > > +               netdev_err(vi->dev, "reset tx fail: tx queue index: %=
d err: %d\n", qindex, err);
> > > +       else
> > > +               err =3D virtnet_sq_set_premapped(sq, !!pool);
> > > +
> > > +       if (err)
> > > +               pool =3D NULL;
> > > +
> > > +       sq->xsk.pool =3D pool;
> > > +
> > > +       virtnet_tx_resume(vi, sq);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > > +                                  struct xsk_buff_pool *pool,
> > > +                                  u16 qid)
> > > +{
> > > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > > +       struct receive_queue *rq;
> > > +       struct send_queue *sq;
> > > +       struct device *dma_dev;
> > > +       dma_addr_t hdr_dma;
> > > +       int err;
> > > +
> > > +       /* In big_packets mode, xdp cannot work, so there is no need =
to
> > > +        * initialize xsk of rq.
> > > +        *
> > > +        * Support for small mode firstly.
> >
> > This comment is kind of confusing, I think mergeable mode is also
> > supported. If it's true, we can simply remove it.
>
> For the commit num limit of the net-next, I have to remove some commits.
>
> So the mergeable mode is not supported by this patch set.
>
> I plan to support the merge mode after this patch set.

Then, I'd suggest to split the patches into two series:

1) AF_XDP TX zerocopy
2) AF_XDP RX zerocopy

And implement both small and mergeable in series 2).

>
>
> >
> > > +        */
> > > +       if (vi->big_packets)
> > > +               return -ENOENT;
> > > +
> > > +       if (qid >=3D vi->curr_queue_pairs)
> > > +               return -EINVAL;
> > > +
> > > +       sq =3D &vi->sq[qid];
> > > +       rq =3D &vi->rq[qid];
> > > +
> > > +       /* xsk tx zerocopy depend on the tx napi.
> > > +        *
> > > +        * All xsk packets are actually consumed and sent out from th=
e xsk tx
> > > +        * queue under the tx napi mechanism.
> > > +        */
> > > +       if (!sq->napi.weight)
> > > +               return -EPERM;
> > > +
> > > +       /* For the xsk, the tx and rx should have the same device. Bu=
t
> > > +        * vq->dma_dev allows every vq has the respective dma dev. So=
 I check
> > > +        * the dma dev of vq and sq is the same dev.
> > > +        */
> > > +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> > > +               return -EPERM;
> >
> > I don't understand how a different DMA device matters here. It looks
> > like the code is using per virtqueue DMA below.
>
> The af-xdp may use one buffer to receive from the rx and reuse this buffe=
r to
> send by the tx.  So the dma dev of sq and rq should be the same one.

Right, let's tweak the comment to say something like this.

Thanks


