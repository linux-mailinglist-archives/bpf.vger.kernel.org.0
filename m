Return-Path: <bpf+bounces-44732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA659C705F
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 14:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621BEB29EAF
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7F204F7D;
	Wed, 13 Nov 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLbdAbc6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64E7081B;
	Wed, 13 Nov 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502694; cv=none; b=JBDdsZd7n9bqSX/CYk6Vnk4tUB85O6cumi0NGrSrPetGR74itcy3RiytBn5ULcP8Gt5AecxSJ2e+uKWmikNfEfwTCk6MYUv/Ghhu+Vkt+DXsx6KSgngxdi/TAZPhPyabUOcc4vC5CPne8OtplQULSrBmgU/oFlidFfG+MaLHLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502694; c=relaxed/simple;
	bh=ZACd5nIdMRAVNhoo2/mRaqP5u0O2tzAVJR0CQFWno+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1JoKPdOVTN1Y8LKjymKTd14maQTi3Z7gWJBkiIM/XjDENdDpWdyVzdYVCdHMj5rEiievSDQIO3+1ysfBQRr5+DWEbrw+oosIFm6bqm6/1xziPSy9xwbuRMDezKTbrbtL/GywAO0DU5TloA8aORBkjy2dcYvTpqjiPy4WGScS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLbdAbc6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so4984291a12.1;
        Wed, 13 Nov 2024 04:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502691; x=1732107491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4uHKNgHTelYlny2krcQ638zz7tT9VKe4QfYY382d0Q=;
        b=dLbdAbc6Z2L6joEQA9Qm/ObDYZmEwGkmLeisYiQk6clXrn6/bY19cADcVSVfoa1PEL
         xogXgXjYFH8P2aP7S6UIyJN3Aw64PotGDYMPbPTlXQDQRGMRDE0LDW+xdHIJHKX9o3pO
         JYHGmzf1z0yfWQ7ndUaT3SKeL5p8n48m0N5GFTWw0nFo1kBYxIUSBjQwIb8AYfFchlkH
         scTk65+qsfgNw8F4NvwEbxdiEdi2amqdEzlJFD/j75RdQBfZjLKzP1T1LFTCmBEZgXKH
         buSt5XjlpE66RDanzvurPmrPs+mSuw5Xtp3o6d1TrlQrkEB0UqToTlXYHAddhFdnNTBn
         VTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502691; x=1732107491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4uHKNgHTelYlny2krcQ638zz7tT9VKe4QfYY382d0Q=;
        b=PMeYVq91WR+Y1QIIqjomrMbk8mQzeKNHUVVzTv5FC6jAFXbQi+wq1JK9jL+L3KNzte
         cOV9RV9/ugus3Kf38WZ5Wtlcef8kQVFncfGTnAhhG39T4Hv2ul9bu7tcg2AXZ87c3147
         IEBNTBh/l9gfemJCiNs4f6elbfgUvU3j2oFWThvJ+jGtrHOJMzdWk4oQNVh7Len+rdVR
         LFfiAZpxDSf0znWYF84DiT/L3hToayho2QSrQcThh83XD424X9kXiake/bz7n4CxwqvM
         lMP5sxSUJjMp6ZlUfx8DMAWZ0eH/93Bx2+QaY1FEwrKkaFn1I7BX45GWws0EJlFHkQvt
         rcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMBbMJlmExVgcH4S7QYldEwdA8O33qFL9jMCOKbG+2/oyd+EoGgcjvbL8bIx8CjAWCrTjgxUrAZH8+@vger.kernel.org, AJvYcCUVyAhWmn7EZ6a3BZkDLM5OcRgJMBFlsV9lVjLIkUbiT7HKRK03Mq50fmYxL3anWgzuRbUURR8BgQFx9Q==@vger.kernel.org, AJvYcCVEbzM9Bhm0fkhnZSApasHfScA+UvOE9IaE6DdVyC5bzPP+fNUgBDmQnj4TR4AEvKMfFpI=@vger.kernel.org, AJvYcCVfqnFD6TuXYfB0ErXAtWVtMYwpEHF30a7FIT1m6MSt2Q8oEZTQxxt8xyr/fxvKPi4UYUYqlBqyvGS4@vger.kernel.org, AJvYcCVhF3fpOaE2Gqb5/Qiqxx0nGnimf9R+41JC6XUxvE/PpML3uf3rtSBb+T3tBHC64+FrGzvo/Wgj2pL3dSRD8f0=@vger.kernel.org, AJvYcCXa2bHI61p8KmrA1CG8ehmM8CJSYU9hZNc9cEWq92OaeKDRcoKqOPyiWibA5ihHQELmCAMPDP7048EKGd8voTUa@vger.kernel.org, AJvYcCXadaxd4d9JPbXg/K62fBWo3yvpJnZp5pOQsBNmleuH2x8MzgqM5zDIasKjHlWEzeWwrgR54tJBrLZeAg==@vger.kernel.org, AJvYcCXgXOAvIZRUkirxfSNkzMpXJH9ic4PnwxPSRbYvAjrEeTOTkqQ4qI3RmTabLJ6xuvfTRWx+TY8Zl/Jq7kgn@vger.kernel.org
