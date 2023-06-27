Return-Path: <bpf+bounces-3540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2C73F667
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F781C20AAB
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82616409;
	Tue, 27 Jun 2023 08:03:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B815AFC
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:03:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093EE71
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687853018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAIgwfCxKCOJsdi6od/XlBbV/+5tFRsCfnVys12ZFNk=;
	b=LJ3QSXEVA4ijZO632BKlVcvWI7YS0jQRTtcTsgcH324tgfvzq1oI9hGWdB7ANwkOq76r2a
	YIVsX3UbFdkj251btm9gGz9m2tCmb/5c7cFuHD7xf1PblD+H0XN1XKoZRKhGrtb9PSw6ix
	auHIch+hADR6PIhRStJNBh16I5bDqIs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-h4hvF1g2Phurz9M6UHFc7w-1; Tue, 27 Jun 2023 04:03:37 -0400
X-MC-Unique: h4hvF1g2Phurz9M6UHFc7w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6997407faso20403931fa.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853015; x=1690445015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAIgwfCxKCOJsdi6od/XlBbV/+5tFRsCfnVys12ZFNk=;
        b=UJnU2GUTePA8ooMOBKgk9rxu7MeTpkslg5zcO6u8M12iu0szbN6d+YTx/ymvmL6Uk0
         LN//xk5zda7Iw7CuMIEpMdNspu7fOFbHE5lSE60fMtTysmgs/QLTZUOkh5XZHrVt7V8b
         WcHkZYi3BMtzp13ISvBjZImBzQD82ZoPvPwWCx+pbFhFOOItMs8hfM1Qv4bU9RCPqdGZ
         LrOLTiaprl7I3cukBDNJ5vkiRHJlDXhHbZyWDF5n8M43kshpt7AUNIGJTgiP6r96jiOc
         06LJcwunqGMtmLHyuFCKupF9jO9VcC6tZ2wQ8Qiwq9jrr+3IQKir1i0kESk22fUHx7G4
         Mprw==
X-Gm-Message-State: AC+VfDyDrHaKjnj8N9VEr5J6F612tsBKyS0U7AyumiXRk59fT2c0aHHg
	J5AYXbgwczZnx+ANk1bwkSEJ4PQDb0YJVbNqTp5LhGcbFmrPrQkqbAdSvWF68dIF73vRy1AZjGF
	X0PFYqMqHo7JoYWQdNebjfzkF3nIy
X-Received: by 2002:a2e:7316:0:b0:2b6:9e58:33e4 with SMTP id o22-20020a2e7316000000b002b69e5833e4mr3819042ljc.4.1687853014817;
        Tue, 27 Jun 2023 01:03:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hU3RHXYr/pj0pxaHkeuHxuPz++Ykm7OjgngDYXG0THDVyAk4d453g90XaTYXzIjRL+EoepNV13PFA/YETwDY=
X-Received: by 2002:a2e:7316:0:b0:2b6:9e58:33e4 with SMTP id
 o22-20020a2e7316000000b002b69e5833e4mr3819029ljc.4.1687853014630; Tue, 27 Jun
 2023 01:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:23 +0800
Message-ID: <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce virtqueue_set_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 5:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This helper allows the driver change the dma mode to premapped mode.
> Under the premapped mode, the virtio core do not do dma mapping
> internally.
>
> This just work when the use_dma_api is true. If the use_dma_api is false,
> the dma options is not through the DMA APIs, that is not the standard
> way of the linux kernel.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 72ed07a604d4..2afdfb9e3e30 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -172,6 +172,9 @@ struct vring_virtqueue {
>         /* Host publishes avail event idx */
>         bool event;
>
> +       /* Do DMA mapping by driver */
> +       bool premapped;
> +
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -2059,6 +2062,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(
>         vq->packed_ring =3D true;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->premapped =3D false;
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2548,6 +2552,7 @@ static struct virtqueue *__vring_new_virtqueue(unsi=
gned int index,
>  #endif
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->premapped =3D false;
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2691,6 +2696,41 @@ int virtqueue_resize(struct virtqueue *_vq, u32 nu=
m,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>
> +/**
> + * virtqueue_set_premapped - set the vring premapped mode
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Enable the premapped mode of the vq.
> + *
> + * The vring in premapped mode does not do dma internally, so the driver=
 must
> + * do dma mapping in advance. The driver must pass the dma_address throu=
gh
> + * dma_address of scatterlist. When the driver got a used buffer from
> + * the vring, it has to unmap the dma address. So the driver must call
> + * virtqueue_get_buf_premapped()/virtqueue_detach_unused_buf_premapped()=
.
> + *
> + * This must be called before adding any buf to vring.

And any old buffer should be detached?

> + * So this should be called immediately after init vq or vq reset.

Any way to detect and warn in this case? (not a must if it's too
expensive to do the check)

> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -EINVAL: vring does not use the dma api, so we can not enable premapp=
ed mode.
> + */
> +int virtqueue_set_premapped(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       if (!vq->use_dma_api)
> +               return -EINVAL;
> +
> +       vq->premapped =3D true;

I guess there should be a way to disable it. Would it be useful for
the case when AF_XDP sockets were destroyed?

Thanks


> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_premapped);
> +
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                                       unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..1fc0e1023bd4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
>
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>
> +int virtqueue_set_premapped(struct virtqueue *_vq);
> +
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> --
> 2.32.0.3.g01195cf9f
>


