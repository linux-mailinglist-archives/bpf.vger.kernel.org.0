Return-Path: <bpf+bounces-30931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E58D4AAF
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA251C21E4B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEA17C7B4;
	Thu, 30 May 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xEAMgL46"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A33176AC5;
	Thu, 30 May 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068253; cv=none; b=K+H+Zko3BXIpSo3rK+70qHoWTKcsV1oaK69TZPet34uJ84fGTd3PwJbSxaAFRvTftBDyDgLdZRt/5qrMRSzak5+WhAd+QmimdFQHrRXMyOt5xVjWbEQauNk9HGS0R18+T15qsOREy+7NEh8IdnV/Ho4NfBQNN/MTm2YjBmiKF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068253; c=relaxed/simple;
	bh=0WJDpDa9lhr2LGFYbOePHFyZ6YwcfioYnmBnQeGxP4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1YLFrvgJZwG078Gj2G10sWFx83FgoZfFhNL911SbGTfwgUlfkzcVWgNG/ZFZi3T4nxtK/gLFp6y+Tzmnctb/ZAlC8IJRhsTvS6o3on6c6PVSNesaB21mfJ0nrS4GkDhXYLXDPAwoIphz7AcOGX/ViHhIDig3PPvIuGlwxOEnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xEAMgL46; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JCJQLpIokiiuVSotEGZG1s9N4gxo3eGKbRmi/fsG/24=;
	b=xEAMgL4659vDog54voASykO1AFZOTY9lgc8jikzgPv+y6HvyQGoudvUoUUMTRlt14L6aw9Dp0wZOGJT3ZoAg8LI8SH0v6kDiYCyYR4Mm0JMlRm2SwBNey1NJJx9wEKeazU+eiuMGkqqtM4pRCQpFhjq+B7w6cQQDhqb6DPCYv5c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WnOUG_1717068246;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WnOUG_1717068246)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 19:23:54 +0800
Message-Id: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
Content-Transfer-Encoding: 8bit

This patch set prepares for supporting af-xdp zerocopy.
There is no feature change in this patch set.
I just want to reduce the patch num of the final patch set,
so I split the patch set.

Thanks.

v2:
    1. Add five commits. That provides some helper for sq to support premapped
       mode. And the last one refactors distinguishing xmit types.

v1:
    1. resend for the new net-next merge window



Xuan Zhuo (12):
  virtio_net: independent directory
  virtio_net: move core structures to virtio_net.h
  virtio_net: add prefix virtnet to all struct inside virtio_net.h
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: separate receive_mergeable
  virtio_net: separate receive_buf
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: introduce dma map api for page
  virtio_ring: introduce virtqueue_dma_map_sg_attrs
  virtio_ring: virtqueue_set_dma_premapped() support to disable
  virtio_net: refactor the xmit type

 MAINTAINERS                                   |   2 +-
 drivers/net/Kconfig                           |   9 +-
 drivers/net/Makefile                          |   2 +-
 drivers/net/virtio/Kconfig                    |  12 +
 drivers/net/virtio/Makefile                   |   8 +
 drivers/net/virtio/virtnet.h                  | 248 ++++++++
 .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
 drivers/virtio/virtio_ring.c                  | 118 +++-
 include/linux/virtio.h                        |  12 +-
 9 files changed, 606 insertions(+), 401 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 create mode 100644 drivers/net/virtio/virtnet.h
 rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)

--
2.32.0.3.g01195cf9f


