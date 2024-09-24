Return-Path: <bpf+bounces-40226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB880983AE4
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC44A1C22639
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071A4642D;
	Tue, 24 Sep 2024 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ndsCUWRe"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2217579;
	Tue, 24 Sep 2024 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141540; cv=none; b=jNv84rXKetFVWOUvrG1hMDvR6vgbDydQYiVGMlmruTOSigZd4wo+iroyzRCzzbw/yVetETylyfMbz2h96jdM9ZMjru5xAhVG6xgFYoYCNI0XRaaYZjk27URo32EcY5AT2IYowRTG6fO0kzfVeHzdLiEQSFnjUBs8GakoGyIAH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141540; c=relaxed/simple;
	bh=4PzE8lbbODeyaw38W4gYHeqOOSSQbowpvFBovmjchbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUPZ50kueuV0mnqao0pCtWHlNvnlIeBA2eVeNxj2Lc1Cg2+NQsB1G6s/UENGLYtzVA0tTr+S/RF9FtAjq+C1GkNLzt3A++XJmBLMUOz9l4Jx5e7b5i2URlP3NnASghgJjifx5XwVCTtR/VdUyqks0d6uJg1X97HrOXNk9nl07jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ndsCUWRe; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b6ZRBF+DYuysjrAxQNYZueIJJvIDTJk/DwCLRshP4RA=;
	b=ndsCUWReZ2fwyZlSHiMkd5PJl+kEN0DtOhzfdYyuqwJISKYzcKcAMdVIwmzy/bjyYAR9a54UlAem1IT3TB24RDzx9mUMDRBQGgf2UWfITLiCEvshBKVJg/XY6Ev9PHzx0HAZU06+u3zEbyV+cnF6BJiIf5l79PIgV4dbIRgcU9Q=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFdsUny_1727141534)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:14 +0800
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
Subject: [RFC net-next v1 11/12] virtio_net: update tx timeout record
Date: Tue, 24 Sep 2024 09:32:03 +0800
Message-Id: <20240924013204.13763-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 83bb687d4b73
Content-Transfer-Encoding: 8bit

If send queue sent some packets, we update the tx timeout
record to prevent the tx timeout.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1a870f1df910..a1ef0277c550 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1488,6 +1488,13 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, vi->dev, sq);
 
+	if (sent) {
+		struct netdev_queue *txq;
+
+		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
+		txq_trans_cond_update(txq);
+	}
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	u64_stats_add(&sq->stats.packets, stats.packets);
 	u64_stats_add(&sq->stats.bytes,   stats.bytes);
-- 
2.32.0.3.g01195cf9f


