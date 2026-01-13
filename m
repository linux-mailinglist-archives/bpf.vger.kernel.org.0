Return-Path: <bpf+bounces-78769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA2D1BB20
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BBDB3006460
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1636C599;
	Tue, 13 Jan 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gSxdpSB7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978F36B06C;
	Tue, 13 Jan 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346605; cv=none; b=dS1dt2BZDgm7rTfv0NxT9NWgzP9TZd7Jn+pjH2KjZvan1wkuBh2IVdk1DjM73j7GPkcj6Cyyxck+FBs1L3W+iV5n/KIDwOZt1JksZs//YLrjbuOncsP19JxRUAgnJjjtQHHdXsrOwsKH5xiYGCQb+JOKfEP+0Tc9AwLf5ry9yzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346605; c=relaxed/simple;
	bh=NNWjAuSsX0rTVd6hiMmalLmDZEsYik/YOXbLW87vOjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAwaOhvOPYCzy5BIixoXzqAsdKd9hWNHFL/r87RybM69ZWaIPDyiyyJN4gRW+vlwAjQLwG/HYyyhorigqG7sCqsQxUASsiG2vIfs2AnxJxOzb4xTiEaRJDS9hGKtq6zg2FWjg2x28x30fAt5fRcwOrXxvOwos31MvG+FEPG4Ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gSxdpSB7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V+fMNtDUChdZEIBeTrMIWJehk6TmmwFvGtBxWUlieoY=; b=gSxdpSB7UHA4dVxpWr+a0X1e+Q
	AsEz5GdZz4bDyzTH6dxhHx5kRGPEqPmiJYz83ZI7uFftcAoz4mJ5JSb/C1xor7t6F/mMUW7/AQzzF
	KKUbrGlBgOkCJhzF2a7zpjZ8AJ2QpTYDFPjJf3kfqVZGdI9LmsPqROOCw9jBYUhtsClhPqOVpg9P+
	gK+ZquEvbjJmj7RX+aCmUSRzhKBEQPQPScIoH5nTTlly2tN2CH6jjU6hMRu5qIbhbPE8V2rYFDOgk
	yhoAX90M72ATqizjD6J4zb6VUDQFkZm4Au5VBEyMo+5ehvg3s5ML0VFQ0aW0eDmjYqw63vxpBC0IP
	EdjeAoKw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnj2-0003VR-1y;
	Wed, 14 Jan 2026 00:23:00 +0100
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
Subject: [PATCH net-next v6 01/16] net: Add queue-create operation
Date: Wed, 14 Jan 2026 00:22:42 +0100
Message-ID: <20260113232257.200036-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

Add a ynl netdev family operation called queue-create that creates a
new queue on a netdevice:

      name: queue-create
      attribute-set: queue
      flags: [admin-perm]
      do:
        request:
          attributes:
            - ifindex
            - type
            - lease
        reply: &queue-create-op
          attributes:
            - id

This is a generic operation such that it can be extended for various
use cases in future. Right now it is mandatory to specify ifindex,
the queue type which is enforced to rx and a lease. The newly created
queue id is returned to the caller.

A queue from a virtual device can have a lease which refers to another
queue from a physical device. This is useful for memory providers
and AF_XDP operations which take an ifindex and queue id to allow
applications to bind against virtual devices in containers. The lease
couples both queues together and allows to proxy the operations from
a virtual device in a container to the physical device.

In future, the nested lease attribute can be lifted and made optional
for other use-cases such as dynamic queue creation for physical
netdevs. The lack of lease and the specification of the physical
device as an ifindex will imply that we need a real queue to be
allocated. Similarly, the queue type enforcement to rx can then be
lifted as well to support tx.

An early implementation had only driver-specific integration [0], but
in order for other virtual devices to reuse, it makes sense to have
this as a generic API in core net.

For leasing queues, the virtual netdev must have real_num_rx_queue
less than num_rx_queues at the time of calling queue-create. The
queue-type must be rx as only rx queues are supported for leasing
for now. We also enforce that the queue-create ifindex must point
to a virtual device, and that the nested lease attribute's ifindex
must point to a physical device. The nested lease attribute set
contains a netns-id attribute which is currently only intended for
dumping as part of the queue-get operation. Also, it is modeled as
an s32 type similarly as done elsewhere in the stack.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
---
 Documentation/netlink/specs/netdev.yaml | 44 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 11 +++++++
 net/core/netdev-genl-gen.c              | 20 +++++++++++
 net/core/netdev-genl-gen.h              |  2 ++
 net/core/netdev-genl.c                  |  5 +++
 tools/include/uapi/linux/netdev.h       | 11 +++++++
 6 files changed, 93 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 596c306ce52b..b86db8656eac 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -339,6 +339,15 @@ attribute-sets:
         doc: XSK information for this queue, if any.
         type: nest
         nested-attributes: xsk-info
