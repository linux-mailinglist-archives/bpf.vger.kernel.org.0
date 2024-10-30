Return-Path: <bpf+bounces-43518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B39B5D99
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30779B2291C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB611E0E14;
	Wed, 30 Oct 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="heqCHfMn"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E61991CF;
	Wed, 30 Oct 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276703; cv=none; b=Nli0xNTAgM71PCwk8ykLhd8ED6MhzOQ5BWL/FJCXOJp0RTcg9jv9Ri7ro95FhrxrEjRFZtFpyhIwjm0vznkb89ny7NpNuBqgvJwAFgUq0R5MUPLc30tzLu5chlEFcKXsu3Eap+CTI6lOPgDysiZ+YqWcoWyWGuc3P43GfPbXHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276703; c=relaxed/simple;
	bh=MMRebhkiS3gvjjVdCqGx3cxAqPw5rppT+QPN6VbHzH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XttJu4C7X0mlQpNzv1YZ4SUfc2go1BI/xxajpc7Bu4JZTdADcHejR48Jy8Ac5cTuc2+j4wTEI5hwAu4hbjJmvh29BJAtFQ/KdyYbMKfD1xojNgPuSvvAf6z9q0+c+/MDGQ5ORKoOcUKixEY50hvTL4xbalq+cmxlk0PiZndRy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=heqCHfMn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276694; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+Y/Qt8yoXhM0KLjZGcz9qLSogD/6Ml4nCyD3lSBQsJw=;
	b=heqCHfMntSRAr4cJRe0yfu8ydZe6SkdCpfRmBZgPvg/pLFPyJVrd0555eDcQOufI7o6UxT9n0IJCczuzAO4yMnigSv8pWAv+boXlsVrkpLJqPHRPH6Aaor0p8ORzEtuht2Ppf8tUCSghLb09LsCDgehyoqOGwmAO/K18kDYSRJs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDHQMJ_1730276693 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:24:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 00/13] virtio-net: support AF_XDP zero copy (tx)
Date: Wed, 30 Oct 2024 16:24:40 +0800
Message-Id: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
Content-Transfer-Encoding: 8bit

v2:
    1. use new api to submit premapped buffer instead of using sgs to pass this info
    2. some small fixes for http://lore.kernel.org/all/20240924013204.13763-1-xuanzhuo@linux.alibaba.com


v1:
    1. some small fixes for http://lore.kernel.org/all/20240820073330.9161-1-xuanzhuo@linux.alibaba.com
        1. fix the title of the commit #2, #3
        2. fix the gcc error for commit #3
        3. use virtqueue_dma_xxxx for tx hdr
        4. rename virtnet_ptr_to_xsk to virtnet_ptr_to_xsk_buff_len
        5. squash #11 in last patch set to #10

================================================================================

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
  virtio_ring: split: record extras for indirect buffers
  virtio_ring: packed: record extras for indirect buffers
  virtio_ring: perform premapped operations based on per-buffer
  virtio_ring: introduce add api for premapped
  virtio-net: rq submits premapped per-buffer
  virtio_ring: remove API virtqueue_set_dma_premapped
  virtio_net: refactor the xmit type
  virtio_net: xsk: bind/unbind xsk for tx
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support xmit xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 drivers/net/virtio_net.c     | 358 +++++++++++++++++++++++++++++------
 drivers/virtio/virtio_ring.c | 340 ++++++++++++++++-----------------
 include/linux/virtio.h       |  15 +-
 3 files changed, 483 insertions(+), 230 deletions(-)

--
2.32.0.3.g01195cf9f


