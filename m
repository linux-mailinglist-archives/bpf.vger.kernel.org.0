Return-Path: <bpf+bounces-7208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C3773724
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 04:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E429281493
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5C1367;
	Tue,  8 Aug 2023 02:52:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8DC397;
	Tue,  8 Aug 2023 02:52:20 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71A19AF;
	Mon,  7 Aug 2023 19:52:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpJJxIS_1691463117;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpJJxIS_1691463117)
          by smtp.aliyun-inc.com;
          Tue, 08 Aug 2023 10:51:58 +0800
Message-ID: <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 8 Aug 2023 10:47:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
In-Reply-To: <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 8 Aug 2023 10:26:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> > > On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> > > > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
> > > > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@=
infradead.org> wrote:
> > > > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsir=
kin wrote:
> > > > > > > > > > Well I think we can add wrappers like virtio_dma_sync a=
nd so on.
> > > > > > > > > > There are NOP for non-dma so passing the dma device is =
harmless.
> > > > > > > > >
> > > > > > > > > Yes, please.
> > > > > > > >
> > > > > > > >
> > > > > > > > I am not sure I got this fully.
> > > > > > > >
> > > > > > > > Are you mean this:
> > > > > > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhu=
o@linux.alibaba.com/
> > > > > > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhu=
o@linux.alibaba.com/
> > > > > > > >
> > > > > > > > Then the driver must do dma operation(map and sync) by thes=
e virtio_dma_* APIs.
> > > > > > > > No care the device is non-dma device or dma device.
> > > > > > >
> > > > > > > yes
> > > > > > >
> > > > > > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio=
 device.
> > > > > > >
> > > > > > > We'll worry about AF_XDP when the patch is posted.
> > > > > >
> > > > > > YES.
> > > > > >
> > > > > > We discussed it. They voted 'no'.
> > > > > >
> > > > > > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> > > > >
> > > > >
> > > > > Hi guys, this topic is stuck again. How should I proceed with thi=
s work?
> > > > >
> > > > > Let me briefly summarize:
> > > > > 1. The problem with adding virtio_dma_{map, sync} api is that, fo=
r AF_XDP and
> > > > > the driver layer, we need to support these APIs. The current conc=
lusion of
> > > > > AF_XDP is no.
> > > > >
> > > > > 2. Set dma_set_mask_and_coherent, then we can use DMA API uniform=
ly inside
> > > > > driver. This idea seems to be inconsistent with the framework des=
ign of DMA. The
> > > > > conclusion is no.
> > > > >
> > > > > 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_=
PLATFORM, it
> > > > > uses DMA API. And this type of device is the future direction, so=
 we only
> > > > > support DMA premapped for this type of virtio device. The problem=
 with this
> > > > > solution is that virtqueue_dma_dev() only returns dev in some cas=
es, because
> > > > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases.
>
> Could you explain the issue a little bit more?
>
> E.g if we limit AF_XDP to ACESS_PLATFROM only, why does
> virtqueue_dma_dev() only return dev in some cases?

The behavior of virtqueue_dma_dev() is not related to AF_XDP.

The return value of virtqueue_dma_dev() is used for the DMA APIs. So it can
return dma dev when the virtio is with ACCESS_PLATFORM. If virtio is without
ACCESS_PLATFORM then it MUST return NULL.

In the virtio-net driver, if the virtqueue_dma_dev() returns dma dev,
we can enable AF_XDP. If not, we return error to AF_XDP.

Thanks




>
> Thanks
>
> >Otherwise NULL is returned.
> > > > > This option is currently NO.
> > > > >
> > > > > So I'm wondering what should I do, from a DMA point of view, is t=
here any
> > > > > solution in case of using DMA API?
> > > > >
> > > > > Thank you
> > > >
> > > >
> > > > I think it's ok at this point, Christoph just asked you
> > > > to add wrappers for map/unmap for use in virtio code.
> > > > Seems like a cosmetic change, shouldn't be hard.
> > >
> > > Yes, that is not hard, I has this code.
> > >
> > > But, you mean that the wrappers is just used for the virtio driver co=
de?
> > > And we also offer the  API virtqueue_dma_dev() at the same time?
> > > Then the driver will has two chooses to do DMA.
> > >
> > > Is that so?
> >
> > Ping.
> >
> > Thanks
> >
> > >
> > >
> > > > Otherwise I haven't seen significant comments.
> > > >
> > > >
> > > > Christoph do I summarize what you are saying correctly?
> > > > --
> > > > MST
> > > >
> > >
> >
>

