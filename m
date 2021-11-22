Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C94594F0
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhKVSts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 13:49:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:30770 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237678AbhKVStr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 13:49:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="214878594"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="214878594"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 10:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="739350094"
Received: from anguy11-desk2.jf.intel.com ([10.166.244.147])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2021 10:46:40 -0800
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kiran Bhandare <kiranx.bhandare@intel.com>
Subject: [PATCH net 1/2] ice: fix vsi->txq_map sizing
Date:   Mon, 22 Nov 2021 10:45:21 -0800
Message-Id: <20211122184522.147331-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211122184522.147331-1-anthony.l.nguyen@intel.com>
References: <20211122184522.147331-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

The approach of having XDP queue per CPU regardless of user's setting
exposed a hidden bug that could occur in case when Rx queue count differ
from Tx queue count. Currently vsi->txq_map's size is equal to the
doubled vsi->alloc_txq, which is not correct due to the fact that XDP
rings were previously based on the Rx queue count. Below splat can be
seen when ethtool -L is used and XDP rings are configured:

[  682.875339] BUG: kernel NULL pointer dereference, address: 000000000000000f
[  682.883403] #PF: supervisor read access in kernel mode
[  682.889345] #PF: error_code(0x0000) - not-present page
[  682.895289] PGD 0 P4D 0
[  682.898218] Oops: 0000 [#1] PREEMPT SMP PTI
[  682.903055] CPU: 42 PID: 2878 Comm: ethtool Tainted: G           OE     5.15.0-rc5+ #1
[  682.912214] Hardware name: Intel Corp. GRANTLEY/GRANTLEY, BIOS GRRFCRB1.86B.0276.D07.1605190235 05/19/2016
[  682.923380] RIP: 0010:devres_remove+0x44/0x130
[  682.928527] Code: 49 89 f4 55 48 89 fd 4c 89 ff 53 48 83 ec 10 e8 92 b9 49 00 48 8b 9d a8 02 00 00 48 8d 8d a0 02 00 00 49 89 c2 48 39 cb 74 0f <4c> 3b 63 10 74 25 48 8b 5b 08 48 39 cb 75 f1 4c 89 ff 4c 89 d6 e8
[  682.950237] RSP: 0018:ffffc90006a679f0 EFLAGS: 00010002
[  682.956285] RAX: 0000000000000286 RBX: ffffffffffffffff RCX: ffff88908343a370
[  682.964538] RDX: 0000000000000001 RSI: ffffffff81690d60 RDI: 0000000000000000
[  682.972789] RBP: ffff88908343a0d0 R08: 0000000000000000 R09: 0000000000000000
[  682.981040] R10: 0000000000000286 R11: 3fffffffffffffff R12: ffffffff81690d60
[  682.989282] R13: ffffffff81690a00 R14: ffff8890819807a8 R15: ffff88908343a36c
[  682.997535] FS:  00007f08c7bfa740(0000) GS:ffff88a03fd00000(0000) knlGS:0000000000000000
[  683.006910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  683.013557] CR2: 000000000000000f CR3: 0000001080a66003 CR4: 00000000003706e0
[  683.021819] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  683.030075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  683.038336] Call Trace:
[  683.041167]  devm_kfree+0x33/0x50
[  683.045004]  ice_vsi_free_arrays+0x5e/0xc0 [ice]
[  683.050380]  ice_vsi_rebuild+0x4c8/0x750 [ice]
[  683.055543]  ice_vsi_recfg_qs+0x9a/0x110 [ice]
[  683.060697]  ice_set_channels+0x14f/0x290 [ice]
[  683.065962]  ethnl_set_channels+0x333/0x3f0
[  683.070807]  genl_family_rcv_msg_doit+0xea/0x150
[  683.076152]  genl_rcv_msg+0xde/0x1d0
[  683.080289]  ? channels_prepare_data+0x60/0x60
[  683.085432]  ? genl_get_cmd+0xd0/0xd0
[  683.089667]  netlink_rcv_skb+0x50/0xf0
[  683.094006]  genl_rcv+0x24/0x40
[  683.097638]  netlink_unicast+0x239/0x340
[  683.102177]  netlink_sendmsg+0x22e/0x470
[  683.106717]  sock_sendmsg+0x5e/0x60
[  683.110756]  __sys_sendto+0xee/0x150
[  683.114894]  ? handle_mm_fault+0xd0/0x2a0
[  683.119535]  ? do_user_addr_fault+0x1f3/0x690
[  683.134173]  __x64_sys_sendto+0x25/0x30
[  683.148231]  do_syscall_64+0x3b/0xc0
[  683.161992]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fix this by taking into account the value that num_possible_cpus()
yields in addition to vsi->alloc_txq instead of doubling the latter.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Fixes: 22bf877e528f ("ice: introduce XDP_TX fallback path")
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 40562600a8cf..09a3297cd63c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -89,8 +89,13 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->rx_rings)
 		goto err_rings;
 
-	/* XDP will have vsi->alloc_txq Tx queues as well, so double the size */
-	vsi->txq_map = devm_kcalloc(dev, (2 * vsi->alloc_txq),
+	/* txq_map needs to have enough space to track both Tx (stack) rings
+	 * and XDP rings; at this point vsi->num_xdp_txq might not be set,
+	 * so use num_possible_cpus() as we want to always provide XDP ring
+	 * per CPU, regardless of queue count settings from user that might
+	 * have come from ethtool's set_channels() callback;
+	 */
+	vsi->txq_map = devm_kcalloc(dev, (vsi->alloc_txq + num_possible_cpus()),
 				    sizeof(*vsi->txq_map), GFP_KERNEL);
 
 	if (!vsi->txq_map)
-- 
2.31.1

