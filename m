Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE626B2F97
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCIV35 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 16:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCIV3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 16:29:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C1E1939;
        Thu,  9 Mar 2023 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678397391; x=1709933391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clNquW0R/qxySvFeKYbF82GzRSqZaBQkUWMw8oEqUb0=;
  b=Cfe9yZ6Ip6zQ0K/ECk4MMcbOZOczVKrVEej7Wt5Gu5XgoRTvNvBcRZn0
   UOXV8LG1C8Q0HzRZ7JSZBSNilJlFexF52nN3GJDQN2Jv0Vp8zxjh1qNAK
   aubPv/FkozcEZ3X7efQuBNseHQ16oZ5IX48AjdSJNhomYSpD7iV84BvHA
   Ev8o8kjyfmUkqhuePevw6tB3+8bR5WS7/Gp+qRIhSRQ1zBCG8E+ZfsUu7
   fXdMZgsKfPyY/R7jEwWv+KyqGqopmhujPb3ZR6SiAquoGaNWpowpFyWoB
   8p/mXZ9RcBj2q2t1bUC5cyiZXeZAEVAAssRD42p4USF2kPrrYTdO5K6P/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338126159"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="338126159"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 13:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="710011475"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="710011475"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2023 13:29:51 -0800
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org
Cc:     Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
        anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net-next v2 6/8] i40e: introduce next_to_process to i40e_ring
Date:   Thu,  9 Mar 2023 13:28:17 -0800
Message-Id: <20230309212819.1198218-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230309212819.1198218-1-anthony.l.nguyen@intel.com>
References: <20230309212819.1198218-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Add a new field called next_to_process in the i40e_ring that is
advanced for every buffer and change the semantics of next_to_clean to
point to the first buffer of a packet. Driver will use next_to_process
in the same way next_to_clean was used previously.

For the non multi-buffer case, next_to_process and next_to_clean will
always be the same since each packet consists of a single buffer.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 26 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  4 ++++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e34595ca4fbe..7fa35ff52689 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1524,6 +1524,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_process = 0;
 	rx_ring->next_to_use = 0;
 }
 
@@ -1576,6 +1577,7 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_process = 0;
 	rx_ring->next_to_use = 0;
 
 	/* XDP RX-queue info only needed for RX rings exposed to XDP */
@@ -2076,7 +2078,7 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
 {
 	struct i40e_rx_buffer *rx_buffer;
 
-	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
+	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_process);
 	rx_buffer->page_count =
 #if (PAGE_SIZE < 8192)
 		page_count(rx_buffer->page);
@@ -2375,16 +2377,16 @@ void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
 }
 
 /**
- * i40e_inc_ntc: Advance the next_to_clean index
+ * i40e_inc_ntp: Advance the next_to_process index
  * @rx_ring: Rx ring
  **/
-static void i40e_inc_ntc(struct i40e_ring *rx_ring)
+static void i40e_inc_ntp(struct i40e_ring *rx_ring)
 {
-	u32 ntc = rx_ring->next_to_clean + 1;
+	u32 ntp = rx_ring->next_to_process + 1;
 
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-	prefetch(I40E_RX_DESC(rx_ring, ntc));
+	ntp = (ntp < rx_ring->count) ? ntp : 0;
+	rx_ring->next_to_process = ntp;
+	prefetch(I40E_RX_DESC(rx_ring, ntp));
 }
 
 /**
@@ -2421,6 +2423,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
+		u16 ntp = rx_ring->next_to_process;
 		struct i40e_rx_buffer *rx_buffer;
 		union i40e_rx_desc *rx_desc;
 		unsigned int size;
@@ -2433,7 +2436,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			cleaned_count = 0;
 		}
 
-		rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		rx_desc = I40E_RX_DESC(rx_ring, ntp);
 
 		/* status_error_len will always be zero for unused descriptors
 		 * because it's cleared in cleanup, and overlaps with hdr_addr
@@ -2452,8 +2455,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
-			rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
-			i40e_inc_ntc(rx_ring);
+			rx_buffer = i40e_rx_bi(rx_ring, ntp);
+			i40e_inc_ntp(rx_ring);
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
 			cleaned_count++;
 			continue;
@@ -2509,7 +2512,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		i40e_put_rx_buffer(rx_ring, rx_buffer);
 		cleaned_count++;
 
-		i40e_inc_ntc(rx_ring);
+		i40e_inc_ntp(rx_ring);
+		rx_ring->next_to_clean = rx_ring->next_to_process;
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index eec4a4a99b9c..75888a9ab06d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -337,6 +337,10 @@ struct i40e_ring {
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
 
+	/* Next descriptor to be processed; next_to_clean is updated only on
+	 * processing EOP descriptor
+	 */
+	u16 next_to_process;
 	/* high bit set means dynamic, use accessor routines to read/write.
 	 * hardware only supports 2us resolution for the ITR registers.
 	 * these values always store the USER setting, and must be converted
-- 
2.38.1

