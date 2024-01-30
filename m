Return-Path: <bpf+bounces-20673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09135841A72
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D97E1C214D6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2426381A0;
	Tue, 30 Jan 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kONvruD6"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98F381A4;
	Tue, 30 Jan 2024 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584925; cv=none; b=HJkJnggjkTyrdvdA46bKTWvpL/jHEm1na+CWW2690aUPVR7xCQTKhOt4f9l3HEkuVCdG6BxAWaHdvQo2pRh+XHtU3sUnoywPFhys50v4GbG2jQe0A5lxTFOMSOw2kPcu0anbIm2caWqtDeMmZu8e2hhFTXYxDmoaHHYgOPUsEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584925; c=relaxed/simple;
	bh=iXy2dS2DfwRCUUvL1SR6tJI+B9xsan6Xg5tyusY2fwU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=l4ruzc/3dzzYje+Xj1hfpoqxADxl1ka+72yfBhhnlLYhzKphFz1vJNL/TxKunzBo22ZWYptwgmLdm1X0geDi5SnErtMs15+mu0BuSqgd0E3KA0Y0MCHbVAaUtf6Nbz8fzvxiBcfqW8hyDGMlvff4w0ay3EDX8ORp7YV8uciiRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kONvruD6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706584920; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ZD2yvpKQc8CSoOhH3o/udhKZEK9aYQNGxyzrBuqEtJw=;
	b=kONvruD6xks/hv95DymGRusNNeI75jUcYojdZsqSOfV98jIl9QxVlDNO/WW4Jcba9gh5ewv0sX5Ina58xKpmK1u0+vs4ahF33536QaDQ7B5JU8muZBnB4Lx6P4IJyOA50hJHLfufufDI9k2RzlGDiKWT0U2aRRrA/ROSeT7PzqY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.eeHq-_1706584918;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.eeHq-_1706584918)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:21:59 +0800
Message-ID: <1706584507.0804718-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: sq support premapped mode
Date: Tue, 30 Jan 2024 11:15:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
 <1706162331.1486428-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvk7eiq6HKzoqHqmQ0DTuK-3tbc5r5rro1unyKYM61mMg@mail.gmail.com>
 <1706497888.0777724-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsAx=VTOcxdTR555ZVVdmx57o5qr=t+kNQO1u-RM4Dspw@mail.gmail.com>
In-Reply-To: <CACGkMEsAx=VTOcxdTR555ZVVdmx57o5qr=t+kNQO1u-RM4Dspw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 30 Jan 2024 10:56:25 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 29, 2024 at 11:28=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Mon, 29 Jan 2024 11:06:35 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Jan 25, 2024 at 2:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 25 Jan 2024 11:39:20 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > >
> > > > > Any reason for this? Technically, virtio-net can work as other NIC
> > > > > like 256 queues. There could be some work like optimizing the
> > > > > interrupt allocations etc.
> > > >
> > > > Just like the logic of XDP_TX.
> > > >
> > > > Now the virtio spec does not allow to add new dynamic queues.
> > > > As I know, most hypervisors just support few queues.
> > >
> > > When multiqueue is developed in Qemu, it support as least 256 queue
> > > pairs if my memory is correct.
> > >
> >
> >
> > YES, but that is configured by the hypervisor.
> >
> > For the user on any platform, when he got a vm, the queue num is fixed.
> > As I know, on most case, the num is less.
> > If we want the af-xdp/xdp-tx has the the independent queues
> > I think the dynamic queue is good way.
>
> Yes, we can start from this.


My plan is start from sharing send queues.

After that I will push the dynamic queues rfc to the virtio spec.

If the new feature is negotiated, then we can support xdp/af-xdp
with independent send queues, if the feature is not supported,
xdp/af-xdp can work with sharing send queue.

I think that will not conflict.


>
> >
> >
> > > > The num of
> > > > queues is not bigger than the cpu num. So the best way is
> > > > to share the send queues.
> > > >
> > > > Parav and I tried to introduce dynamic queues.
> > >
> > > Virtio-net doesn't differ from real NIC where most of them can create
> > > queue dynamically. It's more about the resource allocation, if mgmt
> > > can start with 256 queues, then we probably fine.
> >
> > But now, if the devices has 256, we will enable the 256 queues by defau=
lt.
> > that is too much.
>
> It doesn't differ from the other NIC. E.g currently the active #qps is
> determined by the number of cpus. this is only true if we have 256
> cpus.


YES. But now, the normal devices just have few queues (such as 8, 32).

Thanks.


>
> >
> > So, the dynamic queue is not to create a new queue out of the resource.
> >
> > The device may tell the driver, the max queue resource is 256,
> > but let we start from 8. If the driver need more, then we can
> > enable more.
>
> This is the policy we used now.
>
> >
> > But for me, the xdp tx can share the sq queue, so let we start
> > the af-xdp from sharing sq queue.
> >
> >
> > >
> > > But I think we can leave this question now.
> > >
> > > > But that is dropped.
> > > > Before that I think we can share the send queues.
> > > >
> > > >
> > > > >
> > > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > > So the send queue must support premapped mode.
> > > > > >
> > > > > > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0=
.123 -m 00:16:3e:12:e1:3e -n 0 -p 100
> > > > > > machine:  ecs.ebmg6e.26xlarge of Aliyun
> > > > > > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > > > > > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> > > > > >
> > > > > >                       |        iommu off           |        iom=
mu on
> > > > > > ----------------------|----------------------------------------=
-------------
> > > > > >                       | 16         |  1400         | 16        =
 | 1400
