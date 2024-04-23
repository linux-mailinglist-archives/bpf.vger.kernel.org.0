Return-Path: <bpf+bounces-27536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976018AE406
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A973CB23BA8
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1785623;
	Tue, 23 Apr 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JGTg3cwD"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806785278;
	Tue, 23 Apr 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871920; cv=none; b=uBNkrulVVbxLj+aSFpZzbfVFWnVD0vx6smYUK3X95SQWSiJmaEl4JxauEaahK7xRgGcRHciwAZIxDJHeLIoq/ODUNxppTXddPmjShVa3sm2oMa2MUM/0lAiaXnvRbeUdrlNFEEd7SGbZIuVwlDkDoyimuBxG8NIHAjjDkctiSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871920; c=relaxed/simple;
	bh=EXTPP5AuAXTCkLO19qrRysI5zs1pn4K1SI570o/82eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ll9PelMkQ2ufNtBsyh/iCd5oR5QxNGVJHzMhpRMFRH1IdzuGJi/wKqT5QthFaKL1dfaupiTyvitMPto0vBngUTm5v396TzAr+3vEnra0TvZIXfWi6/2xCL+P9tsGrGooyD+BOXvg4VimD7l0F+OuJkVCMoBz3rbq9bat/H2MmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JGTg3cwD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871910; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IZFppeLH1d3MqL5PBllcng/AyoH22MqfCAkun1ouuWI=;
	b=JGTg3cwDNZDY53xZwt7Q2xTHtyTwXkW4h/yZ5eEE6LGAqWfUm1Iq1N+4ORVIKVXy7K7q3V6l72AY1qGGYDrYn5R72K/rezl5GAtvtgKqdG3r0O82jE5TMRHe87RJm933+9VPJ7VkUNJxszcO2n81m/VFOwRJ+E3L0yQHsGGxC8E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W591Z8X_1713871907;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W591Z8X_1713871907)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:48 +0800
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
Subject: [PATCH net-next v6 4/8] virtio_net: device stats helpers support driver stats
Date: Tue, 23 Apr 2024 19:31:37 +0800
Message-Id: <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
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

In the last commit, we introduced some helpers for device stats.
And the drivers stats are realized by the open code.
This commit make the helpers to support driver stats.
Then we can have the unify helper for device and driver stats.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 157 ++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 75 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index acae0c310688..6d24cd8fb15f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -102,32 +102,29 @@ struct virtnet_rq_stats {
 	u64_stats_t kicks;
 };
 
-#define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
-#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
+#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m)}
+#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m)}
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
-	{ "packets",		VIRTNET_SQ_STAT(packets) },
-	{ "bytes",		VIRTNET_SQ_STAT(bytes) },
-	{ "xdp_tx",		VIRTNET_SQ_STAT(xdp_tx) },
-	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
-	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
-	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
+	VIRTNET_SQ_STAT("packets",      packets),
+	VIRTNET_SQ_STAT("bytes",        bytes),
+	VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
+	VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
+	VIRTNET_SQ_STAT("kicks",        kicks),
+	VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
-	{ "packets",		VIRTNET_RQ_STAT(packets) },
-	{ "bytes",		VIRTNET_RQ_STAT(bytes) },
-	{ "drops",		VIRTNET_RQ_STAT(drops) },
-	{ "xdp_packets",	VIRTNET_RQ_STAT(xdp_packets) },
-	{ "xdp_tx",		VIRTNET_RQ_STAT(xdp_tx) },
-	{ "xdp_redirects",	VIRTNET_RQ_STAT(xdp_redirects) },
-	{ "xdp_drops",		VIRTNET_RQ_STAT(xdp_drops) },
-	{ "kicks",		VIRTNET_RQ_STAT(kicks) },
+	VIRTNET_RQ_STAT("packets",       packets),
+	VIRTNET_RQ_STAT("bytes",         bytes),
+	VIRTNET_RQ_STAT("drops",         drops),
+	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
+	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
+	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
+	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
+	VIRTNET_RQ_STAT("kicks",         kicks),
 };
 
-#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
-#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
-
 #define VIRTNET_STATS_DESC_CQ(name) \
 	{#name, offsetof(struct virtio_net_stats_cvq, name)}
 
@@ -2194,7 +2191,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
+	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
 		u64_stats_t *item, *src;
 
@@ -3347,16 +3344,13 @@ static void virtnet_stats_sprintf(u8 **p, const char *fmt, const char *noq_fmt,
 	}
 }
 
-static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
+static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	const struct virtnet_stat_desc *desc;
 	const char *fmt, *noq_fmt;
 	u8 *p = *data;
 	u32 num = 0;
 
