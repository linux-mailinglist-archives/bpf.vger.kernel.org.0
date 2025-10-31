Return-Path: <bpf+bounces-73195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F55C2704C
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A214B188F8A0
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8D30CD98;
	Fri, 31 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="S8Sglv2F"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F30FF1C;
	Fri, 31 Oct 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945694; cv=none; b=A5qQw57w5wzn6NAIhIyXla1qk5n1oOA8RH1iygeBuJJYDx7BH3rbJf37MMFqtHbU8zUHRRwNkh/Sx5nNm9WW5QGZ0hkA4KHIwtKSXaEA6rd0Qiac4IjzvAfRijf//i+sE+eQiF2vKtXl2Nd+Im7eX843+X2lG0+Xqs/J3e0RZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945694; c=relaxed/simple;
	bh=N3BPYUnny944PVjEgeR9sMSDxXSplAwlEmO2XvatyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV6HJsQ4WiFoMxhS/sPyKC6sYBxIkeW2HVu233MWDJICG39jek6c3MZCoqchCn4GsYkoHRXTyLn/9u0igpR7fNeL04AvJX6QoTgMlOabw6nQVP+sqmPypku7Y/gn/KT+b559i1k842L6i+M0ypIiAROYtfdGfbyBA2Oe4MOcJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=S8Sglv2F; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9bfTRxeskncxBJ9KUKWdbMBAd07N2tPA+5yOc491aOU=; b=S8Sglv2Fc2Mk5LHR3Pqxap0A01
	t5DA/aJpJLQ4ajxTpTvH4orUihYe3IIjpY/3h2bLxWW1NfV5allHSCimLM0cTqj0Pgtjp99RaIGuC
	i7f1YldGVAp0PFj+9BeW8UfJ4SmRK+OphQTq2R+SEzKEAo/ybt0GIwtWcnIJAk/zRUiG+KKltzyRO
	0+1lLVB/mWL8MtTrbdX4X9Pyky10p8PuPvsjlV7fKlpbsMRI0Z4ZZJqBkg+iFdhPN8XiMQSjBJkgX
	tgf7+KvgGmHjVkuhgpC9LmOlo3qg+iFgrpq7otdd/bysa3kidPvQZ+VouGWIKF4ue+27O2fvHfq8F
	4RjbfuoQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYW-0005cK-2F;
	Fri, 31 Oct 2025 22:21:08 +0100
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
Subject: [PATCH net-next v4 03/14] net: Add peer info to queue-get response
Date: Fri, 31 Oct 2025 22:20:52 +0100
Message-ID: <20251031212103.310683-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

From: David Wei <dw@davidwei.uk>

Add a nested peer field to the queue-get response that returns the peered
ifindex, queue id and optionally netns id if the device resides in a
different netns.

Example with ynl client:

  # ip a
  [...]
  4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
    link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 scope global enp10s0f0np0
       valid_lft forever preferred_lft forever
    inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
  [...]

  # ethtool -i enp10s0f0np0
  driver: mlx5_core
  [...]

  # ip netns exec foo ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 4, "id": 15, "type": "rx"}'
  {'id': 15,
   'ifindex': 4,
   'napi-id': 8227,
   'peer': {'id': 1, 'ifindex': 8, 'netns-id': 0},
   'type': 'rx',
   'xsk': {}}

  # ip netns list
  foo (id: 0)

  # ip netns exec foo ip a
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
      inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
         valid_lft forever preferred_lft forever
  [...]

  # ip netns exec foo ethtool -i nk
  driver: netkit
  [...]

  # ip netns exec foo ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 8, "id": 1, "type": "rx"}'
  {'id': 1, 'ifindex': 8, 'type': 'rx'}

Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
lock. For the queue-get we do not lock both devices. When queues get
{un,}peered, both devices are locked, thus if __netif_get_rx_queue_peer()
returns true, the peer pointer points to a valid device. The netns-id
is fetched via peernet2id_alloc() similarly as done in OVS.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 Documentation/netlink/specs/netdev.yaml | 24 +++++++++++++++++
 include/net/netdev_rx_queue.h           |  9 +++++++
 include/uapi/linux/netdev.h             | 10 ++++++++
 net/core/netdev-genl.c                  | 34 +++++++++++++++++++++++--
 net/core/netdev_rx_queue.c              | 19 +++++++++++---
 tools/include/uapi/linux/netdev.h       | 10 ++++++++
 6 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1e24c7f76de0..e1735b486222 100644
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
index 3a02d47e42bc..d2505d099400 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -92,4 +92,13 @@ netif_get_rx_queue_peer_locked(struct net_device **dev,
 			       unsigned int *rxq_idx);
 void netif_put_rx_queue_peer_locked(struct net_device *orig_dev,
 				    struct net_device *dev);
