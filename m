Return-Path: <bpf+bounces-27886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4B8B2F25
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E50282D84
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC37E590;
	Fri, 26 Apr 2024 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CnNRLVjo"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C478B50;
	Fri, 26 Apr 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102786; cv=none; b=uPDVm9+W4Gb0XVcI3/kzVR3EwAnObzIwZIACUFt625Rqpe9SxVc/5EFOkJLy/71opLEjGvMdP5oQbufYNKS7Vo/ir1cerG9MUO5a1LCWifmCMo0P8RdI1sUUGW+MdJbJOetJR0ZvswMKCwkymGDCYPJTYEtjNlDikuqgpCKRB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102786; c=relaxed/simple;
	bh=cd+uL9TzYVnhtfpVBUWfcbQO9N2lTDl7xnqUMk1hPg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guDqNTItF6n6cmJFWCqigM4p64UIinQfgwYmO6hZBFqMhUCMt4ISx59W1Ko6ZidJbmkPTtYelnpSFADjyES/zoO67W1+gmYN82kJ/H0jMhwOaCLQxNzxJVGKeuCAdY1YZnz3aAlZ2NByDCw4xgY30QcD1S83ncmdlvoDi2MsKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CnNRLVjo; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102781; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8oWi0RwtC2n517A9JH1nmRldQxAH8xXGDDnYsI4AU8Q=;
	b=CnNRLVjoaNE1ymMmVj4hkECgzpwEFA+JoX7o41cQlxX+cvQKaG//GS0aAOMWY0ZDmaZqSHUf2b49jRjdqZdTYWm/0cNiyJjnQgXKD/GHBHTf/mBt5eWuM1HhmgsMHkN2HShjXyDjNnaW6KtAkICRyictX/Pn5t8Hb2OyIriLYj8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5HSYUq_1714102778;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5HSYUq_1714102778)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:40 +0800
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
Subject: [PATCH net-next v7 7/8] netdev: add queue stats
Date: Fri, 26 Apr 2024 11:39:27 +0800
Message-Id: <20240426033928.77778-8-xuanzhuo@linux.alibaba.com>
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

These stats are commonly. Support reporting those via netdev-genl queue
stats.

name: rx-hw-drops
name: rx-hw-drop-overruns
name: rx-csum-unnecessary
name: rx-csum-none
name: rx-csum-bad
name: rx-hw-gro-packets
name: rx-hw-gro-bytes
name: rx-hw-gro-wire-packets
name: rx-hw-gro-wire-bytes
name: rx-hw-drop-ratelimits
name: tx-hw-drops
name: tx-hw-drop-errors
name: tx-csum-none
name: tx-needs-csum
name: tx-hw-gso-packets
name: tx-hw-gso-bytes
name: tx-hw-gso-wire-packets
name: tx-hw-gso-wire-bytes
name: tx-hw-drop-ratelimits

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 Documentation/netlink/specs/netdev.yaml | 104 ++++++++++++++++++++++++
 include/net/netdev_queues.h             |  27 ++++++
 include/uapi/linux/netdev.h             |  19 +++++
 net/core/netdev-genl.c                  |  23 +++++-
 tools/include/uapi/linux/netdev.h       |  19 +++++
 5 files changed, 190 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 679c4130707c..2be4b3714d17 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -335,6 +335,110 @@ attribute-sets:
           Allocation failure may, or may not result in a packet drop, depending
           on driver implementation and whether system recovers quickly.
         type: uint
