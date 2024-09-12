Return-Path: <bpf+bounces-39698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A335E97632B
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7828181B
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423318E752;
	Thu, 12 Sep 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l4GrSaRi"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D01552E1;
	Thu, 12 Sep 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126975; cv=none; b=o6T125T5gW5OY8rqZsocJL4SUeeHYL+nGQj2MmITfxdjrwAmRnhYlGU20sxwT/Bm4m3p1M1CD3eTk0MOZwSr6yefrNt7S98MTkVokXXPNJ/ZWuIXddbPORNyrffhqYRgPQo+V8aWxRr8Q4YoCIVRhx+jRZBw30s1qa+/+GZ1CTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126975; c=relaxed/simple;
	bh=j/o+wcsyRF/DAocXBwgSxHKy2B6Gf7g2GPjxJLoUbKc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LbYI3zIfxgf2P1XFr7ios2Ky2TPF1wMRHnSkTx7T8Jr8zBu81w4ZQIjYAZ5NRKdmzHBGlRT+aohYpoYBJhjfGlmDDCTj1kuIrrrkMsYML7a7y0B+y++ieccsCQaWivRNcBkJIZA+moAbDSzuUr3cpSm2yuq4zr8eHPd2/eVa04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l4GrSaRi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726126969; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=E05P+8jgvmwnGVGquKKKGBfFfSCeC2pb59XNl5pAJiw=;
	b=l4GrSaRiPvKF0gkqrQ9v2OGy/uYyLTTT+uNm/PXPTrKZ2JaLAmAPPDFSy1InTLWXkN/gy0cvwwde5MTCmXrBH3B9102VCW2cWOj4c4rMd2LF78NqZ/eke/5wCyR5CoUPZgw0s3l9FnTfh3GedhrNFr2NQ6DX44S6vNhUhimY9Kg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqd5Wx_1726126968)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:42:49 +0800
Message-ID: <1726126586.5406406-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 04/13] virtio_ring: perform premapped operations based on per-buffer
Date: Thu, 12 Sep 2024 15:36:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEt19u07b_2GkT_tEBhpKJj97VoF-jcSqoaTyEULoWvdFw@mail.gmail.com>
In-Reply-To: <CACGkMEt19u07b_2GkT_tEBhpKJj97VoF-jcSqoaTyEULoWvdFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 11:54:25 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The current configuration sets the virtqueue (vq) to premapped mode,
> > implying that all buffers submitted to this queue must be mapped ahead
> > of time. This presents a challenge for the virtnet send queue (sq): the
> > virtnet driver would be required to keep track of dma information for vq
> > size * 17, which can be substantial. However, if the premapped mode were
> > applied on a per-buffer basis, the complexity would be greatly reduced.
> > With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> > skb buffers could remain unmapped.
>
> Is this only applied to TX or both TX and RX.


For rx, if you mean per-buffer dma buffer, I think it is yes,
rx can reuse this. If you mean should we do premapped for the
normal rx buffers, I think we should, that can reduce the
dma map operations.


>
> >
> > We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> > indicates that the driver has performed DMA mapping in advance, allowing
> > the Virtio core to directly utilize sg_dma_address(sg) without
> > conducting any internal DMA mapping.
>
> This seems conflict with the code below?
>
> #define sg_is_premapped(sg) (!sg_page(sg))

Sorry, I do not get for you.

The key point is that the sg->page is setted by driver.

So I mean if the driver sets sg->page =3D NULL, then for this sg,
the virtio core can skip dma mapping. If the driver sets
sg->page to the page of the buffer, then the virtio core should
do dma mapping for this sg.



