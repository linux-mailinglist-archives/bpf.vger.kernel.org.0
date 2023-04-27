Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD956F06F1
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 16:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbjD0OET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbjD0OEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 10:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35F44B6;
        Thu, 27 Apr 2023 07:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AAE863D83;
        Thu, 27 Apr 2023 14:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58821C433EF;
        Thu, 27 Apr 2023 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682604254;
        bh=w/v8TkNlINJ/WF87Lg+J5iNjWzTzXNG9uFCdWsRckyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHgxnOfa6T9rib/ZphXMXl1bwNwHGa8lWtJS6SgPJ5c0lr5k60d1UF/FLLimT5jZZ
         YIRda045RtbP48243Y7w2YuoiEVysQs0lKeyjYFfKCIj/f8FcKQMKYItqVtzhiU7sd
         2c+rzL096cfb1F/h3TnOW/zG8+BjjwPRqve1Bk+gpDqKNvHqbFmcV2ZVswTARU/d16
         scVgNaU4esmEP0ELe9Iu7LXIRTO36NnxAwg7NCkWsB/xb5mRnUXDqiWfRrA01A/wtS
         6730yVFq9KaO6tWH/a6NCTAP8DwtcII8lBateVAe6O6YIurkx34u63yuwS5Fm8CRnZ
         3tw9UyC1k21Mg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, j.vosburgh@gmail.com,
        andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, alardam@gmail.com,
        memxor@gmail.com, sdf@google.com, brouer@redhat.com,
        toke@redhat.com
Subject: [PATCH net 1/2] bonding: add xdp_features support
Date:   Thu, 27 Apr 2023 16:03:33 +0200
Message-Id: <d5d808e56fd15385c47a45d21953e5cc28c77b89.1682603719.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682603719.git.lorenzo@kernel.org>
References: <cover.1682603719.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce xdp_features support for bonding driver according to the slave
devices attached to the master one.

Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/bonding/bond_main.c    | 48 ++++++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c |  2 ++
 include/net/bonding.h              |  1 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 710548dbd0c1..f22e3fab14d4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1789,6 +1789,45 @@ static void bond_ether_setup(struct net_device *bond_dev)
 	bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 }
 
+void bond_xdp_xdp_set_features(struct net_device *bond_dev)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	xdp_features_t val = NETDEV_XDP_ACT_MASK;
+	struct list_head *iter;
+	struct slave *slave;
+
+	ASSERT_RTNL();
+
+	if (!bond_xdp_check(bond)) {
+		xdp_clear_features_flag(bond_dev);
+		return;
+	}
+
+	bond_for_each_slave(bond, slave, iter) {
+		struct net_device *dev = slave->dev;
+
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
+			xdp_clear_features_flag(bond_dev);
+			return;
+		}
+
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_REDIRECT))
+			val &= ~NETDEV_XDP_ACT_REDIRECT;
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
+			val &= ~NETDEV_XDP_ACT_NDO_XMIT;
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY))
+			val &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_HW_OFFLOAD))
+			val &= ~NETDEV_XDP_ACT_HW_OFFLOAD;
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_RX_SG))
+			val &= ~NETDEV_XDP_ACT_RX_SG;
+		if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG))
+			val &= ~NETDEV_XDP_ACT_NDO_XMIT_SG;
+	}
+
+	xdp_set_features_flag(bond_dev, val);
+}
+
 /* enslave device <slave> to bond device <master> */
 int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 struct netlink_ext_ack *extack)
@@ -2236,6 +2275,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	bond_xdp_xdp_set_features(bond_dev);
+
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
 		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
@@ -2483,6 +2524,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 	if (!netif_is_bond_master(slave_dev))
 		slave_dev->priv_flags &= ~IFF_BONDING;
 
+	bond_xdp_xdp_set_features(bond_dev);
 	kobject_put(&slave->kobj);
 
 	return 0;
@@ -3930,6 +3972,9 @@ static int bond_slave_netdev_event(unsigned long event,
 		/* Propagate to master device */
 		call_netdevice_notifiers(event, slave->bond->dev);
 		break;
+	case NETDEV_XDP_FEAT_CHANGE:
+		bond_xdp_xdp_set_features(bond_dev);
+		break;
 	default:
 		break;
 	}
@@ -5874,6 +5919,9 @@ void bond_setup(struct net_device *bond_dev)
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
 		bond_dev->features |= BOND_XFRM_FEATURES;
 #endif /* CONFIG_XFRM_OFFLOAD */
+
+	if (bond_xdp_check(bond))
+		bond_dev->xdp_features = NETDEV_XDP_ACT_MASK;
 }
 
 /* Destroy a bonding device.
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index f71d5517f829..2a899dda79d2 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -877,6 +877,8 @@ static int bond_option_mode_set(struct bonding *bond,
 			netdev_update_features(bond->dev);
 	}
 
+	bond_xdp_xdp_set_features(bond->dev);
+
 	return 0;
 }
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index c3843239517d..fa70ba3de815 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -659,6 +659,7 @@ void bond_destroy_sysfs(struct bond_net *net);
 void bond_prepare_sysfs_group(struct bonding *bond);
 int bond_sysfs_slave_add(struct slave *slave);
 void bond_sysfs_slave_del(struct slave *slave);
+void bond_xdp_xdp_set_features(struct net_device *bond_dev);
 int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 struct netlink_ext_ack *extack);
 int bond_release(struct net_device *bond_dev, struct net_device *slave_dev);
-- 
2.40.0

