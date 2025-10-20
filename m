Return-Path: <bpf+bounces-71419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C0BF2656
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D551E18A7D20
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765128DB71;
	Mon, 20 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DGrYl4is"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C727B4F9;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=tI1wSfERjpbfDIeqJrn6bT9upb89aMEfDL20Fy6xKE/T96zmQxnKUziQuAQt/2UxuPa+LQrJuL2s9FCdK84F9Gnt5rvCMNT6+Nw3z4pondJhAQ3XliBFcbxuAnPat/pmMLLpgAOEt/kdLcEwFNCw05Rhs+2/eV+godfv0/XiXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=22Sp1Ubk/1T7W6H2wKlF+PClET5LMtTme1lJVFic2HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX/1OSR9wSPe+WPi5A9RD+zCU9B9EMmnRCb6HpZgxADkoiZyUj7gmcjaVagRASIV1AZoDCO80oajxkE+bfJNILTrDsv3/qTO4LAr72sN45jt/zoSXVOaE9xMXegJaXHSpPllkEmWUCgGRHcBNI4JAekMZDAoVymFIWt66Cv0VRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DGrYl4is; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2xFmGOq6inuHI0lVhJVsaPt71VXBvnhK+/0uEA8R474=; b=DGrYl4isU0j2AbXL/TLx+UMJn2
	LjyLRj9uUsDMuDVW7eSO4I3BJkXyU6nUljyIPbJJjydDhP9SUufqb5TK29Tq50mloS9HtUrrn6nrp
	xDJV7Nw+8jae6U10ulf3c/eBu5x1tFnXKD8H+vzE/b04+fBehHM0T8ELUCONOBTO63fMqKh4IYp8Q
	qpPLUWKudT+Dt6dHzlM0koBmT4MWsTTNmrktl5jASwpPfh2TeptcK/EABrLJyIBXmQTe46qXK9X67
	TQA4uSkxhjQ4/wMFi5SJRWPn4g/a0zPT5K7XYAK8OOPNjAUxU8JJBxooaYDbhZwILbyrhSEXcOSfB
	Sjst9LrQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsfw-000Jih-0d;
	Mon, 20 Oct 2025 18:24:00 +0200
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
Subject: [PATCH net-next v3 03/15] net: Add peer info to queue-get response
Date: Mon, 20 Oct 2025 18:23:43 +0200
Message-ID: <20251020162355.136118-4-daniel@iogearbox.net>
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

Add a nested peer field to the queue-get response that returns the peered
ifindex and queue id.

Example with ynl client:

  # ip netns exec foo ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 3, "id": 1, "type": "rx"}'
  {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}

Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
lock. For the queue-get we do not lock both devices. When queues get
{un,}peered, both devices are locked, thus if netdev_rx_queue_peered()
returns true, the peer pointer points to a valid device. The netns-id
is fetched via peernet2id_alloc() similarly as done in OVS.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/netlink/specs/netdev.yaml | 24 ++++++++++++++++++
 include/net/netdev_rx_queue.h           |  3 +++
 include/uapi/linux/netdev.h             | 10 ++++++++
 net/core/netdev-genl.c                  | 33 +++++++++++++++++++++++--
 net/core/netdev_rx_queue.c              |  8 ++++++
 tools/include/uapi/linux/netdev.h       | 10 ++++++++
 6 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 20bb00b7e9ac..a3c562dfd205 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -297,6 +297,24 @@ attribute-sets:
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
+      -
+        name: netns-id
+        doc: |
+          Network namespace of the netdevice to which the peer queue belongs.
+          This is populated if the netdevices are not in the same network
+          namespace.
+        type: s32
   -
     name: queue
     attributes:
@@ -338,6 +356,11 @@ attribute-sets:
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
@@ -723,6 +746,7 @@ operations:
             - dmabuf
             - io-uring
             - xsk
+            - peer
       dump:
         request:
           attributes:
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index db3ef94c0744..ea23cca947bb 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -90,4 +90,7 @@ struct netdev_rx_queue *
 netif_get_rx_queue_peer_locked(struct net_device **dev,
 			       unsigned int *rxq_idx,
 			       bool *needs_unlock);
+struct netdev_rx_queue *
+netif_get_rx_queue_peer_any(struct net_device **dev,
+			    unsigned int *rxq_idx);
 #endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 4ef04d0bc412..d4d5d9f86eee 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -150,6 +150,15 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PEER_INFO_ID = 1,
+	NETDEV_A_PEER_INFO_IFINDEX,
+	NETDEV_A_PEER_INFO_NETNS_ID,
+
+	__NETDEV_A_PEER_INFO_MAX,
+	NETDEV_A_PEER_INFO_MAX = (__NETDEV_A_PEER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -158,6 +167,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_PEER,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 579469abac8c..28658b5cd7a4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -393,6 +393,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	struct pp_memory_provider_params *params;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
+	struct nlattr *nest;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -410,6 +411,34 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 
+		if (netdev_rx_queue_peered(netdev, q_idx)) {
+			struct net_device *p_netdev = netdev;
+			struct net *net, *p_net;
+			u32 p_q_idx = q_idx;
+
+			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_PEER);
+			if (!nest)
+				goto nla_put_failure;
+
+			netif_get_rx_queue_peer_any(&p_netdev, &p_q_idx);
+			if (nla_put_u32(rsp, NETDEV_A_PEER_INFO_ID, p_q_idx) ||
+			    nla_put_u32(rsp, NETDEV_A_PEER_INFO_IFINDEX,
+					READ_ONCE(p_netdev->ifindex)))
+				goto nla_put_failure;
+
+			rcu_read_lock();
+			p_net = dev_net_rcu(p_netdev);
+			net = dev_net_rcu(netdev);
+			if (!net_eq(net, p_net)) {
+				s32 id = peernet2id_alloc(net, p_net, GFP_ATOMIC);
+
+				if (nla_put_s32(rsp, NETDEV_A_PEER_INFO_NETNS_ID, id))
+					goto nla_put_failure_unlock;
+			}
+			rcu_read_unlock();
+			nla_nest_end(rsp, nest);
+		}
+
 		params = &rxq->mp_params;
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
@@ -419,7 +448,6 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
 				goto nla_put_failure;
 #endif
-
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
@@ -434,9 +462,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	}
 
 	genlmsg_end(rsp, hdr);
-
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	genlmsg_cancel(rsp, hdr);
 	return -EMSGSIZE;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 916ca8d7ae7c..8ee289316c06 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -79,6 +79,14 @@ netif_get_rx_queue_peer_locked(struct net_device **dev, unsigned int *rxq_idx,
 	return rxq;
 }
 
+struct netdev_rx_queue *
+netif_get_rx_queue_peer_any(struct net_device **dev, unsigned int *rxq_idx)
+{
+	netdev_ops_assert_locked(*dev);
+	/* Retrieves both virt-to-phys and phys-to-virt peering. */
+	return __netif_get_rx_queue_peer(dev, rxq_idx, false);
+}
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 4ef04d0bc412..d4d5d9f86eee 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -150,6 +150,15 @@ enum {
 	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PEER_INFO_ID = 1,
+	NETDEV_A_PEER_INFO_IFINDEX,
+	NETDEV_A_PEER_INFO_NETNS_ID,
+
+	__NETDEV_A_PEER_INFO_MAX,
+	NETDEV_A_PEER_INFO_MAX = (__NETDEV_A_PEER_INFO_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -158,6 +167,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_PEER,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.43.0


