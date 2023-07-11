Return-Path: <bpf+bounces-4713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE174E527
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C49E1C20C9E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262E3D6E;
	Tue, 11 Jul 2023 03:13:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEF210B;
	Tue, 11 Jul 2023 03:13:16 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22223EA;
	Mon, 10 Jul 2023 20:13:13 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vn6n-l6_1689045189;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vn6n-l6_1689045189)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 11:13:09 +0800
Message-ID: <1689045049.360526-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt coalescing support
Date: Tue, 11 Jul 2023 11:10:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 ast@kernel.org,
 daniel@iogearbox.net,
 hawk@kernel.org,
 john.fastabend@gmail.com,
 jiri@nvidia.com,
 dtatulea@nvidia.com,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <1688981109.6377137-1-xuanzhuo@linux.alibaba.com>
 <ea32a1cf-3a77-d63b-034f-0f80d2dd80ea@nvidia.com>
In-Reply-To: <ea32a1cf-3a77-d63b-034f-0f80d2dd80ea@nvidia.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 11 Jul 2023 10:34:33 +0800, Gavin Li <gavinl@nvidia.com> wrote:
>
> On 7/10/2023 5:25 PM, Xuan Zhuo wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 10 Jul 2023 12:20:01 +0300, Gavin Li <gavinl@nvidia.com> wrote:
> >
> > As far as I know, Heng Qi does that. I'm not sure, it's the same piece.
> >
> > cc @Heng Qi
> >
> > Thanks.
> Do you mean the one below?

YES


>
> https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>
> The code is to implement what it described and I don't have better
> words. So, I copied the text from Heng Qi's.

Maybe he wrote code for it. I think you should ask him about his plans first.

Thanks.


>
> >
> >
> >> Currently, coalescing parameters are grouped for all transmit and receive
> >> virtqueues. This patch series add support to set or get the parameters for
> >> a specified virtqueue.
> >>
> >> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> >> is busy and another virtqueue is idle, then it will be very useful to
> >> control coalescing parameters at the virtqueue granularity.
> >>
> >> Example command:
> >> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> >> Would set max_packets=10 to VQ 1.
> >> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> >> Would set max_packets=10 to VQ 0.
> >> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> >>   Queue: 0
> >>   Adaptive RX: off  TX: off
> >>   stats-block-usecs: 0
> >>   sample-interval: 0
> >>   pkt-rate-low: 0
> >>   pkt-rate-high: 0
> >>
> >>   rx-usecs: 222
> >>   rx-frames: 0
> >>   rx-usecs-irq: 0
> >>   rx-frames-irq: 256
> >>
> >>   tx-usecs: 222
> >>   tx-frames: 0
> >>   tx-usecs-irq: 0
> >>   tx-frames-irq: 256
> >>
> >>   rx-usecs-low: 0
> >>   rx-frame-low: 0
> >>   tx-usecs-low: 0
> >>   tx-frame-low: 0
> >>
> >>   rx-usecs-high: 0
> >>   rx-frame-high: 0
> >>   tx-usecs-high: 0
> >>   tx-frame-high: 0
> >>
> >> In this patch series:
> >> Patch-1: Extract interrupt coalescing settings to a structure.
> >> Patch-2: Extract get/set interrupt coalesce to a function.
> >> Patch-3: Support per queue interrupt coalesce command.
> >> Patch-4: Enable per queue interrupt coalesce feature.
> >>
> >> Gavin Li (4):
> >>    virtio_net: extract interrupt coalescing settings to a structure
> >>    virtio_net: extract get/set interrupt coalesce to a function
> >>    virtio_net: support per queue interrupt coalesce command
> >>    virtio_net: enable per queue interrupt coalesce feature
> >>
> >>   drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> >>   include/uapi/linux/virtio_net.h |  14 +++
> >>   2 files changed, 154 insertions(+), 29 deletions(-)
> >>
> >> --
> >> 2.39.1
> >>

