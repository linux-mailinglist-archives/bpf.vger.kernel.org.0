Return-Path: <bpf+bounces-4987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B4753178
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 07:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04831C21518
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 05:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FD6AD7;
	Fri, 14 Jul 2023 05:46:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1A6AB5
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 05:46:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CA3580
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689313563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77AGNJv1V8XJrNZ1KyM3QJn519yY+kAc0YCuof2bFKU=;
	b=N4TjpfPhS8NdCQtfyxi9zwlYG46v6o6GPRughn0nFCmEpeGyYChjJJm/HvSCRie605JMZi
	5a4wDtL6vJ+xhXVWfJZzz07D62bxVZ3sj5+gjg2n71AtsqHTlQ0zKsKzhIyGIOwJWdMKdF
	At4NXM/hOwvNCO6bdASgDb4ULJLPdgc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-bU4LEZHlOpyHvwjaMsbltw-1; Fri, 14 Jul 2023 01:46:00 -0400
X-MC-Unique: bU4LEZHlOpyHvwjaMsbltw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b70c44b5fdso15316291fa.1
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 22:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689313559; x=1691905559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77AGNJv1V8XJrNZ1KyM3QJn519yY+kAc0YCuof2bFKU=;
        b=CKX0Jw8bgKxoSNM0hJWTcsdNzr4jUwvXCN9jp8QKlZVKhS6kvDOR3wv5Aqn5jwyAWq
         tby9b6zHqiIXDuG5WFEs+sg5fEOwfQSYexSt2Xi3ML1rTHXGxf9oDTlPVbwzbpvPbnPq
         j4jhEHerUdKK7zqgASWkGdghm1ICquMttiJLH5mdEh1WmpuGUh+Ikdr8TRNjB3FC/Jyl
         WRfSiicGLFJNJ7l8v4Ffsub4suyMBY8y+h2tsm9Cx9kiqXQwjWdPSgDyxGwL3+CmMqq8
         nvMGFcTVkzpnquN005x3iL184V+XIZ0sI1SPlbNbBWb38zXAA6QMBVTGLKOWfs1f7QR8
         rTsQ==
X-Gm-Message-State: ABy/qLaAKlQoNwJCv9GBsipzwP+uyVcrpKv+xnkDQl72K8e1+ycPPon9
	hv+8zFHsJuw25g+Mc/YjDJOYUJ3wSFo50OTi1TgB8iHkiMXjRvL2Hheyc2eWLZWRjaXAyBE4jIA
	9ZPF1lDUI6mFFCABWj+AO5OoKL4LB
X-Received: by 2002:a2e:b611:0:b0:2b7:2066:10e1 with SMTP id r17-20020a2eb611000000b002b7206610e1mr3108217ljn.0.1689313558981;
        Thu, 13 Jul 2023 22:45:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHSgrBYmMH1ILorf9h3K/mEQWclazvvg5uCwLIqIbMYCm7fl4FB4g4ZBAS6qMIhJsCZQoQq7D/UG1d2spsqtk=
X-Received: by 2002:a2e:b611:0:b0:2b7:2066:10e1 with SMTP id
 r17-20020a2eb611000000b002b7206610e1mr3108205ljn.0.1689313558547; Thu, 13 Jul
 2023 22:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com> <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231604.0892205-3-xuanzhuo@linux.alibaba.com> <CACGkMEsGY=1wpT_AjyuEbE-4HDJkH5_5wmaP5H30O0B16o3a5Q@mail.gmail.com>
 <1689307105.301344-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1689307105.301344-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jul 2023 13:45:38 +0800
