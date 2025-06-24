Return-Path: <bpf+bounces-61395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F1AE6CBC
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219B73A0134
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CC2E6D03;
	Tue, 24 Jun 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdsJohrU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1102E62CD;
	Tue, 24 Jun 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783549; cv=none; b=gbHX14gcUXDxPh2fXb3mMGSYu2m6PFDALdUybLzr060kLOVp90tx+Qe8BcHOTYvY41r/J5sJsgQJuy32Duwe43Nx0a0zYYeB3m643coa9XIBnsF8BL8CVD6FvyEFBIdzz4kvTAGMZYqNk5x+saIRvadlNTJgPZ4zEprwRLkfDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783549; c=relaxed/simple;
	bh=r8WPfcvVmcBUTSmYNEXw6s82WdS/cusWfHrCEVEYrgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flz6u+XJboBgz1MzimAN5hCxx9eM3kOyx4Q5++lj9MTSenH67MfsZ3VswstqiL2pUQAFFrr9bxjK/ujcN2t/60pjK8NYZRqpz+GoZ5ONLgMVGhtR+B5yicrRKN+h9dPc0UXMY/IqB/Lr17v/w4pCJz1JJ+IRKLln0NUNXwXEyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdsJohrU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750783548; x=1782319548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8WPfcvVmcBUTSmYNEXw6s82WdS/cusWfHrCEVEYrgo=;
  b=PdsJohrUdhN7NyLNTPgarDHxb3L8XNunYLcEXUWIcohAY+QsyfZf7VGh
   sfCE4AnPDXoqGqKqqgmNb/sIamVON2pV3FScdJmrwvg504BYWSbCPQJbk
   JIxQdIVB9LdNZ+D3ci0j6JthJXQZMn/+kf7p5ohVW3GhaHFrO6bK6449O
   84OC6cPtnyxs4+ypcscuY6sDXJ2ANbNwN+/0Yxkw/wqsAR9JqWe4vYkr+
   FgRJnDbyMbodCfKQ75MN/2J6s0TgDy99oWpPNvpl3jJMkxfPHiuKYjsqU
   L+enWX1mOX21zi1fIzll8pAJ3LsmItwoFNBDdgRNXR7gISa3h6E2vnk7B
   w==;
X-CSE-ConnectionGUID: Vz0xM13zTUWXCoMx5L++fw==
X-CSE-MsgGUID: 6jhD1AnqQvOTFfdR/OUumA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64091148"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64091148"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:45:47 -0700
X-CSE-ConnectionGUID: OxvfbUtoSGe1NIgaO2j8EQ==
X-CSE-MsgGUID: W/l9vzTSQJqOA1BN31B5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="152669450"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2025 09:45:44 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 02/12] idpf: use a saner limit for default number of queues to allocate
Date: Tue, 24 Jun 2025 18:45:05 +0200
Message-ID: <20250624164515.2663137-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
References: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the maximum number of queues available for one vport is 16.
This is hardcoded, but then the function calculating the optimal number
of queues takes min(16, num_online_cpus()).
In order to be able to allocate more queues, which will be then used for
XDP, stop hardcoding 16 and rely on what the device gives us. Instead of
num_online_cpus(), which is considered suboptimal since at least 2013,
use netif_get_num_default_rss_queues() to still have free queues in the
pool.
nr_cpu_ids number of Tx queues are needed only for lockless XDP sending,
the regular stack doesn't benefit from that anyhow.
On a 128-thread Xeon, this now gives me 32 regular Tx queues and leaves
224 free for XDP (128 of which will handle XDP_TX, .ndo_xdp_xmit(), and
XSk xmit when enabled).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 8 +-------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 0ba766fe4f26..875ed4054268 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1243,13 +1243,7 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 		num_req_tx_qs = vport_config->user_config.num_req_tx_qs;
 		num_req_rx_qs = vport_config->user_config.num_req_rx_qs;
 	} else {
-		int num_cpus;
-
-		/* Restrict num of queues to cpus online as a default
-		 * configuration to give best performance. User can always
-		 * override to a max number of queues via ethtool.
-		 */
-		num_cpus = num_online_cpus();
+		u32 num_cpus = netif_get_num_default_rss_queues();
 
 		dflt_splitq_txq_grps = min_t(int, max_q->max_txq, num_cpus);
 		dflt_singleq_txqs = min_t(int, max_q->max_txq, num_cpus);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 24febaaa8fbb..29cd3da6376d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -909,7 +909,7 @@ int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
 	max_tx_q = le16_to_cpu(caps->max_tx_q) / default_vports;
 	if (adapter->num_alloc_vports < default_vports) {
 		max_q->max_rxq = min_t(u16, max_rx_q, IDPF_MAX_Q);
-		max_q->max_txq = min_t(u16, max_tx_q, IDPF_MAX_Q);
+		max_q->max_txq = min_t(u16, max_tx_q, IDPF_LARGE_MAX_Q);
 	} else {
 		max_q->max_rxq = IDPF_MIN_Q;
 		max_q->max_txq = IDPF_MIN_Q;
-- 
2.49.0