+      -
+        name: lease
+        doc: |
+          A queue from a virtual device can have a lease which refers to
+          another queue from a physical device. This is useful for memory
+          providers and AF_XDP operations which take an ifindex and queue id
+          to allow applications to bind against virtual devices in containers.
+        type: nest
+        nested-attributes: lease
   -
     name: qstats
     doc: |
@@ -537,6 +546,24 @@ attribute-sets:
         name: id
       -
         name: type
+  -
+    name: lease
+    attributes:
+      -
+        name: ifindex
+        doc: The netdev ifindex to lease the queue from.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queue
+        doc: The netdev queue to lease from.
+        type: nest
+        nested-attributes: queue-id
+      -
+        name: netns-id
+        doc: The network namespace id of the netdev.
+        type: s32
   -
     name: dmabuf
     attributes:
@@ -686,6 +713,7 @@ operations:
             - dmabuf
             - io-uring
             - xsk
+            - lease
       dump:
         request:
           attributes:
@@ -797,6 +825,22 @@ operations:
         reply:
           attributes:
             - id
+    -
+      name: queue-create
+      doc: |
+        Create a new queue for the given netdevice. Whether this operation
+        is supported depends on the device and the driver.
+      attribute-set: queue
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - lease
+        reply: &queue-create-op
+          attributes:
+            - id
 
 kernel-family:
   headers: ["net/netdev_netlink.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e0b579a1df4f..7df1056a35fd 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -160,6 +160,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_LEASE,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -202,6 +203,15 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_LEASE_IFINDEX = 1,
+	NETDEV_A_LEASE_QUEUE,
+	NETDEV_A_LEASE_NETNS_ID,
+
+	__NETDEV_A_LEASE_MAX,
+	NETDEV_A_LEASE_MAX = (__NETDEV_A_LEASE_MAX - 1)
+};
+
 enum {
 	NETDEV_A_DMABUF_IFINDEX = 1,
 	NETDEV_A_DMABUF_QUEUES,
@@ -228,6 +238,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_QUEUE_CREATE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ba673e81716f..52ba99c019e7 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -28,6 +28,12 @@ static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range
 };
 
 /* Common nested types */
+const struct nla_policy netdev_lease_nl_policy[NETDEV_A_LEASE_NETNS_ID + 1] = {
+	[NETDEV_A_LEASE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_LEASE_QUEUE] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
+	[NETDEV_A_LEASE_NETNS_ID] = { .type = NLA_S32, },
+};
+
 const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
 	[NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
 	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
@@ -107,6 +113,13 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 };
 
+/* NETDEV_CMD_QUEUE_CREATE - do */
+static const struct nla_policy netdev_queue_create_nl_policy[NETDEV_A_QUEUE_LEASE + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_LEASE] = NLA_POLICY_NESTED(netdev_lease_nl_policy),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -205,6 +218,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_DMABUF_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_CREATE,
+		.doit		= netdev_nl_queue_create_doit,
+		.policy		= netdev_queue_create_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_LEASE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index cffc08517a41..d71b435d72c1 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -14,6 +14,7 @@
 #include <net/netdev_netlink.h>
 
 /* Common nested types */
+extern const struct nla_policy netdev_lease_nl_policy[NETDEV_A_LEASE_NETNS_ID + 1];
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
 extern const struct nla_policy netdev_queue_id_nl_policy[NETDEV_A_QUEUE_TYPE + 1];
 
@@ -36,6 +37,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..aae75431858d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1120,6 +1120,11 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e0b579a1df4f..7df1056a35fd 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -160,6 +160,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_LEASE,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -202,6 +203,15 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_LEASE_IFINDEX = 1,
+	NETDEV_A_LEASE_QUEUE,
+	NETDEV_A_LEASE_NETNS_ID,
+
+	__NETDEV_A_LEASE_MAX,
+	NETDEV_A_LEASE_MAX = (__NETDEV_A_LEASE_MAX - 1)
+};
+
 enum {
 	NETDEV_A_DMABUF_IFINDEX = 1,
 	NETDEV_A_DMABUF_QUEUES,
@@ -228,6 +238,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_QUEUE_CREATE,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.43.0


