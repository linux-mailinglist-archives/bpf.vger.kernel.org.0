Return-Path: <bpf+bounces-10847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B207AE560
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 24852281ACB
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01271539E;
	Tue, 26 Sep 2023 05:59:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50E4408;
	Tue, 26 Sep 2023 05:59:39 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C20E9;
	Mon, 25 Sep 2023 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=n2eG0ZCm11VCNUOtMZq/I1YodnPen7WqvyZ2P82KCto=; b=bVN6/EbtAQG4ROL5e+9EcqdTRC
	eFeYhFnfAxanw88Mr6E1LXHFkuJooD6JRvKqjVKXq6RcXyDrgdPKYPElYDriHL1iESrTpeuwgwOc5
	CyuxSUfD7FoLhfE1i3Sk+B2phjX6otFz0e53LrX/uY7AVulztsowVbTvoR/PRy/XhUNM8pmFBUUkn
	OQ4h7tbZYwE+0OIsujLwFnfGMMafspxMgGYTESS7QRQEQHl+6MWaNIuigZ5olGJ/bAXtummRDeIzL
	muy3UZgKn4c8khGFt5KGoT7BDaxUYh/DzAevmdHQD53eYElwJXPspdTDhXSfQUrdNKJYKgGjU8laU
	DZNwgg4Q==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16a-0006mn-UV; Tue, 26 Sep 2023 07:59:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
Date: Tue, 26 Sep 2023 07:59:06 +0200
Message-Id: <20230926055913.9859-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926055913.9859-1-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This work adds a new, minimal BPF-programmable device called "meta" we
recently presented at LSF/MM/BPF. The latter name derives from the Greek
μετά, encompassing a wide array of meanings such as "on top of", "beyond".
Given business logic is defined by BPF, this device can have many meanings.
The core idea is that BPF programs are executed within the drivers xmit
routine and therefore e.g. in case of containers/Pods moving BPF processing
closer to the source.

One of the goals was that in case of Pod egress traffic, this allows to
move BPF programs from hostns tcx ingress into the device itself, providing
earlier drop or forward mechanisms, for example, if the BPF program
determines that the skb must be sent out of the node, then a redirect to
the physical device can take place directly without going through per-CPU
backlog queue. This helps to shift processing for such traffic from softirq
to process context, leading to better scheduling decisions and better
performance.

In this initial version, the meta device ships as a pair, but we plan to
extend this further so it can also operate in single device mode. The pair
comes with a primary and a peer device. Only the primary device, typically
residing in hostns, can manage BPF programs for itself and its peer. The
peer device is designated for containers/Pods and cannot attach/detach
BPF programs. Upon the device creation, the user can set the default policy
to 'forward' or 'drop' for the case when no BPF program is attached.

Additionally, the device can be operated in L3 (default) or L2 mode. The
management of BPF programs is done via bpf_mprog, so that multi-attach is
supported right from the beginning with similar API/dependency controls as
tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add generic
attach/detach/query API for multi-progs"). tc BPF compatibility is provided,
so that existing programs can be easily migrated.

Going forward, we plan to use meta devices in Cilium as the main device type
for connecting Pods. They will be operated in L3 mode in order to simplify
a Pod's neighbor management and the peer will operate in default drop mode,
so that no traffic is leaving between the time when a Pod is brought up by
the CNI plugin and programs attached by the agent. Additionally, the programs
we attach via tcx on the physical devices are using bpf_redirect_peer()
for inbound traffic into meta device, hence the latter also supporting the
ndo_get_peer_dev callback. Similarly, we use bpf_redirect_neigh() for the
way out, pushing to phys device directly. Also, BIG TCP is supported on meta
device. For the follow-up work in single device mode, we plan to convert
Cilium's cilium_host/_net devices into a single one.

