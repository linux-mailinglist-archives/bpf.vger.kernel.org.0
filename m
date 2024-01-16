Return-Path: <bpf+bounces-19582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7E82EBCB
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2AA1F2433E
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB3412E4A;
	Tue, 16 Jan 2024 09:43:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701012B90;
	Tue, 16 Jan 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmFMW_1705398193;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmFMW_1705398193)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Date: Tue, 16 Jan 2024 17:42:56 +0800
Message-Id: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1913ebd4ae28
Content-Transfer-Encoding: 8bit

This is the third part of virtio-net support AF_XDP zero copy.

The whole patch set
http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linux.alibaba.com

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

Xuan Zhuo (17):
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

 drivers/net/virtio/Makefile     |   2 +-
 drivers/net/virtio/main.c       | 409 +++++++++++----------
 drivers/net/virtio/virtio_net.h | 140 +++++++
 drivers/net/virtio/xsk.c        | 622 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  32 ++
 5 files changed, 1014 insertions(+), 191 deletions(-)
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

--
2.32.0.3.g01195cf9f


