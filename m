Return-Path: <bpf+bounces-68978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D3B8B571
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EE85A691B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D02D3EE1;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ysk1YgPO"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D362459FF;
	Fri, 19 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=CBYCsbSJ/XDJSaglHs4+QsJb9+VNCWx7qiyzK5UbwURgsenQxnFDE8caW8W5OhBgAi0wXUwXev8w2XdtyEb52J676is95K42jTbuVVfgGtAQeXrOESxHY6CRt9+kNmq1ZP4GUes+89nRk+eCc7RD2iUsIkK+V0QLbPl7eXUkMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=WK0h+RD25FJkm8BrkuPULY1BwBf+vaOJavD87R+/S5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxK7DP4bIkkr/544hZrnwrkt4EbXo52HLFTXQtpmPT41LBPIiw4klycKdm6GSycl5G1BBR2BqIPlPHQkzt4/VicftGwfuAAAhxbV+N9hoghszqMtNikqpPDydA0ssWuZgoO1y9zA0HO7HxTmNCBHKG/TOtHL4DzwKHqnZyPv93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ysk1YgPO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4nW4d7d+M/ZEzRqXsjlIKgIhy/uf3MLuvvpI7yHxWMM=; b=Ysk1YgPOGxh7DSW0yJU11St5MJ
	u5pvS0N5qmHfXRbaugnUOt2Rmd7kCoWLeguSimbeJvsudeWZQ2BdGzreDXZmLtB/BNmB5MLj3VY8J
	DzYF0iVla/h9u5eSbqkfeYds680YAgFSqIYHm8qbnlWerDgjjbiQjt3nQfNUQaT5qaIhXHPeVReOs
	Ny7DOONqwJcI9VW3BwzgPAZzMhOPwIYT6WHelDQlYMYlZtbxkbMlOgz50Yi+vERW5YvNyMlfgppdf
	DZGqOy0uCn935NhdjTyBMwtdq++VozT9KRWp8/s6w5jELkMFwSQeyIS6uv56QpLCHCU6ev/5zFCn9
	0+q86Jag==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihv-000NpZ-1B;
	Fri, 19 Sep 2025 23:31:55 +0200
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 01/20] net, ynl: Add bind-queue operation
Date: Fri, 19 Sep 2025 23:31:34 +0200
Message-ID: <20250919213153.103606-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

Add a ynl netdev family operation called bind-queue that _binds_ an
rxq from a real netdev to a virtual netdev i.e. netkit or veth. This
bound or _mapped_ rxq in the virtual netdev acts as a proxy for the
parent real rxq, and can be used by processes running in a container
to use memory providers (io_uring zero-copy rx or devmem) or AF_XDP.
An early implementation had only driver-specific integration [0],
but in order for other virtual devices to reuse, it makes sense to
have this as a generic API.

src-ifindex and src-queue-id is the real netdev and rxq respectively.
dst-ifindex is the virtual netdev. Note that this op doesn't take
dst-queue-id, because the expectation is that the op will _create_ a
new rxq in the virtual netdev. The virtual netdev must have
real_num_rx_queues less than num_rx_queues at the time of calling
bind-queue.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
---
 Documentation/netlink/specs/netdev.yaml | 37 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 11 ++++++++
 net/core/netdev-genl-gen.c              | 14 ++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  4 +++
 tools/include/uapi/linux/netdev.h       | 11 ++++++++
 6 files changed, 78 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152..99a430ea8a9a 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -561,6 +561,29 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+  -
+    name: queue-pair
+    attributes:
+      -
+        name: src-ifindex
+        doc: netdev ifindex of the physical device
+        type: u32
+        checks:
+          min: 1
+      -
+        name: src-queue-id
+        doc: netdev queue id of the physical device
+        type: u32
+      -
+        name: dst-ifindex
+        doc: netdev ifindex of the virtual device
+        type: u32
+        checks:
+          min: 1
+      -
+        name: dst-queue-id
+        doc: netdev queue id of the virtual device
+        type: u32
 
 operations:
   list:
@@ -772,6 +795,20 @@ operations:
           attributes:
             - id
 
+    -
+      name: bind-queue
+      doc: Bind a physical netdev queue to a virtual one
+      attribute-set: queue-pair
+      do:
+        request:
+          attributes:
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
index 48eb49aa03d4..05e17765a39d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -210,6 +210,16 @@ enum {
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX = 1,
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
@@ -226,6 +236,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_BIND_QUEUE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index e9a2a6f26cb7..10b2ab4dd500 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -106,6 +106,13 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 };
 
+/* NETDEV_CMD_BIND_QUEUE - do */
+static const struct nla_policy netdev_bind_queue_nl_policy[NETDEV_A_QUEUE_PAIR_DST_IFINDEX + 1] = {
+	[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_PAIR_DST_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -204,6 +211,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
index 470fabbeacd9..b0aea27bf84e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1120,6 +1120,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
+{
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..05e17765a39d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -210,6 +210,16 @@ enum {
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX = 1,
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
@@ -226,6 +236,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_BIND_QUEUE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.43.0