An extensive test suite for checking device operations and the BPF program
and link management API comes as BPF selftests in this series.

Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://github.com/borkmann/iproute2/commits/pr/meta
Link: http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf (24ff.)
---
 MAINTAINERS                    |   9 +
 drivers/net/Kconfig            |   9 +
 drivers/net/Makefile           |   1 +
 drivers/net/meta.c             | 734 +++++++++++++++++++++++++++++++++
 include/linux/netdevice.h      |   2 +
 include/net/meta.h             |  31 ++
 include/uapi/linux/bpf.h       |   2 +
 include/uapi/linux/if_link.h   |  25 ++
 kernel/bpf/syscall.c           |  30 +-
 tools/include/uapi/linux/bpf.h |   2 +
 10 files changed, 840 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/meta.c
 create mode 100644 include/net/meta.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8985a1b0b5ee..ec3edd4caa56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3774,6 +3774,15 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/lib/bpf/
 
+BPF [META]
+M:	Daniel Borkmann <daniel@iogearbox.net>
+M:	Nikolay Aleksandrov <razor@blackwall.org>
+L:	bpf@vger.kernel.org
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/meta.c
+F:	include/net/meta.h
+
 BPF [MISC]
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 44eeb5d61ba9..9959cdd50b0b 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -448,6 +448,15 @@ config NLMON
 	  diagnostics, etc. This is mostly intended for developers or support
 	  to debug netlink issues. If unsure, say N.
 
+config META
+	bool "BPF-programmable meta device"
+	depends on BPF_SYSCALL
+	help
+	  The virtual meta devices can be created in pairs and used to connect
+	  two network namespaces. A BPF program can be attached to the device(s)
+	  which then gets executed on transmission to implement the driver
+	  internal logic.
+
 config NET_VRF
 	tristate "Virtual Routing and Forwarding (Lite)"
 	depends on IP_MULTIPLE_TABLES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index e26f98f897c5..18eabeb78ece 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO) += mdio.o
 obj-$(CONFIG_NET) += loopback.o
 obj-$(CONFIG_NETDEV_LEGACY_INIT) += Space.o
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_META) += meta.o
 obj-y += phy/
 obj-y += pse-pd/
 obj-y += mdio/