+
+enum netif_peer_dir {
+	NETIF_VIRT_TO_PHYS,
+	NETIF_PHYS_TO_VIRT,
+};
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx,
+			  enum netif_peer_dir dir);
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
index 4fa7e881441f..5cf7a9ca2e4b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -391,8 +391,11 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
 	struct pp_memory_provider_params *params;
+	struct net_device *orig_netdev = netdev;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
+	u32 peer_q_idx = q_idx;
+	struct nlattr *nest;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -410,6 +413,33 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 
+		if (__netif_get_rx_queue_peer(&netdev, &peer_q_idx,
+					      NETIF_PHYS_TO_VIRT)) {
+			struct net *net, *peer_net;
+
+			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_PEER);
+			if (!nest)
+				goto nla_put_failure;
+
+			if (nla_put_u32(rsp, NETDEV_A_PEER_INFO_ID, peer_q_idx) ||
+			    nla_put_u32(rsp, NETDEV_A_PEER_INFO_IFINDEX,
+					READ_ONCE(netdev->ifindex)))
+				goto nla_put_failure;
+
+			rcu_read_lock();
+			peer_net = dev_net_rcu(netdev);
+			net = dev_net_rcu(orig_netdev);
+			if (!net_eq(net, peer_net)) {
+				s32 id = peernet2id_alloc(net, peer_net, GFP_ATOMIC);
+
+				if (nla_put_s32(rsp, NETDEV_A_PEER_INFO_NETNS_ID, id))
+					goto nla_put_failure_unlock;
+			}
+			rcu_read_unlock();
+			nla_nest_end(rsp, nest);
+			netdev = orig_netdev;
+		}
+
 		params = &rxq->mp_params;
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
@@ -419,7 +449,6 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
 				goto nla_put_failure;
 #endif
-
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
@@ -434,9 +463,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
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
index 6eb12f3b969c..889b7382cdb6 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -42,14 +42,25 @@ void netdev_rx_queue_unpeer(struct net_device *src_dev,
 	netdev_put(src_dev, &src_rxq->peer_tracker);
 }
 
-static struct netdev_rx_queue *
-__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx)
+static bool netif_peer_dir_ok(const struct net_device *dev,
+			      enum netif_peer_dir dir)
+{
+	if (dir == NETIF_VIRT_TO_PHYS && !dev->dev.parent)
+		return true;
+	if (dir == NETIF_PHYS_TO_VIRT && dev->dev.parent)
+		return true;
+	return false;
+}
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx,
+			  enum netif_peer_dir dir)
 {
 	struct net_device *orig_dev = *dev;
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(orig_dev, *rxq_idx);
 
 	if (rxq->peer) {
-		if (orig_dev->dev.parent)
+		if (!netif_peer_dir_ok(orig_dev, dir))
 			return NULL;
 		rxq = rxq->peer;
 		*rxq_idx = get_netdev_rx_queue_index(rxq);
@@ -68,7 +79,7 @@ netif_get_rx_queue_peer_locked(struct net_device **dev, unsigned int *rxq_idx)
 	 * see netdev_nl_bind_queue_doit().
 	 */
 	netdev_ops_assert_locked(orig_dev);
-	rxq = __netif_get_rx_queue_peer(dev, rxq_idx);
+	rxq = __netif_get_rx_queue_peer(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
 	if (rxq && orig_dev != *dev)
 		netdev_lock(*dev);
 	return rxq;
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