Message-ID: <CACGkMEvkNVJmok=VsC1p84h=wL2r5=yeH4M9Zt8npcrkwH_H9g@mail.gmail.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one page
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 12:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Fri, 14 Jul 2023 11:57:05 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jul 13, 2023 at 3:02=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 13 Jul 2023 12:20:01 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jul 10, 2023 at 11:43=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > >
> > > > I'd suggest to tweak the title like:
> > > >
> > > > "merge dma operations when refilling mergeable buffers"
> > > >
> > > > > Currently, the virtio core will perform a dma operation for each
> > > > > operation.
> > > >
> > > > "for each buffer"?
> > > >
> > > > > Although, the same page may be operated multiple times.
> > > > >
> > > > > The driver does the dma operation and manages the dma address bas=
ed the
> > > > > feature premapped of virtio core.
> > > > >
> > > > > This way, we can perform only one dma operation for the same page=
. In
> > > > > the case of mtu 1500, this can reduce a lot of dma operations.
> > > > >
> > > > > Tested on Aliyun g7.4large machine, in the case of a cpu 100%, pp=
s
> > > > > increased from 1893766 to 1901105. An increase of 0.4%.
> > > >
> > > > Btw, it looks to me the code to deal with XDP_TX/REDIRECT for
> > > > linearized pages was missed.
> > > >
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 283 +++++++++++++++++++++++++++++++++=
+++---
> > > > >  1 file changed, 267 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 486b5849033d..4de845d35bed 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -126,6 +126,27 @@ static const struct virtnet_stat_desc virtne=
t_rq_stats_desc[] =3D {
> > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
> > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
> > > > >
> > > > > +/* The bufs on the same page may share this struct. */
> > > > > +struct virtnet_rq_dma {
> > > > > +       struct virtnet_rq_dma *next;
> > > > > +
> > > > > +       dma_addr_t addr;
> > > > > +
> > > > > +       void *buf;
> > > > > +       u32 len;
> > > > > +
> > > > > +       u32 ref;
> > > > > +};
> > > > > +
> > > > > +/* Record the dma and buf. */
> > > > > +struct virtnet_rq_data {
> > > > > +       struct virtnet_rq_data *next;
> > > > > +
> > > > > +       void *buf;
> > > > > +
> > > > > +       struct virtnet_rq_dma *dma;
> > > > > +};
> > > > > +
> > > > >  /* Internal representation of a send virtqueue */
> > > > >  struct send_queue {
> > > > >         /* Virtqueue associated with this send _queue */
> > > > > @@ -175,6 +196,13 @@ struct receive_queue {
> > > > >         char name[16];
> > > > >
> > > > >         struct xdp_rxq_info xdp_rxq;
> > > > > +
> > > > > +       struct virtnet_rq_data *data_array;
> > > > > +       struct virtnet_rq_data *data_free;
> > > > > +
> > > > > +       struct virtnet_rq_dma *dma_array;
> > > > > +       struct virtnet_rq_dma *dma_free;
> > > > > +       struct virtnet_rq_dma *last_dma;
> > > > >  };
> > > > >
> > > > >  /* This structure can contain rss message with maximum settings =
for indirection table and keysize
> > > > > @@ -549,6 +577,176 @@ static struct sk_buff *page_to_skb(struct v=
irtnet_info *vi,
> > > > >         return skb;
> > > > >  }
> > > > >
> > > > > +static void virtnet_rq_unmap(struct receive_queue *rq, struct vi=
rtnet_rq_dma *dma)
> > > > > +{
> > > > > +       struct device *dev;
> > > > > +
> > > > > +       --dma->ref;
> > > > > +
> > > > > +       if (dma->ref)
> > > > > +               return;
> > > > > +
> > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > +
> > > > > +       dma_unmap_page(dev, dma->addr, dma->len, DMA_FROM_DEVICE)=
;
> > > > > +
> > > > > +       dma->next =3D rq->dma_free;
> > > > > +       rq->dma_free =3D dma;
> > > > > +}
> > > > > +
> > > > > +static void *virtnet_rq_recycle_data(struct receive_queue *rq,
> > > > > +                                    struct virtnet_rq_data *data=
)
> > > > > +{
> > > > > +       void *buf;
> > > > > +
> > > > > +       buf =3D data->buf;
> > > > > +
> > > > > +       data->next =3D rq->data_free;
> > > > > +       rq->data_free =3D data;
> > > > > +
> > > > > +       return buf;
> > > > > +}
> > > > > +
> > > > > +static struct virtnet_rq_data *virtnet_rq_get_data(struct receiv=
e_queue *rq,
> > > > > +                                                  void *buf,
> > > > > +                                                  struct virtnet=
_rq_dma *dma)
> > > > > +{
> > > > > +       struct virtnet_rq_data *data;
> > > > > +
> > > > > +       data =3D rq->data_free;
> > > > > +       rq->data_free =3D data->next;
> > > > > +
> > > > > +       data->buf =3D buf;
> > > > > +       data->dma =3D dma;
> > > > > +
> > > > > +       return data;
> > > > > +}
> > > > > +
> > > > > +static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *l=
en, void **ctx)
> > > > > +{
> > > > > +       struct virtnet_rq_data *data;
> > > > > +       void *buf;
> > > > > +
> > > > > +       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > +       if (!buf || !rq->data_array)
> > > > > +               return buf;
> > > > > +
> > > > > +       data =3D buf;
> > > > > +
> > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > +
> > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > +}
> > > > > +
> > > > > +static void *virtnet_rq_detach_unused_buf(struct receive_queue *=
rq)
> > > > > +{
> > > > > +       struct virtnet_rq_data *data;
> > > > > +       void *buf;
> > > > > +
> > > > > +       buf =3D virtqueue_detach_unused_buf(rq->vq);
> > > > > +       if (!buf || !rq->data_array)
> > > > > +               return buf;
> > > > > +
> > > > > +       data =3D buf;
> > > > > +
> > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > +
> > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > +}
> > > > > +
> > > > > +static int virtnet_rq_map_sg(struct receive_queue *rq, void *buf=
, u32 len)
> > > > > +{
> > > > > +       struct virtnet_rq_dma *dma =3D rq->last_dma;
> > > > > +       struct device *dev;
> > > > > +       u32 off, map_len;
> > > > > +       dma_addr_t addr;
> > > > > +       void *end;
> > > > > +
> > > > > +       if (likely(dma) && buf >=3D dma->buf && (buf + len <=3D d=
ma->buf + dma->len)) {
> > > > > +               ++dma->ref;
> > > > > +               addr =3D dma->addr + (buf - dma->buf);
> > > > > +               goto ok;
> > > > > +       }
> > > > > +
> > > > > +       end =3D buf + len - 1;
> > > > > +       off =3D offset_in_page(end);
> > > > > +       map_len =3D len + PAGE_SIZE - off;
> > > >
> > > > This assumes a PAGE_SIZE which seems sub-optimal as page frag could=
 be
> > > > larger than this.
> > > >
> > > > > +
> > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > +
> > > > > +       addr =3D dma_map_page_attrs(dev, virt_to_page(buf), offse=
t_in_page(buf),
> > > > > +                                 map_len, DMA_FROM_DEVICE, 0);
> > > > > +       if (addr =3D=3D DMA_MAPPING_ERROR)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       dma =3D rq->dma_free;
> > > > > +       rq->dma_free =3D dma->next;
> > > > > +
> > > > > +       dma->ref =3D 1;
> > > > > +       dma->buf =3D buf;
> > > > > +       dma->addr =3D addr;
> > > > > +       dma->len =3D map_len;
> > > > > +
> > > > > +       rq->last_dma =3D dma;
> > > > > +
> > > > > +ok:
> > > > > +       sg_init_table(rq->sg, 1);
> > > > > +       rq->sg[0].dma_address =3D addr;
> > > > > +       rq->sg[0].length =3D len;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int virtnet_rq_merge_map_init(struct virtnet_info *vi)
> > > > > +{
> > > > > +       struct receive_queue *rq;
> > > > > +       int i, err, j, num;
> > > > > +
> > > > > +       /* disable for big mode */
> > > > > +       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > +               err =3D virtqueue_set_premapped(vi->rq[i].vq);
> > > > > +               if (err)
> > > > > +                       continue;
> > > > > +
> > > > > +               rq =3D &vi->rq[i];
> > > > > +
> > > > > +               num =3D virtqueue_get_vring_size(rq->vq);
> > > > > +
> > > > > +               rq->data_array =3D kmalloc_array(num, sizeof(*rq-=
>data_array), GFP_KERNEL);
> > > > > +               if (!rq->data_array)
> > > >
> > > > Can we avoid those allocations when we don't use the DMA API?
> > > >
> > > > > +                       goto err;
> > > > > +
> > > > > +               rq->dma_array =3D kmalloc_array(num, sizeof(*rq->=
dma_array), GFP_KERNEL);
> > > > > +               if (!rq->dma_array)
> > > > > +                       goto err;
> > > > > +
> > > > > +               for (j =3D 0; j < num; ++j) {
> > > > > +                       rq->data_array[j].next =3D rq->data_free;
> > > > > +                       rq->data_free =3D &rq->data_array[j];
> > > > > +
> > > > > +                       rq->dma_array[j].next =3D rq->dma_free;
> > > > > +                       rq->dma_free =3D &rq->dma_array[j];
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +
> > > > > +err:
> > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > +               struct receive_queue *rq;
> > > > > +
> > > > > +               rq =3D &vi->rq[i];
> > > > > +
> > > > > +               kfree(rq->dma_array);
> > > > > +               kfree(rq->data_array);
> > > > > +       }
> > > > > +
> > > > > +       return -ENOMEM;
> > > > > +}
> > > > > +
> > > > >  static void free_old_xmit_skbs(struct send_queue *sq, bool in_na=
pi)
> > > > >  {
> > > > >         unsigned int len;
> > > > > @@ -835,7 +1033,7 @@ static struct page *xdp_linearize_page(struc=
t receive_queue *rq,
> > > > >                 void *buf;
> > > > >                 int off;
> > > > >
> > > > > -               buf =3D virtqueue_get_buf(rq->vq, &buflen);
> > > > > +               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> > > > >                 if (unlikely(!buf))
> > > > >                         goto err_buf;
> > > > >
> > > > > @@ -1126,7 +1324,7 @@ static int virtnet_build_xdp_buff_mrg(struc=
t net_device *dev,
> > > > >                 return -EINVAL;
> > > > >
> > > > >         while (--*num_buf > 0) {
> > > > > -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ctx)=
;
> > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
> > > > >                 if (unlikely(!buf)) {
> > > > >                         pr_debug("%s: rx error: %d buffers out of=
 %d missing\n",
> > > > >                                  dev->name, *num_buf,
> > > > > @@ -1351,7 +1549,7 @@ static struct sk_buff *receive_mergeable(st=
ruct net_device *dev,
> > > > >         while (--num_buf) {
> > > > >                 int num_skb_frags;
> > > > >
> > > > > -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ctx)=
;
> > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
> > > > >                 if (unlikely(!buf)) {
> > > > >                         pr_debug("%s: rx error: %d buffers out of=
 %d missing\n",
> > > > >                                  dev->name, num_buf,
> > > > > @@ -1414,7 +1612,7 @@ static struct sk_buff *receive_mergeable(st=
ruct net_device *dev,
> > > > >  err_skb:
> > > > >         put_page(page);
> > > > >         while (num_buf-- > 1) {
> > > > > -               buf =3D virtqueue_get_buf(rq->vq, &len);
> > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, NULL);
> > > > >                 if (unlikely(!buf)) {
> > > > >                         pr_debug("%s: rx error: %d buffers missin=
g\n",
> > > > >                                  dev->name, num_buf);
> > > > > @@ -1529,6 +1727,7 @@ static int add_recvbuf_small(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > >         unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> > > > >         void *ctx =3D (void *)(unsigned long)xdp_headroom;
> > > > >         int len =3D vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LE=
N + xdp_headroom;
> > > > > +       struct virtnet_rq_data *data;
> > > > >         int err;
> > > > >
> > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > @@ -1539,11 +1738,34 @@ static int add_recvbuf_small(struct virtn=
et_info *vi, struct receive_queue *rq,
> > > > >         buf =3D (char *)page_address(alloc_frag->page) + alloc_fr=
ag->offset;
> > > > >         get_page(alloc_frag->page);
> > > > >         alloc_frag->offset +=3D len;
> > > > > -       sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > -                   vi->hdr_len + GOOD_PACKET_LEN);
> > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> > > > > +
> > > > > +       if (rq->data_array) {
> > > > > +               err =3D virtnet_rq_map_sg(rq, buf + VIRTNET_RX_PA=
D + xdp_headroom,
> > > > > +                                       vi->hdr_len + GOOD_PACKET=
_LEN);
> > > >
> > > > Thanks to the compound page. I wonder if everything could be
> > > > simplified if we just reuse page->private for storing metadata like
> > > > dma address and refcnt. Then we don't need extra stuff for tracking
> > > > any other thing?
> > >
> > > Maybe we can try alloc one small buffer from the page_frag to store t=
he dma info
> > > when page_frag.offset =3D=3D 0.
> >
> > And store it in the ctx? I think it should work.
>
>
> Since the dma information is located on the first page of the composite p=
age, we
> can get the dma information through buf.
>
> No need to modify ctx.

Ok, I'm not sure I get this fully, maybe you can post another version to se=
e.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > >
> > > > > +               if (err)
> > > > > +                       goto map_err;
> > > > > +
> > > > > +               data =3D virtnet_rq_get_data(rq, buf, rq->last_dm=
a);
> > > > > +       } else {
> > > > > +               sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_he=
adroom,
> > > > > +                           vi->hdr_len + GOOD_PACKET_LEN);
> > > > > +               data =3D (void *)buf;
> > > > > +       }
> > > > > +
> > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data, =
ctx, gfp);
> > > > >         if (err < 0)
> > > > > -               put_page(virt_to_head_page(buf));
> > > > > +               goto add_err;
> > > > > +
> > > > > +       return err;
> > > > > +
> > > > > +add_err:
> > > > > +       if (rq->data_array) {
> > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > +       }
> > > > > +
> > > > > +map_err:
> > > > > +       put_page(virt_to_head_page(buf));
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > @@ -1620,6 +1842,7 @@ static int add_recvbuf_mergeable(struct vir=
tnet_info *vi,
> > > > >         unsigned int headroom =3D virtnet_get_headroom(vi);
> > > > >         unsigned int tailroom =3D headroom ? sizeof(struct skb_sh=
ared_info) : 0;
> > > > >         unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroom)=
;
> > > > > +       struct virtnet_rq_data *data;
> > > > >         char *buf;
> > > > >         void *ctx;
> > > > >         int err;
> > > > > @@ -1650,12 +1873,32 @@ static int add_recvbuf_mergeable(struct v=
irtnet_info *vi,
> > > > >                 alloc_frag->offset +=3D hole;
> > > > >         }
> > > > >
> > > > > -       sg_init_one(rq->sg, buf, len);
> > > > > +       if (rq->data_array) {
> > > > > +               err =3D virtnet_rq_map_sg(rq, buf, len);
> > > > > +               if (err)
> > > > > +                       goto map_err;
> > > > > +
> > > > > +               data =3D virtnet_rq_get_data(rq, buf, rq->last_dm=
a);
> > > > > +       } else {
> > > > > +               sg_init_one(rq->sg, buf, len);
> > > > > +               data =3D (void *)buf;
> > > > > +       }
> > > > > +
> > > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data, =
ctx, gfp);
> > > > >         if (err < 0)
> > > > > -               put_page(virt_to_head_page(buf));
> > > > > +               goto add_err;
> > > > > +
> > > > > +       return 0;
> > > > > +
> > > > > +add_err:
> > > > > +       if (rq->data_array) {
> > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > +       }
> > > > >
> > > > > +map_err:
> > > > > +       put_page(virt_to_head_page(buf));
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > @@ -1775,13 +2018,13 @@ static int virtnet_receive(struct receive=
_queue *rq, int budget,
> > > > >                 void *ctx;
> > > > >
> > > > >                 while (stats.packets < budget &&
> > > > > -                      (buf =3D virtqueue_get_buf_ctx(rq->vq, &le=
n, &ctx))) {
> > > > > +                      (buf =3D virtnet_rq_get_buf(rq, &len, &ctx=
))) {
> > > > >                         receive_buf(vi, rq, buf, len, ctx, xdp_xm=
it, &stats);
> > > > >                         stats.packets++;
> > > > >                 }
> > > > >         } else {
> > > > >                 while (stats.packets < budget &&
> > > > > -                      (buf =3D virtqueue_get_buf(rq->vq, &len)) =
!=3D NULL) {
> > > > > +                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL=
)) !=3D NULL) {
> > > > >                         receive_buf(vi, rq, buf, len, NULL, xdp_x=
mit, &stats);
> > > > >                         stats.packets++;
> > > > >                 }
> > > > > @@ -3514,6 +3757,9 @@ static void virtnet_free_queues(struct virt=
net_info *vi)
> > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > >                 __netif_napi_del(&vi->rq[i].napi);
> > > > >                 __netif_napi_del(&vi->sq[i].napi);
> > > > > +
> > > > > +               kfree(vi->rq[i].data_array);
> > > > > +               kfree(vi->rq[i].dma_array);
> > > > >         }
> > > > >
> > > > >         /* We called __netif_napi_del(),
> > > > > @@ -3591,9 +3837,10 @@ static void free_unused_bufs(struct virtne=
t_info *vi)
> > > > >         }
> > > > >
> > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > -               struct virtqueue *vq =3D vi->rq[i].vq;
> > > > > -               while ((buf =3D virtqueue_detach_unused_buf(vq)) =
!=3D NULL)
> > > > > -                       virtnet_rq_free_unused_buf(vq, buf);
> > > > > +               struct receive_queue *rq =3D &vi->rq[i];
> > > > > +
> > > > > +               while ((buf =3D virtnet_rq_detach_unused_buf(rq))=
 !=3D NULL)
> > > > > +                       virtnet_rq_free_unused_buf(rq->vq, buf);
> > > > >                 cond_resched();
> > > > >         }
> > > > >  }
> > > > > @@ -3767,6 +4014,10 @@ static int init_vqs(struct virtnet_info *v=
i)
> > > > >         if (ret)
> > > > >                 goto err_free;
> > > > >
> > > > > +       ret =3D virtnet_rq_merge_map_init(vi);
> > > > > +       if (ret)
> > > > > +               goto err_free;
> > > > > +
> > > > >         cpus_read_lock();
> > > > >         virtnet_set_affinity(vi);
> > > > >         cpus_read_unlock();
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> >
>


