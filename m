Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30D22D7BD3
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbgLKRAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 12:00:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:8161 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732826AbgLKRAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 12:00:21 -0500
IronPort-SDR: JC/VZ1KAbtE5+hsGTG8YzMhXgjCqrNPhJ1e7yOShQLmWC5aCUs/bh1hqzH2yJpkixKCZDHlKcH
 GfUD4nuHzsqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="236055081"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="236055081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 08:59:31 -0800
IronPort-SDR: HXPJ2PdtmM2ixNxgFHNk4zRcgid8dRahQBjs7fRDnN30c6/xfM0uFswzhKTFEuZGzY/QJzSJFg
 g3NGYsSt2qHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="365497520"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2020 08:59:29 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        anthony.l.nguyen@intel.com, kuba@kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 3/8] i40e: adjust i40e_is_non_eop
Date:   Fri, 11 Dec 2020 17:49:51 +0100
Message-Id: <20201211164956.59628-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
References: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

i40e_is_non_eop had a leftover comment and unused skb argument which was
used for placing the skb onto rx_buf in case when current buffer was
non-eop one. This is not relevant anymore as commit e72e56597ba1
("i40e/i40evf: Moves skb from i40e_rx_buffer to i40e_ring") pulled the
non-complete skb handling out of rx_bufs up to rx_ring.  Therefore,
let's adjust the function arguments that i40e_is_non_eop takes.

Furthermore, since there is already a function responsible for bumping
the ntc, make use of that and drop that logic from i40e_is_non_eop so
that the scope of this function is limited to what the name actually
states.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 23 ++++++---------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1dbb8efa50ad..205dc2124e96 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2118,25 +2118,13 @@ static void i40e_put_rx_buffer(struct i40e_ring *rx_ring,
  * i40e_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
  * @rx_desc: Rx descriptor for current buffer
- * @skb: Current socket buffer containing buffer in progress
  *
- * This function updates next to clean.  If the buffer is an EOP buffer
- * this function exits returning false, otherwise it will place the
- * sk_buff in the next buffer to be chained and return true indicating
- * that this is in fact a non-EOP buffer.
- **/
+ * If the buffer is an EOP buffer, this function exits returning false,
+ * otherwise return true indicating that this is in fact a non-EOP buffer.
+ */
 static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
-			    union i40e_rx_desc *rx_desc,
-			    struct sk_buff *skb)
+			    union i40e_rx_desc *rx_desc)
 {
-	u32 ntc = rx_ring->next_to_clean + 1;
-
-	/* fetch, update, and store next to clean */
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-
-	prefetch(I40E_RX_DESC(rx_ring, ntc));
-
 	/* if we are the last buffer then there is nothing else to do */
 #define I40E_RXD_EOF BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)
 	if (likely(i40e_test_staterr(rx_desc, I40E_RXD_EOF)))
@@ -2414,7 +2402,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		i40e_put_rx_buffer(rx_ring, rx_buffer);
 		cleaned_count++;
 
-		if (i40e_is_non_eop(rx_ring, rx_desc, skb))
+		i40e_inc_ntc(rx_ring);
+		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
 		if (i40e_cleanup_headers(rx_ring, skb, rx_desc)) {
-- 
2.20.1

