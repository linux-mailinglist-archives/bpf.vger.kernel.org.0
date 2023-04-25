Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098AC6EE651
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjDYRGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjDYRGL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 13:06:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504295BAC;
        Tue, 25 Apr 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682442369; x=1713978369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZnqnIqXpEma2krRB1HVAkkxSdhVH6PAVjZil+9/25s4=;
  b=UiIPjwUJgJJ63oN4qq60D9e4qPEv19g9Y8TM0zPfu+cwKlaLciNoENuC
   jgGRIKPr3A/IYkiTAxUBBfikRgzP4biwOSV6H8Kl4qoW9wm1zFpcv16U4
   PbWNq9VXHTHkxGqEn60oD3mPfMSbUzkgnz2PsLxes4i00pa2bfgtmgEcy
   uQAj7GD1OOEHv+8m1YP8wciCgk4MNJg1Gmu7oSOd+2DCVw1igl05wXFyl
   65/+xe/sjKhtbRAdA621fsk6BiEOJJnFd7o2aQ3WYfvlvU7S5ZqPAfCyH
   QmsoK9OMxTPZonMIL1qBtmXpxdIVvMSSJA/5jUsoS18wgtINaxY2REneT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="348757893"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="348757893"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 10:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="1023220320"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="1023220320"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2023 10:06:06 -0700
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org
Cc:     John Hickey <jjh@daedalian.us>, anthony.l.nguyen@intel.com,
        xingwanli@kuaishou.com, lishujin@kuaishou.com,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 1/1] ixgbe: Fix panic during XDP_TX with > 64 CPUs
Date:   Tue, 25 Apr 2023 10:03:08 -0700
Message-Id: <20230425170308.2522429-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Hickey <jjh@daedalian.us>

Commit 4fe815850bdc ("ixgbe: let the xdpdrv work with more than 64 cpus")
adds support to allow XDP programs to run on systems with more than
64 CPUs by locking the XDP TX rings and indexing them using cpu % 64
(IXGBE_MAX_XDP_QS).

Upon trying this out patch on a system with more than 64 cores,
the kernel paniced with an array-index-out-of-bounds at the return in
ixgbe_determine_xdp_ring in ixgbe.h, which means ixgbe_determine_xdp_q_idx
was just returning the cpu instead of cpu % IXGBE_MAX_XDP_QS.  An example
splat:

 ==========================================================================
 UBSAN: array-index-out-of-bounds in
 /var/lib/dkms/ixgbe/5.18.6+focal-1/build/src/ixgbe.h:1147:26
 index 65 is out of range for type 'ixgbe_ring *[64]'
 ==========================================================================
 BUG: kernel NULL pointer dereference, address: 0000000000000058
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 65 PID: 408 Comm: ksoftirqd/65
 Tainted: G          IOE     5.15.0-48-generic #54~20.04.1-Ubuntu
 Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 2.5.4 01/13/2020
 RIP: 0010:ixgbe_xmit_xdp_ring+0x1b/0x1c0 [ixgbe]
 Code: 3b 52 d4 cf e9 42 f2 ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 55 b9
 00 00 00 00 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 <44> 0f b7
 47 58 0f b7 47 5a 0f b7 57 54 44 0f b7 76 08 66 41 39 c0
 RSP: 0018:ffffbc3fcd88fcb0 EFLAGS: 00010282
 RAX: ffff92a253260980 RBX: ffffbc3fe68b00a0 RCX: 0000000000000000
 RDX: ffff928b5f659000 RSI: ffff928b5f659000 RDI: 0000000000000000
 RBP: ffffbc3fcd88fce0 R08: ffff92b9dfc20580 R09: 0000000000000001
 R10: 3d3d3d3d3d3d3d3d R11: 3d3d3d3d3d3d3d3d R12: 0000000000000000
 R13: ffff928b2f0fa8c0 R14: ffff928b9be20050 R15: 000000000000003c
 FS:  0000000000000000(0000) GS:ffff92b9dfc00000(0000)
 knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000058 CR3: 000000011dd6a002 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ixgbe_poll+0x103e/0x1280 [ixgbe]
  ? sched_clock_cpu+0x12/0xe0
  __napi_poll+0x30/0x160
  net_rx_action+0x11c/0x270
  __do_softirq+0xda/0x2ee
  run_ksoftirqd+0x2f/0x50
  smpboot_thread_fn+0xb7/0x150
  ? sort_range+0x30/0x30
  kthread+0x127/0x150
  ? set_kthread_struct+0x50/0x50
  ret_from_fork+0x1f/0x30
  </TASK>

I think this is how it happens:

Upon loading the first XDP program on a system with more than 64 CPUs,
ixgbe_xdp_locking_key is incremented in ixgbe_xdp_setup.  However,
immediately after this, the rings are reconfigured by ixgbe_setup_tc.
ixgbe_setup_tc calls ixgbe_clear_interrupt_scheme which calls
ixgbe_free_q_vectors which calls ixgbe_free_q_vector in a loop.
ixgbe_free_q_vector decrements ixgbe_xdp_locking_key once per call if
it is non-zero.  Commenting out the decrement in ixgbe_free_q_vector
stopped my system from panicing.

I suspect to make the original patch work, I would need to load an XDP
program and then replace it in order to get ixgbe_xdp_locking_key back
above 0 since ixgbe_setup_tc is only called when transitioning between
XDP and non-XDP ring configurations, while ixgbe_xdp_locking_key is
incremented every time ixgbe_xdp_setup is called.

Also, ixgbe_setup_tc can be called via ethtool --set-channels, so this
becomes another path to decrement ixgbe_xdp_locking_key to 0 on systems
with more than 64 CPUs.

Since ixgbe_xdp_locking_key only protects the XDP_TX path and is tied
to the number of CPUs present, there is no reason to disable it upon
unloading an XDP program.  To avoid confusion, I have moved enabling
ixgbe_xdp_locking_key into ixgbe_sw_init, which is part of the probe path.

Fixes: 4fe815850bdc ("ixgbe: let the xdpdrv work with more than 64 cpus")
Signed-off-by: John Hickey <jjh@daedalian.us>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 3 ---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index f8156fe4b1dc..0ee943db3dc9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1035,9 +1035,6 @@ static void ixgbe_free_q_vector(struct ixgbe_adapter *adapter, int v_idx)
 	adapter->q_vector[v_idx] = NULL;
 	__netif_napi_del(&q_vector->napi);
 
-	if (static_key_enabled(&ixgbe_xdp_locking_key))
-		static_branch_dec(&ixgbe_xdp_locking_key);
-
 	/*
 	 * after a call to __netif_napi_del() napi may still be used and
 	 * ixgbe_get_stats64() might access the rings on this vector,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 773c35fecace..d7c247e46dfc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6495,6 +6495,10 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	set_bit(0, adapter->fwd_bitmask);
 	set_bit(__IXGBE_DOWN, &adapter->state);
 
+	/* enable locking for XDP_TX if we have more CPUs than queues */
+	if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
+		static_branch_enable(&ixgbe_xdp_locking_key);
+
 	return 0;
 }
 
@@ -10290,8 +10294,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	 */
 	if (nr_cpu_ids > IXGBE_MAX_XDP_QS * 2)
 		return -ENOMEM;
-	else if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
-		static_branch_inc(&ixgbe_xdp_locking_key);
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	need_reset = (!!prog != !!old_prog);
-- 
2.38.1

