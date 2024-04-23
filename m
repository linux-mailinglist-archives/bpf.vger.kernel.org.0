Return-Path: <bpf+bounces-27534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6418AE401
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0948D1F232F7
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E67E78E;
	Tue, 23 Apr 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fUrBtGLU"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235384039;
	Tue, 23 Apr 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871916; cv=none; b=ODXrPpbtfWuslgUb71vaBSBHkx0KCSZBuc0ag5kt0V/lKm3lZosOwLNN4DDQDG3wSzKpLzBBKZIj96k/GxLfNZEOkIt0GV+MIB+wsOusB6YviflGO/P2bOBlS3zhs+w6BUMPlnrh+5Pw1b6EwtS6W9oeT9ZpSbLGujbXLmy0Ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871916; c=relaxed/simple;
	bh=fs9mBfnUo5VUwoC49M1oKhjXjQYzloflCrFTocr6Ktc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZqAf+0lvrh40JbfVsU5BmqnM6ou8IilA1grodw4RsHw0NaVn9HSI6nmsYCyJbCrRekCYm/tsvdMDJ2iDZjxCnbF+NNxhgNkptJFMQuKqc3ATvTgLE+F6sl0gxHqHTHTl522Bacu7bc7ya+H9Io51QBbljms0VMoS5qcvnrmWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fUrBtGLU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871912; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TRD9x7KsHx7J1Ivp7O94hlWIwg6juNJcB2vUf7rdXAU=;
	b=fUrBtGLUvMUXcFpzlpw7Kt276fhqUQUg3ZFtmYCd+Lyo2HN5gY8lGIu+hxmcd6uIIDBMS6Jdx6soKswgJmGsvNKykr6+O1jyWf0pdW+J0gRDt2Eq5ChqKRtYpG/NX/nZFvPCeV5vfVUNY0ImxOFFItm1Gq/J4itaxV7HsizdoE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W592gRd_1713871909;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W592gRd_1713871909)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:50 +0800
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
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 5/8] virtio_net: add the total stats field
Date: Tue, 23 Apr 2024 19:31:38 +0800
Message-Id: <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 75c95ace5f2d
Content-Transfer-Encoding: 8bit

Now, we just show the stats of every queue.

But for the user, the total values of every stat may are valuable.

NIC statistics:
     rx_packets: 373522
     rx_bytes: 85919736
     rx_drops: 0
     rx_xdp_packets: 0
     rx_xdp_tx: 0
     rx_xdp_redirects: 0
     rx_xdp_drops: 0
     rx_kicks: 11125
     rx_hw_notifications: 0
     rx_hw_packets: 1325870
     rx_hw_bytes: 263348963
     rx_hw_interrupts: 0
     rx_hw_drops: 1451
     rx_hw_drop_overruns: 0
     rx_hw_csum_valid: 1325870
     rx_hw_needs_csum: 1325870
     rx_hw_csum_none: 0
     rx_hw_csum_bad: 0
     rx_hw_ratelimit_packets: 0
     rx_hw_ratelimit_bytes: 0
     tx_packets: 10050
     tx_bytes: 1230176
     tx_xdp_tx: 0
     tx_xdp_tx_drops: 0
     tx_kicks: 10050
     tx_timeouts: 0
     tx_hw_notifications: 0
     tx_hw_packets: 32281
     tx_hw_bytes: 4315590
     tx_hw_interrupts: 0
     tx_hw_drops: 0
     tx_hw_drop_malformed: 0
     tx_hw_csum_none: 0
     tx_hw_needs_csum: 32281
     tx_hw_ratelimit_packets: 0
     tx_hw_ratelimit_bytes: 0
     rx0_packets: 373522
     rx0_bytes: 85919736
     rx0_drops: 0
     rx0_xdp_packets: 0
     rx0_xdp_tx: 0
     rx0_xdp_redirects: 0
     rx0_xdp_drops: 0
     rx0_kicks: 11125
     rx0_hw_notifications: 0
     rx0_hw_packets: 1325870
     rx0_hw_bytes: 263348963
     rx0_hw_interrupts: 0
     rx0_hw_drops: 1451
     rx0_hw_drop_overruns: 0
     rx0_hw_csum_valid: 1325870
     rx0_hw_needs_csum: 1325870
     rx0_hw_csum_none: 0
     rx0_hw_csum_bad: 0
     rx0_hw_ratelimit_packets: 0
     rx0_hw_ratelimit_bytes: 0
     tx0_packets: 10050
     tx0_bytes: 1230176
     tx0_xdp_tx: 0
     tx0_xdp_tx_drops: 0
     tx0_kicks: 10050
     tx0_timeouts: 0
     tx0_hw_notifications: 0
     tx0_hw_packets: 32281
     tx0_hw_bytes: 4315590
     tx0_hw_interrupts: 0
     tx0_hw_drops: 0
     tx0_hw_drop_malformed: 0
     tx0_hw_csum_none: 0
     tx0_hw_needs_csum: 32281
     tx0_hw_ratelimit_packets: 0
     tx0_hw_ratelimit_bytes: 0

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6d24cd8fb15f..8a4d22f5f5b1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3344,14 +3344,15 @@ static void virtnet_stats_sprintf(u8 **p, const char *fmt, const char *noq_fmt,
 	}
 }
 
