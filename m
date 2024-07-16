Return-Path: <bpf+bounces-34880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8F93208D
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF41F223C2
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22371CF92;
	Tue, 16 Jul 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Olu82rss"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB51CA9E;
	Tue, 16 Jul 2024 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112396; cv=none; b=SsiEH5fW67xiFf8wjxsF4tJfnT6n7ju01ySrd8O2lpzVTFPwgVN7YhMbsy4VosfYQz25ZUFRhRiunnTlIrou/2pUFs3AUPSEpUXM/L4e8k4x/mSjxpbaH/56oVKpdHnIewU3wDV5kEI5cxoe1jaub+WpN27Y98qDrozzmyvjJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112396; c=relaxed/simple;
	bh=BWVmVKJHlax9DkqBORWUNkJV/4sN3wXMkn15jbZ2tlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ucolFi3vV2CYwcofWWND7NWfHyjTCvLmaed2N46GgJjjuwVbSuc886PFLd5ZIA7upfHgPD++tjGmIDSDopqmv4HEsG+TdNROxiqxq7gwiqgK4/T2C4521OPBF3AkjTwCwBxw0k9/+J5H0TLffcydzVDGrvyKNgn2bzlYq1yKAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Olu82rss; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112390; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=E0dRE0f7kcCMLK7jhepXQaYa72tfO34iZaN/yvvmVOA=;
	b=Olu82rsscc8Gf8hDgxk/AkhPhyKPcgSYUbZVSEjkfISe9xucVCfLoQ3UUpejLo3ukx3tKLxvgWwvf4G6DxFH81KNscr0BRebCQ27a95Jq7XyKpwEUq8jHhsXjMZPkIStwDZpP4A96/HtbN/ZWMwRkrlW7ZhMNsm8NuTsYbrTUYs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgSzgo_1721112388;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgSzgo_1721112388)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
Subject: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
Date: Tue, 16 Jul 2024 14:46:15 +0800
Message-Id: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: d3e48bf059c8
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

This patch set includes some refactor to the virtio-net to let that to support
AF_XDP.

## About virtio premapped mode

The current configuration sets the virtqueue (vq) to premapped mode,
implying that all buffers submitted to this queue must be mapped ahead
of time. This presents a challenge for the virtnet send queue (sq): the
virtnet driver would be required to keep track of dma information for vq
size * 17, which can be substantial. However, if the premapped mode were
applied on a per-buffer basis, the complexity would be greatly reduced.
With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
skb buffers could remain unmapped.

We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
indicates that the driver has performed DMA mapping in advance, allowing
the Virtio core to directly utilize sg_dma_address(sg) without
conducting any internal DMA mapping. Additionally, DMA unmap operations
for this buffer will be bypassed.

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

Please review.

Thanks.

Xuan Zhuo (13):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: split: harden dma unmap for indirect
  virtio_ring: packed: harden dma unmap for indirect
  virtio_ring: perform premapped operations based on per-buffer
  virtio-net: rq submits premapped buffer per buffer
  virtio_ring: remove API virtqueue_set_dma_premapped
  virtio_net: refactor the xmit type
  virtio_net: xsk: bind/unbind xsk for tx
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support xmit xsk buffer
  virtio_net: xsk: tx: handle the transmitted xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 drivers/net/virtio_net.c     | 363 ++++++++++++++++++++++++++++-------
 drivers/virtio/virtio_ring.c | 302 ++++++++++++-----------------
 include/linux/virtio.h       |   2 -
 3 files changed, 421 insertions(+), 246 deletions(-)

--
2.32.0.3.g01195cf9f


