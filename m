Return-Path: <bpf+bounces-78394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E928D0C51A
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA77330A36DC
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3F33D6EC;
	Fri,  9 Jan 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O+Db6MEB"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000133D50C;
	Fri,  9 Jan 2026 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994025; cv=none; b=p2ttKPfJb6WfQTEQdTLm2RXyh+MrKNfbBvYDP+wBTtvueOU5yNnzuuquFVqxcjdrv3fV3Weda1ryQe4ixhHAjIXpVFgYsFo8hOocBXQ7VtoLjVdoYjxEGvKFaUIBYWydpCT1NVQhgDssH0RjzhSE0bPizlePBudV8i6XjDA/GC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994025; c=relaxed/simple;
	bh=dMQSAlrh4tJCS9xLK7FxrOplNJbCcDGarQvFPFS+7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbUyH7ZaZj01SbjqoBROBs2yewHTKaeTlPmOFSQtKTjlKIbucfjsb1qaOkmVcsiBeOo82Oy1XoVl9LHeLp6WvEgnk4yq0yVV+rqzOaJzWsHKyYVyE7x0H6Z9PgbLtfPzv5UATTeM86M5PGTAu5a/4O2R++I3D44KgCMyErirFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O+Db6MEB; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5k0TkGA7AzD+s9tVJrNQn9vHQHakrPyWfA266GzgxCc=; b=O+Db6MEBrXT1LHxGunpNLfLNtk
	Te/j/A7G0jHsCaq3nG+onf9AxadMngD5AoQhhEXE76j4aDy1zZMBF7oe5HltRNmOv2gIHqmk/FQIn
	XJnhcT9vVxVFWGpq3Zgucy/5kkx4nccTS0WtepY26pOp5GOEAd5zM4zTao1Uh8v1ROVbhwtBgcTOn
	cRF/m/pn7v9NkA7Gjg+Pgp9t6Ug1mCnnisd0r8+9muzJNtb+9D3vS/YdMS8NPdUDo1NRagBrSjmeS
	r8o66SnwEHm6AplvdnhHJfVBCYgaDqLPOM3Dtzg3kNDH0qdnuk5obRRmYKx8VV3Pz6drANJ9fF/tU
	RlOXl4Dw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0K-00054G-1b;
	Fri, 09 Jan 2026 22:26:44 +0100
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
Subject: [PATCH net-next v5 09/16] netkit: Add single device mode for netkit
Date: Fri,  9 Jan 2026 22:26:25 +0100
Message-ID: <20260109212632.146920-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109212632.146920-1-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27875/Fri Jan  9 08:26:02 2026)

Add a single device mode for netkit instead of netkit pairs. The primary
target for the paired devices is to connect network namespaces, of course,
and support has been implemented in projects like Cilium [0]. For the rxq
leasing the plan is to support two main scenarios related to single device
mode:

* For the use-case of io_uring zero-copy, the control plane can either
  set up a netkit pair where the peer device can perform rxq leasing which
  is then tied to the lifetime of the peer device, or the control plane
  can use a regular netkit pair to connect the hostns to a Pod/container
  and dynamically add/remove rxq leasing through a single device without
  having to interrupt the device pair. In the case of io_uring, the memory
  pool is used as skb non-linear pages, and thus the skb will go its way
  through the regular stack into netkit. Things like the netkit policy when
  no BPF is attached or skb scrubbing etc apply as-is in case the paired
  devices are used, or if the backend memory is tied to the single device
  and traffic goes through a paired device.

* For the use-case of AF_XDP, the control plane needs to use netkit in the
  single device mode. The single device mode currently enforces only a
  pass policy when no BPF is attached, and does not yet support BPF link
  attachments for AF_XDP. skbs sent to that device get dropped at the
  moment. Given AF_XDP operates at a lower layer of the stack tying this
  to the netkit pair did not make sense. In future, the plan is to allow
  BPF at the XDP layer which can: i) process traffic coming from the AF_XDP
  application (e.g. QEMU with AF_XDP backend) to filter egress traffic or
  to push selected egress traffic up to the single netkit device to the
  local stack (e.g. DHCP requests), and ii) vice-versa skbs sent to the
  single netkit into the AF_XDP application (e.g. DHCP replies). Also,
  the control-plane can dynamically manage rxq leasing for the single
  netkit device without having to interrupt (e.g. down/up cycle) the main
  netkit pair for the Pod which has traffic going in and out.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://docs.cilium.io/en/stable/operations/performance/tuning/#netkit-device-mode [0]
