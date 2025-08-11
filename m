Return-Path: <bpf+bounces-65350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703CB211B0
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687E618896D3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23782E11C3;
	Mon, 11 Aug 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgaSo/aU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F82E093E;
	Mon, 11 Aug 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928775; cv=none; b=RJBZP/kfOMljP2TkQ1CsP0BFoKi56WLxH2QK9FWxYChvotDxFykuV5g0ZYUmxnshd4vfZO+4gTU5pawr7sNk3oHB52jHuCjywyJJqwP6TpHlW2f8zXxpEluFR5hN41ecr408ySgvaZEd7qrhU7dXiGcS7XIGesEy7Kl22oQTGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928775; c=relaxed/simple;
	bh=BSD20DJHskwQfGIbjfi2O55r65lbLUrLXZlFj/S3YHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnO7sJGOsuVeq641GElvSOaqPUYzGDRtniyq9WoEv6753VsPkQ8CGKMSD3ErXozLWg7cYf3tgIB1qYMA7aYFiry1voAeSFIourFKYG5Ewy33vXSHPeDQOwkI94QjvwwG/TZIAZkYluW/nsE3Sev28HEeLoORICkNe0eh6RIBMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgaSo/aU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928774; x=1786464774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSD20DJHskwQfGIbjfi2O55r65lbLUrLXZlFj/S3YHQ=;
  b=bgaSo/aUbBhd53F1A93oVu318tDGbNPBEKS8jtbJ1L4hOKbjFml8+/Hq
   E+1XGvIGSrNRBaW0v/ldcyrLfi30vInSTz8M/ej72iVk1GKQwIZDoCXsV
   X5iLzNXWi+vexq5g5JuJBykrj6q9LJ5E4kiXuiJVnhaofgmhtv3rX3K63
   h6kkcgbfL/woJSfDrxsyxGpIa4hiHB6qFp6ZXb3EddUn9w7l+o391wMl8
   phwZU/hizKeFbV6xDNZn021M2FdXHv4x8AYzkSABDFMI3G3CNpjf4Qv96
   tRAXPNM3OvLjP5mp8EwhkCzyez1OmWnlAGmBWDg9x3HfEq3Qf/ODfoyag
   w==;
X-CSE-ConnectionGUID: u67W0dnqR++VpDf4seFHFw==
X-CSE-MsgGUID: KC0eckiRQdq/A0gCKYhydA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899547"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899547"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:12:53 -0700
X-CSE-ConnectionGUID: qpIOcC7lTFuVHqUg1/P11A==
X-CSE-MsgGUID: 0PK4GSW8REiYhzaAqx+vcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163160"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:12:49 -0700
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
Subject: [PATCH iwl-next v4 02/13] idpf: fix Rx descriptor ready check barrier in splitq
Date: Mon, 11 Aug 2025 18:10:33 +0200
Message-ID: <20250811161044.32329-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
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
index 68b3857c803b..72459fc1af79 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3186,18 +3186,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
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
2.50.1


