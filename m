Return-Path: <bpf+bounces-47015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AC9F2A57
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BF3166F8D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C31CEE9A;
	Mon, 16 Dec 2024 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RctacwlT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3331CEAB2;
	Mon, 16 Dec 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331730; cv=none; b=sAGnUETsLd2q6vbocmC+r/2yoT2iU0Q0tzVDVow4v4lT64AlQtAnUm5Pk50AsFOOZChVW5WDCN5x6VNwuePLs7T5OZQATKEz48pojHsUkQpm19yMtyn8R7e89kyYAAWyP4ur40vB/7K9bDW/fI84edZfWSWnJCFr8v4voUxow58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331730; c=relaxed/simple;
	bh=xwG7KILTeH2AI6bM+wQIURzWAR71Cye3Uil/wuyYQO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3rz4sd2IXuwF9cvcIP1r36DR1KbrOq9e3jwVvM+GkpjI2L3doI/NboUnzUJry0BMyAMmwUkaFHwDg4AEFPA56QgHusJAUyp6HomjxtBzlGLOMFF2MaldrMnDnOwxFTfpvMofw3xJ3EzC/GgG14GA6NcxRcyNKgEHnZ4cz7L8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RctacwlT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331729; x=1765867729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwG7KILTeH2AI6bM+wQIURzWAR71Cye3Uil/wuyYQO4=;
  b=RctacwlT+3ffSdXU7qvmmwrWcSh8Agjqkjw0I9f8t+xwaO0i69R7hAD1
   lfyGBVtb7YmNGT7mx/osnIXMQIWhc2WcQSwdzvdD37frVQ23mL7EmG/wk
   UYYfbHtXhHQCokiwUW508nlHdzLOQGJNaCGjzVVbta+LlOrHKN2iHnVV/
   TK8TM0HAEeVCsT4S6ULq+NQHMv8+PSxtjRllDIsugLSB7wTeESerOemx3
   ImrV/YviouwA/nEE9bHQqj7WV5fB39p5Ih+xehClS1Qi6dCBhVgt9Op+U
   I/tfHk+MsXyAEXIDSimL4sDabW5u6W5f2Wv/i/MLGhJAHwq5et5/hGJZW
   A==;
X-CSE-ConnectionGUID: 4xtkTtILTQ6dh5WHvS9N7g==
X-CSE-MsgGUID: I4TpjHfxTeedfdKEQu5szw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848186"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:48:48 -0800
X-CSE-ConnectionGUID: KqO2hNatSv6FE6QkJLzNMw==
X-CSE-MsgGUID: I99YYVVuRpOEkmMLJ/QDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101840"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:48:45 -0800
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
Subject: [PATCH iwl-next 1/9] igc: Rename xdp_get_tx_ring() for non-xdp usage
Date: Mon, 16 Dec 2024 01:47:12 -0500
Message-Id: <20241216064720.931522-2-faizal.abdul.rahim@linux.intel.com>
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

Renamed xdp_get_tx_ring() function to a more generic name for use in
upcoming frame preemption patches.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..34a6e4d8a652 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -734,7 +734,7 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 				      u32 location);
 int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
-
+struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..05146cc1b92c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2448,8 +2448,8 @@ static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
 	return -ENOMEM;
 }
 
-static struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter,
-					    int cpu)
+struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter,
+				 int cpu)
 {
 	int index = cpu;
 
@@ -2473,7 +2473,7 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	if (unlikely(!xdpf))
 		return -EFAULT;
 
-	ring = igc_xdp_get_tx_ring(adapter, cpu);
+	ring = igc_get_tx_ring(adapter, cpu);
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
@@ -2551,7 +2551,7 @@ static void igc_finalize_xdp(struct igc_adapter *adapter, int status)
 	struct igc_ring *ring;
 
 	if (status & IGC_XDP_TX) {
-		ring = igc_xdp_get_tx_ring(adapter, cpu);
+		ring = igc_get_tx_ring(adapter, cpu);
 		nq = txring_txq(ring);
 
 		__netif_tx_lock(nq, cpu);
@@ -6677,7 +6677,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-	ring = igc_xdp_get_tx_ring(adapter, cpu);
+	ring = igc_get_tx_ring(adapter, cpu);
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
-- 
2.25.1


