Return-Path: <bpf+bounces-49278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BCDA16541
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 02:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D44160273
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE54D5AB;
	Mon, 20 Jan 2025 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt4hQDH/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE11CD2C
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338313; cv=none; b=nzuveAkJrKQVp5q92xA0RFjd50uY7ohaYC/bmD6saLutH41QeImr8xBfzD4F9C/G0pQNuCx/HYSxtVwAyb8svHIvHGedFQBKuPOQPpjlkmIra7deE4m5xM1U7e6Pi95QCrbpoyBdMtn4X3pOfg8Acp0boW9Kvl9P52Tj+R5EgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338313; c=relaxed/simple;
	bh=yuBc5+h/9lwzieCgUsFLqW7znh5vXegnrIKqqEjuQzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZlk9VdUkQhpVNTPFoLtpOBEwsPTgGvyMc8WrA91iMmWu720iQ048H7cTX6gVt0VNmVb7xnrjSrupnFxFeZk/KP8pR3PWocNU5rcvXiqK6Y2pIjTrDgy4f5KQpJ5XS1PMl/SLJncd+kV6+EMisUpIpg5xLIMdZM4NVUACh+Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt4hQDH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737338311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
	b=Xt4hQDH/czYby6hl6HzyCMNm94k0p4HeHvup77+VBQhVTMJPXRomYLDGxoq03I2bFVs25S
	c85CSyabsX5wNiL/MIPOVYLPQ2wI5ofDK1ZN5S/nzXYhY3Phdpdu7h4Oa3SsJnomVGy+TN
	VRZookp505lWKxRyJC9hpjkekTP16Z0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-w1iNsCW3PneRBw57F23G9g-1; Sun, 19 Jan 2025 20:58:29 -0500
X-MC-Unique: w1iNsCW3PneRBw57F23G9g-1
X-Mimecast-MFC-AGG-ID: w1iNsCW3PneRBw57F23G9g
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so11287885a91.2
        for <bpf@vger.kernel.org>; Sun, 19 Jan 2025 17:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737338306; x=1737943106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
        b=AD5/aX3HeOkBgyTNZPx4SmRZG5DV+BQZ4bfrwqcqVRXhku+MQPQGuKnYU9xjH0muaV
         0VvkHRQjVlLlz5VrPfXXdWmQDBF9QBmM2mn0xLiHLDdr1IPvfrf5tEWZJVu4HFpYbbPZ
         A4uf4ZNee5v12KzsK1inOsJXBSkAGCuAnRLY1zf7ZKkfaz4bsbPthQthUSpJypVrQ6b0
         O6a80MSp8OISMVCLMgvTee0FayS2zpoBM8LjoafTzXgr8abidVmqN7JFOZPCuha3WDQx
         U8BQGU7MiYIN6/4f6y0XFqGg8OwqD2RlbmMaqAvgmKRrPIKL6n6Inq/93WpwO8fC6ZX9
         1NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxjgelUYPNPrRN0L6ZIPxL31w7u0C/TbKv0RC/AVBpavmZpwcelf/d0Rt1gKtKyl2suNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCJL4LHBOoSduSF4dL+L0wPhKOb8+kd5u4d5zZ8vI/QjAAmr5
	/bn4UeSDCjDzCzUcuATKvO8FtGXbYhcdfS0BxCMinZQQoa8BilI1OUetef9/HMjnd3FxAMtAiZW
	41sIcqhDvN/zXFiPfbWgNgpxK66eDCtw5xAr6+fXb6hlaM55+ULLN0MNdQdqoDbSRykxjG9jA9o
	oXy1Ojg4Ccr2Re36zFFctorHFf916geFJxOjc=
X-Gm-Gg: ASbGncuxDD8zu+hk2yHopTHlo02VTxOPAMJTJv6zafYV5dD/tY05Q+dj6PjWgnzvrCM
	OEVYcCy17ywiwkqarvE/tshKKPxE2F4lgFAsUj37DYP8+wLH76o1W
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2f782d32bdcmr14441686a91.26.1737338306239;
        Sun, 19 Jan 2025 17:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxcO+gcU6GGpItpVaST+mP+lotfH8ALDufTNkb6YlviJFAQ1S+ZPqhw8EXYw//ooixqAGk20ku9VsIkuS7U5A=
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f782d32bdcmr14441654a91.26.1737338305832; Sun, 19 Jan 2025
 17:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116055302.14308-1-jdamato@fastly.com> <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 09:58:13 +0800
X-Gm-Features: AbW1kvarckGogeshrcvCGai-_wdzjzim8Cy3XTbYBj63sr-Fx1KKQaClUhGQeVc
Message-ID: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Joe Damato <jdamato@fastly.com>, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote=
:
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json=3D'{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Eliminate RTNL code paths using the API Jakub introduced in patch =
1
> >      of this v2.
> >    - Added virtnet_napi_disable to reduce code duplication as
> >      suggested by Jason Wang.
> >
> >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cff18c66b54a..c6fda756dd07 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqu=
eue *vq,
> >       local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_stru=
ct *napi)
> > +static void virtnet_napi_enable(struct virtqueue *vq,
> > +                             struct napi_struct *napi)
> >  {
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> >       virtnet_napi_do_enable(vq, napi);
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, na=
pi);
>
> So what case the check of xdp_enabled is for?

+1 and I think the XDP related checks should be done by the caller not here=
.

>
> And I think we should merge this to last commit.
>
> Thanks.
>

Thanks

> >  }
> >
> >  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> > @@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtne=
t_info *vi,
> >       virtnet_napi_do_enable(vq, napi);
> >  }
> >
> > +static void virtnet_napi_disable(struct virtqueue *vq,
> > +                              struct napi_struct *napi)
> > +{
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> > +
> > +     napi_disable(napi);
> > +}
> > +
> >  static void virtnet_napi_tx_disable(struct napi_struct *napi)
> >  {
> >       if (napi->weight)
> > @@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
> >       for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >               struct receive_queue *rq =3D &vi->rq[i];
> >
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> > +
> >               still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> >               virtnet_napi_enable(rq->vq, &rq->napi);
> >
> > @@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> >  {
> >       virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> > -     napi_disable(&vi->rq[qp_index].napi);
> > +     virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi)=
;
> >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > @@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
> >       bool running =3D netif_running(vi->dev);
> >
> >       if (running) {
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> >               virtnet_cancel_dim(vi, &rq->dim);
> >       }
> >  }
> > @@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev=
, struct bpf_prog *prog,
> >       /* Make sure NAPI is not using any XDP TX queues for RX. */
> >       if (netif_running(dev)) {
> >               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -                     napi_disable(&vi->rq[i].napi);
> > +                     virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].nap=
i);
> >                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> >               }
> >       }
> > --
> > 2.25.1
> >
>


