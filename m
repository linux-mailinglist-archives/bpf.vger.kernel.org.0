Return-Path: <bpf+bounces-27537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C58AE409
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2D01C223AF
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5585930;
	Tue, 23 Apr 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MwU8eysK"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F285287;
	Tue, 23 Apr 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871921; cv=none; b=ZBbB6kHzLEzhY6YU8ggrAbSZ5ZJ00ciNNpHI0T7b1joQ6qf+AQPk/fVKSqpSOHkQs4bvRmGk3MAtOHP1wA0WY4btmR5qBvFfk+MQQ+G431GoT0i3hyCbybYkZxbf9f09UMJ68KHjCdqAvvB/I97rvJU0ECxDAsgE3tUQywBusKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871921; c=relaxed/simple;
	bh=1jtpcWgjoCh73JvlWjZiAJuPjO4+9ruY5D3Z66Qefz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/aiIE/HmvW8AaggUABmeu6joSPblBaAuA0hmeB3bcTRs8Elzc5sInvlP7idcrwa5M4AsiNSBFXca3d377yKA/h71N0SCKFE2HT3YmEvYQrM3MIRpuE337tlW43rNJQFckheWf7+QWevvREFSRIQx+GvpOgFAF+23j16vpHTWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MwU8eysK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871916; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OxkOzBk9LeDfb7JH999d2oC0hw5ai5ZleQXXWY4x2zc=;
	b=MwU8eysKkoN7AWzJVVAbj1/w3DGEZ77d5sZAigLYqdOnHtrdqm/McLbYCNh3nYP6ff6sQI5w6RKtOJjl1nX2WLmZ5Q6EpAbfEG6R5SjTwsWzV01/Q2QJUFrOcxrprhVWrp4M5ItzGHxrA4xNZizaEPSnsHZ89wHrXyH5Lw8/ntw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W591ZBw_1713871914;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W591ZBw_1713871914)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:55 +0800
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
Subject: [PATCH net-next v6 8/8] virtio-net: support queue stat
Date: Tue, 23 Apr 2024 19:31:41 +0800
Message-Id: <20240423113141.1752-9-xuanzhuo@linux.alibaba.com>
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

To enhance functionality, we now support reporting statistics through
the netdev-generic netlink (netdev-genl) queue stats interface. However,
this does not extend to all statistics, so a new field, qstat_offset,
has been introduced. This field determines which statistics should be
reported via netdev-genl queue stats.

Given that queue stats are retrieved individually per queue, it's
necessary for the virtnet_get_hw_stats() function to be capable of
fetching statistics for a specific queue.

As the document https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors

We should not duplicate the stats which get reported via the netlink API in
ethtool. If the stats are for queue stat, that will not be reported by
ethtool -S.

python3 ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml
    --dump qstats-get --json '{"scope": "queue"}'
[{'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-bytes': 157844011,
  'rx-csum-bad': 0,
  'rx-csum-none': 0,
  'rx-csum-unnecessary': 2195386,
  'rx-hw-drop-overruns': 0,
  'rx-hw-drop-ratelimits': 0,
  'rx-hw-drops': 12964,
  'rx-packets': 598929},
 {'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 1938511,
  'tx-csum-none': 0,
  'tx-hw-drop-errors': 0,
  'tx-hw-drop-ratelimits': 0,
  'tx-hw-drops': 0,
  'tx-needs-csum': 61263,
  'tx-packets': 15515}]

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 369 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 348 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51ce2308f4f5..446a44a5cad9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -24,6 +24,7 @@
 #include <net/xdp.h>
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
+#include <net/netdev_queues.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -78,6 +79,7 @@ static const unsigned long guest_offloads[] = {
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
 	size_t offset;
+	size_t qstat_offset;
 };
 
 struct virtnet_sq_stats {
@@ -102,12 +104,24 @@ struct virtnet_rq_stats {
 	u64_stats_t kicks;
 };
 
-#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m)}
-#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m)}
+#define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
+#define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m), -1}
+
+#define VIRTNET_SQ_STAT_QSTAT(name, m)				\
+	{							\
+		name,						\
+		offsetof(struct virtnet_sq_stats, m),		\
+		offsetof(struct netdev_queue_stats_tx, m),	\
+	}
+
+#define VIRTNET_RQ_STAT_QSTAT(name, m)				\
+	{							\
+		name,						\
+		offsetof(struct virtnet_rq_stats, m),		\
+		offsetof(struct netdev_queue_stats_rx, m),	\
+	}
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
-	VIRTNET_SQ_STAT("packets",      packets),
-	VIRTNET_SQ_STAT("bytes",        bytes),
 	VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
 	VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
 	VIRTNET_SQ_STAT("kicks",        kicks),
@@ -115,8 +129,6 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
-	VIRTNET_RQ_STAT("packets",       packets),
-	VIRTNET_RQ_STAT("bytes",         bytes),
 	VIRTNET_RQ_STAT("drops",         drops),
 	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
 	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
@@ -125,14 +137,25 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	VIRTNET_RQ_STAT("kicks",         kicks),
 };
 
