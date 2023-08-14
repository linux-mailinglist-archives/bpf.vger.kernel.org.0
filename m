Return-Path: <bpf+bounces-7683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AFD77AFD7
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 05:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213761C2040D
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDD1FB8;
	Mon, 14 Aug 2023 03:06:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399D1842
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 03:06:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F53E6C
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691982364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEQvLnZpHKMxmINXxgY8yNlnhaoRKs5JAeT4GwTAej0=;
	b=Ue8Ytg1aUHO3uxvdqZ9Eb/EEYJlWJtrsQh1d1cl83EKH3M04azNRqyw0W9dYjR4+2V4oW+
	gVhTB485CgDoen2MagZAFakkeUHSauu69wUtP7skJldIi86DCJm5aoQw+6lyLqT4ghuNAZ
	FEMPiLmL7cy4YMzwSV9YvDR5duQFauM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-K7D5x6fTNL2RTKMO9CRa1A-1; Sun, 13 Aug 2023 23:06:03 -0400
X-MC-Unique: K7D5x6fTNL2RTKMO9CRa1A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9dc1bfdd2so37599941fa.1
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 20:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691982361; x=1692587161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEQvLnZpHKMxmINXxgY8yNlnhaoRKs5JAeT4GwTAej0=;
        b=QWpQtE6Rx5RDLXbr+ikC49oTXtArYHn3m01n8OFxd5aMu10X2xdmggQ2RucUVa8ZcT
         4UdAspgmSHmXL5wQR+j6jqhhR8XHexfHeZppGY6SeSE0/YZDWSNPxTIoEJrQxUArALmu
         FzHi7dFpFgoDvEoct2kpDQi2sMBqZTwl1RRK/GW6KR+n1aAs4IMu2hYUfN5THLrNo7Sp
         uCL6gTKkQm6srk0Z4GmhEF2R40KpTDV454pcj8N8QR+yQ6vbVevR9ARL9c1j2BjAqcSL
         lCfgswQumndXk2L90UrcANlf6frUa85g7nw+gWluQatLeF8uiJQ8uCt8OlmZhFQNEkbQ
         eoQA==
X-Gm-Message-State: AOJu0YxHnJHKvEOJ7KF01HFfG+SlW+2AIJ2KPLBIIF80WsAnAx5ywWsr
	ro/XPoWqG6DtRlMtHgzImHfdpmNznXXXK8RNl+SXI0Aq8lfZ3ACl5GwcQH019ozRmG2LUJBMZFP
	G0qZfERE8JI1gquhGLyej8oFaMSYu
X-Received: by 2002:a05:651c:201:b0:2b6:c8e8:915f with SMTP id y1-20020a05651c020100b002b6c8e8915fmr6561102ljn.22.1691982361707;
        Sun, 13 Aug 2023 20:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAPWsS2u1WCGu6IhHV+mL911csJPkxR6lX4zb+l6NtWUsStkFmd5o09OQZkwH4y+pfluKc9s8tjYAVczcb04=
X-Received: by 2002:a05:651c:201:b0:2b6:c8e8:915f with SMTP id
 y1-20020a05651c020100b002b6c8e8915fmr6561095ljn.22.1691982361435; Sun, 13 Aug
 2023 20:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com> <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 11:05:49 +0800
Message-ID: <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 8:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> caller can do dma operation in advance. The purpose is to keep memory
> mapped across multiple add/get buf operations.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

So I think we don't have actual users for this in this series? Can we
simply have another independent patch for this?

> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f9f772e85a38..bb3d73d221cd 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2265,6 +2265,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>
> +/**
> + * virtqueue_dma_dev - get the dma dev
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the dma dev. That can been used for dma api.
> + */
> +struct device *virtqueue_dma_dev(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       if (vq->use_dma_api)
> +               return vring_dma_dev(vq);
> +       else
> +               return NULL;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_dev);

One possible concern is that exporting things like NULL may result in
the switch in the caller (driver). I wonder if it's better to do
BUG_ON() in the path of NULL?

Thanks

> +
>  /**
>   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 8add38038877..bd55a05eec04 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -61,6 +61,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>                       void *data,
>                       gfp_t gfp);
>
> +struct device *virtqueue_dma_dev(struct virtqueue *vq);
> +
>  bool virtqueue_kick(struct virtqueue *vq);
>
>  bool virtqueue_kick_prepare(struct virtqueue *vq);
> --
> 2.32.0.3.g01195cf9f
>


