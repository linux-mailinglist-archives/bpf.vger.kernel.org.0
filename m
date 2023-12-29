Return-Path: <bpf+bounces-18708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BE81FD7C
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9626E284A40
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66B747E;
	Fri, 29 Dec 2023 07:31:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B423BB;
	Fri, 29 Dec 2023 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQyVzG_1703835069;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQyVzG_1703835069)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 00/27] virtio-net: support AF_XDP zero copy
Date: Fri, 29 Dec 2023 15:30:41 +0800
Message-Id: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

## AF_XDP

XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
copy feature of xsk (XDP socket) needs to be supported by the driver. The
performance of zero copy is very good. mlx5 and intel ixgbe already support
this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
feature.

At present, we have completed some preparation:

1. vq-reset (virtio spec and kernel code)
2. virtio-core premapped dma
3. virtio-net xdp refactor

So it is time for Virtio-Net to complete the support for the XDP Socket
Zerocopy.

Virtio-net can not increase the queue num at will, so xsk shares the queue with
kernel.

On the other hand, Virtio-Net does not support generate interrupt from driver
manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
is also the local CPU, then we wake up napi directly.

This patch set includes some refactor to the virtio-net to let that to support
AF_XDP.

## performance

ENV: Qemu with vhost-user(polling mode).
Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz

### virtio PMD in guest with testpmd

testpmd> show port stats all

 ######################## NIC statistics for port 0 ########################
 RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
 RX-errors: 0
 RX-nombuf: 0
 TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664


 Throughput (since last show)
 Rx-pps:   8861574     Rx-bps:  3969985208
 Tx-pps:   8861493     Tx-bps:  3969962736
 ############################################################################

### AF_XDP PMD in guest with testpmd

testpmd> show port stats all

  ######################## NIC statistics for port 0  ########################
  RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152

  Throughput (since last show)
  Rx-pps:      6333196          Rx-bps:   2837272088
  Tx-pps:      6333227          Tx-bps:   2837285936
  ############################################################################

But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).

## maintain

I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
virtio-net.

Please review.

Thanks.

v3
    1. virtio introduces helpers for virtio-net sq using premapped dma
    2. xsk has more complete support for merge mode
    3. fix some problems

v2
    1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
    2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
    3. split the commit "move to virtio_net.h" in last patch set. Just move the
       struct/api to header when we use them.
    4. add comments for some code

v1:
    1. remove two virtio commits. Push this patchset to net-next
    2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
    3. fix some warnings



Xuan Zhuo (27):
  virtio_net: rename free_old_xmit_skbs to free_old_xmit
  virtio_net: unify the code for recycling the xmit ptr
  virtio_net: independent directory
  virtio_net: move core structures to virtio_net.h
  virtio_net: add prefix virtnet to all struct inside virtio_net.h
  virtio_ring: introduce virtqueue_get_buf_ctx_dma()
  virtio_ring: virtqueue_disable_and_recycle let the callback detach
    bufs
  virtio_ring: introduce virtqueue_detach_unused_buf_dma()
  virtio_ring: introduce virtqueue_get_dma_premapped()
  virtio_net: sq support premapped mode
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: xsk: bind/unbind xsk
  virtio_net: xsk: prevent disable tx napi
  virtio_net: move some api to header
  virtio_net: xsk: tx: support xmit xsk buffer
  virtio_net: xsk: tx: support wakeup
  virtio_net: xsk: tx: handle the transmitted xsk buffer
  virtio_net: xsk: tx: free the unused xsk buffer
  virtio_net: separate receive_mergeable
  virtio_net: separate receive_buf
  virtio_net: xsk: rx: support fill with xsk buffer
  virtio_net: xsk: rx: support recv merge mode
  virtio_net: xsk: rx: support recv small mode
  virtio_net: xsk: rx: free the unused xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 MAINTAINERS                                 |   2 +-
 drivers/net/Kconfig                         |   8 +-
 drivers/net/Makefile                        |   2 +-
 drivers/net/virtio/Kconfig                  |  13 +
 drivers/net/virtio/Makefile                 |   8 +
 drivers/net/{virtio_net.c => virtio/main.c} | 806 +++++++++-----------
 drivers/net/virtio/virtio_net.h             | 337 ++++++++
 drivers/net/virtio/xsk.c                    | 626 +++++++++++++++
 drivers/net/virtio/xsk.h                    |  32 +
 drivers/virtio/virtio_ring.c                | 235 ++++--
 include/linux/virtio.h                      |  22 +-
 11 files changed, 1582 insertions(+), 509 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/main.c} (90%)
 create mode 100644 drivers/net/virtio/virtio_net.h
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

--
2.32.0.3.g01195cf9f


