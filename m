Return-Path: <bpf+bounces-21814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DD8526D9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6064D1F2595B
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504227A73B;
	Tue, 13 Feb 2024 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8Ly2ete"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BA7A705;
	Tue, 13 Feb 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786368; cv=none; b=nsb2AuvEzvKGp5jXbxLQT0mTh9utAwQknuJetxKhV3ikbwl+JiuzX8KEwoe3UaZoHqVZp1FvrcDRsLqwQK6fjwdivp8ESGXCcPy8Ai9kz6vc/aG6QogAaAZhFrhL1dS+rd+tWVT1jmO7koFKUPPIvGK5gVp/lhVgm3z/myVdxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786368; c=relaxed/simple;
	bh=rpCO9f0Omg51h9cA+beqHpVMS/hZzt/qJ2gHgn/cQvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbIqj6STaBpJFntMO/s4ba1s70FiMDkMD29Ct/FK8HTPyGjNO8oooxKQVbnpvCPqH2+g2QqtzKnbtRHiQ+ElQz+rmqTOgeOVXcRwv0dmF5W61OZOm3Rvp6PHIezXfbaayG338B/3vIzd0JiDdocZVr+vSj/Z0pJcmLCT6DE+yZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8Ly2ete; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786367; x=1739322367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpCO9f0Omg51h9cA+beqHpVMS/hZzt/qJ2gHgn/cQvo=;
  b=h8Ly2eteSJGtHueOos/faaOcs0AGryy6hhIV1IkUGD9Wmz1C+bd9eQiP
   abM3prEWkaSPiJ0lCKOzKiOJUZvtgUp4biYCKJD27auLC+F6WUueQB95Y
   TWzjcsRqbbJVdmbz9cp5Qrs9/xu95d8+mbkhj2PiB0u1o4uVLVFAt8Tqp
   IsBnjZYDWd/0x+VI8U3oOyy2KA0+SXu8oBZsJDAWsCFxSHx9qVqX0gIZL
   e+M41vyt+R3JmxPQrci1XhcBO1hoM2ccLpBl+Vds577o1kJD9KUJXUMQl
   yank0wro82uqmAenG7iDmuH+nuX8uzyPL+SwQRP2bzWzCR+N3yFY5NdEy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436927664"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436927664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911651342"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911651342"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2024 17:05:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 4/4] i40e: take into account XDP Tx queues when stopping rings
Date: Mon, 12 Feb 2024 17:05:39 -0800
Message-ID: <20240213010540.1085039-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
References: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Seth reported that on his side XDP traffic can not survive a round of
down/up against i40e interface. Dmesg output was telling us that we were
not able to disable the very first XDP ring. That was due to the fact
that in i40e_vsi_stop_rings() in a pre-work that is done before calling
i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
account.

To fix this, let us distinguish between Rx and Tx queue boundaries and
take into the account XDP queues for Tx side.

Reported-by: Seth Forshee <sforshee@kernel.org>
Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
Tested-by: Seth Forshee <sforshee@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 06078c4d54e8..54eb55464e31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4926,21 +4926,23 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
 void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
-	int pf_q, q_end;
+	u32 pf_q, tx_q_end, rx_q_end;
 
 	/* When port TX is suspended, don't wait */
 	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
 		return i40e_vsi_stop_rings_no_wait(vsi);
 
-	q_end = vsi->base_queue + vsi->num_queue_pairs;
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
-		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
+	tx_q_end = vsi->base_queue +
+		vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
+	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
+		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
 
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
+	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
+	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
 		i40e_control_rx_q(pf, pf_q, false);
 
 	msleep(I40E_DISABLE_TX_GAP_MSEC);
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
+	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
 		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
 
 	i40e_vsi_wait_queues_disabled(vsi);
-- 
2.41.0