+/* qid == -1: for rx/tx queue total field */
 static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	const struct virtnet_stat_desc *desc;
 	const char *fmt, *noq_fmt;
 	u8 *p = *data;
-	u32 num = 0;
+	u32 num;
 
-	if (type == VIRTNET_Q_TYPE_CQ) {
+	if (type == VIRTNET_Q_TYPE_CQ && qid >= 0) {
 		noq_fmt = "cq_hw_%s";
 
 		if (VIRTIO_NET_STATS_TYPE_CVQ & vi->device_stats_cap) {
@@ -3364,65 +3365,69 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 
 	if (type == VIRTNET_Q_TYPE_RX) {
 		fmt = "rx%u_%s";
+		noq_fmt = "rx_%s";
 
 		desc = &virtnet_rq_stats_desc[0];
 		num = ARRAY_SIZE(virtnet_rq_stats_desc);
 
-		virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 
 		fmt = "rx%u_hw_%s";
+		noq_fmt = "rx_hw_%s";
 
 		if (VIRTIO_NET_STATS_TYPE_RX_BASIC & vi->device_stats_cap) {
 			desc = &virtnet_stats_rx_basic_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_rx_basic_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 
 		if (VIRTIO_NET_STATS_TYPE_RX_CSUM & vi->device_stats_cap) {
 			desc = &virtnet_stats_rx_csum_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_rx_csum_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 
 		if (VIRTIO_NET_STATS_TYPE_RX_SPEED & vi->device_stats_cap) {
 			desc = &virtnet_stats_rx_speed_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_rx_speed_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 	}
 
 	if (type == VIRTNET_Q_TYPE_TX) {
 		fmt = "tx%u_%s";
+		noq_fmt = "tx_%s";
 
 		desc = &virtnet_sq_stats_desc[0];
 		num = ARRAY_SIZE(virtnet_sq_stats_desc);
 
-		virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 
 		fmt = "tx%u_hw_%s";
+		noq_fmt = "tx_hw_%s";
 
 		if (VIRTIO_NET_STATS_TYPE_TX_BASIC & vi->device_stats_cap) {
 			desc = &virtnet_stats_tx_basic_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_tx_basic_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 
 		if (VIRTIO_NET_STATS_TYPE_TX_GSO & vi->device_stats_cap) {
 			desc = &virtnet_stats_tx_gso_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_tx_gso_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 
 		if (VIRTIO_NET_STATS_TYPE_TX_SPEED & vi->device_stats_cap) {
 			desc = &virtnet_stats_tx_speed_desc[0];
 			num = ARRAY_SIZE(virtnet_stats_tx_speed_desc);
 
-			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+			virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
 		}
 	}
 
@@ -3503,6 +3508,49 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	}
 }
 
+/* stats_sum_queue - Calculate the sum of the same fields in sq or rq.
+ * @sum: the position to store the sum values
+ * @num: field num
+ * @q_value: the first queue fields
+ * @q_num: number of the queues
+ */
+static void stats_sum_queue(u64 *sum, u32 num, u64 *q_value, u32 q_num)
+{
+	u32 step = num;
+	int i, j;
+	u64 *p;
+
+	for (i = 0; i < num; ++i) {
+		p = sum + i;
+		*p = 0;
+
+		for (j = 0; j < q_num; ++j)
+			*p += *(q_value + i + j * step);
+	}
+}
+
+static void virtnet_fill_total_fields(struct virtnet_info *vi,
+				      struct virtnet_stats_ctx *ctx)
+{
+	u64 *data, *first_rx_q, *first_tx_q;
+	u32 num_cq, num_rx, num_tx;
+
+	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
+
+	first_rx_q = ctx->data + num_rx + num_tx + num_cq;
+	first_tx_q = first_rx_q + vi->curr_queue_pairs * num_rx;
+
+	data = ctx->data;
+
+	stats_sum_queue(data, num_rx, first_rx_q, vi->curr_queue_pairs);
+
+	data = ctx->data + num_rx;
+
+	stats_sum_queue(data, num_tx, first_tx_q, vi->curr_queue_pairs);
+}
+
 /* virtnet_fill_stats - copy the stats to ethtool -S
  * The stats source is the device or the driver.
  *
@@ -3530,7 +3578,9 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 
 	queue_type = vq_type(vi, qid);
 	bitmap = ctx->bitmap[queue_type];
-	offset = 0;
+
+	/* skip the total fields of pairs */
+	offset = num_rx + num_tx;
 
 	if (queue_type == VIRTNET_Q_TYPE_TX) {
 		offset += num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
@@ -3741,6 +3791,10 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		/* Generate the total field names. */
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_RX, -1, &p);
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_TX, -1, &p);
+
 		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
 
 		for (i = 0; i < vi->curr_queue_pairs; ++i)
@@ -3764,7 +3818,8 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
-		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
+		return pair_count + ctx.desc_num[VIRTNET_Q_TYPE_CQ] +
+			vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3798,6 +3853,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 	}
+
+	virtnet_fill_total_fields(vi, &ctx);
 }
 
 static void virtnet_get_channels(struct net_device *dev,
-- 
2.32.0.3.g01195cf9f