X-Gm-Message-State: AOJu0YyJm6QaR12JRI23IjfdxDCutYbC2AMyrb2fAOLfRX4U7p0TBIOb
	oOVS9xVKBEUeTKuEY9zqjblxhQPQeImhlOQjHkfiPPyc6yvS9tH67gN4ui885rk=
X-Google-Smtp-Source: AGHT+IEW/8FLBI4yQo5ibxoGCxIofggmcjjVftErLiAf+Ryg0MG2XED6WhS+2Fn2LgKf4ZhExPXwEQ==
X-Received: by 2002:a05:6a20:244d:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1dc7037f641mr3401109637.13.1731502690293;
        Wed, 13 Nov 2024 04:58:10 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:09 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/6] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
Date: Wed, 13 Nov 2024 20:57:13 +0800
Message-ID: <20241113125715.150201-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three net namespaces involved when creating links:

 - source netns - where the netlink socket resides,
 - target netns - where to put the device being created,
 - link netns - netns associated with the device (backend).

Currently, two nets are passed to newlink() callback - "src_net"
parameter and "dev_net" (implicitly in net_device). They are set as
follows, depending on whether IFLA_LINK_NETNSID is present.

 +-------------------+---------+---------+
 | IFLA_LINK_NETNSID | src_net | dev_net |
 +-------------------+---------+---------+
 | absent            | source  | target  |
 +-------------------+---------+---------+
 | present           | link    | link    |
 +-------------------+---------+---------+

When IFLA_LINK_NETNSID is present, the device is created in link netns
first. This has some side effects, including extra ifindex allocation,
ifname validation and link notifications. There's also an extra step to
move the device to target netns. These could be avoided if we create it
in target netns at the beginning.

On the other hand, the meaning of src_net is ambiguous. It should be
the effective link netns by design, but some drivers ignore it and use
dev_net instead.

This patch refactors netns handling. rtnl_newlink_create() now creates
devices in target netns directly, so dev_net is always target netns.
Source and link netns are passed to newlink() as src_net and link_net in
a new struct consistently.

When determining the effective link netns, in the absence link_net,
drivers should look for src_net in general. But for compatibility,
drivers that use dev_net will keep current behavior.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---

There're some issues found when coverting drivers. Please check if they
work as intended:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net (src_net actually), but amt_lookup_upper_dev() only searches
  in dev_net.

- In gtp_newlink() in drivers/net/gtp.c:

    gtp->net = src_net;
    ...
    gn = net_generic(dev_net(dev), gtp_net_id);
    list_add_rcu(&gtp->list, &gn->gtp_dev_list);

  Uses src_net, but is linked to list in dev_net.

- In pfcp_newlink() in drivers/net/pfcp.c:

    pfcp->net = net;
    ...
    pn = net_generic(dev_net(dev), pfcp_net_id);
    list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);

  Same.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

