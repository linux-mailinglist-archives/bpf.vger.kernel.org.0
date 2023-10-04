Return-Path: <bpf+bounces-11352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB867B7AC7
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DB4692817C9
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640B4107AB;
	Wed,  4 Oct 2023 08:53:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2711078D;
	Wed,  4 Oct 2023 08:53:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F698;
	Wed,  4 Oct 2023 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696409612; x=1727945612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jOkGAQMfFt/tof6iuDRfEPv3hBtFiBn7WKU34mkhsf0=;
  b=TulpEIa6guRndKA2o0LV7cyCrlfA/MfcQq/lrpPYkRynlPhJwudUg3G0
   AC4gFO7wCChzmkaqDHjb17A2XIWJBP73G+fW3DgkM0e8+Cf4Xal/ct7dE
   iOVSGy/ZAmjD1KJD1cKF0ae5uFNks9mF49CoLRJhv8oxYF9rJisys8aIZ
   1iVfvYwwxQdBlTVbnNeAfyc/qxJE8KcxG4XyxfnzZo6d/wuw9slV4o2rr
   IhJw0kbFavO7P2CYoS6dFAFlwgsvrRFY1gHC4UW1vqO6pUjL/M8wtEpbJ
   fFv5jt6GMhlvOOsfxD8cLSft+wK3L4Zm8CWyk34bmMmLFpDRdWHZZHh4g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469375221"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="469375221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894850759"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="894850759"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:52:05 -0700
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com
Subject: [PATCH net] i40e: sync next_to_clean and next_to_process for programming status desc
Date: Wed,  4 Oct 2023 14:04:54 +0530
Message-Id: <20231004083454.20143-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When a programming status desc is encountered on the rx_ring,
next_to_process is bumped along with cleaned_count but next_to_clean is
not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
overwriting whole ring with new buffers.

Update next_to_clean to point to next_to_process on seeing a programming
status desc if not in the middle of handling a multi-frag packet. Also,
bump cleaned_count only for such case as otherwise next_to_clean buffer
may be returned to hardware on reaching clean_threshold.

Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reported-by: hq.dev+kernel@msdfc.xyz
Reported by: Solomon Peachy <pizza@shaftnet.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
Tested-by: hq.dev+kernel@msdfc.xyz
Tested by: Indrek Järve <incx@dustbite.net>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb..50c70a8e470a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			rx_buffer = i40e_rx_bi(rx_ring, ntp);
 			i40e_inc_ntp(rx_ring);
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
-			cleaned_count++;
+			/* Update ntc and bump cleaned count if not in the
+			 * middle of mb packet.
+			 */
+			if (rx_ring->next_to_clean == ntp) {
+				rx_ring->next_to_clean =
+					rx_ring->next_to_process;
+				cleaned_count++;
+			}
 			continue;
 		}
 
-- 
2.34.1