> > > > > > ----------------------|----------------------------------------=
-------------
> > > > > > Before:               |1716796.00  |  1581829.00   | 390756.00 =
 | 374493.00
> > > > > > After(premapped off): |1733794.00  |  1576259.00   | 390189.00 =
 | 378128.00
> > > > > > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00 =
 | 373584.00
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++=
++++----
> > > > > >  drivers/net/virtio/virtio_net.h |  10 ++-
> > > > > >  2 files changed, 116 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/mai=
n.c
> > > > > > index 4fbf612da235..53143f95a3a0 100644
> > > > > > --- a/drivers/net/virtio/main.c
> > > > > > +++ b/drivers/net/virtio/main.c
> > > > > > @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void =
*ptr)
> > > > > >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTI=
O_XDP_FLAG);
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct=
 virtio_dma_head *dma)
> > > > > > +{
> > > > > > +       int i;
> > > > > > +
> > > > > > +       if (!dma)
> > > > > > +               return;
> > > > > > +
> > > > > > +       for (i =3D 0; i < dma->next; ++i)
> > > > > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > > > > +                                                dma->items[i].=
addr,
> > > > > > +                                                dma->items[i].=
length,
> > > > > > +                                                DMA_TO_DEVICE,=
 0);
> > > > > > +       dma->next =3D 0;
> > > > > > +}
> > > > > > +
> > > > > >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_nap=
i,
> > > > > >                             u64 *bytes, u64 *packets)
> > > > > >  {
> > > > > > +       struct virtio_dma_head *dma;
> > > > > >         unsigned int len;
> > > > > >         void *ptr;
> > > > > >
> > > > > > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D N=
ULL) {
> > > > > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > > >
> > > > > Any chance this.can be false?
> > > >
> > > > __free_old_xmit is the common path.
> > >
> > > Did you mean the XDP path doesn't work with this? If yes, we need to
> > > change that.
> >
> >
> > NO. If the virtio core use_dma_api is false, the dma premapped
> > can not be ture.
>
> Ok, I see.
>
> >
> > >
> > > >
> > > > The virtqueue_get_dma_premapped() is used to check whether the sq i=
s premapped
> > > > mode.
> > > >
> > > > >
> > > > > > +               dma =3D &sq->dma.head;
> > > > > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > > > > +               dma->next =3D 0;
> > > > >
> > > > > Btw, I found in the case of RX we have:
> > > > >
> > > > > virtnet_rq_alloc():
> > > > >
> > > > >                         alloc_frag->offset =3D sizeof(*dma);
> > > > >
> > > > > This seems to defeat frag coalescing when the memory is highly
> > > > > fragmented or high order allocation is disallowed.
> > > > >
> > > > > Any idea to solve this?
> > > >
> > > >
> > > > On the rq premapped pathset, I answered this.
> > > >
> > > > http://lore.kernel.org/all/1692156147.7470396-3-xuanzhuo@linux.alib=
aba.com
> > >
> > > Oops, I forget that.
> > >
> > > >
> > > > >
> > > > > > +       } else {
> > > > > > +               dma =3D NULL;
> > > > > > +       }
> > > > > > +
> > > > > > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len,=
 dma, NULL)) !=3D NULL) {
> > > > > > +               virtnet_sq_unmap_buf(sq, dma);
> > > > > > +
> > > > > >                 if (!is_xdp_frame(ptr)) {
> > > > > >                         struct sk_buff *skb =3D ptr;
> > > > > >
> > > > > > @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virt=
net_rq *rq, u32 size, gfp_t gfp)
> > > > > >         return buf;
> > > > > >  }
> > > > > >
> > > > > > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > > > > > +static void virtnet_set_premapped(struct virtnet_info *vi)
> > > > > >  {
> > > > > >         int i;
> > > > > >
> > > > > > -       /* disable for big mode */
> > > > > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > > -               return;
> > > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> > > > > >
> > > > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > > > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > > > +               /* TODO for big mode */
> > > > >
> > > > > Btw, how hard to support big mode? If we can do premapping for th=
at
> > > > > code could be simplified.
> > > > >
> > > > > (There are vendors that doesn't support mergeable rx buffers).
> > > >
> > > > I will do that after these patch-sets
> > >
> > > If it's not too hard, I'd suggest to do it now.
> >
> >
> > YES. Is not too hard, but I was doing too much.
> >
> > * virtio-net + device stats
> > * virtio-net + af-xdp, this patch set has about 27 commits
> >
> > And I was pushing this too long, I just want to finish the work.
> > Then I can work on the next (premapped big mode, af-xdp multi-buf....).
> >
> > So, let we step by step.
>
> That's fine.
>
> Thanks
>