+static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
+	VIRTNET_SQ_STAT_QSTAT("packets", packets),
+	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
+};
+
+static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
+	VIRTNET_RQ_STAT_QSTAT("packets", packets),
+	VIRTNET_RQ_STAT_QSTAT("bytes",   bytes),
+};
+
 #define VIRTNET_STATS_DESC_CQ(name) \
-	{#name, offsetof(struct virtio_net_stats_cvq, name)}
+	{#name, offsetof(struct virtio_net_stats_cvq, name), -1}
 
 #define VIRTNET_STATS_DESC_RX(class, name) \
-	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name)}
+	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name), -1}
 
 #define VIRTNET_STATS_DESC_TX(class, name) \
-	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name)}
+	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name), -1}
+
 
 static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
 	VIRTNET_STATS_DESC_CQ(command_num),
@@ -172,6 +195,63 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
 	VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
 };
 
+#define VIRTNET_STATS_DESC_RX_QSTAT(class, name, qstat_field)			\
+	{									\
+		#name,								\
+		offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name),	\
+		offsetof(struct netdev_queue_stats_rx, qstat_field),		\
+	}
+
+#define VIRTNET_STATS_DESC_TX_QSTAT(class, name, qstat_field)			\
+	{									\
+		#name,								\
+		offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name),	\
+		offsetof(struct netdev_queue_stats_tx, qstat_field),		\
+	}
+
+static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc_qstat[] = {
+	VIRTNET_STATS_DESC_RX_QSTAT(basic, drops,         hw_drops),
+	VIRTNET_STATS_DESC_RX_QSTAT(basic, drop_overruns, hw_drop_overruns),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc_qstat[] = {
+	VIRTNET_STATS_DESC_TX_QSTAT(basic, drops,          hw_drops),
+	VIRTNET_STATS_DESC_TX_QSTAT(basic, drop_malformed, hw_drop_errors),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc_qstat[] = {
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_valid, csum_unnecessary),
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_none,  csum_none),
+	VIRTNET_STATS_DESC_RX_QSTAT(csum, csum_bad,   csum_bad),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc_qstat[] = {
+	VIRTNET_STATS_DESC_TX_QSTAT(csum, csum_none,  csum_none),
+	VIRTNET_STATS_DESC_TX_QSTAT(csum, needs_csum, needs_csum),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc_qstat[] = {
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_packets,           hw_gro_packets),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_bytes,             hw_gro_bytes),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_packets_coalesced, hw_gro_wire_packets),
+	VIRTNET_STATS_DESC_RX_QSTAT(gso, gso_bytes_coalesced,   hw_gro_wire_bytes),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc_qstat[] = {
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_packets,        hw_gso_packets),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_bytes,          hw_gso_bytes),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_segments,       hw_gso_wire_packets),
+	VIRTNET_STATS_DESC_TX_QSTAT(gso, gso_segments_bytes, hw_gso_wire_bytes),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc_qstat[] = {
+	VIRTNET_STATS_DESC_RX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
+	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -2199,6 +2279,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		src = (u64_stats_t *)((u8 *)&stats + offset);
 		u64_stats_add(item, u64_stats_read(src));
 	}
+
+	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
+	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
+
 	u64_stats_update_end(&rq->stats.syncp);
 
 	return packets;
