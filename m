Return-Path: <bpf+bounces-6164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C87663E8
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161401C216E4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478FBA35;
	Fri, 28 Jul 2023 06:05:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF33D86;
	Fri, 28 Jul 2023 06:05:16 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A13A8C;
	Thu, 27 Jul 2023 23:05:07 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VoOz.dW_1690524303;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VoOz.dW_1690524303)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 14:05:04 +0800
Message-ID: <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Fri, 28 Jul 2023 14:02:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
In-Reply-To: <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > > > There are NOP for non-dma so passing the dma device is harmless.
> > > >
> > > > Yes, please.
> > >
> > >
> > > I am not sure I got this fully.
> > >
> > > Are you mean this:
> > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> > >
> > > Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> > > No care the device is non-dma device or dma device.
> >
> > yes
> >
> > > Then the AF_XDP must use these virtio_dma_* APIs for virtio device.
> >
> > We'll worry about AF_XDP when the patch is posted.
>
> YES.
>
> We discussed it. They voted 'no'.
>
> http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org


Hi guys, this topic is stuck again. How should I proceed with this work?

Let me briefly summarize:
1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
the driver layer, we need to support these APIs. The current conclusion of
AF_XDP is no.

2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
driver. This idea seems to be inconsistent with the framework design of DMA. The
conclusion is no.

3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
uses DMA API. And this type of device is the future direction, so we only
support DMA premapped for this type of virtio device. The problem with this
solution is that virtqueue_dma_dev() only returns dev in some cases, because
VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
This option is currently NO.

So I'm wondering what should I do, from a DMA point of view, is there any
solution in case of using DMA API?

Thank you



>
> Thanks.
>
>
> >
> > --
> > MST
> >
>

