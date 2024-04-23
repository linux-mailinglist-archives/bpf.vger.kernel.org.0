Return-Path: <bpf+bounces-27533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CE8AE3FC
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7191C224E4
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29284A21;
	Tue, 23 Apr 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JbUDg+pb"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA618004E;
	Tue, 23 Apr 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871914; cv=none; b=Owtl6WKJ41Zr91JY76xrYnICh/HLquNZS/D+k1bGdKzruwAJB09a//8GegGElIReIxJXBYSWxdafOy9Y0tsoqm3XIOPnfjiIo5Ddi9MAh69Opy9tSUxz6yxN3emv/p3SOMVFTfPT/0ARw/PGGYDIIxYQNkKNTAahKSNl3JTxRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871914; c=relaxed/simple;
	bh=uIiWMYrcJifIQXHUo+DjMa00IxnJ7lWREDIAJfI9SII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaM7SrVqD5yftZ5TdaTT0iBNCAMl7V9PW1lfFv8xVHLXE/Rlgf4qld+cY0x+sqeQXjt+Lh8NFCQN2GJPdvJtiVTLjjpClep/X35yBVIbnVZMQqSMHVu+j8cWn5cOZjuUotGWYg8ueR0AS/TGLJtCIoMhmYTSLI/npsH8umgF+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JbUDg+pb; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871908; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V9oAS4CIshZzTfqf7tTuRNrroNwYJY0NXx6SGPJpT8o=;
	b=JbUDg+pbz/KrL8y+sOkMwlZLs6elTTQskXSnm4lXZ16+Pip2JHpuerrTsuafYhxnQy7dY8CBCetSXAcKW97eEiZvdGHQyckJw7QKZrs0NmSKGJWlQfqW7Rr0Z9AfUEDL5FaHoDPS7/JF/r2rlQveOI56MuzuDzU3Y15ZLIpEDCQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W591Z7U_1713871906;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W591Z7U_1713871906)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:47 +0800
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
Subject: [PATCH net-next v6 3/8] virtio_net: support device stats
Date: Tue, 23 Apr 2024 19:31:36 +0800
Message-Id: <20240423113141.1752-4-xuanzhuo@linux.alibaba.com>
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

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

make virtio-net support getting the stats from the device by ethtool -S
<eth0>.

NIC statistics:
     rx0_packets: 582951
     rx0_bytes: 155307077
     rx0_drops: 0
     rx0_xdp_packets: 0
     rx0_xdp_tx: 0
     rx0_xdp_redirects: 0
     rx0_xdp_drops: 0
     rx0_kicks: 17007
     rx0_hw_packets: 2179409
     rx0_hw_bytes: 510015040
     rx0_hw_notifications: 0
     rx0_hw_interrupts: 0
     rx0_hw_needs_csum: 2179409
     rx0_hw_ratelimit_bytes: 0
     tx0_packets: 15361
     tx0_bytes: 1918970
     tx0_xdp_tx: 0
     tx0_xdp_tx_drops: 0
     tx0_kicks: 15361
     tx0_timeouts: 0
     tx0_hw_packets: 32272
     tx0_hw_bytes: 4311698
     tx0_hw_notifications: 0
     tx0_hw_interrupts: 0
     tx0_hw_ratelimit_bytes: 0

The follow stats are hidden, there are exported by the queue stat API
in the subsequent comment.

    VIRTNET_STATS_DESC_RX(basic, drops)
    VIRTNET_STATS_DESC_RX(basic, drop_overruns),
    VIRTNET_STATS_DESC_TX(basic, drops),
    VIRTNET_STATS_DESC_TX(basic, drop_malformed),
    VIRTNET_STATS_DESC_RX(csum, csum_valid),
    VIRTNET_STATS_DESC_RX(csum, csum_none),
    VIRTNET_STATS_DESC_RX(csum, csum_bad),
    VIRTNET_STATS_DESC_TX(csum, needs_csum),
    VIRTNET_STATS_DESC_TX(csum, csum_none),
    VIRTNET_STATS_DESC_RX(gso, gso_packets),
    VIRTNET_STATS_DESC_RX(gso, gso_bytes),
    VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
    VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
    VIRTNET_STATS_DESC_TX(gso, gso_packets),
    VIRTNET_STATS_DESC_TX(gso, gso_bytes),
    VIRTNET_STATS_DESC_TX(gso, gso_segments),
    VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
    VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
    VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 476 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 472 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bd90f9d3d9b7..acae0c310688 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -128,6 +128,57 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