@@ -3435,6 +3519,9 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 }
 
 struct virtnet_stats_ctx {
+	/* The stats are write to qstats or ethtool -S */
+	bool to_qstat;
+
 	/* Used to calculate the offset inside the output buffer. */
 	u32 desc_num[3];
 
@@ -3450,11 +3537,71 @@ struct virtnet_stats_ctx {
 
 static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 				   struct virtnet_stats_ctx *ctx,
-				   u64 *data)
+				   u64 *data, bool to_qstat)
 {
 	u32 queue_type;
 
 	ctx->data = data;
+	ctx->to_qstat = to_qstat;
+
+	if (to_qstat) {
+		ctx->desc_num[VIRTNET_Q_TYPE_RX] = ARRAY_SIZE(virtnet_rq_stats_desc_qstat);
+		ctx->desc_num[VIRTNET_Q_TYPE_TX] = ARRAY_SIZE(virtnet_sq_stats_desc_qstat);
+
+		queue_type = VIRTNET_Q_TYPE_RX;
+
+		if (VIRTIO_NET_STATS_TYPE_RX_BASIC & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_BASIC;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_basic_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_basic);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_RX_CSUM & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_CSUM;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_csum_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_csum);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_RX_GSO & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_GSO;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_gso_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_gso);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_RX_SPEED & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_SPEED;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_speed_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_speed);
+		}
+
+		queue_type = VIRTNET_Q_TYPE_TX;
+
+		if (VIRTIO_NET_STATS_TYPE_TX_BASIC & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_BASIC;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_basic_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_basic);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_TX_CSUM & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_CSUM;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_csum_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_csum);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_TX_GSO & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_GSO;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_gso_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_gso);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_TX_SPEED & vi->device_stats_cap) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_SPEED;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_speed_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_speed);
+		}
+
+		return;
+	}
 
 	ctx->desc_num[VIRTNET_Q_TYPE_RX] = ARRAY_SIZE(virtnet_rq_stats_desc);
 	ctx->desc_num[VIRTNET_Q_TYPE_TX] = ARRAY_SIZE(virtnet_sq_stats_desc);
@@ -3551,7 +3698,104 @@ static void virtnet_fill_total_fields(struct virtnet_info *vi,
 	stats_sum_queue(data, num_tx, first_tx_q, vi->curr_queue_pairs);
 }
 
