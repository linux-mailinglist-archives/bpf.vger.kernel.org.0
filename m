Return-Path: <bpf+bounces-68983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C7B8B592
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE2B5C02D5
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689922D7DC8;
	Fri, 19 Sep 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pFjPb+cy"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD22D063D;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317531; cv=none; b=oYgHWkKoIiHdKPfWJFrA9VPgovGchpRB7YT7sbo5X0WZDDzQKff8pPGrh4dGGGx8TLXXozUiJyLu4RIoCsQeoHI16yf2wSWVM6pgP9DpR9Z3d2D0bZ/NlRQv2Yd9x67LEN4x0IeJa26bLK5/LGHgWFhEHroMYWqjPsZd6oomVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317531; c=relaxed/simple;
	bh=usdW0SQcq55RuopFtcXe2iNq5lsGjiQOeFVKc4CZpk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqfCgcyFtXEMe1YZUxBKVTfbCHEILS8EQhwbdwNP4VZ+lfbcbsnzN0wwRL+M0Syz2Pcf4zArfQtbfZV2HzsSpdLmemTCpCj6qoNtA4GmEgDrU3LVsKg4dGH0S3QXyHU3L8+vDeZL4JIsNkvlwbguU59Kwa0i2OiqvCsa8jNzNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pFjPb+cy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oppZc5jiprD9oT98ObGJpSbUSe/d1l7YpT9BhIRilrY=; b=pFjPb+cyzPo0irop8VK9UwOoFR
	4aSfmpAQGxcdQ+/KOvChQvoWYtXwzwy9TlZasO6VkNpr6dUvs4m7hu2sS3epE0CQySeoWrIorPTaz
	qY2YhkXweiB9sbOx4RbhJQ4Ka7NnuNcwY79kJswfWokli8ooJihEdCo5PD7s2gui1kTfVbqhFgv6V
	twbCFtxBKzKjBnTW0AT93CbMrogDBWJDiN6WruoDy+Rqi4qQ2FU3xaNSp7sjcvQp43RTNhUiOqknh
	ha2Oz7j+nLARI0A3mJnoKntH1HZcxbM25iqJRJZaKdBpeEiYPDCPieRMFZEyIVLmCguEueV4fDs3v
	AX2BSdDg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii0-000NqH-2q;
	Fri, 19 Sep 2025 23:32:00 +0200
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
Subject: [PATCH net-next 06/20] net, ynl: Add peer info to queue-get response
Date: Fri, 19 Sep 2025 23:31:39 +0200
Message-ID: <20250919213153.103606-7-daniel@iogearbox.net>
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

Add a nested peer field to the queue-get response that returns the
peered ifindex and queue id. If the queried queue is a mapped queue
in a virtual netdev, the nested fields for dmabuf/io-uring/xsk will
be filled in, too.

Example:

  # ip netns exec foo ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 3, "id": 1, "type": "rx"}'
  {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4}, 'io-uring': {}, 'type': 'rx'}

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/netlink/specs/netdev.yaml | 17 +++++++++++++++++
 include/uapi/linux/netdev.h             |  9 +++++++++
 net/core/netdev-genl.c                  | 23 ++++++++++++++++++++++-
 tools/include/uapi/linux/netdev.h       |  9 +++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 99a430ea8a9a..1467c36f6b5f 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -297,6 +297,17 @@ attribute-sets:
   -
     name: xsk-info
     attributes: []
+  -
+    name: peer-info
+    attributes:
+      -
+        name: id
+        doc: Queue index of the netdevice to which the peer queue belongs.
+        type: u32
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which the peer queue belongs.
+        type: u32
   -
     name: queue
     attributes:
@@ -338,6 +349,11 @@ attribute-sets:
         doc: XSK information for this queue, if any.
         type: nest
         nested-attributes: xsk-info
+      -
+        name: peer
+        doc: Whether this queue was bound to another peer queue.
+        type: nest
+        nested-attributes: peer-info
   -
     name: qstats
     doc: |
@@ -706,6 +722,7 @@ operations:
             - dmabuf
             - io-uring
             - xsk
+            - peer
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 05e17765a39d..73d1590e4696 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -150,6 +150,14 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PEER_INFO_ID = 1,
+	NETDEV_A_PEER_INFO_IFINDEX,
+
+	__NETDEV_A_PEER_INFO_MAX,
+	NETDEV_A_PEER_INFO_MAX = (__NETDEV_A_PEER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -158,6 +166,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_PEER,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index ed0ce3dbfc6f..c20922539216 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -393,6 +393,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	struct pp_memory_provider_params *params;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
+	struct nlattr *nest;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -410,6 +411,27 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 
+		if (netdev_rx_queue_peered(netdev, q_idx)) {
+			struct netdev_rx_queue *p_rxq;
+			struct net_device *p_netdev = netdev;
+			u32 p_q_idx = q_idx;
+
+			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_PEER);
+			if (!nest)
+				goto nla_put_failure;
+			p_rxq = __netif_get_rx_queue_peer(&p_netdev, &p_q_idx);
+			if (nla_put_u32(rsp, NETDEV_A_PEER_INFO_ID, p_q_idx) ||
+			    nla_put_u32(rsp, NETDEV_A_PEER_INFO_IFINDEX, p_netdev->ifindex))
+				goto nla_put_failure;
+			nla_nest_end(rsp, nest);
+
+			if (!netdev->dev.parent) {
+				netdev = p_netdev;
+				q_idx = p_q_idx;
+				rxq = p_rxq;
+			}
+		}
+
 		params = &rxq->mp_params;
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
@@ -419,7 +441,6 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
 				goto nla_put_failure;
 #endif
-
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 05e17765a39d..73d1590e4696 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -150,6 +150,14 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PEER_INFO_ID = 1,
+	NETDEV_A_PEER_INFO_IFINDEX,
+
+	__NETDEV_A_PEER_INFO_MAX,
+	NETDEV_A_PEER_INFO_MAX = (__NETDEV_A_PEER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -158,6 +166,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_PEER,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.43.0


