Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F73DE3C0
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhHCBD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:03:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhHCBD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:03:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327834"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480106"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [[RFC xdp-hints] 02/16] net/core: XDP metadata BTF netlink API
Date:   Mon,  2 Aug 2021 18:03:17 -0700
Message-Id: <20210803010331.39453-3-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

Add new devlink XDP attributes to be used to query or setup XDP metadata
BTF state.

IFLA_XDP_MD_BTF_ID: type NLA_U32.
IFLA_XDP_MD_BTF_STATE: type = NLA_U8.

On XDP query driver reports current loaded BTF ID, and its state if
active or not.

On XDP setup, driver will use these attributes to activate/deactivate
a specific BTF ID.

Issue: 2114293
Change-Id: I14d57cc104231f970c5ce709c0b21f7ff1711ff1
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 include/linux/netdevice.h    | 15 +++++++++-
 include/uapi/linux/if_link.h |  2 ++
 net/core/dev.c               | 54 ++++++++++++++++++++++++++++++++++++
 net/core/rtnetlink.c         | 18 +++++++++++-
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c871dc223dfa..79a794711cd6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -938,6 +938,9 @@ enum bpf_netdev_command {
 	 */
 	XDP_SETUP_PROG,
 	XDP_SETUP_PROG_HW,
+	/* Setup/query XDP Meta Data BTF */
+	XDP_SETUP_MD_BTF,
+	XDP_QUERY_MD_BTF,
 	/* BPF program for offload callbacks, invoked at program load time. */
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
@@ -948,6 +951,7 @@ struct bpf_prog_offload_ops;
 struct netlink_ext_ack;
 struct xdp_umem;
 struct xdp_dev_bulk_queue;
+struct btf;
 struct bpf_xdp_link;
 
 enum bpf_xdp_mode {
@@ -969,7 +973,11 @@ struct netdev_bpf {
 		struct {
 			u32 flags;
 			struct bpf_prog *prog;
-			struct netlink_ext_ack *extack;
+		};
+		/* XDP_{SETUP/QUERY}_MD_BTF */
+		struct {
+			u8 btf_enable; /* only enable/disable for now */
+			u32 btf_id;
 		};
 		/* BPF_OFFLOAD_MAP_ALLOC, BPF_OFFLOAD_MAP_FREE */
 		struct {
@@ -981,6 +989,7 @@ struct netdev_bpf {
 			u16 queue_id;
 		} xsk;
 	};
+	struct netlink_ext_ack *extack;
 };
 
 /* Flags for ndo_xsk_wakeup. */
@@ -4067,6 +4076,10 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
+int dev_xdp_setup_md_btf(struct net_device *dev, struct netlink_ext_ack *extack,
+			 u8 enable);
+u32 dev_xdp_query_md_btf(struct net_device *dev, u8 *enabled);
+
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 4882e81514b6..6879a33b63ed 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1204,6 +1204,8 @@ enum {
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
 	IFLA_XDP_EXPECTED_FD,
+	IFLA_XDP_MD_BTF_ID,
+	IFLA_XDP_MD_BTF_STATE,
 	__IFLA_XDP_MAX,
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index fb5d12a3d52d..792bc356582b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9462,6 +9462,60 @@ static void dev_xdp_uninstall(struct net_device *dev)
 	}
 }
 
+
+/**
+ *	dev_xdp_query_md_btf - Query meta data btf of a device
+ *	@dev: device
+ *	@enabled: 1 if enabled, 0 otherwise
+ *
+ *	Returns btf id > 0 if valid
+ */
+u32 dev_xdp_query_md_btf(struct net_device *dev, u8 *enabled)
+{
+	struct netdev_bpf xdp;
+	bpf_op_t ndo_bpf;
+
+	ndo_bpf = dev->netdev_ops->ndo_bpf;
+	if (!ndo_bpf)
+		return 0;
+
+	memset(&xdp, 0, sizeof(xdp));
+	xdp.command = XDP_QUERY_MD_BTF;
+
+	if (ndo_bpf(dev, &xdp))
+		return 0; /* 0 is an invalid btf id */
+
+	*enabled = xdp.btf_enable;
+	return xdp.btf_id;
+}
+
+/**
+ *	dev_xdp_setup_md_btf - enable or disable meta data btf for a device
+ *	@dev: device
+ *	@extack: netlink extended ack
+ *	@enable: 1 to enable, 0 to disable
+ *
+ *	Returns 0 on success
+ */
+int dev_xdp_setup_md_btf(struct net_device *dev, struct netlink_ext_ack *extack,
+			 u8 enable)
+{
+	struct netdev_bpf xdp;
+	bpf_op_t ndo_bpf;
+
+	ndo_bpf = dev->netdev_ops->ndo_bpf;
+	if (!ndo_bpf)
+		return -EOPNOTSUPP;
+
+	memset(&xdp, 0, sizeof(xdp));
+
+	xdp.command = XDP_SETUP_MD_BTF;
+	xdp.btf_enable = enable;
+	xdp.extack = extack;
+
+	return ndo_bpf(dev, &xdp);
+}
+
 static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack,
 			  struct bpf_xdp_link *link, struct bpf_prog *new_prog,
 			  struct bpf_prog *old_prog, u32 flags)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e79aaf1f7139..961cd7e98054 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1453,8 +1453,9 @@ static int rtnl_xdp_report_one(struct sk_buff *skb, struct net_device *dev,
 
 static int rtnl_xdp_fill(struct sk_buff *skb, struct net_device *dev)
 {
+	u32 prog_id, md_btf_id;
+	u8 md_btf_enabled = 0;
 	struct nlattr *xdp;
-	u32 prog_id;
 	int err;
 	u8 mode;
 
@@ -1487,6 +1488,10 @@ static int rtnl_xdp_fill(struct sk_buff *skb, struct net_device *dev)
 			goto err_cancel;
 	}
 
+	md_btf_id = dev_xdp_query_md_btf(dev, &md_btf_enabled);
+	nla_put_u32(skb, IFLA_XDP_MD_BTF_ID, md_btf_id);
+	nla_put_u8(skb, IFLA_XDP_MD_BTF_STATE, md_btf_enabled);
+
 	nla_nest_end(skb, xdp);
 	return 0;
 
@@ -1931,6 +1936,8 @@ static const struct nla_policy ifla_xdp_policy[IFLA_XDP_MAX + 1] = {
 	[IFLA_XDP_ATTACHED]	= { .type = NLA_U8 },
 	[IFLA_XDP_FLAGS]	= { .type = NLA_U32 },
 	[IFLA_XDP_PROG_ID]	= { .type = NLA_U32 },
+	[IFLA_XDP_MD_BTF_ID]	= { .type = NLA_U32 },
+	[IFLA_XDP_MD_BTF_STATE] = { .type = NLA_U8 },
 };
 
 static const struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla)
@@ -2927,6 +2934,15 @@ static int do_setlink(const struct sk_buff *skb,
 				goto errout;
 			status |= DO_SETLINK_NOTIFY;
 		}
+
+		if (xdp[IFLA_XDP_MD_BTF_STATE]) {
+			u8 enable = nla_get_u8(xdp[IFLA_XDP_MD_BTF_STATE]);
+
+			err = dev_xdp_setup_md_btf(dev, extack, enable);
+			if (err)
+				goto errout;
+			status |= DO_SETLINK_NOTIFY;
+		}
 	}
 
 errout:
-- 
2.32.0

