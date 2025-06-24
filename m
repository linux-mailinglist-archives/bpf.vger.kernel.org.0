Return-Path: <bpf+bounces-61394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0AAE6CB5
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980965A6EC8
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D62E62A1;
	Tue, 24 Jun 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWCUzWJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1D2E3B18;
	Tue, 24 Jun 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783546; cv=none; b=jXyvlEXm496j84uTnRKB6X2QlII6obSVy6xybDK47Rvf2WtlHGwvzxSQOapn8dqpqPRYqgU5Jm/4/dtS5bAHWWJhPefrq9cQxG6y9x5b7wt8xFyOOoEpEEkBifB2qoJ9Hlt1YJk5PLAc8bWo/LGXuy2vj7feinMX4sy2mGL/6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783546; c=relaxed/simple;
	bh=+Eq8L4mwgYsDhXBoNMhH/D2yI9FKq8xBEzywIz+DqFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma9Kbgh8TEMGlum+dOgyezp4hGY7BVj7W75FK11QD9Lwh8qSqZJ6hy3MpoIb29ThbphAQcuYgWsIVugAf+uqcfGw2h4VT2aH5GuMieBx6GXdvtk9s5d/iqpS/cJiC+6dvoOtlAMw/wyfJXZYB9naslSeGillx7jl4VP4KpwG4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWCUzWJ4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750783544; x=1782319544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Eq8L4mwgYsDhXBoNMhH/D2yI9FKq8xBEzywIz+DqFY=;
  b=GWCUzWJ441G2hlY4o3r2tMnj3P4YrHopMzGmiD6XKb/i2OUWeKjTPk0+
   Kae07lsCQ/TWiHoRN79y8PjbTQ5ddF/MSxkPVEv9zhUPDbJbL43wFSVKj
   dWHpLigXtLM1w8YGymr4GTcWdGii3usN6la+X72dWI+BA5ueeMrSFCE9y
   6iOi3MwbW0ZCKZ5ZnypOFjFpsiKPbkdMBLYo/AclxHv9knEMCHMwMfNKq
   XAr5/kceG0E23/W+IY55KuZgp09PQPP3IHbcFPMmRWnp36ETPlqltZLqX
   umzC1CzO6+y73fzxXLQPy/Iajua50D0sq4ThEIW1NkQ9sqcZY2ZXJc+I1
   A==;
X-CSE-ConnectionGUID: mkVxbqHYRKaukrUyQj2jHw==
X-CSE-MsgGUID: xfhhP1QuSy6CCN3KX9MMIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64091133"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64091133"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:45:44 -0700
X-CSE-ConnectionGUID: VsZVGxx+RNubcTiNb1vhuA==
X-CSE-MsgGUID: DyIp5x6oT6OdOXAfbYpaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="152669444"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2025 09:45:40 -0700
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
Subject: [PATCH iwl-next v2 01/12] idpf: fix Rx descriptor ready check barrier in splitq
Date: Tue, 24 Jun 2025 18:45:04 +0200
Message-ID: <20250624164515.2663137-2-aleksander.lobakin@intel.com>
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

No idea what the current barrier position was meant for. At that point,
nothing is read from the descriptor, only the pointer to the actual one
is fetched.
The correct barrier usage here is after the generation check, so that
only the first qword is read if the descriptor is not yet ready and we
need to stop polling. Debatable on coherent DMA as the Rx descriptor
size is <= cacheline size, but anyway, the current barrier position
only makes the codegen worse.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index cef9dfb877e8..0ba766fe4f26 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3376,18 +3376,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
 
-		/* This memory barrier is needed to keep us from reading
-		 * any other fields out of the rx_desc
-		 */
-		dma_rmb();
-
 		/* if the descriptor isn't done, no work yet to do */
 		gen_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
 				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
-
 		if (idpf_queue_has(GEN_CHK, rxq) != gen_id)
 			break;
 
+		dma_rmb();
+
 		rxdid = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RXDID_M,
 				  rx_desc->rxdid_ucast);
 		if (rxdid != VIRTCHNL2_RXDID_2_FLEX_SPLITQ) {
-- 
2.49.0