>
> And rethink of the design, a question is that is there a chance that
> VM_PFNMAP area could be used for virtio-net? If it is true, the trick
> for sg_page() can not work?
>
> A quick glance told me AF_XEP seems to be safe as it uses
> pin_user_pages(), but we need to check other possibilities.
>
> Or we need to fall back to our previous idea, having new APIs.
>
> > Additionally, DMA unmap operations
> > for this buffer will be bypassed.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 70 +++++++++++++++++++++---------------
> >  1 file changed, 41 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index b43eca93015c..7efddc71af67 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -235,6 +235,7 @@ static void vring_free(struct virtqueue *_vq);
> >   */
> >
> >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
> > +#define sg_is_premapped(sg) (!sg_page(sg))
> >
> >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> >                                    unsigned int total_sg)
> > @@ -292,9 +293,10 @@ static bool vring_use_dma_api(const struct virtio_=
device *vdev)
> >         return false;
> >  }
> >
> > -static bool vring_need_unmap_buffer(const struct vring_virtqueue *vrin=
g)
> > +static bool vring_need_unmap_buffer(const struct vring_virtqueue *vrin=
g,
> > +                                   const struct vring_desc_extra *extr=
a)
> >  {
> > -       return vring->use_dma_api && !vring->premapped;
> > +       return vring->use_dma_api && (extra->addr !=3D DMA_MAPPING_ERRO=
R);
> >  }
> >
> >  size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > @@ -366,7 +368,7 @@ static struct device *vring_dma_dev(const struct vr=
ing_virtqueue *vq)
> >  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct s=
catterlist *sg,
> >                             enum dma_data_direction direction, dma_addr=
_t *addr)
> >  {
> > -       if (vq->premapped) {
> > +       if (sg_is_premapped(sg)) {
> >                 *addr =3D sg_dma_address(sg);
> >                 return 0;
> >         }
> > @@ -457,7 +459,7 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > -               if (!vring_need_unmap_buffer(vq))
> > +               if (!vring_need_unmap_buffer(vq, extra))
> >                         goto out;
> >
> >                 dma_unmap_page(vring_dma_dev(vq),
> > @@ -510,7 +512,7 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
> >                                                     dma_addr_t addr,
> >                                                     unsigned int len,
> >                                                     u16 flags,
> > -                                                   bool indirect)
> > +                                                   bool indirect, bool=
 premapped)
> >  {
> >         u16 next;
> >
> > @@ -518,7 +520,7 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
> >         desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> >         desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> >
> > -       extra[i].addr =3D addr;
> > +       extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
> >         extra[i].len =3D len;
> >         extra[i].flags =3D flags;
> >
> > @@ -611,7 +613,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                          */
> >                         i =3D virtqueue_add_desc_split(_vq, desc, extra=
, i, addr, sg->length,
> >                                                      VRING_DESC_F_NEXT,
> > -                                                    indirect);
> > +                                                    indirect, sg_is_pr=
emapped(sg));
> >                 }
> >         }
> >         for (; n < (out_sgs + in_sgs); n++) {
> > @@ -629,12 +631,12 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                                                      sg->length,
> >                                                      VRING_DESC_F_NEXT |
> >                                                      VRING_DESC_F_WRITE,
> > -                                                    indirect);
> > +                                                    indirect, sg_is_pr=
emapped(sg));
> >                 }
> >         }
> >         /* Last one doesn't continue. */
> >         desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_=
NEXT);
> > -       if (!indirect && vring_need_unmap_buffer(vq))
> > +       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].=
flags &=3D
> >                         ~VRING_DESC_F_NEXT;
> >
> > @@ -643,19 +645,15 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                 dma_addr_t addr =3D vring_map_single(
> >                         vq, desc, total_sg * sizeof(struct vring_desc),
> >                         DMA_TO_DEVICE);
> > -               if (vring_mapping_error(vq, addr)) {
> > -                       if (vq->premapped)
> > -                               goto free_indirect;
> > -
> > +               if (vring_mapping_error(vq, addr))
> >                         goto unmap_release;
> > -               }
> >
> >                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> >                                          vq->split.desc_extra,
> >                                          head, addr,
> >                                          total_sg * sizeof(struct vring=
_desc),
> >                                          VRING_DESC_F_INDIRECT,
> > -                                        false);
> > +                                        false, false);
> >         }
> >
> >         /* We're using some buffers from the free list. */
> > @@ -712,7 +710,6 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                 i =3D vring_unmap_one_split(vq, &extra[i]);
> >         }
> >
> > -free_indirect:
> >         if (indirect)
> >                 kfree(desc);
> >
> > @@ -794,7 +791,7 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
> >                                 VRING_DESC_F_INDIRECT));
> >                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> >
> > -               if (vring_need_unmap_buffer(vq)) {
> > +               if (vq->use_dma_api) {
> >                         for (j =3D 0; j < len / sizeof(struct vring_des=
c); j++)
> >                                 vring_unmap_one_split(vq, &extra[j]);
> >                 }
> > @@ -1228,7 +1225,7 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > -               if (!vring_need_unmap_buffer(vq))
> > +               if (!vring_need_unmap_buffer(vq, extra))
> >                         return;
> >
> >                 dma_unmap_page(vring_dma_dev(vq),
> > @@ -1309,7 +1306,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                         i++;
> >
> >                         if (unlikely(vq->use_dma_api)) {
> > -                               extra[i].addr =3D addr;
> > +                               extra[i].addr =3D sg_is_premapped(sg) ?=
 DMA_MAPPING_ERROR : addr;
> >                                 extra[i].len =3D sg->length;
> >                                 extra[i].flags =3D n < out_sgs ?  0 : V=
RING_DESC_F_WRITE;
> >                         }
> > @@ -1320,12 +1317,8 @@ static int virtqueue_add_indirect_packed(struct =
vring_virtqueue *vq,
> >         addr =3D vring_map_single(vq, desc,
> >                         total_sg * sizeof(struct vring_packed_desc),
> >                         DMA_TO_DEVICE);
> > -       if (vring_mapping_error(vq, addr)) {
> > -               if (vq->premapped)
> > -                       goto free_desc;
> > -
> > +       if (vring_mapping_error(vq, addr))
> >                 goto unmap_release;
> > -       }
> >
> >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> > @@ -1383,7 +1376,6 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >         for (i =3D 0; i < err_idx; i++)
> >                 vring_unmap_extra_packed(vq, &extra[i]);
> >
> > -free_desc:
> >         kfree(desc);
> >
> >         END_USE(vq);
> > @@ -1474,7 +1466,8 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
> >                         desc[i].id =3D cpu_to_le16(id);
> >
> >                         if (unlikely(vq->use_dma_api)) {
> > -                               vq->packed.desc_extra[curr].addr =3D ad=
dr;
> > +                               vq->packed.desc_extra[curr].addr =3D sg=
_is_premapped(sg) ?
> > +                                       DMA_MAPPING_ERROR : addr;
> >                                 vq->packed.desc_extra[curr].len =3D sg-=
>length;
> >                                 vq->packed.desc_extra[curr].flags =3D
> >                                         le16_to_cpu(flags);
> > @@ -1625,10 +1618,9 @@ static void detach_buf_packed(struct vring_virtq=
ueue *vq,
> >                 if (!extra)
> >                         return;
> >
> > -               if (vring_need_unmap_buffer(vq)) {
> > +               if (vq->use_dma_api) {
> >                         len =3D vq->packed.desc_extra[id].len;
> > -                       for (i =3D 0; i < len / sizeof(struct vring_pac=
ked_desc);
> > -                                       i++)
> > +                       for (i =3D 0; i < len / sizeof(struct vring_pac=
ked_desc); i++)
>
> Unnecessary changes?


Will fix.

Thanks.

>
>
> >                                 vring_unmap_extra_packed(vq, &extra[i]);
> >                 }
> >                 kfree(desc);
> > @@ -2212,6 +2204,11 @@ static inline int virtqueue_add(struct virtqueue=
 *_vq,
> >   * @data: the token identifying the buffer.
> >   * @gfp: how to do memory allocations (if necessary).
> >   *
> > + * When sg_page(sg) is NULL, this indicates that the driver has perfor=
med DMA
> > + * mapping in advance, allowing the virtio core to directly utilize
> > + * sg_dma_address(sg) without conducting any internal DMA mapping. Add=
itionally,
> > + * DMA unmap operations for this buffer will be bypassed.
> > + *
> >   * Caller must ensure we don't call this with other virtqueue operatio=
ns
> >   * at the same time (except where noted).
> >   *
> > @@ -2246,6 +2243,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> >   * @data: the token identifying the buffer.
> >   * @gfp: how to do memory allocations (if necessary).
> >   *
> > + * When sg_page(sg) is NULL, this indicates that the driver has perfor=
med DMA
> > + * mapping in advance, allowing the virtio core to directly utilize
> > + * sg_dma_address(sg) without conducting any internal DMA mapping. Add=
itionally,
> > + * DMA unmap operations for this buffer will be bypassed.
> > + *
> >   * Caller must ensure we don't call this with other virtqueue operatio=
ns
> >   * at the same time (except where noted).
> >   *
> > @@ -2268,6 +2270,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> >   * @data: the token identifying the buffer.
> >   * @gfp: how to do memory allocations (if necessary).
> >   *
> > + * When sg_page(sg) is NULL, this indicates that the driver has perfor=
med DMA
> > + * mapping in advance, allowing the virtio core to directly utilize
> > + * sg_dma_address(sg) without conducting any internal DMA mapping. Add=
itionally,
> > + * DMA unmap operations for this buffer will be bypassed.
> > + *
> >   * Caller must ensure we don't call this with other virtqueue operatio=
ns
> >   * at the same time (except where noted).
> >   *
> > @@ -2291,6 +2298,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
> >   * @ctx: extra context for the token
> >   * @gfp: how to do memory allocations (if necessary).
> >   *
> > + * When sg_page(sg) is NULL, this indicates that the driver has perfor=
med DMA
> > + * mapping in advance, allowing the virtio core to directly utilize
> > + * sg_dma_address(sg) without conducting any internal DMA mapping. Add=
itionally,
> > + * DMA unmap operations for this buffer will be bypassed.
> > + *
> >   * Caller must ensure we don't call this with other virtqueue operatio=
ns
> >   * at the same time (except where noted).
> >   *
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