---
 drivers/net/netkit.c         | 108 ++++++++++++++++++++++-------------
 include/uapi/linux/if_link.h |   6 ++
 2 files changed, 74 insertions(+), 40 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 0a2fef7caccb..96734828bfb8 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -26,6 +26,7 @@ struct netkit {
 
 	__cacheline_group_begin(netkit_slowpath);
 	enum netkit_mode mode;
+	enum netkit_pairing pair;
 	bool primary;
 	u32 headroom;
 	__cacheline_group_end(netkit_slowpath);
@@ -135,6 +136,10 @@ static int netkit_open(struct net_device *dev)
 	struct netkit *nk = netkit_priv(dev);
 	struct net_device *peer = rtnl_dereference(nk->peer);
 
+	if (nk->pair == NETKIT_DEVICE_SINGLE) {
+		netif_carrier_on(dev);
+		return 0;
+	}
 	if (!peer)
 		return -ENOTCONN;
 	if (peer->flags & IFF_UP) {
@@ -335,6 +340,7 @@ static int netkit_new_link(struct net_device *dev,
 	enum netkit_scrub scrub_prim = NETKIT_SCRUB_DEFAULT;
 	enum netkit_scrub scrub_peer = NETKIT_SCRUB_DEFAULT;
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;
+	enum netkit_pairing pair = NETKIT_DEVICE_PAIR;
 	enum netkit_action policy_prim = NETKIT_PASS;
 	enum netkit_action policy_peer = NETKIT_PASS;
 	struct nlattr **data = params->data;
@@ -343,7 +349,7 @@ static int netkit_new_link(struct net_device *dev,
 	struct nlattr **tb = params->tb;
 	u16 headroom = 0, tailroom = 0;
 	struct ifinfomsg *ifmp = NULL;
-	struct net_device *peer;
+	struct net_device *peer = NULL;
 	char ifname[IFNAMSIZ];
 	struct netkit *nk;
 	int err;
@@ -380,6 +386,8 @@ static int netkit_new_link(struct net_device *dev,
 			headroom = nla_get_u16(data[IFLA_NETKIT_HEADROOM]);
 		if (data[IFLA_NETKIT_TAILROOM])
 			tailroom = nla_get_u16(data[IFLA_NETKIT_TAILROOM]);
+		if (data[IFLA_NETKIT_PAIRING])
+			pair = nla_get_u32(data[IFLA_NETKIT_PAIRING]);
 	}
 
 	if (ifmp && tbp[IFLA_IFNAME]) {
@@ -392,45 +400,49 @@ static int netkit_new_link(struct net_device *dev,
 	if (mode != NETKIT_L2 &&
 	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
 		return -EOPNOTSUPP;
+	if (pair == NETKIT_DEVICE_SINGLE &&
+	    (tb != tbp ||
+	     tb[IFLA_NETKIT_PEER_POLICY] ||
+	     tb[IFLA_NETKIT_PEER_SCRUB] ||
+	     policy_prim != NETKIT_PASS))
+		return -EOPNOTSUPP;
 
-	peer = rtnl_create_link(peer_net, ifname, ifname_assign_type,
-				&netkit_link_ops, tbp, extack);
-	if (IS_ERR(peer))
-		return PTR_ERR(peer);
-
-	netif_inherit_tso_max(peer, dev);
-	if (headroom) {
-		peer->needed_headroom = headroom;
-		dev->needed_headroom = headroom;
-	}
-	if (tailroom) {
-		peer->needed_tailroom = tailroom;
-		dev->needed_tailroom = tailroom;
-	}
-
-	if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
-		eth_hw_addr_random(peer);
-	if (ifmp && dev->ifindex)
-		peer->ifindex = ifmp->ifi_index;
-
-	nk = netkit_priv(peer);
-	nk->primary = false;
-	nk->policy = policy_peer;
-	nk->scrub = scrub_peer;
-	nk->mode = mode;
-	nk->headroom = headroom;
-	bpf_mprog_bundle_init(&nk->bundle);
+	if (pair == NETKIT_DEVICE_PAIR) {
+		peer = rtnl_create_link(peer_net, ifname, ifname_assign_type,
+					&netkit_link_ops, tbp, extack);
+		if (IS_ERR(peer))
+			return PTR_ERR(peer);
+
+		netif_inherit_tso_max(peer, dev);
+		if (headroom)
+			peer->needed_headroom = headroom;
+		if (tailroom)
+			peer->needed_tailroom = tailroom;
+		if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
+			eth_hw_addr_random(peer);
+		if (ifmp && dev->ifindex)
+			peer->ifindex = ifmp->ifi_index;
 
-	err = register_netdevice(peer);
-	if (err < 0)
-		goto err_register_peer;
-	netif_carrier_off(peer);
-	if (mode == NETKIT_L2)
-		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
+		nk = netkit_priv(peer);
+		nk->primary = false;
+		nk->policy = policy_peer;
+		nk->scrub = scrub_peer;
+		nk->mode = mode;
+		nk->pair = pair;
+		nk->headroom = headroom;
+		bpf_mprog_bundle_init(&nk->bundle);
+
+		err = register_netdevice(peer);
+		if (err < 0)
+			goto err_register_peer;
+		netif_carrier_off(peer);
+		if (mode == NETKIT_L2)
+			dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
 
-	err = rtnl_configure_link(peer, NULL, 0, NULL);
-	if (err < 0)
-		goto err_configure_peer;
+		err = rtnl_configure_link(peer, NULL, 0, NULL);
+		if (err < 0)
+			goto err_configure_peer;
+	}
 
 	if (mode == NETKIT_L2 && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
@@ -438,12 +450,17 @@ static int netkit_new_link(struct net_device *dev,
 		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
 		strscpy(dev->name, "nk%d", IFNAMSIZ);
+	if (headroom)
+		dev->needed_headroom = headroom;
+	if (tailroom)
+		dev->needed_tailroom = tailroom;
 
 	nk = netkit_priv(dev);
 	nk->primary = true;
 	nk->policy = policy_prim;
 	nk->scrub = scrub_prim;
 	nk->mode = mode;
+	nk->pair = pair;
 	nk->headroom = headroom;
 	bpf_mprog_bundle_init(&nk->bundle);
 
@@ -455,10 +472,12 @@ static int netkit_new_link(struct net_device *dev,
 		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
 
 	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
-	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
+	if (peer)
+		rcu_assign_pointer(netkit_priv(peer)->peer, dev);
 	return 0;
 err_configure_peer:
-	unregister_netdevice(peer);
+	if (peer)
+		unregister_netdevice(peer);
 	return err;
 err_register_peer:
 	free_netdev(peer);
@@ -518,6 +537,8 @@ static struct net_device *netkit_dev_fetch(struct net *net, u32 ifindex, u32 whi
 	nk = netkit_priv(dev);
 	if (!nk->primary)
 		return ERR_PTR(-EACCES);
+	if (nk->pair == NETKIT_DEVICE_SINGLE)
+		return ERR_PTR(-EOPNOTSUPP);
 	if (which == BPF_NETKIT_PEER) {
 		dev = rcu_dereference_rtnl(nk->peer);
 		if (!dev)
@@ -879,6 +900,7 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 		{ IFLA_NETKIT_PEER_INFO,  "peer info" },
 		{ IFLA_NETKIT_HEADROOM,   "headroom" },
 		{ IFLA_NETKIT_TAILROOM,   "tailroom" },
+		{ IFLA_NETKIT_PAIRING,    "pairing" },
 	};
 
 	if (!nk->primary) {
@@ -898,9 +920,11 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_NETKIT_POLICY]) {
+		err = -EOPNOTSUPP;
 		attr = data[IFLA_NETKIT_POLICY];
 		policy = nla_get_u32(attr);
-		err = netkit_check_policy(policy, attr, extack);
+		if (nk->pair == NETKIT_DEVICE_PAIR)
+			err = netkit_check_policy(policy, attr, extack);
 		if (err)
 			return err;
 		WRITE_ONCE(nk->policy, policy);
@@ -931,6 +955,7 @@ static size_t netkit_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(u8))  + /* IFLA_NETKIT_PRIMARY */
 	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_HEADROOM */
 	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_TAILROOM */
+	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_PAIRING */
 	       0;
 }
 
@@ -951,6 +976,8 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		return -EMSGSIZE;
 	if (nla_put_u16(skb, IFLA_NETKIT_TAILROOM, dev->needed_tailroom))
 		return -EMSGSIZE;
+	if (nla_put_u32(skb, IFLA_NETKIT_PAIRING, nk->pair))
+		return -EMSGSIZE;
 
 	if (peer) {
 		nk = netkit_priv(peer);
@@ -972,6 +999,7 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_TAILROOM]		= { .type = NLA_U16 },
 	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
 	[IFLA_NETKIT_PEER_SCRUB]	= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
+	[IFLA_NETKIT_PAIRING]		= NLA_POLICY_MAX(NLA_U32, NETKIT_DEVICE_SINGLE),
 	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
 					    .reject_message = "Primary attribute is read-only" },
 };
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b491d96e52e..bbd565757298 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1296,6 +1296,11 @@ enum netkit_mode {
 	NETKIT_L3,
 };
 
+enum netkit_pairing {
+	NETKIT_DEVICE_PAIR,
+	NETKIT_DEVICE_SINGLE,
+};
+
 /* NETKIT_SCRUB_NONE leaves clearing skb->{mark,priority} up to
  * the BPF program if attached. This also means the latter can
  * consume the two fields if they were populated earlier.
@@ -1320,6 +1325,7 @@ enum {
 	IFLA_NETKIT_PEER_SCRUB,
 	IFLA_NETKIT_HEADROOM,
 	IFLA_NETKIT_TAILROOM,
+	IFLA_NETKIT_PAIRING,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
-- 
2.43.0