-/* virtnet_fill_stats - copy the stats to ethtool -S
+static void virtnet_fill_stats_qstat(struct virtnet_info *vi, u32 qid,
+				     struct virtnet_stats_ctx *ctx,
+				     const u8 *base, bool drv_stats, u8 reply_type)
+{
+	const struct virtnet_stat_desc *desc;
+	const u64_stats_t *v_stat;
+	u64 offset, bitmap;
+	const __le64 *v;
+	u32 queue_type;
+	int i, num;
+
+	queue_type = vq_type(vi, qid);
+	bitmap = ctx->bitmap[queue_type];
+
+	if (drv_stats) {
+		if (queue_type == VIRTNET_Q_TYPE_RX) {
+			desc = &virtnet_rq_stats_desc_qstat[0];
+			num = ARRAY_SIZE(virtnet_rq_stats_desc_qstat);
+		} else {
+			desc = &virtnet_sq_stats_desc_qstat[0];
+			num = ARRAY_SIZE(virtnet_sq_stats_desc_qstat);
+		}
+
+		for (i = 0; i < num; ++i) {
+			offset = desc[i].qstat_offset / sizeof(*ctx->data);
+			v_stat = (const u64_stats_t *)(base + desc[i].offset);
+			ctx->data[offset] = u64_stats_read(v_stat);
+		}
+		return;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_BASIC & bitmap) {
+		desc = &virtnet_stats_rx_basic_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_basic_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_CSUM & bitmap) {
+		desc = &virtnet_stats_rx_csum_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_csum_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_GSO & bitmap) {
+		desc = &virtnet_stats_rx_gso_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_gso_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_SPEED & bitmap) {
+		desc = &virtnet_stats_rx_speed_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_speed_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_BASIC & bitmap) {
+		desc = &virtnet_stats_tx_basic_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_basic_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_CSUM & bitmap) {
+		desc = &virtnet_stats_tx_csum_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_csum_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_GSO & bitmap) {
+		desc = &virtnet_stats_tx_gso_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_gso_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO)
+			goto found;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_SPEED & bitmap) {
+		desc = &virtnet_stats_tx_speed_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_speed_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED)
+			goto found;
+	}
+
+	return;
+
+found:
+	for (i = 0; i < num; ++i) {
+		offset = desc[i].qstat_offset / sizeof(*ctx->data);
+		v = (const __le64 *)(base + desc[i].offset);
+		ctx->data[offset] = le64_to_cpu(*v);
+	}
+}
+
+/* virtnet_fill_stats - copy the stats to qstats or ethtool -S
  * The stats source is the device or the driver.
  *
  * @vi: virtio net info
@@ -3572,6 +3816,9 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	const __le64 *v;
 	int i, num;
 
+	if (ctx->to_qstat)
+		return virtnet_fill_stats_qstat(vi, qid, ctx, base, drv_stats, reply_type);
+
 	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
 	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
 	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
@@ -3731,22 +3978,34 @@ static void virtnet_make_stat_req(struct virtnet_info *vi,
 	*idx += 1;
 }
 
+/* qid: -1: get stats of all vq.
+ *     > 0: get the stats for the special vq. This must not be cvq.
+ */
 static int virtnet_get_hw_stats(struct virtnet_info *vi,
-				struct virtnet_stats_ctx *ctx)
+				struct virtnet_stats_ctx *ctx, int qid)
 {
+	int qnum, i, j, res_size, qtype, last_vq, first_vq;
 	struct virtio_net_ctrl_queue_stats *req;
-	int qnum, i, j, res_size, qtype, last_vq;
+	bool enable_cvq;
 	void *reply;
 	int ok;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
 		return 0;
 
-	last_vq = vi->curr_queue_pairs * 2 - 1;
+	if (qid == -1) {
+		last_vq = vi->curr_queue_pairs * 2 - 1;
+		first_vq = 0;
+		enable_cvq = true;
+	} else {
+		last_vq = qid;
+		first_vq = qid;
+		enable_cvq = false;
+	}
 
 	qnum = 0;
 	res_size = 0;
-	for (i = 0; i <= last_vq ; ++i) {
+	for (i = first_vq; i <= last_vq ; ++i) {
 		qtype = vq_type(vi, i);
 		if (ctx->bitmap[qtype]) {
 			++qnum;
@@ -3754,7 +4013,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 		}
 	}
 
-	if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
+	if (enable_cvq && ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
 		res_size += ctx->size[VIRTNET_Q_TYPE_CQ];
 		qnum += 1;
 	}
@@ -3770,10 +4029,11 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	}
 
 	j = 0;
-	for (i = 0; i <= last_vq ; ++i)
+	for (i = first_vq; i <= last_vq ; ++i)
 		virtnet_make_stat_req(vi, ctx, req, i, &j);
 
-	virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+	if (enable_cvq)
+		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
 	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
 
@@ -3814,7 +4074,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		virtnet_stats_ctx_init(vi, &ctx, NULL);
+		virtnet_stats_ctx_init(vi, &ctx, NULL, false);
 
 		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
@@ -3833,8 +4093,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	unsigned int start, i;
 	const u8 *stats_base;
 
-	virtnet_stats_ctx_init(vi, &ctx, data);
-	if (virtnet_get_hw_stats(vi, &ctx))
+	virtnet_stats_ctx_init(vi, &ctx, data, false);
+	if (virtnet_get_hw_stats(vi, &ctx, -1))
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -4373,6 +4633,72 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
+static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
+				       struct netdev_queue_stats_rx *stats)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct receive_queue *rq = &vi->rq[i];
+	struct virtnet_stats_ctx ctx = {0};
+
+	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
+
+	virtnet_get_hw_stats(vi, &ctx, i * 2);
+	virtnet_fill_stats(vi, i * 2, &ctx, (void *)&rq->stats, true, 0);
+}
+
+static void virtnet_get_queue_stats_tx(struct net_device *dev, int i,
+				       struct netdev_queue_stats_tx *stats)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq = &vi->sq[i];
+	struct virtnet_stats_ctx ctx = {0};
+
+	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
+
+	virtnet_get_hw_stats(vi, &ctx, i * 2 + 1);
+	virtnet_fill_stats(vi, i * 2 + 1, &ctx, (void *)&sq->stats, true, 0);
+}
+
+static void virtnet_get_base_stats(struct net_device *dev,
+				   struct netdev_queue_stats_rx *rx,
+				   struct netdev_queue_stats_tx *tx)
+{
+	/* The queue stats of the virtio-net will not be reset. So here we
+	 * return 0.
+	 */
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->hw_drops = 0;
+	rx->hw_drop_overruns = 0;
+	rx->csum_unnecessary = 0;
+	rx->csum_none = 0;
+	rx->csum_bad = 0;
+	rx->hw_gro_packets = 0;
+	rx->hw_gro_bytes = 0;
+	rx->hw_gro_wire_packets = 0;
+	rx->hw_gro_wire_bytes = 0;
+	rx->hw_drop_ratelimits = 0;
+
+	tx->bytes = 0;
+	tx->packets = 0;
+	tx->hw_drops = 0;
+	tx->hw_drop_errors = 0;
+	tx->csum_none = 0;
+	tx->needs_csum = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_bytes = 0;
+	tx->hw_gso_wire_packets = 0;
+	tx->hw_gso_wire_bytes = 0;
+	tx->hw_drop_ratelimits = 0;
+}
+
+static const struct netdev_stat_ops virtnet_stat_ops = {
+	.get_queue_stats_rx	= virtnet_get_queue_stats_rx,
+	.get_queue_stats_tx	= virtnet_get_queue_stats_tx,
+	.get_base_stats		= virtnet_get_base_stats,
+};
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5131,6 +5457,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
 			   IFF_TX_SKB_NO_LINEAR;
 	dev->netdev_ops = &virtnet_netdev;
+	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
-- 
2.32.0.3.g01195cf9f


