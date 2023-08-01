Return-Path: <bpf+bounces-6510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9D76A6F4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE321C20DDC
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BA1107;
	Tue,  1 Aug 2023 02:27:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEC7E;
	Tue,  1 Aug 2023 02:27:39 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674210DD;
	Mon, 31 Jul 2023 19:27:35 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VojLbbu_1690856850;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VojLbbu_1690856850)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:27:31 +0800
Message-ID: <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 1 Aug 2023 10:03:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel  Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
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
 <20230728080305.5fe3737c@kernel.org>
 <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
 <20230731084651.16ec0a96@kernel.org>
In-Reply-To: <20230731084651.16ec0a96@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 31 Jul 2023 08:46:51 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 31 Jul 2023 09:23:29 +0800 Jason Wang wrote:
> > > I'd step back and ask you why do you want to use AF_XDP with virtio.
> > > Instead of bifurcating one virtio instance into different queues why
> > > not create a separate virtio instance?
> >
> > I'm not sure I get this, but do you mean a separate virtio device that
> > owns AF_XDP queues only? If I understand it correctly, bifurcating is
> > one of the key advantages of AF_XDP. What's more, current virtio
> > doesn't support being split at queue (pair) level. And it may still
> > suffer from the yes/no DMA API issue.
>
> I guess we should step even further back and ask Xuan what the use case
> is, because I'm not very sure. All we hear is "enable AF_XDP on virtio"
> but AF_XDP is barely used on real HW, so why?


Why just for real HW?

I want to enable AF_XDP on virtio-net. Then the user can send/recv packets by
AF_XDP bypass through the kernel. That has be used on large scale.

I donot know what is the problem of the virtio-net.
Why do you think that the virtio-net cannot work with AF_XDP?


>
> Bifurcating makes (used to make?) some sense in case of real HW when you
> had only one PCI function and had to subdivide it.

Sorry I do not get this.


> Virtio is either a SW
> construct or offloaded to very capable HW, so either way cost of
> creating an extra instance for DPDK or whatever else is very low.


The extra instance is virtio-net?

I think there is a gap. So let me give you a brief introduction of our case.

Firstly, we donot use dpdk. We use the AF_XDP, because of that the AF_XDP is
more simpler and easy to deploy for the nginx.

We use the AF_XDP to speedup the UDP of the quic. By the library, the APP just
needs some simple change.

On the AliYun, the net driver is virtio-net. So we want the virtio-net support
the AF_XDP.

I guess what you mean is that we can speed up through the cooperation of devices
and drivers, but our machines are public clouds, and we cannot change the
back-end devices of virtio under normal circumstances.

Here I do not know the different of the real hw and the virtio-net.


Thanks.