+      -
+        name: rx-hw-drops
+        doc: |
+          Number of all packets which entered the device, but never left it,
+          including but not limited to: packets dropped due to lack of buffer
+          space, processing errors, explicit or implicit policies and packet
+          filters.
+        type: uint
+      -
+        name: rx-hw-drop-overruns
+        doc: |
+          Number of packets dropped due to transient lack of resources, such as
+          buffer space, host descriptors etc.
+        type: uint
+      -
+        name: rx-csum-unnecessary
+        doc: Number of packets that were marked as CHECKSUM_UNNECESSARY.
+        type: uint
+      -
+        name: rx-csum-none
+        doc: Number of packets that were not checksummed by device.
+        type: uint
+      -
+        name: rx-csum-bad
+        doc: |
+          Number of packets with bad checksum. The packets are not discarded,
+          but still delivered to the stack.
+        type: uint
+      -
+        name: rx-hw-gro-packets
+        doc: |
+          Number of packets that were coalesced from smaller packets by the device.
+          Counts only packets coalesced with the HW-GRO netdevice feature,
+          LRO-coalesced packets are not counted.
+        type: uint
+      -
+        name: rx-hw-gro-bytes
+        doc: See `rx-hw-gro-packets`.
+        type: uint
+      -
+        name: rx-hw-gro-wire-packets
+        doc: |
+          Number of packets that were coalesced to bigger packetss with the HW-GRO
+          netdevice feature. LRO-coalesced packets are not counted.
+        type: uint
+      -
+        name: rx-hw-gro-wire-bytes
+        doc: See `rx-hw-gro-wire-packets`.
+        type: uint
+      -
+        name: rx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the received
+          packets bitrate exceeding the device rate limit.
+        type: uint
+      -
+        name: tx-hw-drops
+        doc: |
+          Number of packets that arrived at the device but never left it,
+          encompassing packets dropped for reasons such as processing errors, as
+          well as those affected by explicitly defined policies and packet
+          filtering criteria.
+        type: uint
+      -
+        name: tx-hw-drop-errors
+        doc: Number of packets dropped because they were invalid or malformed.
+        type: uint
+      -
+        name: tx-csum-none
+        doc: |
+          Number of packets that did not require the device to calculate the
+          checksum.
+        type: uint
+      -
+        name: tx-needs-csum
+        doc: |
+          Number of packets that required the device to calculate the checksum.
+        type: uint
+      -
+        name: tx-hw-gso-packets
+        doc: |
+          Number of packets that necessitated segmentation into smaller packets
+          by the device.
+        type: uint
+      -
+        name: tx-hw-gso-bytes
+        doc: See `tx-hw-gso-packets`.
+        type: uint
+      -
+        name: tx-hw-gso-wire-packets
+        doc: |
+          Number of wire-sized packets generated by processing
+          `tx-hw-gso-packets`
+        type: uint
+      -
+        name: tx-hw-gso-wire-bytes
+        doc: See `tx-hw-gso-wire-packets`.
+        type: uint
+      -
+        name: tx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the transmit
+          packets bitrate exceeding the device rate limit.
+        type: uint
 
 operations:
   list:
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..c7ac4539eafc 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -9,11 +9,38 @@ struct netdev_queue_stats_rx {
 	u64 bytes;
 	u64 packets;
 	u64 alloc_fail;
+
+	u64 hw_drops;
+	u64 hw_drop_overruns;
+
+	u64 csum_unnecessary;
+	u64 csum_none;
+	u64 csum_bad;
+
+	u64 hw_gro_packets;
+	u64 hw_gro_bytes;
+	u64 hw_gro_wire_packets;
+	u64 hw_gro_wire_bytes;
+
+	u64 hw_drop_ratelimits;
 };
 
 struct netdev_queue_stats_tx {
 	u64 bytes;
 	u64 packets;
+
+	u64 hw_drops;
+	u64 hw_drop_errors;
+
+	u64 csum_none;
+	u64 needs_csum;
+
+	u64 hw_gso_packets;
+	u64 hw_gso_bytes;
+	u64 hw_gso_wire_packets;
+	u64 hw_gso_wire_bytes;
+
+	u64 hw_drop_ratelimits;
 };
 
 /**
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bb65ee840cda..cf24f1d9adf8 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -146,6 +146,25 @@ enum {
 	NETDEV_A_QSTATS_TX_PACKETS,
 	NETDEV_A_QSTATS_TX_BYTES,
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
+	NETDEV_A_QSTATS_RX_HW_DROPS,
+	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
+	NETDEV_A_QSTATS_RX_CSUM_NONE,
+	NETDEV_A_QSTATS_RX_CSUM_BAD,
+	NETDEV_A_QSTATS_RX_HW_GRO_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_BYTES,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES,
+	NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_HW_DROPS,
+	NETDEV_A_QSTATS_TX_HW_DROP_ERRORS,
+	NETDEV_A_QSTATS_TX_CSUM_NONE,
+	NETDEV_A_QSTATS_TX_NEEDS_CSUM,
+	NETDEV_A_QSTATS_TX_HW_GSO_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
+	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index dd6510f2c652..4b5054087309 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -489,7 +489,17 @@ netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_PACKETS, rx->packets) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_BYTES, rx->bytes) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROPS, rx->hw_drops) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS, rx->hw_drop_overruns) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY, rx->csum_unnecessary) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_NONE, rx->csum_none) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_BAD, rx->csum_bad) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_PACKETS, rx->hw_gro_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_BYTES, rx->hw_gro_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS, rx->hw_gro_wire_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES, rx->hw_gro_wire_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS, rx->hw_drop_ratelimits))
 		return -EMSGSIZE;
 	return 0;
 }
@@ -498,7 +508,16 @@ static int
 netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_PACKETS, tx->packets) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_BYTES, tx->bytes))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_BYTES, tx->bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROPS, tx->hw_drops) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_ERRORS, tx->hw_drop_errors) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_CSUM_NONE, tx->csum_none) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_NEEDS_CSUM, tx->needs_csum) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_PACKETS, tx->hw_gso_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_gso_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, tx->hw_gso_wire_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx->hw_gso_wire_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bb65ee840cda..cf24f1d9adf8 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -146,6 +146,25 @@ enum {
 	NETDEV_A_QSTATS_TX_PACKETS,
 	NETDEV_A_QSTATS_TX_BYTES,
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
+	NETDEV_A_QSTATS_RX_HW_DROPS,
+	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
+	NETDEV_A_QSTATS_RX_CSUM_NONE,
+	NETDEV_A_QSTATS_RX_CSUM_BAD,
+	NETDEV_A_QSTATS_RX_HW_GRO_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_BYTES,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES,
+	NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_HW_DROPS,
+	NETDEV_A_QSTATS_TX_HW_DROP_ERRORS,
+	NETDEV_A_QSTATS_TX_CSUM_NONE,
+	NETDEV_A_QSTATS_TX_NEEDS_CSUM,
+	NETDEV_A_QSTATS_TX_HW_GSO_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
+	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
-- 
2.32.0.3.g01195cf9f


