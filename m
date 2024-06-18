Return-Path: <bpf+bounces-32394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088290C6BB
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9F928230B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6519EEAF;
	Tue, 18 Jun 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h5Eqxrda"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994619E7DD;
	Tue, 18 Jun 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697420; cv=none; b=U0T0T3IA8Dak7M/z5mzmjxLU+7Ak5Bldrzdw1jJwbBT/vtWuwiClyNPYGYxYlSfaZHcIDC6+eGNzDP6oUtTj3O2IkkVqbpnEFlp75SqayQR1djNfVwXhesSyJuqPqIfa2R+o7mcE+Z4i8j7VNcGdHcBsEzKkueayY45YDUt1+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697420; c=relaxed/simple;
	bh=ujRQgVR1me4J6+GwMqJ69HKjg8vldD6L9KIr0nVFAQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWwiCSjuXV8ft0QauCs71WASn15mIE5et8MPNl7AYdGOUW8aERSlBuPrkNKEj9tP5FYZdLw9jK5tRjJhng35vlrDZgFJk7Cob3rrXe1un+ooN4Md9AZAMU7yXxV3wwtUE+gkKmhMvwX9mxoXRaNVzz5TjEhu/uZUrHU+8kXjcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h5Eqxrda; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FXlDnaoklNLjA51vt2sGGi+2+tst7TAGL7vCCvlAcsY=;
	b=h5EqxrdaYocR0iuc04UeNU6Frh7AYl2z39/5WakoluMik5RsbocmoCeJS9B0LDjlgj7iyOeK2K1XwxmSXL7khatMBs/NACTx64f35uiYWD7zILwZFZKSCQBPtDQWc28VkP8pLrf8fXPw0INv+YuHPG8rX1c9zJ9/kccwwHqI2fM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jSGBr_1718697409;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jSGBr_1718697409)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:49 +0800
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
Subject: [PATCH net-next v6 06/10] virtio_net: xsk: support wakeup
Date: Tue, 18 Jun 2024 15:56:39 +0800
Message-Id: <20240618075643.24867-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
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
index d8cce143be26..2bbc715f22c6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1032,6 +1032,29 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
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
@@ -5312,6 +5335,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
-- 
2.32.0.3.g01195cf9f