+#define VIRTNET_STATS_DESC_CQ(name) \
+	{#name, offsetof(struct virtio_net_stats_cvq, name)}
+
+#define VIRTNET_STATS_DESC_RX(class, name) \
+	{#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## name)}
+
+#define VIRTNET_STATS_DESC_TX(class, name) \
+	{#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## name)}
+
+static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
+	VIRTNET_STATS_DESC_CQ(command_num),
+	VIRTNET_STATS_DESC_CQ(ok_num),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
+	VIRTNET_STATS_DESC_RX(basic, packets),
+	VIRTNET_STATS_DESC_RX(basic, bytes),
+
+	VIRTNET_STATS_DESC_RX(basic, notifications),
+	VIRTNET_STATS_DESC_RX(basic, interrupts),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
+	VIRTNET_STATS_DESC_TX(basic, packets),
+	VIRTNET_STATS_DESC_TX(basic, bytes),
+
+	VIRTNET_STATS_DESC_TX(basic, notifications),
+	VIRTNET_STATS_DESC_TX(basic, interrupts),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
+	VIRTNET_STATS_DESC_RX(csum, needs_csum),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
+	VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
+	VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
+	VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
+};
+
+static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
+	VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
+};
+
+#define VIRTNET_Q_TYPE_RX 0
+#define VIRTNET_Q_TYPE_TX 1
+#define VIRTNET_Q_TYPE_CQ 2
+
 struct virtnet_interrupt_coalesce {
 	u32 max_packets;
 	u32 max_usecs;
@@ -244,6 +295,7 @@ struct control_buf {
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
+	struct virtio_net_stats_capabilities stats_cap;
 };
 
 struct virtnet_info {
@@ -329,6 +381,8 @@ struct virtnet_info {
 
 	/* failover when STANDBY feature enabled */
 	struct failover *failover;
+
+	u64 device_stats_cap;
 };
 
 struct padded_vnet_hdr {
@@ -389,6 +443,17 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
+static int vq_type(struct virtnet_info *vi, int qid)
+{
+	if (qid == vi->max_queue_pairs * 2)
+		return VIRTNET_Q_TYPE_CQ;
+
+	if (qid % 2)
+		return VIRTNET_Q_TYPE_TX;
+
+	return VIRTNET_Q_TYPE_RX;
+}
+
 static inline struct virtio_net_common_hdr *
 skb_vnet_common_hdr(struct sk_buff *skb)
 {
@@ -3268,6 +3333,369 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+static void virtnet_stats_sprintf(u8 **p, const char *fmt, const char *noq_fmt,
+				  int num, int qid, const struct virtnet_stat_desc *desc)
+{
+	int i;
+
+	if (qid < 0) {
+		for (i = 0; i < num; ++i)
+			ethtool_sprintf(p, noq_fmt, desc[i].desc);
+	} else {
+		for (i = 0; i < num; ++i)
+			ethtool_sprintf(p, fmt, qid, desc[i].desc);
+	}
+}
+
+static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
+{
+	const struct virtnet_stat_desc *desc;
+	const char *fmt, *noq_fmt;
+	u8 *p = *data;
+	u32 num = 0;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
+		return;
+
+	if (type == VIRTNET_Q_TYPE_CQ) {
+		noq_fmt = "cq_hw_%s";
+
+		if (VIRTIO_NET_STATS_TYPE_CVQ & vi->device_stats_cap) {
+			desc = &virtnet_stats_cvq_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_cvq_desc);
+
+			virtnet_stats_sprintf(&p, NULL, noq_fmt, num, -1, desc);
+		}
+	}
+
+	if (type == VIRTNET_Q_TYPE_RX) {
+		fmt = "rx%u_hw_%s";
+
+		if (VIRTIO_NET_STATS_TYPE_RX_BASIC & vi->device_stats_cap) {
+			desc = &virtnet_stats_rx_basic_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_rx_basic_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_RX_CSUM & vi->device_stats_cap) {
+			desc = &virtnet_stats_rx_csum_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_rx_csum_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_RX_SPEED & vi->device_stats_cap) {
+			desc = &virtnet_stats_rx_speed_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_rx_speed_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+	}
+
+	if (type == VIRTNET_Q_TYPE_TX) {
+		fmt = "tx%u_hw_%s";
+
+		if (VIRTIO_NET_STATS_TYPE_TX_BASIC & vi->device_stats_cap) {
+			desc = &virtnet_stats_tx_basic_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_tx_basic_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_TX_GSO & vi->device_stats_cap) {
+			desc = &virtnet_stats_tx_gso_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_tx_gso_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+
+		if (VIRTIO_NET_STATS_TYPE_TX_SPEED & vi->device_stats_cap) {
+			desc = &virtnet_stats_tx_speed_desc[0];
+			num = ARRAY_SIZE(virtnet_stats_tx_speed_desc);
+
+			virtnet_stats_sprintf(&p, fmt, NULL, num, qid, desc);
+		}
+	}
+
+	*data = p;
+}
+
+struct virtnet_stats_ctx {
+	/* Used to calculate the offset inside the output buffer. */
+	u32 desc_num[3];
+
+	/* The actual supported stat types. */
+	u32 bitmap[3];
+
+	/* Used to calculate the reply buffer size. */
+	u32 size[3];
+
+	/* Record the output buffer. */
+	u64 *data;
+};
+
+static void virtnet_stats_ctx_init(struct virtnet_info *vi,
+				   struct virtnet_stats_ctx *ctx,
+				   u64 *data)
+{
+	u32 queue_type;
+
+	ctx->data = data;
+
+	if (VIRTIO_NET_STATS_TYPE_CVQ & vi->device_stats_cap) {
+		queue_type = VIRTNET_Q_TYPE_CQ;
+
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
+	}
+
+	queue_type = VIRTNET_Q_TYPE_RX;
+
+	if (VIRTIO_NET_STATS_TYPE_RX_BASIC & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_BASIC;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_basic_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_basic);
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_CSUM & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_CSUM;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_csum_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_csum);
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_SPEED & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_RX_SPEED;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_rx_speed_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_rx_speed);
+	}
+
+	queue_type = VIRTNET_Q_TYPE_TX;
+
+	if (VIRTIO_NET_STATS_TYPE_TX_BASIC & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_BASIC;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_basic_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_basic);
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_GSO & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_GSO;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_gso_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_gso);
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_SPEED & vi->device_stats_cap) {
+		ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_TX_SPEED;
+		ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_tx_speed_desc);
+		ctx->size[queue_type]     += sizeof(struct virtio_net_stats_tx_speed);
+	}
+}
+
+/* virtnet_fill_stats - copy the stats to ethtool -S
+ * The stats source is the device.
+ *
+ * @vi: virtio net info
+ * @qid: the vq id
+ * @ctx: stats ctx (initiated by virtnet_stats_ctx_init())
+ * @base: pointer to the device reply.
+ * @type: the type of the device reply
+ */
+static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
+			       struct virtnet_stats_ctx *ctx,
+			       const u8 *base, u8 reply_type)
+{
+	u32 queue_type, num_rx, num_tx, num_cq;
+	const struct virtnet_stat_desc *desc;
+	u64 offset, bitmap;
+	const __le64 *v;
+	int i, num;
+
+	num_rx = VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_TX];
+	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+
+	queue_type = vq_type(vi, qid);
+	bitmap = ctx->bitmap[queue_type];
+	offset = 0;
+
+	if (queue_type == VIRTNET_Q_TYPE_TX) {
+		offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
+		offset += VIRTNET_SQ_STATS_LEN;
+	} else if (queue_type == VIRTNET_Q_TYPE_RX) {
+		offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_CVQ & bitmap) {
+		desc = &virtnet_stats_cvq_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_cvq_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_CVQ)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_BASIC & bitmap) {
+		desc = &virtnet_stats_rx_basic_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_basic_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_CSUM & bitmap) {
+		desc = &virtnet_stats_rx_csum_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_csum_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_RX_SPEED & bitmap) {
+		desc = &virtnet_stats_rx_speed_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_rx_speed_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_BASIC & bitmap) {
+		desc = &virtnet_stats_tx_basic_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_basic_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_GSO & bitmap) {
+		desc = &virtnet_stats_tx_gso_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_gso_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO)
+			goto found;
+
+		offset += num;
+	}
+
+	if (VIRTIO_NET_STATS_TYPE_TX_SPEED & bitmap) {
+		desc = &virtnet_stats_tx_speed_desc[0];
+		num = ARRAY_SIZE(virtnet_stats_tx_speed_desc);
+		if (reply_type == VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED)
+			goto found;
+
+		offset += num;
+	}
+
+	return;
+
+found:
+	for (i = 0; i < num; ++i) {
+		v = (const __le64 *)(base + desc[i].offset);
+		ctx->data[offset + i] = le64_to_cpu(*v);
+	}
+}
+
+static int __virtnet_get_hw_stats(struct virtnet_info *vi,
+				  struct virtnet_stats_ctx *ctx,
+				  struct virtio_net_ctrl_queue_stats *req,
+				  int req_size, void *reply, int res_size)
+{
+	struct virtio_net_stats_reply_hdr *hdr;
+	struct scatterlist sgs_in, sgs_out;
+	void *p;
+	u32 qid;
+	int ok;
+
+	sg_init_one(&sgs_out, req, req_size);
+	sg_init_one(&sgs_in, reply, res_size);
+
+	ok = virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
+					VIRTIO_NET_CTRL_STATS_GET,
+					&sgs_out, &sgs_in);
+
+	if (!ok)
+		return ok;
+
+	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+		hdr = p;
+		qid = le16_to_cpu(hdr->vq_index);
+		virtnet_fill_stats(vi, qid, ctx, p, hdr->type);
+	}
+
+	return 0;
+}
+
+static void virtnet_make_stat_req(struct virtnet_info *vi,
+				  struct virtnet_stats_ctx *ctx,
+				  struct virtio_net_ctrl_queue_stats *req,
+				  int qid, int *idx)
+{
+	int qtype = vq_type(vi, qid);
+	u64 bitmap = ctx->bitmap[qtype];
+
+	if (!bitmap)
+		return;
+
+	req->stats[*idx].vq_index = cpu_to_le16(qid);
+	req->stats[*idx].types_bitmap[0] = cpu_to_le64(bitmap);
+	*idx += 1;
+}
+
+static int virtnet_get_hw_stats(struct virtnet_info *vi,
+				struct virtnet_stats_ctx *ctx)
+{
+	struct virtio_net_ctrl_queue_stats *req;
+	int qnum, i, j, res_size, qtype, last_vq;
+	void *reply;
+	int ok;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
+		return 0;
+
+	last_vq = vi->curr_queue_pairs * 2 - 1;
+
+	qnum = 0;
+	res_size = 0;
+	for (i = 0; i <= last_vq ; ++i) {
+		qtype = vq_type(vi, i);
+		if (ctx->bitmap[qtype]) {
+			++qnum;
+			res_size += ctx->size[qtype];
+		}
+	}
+
+	if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
+		res_size += ctx->size[VIRTNET_Q_TYPE_CQ];
+		qnum += 1;
+	}
+
+	req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	reply = kmalloc(res_size, GFP_KERNEL);
+	if (!reply) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	j = 0;
+	for (i = 0; i <= last_vq ; ++i)
+		virtnet_make_stat_req(vi, ctx, req, i, &j);
+
+	virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+
+	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+
+	kfree(req);
+	kfree(reply);
+
+	return ok;
+}
+
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3276,16 +3704,22 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
+
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "rx%u_%s", i,
 						virtnet_rq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_RX, i, &p);
 		}
 
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
 				ethtool_sprintf(&p, "tx%u_%s", i,
 						virtnet_sq_stats_desc[j].desc);
