Return-Path: <bpf+bounces-5270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE97591C5
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5921C20E97
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A9125A3;
	Wed, 19 Jul 2023 09:39:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65672101D3
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:39:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5CE42
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689759551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cMSLw3VSpktbFnKJVT80UN55/GAkszHBQTRXo6Gr/A=;
	b=SIYhhcMI6j22YQTHUW11eDlqomn4zvhDEgDdKBJcJSlH9UxsZR2lT49sVD8DTzvmTwWjwS
	QqFzpoTd6cONOtaoSl9O6IUWJRG3jYTMTNbDhnC9XcOwI5vuYFKB1i86fxwDM06fGCm0jq
	Mc6nOITwNyqxUatqtLY/5yua2mBLKZg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-XW0EMLKONk-uNEtQHKr3eQ-1; Wed, 19 Jul 2023 05:39:09 -0400
X-MC-Unique: XW0EMLKONk-uNEtQHKr3eQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b707829eb9so61344471fa.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759548; x=1692351548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cMSLw3VSpktbFnKJVT80UN55/GAkszHBQTRXo6Gr/A=;
        b=NyUaIYWupnCJ7bjXHe6d3Olo4K4cAeTcOVmq4X0QU51mbLo5tuzeolAXrtcWhdqG8x
         dxSpITIAlPBhY9zZ3PABqRWhOqTG3gXYEPF2HJaKW6QEDtOcEUNWFO1In39RqiASzULp
         F1bgU+ptwaIJPPmRxAnsKqN7A/ZNjVy0r62x9/BrqP96W6fagki8mPIx59LnL3z9JVSH
         080MVTndisflzA27Pz961ZaQXwwgFA6jaZKwT9pg5aryggFGcMI60V77NAgPkuPImcjK
         3ch+yl3Zt62NdaGjpb1WpunQTmeFVNVBwAnf5UEvrl4ipQHN26FYAybIJ6Q/Pev5NY1q
         Ri7A==
X-Gm-Message-State: ABy/qLbmZTKx9Lx7pQD5N1iXMackp42h1kpOCxKolGfjAtccWdPP7VKD
	yjpQg+lNxAuxbY2PqM4Iae1TsSBONo8L97ZxThCpYThWxPN4Pk+Mqk7QdduF3fxeiI2vireH+r0
	jQYw5qCDiMd2xNJJDmVeDElEKubFz
X-Received: by 2002:a2e:7a01:0:b0:2b7:a64:91bd with SMTP id v1-20020a2e7a01000000b002b70a6491bdmr16878752ljc.35.1689759548319;
        Wed, 19 Jul 2023 02:39:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIFKe4/LEv8hDFl+iTa4R0UQeCWy+NzWoWMFrxGa1VAUMRaZ1gXndr+PbgoINMYdUoMriH2oPWsIhS/wWOZak=
X-Received: by 2002:a2e:7a01:0:b0:2b7:a64:91bd with SMTP id
 v1-20020a2e7a01000000b002b70a6491bdmr16878734ljc.35.1689759547862; Wed, 19
 Jul 2023 02:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1688992712.1534917-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsp0S2APzXENcK-SY8KZwu-1=w3xXNxh5kXT36EsiwaNQ@mail.gmail.com>
 <1689043238.4362252-1-xuanzhuo@linux.alibaba.com> <CACGkMEvT+o4kHSMY5_8PXFMGP3YEJkmLe3fuZ2GuektTmtLE5A@mail.gmail.com>
 <1689148498.6023948-1-xuanzhuo@linux.alibaba.com> <1689150730.075546-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu3MmM7uVToP5+gUtCKHhyn8kkSLeM-k8Fo7hLQESn8hw@mail.gmail.com>
 <1689151104.6567523-5-xuanzhuo@linux.alibaba.com> <20230714063606-mutt-send-email-mst@kernel.org>
 <1689736867.7075129-1-xuanzhuo@linux.alibaba.com> <20230719045251-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230719045251-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jul 2023 17:38:56 +0800
