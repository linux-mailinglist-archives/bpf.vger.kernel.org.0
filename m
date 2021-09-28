Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09141BA1C
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 00:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbhI1WVf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 18:21:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:61585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240687AbhI1WVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 18:21:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224855469"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224855469"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 15:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="655279845"
Received: from anguy11-desk2.jf.intel.com ([10.166.244.147])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2021 15:19:54 -0700
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Feng Zhou <zhoufeng.zf@bytedance.com>, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH net 1/1] ixgbe: Fix NULL pointer dereference in ixgbe_xdp_setup
Date:   Tue, 28 Sep 2021 15:23:59 -0700
Message-Id: <20210928222359.3380825-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

The ixgbe driver currently generates a NULL pointer dereference with
some machine (online cpus < 63). This is due to the fact that the
maximum value of num_xdp_queues is nr_cpu_ids. Code is in
"ixgbe_set_rss_queues"".

Here's how the problem repeats itself:
Some machine (online cpus < 63), And user set num_queues to 63 through
ethtool. Code is in the "ixgbe_set_channels",
	adapter->ring_feature[RING_F_FDIR].limit = count;

It becomes 63.

When user use xdp, "ixgbe_set_rss_queues" will set queues num.
	adapter->num_rx_queues = rss_i;
	adapter->num_tx_queues = rss_i;
	adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);

And rss_i's value is from
	f = &adapter->ring_feature[RING_F_FDIR];
	rss_i = f->indices = f->limit;

So "num_rx_queues" > "num_xdp_queues", when run to "ixgbe_xdp_setup",
	for (i = 0; i < adapter->num_rx_queues; i++)
		if (adapter->xdp_ring[i]->xsk_umem)

It leads to panic.

Call trace:
[exception RIP: ixgbe_xdp+368]
RIP: ffffffffc02a76a0  RSP: ffff9fe16202f8d0  RFLAGS: 00010297
RAX: 0000000000000000  RBX: 0000000000000020  RCX: 0000000000000000
RDX: 0000000000000000  RSI: 000000000000001c  RDI: ffffffffa94ead90
RBP: ffff92f8f24c0c18   R8: 0000000000000000   R9: 0000000000000000
R10: ffff9fe16202f830  R11: 0000000000000000  R12: ffff92f8f24c0000
R13: ffff9fe16202fc01  R14: 000000000000000a  R15: ffffffffc02a7530
ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 7 [ffff9fe16202f8f0] dev_xdp_install at ffffffffa89fbbcc
 8 [ffff9fe16202f920] dev_change_xdp_fd at ffffffffa8a08808
 9 [ffff9fe16202f960] do_setlink at ffffffffa8a20235
10 [ffff9fe16202fa88] rtnl_setlink at ffffffffa8a20384
11 [ffff9fe16202fc78] rtnetlink_rcv_msg at ffffffffa8a1a8dd
12 [ffff9fe16202fcf0] netlink_rcv_skb at ffffffffa8a717eb
13 [ffff9fe16202fd40] netlink_unicast at ffffffffa8a70f88
14 [ffff9fe16202fd80] netlink_sendmsg at ffffffffa8a71319
15 [ffff9fe16202fdf0] sock_sendmsg at ffffffffa89df290
16 [ffff9fe16202fe08] __sys_sendto at ffffffffa89e19c8
17 [ffff9fe16202ff30] __x64_sys_sendto at ffffffffa89e1a64
18 [ffff9fe16202ff38] do_syscall_64 at ffffffffa84042b9
19 [ffff9fe16202ff50] entry_SYSCALL_64_after_hwframe at ffffffffa8c0008c

So I fix ixgbe_max_channels so that it will not allow a setting of queues
to be higher than the num_online_cpus(). And when run to ixgbe_xdp_setup,
take the smaller value of num_rx_queues and num_xdp_queues.

Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for AF_XDP")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index fc26e4ddeb0d..beda8e0ef7d4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3208,7 +3208,7 @@ static unsigned int ixgbe_max_channels(struct ixgbe_adapter *adapter)
 		max_combined = ixgbe_max_rss_indices(adapter);
 	}
 
-	return max_combined;
+	return min_t(int, max_combined, num_online_cpus());
 }
 
 static void ixgbe_get_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 24e06ba6f5e9..13c4782b920a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10112,6 +10112,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
 	bool need_reset;
+	int num_queues;
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		return -EINVAL;
@@ -10161,11 +10162,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	/* Kick start the NAPI context if there is an AF_XDP socket open
 	 * on that queue id. This so that receiving will start.
 	 */
-	if (need_reset && prog)
-		for (i = 0; i < adapter->num_rx_queues; i++)
+	if (need_reset && prog) {
+		num_queues = min_t(int, adapter->num_rx_queues,
+				   adapter->num_xdp_queues);
+		for (i = 0; i < num_queues; i++)
 			if (adapter->xdp_ring[i]->xsk_pool)
 				(void)ixgbe_xsk_wakeup(adapter->netdev, i,
 						       XDP_WAKEUP_RX);
+	}
 
 	return 0;
 }
-- 
2.26.2

