Return-Path: <bpf+bounces-47021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200729F2A6A
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FA1631A0
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A561D61BC;
	Mon, 16 Dec 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTRjnVkG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE001D5AB8;
	Mon, 16 Dec 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331754; cv=none; b=OQ6HtafFyyuOyM5fRVHCkfFqndPmy5QwQijlu+RZtEakyL9xxfE4sat0Em3Oyqp1+L+/staQyfe4MHg76bZzTo7/QyXlRYIPNolG+9+s8QPgXsqNh6oAxBWa1ZZCM1WrxVs61g5IEOOPgYQAk1mhfiZkDdIKpyZLwWp6cKZ7x+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331754; c=relaxed/simple;
	bh=jkHNJJkIGIVWZcBBHLMo8Ei+M8xuX0/Qa97bdETj9YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/0mS9fXm2fAiCELTsnypfyUqKNZomAx6vgcaJDwBKN6Sbc5o0RJP9+q2qa3Z4P2kZAPgZMfJoblvZbNiivJInBFROJW0LmRo/pIBRKlG+WpubCFk2DILp3GaCGabNayNMiovopJnF9dwzBKy8nNGouWGru+Gyf4ZcHTCnAWGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTRjnVkG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331753; x=1765867753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jkHNJJkIGIVWZcBBHLMo8Ei+M8xuX0/Qa97bdETj9YQ=;
  b=eTRjnVkGajv5fd0d++Y6gC5qKYpWN2nTfXJhvuxtWJmDOp/AfIFThxNO
   494ZdIAwkoXS5LnrmnAL3IcRO6B8q5/AnADMhjILAxIuMa9Hb8rfnKKUw
   h8MtNEyt72DAsKdssotr7HbDQwAcRO0UnM2RkuqbOicPLkp5jPNBkZt1F
   trzH9oPwu21JEWWjxhVMZ9vTotOOYnJ+pRe7hCt7MdRqy7Dl5YPD4kvfJ
   FseohzGSHEuS+gpgdXpKWrIf1ZAJMuMOb1EAHXwhIhHRxm5wdkYbKKncs
   b6Y+bLtfFuVF4wPEEQ19/rRCeRH5pJmHfgXG/YoF2JPrEWah0Tyu07DtO
   Q==;
X-CSE-ConnectionGUID: XSlBaCYATVCWhCEG8/ZBZA==
X-CSE-MsgGUID: SpXSEraOQdiKilrDiaO1Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848255"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848255"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:49:13 -0800
X-CSE-ConnectionGUID: xidStsfWS/ScD6XUaQ9Lug==
X-CSE-MsgGUID: xARQ7+miTzGzAo0jOlkBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101895"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:49:09 -0800
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
Subject: [PATCH iwl-next 7/9] igc: Add support for preemptible traffic class in taprio
Date: Mon, 16 Dec 2024 01:47:18 -0500
Message-Id: <20241216064720.931522-8-faizal.abdul.rahim@linux.intel.com>
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

Set queue as preemptible or express for taprio.
This will eventually set queue-specific preemptible field in TXQCTL
register.

A preemptible queue can only be set if it satisfies the conditions in
igc_fpe_is_tx_preempt_allowed(), including the verification handshake
condition. However, the handshake is optional, as users can disable the
"verify_enabled" field, which the function also handles.

Verified that the correct preemptible hardware queue is set using the
following commands:

a) 1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace dev enp1s0 parent root handle 100 \
     taprio num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
     queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
     fp E E P P