Message-ID: <CACGkMEtyXni=Kvk_AW+iwReAnxLjxiQexaT9AGL1fgb24SmTtg@mail.gmail.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one page
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 4:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 19, 2023 at 11:21:07AM +0800, Xuan Zhuo wrote:
> > On Fri, 14 Jul 2023 06:37:10 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Wed, Jul 12, 2023 at 04:38:24PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 12 Jul 2023 16:37:43 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Wed, Jul 12, 2023 at 4:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Wed, 12 Jul 2023 15:54:58 +0800, Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > > > > On Tue, 11 Jul 2023 10:58:51 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Jul 11, 2023 at 10:42=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 11 Jul 2023 10:36:17 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Mon, Jul 10, 2023 at 8:41=E2=80=AFPM Xuan Zhuo <xuan=
zhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 10 Jul 2023 07:59:03 -0400, "Michael S. Tsirk=
in" <mst@redhat.com> wrote:
> > > > > > > > > > > > On Mon, Jul 10, 2023 at 06:18:30PM +0800, Xuan Zhuo=
 wrote:
> > > > > > > > > > > > > On Mon, 10 Jul 2023 05:40:21 -0400, "Michael S. T=
sirkin" <mst@redhat.com> wrote:
> > > > > > > > > > > > > > On Mon, Jul 10, 2023 at 11:42:37AM +0800, Xuan =
Zhuo wrote:
> > > > > > > > > > > > > > > Currently, the virtio core will perform a dma=
 operation for each
> > > > > > > > > > > > > > > operation. Although, the same page may be ope=
rated multiple times.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The driver does the dma operation and manages=
 the dma address based the
> > > > > > > > > > > > > > > feature premapped of virtio core.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This way, we can perform only one dma operati=
on for the same page. In
> > > > > > > > > > > > > > > the case of mtu 1500, this can reduce a lot o=
f dma operations.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Tested on Aliyun g7.4large machine, in the ca=
se of a cpu 100%, pps
> > > > > > > > > > > > > > > increased from 1893766 to 1901105. An increas=
e of 0.4%.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > what kind of dma was there? an IOMMU? which ven=
dors? in which mode
> > > > > > > > > > > > > > of operation?
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Do you mean this:
> > > > > > > > > > > > >
> > > > > > > > > > > > > [    0.470816] iommu: Default domain type: Passth=
rough
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > With passthrough, dma API is just some indirect fun=
ction calls, they do
> > > > > > > > > > > > not affect the performance a lot.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Yes, this benefit is worthless. I seem to have done a=
 meaningless thing. The
> > > > > > > > > > > overhead of DMA I observed is indeed not too high.
> > > > > > > > > >
> > > > > > > > > > Have you measured with iommu=3Dstrict?
> > > > > > > > >
> > > > > > > > > I have not tested this way, our environment is pt, I wond=
er if strict is a
> > > > > > > > > common scenario. I can test it.
> > > > > > > >
> > > > > > > > It's not a common setup, but it's a way to stress DMA layer=
 to see the overhead.
> > > > > > >
> > > > > > > kernel command line: intel_iommu=3Don iommu.strict=3D1 iommu.=
passthrough=3D0
> > > > > > >
> > > > > > > virtio-net without merge dma 428614.00 pps
> > > > > > >
> > > > > > > virtio-net with merge dma    742853.00 pps
> > > > > >
> > > > > >
> > > > > > kernel command line: intel_iommu=3Don iommu.strict=3D0 iommu.pa=
ssthrough=3D0
> > > > > >
> > > > > > virtio-net without merge dma 775496.00 pps
> > > > > >
> > > > > > virtio-net with merge dma    1010514.00 pps
> > > > > >
> > > > > >
> > > > >
> > > > > Great, let's add those numbers to the changelog.
> > > >
> > > >
> > > > Yes, I will do it in next version.
> > > >
> > > >
> > > > Thanks.
> > > >
> > >
> > > You should also test without iommu but with swiotlb=3Dforce
> >
> >
> > For swiotlb, merge DMA has no benefit, because we still need to copy da=
ta from
> > swiotlb buffer to the origin buffer.
> > The benefit of the merge DMA is to reduce the operate to the iommu devi=
ce.
> >
> > I did some test for this. The result is same.
> >
> > Thanks.
> >
>
> Did you actually check that it works though?
> Looks like with swiotlb you need to synch to trigger a copy
> before unmap, and I don't see where it's done in the current
> patch.

