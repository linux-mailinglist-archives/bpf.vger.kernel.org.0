Return-Path: <bpf+bounces-14576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5B47E68FE
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 11:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257491C20A3B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A6182AF;
	Thu,  9 Nov 2023 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF85134D1;
	Thu,  9 Nov 2023 10:58:39 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC42590;
	Thu,  9 Nov 2023 02:58:37 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vw0bMC3_1699527511;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vw0bMC3_1699527511)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 18:58:32 +0800
Message-ID: <1699526256.4202905-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/21] virtio-net: support AF_XDP zero copy
Date: Thu, 9 Nov 2023 18:37:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231109031728-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231109031728-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 9 Nov 2023 03:19:04 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Nov 07, 2023 at 11:12:06AM +0800, Xuan Zhuo wrote:
> > ## AF_XDP
> >
> > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > feature.
> >
> > At present, we have completed some preparation:
> >
> > 1. vq-reset (virtio spec and kernel code)
> > 2. virtio-core premapped dma
> > 3. virtio-net xdp refactor
> >
> > So it is time for Virtio-Net to complete the support for the XDP Socket
> > Zerocopy.
> >
> > Virtio-net can not increase the queue num at will, so xsk shares the queue with
> > kernel.
> >
> > On the other hand, Virtio-Net does not support generate interrupt from driver
> > manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
> > NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
> > is also the local CPU, then we wake up napi directly.
> >
> > This patch set includes some refactor to the virtio-net to let that to support
> > AF_XDP.
> >
> > ## performance
> >
> > ENV: Qemu with vhost-user(polling mode).
> > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> >
> > ### virtio PMD in guest with testpmd
> >
> > testpmd> show port stats all
> >
> >  ######################## NIC statistics for port 0 ########################
> >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
> >  RX-errors: 0
> >  RX-nombuf: 0
> >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> >
> >
> >  Throughput (since last show)
> >  Rx-pps:   8861574     Rx-bps:  3969985208
> >  Tx-pps:   8861493     Tx-bps:  3969962736
> >  ############################################################################
> >
> > ### AF_XDP PMD in guest with testpmd
> >
> > testpmd> show port stats all
> >
> >   ######################## NIC statistics for port 0  ########################
> >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
> >   RX-errors: 0
> >   RX-nombuf:  0
> >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> >
> >   Throughput (since last show)
> >   Rx-pps:      6333196          Rx-bps:   2837272088
> >   Tx-pps:      6333227          Tx-bps:   2837285936
> >   ############################################################################
> >
> > But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> >
> > ## maintain
> >
> > I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
> > virtio-net.
> >
> > Please review.
> >
> > Thanks.
> >
> > v2
> >     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
> >     2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
> >     3. split the commit "move to virtio_net.h" in last patch set. Just move the
> >        struct/api to header when we use them.
> >     4. add comments for some code
> >
> > v1:
> >     1. remove two virtio commits. Push this patchset to net-next
> >     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
> >     3. fix some warnings
> >
> >
> > Xuan Zhuo (21):
> >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> >   virtio_net: unify the code for recycling the xmit ptr
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: sq support premapped mode
> >   virtio_net: xsk: bind/unbind xsk
> >   virtio_net: xsk: prevent disable tx napi
> >   virtio_net: move some api to header
> >   virtio_net: xsk: tx: support tx
> >   virtio_net: xsk: tx: support wakeup
> >   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
> >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
> >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> >   virtio_net: xsk: rx: skip dma unmap when rq is bind with AF_XDP
> >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
> >   virtio_net: update tx timeout record
> >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> >
> >  MAINTAINERS                                 |   2 +-
> >  drivers/net/Kconfig                         |   8 +-
> >  drivers/net/Makefile                        |   2 +-
> >  drivers/net/virtio/Kconfig                  |  13 +
> >  drivers/net/virtio/Makefile                 |   8 +
> >  drivers/net/{virtio_net.c => virtio/main.c} | 630 +++++++++-----------
> >  drivers/net/virtio/virtio_net.h             | 346 +++++++++++
> >  drivers/net/virtio/xsk.c                    | 498 ++++++++++++++++
> >  drivers/net/virtio/xsk.h                    |  32 +
> >  9 files changed, 1174 insertions(+), 365 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  rename drivers/net/{virtio_net.c => virtio/main.c} (92%)
> >  create mode 100644 drivers/net/virtio/virtio_net.h
> >  create mode 100644 drivers/net/virtio/xsk.c
> >  create mode 100644 drivers/net/virtio/xsk.h
>
>
> Too much code duplications for my taste. Would there maybe be less if
> everything was in a single file?


What duplication?

Yes. If everything is in a single file, something maybe simpler. But I
do not like that, that will be more trouble in the future. We want to
make the virtnet more like the modern network card, then we will
introduce more features to the virtio-net. I think it's time to
split the single file to modules. I think letting every module simple is
beneficial for the maintaining.

About the duplications, I do not understand. No duplication,
We just refer the functions from each other.

Do you mean the receive_xsk()?
Let we resolve this problem if you think it's a duplicate. I think this is the
right way.

Thanks.





>
>
> > --
> > 2.32.0.3.g01195cf9f
>
>

