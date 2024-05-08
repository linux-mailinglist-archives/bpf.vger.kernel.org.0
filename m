Return-Path: <bpf+bounces-29006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB508BF46F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C7E1F254D3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE9BA49;
	Wed,  8 May 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RcD5Fp46"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EE1A2C28;
	Wed,  8 May 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135019; cv=none; b=F1s+RYw8ygp4BtlW6QfOnQzJTa9znCIR5XFEYrp0bOlakARjfrkSMP9VDwN0zfHTm65ddy9R1j3aaBrrf+kOQwfdtVytEJe4dnawb/XH8cUCJNHXAIAo1IFg4IPOo5Fo0Cb9hYRYGDdc6YbqAjpknnozgsFOVk+mDD2HIq4XSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135019; c=relaxed/simple;
	bh=sG/5CfdEuGFt2qXUIXDQ9Iph/PZ5SPBnkvic3k5LFAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+0fizW+Qblx5BTAuy7aUyif7fqsHbTantBbOIHtPRejuK44W5QH67Qh5hI15Jc8T2Jju86dK0KqwvfqHnn8Ac79HoYVh1AsqMSuVtUnGvtc/WeeS4rcP6wPdcdroMki5dzvX48hIMLVhXZMSbKdX7sdoqGpia/aG6sK8Z+F1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RcD5Fp46; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135014; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CHRizpqvv8zGKVGFHnosxx03lv56lVLD4Vx5MAGSMNk=;
	b=RcD5Fp46t08+mnDXX/1U33ARwWbHTZy++IRFoCUyFSxKXN9eDNH4F1GoDIJLTZj0jUIax0Q4mudR7Zx9to4799zMo8X1SCCxgRmTPVsP4tpzWrmhifE4spX3ccgDy9ZJz7p6Q4Gilr3OebOvAbw0CnJAZFwyuaA9/hSBWAzr5Pc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W61t.Sk_1715135012;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W61t.Sk_1715135012)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:23:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 0/5] virtio_net: introduce api to enable/disable premapped mode for sq
Date: Wed,  8 May 2024 10:23:26 +0800
Message-Id: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a0fef46c457b
Content-Transfer-Encoding: 8bit

As discussed:

http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com

If virtio is in pre-mapped mode, the driver should manage the DMA info itself.

However, due to the indirect feature, the virtio-net driver may need to maintain
an excessive amount of DMA info. Therefore, we only enable pre-mapped mode for
the send queue (SQ) when af-xdp is bound to it. We have set a limit on the
amount of DMA info we manage. If the kernel stack or xdp tx/redirect attempts to
use more descriptors than this limit, virtnet_add_outbuf() will return an
-ENOMEM error. However, AF-XDP can continue working.

The last patch aims to demonstrate the logic of enabling pre-mapped mode when
af-xdp is bound to the SQ, and we can discuss it further.

Although the APIs are not used, this patch might belong in the final patch set
(virtio-net supports AF_XDP). But I hope the first four patches can be merged
first to reduce the number of patches in the final set.

Thanks.

Xuan Zhuo (5):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: introduce dma map api for page
  virtio_ring: introduce virtqueue_dma_map_sg_attrs
  virtio_ring: virtqueue_set_dma_premapped() support to disable
  virtio_net: sq support premapped mode

 drivers/net/virtio_net.c     | 212 ++++++++++++++++++++++++++++++++++-
 drivers/virtio/virtio_ring.c | 118 ++++++++++++++++---
 include/linux/virtio.h       |  12 +-
 3 files changed, 319 insertions(+), 23 deletions(-)

--
2.32.0.3.g01195cf9f