And this is needed for XDP_REDIRECT as well.

Thanks

>
>
> >
> > >
> > > But first fix the use of DMA API to actually be correct,
> > > otherwise you are cheating by avoiding synchronization.
> > >
> > >
> > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Try e.g. bounce buffer. Which is where you will see=
 a problem: your
> > > > > > > > > > > > patches won't work.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alib=
aba.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This kind of difference is likely in the noise.
> > > > > > > > > > > > >
> > > > > > > > > > > > > It's really not high, but this is because the pro=
portion of DMA under perf top
> > > > > > > > > > > > > is not high. Probably that much.
> > > > > > > > > > > >
> > > > > > > > > > > > So maybe not worth the complexity.
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >  drivers/net/virtio_net.c | 283 +++++++++++++=
+++++++++++++++++++++++---
> > > > > > > > > > > > > > >  1 file changed, 267 insertions(+), 16 deleti=
ons(-)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drive=
rs/net/virtio_net.c
> > > > > > > > > > > > > > > index 486b5849033d..4de845d35bed 100644
> > > > > > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > > > > > @@ -126,6 +126,27 @@ static const struct virt=
net_stat_desc virtnet_rq_stats_desc[] =3D {
> > > > > > > > > > > > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(vi=
rtnet_sq_stats_desc)
> > > > > > > > > > > > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(vi=
rtnet_rq_stats_desc)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +/* The bufs on the same page may share this =
struct. */
> > > > > > > > > > > > > > > +struct virtnet_rq_dma {
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *next;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > +       u32 len;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       u32 ref;
> > > > > > > > > > > > > > > +};
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +/* Record the dma and buf. */
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I guess I see that. But why?
> > > > > > > > > > > > > > And these two comments are the extent of the av=
ailable
> > > > > > > > > > > > > > documentation, that's not enough I feel.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +struct virtnet_rq_data {
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *next;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Is manually reimplementing a linked list the be=
st
> > > > > > > > > > > > > > we can do?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, we can use llist.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma;
> > > > > > > > > > > > > > > +};
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > >  /* Internal representation of a send virtque=
ue */
> > > > > > > > > > > > > > >  struct send_queue {
> > > > > > > > > > > > > > >         /* Virtqueue associated with this sen=
d _queue */
> > > > > > > > > > > > > > > @@ -175,6 +196,13 @@ struct receive_queue {
> > > > > > > > > > > > > > >         char name[16];
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         struct xdp_rxq_info xdp_rxq;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data_array;
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data_free;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma_array;
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma_free;
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *last_dma;
> > > > > > > > > > > > > > >  };
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  /* This structure can contain rss message wi=
th maximum settings for indirection table and keysize
> > > > > > > > > > > > > > > @@ -549,6 +577,176 @@ static struct sk_buff *=
page_to_skb(struct virtnet_info *vi,
> > > > > > > > > > > > > > >         return skb;
> > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +static void virtnet_rq_unmap(struct receive_=
queue *rq, struct virtnet_rq_dma *dma)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct device *dev;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       --dma->ref;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       if (dma->ref)
> > > > > > > > > > > > > > > +               return;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If you don't unmap there is no guarantee valid =
data will be
> > > > > > > > > > > > > > there in the buffer.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dma_unmap_page(dev, dma->addr, dma->l=
en, DMA_FROM_DEVICE);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dma->next =3D rq->dma_free;
> > > > > > > > > > > > > > > +       rq->dma_free =3D dma;
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static void *virtnet_rq_recycle_data(struct =
receive_queue *rq,
> > > > > > > > > > > > > > > +                                    struct v=
irtnet_rq_data *data)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       buf =3D data->buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       data->next =3D rq->data_free;
> > > > > > > > > > > > > > > +       rq->data_free =3D data;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return buf;
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static struct virtnet_rq_data *virtnet_rq_ge=
t_data(struct receive_queue *rq,
> > > > > > > > > > > > > > > +                                            =
      void *buf,
> > > > > > > > > > > > > > > +                                            =
      struct virtnet_rq_dma *dma)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       data =3D rq->data_free;
> > > > > > > > > > > > > > > +       rq->data_free =3D data->next;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       data->buf =3D buf;
> > > > > > > > > > > > > > > +       data->dma =3D dma;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return data;
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static void *virtnet_rq_get_buf(struct recei=
ve_queue *rq, u32 *len, void **ctx)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       buf =3D virtqueue_get_buf_ctx(rq->vq,=
 len, ctx);
> > > > > > > > > > > > > > > +       if (!buf || !rq->data_array)
> > > > > > > > > > > > > > > +               return buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       data =3D buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return virtnet_rq_recycle_data(rq, da=
ta);
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static void *virtnet_rq_detach_unused_buf(st=
ruct receive_queue *rq)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       buf =3D virtqueue_detach_unused_buf(r=
q->vq);
> > > > > > > > > > > > > > > +       if (!buf || !rq->data_array)
> > > > > > > > > > > > > > > +               return buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       data =3D buf;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return virtnet_rq_recycle_data(rq, da=
ta);
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static int virtnet_rq_map_sg(struct receive_=
queue *rq, void *buf, u32 len)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma =3D rq->la=
st_dma;
> > > > > > > > > > > > > > > +       struct device *dev;
> > > > > > > > > > > > > > > +       u32 off, map_len;
> > > > > > > > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > > > > > > > +       void *end;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       if (likely(dma) && buf >=3D dma->buf =
&& (buf + len <=3D dma->buf + dma->len)) {
> > > > > > > > > > > > > > > +               ++dma->ref;
> > > > > > > > > > > > > > > +               addr =3D dma->addr + (buf - d=
ma->buf);
> > > > > > > > > > > > > > > +               goto ok;
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So this is the meat of the proposed optimizatio=
n. I guess that
> > > > > > > > > > > > > > if the last buffer we allocated happens to be i=
n the same page
> > > > > > > > > > > > > > as this one then they can both be mapped for DM=
A together.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Since we use page_frag, the buffers we allocated =
are all continuous.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Why last one specifically? Whether next one hap=
pens to
> > > > > > > > > > > > > > be close depends on luck. If you want to try op=
timizing this
> > > > > > > > > > > > > > the right thing to do is likely by using a page=
 pool.
> > > > > > > > > > > > > > There's actually work upstream on page pool, lo=
ok it up.
> > > > > > > > > > > > >
> > > > > > > > > > > > > As we discussed in another thread, the page pool =
is first used for xdp. Let's
> > > > > > > > > > > > > transform it step by step.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > > ok so this should wait then?
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       end =3D buf + len - 1;
> > > > > > > > > > > > > > > +       off =3D offset_in_page(end);
> > > > > > > > > > > > > > > +       map_len =3D len + PAGE_SIZE - off;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       addr =3D dma_map_page_attrs(dev, virt=
_to_page(buf), offset_in_page(buf),
> > > > > > > > > > > > > > > +                                 map_len, DM=
A_FROM_DEVICE, 0);
> > > > > > > > > > > > > > > +       if (addr =3D=3D DMA_MAPPING_ERROR)
> > > > > > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dma =3D rq->dma_free;
> > > > > > > > > > > > > > > +       rq->dma_free =3D dma->next;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       dma->ref =3D 1;
> > > > > > > > > > > > > > > +       dma->buf =3D buf;
> > > > > > > > > > > > > > > +       dma->addr =3D addr;
> > > > > > > > > > > > > > > +       dma->len =3D map_len;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       rq->last_dma =3D dma;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +ok:
> > > > > > > > > > > > > > > +       sg_init_table(rq->sg, 1);
> > > > > > > > > > > > > > > +       rq->sg[0].dma_address =3D addr;
> > > > > > > > > > > > > > > +       rq->sg[0].length =3D len;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +static int virtnet_rq_merge_map_init(struct =
virtnet_info *vi)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +       struct receive_queue *rq;
> > > > > > > > > > > > > > > +       int i, err, j, num;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       /* disable for big mode */
> > > > > > > > > > > > > > > +       if (!vi->mergeable_rx_bufs && vi->big=
_packets)
> > > > > > > > > > > > > > > +               return 0;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       for (i =3D 0; i < vi->max_queue_pairs=
; i++) {
> > > > > > > > > > > > > > > +               err =3D virtqueue_set_premapp=
ed(vi->rq[i].vq);
> > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > +                       continue;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               rq =3D &vi->rq[i];
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               num =3D virtqueue_get_vring_s=
ize(rq->vq);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               rq->data_array =3D kmalloc_ar=
ray(num, sizeof(*rq->data_array), GFP_KERNEL);
> > > > > > > > > > > > > > > +               if (!rq->data_array)
> > > > > > > > > > > > > > > +                       goto err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               rq->dma_array =3D kmalloc_arr=
ay(num, sizeof(*rq->dma_array), GFP_KERNEL);
> > > > > > > > > > > > > > > +               if (!rq->dma_array)
> > > > > > > > > > > > > > > +                       goto err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               for (j =3D 0; j < num; ++j) {
> > > > > > > > > > > > > > > +                       rq->data_array[j].nex=
t =3D rq->data_free;
> > > > > > > > > > > > > > > +                       rq->data_free =3D &rq=
->data_array[j];
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +                       rq->dma_array[j].next=
 =3D rq->dma_free;
> > > > > > > > > > > > > > > +                       rq->dma_free =3D &rq-=
>dma_array[j];
> > > > > > > > > > > > > > > +               }
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +err:
> > > > > > > > > > > > > > > +       for (i =3D 0; i < vi->max_queue_pairs=
; i++) {
> > > > > > > > > > > > > > > +               struct receive_queue *rq;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               rq =3D &vi->rq[i];
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               kfree(rq->dma_array);
> > > > > > > > > > > > > > > +               kfree(rq->data_array);
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return -ENOMEM;
> > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > >  static void free_old_xmit_skbs(struct send_q=
ueue *sq, bool in_napi)
> > > > > > > > > > > > > > >  {
> > > > > > > > > > > > > > >         unsigned int len;
> > > > > > > > > > > > > > > @@ -835,7 +1033,7 @@ static struct page *xdp_=
linearize_page(struct receive_queue *rq,
> > > > > > > > > > > > > > >                 void *buf;
> > > > > > > > > > > > > > >                 int off;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -               buf =3D virtqueue_get_buf(rq-=
>vq, &buflen);
> > > > > > > > > > > > > > > +               buf =3D virtnet_rq_get_buf(rq=
, &buflen, NULL);
> > > > > > > > > > > > > > >                 if (unlikely(!buf))
> > > > > > > > > > > > > > >                         goto err_buf;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > @@ -1126,7 +1324,7 @@ static int virtnet_buil=
d_xdp_buff_mrg(struct net_device *dev,
> > > > > > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         while (--*num_buf > 0) {
> > > > > > > > > > > > > > > -               buf =3D virtqueue_get_buf_ctx=
(rq->vq, &len, &ctx);
> > > > > > > > > > > > > > > +               buf =3D virtnet_rq_get_buf(rq=
, &len, &ctx);
> > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > >                         pr_debug("%s: rx erro=
r: %d buffers out of %d missing\n",
> > > > > > > > > > > > > > >                                  dev->name, *=
num_buf,
> > > > > > > > > > > > > > > @@ -1351,7 +1549,7 @@ static struct sk_buff *=
receive_mergeable(struct net_device *dev,
> > > > > > > > > > > > > > >         while (--num_buf) {
> > > > > > > > > > > > > > >                 int num_skb_frags;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -               buf =3D virtqueue_get_buf_ctx=
(rq->vq, &len, &ctx);
> > > > > > > > > > > > > > > +               buf =3D virtnet_rq_get_buf(rq=
, &len, &ctx);
> > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > >                         pr_debug("%s: rx erro=
r: %d buffers out of %d missing\n",
> > > > > > > > > > > > > > >                                  dev->name, n=
um_buf,
> > > > > > > > > > > > > > > @@ -1414,7 +1612,7 @@ static struct sk_buff *=
receive_mergeable(struct net_device *dev,
> > > > > > > > > > > > > > >  err_skb:
> > > > > > > > > > > > > > >         put_page(page);
> > > > > > > > > > > > > > >         while (num_buf-- > 1) {
> > > > > > > > > > > > > > > -               buf =3D virtqueue_get_buf(rq-=
>vq, &len);
> > > > > > > > > > > > > > > +               buf =3D virtnet_rq_get_buf(rq=
, &len, NULL);
> > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > >                         pr_debug("%s: rx erro=
r: %d buffers missing\n",
> > > > > > > > > > > > > > >                                  dev->name, n=
um_buf);
> > > > > > > > > > > > > > > @@ -1529,6 +1727,7 @@ static int add_recvbuf_=
small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > > > > > > > > >         unsigned int xdp_headroom =3D virtnet=
_get_headroom(vi);
> > > > > > > > > > > > > > >         void *ctx =3D (void *)(unsigned long)=
xdp_headroom;
> > > > > > > > > > > > > > >         int len =3D vi->hdr_len + VIRTNET_RX_=
PAD + GOOD_PACKET_LEN + xdp_headroom;
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > >         int err;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > > > > > > > > > > > @@ -1539,11 +1738,34 @@ static int add_recvbu=
f_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > > > > > > > > >         buf =3D (char *)page_address(alloc_fr=
ag->page) + alloc_frag->offset;
> > > > > > > > > > > > > > >         get_page(alloc_frag->page);
> > > > > > > > > > > > > > >         alloc_frag->offset +=3D len;
> > > > > > > > > > > > > > > -       sg_init_one(rq->sg, buf + VIRTNET_RX_=
PAD + xdp_headroom,
> > > > > > > > > > > > > > > -                   vi->hdr_len + GOOD_PACKET=
_LEN);
> > > > > > > > > > > > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->v=
q, rq->sg, 1, buf, ctx, gfp);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > +               err =3D virtnet_rq_map_sg(rq,=
 buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > > > > > > > > > > > +                                       vi->h=
dr_len + GOOD_PACKET_LEN);
> > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > +                       goto map_err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               data =3D virtnet_rq_get_data(=
rq, buf, rq->last_dma);
> > > > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > > > +               sg_init_one(rq->sg, buf + VIR=
TNET_RX_PAD + xdp_headroom,
> > > > > > > > > > > > > > > +                           vi->hdr_len + GOO=
D_PACKET_LEN);
> > > > > > > > > > > > > > > +               data =3D (void *)buf;
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->v=
q, rq->sg, 1, data, ctx, gfp);
> > > > > > > > > > > > > > >         if (err < 0)
> > > > > > > > > > > > > > > -               put_page(virt_to_head_page(bu=
f));
> > > > > > > > > > > > > > > +               goto add_err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +add_err:
> > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > +               virtnet_rq_unmap(rq, data->dm=
a);
> > > > > > > > > > > > > > > +               virtnet_rq_recycle_data(rq, d=
ata);
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +map_err:
> > > > > > > > > > > > > > > +       put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > >         return err;
> > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > @@ -1620,6 +1842,7 @@ static int add_recvbuf_=
mergeable(struct virtnet_info *vi,
> > > > > > > > > > > > > > >         unsigned int headroom =3D virtnet_get=
_headroom(vi);
> > > > > > > > > > > > > > >         unsigned int tailroom =3D headroom ? =
sizeof(struct skb_shared_info) : 0;
> > > > > > > > > > > > > > >         unsigned int room =3D SKB_DATA_ALIGN(=
headroom + tailroom);
> > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > >         char *buf;
> > > > > > > > > > > > > > >         void *ctx;
> > > > > > > > > > > > > > >         int err;
> > > > > > > > > > > > > > > @@ -1650,12 +1873,32 @@ static int add_recvbu=
f_mergeable(struct virtnet_info *vi,
> > > > > > > > > > > > > > >                 alloc_frag->offset +=3D hole;
> > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -       sg_init_one(rq->sg, buf, len);
> > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > +               err =3D virtnet_rq_map_sg(rq,=
 buf, len);
> > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > +                       goto map_err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               data =3D virtnet_rq_get_data(=
rq, buf, rq->last_dma);
> > > > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > > > +               sg_init_one(rq->sg, buf, len)=
;
> > > > > > > > > > > > > > > +               data =3D (void *)buf;
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > >         ctx =3D mergeable_len_to_ctx(len + ro=
om, headroom);
> > > > > > > > > > > > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->v=
q, rq->sg, 1, buf, ctx, gfp);
> > > > > > > > > > > > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->v=
q, rq->sg, 1, data, ctx, gfp);
> > > > > > > > > > > > > > >         if (err < 0)
> > > > > > > > > > > > > > > -               put_page(virt_to_head_page(bu=
f));
> > > > > > > > > > > > > > > +               goto add_err;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +add_err:
> > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > +               virtnet_rq_unmap(rq, data->dm=
a);
> > > > > > > > > > > > > > > +               virtnet_rq_recycle_data(rq, d=
ata);
> > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +map_err:
> > > > > > > > > > > > > > > +       put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > >         return err;
> > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > @@ -1775,13 +2018,13 @@ static int virtnet_re=
ceive(struct receive_queue *rq, int budget,
> > > > > > > > > > > > > > >                 void *ctx;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >                 while (stats.packets < budget=
 &&
> > > > > > > > > > > > > > > -                      (buf =3D virtqueue_get=
_buf_ctx(rq->vq, &len, &ctx))) {
> > > > > > > > > > > > > > > +                      (buf =3D virtnet_rq_ge=
t_buf(rq, &len, &ctx))) {
> > > > > > > > > > > > > > >                         receive_buf(vi, rq, b=
uf, len, ctx, xdp_xmit, &stats);
> > > > > > > > > > > > > > >                         stats.packets++;
> > > > > > > > > > > > > > >                 }
> > > > > > > > > > > > > > >         } else {
> > > > > > > > > > > > > > >                 while (stats.packets < budget=
 &&
> > > > > > > > > > > > > > > -                      (buf =3D virtqueue_get=
_buf(rq->vq, &len)) !=3D NULL) {
> > > > > > > > > > > > > > > +                      (buf =3D virtnet_rq_ge=
t_buf(rq, &len, NULL)) !=3D NULL) {
> > > > > > > > > > > > > > >                         receive_buf(vi, rq, b=
uf, len, NULL, xdp_xmit, &stats);
> > > > > > > > > > > > > > >                         stats.packets++;
> > > > > > > > > > > > > > >                 }
> > > > > > > > > > > > > > > @@ -3514,6 +3757,9 @@ static void virtnet_fre=
e_queues(struct virtnet_info *vi)
> > > > > > > > > > > > > > >         for (i =3D 0; i < vi->max_queue_pairs=
; i++) {
> > > > > > > > > > > > > > >                 __netif_napi_del(&vi->rq[i].n=
api);
> > > > > > > > > > > > > > >                 __netif_napi_del(&vi->sq[i].n=
api);
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               kfree(vi->rq[i].data_array);
> > > > > > > > > > > > > > > +               kfree(vi->rq[i].dma_array);
> > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         /* We called __netif_napi_del(),
> > > > > > > > > > > > > > > @@ -3591,9 +3837,10 @@ static void free_unuse=
d_bufs(struct virtnet_info *vi)
> > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         for (i =3D 0; i < vi->max_queue_pairs=
; i++) {
> > > > > > > > > > > > > > > -               struct virtqueue *vq =3D vi->=
rq[i].vq;
> > > > > > > > > > > > > > > -               while ((buf =3D virtqueue_det=
ach_unused_buf(vq)) !=3D NULL)
> > > > > > > > > > > > > > > -                       virtnet_rq_free_unuse=
d_buf(vq, buf);
> > > > > > > > > > > > > > > +               struct receive_queue *rq =3D =
&vi->rq[i];
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +               while ((buf =3D virtnet_rq_de=
tach_unused_buf(rq)) !=3D NULL)
> > > > > > > > > > > > > > > +                       virtnet_rq_free_unuse=
d_buf(rq->vq, buf);
> > > > > > > > > > > > > > >                 cond_resched();
> > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > @@ -3767,6 +4014,10 @@ static int init_vqs(st=
ruct virtnet_info *vi)
> > > > > > > > > > > > > > >         if (ret)
> > > > > > > > > > > > > > >                 goto err_free;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +       ret =3D virtnet_rq_merge_map_init(vi)=
;
> > > > > > > > > > > > > > > +       if (ret)
> > > > > > > > > > > > > > > +               goto err_free;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > >         cpus_read_lock();
> > > > > > > > > > > > > > >         virtnet_set_affinity(vi);
> > > > > > > > > > > > > > >         cpus_read_unlock();
> > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
>


