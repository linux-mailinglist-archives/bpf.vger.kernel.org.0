Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DEE3DE3CC
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhHCBEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327853"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327853"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480133"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 12/16] ethtool,igc: Add "xdp_headroom" driver info
Date:   Mon,  2 Aug 2021 18:03:27 -0700
Message-Id: <20210803010331.39453-13-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This information can be used by user space applications to determine how
much headroom is needed for the XDP frame.

igc driver is also changed to add this new information.

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
 include/uapi/linux/ethtool.h                 | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index d3e84416248e..7cfd4eb59234 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -8,6 +8,7 @@
 
 #include "igc.h"
 #include "igc_diag.h"
+#include "igc_xdp.h"
 
 /* forward declaration */
 struct igc_stats {
@@ -156,6 +157,7 @@ static void igc_ethtool_get_drvinfo(struct net_device *netdev,
 		sizeof(drvinfo->bus_info));
 
 	drvinfo->n_priv_flags = IGC_PRIV_FLAGS_STR_LEN;
+	drvinfo->xdp_headroom = XDP_PACKET_HEADROOM;
 }
 
 static int igc_ethtool_get_regs_len(struct net_device *netdev)
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 67aa7134b301..dcf14ad4dccd 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -176,6 +176,8 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
  *	and %ETHTOOL_SEEPROM commands, in bytes
  * @regdump_len: Size of register dump returned by the %ETHTOOL_GREGS
  *	command, in bytes
+ * @xdp_headroom: Size of minimum XDP headroom needed by the driver
+ *	to fill with metadata information.
  *
  * Users can use the %ETHTOOL_GSSET_INFO command to get the number of
  * strings in any string set (from Linux 2.6.34).
@@ -197,6 +199,7 @@ struct ethtool_drvinfo {
 	__u32	testinfo_len;
 	__u32	eedump_len;
 	__u32	regdump_len;
+	__u32	xdp_headroom;
 };
 
 #define SOPASS_MAX	6
-- 
2.32.0