---

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  6 +++--
 drivers/net/amt.c                             |  6 ++---
 drivers/net/bareudp.c                         |  4 ++--
 drivers/net/bonding/bond_netlink.c            |  3 ++-
 drivers/net/can/dev/netlink.c                 |  2 +-
 drivers/net/can/vxcan.c                       |  4 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  5 +++--
 drivers/net/geneve.c                          |  4 ++--
 drivers/net/gtp.c                             |  4 ++--
 drivers/net/ipvlan/ipvlan.h                   |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  5 +++--
 drivers/net/ipvlan/ipvtap.c                   |  4 ++--
 drivers/net/macsec.c                          |  5 +++--
 drivers/net/macvlan.c                         |  5 +++--
 drivers/net/macvtap.c                         |  5 +++--
 drivers/net/netkit.c                          |  4 ++--
 drivers/net/pfcp.c                            |  4 ++--
 drivers/net/ppp/ppp_generic.c                 |  4 ++--
 drivers/net/team/team_core.c                  |  2 +-
 drivers/net/veth.c                            |  4 ++--
 drivers/net/vrf.c                             |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 ++--
 drivers/net/wireguard/device.c                |  4 ++--
 drivers/net/wireless/virtual/virt_wifi.c      |  5 +++--
 drivers/net/wwan/wwan_core.c                  |  6 +++--
 include/net/ip_tunnels.h                      |  5 +++--
 include/net/rtnetlink.h                       | 22 ++++++++++++++++++-
 net/8021q/vlan_netlink.c                      |  5 +++--
 net/batman-adv/soft-interface.c               |  5 +++--
 net/bridge/br_netlink.c                       |  2 +-
 net/caif/chnl_net.c                           |  2 +-
 net/core/rtnetlink.c                          | 15 ++++++-------
 net/hsr/hsr_netlink.c                         |  8 +++----
 net/ieee802154/6lowpan/core.c                 |  5 +++--
 net/ipv4/ip_gre.c                             | 13 ++++++-----
 net/ipv4/ip_tunnel.c                          | 10 +++++----
 net/ipv4/ip_vti.c                             |  5 +++--
 net/ipv4/ipip.c                               |  5 +++--
 net/ipv6/ip6_gre.c                            | 17 +++++++-------
 net/ipv6/ip6_tunnel.c                         | 11 +++++-----
 net/ipv6/ip6_vti.c                            | 11 +++++-----
 net/ipv6/sit.c                                | 11 +++++-----
 net/xfrm/xfrm_interface_core.c                | 13 +++++------
 43 files changed, 153 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 9ad8d9856275..7714115a4635 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -97,7 +97,8 @@ static int ipoib_changelink(struct net_device *dev, struct nlattr *tb[],
 	return ret;
 }
 
-static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
+static int ipoib_new_child_link(struct rtnl_link_nets *nets,
+				struct net_device *dev,
 				struct nlattr *tb[], struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
@@ -109,7 +110,8 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	pdev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	pdev = __dev_get_by_index(rtnl_link_netns(nets),
+				  nla_get_u32(tb[IFLA_LINK]));
 	if (!pdev || pdev->type != ARPHRD_INFINIBAND)
 		return -ENODEV;
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 98c6205ed19f..9537175f7ac8 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3161,14 +3161,14 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int amt_newlink(struct net *net, struct net_device *dev,
+static int amt_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
 	struct amt_dev *amt = netdev_priv(dev);
 	int err = -EINVAL;
 
-	amt->net = net;
+	amt->net = rtnl_link_netns(nets);
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
@@ -3183,7 +3183,7 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 	amt->hash_buckets = AMT_HSIZE;
 	amt->nr_tunnels = 0;
 	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));
