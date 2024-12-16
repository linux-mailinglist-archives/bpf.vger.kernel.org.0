Return-Path: <bpf+bounces-47018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B649F2A62
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6201672F5
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C01D47D9;
	Mon, 16 Dec 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwEj/oPZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C161D47B4;
	Mon, 16 Dec 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331742; cv=none; b=NVDH/uKBUSZTg1gn4+8hR/Va6p57LF8iHFqCc7zH7HkV8xQhOd6w6XdxR5gKGIZuTqaALDg2g03co3CQqvkW9pGkSW82V6wAod0vNSuAaQU1aHQ+Zkj55NImSXU3DfObW9O/Pdi1v35/FHnQ6obdG2Uzsaqj5HtGz6LHkK2m8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331742; c=relaxed/simple;
	bh=sUpWvy7waqLMqKC2ZzjWeENU316ueJf7NUW7IVETNa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvZONle79r4p+YRfbYIsw0iMz3QSwwwBsNP0gxm0eTBXWnE/LYqW/C01WanBDc1m6DOl2ECaXCx+dGqNipvSSgBaqNIy7G5BOym+LIYQuDM3GaAU7t6oRYx4e7rYTP5hr338huPmpj2ZzK57Yvof2aIhTFEE4L5Y7L08ASAKor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwEj/oPZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331741; x=1765867741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUpWvy7waqLMqKC2ZzjWeENU316ueJf7NUW7IVETNa8=;
  b=HwEj/oPZXvJ9Skoegkh5LYNuYpw2Kwzw1CQk+oa35iNPEfc9mb82kPSd
   duLVTkA5kLRoHz1EFudsFWQqNWDslEWAwZStKtS0LyPhjYVB8dwM70ymX
   81AJTYBcgEUhGzV0YgBsVcvfGUrvGq3t01gXfeDSHwZB5FD6NzjFxsn+v
   FgNOMRo+6+dN6Nt/blFG1lKEo+0EDy/QULmqzpadT4ebnZpmaLZ0uttNe
   xC1QPJhJX2RQ610mgz2FSbxy19GazGyjZraeb/0BkO3SwMPiB85AOTgRn
   A8RHnzWBSaHCs4qkIVZVw2AQqb4Qh4kovR58agn3UleinyayZQFnqVPEs
   A==;
X-CSE-ConnectionGUID: Rl01dfFcSrKDz81JvFH6HA==
X-CSE-MsgGUID: K6wSMKxITFGY9fdwb/BGZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848219"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:49:00 -0800
X-CSE-ConnectionGUID: 6MSxneviSSKSdMDRvzs4qA==
X-CSE-MsgGUID: yw7loXtJTqi/klqm2Lxh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101869"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:48:56 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 4/9] igc: Add support for receiving frames with all zeroes address
Date: Mon, 16 Dec 2024 01:47:15 -0500
Message-Id: <20241216064720.931522-5-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

The frame preemption verification (as defined by IEEE 802.3-2018
Section 99.4.3) handshake is done by the driver, the default
configuration of the driver is to only receive frames with the driver
address.

So, in preparation for that add a second address to the list of
acceptable addresses.

Because the frame preemption "verify_enable" toggle only affects the
transmission of verification frames, this needs to always be enabled.
As that address is invalid, the impact in practical scenarios should
be minimal. But still a bummer that we have to do this.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 17 +++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.c  |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 34a6e4d8a652..480b54573d60 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -734,6 +734,7 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 				      u32 location);
 int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter);
 struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 05146cc1b92c..3f0751a9530c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3962,6 +3962,23 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return 0;
 }
 
+/**
+ * igc_enable_empty_addr_recv - Enable rx of packets with all-zeroes MAC address
+ * @adapter: Pointer to the igc_adapter structure.
+ *
+ * Frame preemption verification requires that packets with the all-zeroes
+ * MAC address are allowed to be received by IGC. This function adds the
+ * all-zeroes destination address to the list of acceptable addresses.
+ *
+ * @return: 0 on success, negative value otherwise.
+ */
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter)
+{
+	u8 empty[ETH_ALEN] = { };
+
+	return igc_add_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, empty, -1);
+}
+
 /**
  * igc_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index f0213cfce07d..5cd54ce435b9 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -434,6 +434,8 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	unsigned int new_flags;
 	int err = 0;
 
+	igc_enable_empty_addr_recv(adapter);
+
 	new_flags = igc_tsn_new_flags(adapter);
 
 	if (!(new_flags & IGC_FLAG_TSN_ANY_ENABLED))
-- 
2.25.1