b) Non-1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace  dev enp1s0 parent root handle 100 \
     taprio num_tc 3 map 0 1 1 1 2 0 0 0 0 0 0 0 0 0 0 0
     queues 2@0 1@2 1@3
     fp E P P

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 36 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 15 ++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 56a426765be7..fc1960925e28 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -192,7 +192,7 @@ struct igc_ring {
 	bool launchtime_enable;         /* true if LaunchTime is enabled */
 	ktime_t last_tx_cycle;          /* end of the cycle with a launchtime transmission */
 	ktime_t last_ff_cycle;          /* Last cycle with an active first flag */
-
+	bool preemptible;               /* True if not express */
 	u32 start_time;
 	u32 end_time;
 	u32 max_sdu;
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index ba96776d5854..33c2e4ce7cc8 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -557,6 +557,7 @@
 #define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
 #define IGC_TXQCTL_STRICT_CYCLE		0x00000002
 #define IGC_TXQCTL_STRICT_END		0x00000004
+#define IGC_TXQCTL_PREEMPTIBLE		0x00000008
 #define IGC_TXQCTL_QAV_SEL_MASK		0x000000C0
 #define IGC_TXQCTL_QAV_SEL_CBS0		0x00000080
 #define IGC_TXQCTL_QAV_SEL_CBS1		0x000000C0
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e184959ef218..2787a91965d1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6216,6 +6216,39 @@ static bool is_base_time_past(ktime_t base_time, const struct timespec64 *now)
 	return timespec64_compare(now, &b) > 0;
 }
 
+static u32 igc_map_tc_to_queue(const struct igc_adapter *adapter,
+			       unsigned long preemptible_tcs)
+{
+	struct net_device *dev = adapter->netdev;
+	u32 i, queue = 0;
+
+	for (i = 0; i < dev->num_tc; i++) {
+		u32 offset, count;
+
+		if (!(preemptible_tcs & BIT(i)))
+			continue;
+
+		offset = dev->tc_to_txq[i].offset;
+		count = dev->tc_to_txq[i].count;
+		queue |= GENMASK(offset + count - 1, offset);
+	}
+
+	return queue;
+}
+
+static void igc_save_preempt_queue(struct igc_adapter *adapter,
+				   const struct tc_mqprio_qopt_offload *mqprio)
+{
+	u32 preemptible_queue = igc_map_tc_to_queue(adapter,
+						    mqprio->preemptible_tcs);
+
+	for (int i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		tx_ring->preemptible = preemptible_queue & BIT(i);
+	}
+}
+
 static bool validate_schedule(struct igc_adapter *adapter,
 			      const struct tc_taprio_qopt_offload *qopt)
 {
@@ -6302,6 +6335,7 @@ static int igc_qbv_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+		ring->preemptible = false;
 	}
 
 	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
@@ -6458,6 +6492,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 			ring->max_sdu = 0;
 	}
 
+	igc_save_preempt_queue(adapter, &qopt->mqprio);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 3d39be2219f3..efd2a9f676d8 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -209,6 +209,17 @@ void igc_fpe_init(struct fpe_t *fpe)
 	fpe->tx_min_frag_size = IGC_TX_MIN_FRAG_SIZE;
 }
 
+static bool igc_fpe_is_verifed(const struct fpe_t *fpe)
+{
+	return (fpe->verify_enabled && fpe->verify_state == VERIFIED);
+}
+
+bool igc_fpe_is_tx_preempt_allowed(const struct fpe_t *fpe)
+{
+	return (fpe->pmac_enabled && fpe->tx_enabled &&
+		(igc_fpe_is_verifed(fpe) || !fpe->verify_enabled));
+}
+
 void igc_fpe_verify_enabled_changed(struct fpe_t *fpe)
 {
 	if (fpe->verify_enabled && fpe->tx_enabled) {
@@ -539,6 +550,10 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		if (ring->launchtime_enable)
 			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
 
+		if (igc_fpe_is_tx_preempt_allowed(&adapter->fpe) &&
+		    ring->preemptible)
+			txqctl |= IGC_TXQCTL_PREEMPTIBLE;
+
 		/* Skip configuring CBS for Q2 and Q3 */
 		if (i > 1)
 			goto skip_cbs;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index f3d83fbbd1f4..2b67ecae99c9 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -14,6 +14,7 @@
 
 int igc_fpe_get_smd_type(__le32 status_error);
 void igc_fpe_init(struct fpe_t *fpe);
+bool igc_fpe_is_tx_preempt_allowed(const struct fpe_t *fpe);
 bool igc_fpe_is_verify_or_response(int smd_type, unsigned int size);
 void igc_fpe_preprocess_verify_response(struct fpe_t *fpe, int smd_type);
 void igc_fpe_verify_enabled_changed(struct fpe_t *fpe);
-- 
2.25.1


