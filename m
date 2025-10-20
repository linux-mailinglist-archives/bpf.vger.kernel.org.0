Return-Path: <bpf+bounces-71415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F311BF264D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60094F8EF7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963D28BA95;
	Mon, 20 Oct 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qdnXU6zY"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38410286416;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=EYyyTIUZYeae77/+OKB6zZYKkW4wynL3e++PMZgDrFmWTO3n9PsnICTVK5K6G9lbm4+GxNmJnmXi+f+z1FvjJ3xpTFjWf1APdpq6v4PSmVLsJufdkb8y8xDb3HusWrYXZl/vHppfiRxCyRgKHGnr9kUscIjsZ3eD15+bSecpSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=P2G1O8+99gfkQWwU0+MVuDdxRl/eXLJqCTUfxyg//Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKyoNsAXyMcJwpuOUKHhH3PYRuTAp41fHZ22oCCp9GIar+6cKNG6nawD9dSTuYh3MGbpUAF5EIDcj4H87tdmmQ02H3E8nB1/eTM2NyDKXpoaleK7Y/FMcBpGcRarRH0pj1+XmvVGbfmFnE9KJv4HSt9G4jbQWly2GQuA6yMu7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qdnXU6zY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kqaiPMdUkAj81Mh7kQ/VluPNCDbJE/SMqEj4MzPie88=; b=qdnXU6zYFQ4AxaTx2lHzFleh5D
	Z0EKTFtbR5pI4BeiNgDjXSGThMlhnGtFic89bT5R6ojRrczy7De/hjCdIOXIm97YbIy5vTyLBrDFv
	LYKo/iwDAO1cND0jrUb3xIWalS3YNjWwzB3gEP+iKrwlmbinJnoYiHUUvAggjhPCNI6Ut/+L3dPxK
	oClFG0YbHyJ3F01hfEkLVPCzVicnmdNG0c78x5Wzbq+NqR89JvaOaIeqSy9VnPgwL9GhNKba9Upfg
	Xkbd1ZEMCUOhNDlExGgFA14pFqSPx3wKpzUtF1YhW+ie1Z5aTuBq8/wBjKH2PYGobEcqjll4QCLs9
	potClXtQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsft-000JiV-2W;
	Mon, 20 Oct 2025 18:23:57 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v3 01/15] net: Add bind-queue operation
Date: Mon, 20 Oct 2025 18:23:41 +0200
Message-ID: <20251020162355.136118-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

From: David Wei <dw@davidwei.uk>

Add a ynl netdev family operation called bind-queue that creates a new
rx queue in a virtual netdev (i.e. netkit or veth) and binds it to an rx
queue in a real netdev. This forms a queue pair, where the peer queue of
the pair in the virtual netdev acts as a proxy for the peer queue in the
real netdev. Thus, the peer queue in the virtual netdev can be used by
processes running in a container to use both memory providers (io_uring
zero-copy rx and devmem) and AF_XDP. An early implementation had only
driver-specific integration [0], but in order for other virtual devices
to reuse, it makes sense to have this as a generic API.

src-ifindex and src-queue-id is the real netdev and its rx queue id
respectively. dst-ifindex is the virtual netdev. Note that this op doesn't
take dst-queue-id because a new rx queue is created. The virtual netdev
must have real_num_rx_queues less than num_rx_queues at the time of
calling bind-queue. The queue-type must be rx as only rx queues are
supported for now.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
---
 Documentation/netlink/specs/netdev.yaml | 60 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 12 +++++
 net/core/netdev-genl-gen.c              | 25 +++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  5 +++
 tools/include/uapi/linux/netdev.h       | 12 +++++
 6 files changed, 115 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152..20bb00b7e9ac 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -561,6 +561,46 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+  -
+    name: queue-pair
+    attributes:
+      -
+        name: queue-type
+        doc: |
+          Queue type as rx, tx, for src-queue-id and dst-queue-id.
+          Currently only pairing queues of type rx is supported.
+        type: u32
+        enum: queue-type
+      -
+        name: src-ifindex
+        doc: |
+          Specifies the netdev ifindex of the physical device to pair
+          src-queue-id from.
+        type: u32
+        checks:
+          min: 1
+          max: s32-max
+      -
+        name: src-queue-id
+        doc: |
+          Specifies the netdev queue id of the physical device with
+          src-ifindex to pair a queue from.
+        type: u32
+      -
+        name: dst-ifindex
+        doc: |
+          Specifies the netdev ifindex of the virtual device to pair
+          a new queue with the src-queue-id from src-ifindex.
+        type: u32
+        checks:
+          min: 1
+          max: s32-max
+      -
+        name: dst-queue-id
+        doc: |
+          Specifies the new netdev queue id of the virtual device after
+          a successful pairing operation.
+        type: u32
 
 operations:
   list:
@@ -772,6 +812,26 @@ operations:
           attributes:
             - id
 
+    -
+      name: bind-queue
+      doc: |
+        Bind a physical netdevice queue to a virtual one. The binding
+        creates a queue pair, where a queue can reference its peer queue.
+        This is useful for memory providers and AF_XDP operations which
+        take an ifindex and queue id to allow auch applications to bind
+        against virtual devices in containers.
+      attribute-set: queue-pair
+      do:
+        request:
+          attributes:
+            - queue-type
+            - src-ifindex
+            - src-queue-id
+            - dst-ifindex
+        reply:
+          attributes:
+            - dst-queue-id
+
 kernel-family:
   headers: ["net/netdev_netlink.h"]
   sock-priv: struct netdev_nl_sock
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..4ef04d0bc412 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -210,6 +210,17 @@ enum {
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_PAIR_QUEUE_TYPE = 1,
+	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX,
+	NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID,
+	NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
+	NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID,
+
+	__NETDEV_A_QUEUE_PAIR_MAX,
+	NETDEV_A_QUEUE_PAIR_MAX = (__NETDEV_A_QUEUE_PAIR_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -226,6 +237,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_BIND_QUEUE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index e9a2a6f26cb7..69f8126c3e42 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -26,6 +26,16 @@ static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range
 	.max	= S32_MAX,
 };
 
+static const struct netlink_range_validation netdev_a_queue_pair_src_ifindex_range = {
+	.min	= 1ULL,
+	.max	= S32_MAX,
+};
+
+static const struct netlink_range_validation netdev_a_queue_pair_dst_ifindex_range = {
+	.min	= 1ULL,
+	.max	= S32_MAX,
+};
+
 /* Common nested types */
 const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
@@ -106,6 +116,14 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 };
 
+/* NETDEV_CMD_BIND_QUEUE - do */
+static const struct nla_policy netdev_bind_queue_nl_policy[NETDEV_A_QUEUE_PAIR_DST_IFINDEX + 1] = {
+	[NETDEV_A_QUEUE_PAIR_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_queue_pair_src_ifindex_range),
+	[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_PAIR_DST_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_queue_pair_dst_ifindex_range),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -204,6 +222,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_DMABUF_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_QUEUE,
+		.doit		= netdev_nl_bind_queue_doit,
+		.policy		= netdev_bind_queue_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index cf3fad74511f..309248fe2b9e 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -35,6 +35,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..ce1018ea390f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1120,6 +1120,11 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..4ef04d0bc412 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -210,6 +210,17 @@ enum {
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_PAIR_QUEUE_TYPE = 1,
+	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX,
+	NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID,
+	NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
+	NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID,
+
+	__NETDEV_A_QUEUE_PAIR_MAX,
+	NETDEV_A_QUEUE_PAIR_MAX = (__NETDEV_A_QUEUE_PAIR_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -226,6 +237,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_BIND_QUEUE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.43.0