+
+			virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_TX, i, &p);
 		}
 		break;
 	}
@@ -3294,11 +3728,17 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 static int virtnet_get_sset_count(struct net_device *dev, int sset)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_stats_ctx ctx = {0};
+	u32 pair_count;
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return vi->curr_queue_pairs * (VIRTNET_RQ_STATS_LEN +
-					       VIRTNET_SQ_STATS_LEN);
+		virtnet_stats_ctx_init(vi, &ctx, NULL);
+
+		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
+		pair_count += ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
+
+		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3308,11 +3748,18 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	unsigned int idx = 0, start, i, j;
+	struct virtnet_stats_ctx ctx = {0};
+	unsigned int idx, start, i, j;
 	const u8 *stats_base;
 	const u64_stats_t *p;
 	size_t offset;
 
+	virtnet_stats_ctx_init(vi, &ctx, data);
+	if (virtnet_get_hw_stats(vi, &ctx))
+		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
+
+	idx = ctx.desc_num[VIRTNET_Q_TYPE_CQ];
+
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
@@ -3326,6 +3773,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 		idx += VIRTNET_RQ_STATS_LEN;
+		idx += ctx.desc_num[VIRTNET_Q_TYPE_RX];
 	}
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
@@ -3341,6 +3789,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			}
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 		idx += VIRTNET_SQ_STATS_LEN;
+		idx += ctx.desc_num[VIRTNET_Q_TYPE_TX];
 	}
 }
 
@@ -4840,6 +5289,25 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS)) {
+		struct scatterlist sg;
+		__le64 v;
+
+		sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(vi->ctrl->stats_cap));
+
+		if (!virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
+						VIRTIO_NET_CTRL_STATS_QUERY,
+						NULL, &sg)) {
+			pr_debug("virtio_net: fail to get stats capability\n");
+			rtnl_unlock();
+			err = -EINVAL;
+			goto free_unregister_netdev;
+		}
+
+		v = vi->ctrl->stats_cap.supported_stats_types[0];
+		vi->device_stats_cap = le64_to_cpu(v);
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -4966,7 +5434,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
 	VIRTIO_NET_F_VQ_NOTF_COAL, \
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.32.0.3.g01195cf9f