-	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
-		return;
-
 	if (type == VIRTNET_Q_TYPE_CQ) {
 		noq_fmt = "cq_hw_%s";
 
@@ -3369,6 +3363,13 @@ static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int q
 	}
 
 	if (type == VIRTNET_Q_TYPE_RX) {
+		fmt = "rx%u_%s";
+
+		desc = &virtnet_rq_stats_desc[0];
+		num = ARRAY_SIZE(virtnet_rq_stats_desc);
+
+		virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+
 		fmt = "rx%u_hw_%s";
 
 		if (VIRTIO_NET_STATS_TYPE_RX_BASIC & vi->device_stats_cap) {
@@ -3394,6 +3395,13 @@ static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int q
 	}
 
 	if (type == VIRTNET_Q_TYPE_TX) {
+		fmt = "tx%u_%s";
+
+		desc = &virtnet_sq_stats_desc[0];
+		num = ARRAY_SIZE(virtnet_sq_stats_desc);
+
+		virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+
 		fmt = "tx%u_hw_%s";
 
 		if (VIRTIO_NET_STATS_TYPE_TX_BASIC & vi->device_stats_cap) {
@@ -3443,6 +3451,9 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 
 	ctx->data = data;
 
+	ctx->desc_num[VIRTNET_Q_TYPE_RX] = ARRAY_SIZE(virtnet_rq_stats_desc);
+	ctx->desc_num[VIRTNET_Q_TYPE_TX] = ARRAY_SIZE(virtnet_sq_stats_desc);
+
 	if (VIRTIO_NET_STATS_TYPE_CVQ & vi->device_stats_cap) {
 		queue_type = VIRTNET_Q_TYPE_CQ;
 
@@ -3493,37 +3504,55 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 }
 
 /* virtnet_fill_stats - copy the stats to ethtool -S
- * The stats source is the device.
+ * The stats source is the device or the driver.
  *
  * @vi: virtio net info
  * @qid: the vq id
  * @ctx: stats ctx (initiated by virtnet_stats_ctx_init())
- * @base: pointer to the device reply.
- * @type: the type of the device reply
+ * @base: pointer to the device reply or the driver stats structure.
+ * @drv_stats: designate the base type (device reply, driver stats)
+ * @type: the type of the device reply (if drv_stats is true, this must be zero)
  */
 static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 			       struct virtnet_stats_ctx *ctx,
-			       const u8 *base, u8 reply_type)
+			       const u8 *base, bool drv_stats, u8 reply_type)
 {
 	u32 queue_type, num_rx, num_tx, num_cq;
 	const struct virtnet_stat_desc *desc;
+	const u64_stats_t *v_stat;
 	u64 offset, bitmap;
 	const __le64 *v;
 	int i, num;
 
-	num_rx = VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_RX];
-	num_tx = VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_TX];
 	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
 
 	queue_type = vq_type(vi, qid);
 	bitmap = ctx->bitmap[queue_type];
 	offset = 0;
 
 	if (queue_type == VIRTNET_Q_TYPE_TX) {
-		offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
-		offset += VIRTNET_SQ_STATS_LEN;
+		offset += num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
+
+		num = ARRAY_SIZE(virtnet_sq_stats_desc);
+		if (drv_stats) {
+			desc = &virtnet_sq_stats_desc[0];
+			goto drv_stats;
+		}
+
+		offset += num;
+
 	} else if (queue_type == VIRTNET_Q_TYPE_RX) {
-		offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
+		offset += num_cq + num_rx * (qid / 2);
+
+		num = ARRAY_SIZE(virtnet_rq_stats_desc);
+		if (drv_stats) {
+			desc = &virtnet_rq_stats_desc[0];
+			goto drv_stats;
+		}
+
+		offset += num;
 	}
 
 	if (VIRTIO_NET_STATS_TYPE_CVQ & bitmap) {
@@ -3596,6 +3625,14 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 		v = (const __le64 *)(base + desc[i].offset);
 		ctx->data[offset + i] = le64_to_cpu(*v);
 	}
+
+	return;
+
+drv_stats:
+	for (i = 0; i < num; ++i) {
+		v_stat = (const u64_stats_t *)(base + desc[i].offset);
+		ctx->data[offset + i] = u64_stats_read(v_stat);
+	}
 }
 
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
@@ -3622,7 +3659,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
-		virtnet_fill_stats(vi, qid, ctx, p, hdr->type);
+		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
 	return 0;
@@ -3699,28 +3736,18 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	unsigned int i, j;
+	unsigned int i;
 	u8 *p = data;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
-
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "rx%u_%s", i,
-						virtnet_rq_stats_desc[j].desc);
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
 
-			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
-		}
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
 
-		for (i = 0; i < vi->curr_queue_pairs; i++) {
-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "tx%u_%s", i,
-						virtnet_sq_stats_desc[j].desc);
-
-			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
-		}
+		for (i = 0; i < vi->curr_queue_pairs; ++i)
+			virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
 		break;
 	}
 }
@@ -3735,8 +3762,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 	case ETH_SS_STATS:
 		virtnet_stats_ctx_init(vi, &ctx, NULL);
 
-		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
-		pair_count += ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
+		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
 		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
 	default:
@@ -3749,47 +3775,28 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtnet_stats_ctx ctx = {0};
-	unsigned int idx, start, i, j;
+	unsigned int start, i;
 	const u8 *stats_base;
-	const u64_stats_t *p;
-	size_t offset;
 
 	virtnet_stats_ctx_init(vi, &ctx, data);
 	if (virtnet_get_hw_stats(vi, &ctx))
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
-	idx = ctx.desc_num[VIRTNET_Q_TYPE_CQ];
-
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
+		struct send_queue *sq = &vi->sq[i];
 
 		stats_base = (const u8 *)&rq->stats;
 		do {
 			start = u64_stats_fetch_begin(&rq->stats.syncp);
-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
-				offset = virtnet_rq_stats_desc[j].offset;
-				p = (const u64_stats_t *)(stats_base + offset);
-				data[idx + j] = u64_stats_read(p);
-			}
+			virtnet_fill_stats(vi, i * 2, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
-		idx += VIRTNET_RQ_STATS_LEN;
-		idx += ctx.desc_num[VIRTNET_Q_TYPE_RX];
-	}
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct send_queue *sq = &vi->sq[i];
 
 		stats_base = (const u8 *)&sq->stats;
 		do {
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
-				offset = virtnet_sq_stats_desc[j].offset;
-				p = (const u64_stats_t *)(stats_base + offset);
-				data[idx + j] = u64_stats_read(p);
-			}
+			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
-		idx += VIRTNET_SQ_STATS_LEN;
-		idx += ctx.desc_num[VIRTNET_Q_TYPE_TX];
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


