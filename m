Return-Path: <bpf+bounces-37607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4F957FE1
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0174E2844F1
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66A188CBD;
	Tue, 20 Aug 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L046MDOt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF6157A6B;
	Tue, 20 Aug 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139236; cv=none; b=lJCi/NPO6SDGyXLt+33TRBJMqfQ9WHMODq+vlh4F3/je0eoeVkt82ki/2aLvjdqVhho2hRP/nfqQuLahZxyoRcwFpxBOvk22R22n/7NdRCYuAraRiM7/L2udsJC+EPs3QEXs5rClWGg4XBRhu7uAyrLsRMAtynZHmpdTx3Q+mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139236; c=relaxed/simple;
	bh=Kj8ObtmEaOA3y+WYX4P9L9UsvZegCW1nL/ob5LOvhn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxNs9V261nYJlSmrflJC6XyIvKg4NB3k3GxkRwHhyT/hx9sxPlAh4VUJOERP7RMjrDzNnWd/wxcBcZEUdLaB/jeV0m7dOt+EALEzqsTi7Dm72dJWfx03dJ5o+0WhwLLZzXk7/sqZ1fkGr3qHidxMwbp9WCxB2YyHFQhNbpeeokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L046MDOt; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139225; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3elfljQiUVSnVBo5J+zwiJsSKwVnFNME8fZxlBidteU=;
	b=L046MDOtn+QOSj+fe34BB2FJGPUVlcDTSly/0nb6mlyY6fZQQZhZS4y7tAa6nIiJvUT/kkxQ0XZblyi8G11pEH/UQHO+z8CypepLHxAlUH6gZ2F3DUPedQc+2MQuVXUZ2sDyRkseZPebu98LIsUa+Qx7lUynxBCeTrIqHvHV6Pw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHk5EQ_1724139222)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:43 +0800
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
Subject: [PATCH net-next 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Tue, 20 Aug 2024 15:33:30 +0800
Message-Id: <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b206d29d23af
Content-Transfer-Encoding: 8bit

Now, we supported AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to
xdp_features.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 28c5f9e77fa3..8e4578ec1937 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6594,7 +6594,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+		NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = MIN_MTU;
-- 
2.32.0.3.g01195cf9f


