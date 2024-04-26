Return-Path: <bpf+bounces-27887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B68B2F28
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC076B20D8F
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7078C77;
	Fri, 26 Apr 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GEb5z5oA"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8D7D410;
	Fri, 26 Apr 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102788; cv=none; b=lP2kCARPBmee6YqvaQUHkiLjyjqNc06tTmupMvBp7fRqwPjCGgbQv4YL4238PKIFkgmJEA1CfEFS1efV8PEHjcNsJh+FVZ2sDbbMWFshvfxIW8+s5pOiKxd3uKBuzELf/HdwfSltI+wM9jnQ0TajCKAfGuMQwFioOgOPTnw1TsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102788; c=relaxed/simple;
	bh=ziga6Ks9vwAPQR0IAxhLr4qg14lIDBDnJELVCLsGGG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+kz/KhutzfTN/Qb4/i0/60nFfRRpL/kq88uIldHO3E6F5oi5ey65ZdwmkAfotIVZhCXjorr5RPAgT2Sjqe5G47quB3HT/ZmI1TRKyN0B+6gX3f71hvhxfKzYpkqDOD59GCeKw6PFNEfZUSa77TkfTH4tcBGxLLUxCznkUueLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GEb5z5oA; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102783; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VvNUw7difxlwaYE9O914MVFWrfjWc5uUTo+OA4gyiFU=;
	b=GEb5z5oA6HgoLxdpCjDBM8m64qYrfE9oiXlQULQZJGqhU5T5F3SNkOPRIVi4swY8qlRxD2SM0ZIlxZaVcZTsoJzOX5rzJQvmiPh+n9FBl9hFJtMjktR49D1yAyMQOoHovrhjn0OVqR9lpEfgraG+mgbCVynq7ISaT46ePKD240A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5Hk9gG_1714102780;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Hk9gG_1714102780)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:41 +0800
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
Subject: [PATCH net-next v7 8/8] virtio-net: support queue stat
Date: Fri, 26 Apr 2024 11:39:28 +0800
Message-Id: <20240426033928.77778-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 435b736161fa
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
 drivers/net/virtio_net.c | 392 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 371 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ad008fe05fb3..1fa84790041b 100644
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
 
 struct virtnet_sq_free_stats {
@@ -107,12 +109,24 @@ struct virtnet_rq_stats {
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
@@ -120,8 +134,6 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
-	VIRTNET_RQ_STAT("packets",       packets),
-	VIRTNET_RQ_STAT("bytes",         bytes),
 	VIRTNET_RQ_STAT("drops",         drops),
 	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
 	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
@@ -130,14 +142,25 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
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
@@ -177,6 +200,63 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
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
@@ -2215,6 +2295,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		src = (u64_stats_t *)((u8 *)&stats + offset);
 		u64_stats_add(item, u64_stats_read(src));
 	}
+
+	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
+	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
+
 	u64_stats_update_end(&rq->stats.syncp);
 
 	return packets;
@@ -3474,6 +3558,9 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 }
 
 struct virtnet_stats_ctx {
+	/* The stats are write to qstats or ethtool -S */
+	bool to_qstat;
+
 	/* Used to calculate the offset inside the output buffer. */
 	u32 desc_num[3];
 
@@ -3489,11 +3576,71 @@ struct virtnet_stats_ctx {
 
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
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_BASIC) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_BASIC;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_basic_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_basic);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_CSUM) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_CSUM;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_csum_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_csum);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_GSO) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_GSO;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_gso_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_gso);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_SPEED) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_SPEED;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_speed_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_speed);
+		}
+
+		queue_type = VIRTNET_Q_TYPE_TX;
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_BASIC;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_basic_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_basic);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_CSUM) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_CSUM;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_csum_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_csum);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_GSO) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_GSO;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_gso_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_gso);
+		}
+
+		if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_SPEED) {
+			ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_SPEED;
+			ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_speed_desc_qstat);
+			ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_speed);
+		}
+
+		return;
+	}
 
 	ctx->desc_num[VIRTNET_Q_TYPE_RX] = ARRAY_SIZE(virtnet_rq_stats_desc);
 	ctx->desc_num[VIRTNET_Q_TYPE_TX] = ARRAY_SIZE(virtnet_sq_stats_desc);
