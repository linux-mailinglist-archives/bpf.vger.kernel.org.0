Return-Path: <bpf+bounces-33943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46199282E0
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4901F2223E
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3245146588;
	Fri,  5 Jul 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ymwovyso"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30129145359;
	Fri,  5 Jul 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165067; cv=none; b=c980FPSAYrJ4AgWE7OsM2DHdY8raHino1Xr8kF6fbGSU/CzFy+pu19iUW3qf7z0ka8USqTyD1Z1vQLJ0kYa8DdiDRBx8euLVnRElEXKU4wzUh1BdEgcuvdftiArsYzIbclVizbrlwU9MGuyXLuoZlIlXw/Ix0eTLyd5RuAtI+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165067; c=relaxed/simple;
	bh=bQ8pchX1ZViQkpKM1jEfHZDoHW/xgSE6CVB8l2midVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTY8vWB9h6m1W4QG1VO5olUGTglCNL08WGqlQGNjQ+mdUZSMXC4p/2hnxOCBh1+qHTNFEPhU1Xk52S8FNXISI+oIb6jbumX8z9WETbWIyI7EuV4ia/JISrVkIzNdUOGcih12kgiPNHiKcWY3QsVTXmeyztJAhLqSFvI1rFWhWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ymwovyso; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165063; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HOxERNJ2lKwT+7MibpvryEY8eB12BLqay9tuuRTXLko=;
	b=ymwovyso+FCB7CwgFsTVPFJtDaomvDoCTx1YZOEcBrPPowJfwmA3gKb9goKMWVqg9lVxAEu1fcS6AQuxx9QNYMpJp7YTmAl0bXw3MGV2TLUa2GKqzVXl3KFhWrQos2vfZx9qi1wULexY9abRDXc+04yHqiZSYjOdBcRecX0UlK8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9uE.fU_1720165061;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9uE.fU_1720165061)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:42 +0800
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
Subject: [PATCH net-next v7 07/10] virtio_net: xsk: support wakeup
Date: Fri,  5 Jul 2024 15:37:31 +0800
Message-Id: <20240705073734.93905-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
user.

Virtio-net does not support to actively generate an interruption, so it
tries to trigger tx NAPI on the local cpu.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cd87b39600d4..29fa25ce1a7f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1054,6 +1054,29 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return 0;
+
+	local_bh_disable();
+	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+
+	return 0;
+}
+
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 				   struct send_queue *sq,
 				   struct xdp_frame *xdpf)
@@ -5399,6 +5422,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
-- 
2.32.0.3.g01195cf9f


