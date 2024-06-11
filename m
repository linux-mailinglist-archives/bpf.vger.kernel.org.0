Return-Path: <bpf+bounces-31819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01657903AC3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC471C241C3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4417E91A;
	Tue, 11 Jun 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bmU+nznP"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40017C214;
	Tue, 11 Jun 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106113; cv=none; b=KkYQ1RbBGlINS3kJn0EgLEgslOMEQRyDFrV4ua4hv+l5nRWM2tvf36/kAd2G1cpWXjMSVNrC9yHkdNgClApxdmmhLLL7+I8oSyfJGltcZZH3Ta6nYQgfgtHdg9e1ICaeZhfxOwNkix6kiXayEBQvpger0cbXnkFFJAE4t3GogOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106113; c=relaxed/simple;
	bh=HKlc6SLOzdnFpAGdYc0SEvGd1Va4OYPwdTEZ7NWb+UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XOzQfp8RtB4S9cPkcG++EABUveX/+lh3zTW/fx+3VcdMbNjYUyDLxPDqrfN2tmrEUdDeMIx99WE2vjC2dA7yxYDvdsDzEYOVQDeEGMDzkWJPj/tT5+lsKNpkWxM8ZEDnUVlZAv18rosnOUw16YtEA8ZVNcIkVfyTkcBYW96J+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bmU+nznP; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106109; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PR22hkpZDKHp0F47rplJqTDNG4Zp91n5s1+Tkv2383c=;
	b=bmU+nznP4ZpRFRNrHJ1zFgE1JoDQrG5EVY7GQETCjax/ziOVhgqFQqMlN79DWxfs97UOXhRRmbyX9H4r9ODaoOPqcPmZyT7itxl4wvHcmuFmRZ7xVoelByuOS3qDecD2SopIytBVwO/fMsLcaiZbSPfPSxxUdceC6A7M/Wlr+tc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GMZL1_1718106107;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GMZL1_1718106107)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:48 +0800
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
Subject: [PATCH net-next v4 00/15] virtio-net: support AF_XDP zero copy
Date: Tue, 11 Jun 2024 19:41:32 +0800
Message-Id: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

v4:
    1. remove the commits that introduce the independent directory
    2. remove the supporting for the rx merge mode (for limit 15
       commits of net-next). Let's start with the small mode.
    3. merge some commits and remove some not important commits

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




Xuan Zhuo (15):
  virtio_ring: introduce dma map api for page
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: virtqueue_set_dma_premapped() support to disable
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: separate receive_buf
  virtio_net: refactor the xmit type
  virtio_net: sq support premapped mode
  virtio_net: xsk: bind/unbind xsk
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support xmit xsk buffer
  virtio_net: xsk: tx: support wakeup
  virtio_net: xsk: tx: handle the transmitted xsk buffer
  virtio_net: xsk: rx: support fill with xsk buffer
  virtio_net: xsk: rx: support recv small mode

 drivers/net/virtio_net.c     | 983 ++++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_ring.c |  88 +++-
 include/linux/virtio.h       |   9 +-
 3 files changed, 997 insertions(+), 83 deletions(-)

--
2.32.0.3.g01195cf9f