@@ -3590,7 +3737,104 @@ static void virtnet_fill_total_fields(struct virtnet_info *vi,
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
+	if (bitmap & VIRTIO_NET_STATS_TYPE_RX_BASIC) {
+		desc = &virtnet_stats_rx_basic_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_basic_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_RX_CSUM) {
+		desc = &virtnet_stats_rx_csum_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_csum_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_RX_GSO) {
+		desc = &virtnet_stats_rx_gso_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_gso_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_RX_SPEED) {
+		desc = &virtnet_stats_rx_speed_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_speed_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
+		desc = &virtnet_stats_tx_basic_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_basic_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_TX_CSUM) {
+		desc = &virtnet_stats_tx_csum_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_csum_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_TX_GSO) {
+		desc = &virtnet_stats_tx_gso_desc_qstat[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_gso_desc_qstat);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO)
+			goto found;
+	}
+
+	if (bitmap & VIRTIO_NET_STATS_TYPE_TX_SPEED) {
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
@@ -3611,6 +3855,9 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	const __le64 *v;
 	int i, num;
 
+	if (ctx->to_qstat)
+		return virtnet_fill_stats_qstat(vi, qid, ctx, base, drv_stats, reply_type);
+
 	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
 	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
 	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
@@ -3770,22 +4017,34 @@ static void virtnet_make_stat_req(struct virtnet_info *vi,
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
@@ -3793,7 +4052,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 		}
 	}
 
-	if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
+	if (enable_cvq && ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
 		res_size += ctx->size[VIRTNET_Q_TYPE_CQ];
 		qnum += 1;
 	}
@@ -3809,10 +4068,11 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	}
 
 	j = 0;
-	for (i = 0; i <= last_vq ; ++i)
+	for (i = first_vq; i <= last_vq ; ++i)
 		virtnet_make_stat_req(vi, ctx, req, i, &j);
 
-	virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+	if (enable_cvq)
+		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
 	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
 
@@ -3853,7 +4113,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		virtnet_stats_ctx_init(vi, &ctx, NULL);
+		virtnet_stats_ctx_init(vi, &ctx, NULL, false);
 
 		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
@@ -3872,8 +4132,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	unsigned int start, i;
 	const u8 *stats_base;
 
-	virtnet_stats_ctx_init(vi, &ctx, data);
-	if (virtnet_get_hw_stats(vi, &ctx))
+	virtnet_stats_ctx_init(vi, &ctx, data, false);
+	if (virtnet_get_hw_stats(vi, &ctx, -1))
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -4428,6 +4688,95 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
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
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	/* The queue stats of the virtio-net will not be reset. So here we
+	 * return 0.
+	 */
+	rx->bytes = 0;
+	rx->packets = 0;
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_BASIC) {
+		rx->hw_drops = 0;
+		rx->hw_drop_overruns = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_CSUM) {
+		rx->csum_unnecessary = 0;
+		rx->csum_none = 0;
+		rx->csum_bad = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_GSO) {
+		rx->hw_gro_packets = 0;
+		rx->hw_gro_bytes = 0;
+		rx->hw_gro_wire_packets = 0;
+		rx->hw_gro_wire_bytes = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_SPEED)
+		rx->hw_drop_ratelimits = 0;
+
+	tx->bytes = 0;
+	tx->packets = 0;
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
+		tx->hw_drops = 0;
+		tx->hw_drop_errors = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_CSUM) {
+		tx->csum_none = 0;
+		tx->needs_csum = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_GSO) {
+		tx->hw_gso_packets = 0;
+		tx->hw_gso_bytes = 0;
+		tx->hw_gso_wire_packets = 0;
+		tx->hw_gso_wire_bytes = 0;
+	}
+
+	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_SPEED)
+		tx->hw_drop_ratelimits = 0;
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
@@ -5231,6 +5580,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
 			   IFF_TX_SKB_NO_LINEAR;
 	dev->netdev_ops = &virtnet_netdev;
+	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
-- 
2.32.0.3.g01195cf9f