diff --git a/drivers/net/meta.c b/drivers/net/meta.c
new file mode 100644
index 000000000000..e464f547b0a6
--- /dev/null
+++ b/drivers/net/meta.c
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Isovalent */
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/etherdevice.h>
+#include <linux/filter.h>
+#include <linux/netfilter_netdev.h>
+#include <linux/bpf_mprog.h>
+
+#include <net/meta.h>
+#include <net/dst.h>
+#include <net/tcx.h>
+
+#define DRV_NAME	"meta"
+#define DRV_VERSION	"1.0"
+
+struct meta {
+	/* Needed in fast-path */
+	struct net_device __rcu *peer;
+	struct bpf_mprog_entry __rcu *active;
+	enum meta_action policy;
+	struct bpf_mprog_bundle	bundle;
+	/* Needed in slow-path */
+	enum meta_mode mode;
+	bool primary;
+	u32 headroom;
+};
+
+static void meta_scrub_minimum(struct sk_buff *skb)
+{
+	skb->skb_iif = 0;
+	skb->ignore_df = 0;
+	skb->priority = 0;
+	skb_dst_drop(skb);
+	skb_ext_reset(skb);
+	nf_reset_ct(skb);
+	nf_reset_trace(skb);
+	nf_skip_egress(skb, true);
+	ipvs_reset(skb);
+}
+
+static __always_inline int
+meta_run(const struct meta *meta, const struct bpf_mprog_entry *entry,
+	 struct sk_buff *skb, enum meta_action ret)
+{
+	const struct bpf_mprog_fp *fp;
+	const struct bpf_prog *prog;
+
+	bpf_mprog_foreach_prog(entry, fp, prog) {
+		bpf_compute_data_pointers(skb);
+		ret = bpf_prog_run(prog, skb);
+		if (ret != META_NEXT)
+			break;
+	}
+	return ret;
+}
+
+static netdev_tx_t meta_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	enum meta_action ret = READ_ONCE(meta->policy);
+	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
+	const struct bpf_mprog_entry *entry;
+	struct net_device *peer;
+
+	rcu_read_lock();
+	peer = rcu_dereference(meta->peer);
+	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
+		     !pskb_may_pull(skb, ETH_HLEN) ||
+		     skb_orphan_frags(skb, GFP_ATOMIC)))
+		goto drop;
+	meta_scrub_minimum(skb);
+	skb->dev = peer;
+	entry = rcu_dereference(meta->active);
+	if (entry)
+		ret = meta_run(meta, entry, skb, ret);
+	switch (ret) {
+	case META_NEXT:
+	case META_PASS:
+		skb->pkt_type = PACKET_HOST;
+		skb->protocol = eth_type_trans(skb, skb->dev);
+		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
+		__netif_rx(skb);
+		break;
+	case META_REDIRECT:
+		skb_do_redirect(skb);
+		break;
+	case META_DROP:
+	default:
+drop:
+		ret_dev = NET_XMIT_DROP;
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb(skb);
+		break;
+	}
+	rcu_read_unlock();
+	return ret_dev;
+}
+
+static int meta_open(struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+
+	if (!peer)
+		return -ENOTCONN;
+	if (peer->flags & IFF_UP) {
+		netif_carrier_on(dev);
+		netif_carrier_on(peer);
+	}
+	return 0;
+}
+
+static int meta_close(struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+
+	netif_carrier_off(dev);
+	if (peer)
+		netif_carrier_off(peer);
+	return 0;
+}
+
+static int meta_get_iflink(const struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer;
+	int iflink = 0;
+
+	rcu_read_lock();
+	peer = rcu_dereference(meta->peer);
+	if (peer)
+		iflink = peer->ifindex;
+	rcu_read_unlock();
+	return iflink;
+}
+
+static void meta_set_multicast_list(struct net_device *dev)
+{
+}
+
+static void meta_set_headroom(struct net_device *dev, int headroom)
+{
+	struct meta *meta = netdev_priv(dev), *meta2;
+	struct net_device *peer;
+
+	if (headroom < 0)
+		headroom = NET_SKB_PAD;
+
+	rcu_read_lock();
+	peer = rcu_dereference(meta->peer);
+	if (unlikely(!peer))
+		goto out;
+
+	meta2 = netdev_priv(peer);
+	meta->headroom = headroom;
+	headroom = max(meta->headroom, meta2->headroom);
+
+	peer->needed_headroom = headroom;
+	dev->needed_headroom = headroom;
+out:
+	rcu_read_unlock();
+}
+
+static struct net_device *meta_peer_dev(struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+
+	return rcu_dereference(meta->peer);
+}
+
+static struct net_device *meta_peer_dev_rtnl(struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+
+	return rcu_dereference_rtnl(meta->peer);
+}
+
+static const struct net_device_ops meta_netdev_ops = {
+	.ndo_open		= meta_open,
+	.ndo_stop		= meta_close,
+	.ndo_start_xmit		= meta_xmit,
+	.ndo_set_rx_mode	= meta_set_multicast_list,
+	.ndo_set_rx_headroom	= meta_set_headroom,
+	.ndo_get_iflink		= meta_get_iflink,
+	.ndo_get_peer_dev	= meta_peer_dev,
+	.ndo_features_check	= passthru_features_check,
+};
+
+static void meta_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
+}
+
+static const struct ethtool_ops meta_ethtool_ops = {
+	.get_drvinfo		= meta_get_drvinfo,
+};
+
+static void meta_setup(struct net_device *dev)
+{
+	static const netdev_features_t meta_features_hw_vlan =
+		NETIF_F_HW_VLAN_CTAG_TX |
+		NETIF_F_HW_VLAN_CTAG_RX |
+		NETIF_F_HW_VLAN_STAG_TX |
+		NETIF_F_HW_VLAN_STAG_RX;
+	static const netdev_features_t meta_features =
+		meta_features_hw_vlan |
+		NETIF_F_SG |
+		NETIF_F_FRAGLIST |
+		NETIF_F_HW_CSUM |
+		NETIF_F_RXCSUM |
+		NETIF_F_SCTP_CRC |
+		NETIF_F_HIGHDMA |
+		NETIF_F_GSO_SOFTWARE |
+		NETIF_F_GSO_ENCAP_ALL;
+
+	ether_setup(dev);
+	dev->min_mtu = ETH_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
+
+	dev->flags |= IFF_NOARP;
+	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->priv_flags |= IFF_PHONY_HEADROOM;
+	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_META;
+
+	dev->ethtool_ops = &meta_ethtool_ops;
+	dev->netdev_ops  = &meta_netdev_ops;
+
+	dev->features |= meta_features | NETIF_F_LLTX;
+	dev->hw_features = meta_features;
+	dev->hw_enc_features = meta_features;
+	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
+	dev->vlan_features = dev->features & ~meta_features_hw_vlan;
+
+	dev->needs_free_netdev = true;
+
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+}
+
+static struct net *meta_get_link_net(const struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+
+	return peer ? dev_net(peer) : dev_net(dev);
+}
+
+static int meta_check_policy(int policy, struct nlattr *tb,
+			     struct netlink_ext_ack *extack)
+{
+	switch (policy) {
+	case META_PASS:
+	case META_DROP:
+		return 0;
+	default:
+		NL_SET_ERR_MSG_ATTR(extack, tb,
+				    "Provided default xmit policy not supported");
+		return -EINVAL;
+	}
+}
+
+static int meta_check_mode(int mode, struct nlattr *tb,
+			   struct netlink_ext_ack *extack)
+{
+	switch (mode) {
+	case META_L2:
+	case META_L3:
+		return 0;
+	default:
+		NL_SET_ERR_MSG_ATTR(extack, tb,
+				    "Provided device mode can only be L2 or L3");
+		return -EINVAL;
+	}
+}
+
+static int meta_validate(struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	struct nlattr *attr = tb[IFLA_ADDRESS];
+
+	if (!attr)
+		return 0;
+	NL_SET_ERR_MSG_ATTR(extack, attr,
+			    "Setting Ethernet address is not supported");
+	return -EOPNOTSUPP;
+}
+
+static struct rtnl_link_ops meta_link_ops;
+
+static int meta_new_link(struct net *src_net, struct net_device *dev,
+			 struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
+	enum meta_action default_prim = META_PASS;
+	enum meta_action default_peer = META_PASS;
+	unsigned char name_assign_type;
+	enum meta_mode mode = META_L3;
+	struct ifinfomsg *ifmp = NULL;
+	struct net_device *peer;
+	char ifname[IFNAMSIZ];
+	struct meta *meta;
+	struct net *net;
+	int err;
+
+	if (data) {
+		if (data[IFLA_META_MODE]) {
+			attr = data[IFLA_META_MODE];
+			mode = nla_get_u32(attr);
+			err = meta_check_mode(mode, attr, extack);
+			if (err < 0)
+				return err;
+		}
+		if (data[IFLA_META_PEER_INFO]) {
+			attr = data[IFLA_META_PEER_INFO];
+			ifmp = nla_data(attr);
+			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
+			if (err < 0)
+				return err;
+			err = meta_validate(peer_tb, NULL, extack);
+			if (err < 0)
+				return err;
+			tbp = peer_tb;
+		}
+		if (data[IFLA_META_POLICY]) {
+			attr = data[IFLA_META_POLICY];
+			default_prim = nla_get_u32(attr);
+			err = meta_check_policy(default_prim, attr, extack);
+			if (err < 0)
+				return err;
+		}
+		if (data[IFLA_META_PEER_POLICY]) {
+			attr = data[IFLA_META_PEER_POLICY];
+			default_peer = nla_get_u32(attr);
+			err = meta_check_policy(default_peer, attr, extack);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	if (ifmp && tbp[IFLA_IFNAME]) {
+		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
+		name_assign_type = NET_NAME_USER;
+	} else {
+		snprintf(ifname, IFNAMSIZ, "m%%d");
+		name_assign_type = NET_NAME_ENUM;
+	}
+
+	net = rtnl_link_get_net(src_net, tbp);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
+	peer = rtnl_create_link(net, ifname, name_assign_type,
+				&meta_link_ops, tbp, extack);
+	if (IS_ERR(peer)) {
+		put_net(net);
+		return PTR_ERR(peer);
+	}
+
+	if (mode == META_L2)
+		eth_hw_addr_random(peer);
+	if (ifmp && dev->ifindex)
+		peer->ifindex = ifmp->ifi_index;
+
+	netif_inherit_tso_max(peer, dev);
+
+	err = register_netdevice(peer);
+	put_net(net);
+	if (err < 0)
+		goto err_register_peer;
+
+	netif_carrier_off(peer);
+
+	err = rtnl_configure_link(peer, ifmp, 0, NULL);
+	if (err < 0)
+		goto err_configure_peer;
+
+	if (mode == META_L2)
+		eth_hw_addr_random(dev);
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
+	else
+		snprintf(dev->name, IFNAMSIZ, "m%%d");
+
+	err = register_netdevice(dev);
+	if (err < 0)
+		goto err_configure_peer;
+
+	netif_carrier_off(dev);
+
+	meta = netdev_priv(dev);
+	meta->primary = true;
+	meta->policy = default_prim;
+	meta->mode = mode;
+	if (meta->mode == META_L2)
+		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
+	bpf_mprog_bundle_init(&meta->bundle);
+	RCU_INIT_POINTER(meta->active, NULL);
+	rcu_assign_pointer(meta->peer, peer);
+
+	meta = netdev_priv(peer);
+	meta->primary = false;
+	meta->policy = default_peer;
+	meta->mode = mode;
+	if (meta->mode == META_L2)
+		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
+	bpf_mprog_bundle_init(&meta->bundle);
+	RCU_INIT_POINTER(meta->active, NULL);
+	rcu_assign_pointer(meta->peer, dev);
+	return 0;
+err_configure_peer:
+	unregister_netdevice(peer);
+	return err;
+err_register_peer:
+	free_netdev(peer);
+	return err;
+}
+
+static struct bpf_mprog_entry *meta_entry_fetch(struct net_device *dev,
+						bool bundle_fallback)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct bpf_mprog_entry *entry;
+
+	ASSERT_RTNL();
+	entry = rcu_dereference_rtnl(meta->active);
+	if (entry)
+		return entry;
+	if (bundle_fallback)
+		return &meta->bundle.a;
+	return NULL;
+}
+
+static void meta_entry_update(struct net_device *dev, struct bpf_mprog_entry *entry)
+{
+	struct meta *meta = netdev_priv(dev);
+
+	ASSERT_RTNL();
+	rcu_assign_pointer(meta->active, entry);
+}
+
+static void meta_entry_sync(void)
+{
+	synchronize_rcu();
+}
+
+static struct net_device *meta_dev_fetch(struct net *net, u32 ifindex, u32 which)
+{
+	struct net_device *dev;
+	struct meta *meta;
+
+	ASSERT_RTNL();
+
+	switch (which) {
+	case BPF_META_PRIMARY:
+	case BPF_META_PEER:
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	dev = __dev_get_by_index(net, ifindex);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+	if (!(dev->priv_flags & IFF_META))
+		return ERR_PTR(-ENXIO);
+
+	meta = netdev_priv(dev);
+	if (!meta->primary)
+		return ERR_PTR(-EACCES);
+	if (which == BPF_META_PRIMARY)
+		return dev;
+	return meta_peer_dev_rtnl(dev);
+}
+
+int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct bpf_prog *replace_prog = NULL;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = meta_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
+			     attr->attach_type);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+	entry = meta_entry_fetch(dev, true);
+	if (attr->attach_flags & BPF_F_REPLACE) {
+		replace_prog = bpf_prog_get_type(attr->replace_bpf_fd,
+						 prog->type);
+		if (IS_ERR(replace_prog)) {
+			ret = PTR_ERR(replace_prog);
+			replace_prog = NULL;
+			goto out;
+		}
+	}
+	ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
+			       attr->attach_flags, attr->relative_fd,
+			       attr->expected_revision);
+	if (!ret) {
+		if (entry != entry_new) {
+			meta_entry_update(dev, entry_new);
+			meta_entry_sync();
+		}
+		bpf_mprog_commit(entry);
+	}
+out:
+	if (replace_prog)
+		bpf_prog_put(replace_prog);
+	rtnl_unlock();
+	return ret;
+}
+
+int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_mprog_entry *entry, *entry_new;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = meta_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
+			     attr->attach_type);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+	entry = meta_entry_fetch(dev, false);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_flags,
+			       attr->relative_fd, attr->expected_revision);
+	if (!ret) {
+		if (!bpf_mprog_total(entry_new))
+			entry_new = NULL;
+		meta_entry_update(dev, entry_new);
+		meta_entry_sync();
+		bpf_mprog_commit(entry);
+	}
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
+{
+	struct bpf_mprog_entry *entry;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = meta_dev_fetch(current->nsproxy->net_ns, attr->query.target_ifindex,
+			     attr->query.attach_type);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+	entry = meta_entry_fetch(dev, false);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_query(attr, uattr, entry);
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+static void meta_release_all(struct net_device *dev)
+{
+	struct bpf_mprog_entry *entry;
+	struct bpf_tuple tuple = {};
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+
+	entry = meta_entry_fetch(dev, false);
+	if (!entry)
+		return;
+	meta_entry_update(dev, NULL);
+	meta_entry_sync();
+	bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
+		bpf_prog_put(tuple.prog);
+	}
+}
+
+static void meta_del_link(struct net_device *dev, struct list_head *head)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+
+	RCU_INIT_POINTER(meta->peer, NULL);
+	meta_release_all(dev);
+	unregister_netdevice_queue(dev, head);
+	if (peer) {
+		meta = netdev_priv(peer);
+		RCU_INIT_POINTER(meta->peer, NULL);
+		meta_release_all(peer);
+		unregister_netdevice_queue(peer, head);
+	}
+}
+
+static int meta_change_link(struct net_device *dev, struct nlattr *tb[],
+			    struct nlattr *data[],
+			    struct netlink_ext_ack *extack)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+	enum meta_action policy;
+	struct nlattr *attr;
+	int err;
+
+	if (!meta->primary) {
+		NL_SET_ERR_MSG(extack,
+			       "Meta settings can be changed only through the primary device");
+		return -EACCES;
+	}
+
+	if (data[IFLA_META_MODE]) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_META_MODE],
+				    "Meta operating mode cannot be changed after device creation");
+		return -EACCES;
+	}
+
+	if (data[IFLA_META_POLICY]) {
+		attr = data[IFLA_META_POLICY];
+		policy = nla_get_u32(attr);
+		err = meta_check_policy(policy, attr, extack);
+		if (err)
+			return err;
+		WRITE_ONCE(meta->policy, policy);
+	}
+
+	if (data[IFLA_META_PEER_POLICY]) {
+		err = -EOPNOTSUPP;
+		attr = data[IFLA_META_PEER_POLICY];
+		policy = nla_get_u32(attr);
+		if (peer)
+			err = meta_check_policy(policy, attr, extack);
+		if (err)
+			return err;
+		meta = netdev_priv(peer);
+		WRITE_ONCE(meta->policy, policy);
+	}
+
+	return 0;
+}
+
+static size_t meta_get_size(const struct net_device *dev)
+{
+	return nla_total_size(sizeof(u32)) + /* IFLA_META_POLICY */
+	       nla_total_size(sizeof(u32)) + /* IFLA_META_PEER_POLICY */
+	       nla_total_size(sizeof(u8))  + /* IFLA_META_PRIMARY */
+	       nla_total_size(sizeof(u32)) + /* IFLA_META_MODE */
+	       0;
+}
+
+static int meta_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct meta *meta = netdev_priv(dev);
+	struct net_device *peer = rtnl_dereference(meta->peer);
+
+	if (nla_put_u8(skb, IFLA_META_PRIMARY, meta->primary))
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, IFLA_META_POLICY, meta->policy))
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, IFLA_META_MODE, meta->mode))
+		return -EMSGSIZE;
+
+	if (peer) {
+		meta = netdev_priv(peer);
+		if (nla_put_u32(skb, IFLA_META_PEER_POLICY, meta->policy))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+static const struct nla_policy meta_policy[IFLA_META_MAX + 1] = {
+	[IFLA_META_PEER_INFO]	= { .len = sizeof(struct ifinfomsg) },
+	[IFLA_META_POLICY]	= { .type = NLA_U32 },
+	[IFLA_META_MODE]	= { .type = NLA_U32 },
+	[IFLA_META_PEER_POLICY]	= { .type = NLA_U32 },
+	[IFLA_META_PRIMARY]	= { .type = NLA_REJECT,
+				    .reject_message = "Primary attribute is read-only" },
+};
+
+static struct rtnl_link_ops meta_link_ops = {
+	.kind		= DRV_NAME,
+	.priv_size	= sizeof(struct meta),
+	.setup		= meta_setup,
+	.newlink	= meta_new_link,
+	.dellink	= meta_del_link,
+	.changelink	= meta_change_link,
+	.get_link_net	= meta_get_link_net,
+	.get_size	= meta_get_size,
+	.fill_info	= meta_fill_info,
+	.policy		= meta_policy,
+	.validate	= meta_validate,
+	.maxtype	= IFLA_META_MAX,
+};
+
+static __init int meta_init(void)
+{
+	BUILD_BUG_ON((int)META_NEXT != (int)TCX_NEXT ||
+		     (int)META_PASS != (int)TCX_PASS ||
+		     (int)META_DROP != (int)TCX_DROP ||
+		     (int)META_REDIRECT != (int)TCX_REDIRECT);
+
+	return rtnl_link_register(&meta_link_ops);
+}
+
+static __exit void meta_exit(void)
+{
+	rtnl_link_unregister(&meta_link_ops);
+}
+
+module_init(meta_init);
+module_exit(meta_exit);
+
+MODULE_DESCRIPTION("BPF-programmable meta device");
+MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
+MODULE_AUTHOR("Nikolay Aleksandrov <razor@blackwall.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_RTNL_LINK(DRV_NAME);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c..af0f23ed8d51 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1701,6 +1701,7 @@ struct net_device_ops {
  * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
  *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
+ * @IFF_META: device is a meta device
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1737,6 +1738,7 @@ enum netdev_priv_flags {
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
+	IFF_META			= BIT_ULL(34),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
diff --git a/include/net/meta.h b/include/net/meta.h
new file mode 100644
index 000000000000..20fc61d05970
--- /dev/null
+++ b/include/net/meta.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Isovalent */
+#ifndef __NET_META_H
+#define __NET_META_H
+
+#include <linux/bpf.h>
+
+#ifdef CONFIG_META
+int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
+int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
+#else
+static inline int meta_prog_attach(const union bpf_attr *attr,
+				   struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int meta_prog_detach(const union bpf_attr *attr,
+				   struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int meta_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_META */
+#endif /* __NET_META_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5f13db15a3c7..00a875720e84 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1047,6 +1047,8 @@ enum bpf_attach_type {
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
 	BPF_TRACE_UPROBE_MULTI,
+	BPF_META_PRIMARY,
+	BPF_META_PEER,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fac351a93aed..ec099c6c51e0 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -756,6 +756,31 @@ struct tunnel_msg {
 	__u32 ifindex;
 };
 
+/* META section */
+enum meta_action {
+	META_NEXT	= -1,
+	META_PASS	= 0,
+	META_DROP	= 2,
+	META_REDIRECT	= 7,
+};
+
+enum meta_mode {
+	META_L2,
+	META_L3,
+};
+
+enum {
+	IFLA_META_UNSPEC,
+	IFLA_META_PEER_INFO,
+	IFLA_META_PRIMARY,
+	IFLA_META_POLICY,
+	IFLA_META_PEER_POLICY,
+	IFLA_META_MODE,
+	__IFLA_META_MAX,
+};
+
+#define IFLA_META_MAX	(__IFLA_META_MAX - 1)
+
 /* VXLAN section */
 
 /* include statistics in the dump */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85c1d908f70f..51baf4355c39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,8 +35,9 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
-#include <net/netfilter/nf_bpf_link.h>
 
+#include <net/netfilter/nf_bpf_link.h>
+#include <net/meta.h>
 #include <net/tcx.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -3720,6 +3721,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_LSM;
 	case BPF_TCX_INGRESS:
 	case BPF_TCX_EGRESS:
+	case BPF_META_PRIMARY:
+	case BPF_META_PEER:
 		return BPF_PROG_TYPE_SCHED_CLS;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
@@ -3771,7 +3774,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		return 0;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attach_type != BPF_TCX_INGRESS &&
-		    attach_type != BPF_TCX_EGRESS)
+		    attach_type != BPF_TCX_EGRESS &&
+		    attach_type != BPF_META_PRIMARY &&
+		    attach_type != BPF_META_PEER)
 			return -EINVAL;
 		return 0;
 	default:
@@ -3849,7 +3854,11 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 			ret = cgroup_bpf_prog_attach(attr, ptype, prog);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
-		ret = tcx_prog_attach(attr, prog);
+		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
+		    attr->link_create.attach_type == BPF_TCX_EGRESS)
+			ret = tcx_prog_attach(attr, prog);
+		else
+			ret = meta_prog_attach(attr, prog);
 		break;
 	default:
 		ret = -EINVAL;
@@ -3906,7 +3915,11 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 		ret = cgroup_bpf_prog_detach(attr, ptype);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
-		ret = tcx_prog_detach(attr, prog);
+		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
+		    attr->link_create.attach_type == BPF_TCX_EGRESS)
+			ret = tcx_prog_detach(attr, prog);
+		else
+			ret = meta_prog_detach(attr, prog);
 		break;
 	default:
 		ret = -EINVAL;
@@ -3968,6 +3981,9 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_TCX_INGRESS:
 	case BPF_TCX_EGRESS:
 		return tcx_prog_query(attr, uattr);
+	case BPF_META_PRIMARY:
+	case BPF_META_PEER:
+		return meta_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
@@ -4949,7 +4965,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
-		ret = tcx_link_attach(attr, prog);
+		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
+		    attr->link_create.attach_type == BPF_TCX_EGRESS)
+			ret = tcx_link_attach(attr, prog);
+		else
+			ret = -EINVAL;
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		ret = bpf_nf_link_attach(attr, prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5f13db15a3c7..00a875720e84 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1047,6 +1047,8 @@ enum bpf_attach_type {
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
 	BPF_TRACE_UPROBE_MULTI,
+	BPF_META_PRIMARY,
+	BPF_META_PEER,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.34.1


