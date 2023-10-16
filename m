Return-Path: <bpf+bounces-12263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22A7CA765
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA56C1C20B24
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A726E20;
	Mon, 16 Oct 2023 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46282374D;
	Mon, 16 Oct 2023 12:00:41 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A57DC;
	Mon, 16 Oct 2023 05:00:39 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuHc.Mz_1697457634;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuHc.Mz_1697457634)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 20:00:34 +0800
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
Subject: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Mon, 16 Oct 2023 20:00:14 +0800
Message-Id: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 9790cc452aab
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

Sockperf: https://github.com/Mellanox/sockperf
I use this tool to send udp packet by kernel syscall.

xmit command: sockperf tp -i 10.0.3.1 -t 1000

I write a tool that sends udp packets or recvs udp packets by AF_XDP.

                  | Guest APP CPU |Guest Softirq CPU | UDP PPS
------------------|---------------|------------------|------------
xmit by syscall   |   100%        |                  |   676,915
xmit by xsk       |   59.1%       |   100%           | 5,447,168
recv by syscall   |   60%         |   100%           |   932,288
recv by xsk       |   35.7%       |   100%           | 3,343,168

## maintain

I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
virtio-net.

Please review.

Thanks.

v1:
    1. remove two virtio commits. Push this patchset to net-next
    2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
    3. fix some warnings

Xuan Zhuo (19):
  virtio_net: rename free_old_xmit_skbs to free_old_xmit
  virtio_net: unify the code for recycling the xmit ptr
  virtio_net: independent directory
  virtio_net: move to virtio_net.h
  virtio_net: add prefix virtnet to all struct/api inside virtio_net.h
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: sq support premapped mode
  virtio_net: xsk: bind/unbind xsk
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support tx
  virtio_net: xsk: tx: support wakeup
  virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
  virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
  virtio_net: xsk: rx: introduce add_recvbuf_xsk()
  virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
  virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 MAINTAINERS                                 |   2 +-
 drivers/net/Kconfig                         |   8 +-
 drivers/net/Makefile                        |   2 +-
 drivers/net/virtio/Kconfig                  |  13 +
 drivers/net/virtio/Makefile                 |   8 +
 drivers/net/{virtio_net.c => virtio/main.c} | 652 +++++++++-----------
 drivers/net/virtio/virtio_net.h             | 359 +++++++++++
 drivers/net/virtio/xsk.c                    | 545 ++++++++++++++++
 drivers/net/virtio/xsk.h                    |  32 +
 9 files changed, 1247 insertions(+), 374 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/main.c} (91%)
 create mode 100644 drivers/net/virtio/virtio_net.h
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

--
2.32.0.3.g01195cf9f