-	amt->stream_dev = dev_get_by_index(net,
+	amt->stream_dev = dev_get_by_index(rtnl_link_netns(nets),
 					   nla_get_u32(data[IFLA_AMT_LINK]));
 	if (!amt->stream_dev) {
 		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_LINK],
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index a2abfade82dd..c0946006d175 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -698,7 +698,7 @@ static void bareudp_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
-static int bareudp_newlink(struct net *net, struct net_device *dev,
+static int bareudp_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -709,7 +709,7 @@ static int bareudp_newlink(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
-	err = bareudp_configure(net, dev, &conf, extack);
+	err = bareudp_configure(rtnl_link_netns(nets), dev, &conf, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..242a37934f25 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -564,7 +564,8 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 	return 0;
 }
 
-static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
+static int bond_newlink(struct rtnl_link_nets *nets,
+			struct net_device *bond_dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 01aacdcda260..daf88325ccac 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -624,7 +624,7 @@ static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
-static int can_newlink(struct net *src_net, struct net_device *dev,
+static int can_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index da7c72105fb6..2375175044bc 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -172,7 +172,7 @@ static void vxcan_setup(struct net_device *dev)
 /* forward declaration for rtnl_create_link() */
 static struct rtnl_link_ops vxcan_link_ops;
 
-static int vxcan_newlink(struct net *net, struct net_device *dev,
+static int vxcan_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
@@ -203,7 +203,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	peer_net = rtnl_link_get_net(net, tbp);
+	peer_net = rtnl_link_get_net(rtnl_link_netns(nets), tbp);
 	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&vxcan_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index f3bea196a8f9..fa881b038d69 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -117,7 +117,7 @@ static void rmnet_unregister_bridge(struct rmnet_port *port)
 	rmnet_unregister_real_device(bridge_dev);
 }
 
-static int rmnet_newlink(struct net *src_net, struct net_device *dev,
+static int rmnet_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
@@ -134,7 +134,8 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(rtnl_link_netns(nets),
+				      nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2f29b1386b1c..f621d5887b3d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1614,7 +1614,7 @@ static void geneve_link_config(struct net_device *dev,
 	geneve_change_mtu(dev, ldev_mtu - info->options_len);
 }
 
-static int geneve_newlink(struct net *net, struct net_device *dev,
+static int geneve_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
@@ -1631,7 +1631,7 @@ static int geneve_newlink(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
-	err = geneve_configure(net, dev, extack, &cfg);
+	err = geneve_configure(rtnl_link_netns(nets), dev, extack, &cfg);
 	if (err)
 		return err;
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..73ad219746ec 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1460,7 +1460,7 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 #define GTP_TH_MAXLEN	(sizeof(struct udphdr) + sizeof(struct gtp0_header))
 #define GTP_IPV6_MAXLEN	(sizeof(struct ipv6hdr) + GTP_TH_MAXLEN)
 
-static int gtp_newlink(struct net *src_net, struct net_device *dev,
+static int gtp_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
@@ -1494,7 +1494,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
 						0);
 
-	gtp->net = src_net;
+	gtp->net = rtnl_link_netns(nets);
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 025e0c19ec25..81e11086df51 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -166,7 +166,7 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 void *ipvlan_get_L3_hdr(struct ipvl_port *port, struct sk_buff *skb, int *type);
 void ipvlan_count_rx(const struct ipvl_dev *ipvlan,
 		     unsigned int len, bool success, bool mcast);
-int ipvlan_link_new(struct net *src_net, struct net_device *dev,
+int ipvlan_link_new(struct rtnl_link_nets *nets, struct net_device *dev,
 		    struct nlattr *tb[], struct nlattr *data[],
 		    struct netlink_ext_ack *extack);
 void ipvlan_link_delete(struct net_device *dev, struct list_head *head);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee2c3cf4df36..5bd670927d27 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -532,7 +532,7 @@ static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 	return ret;
 }
 
-int ipvlan_link_new(struct net *src_net, struct net_device *dev,
+int ipvlan_link_new(struct rtnl_link_nets *nets, struct net_device *dev,
 		    struct nlattr *tb[], struct nlattr *data[],
 		    struct netlink_ext_ack *extack)
 {
@@ -545,7 +545,8 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	phy_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	phy_dev = __dev_get_by_index(rtnl_link_netns(nets),
+				     nla_get_u32(tb[IFLA_LINK]));
 	if (!phy_dev)
 		return -ENODEV;
 
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..7d8f780581e3 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -73,7 +73,7 @@ static void ipvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
+static int ipvtap_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
@@ -97,7 +97,7 @@ static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err =  ipvlan_link_new(src_net, dev, tb, data, extack);
+	err =  ipvlan_link_new(nets, dev, tb, data, extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1bc1e5993f56..c7871c6747ca 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4141,7 +4141,7 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 
 static struct lock_class_key macsec_netdev_addr_lock_key;
 
-static int macsec_newlink(struct net *net, struct net_device *dev,
+static int macsec_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
@@ -4154,7 +4154,8 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
-	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(rtnl_link_netns(nets),
+				      nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
 	if (real_dev->type != ARPHRD_ETHER)
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index edbd5afcec41..24a1630e2ead 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1565,11 +1565,12 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(macvlan_common_newlink);
 
-static int macvlan_newlink(struct net *src_net, struct net_device *dev,
+static int macvlan_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	return macvlan_common_newlink(src_net, dev, tb, data, extack);
+	return macvlan_common_newlink(rtnl_link_netns(nets), dev, tb, data,
+				      extack);
 }
 
 void macvlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..99152d4ba82b 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -77,7 +77,7 @@ static void macvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int macvtap_newlink(struct net *src_net, struct net_device *dev,
+static int macvtap_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -105,7 +105,8 @@ static int macvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err = macvlan_common_newlink(src_net, dev, tb, data, extack);
+	err = macvlan_common_newlink(rtnl_link_netns(nets), dev, tb, data,
+				     extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index bb07725d1c72..70837ebbb9f2 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -327,7 +327,7 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 static struct rtnl_link_ops netkit_link_ops;
 
-static int netkit_new_link(struct net *src_net, struct net_device *dev,
+static int netkit_new_link(struct rtnl_link_nets *nets, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -385,7 +385,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
 		return -EOPNOTSUPP;
 
-	net = rtnl_link_get_net(src_net, tbp);
+	net = rtnl_link_get_net(rtnl_link_netns(nets), tbp);
 	peer = rtnl_create_link(net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..e1cf41cb9a87 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -184,7 +184,7 @@ static int pfcp_add_sock(struct pfcp_dev *pfcp)
 	return PTR_ERR_OR_ZERO(pfcp->sock);
 }
 
-static int pfcp_newlink(struct net *net, struct net_device *dev,
+static int pfcp_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -192,7 +192,7 @@ static int pfcp_newlink(struct net *net, struct net_device *dev,
 	struct pfcp_net *pn;
 	int err;
 
-	pfcp->net = net;
+	pfcp->net = rtnl_link_netns(nets);
 
 	err = pfcp_add_sock(pfcp);
 	if (err) {
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..87ade0389d0d 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1303,7 +1303,7 @@ static int ppp_nl_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int ppp_nl_newlink(struct net *src_net, struct net_device *dev,
+static int ppp_nl_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
@@ -1343,7 +1343,7 @@ static int ppp_nl_newlink(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_IFNAME] || !nla_len(tb[IFLA_IFNAME]) || !*(char *)nla_data(tb[IFLA_IFNAME]))
 		conf.ifname_is_set = false;
 
-	err = ppp_dev_configure(src_net, dev, &conf);
+	err = ppp_dev_configure(rtnl_link_netns(nets), dev, &conf);
 
 out_unlock:
 	mutex_unlock(&ppp_mutex);
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index a1b27b69f010..d0f1fc404264 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2206,7 +2206,7 @@ static void team_setup(struct net_device *dev)
 	dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 }
 
-static int team_newlink(struct net *src_net, struct net_device *dev,
+static int team_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0d6d0d749d44..a64d0c87b18f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1765,7 +1765,7 @@ static int veth_init_queues(struct net_device *dev, struct nlattr *tb[])
 	return 0;
 }
 
-static int veth_newlink(struct net *src_net, struct net_device *dev,
+static int veth_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -1800,7 +1800,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	net = rtnl_link_get_net(src_net, tbp);
+	net = rtnl_link_get_net(rtnl_link_netns(nets), tbp);
 	peer = rtnl_create_link(net, ifname, name_assign_type,
 				&veth_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 67d25f4f94ef..7dd53d84b289 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1698,7 +1698,7 @@ static void vrf_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
-static int vrf_newlink(struct net *src_net, struct net_device *dev,
+static int vrf_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 42b07bc2b107..6a7fee5fc504 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4345,7 +4345,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int vxlan_newlink(struct net *src_net, struct net_device *dev,
+static int vxlan_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
@@ -4356,7 +4356,7 @@ static int vxlan_newlink(struct net *src_net, struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
+	return __vxlan_dev_create(rtnl_link_netns(nets), dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..25118e1085f7 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -306,14 +306,14 @@ static void wg_setup(struct net_device *dev)
 	wg->dev = dev;
 }
 
-static int wg_newlink(struct net *src_net, struct net_device *dev,
+static int wg_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		      struct nlattr *tb[], struct nlattr *data[],
 		      struct netlink_ext_ack *extack)
 {
 	struct wg_device *wg = netdev_priv(dev);
 	int ret = -ENOMEM;
 
-	rcu_assign_pointer(wg->creating_net, src_net);
+	rcu_assign_pointer(wg->creating_net, rtnl_link_netns(nets));
 	init_rwsem(&wg->static_identity.lock);
 	mutex_init(&wg->socket_update_lock);
 	mutex_init(&wg->device_update_lock);
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..3fea244010e8 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -519,7 +519,8 @@ static rx_handler_result_t virt_wifi_rx_handler(struct sk_buff **pskb)
 }
 
 /* Called with rtnl lock held. */
-static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
+static int virt_wifi_newlink(struct rtnl_link_nets *nets,
+			     struct net_device *dev,
 			     struct nlattr *tb[], struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
@@ -532,7 +533,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	netif_carrier_off(dev);
 
 	priv->upperdev = dev;
-	priv->lowerdev = __dev_get_by_index(src_net,
+	priv->lowerdev = __dev_get_by_index(rtnl_link_netns(nets),
 					    nla_get_u32(tb[IFLA_LINK]));
 
 	if (!priv->lowerdev)
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e2755991a..f208993e04c0 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -967,7 +967,8 @@ static struct net_device *wwan_rtnl_alloc(struct nlattr *tb[],
 	return dev;
 }
 
-static int wwan_rtnl_newlink(struct net *src_net, struct net_device *dev,
+static int wwan_rtnl_newlink(struct rtnl_link_nets *nets,
+			     struct net_device *dev,
 			     struct nlattr *tb[], struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
@@ -1064,6 +1065,7 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct net_device *dev;
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
+	struct rtnl_link_nets nets = { .src_net = &init_net };
 
 	/* Forge attributes required to create a WWAN netdev. We first
 	 * build a netlink message and then parse it. This looks
@@ -1105,7 +1107,7 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	if (WARN_ON(IS_ERR(dev)))
 		goto unlock;
 
-	if (WARN_ON(wwan_rtnl_newlink(&init_net, dev, tb, data, NULL))) {
+	if (WARN_ON(wwan_rtnl_newlink(&nets, dev, tb, data, NULL))) {
 		free_netdev(dev);
 		goto unlock;
 	}
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..ae1f2dda4533 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -406,8 +406,9 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bc0069a8b6ea..f285071a24d4 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -69,6 +69,26 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 		return AF_UNSPEC;
 }
 
+/**
+ *	struct rtnl_link_nets - net namespace context of newlink.
+ *
+ *	@src_net: Source netns of rtnetlink socket
+ *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified.
+ */
+struct rtnl_link_nets {
+	struct net *src_net;
+	struct net *link_net;
+};
+
+/* Get effective link netns from struct rtnl_link_nets. Generally, this is
+ * link_net and falls back to src_net. But for compatibility, a driver may
+ * choose to use dev_net(dev) instead.
+ */
+static inline struct net *rtnl_link_netns(struct rtnl_link_nets *nets)
+{
+	return nets->link_net ? : nets->src_net;
+}
+
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
@@ -125,7 +145,7 @@ struct rtnl_link_ops {
 					    struct nlattr *data[],
 					    struct netlink_ext_ack *extack);
 
-	int			(*newlink)(struct net *src_net,
+	int			(*newlink)(struct rtnl_link_nets *nets,
 					   struct net_device *dev,
 					   struct nlattr *tb[],
 					   struct nlattr *data[],
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 134419667d59..fe62c7c71e7f 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -135,7 +135,7 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static int vlan_newlink(struct net *src_net, struct net_device *dev,
+static int vlan_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -155,7 +155,8 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(rtnl_link_netns(nets),
+				      nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2758aba47a2f..d1c12072feaa 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1063,7 +1063,7 @@ static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
 
 /**
  * batadv_softif_newlink() - pre-initialize and register new batadv link
- * @src_net: the applicable net namespace
+ * @nets: the applicable net namespaces
  * @dev: network device to register
  * @tb: IFLA_INFO_DATA netlink attributes
  * @data: enum batadv_ifla_attrs attributes
@@ -1071,7 +1071,8 @@ static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
+static int batadv_softif_newlink(struct rtnl_link_nets *nets,
+				 struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3e0f47203f2a..715abe3f8b89 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1553,7 +1553,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	return 0;
 }
 
-static int br_dev_newlink(struct net *src_net, struct net_device *dev,
+static int br_dev_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 94ad09e36df2..a805f7552ac9 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -438,7 +438,7 @@ static void caif_netlink_parms(struct nlattr *data[],
 	}
 }
 
-static int ipcaif_newlink(struct net *src_net, struct net_device *dev,
+static int ipcaif_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f573ace60234..93bc4ea8a62e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3750,6 +3750,10 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
 	int err;
+	struct rtnl_link_nets nets = {
+		.src_net = net,
+		.link_net = link_net,
+	};
 
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
@@ -3761,8 +3765,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3771,7 +3775,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 
 	if (ops->newlink)
-		err = ops->newlink(link_net ? : net, dev, tb, data, extack);
+		err = ops->newlink(&nets, dev, tb, data, extack);
 	else
 		err = register_netdevice(dev);
 	if (err < 0) {
@@ -3782,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b68f2f71d0e1..efd42af79b94 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -29,7 +29,7 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
 /* Here, it seems a netdevice has already been allocated for us, and the
  * hsr_dev_setup routine has been executed. Nice!
  */
-static int hsr_newlink(struct net *src_net, struct net_device *dev,
+static int hsr_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
@@ -46,7 +46,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 device not specified");
 		return -EINVAL;
 	}
-	link[0] = __dev_get_by_index(src_net,
+	link[0] = __dev_get_by_index(rtnl_link_netns(nets),
 				     nla_get_u32(data[IFLA_HSR_SLAVE1]));
 	if (!link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 does not exist");
@@ -56,7 +56,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 device not specified");
 		return -EINVAL;
 	}
-	link[1] = __dev_get_by_index(src_net,
+	link[1] = __dev_get_by_index(rtnl_link_netns(nets),
 				     nla_get_u32(data[IFLA_HSR_SLAVE2]));
 	if (!link[1]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 does not exist");
@@ -69,7 +69,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	if (data[IFLA_HSR_INTERLINK])
-		interlink = __dev_get_by_index(src_net,
+		interlink = __dev_get_by_index(rtnl_link_netns(nets),
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
 
 	if (interlink && interlink == link[0]) {
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 175efd860f7b..fd661fec3975 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -129,7 +129,7 @@ static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
+static int lowpan_newlink(struct rtnl_link_nets *nets, struct net_device *ldev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(nets->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc793..6fc344f5005c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1389,10 +1389,11 @@ ipgre_newlink_encap_setup(struct net_device *dev, struct nlattr *data[])
 	return 0;
 }
 
-static int ipgre_newlink(struct net *src_net, struct net_device *dev,
+static int ipgre_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1404,13 +1405,14 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(net, dev, tb, &p, fwmark);
 }
 
-static int erspan_newlink(struct net *src_net, struct net_device *dev,
+static int erspan_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1422,7 +1424,7 @@ static int erspan_newlink(struct net *src_net, struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(net, dev, tb, &p, fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1695,6 +1697,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	LIST_HEAD(list_kill);
 	struct ip_tunnel *t;
 	int err;
+	struct rtnl_link_nets nets = { .src_net = net };
 
 	memset(&tb, 0, sizeof(tb));
 
@@ -1707,7 +1710,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	t = netdev_priv(dev);
 	t->collect_md = true;
 
-	err = ipgre_newlink(net, dev, tb, NULL, NULL);
+	err = ipgre_newlink(&nets, dev, tb, NULL, NULL);
 	if (err < 0) {
 		free_netdev(dev);
 		return ERR_PTR(err);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..618a50d5c0c2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
@@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index f0b4419cef34..c315d60e02ec 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -575,7 +575,7 @@ static void vti_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti_newlink(struct net *src_net, struct net_device *dev,
+static int vti_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
@@ -583,7 +583,8 @@ static int vti_newlink(struct net *src_net, struct net_device *dev,
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(nets->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index dc0db5895e0e..7d6619d7ab3e 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -436,7 +436,7 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ipip_newlink(struct net *src_net, struct net_device *dev,
+static int ipip_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -453,7 +453,8 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(nets->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec70..eb2909689002 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1971,7 +1971,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1992,7 +1992,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2005,12 +2005,12 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 	return err;
 }
 
-static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *nt = netdev_priv(dev);
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2025,7 +2025,7 @@ static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2241,12 +2241,13 @@ static void ip6erspan_tap_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 }
 
-static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
+static int ip6erspan_newlink(struct rtnl_link_nets *nets,
+			     struct net_device *dev,
 			     struct nlattr *tb[], struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *nt = netdev_priv(dev);
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2262,7 +2263,7 @@ static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..994357690d52 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -250,10 +250,9 @@ static void ip6_dev_free(struct net_device *dev)
 	dst_cache_destroy(&t->dst_cache);
 }
 
-static int ip6_tnl_create2(struct net_device *dev)
+static int ip6_tnl_create2(struct net *net, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	int err;
 
@@ -308,7 +307,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 	t = netdev_priv(dev);
 	t->parms = *p;
 	t->net = dev_net(dev);
-	err = ip6_tnl_create2(dev);
+	err = ip6_tnl_create2(net, dev);
 	if (err < 0)
 		goto failed_free;
 
@@ -2002,11 +2001,11 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
+static int ip6_tnl_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 	struct ip6_tnl *nt, *t;
@@ -2031,7 +2030,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6_tnl_create2(dev);
+	err = ip6_tnl_create2(net, dev);
 	if (!err && tb[IFLA_MTU])
 		ip6_tnl_change_mtu(dev, nla_get_u32(tb[IFLA_MTU]));
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 590737c27537..a329ee728331 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -174,10 +174,9 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 	}
 }
 
-static int vti6_tnl_create2(struct net_device *dev)
+static int vti6_tnl_create2(struct net *net, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 	int err;
 
@@ -221,7 +220,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
 	t->parms = *p;
 	t->net = dev_net(dev);
 
-	err = vti6_tnl_create2(dev);
+	err = vti6_tnl_create2(net, dev);
 	if (err < 0)
 		goto failed_free;
 
@@ -997,11 +996,11 @@ static void vti6_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti6_newlink(struct net *src_net, struct net_device *dev,
+static int vti6_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt;
 
 	nt = netdev_priv(dev);
@@ -1012,7 +1011,7 @@ static int vti6_newlink(struct net *src_net, struct net_device *dev,
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
 
-	return vti6_tnl_create2(dev);
+	return vti6_tnl_create2(net, dev);
 }
 
 static void vti6_dellink(struct net_device *dev, struct list_head *head)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 39bd8951bfca..6d7e4be325e7 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -198,10 +198,9 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 #endif
 }
 
-static int ipip6_tunnel_create(struct net_device *dev)
+static int ipip6_tunnel_create(struct net *net, struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 	int err;
 
@@ -270,7 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
-	if (ipip6_tunnel_create(dev) < 0)
+	if (ipip6_tunnel_create(net, dev) < 0)
 		goto failed_free;
 
 	if (!parms->name[0])
@@ -1550,11 +1549,11 @@ static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
 }
 #endif
 
-static int ipip6_newlink(struct net *src_net, struct net_device *dev,
+static int ipip6_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
 #ifdef CONFIG_IPV6_SIT_6RD
@@ -1575,7 +1574,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 	if (ipip6_tunnel_locate(net, &nt->parms, 0))
 		return -EEXIST;
 
-	err = ipip6_tunnel_create(dev);
+	err = ipip6_tunnel_create(net, dev);
 	if (err < 0)
 		return err;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..c072de6db133 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -814,11 +813,11 @@ static void xfrmi_netlink_parms(struct nlattr *data[],
 		parms->collect_md = true;
 }
 
-static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int xfrmi_newlink(struct rtnl_link_nets *nets, struct net_device *dev,
+			 struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
 {
-	struct net *net = dev_net(dev);
+	struct net *net = nets->link_net ? : dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
 	int err;
@@ -851,7 +850,7 @@ static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.0


