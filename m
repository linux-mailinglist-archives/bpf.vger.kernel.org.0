Return-Path: <bpf+bounces-10761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C37ADDC6
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 19:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A5F2F281830
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAA720B2C;
	Mon, 25 Sep 2023 17:23:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00B10962;
	Mon, 25 Sep 2023 17:23:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6ABC;
	Mon, 25 Sep 2023 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695662596; x=1727198596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hT6cdN4DI/JlLRo4tGR4SLBS9vPB7fNcPUjEDnZP6r8=;
  b=m16yX1docmmvliLFoY4p5GCNYRmbZxHAR3lpwK6PQTxkZv8dYitKE35M
   DaElFzMYebXCvPzPvbtYdGklqsZ/DSbK9r8K2nPrtvtFtMc/NRqEqkNZz
   MFnyCU3ebng0Nu63NFBLwCHL42dUp9TOU1ITBVnaBC4Q+m0FV+SqETisb
   vg9NBQSNyhn4DywBO6zxJqwmfONzJO/g9RruDs3fMAafdOp4lj5nwKB6p
   1unJmSQnCHZRVRXv193ZyvgxYmiHvyNpYaFdU7dr6kzQDuVJtfcZBp99/
   8BusmbPf5wqNP8iOYiqmvHHUOgzy0xxaLbX5vHZ8G5EuUWbqeivA9Db+6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412235618"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="412235618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777743198"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="777743198"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2023 10:20:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kamil Maziarz <kamil.maziarz@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net] ice: don't stop netdev tx queues when setting up XSK socket
Date: Mon, 25 Sep 2023 10:19:57 -0700
Message-Id: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kamil Maziarz <kamil.maziarz@intel.com>

Avoid stopping netdev tx queues during XSK setup by removing
netif_tx_stop_queue() and netif_tx_start_queue().
These changes prevent unnecessary stopping and starting of netdev
transmit queues during the setup of XDP socket. Without this change,
after stopping the XDP traffic flow tracker and then stopping
the XDP prog - NETDEV WATCHDOG transmit queue timed out appears.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 2a3f0834e139..cec492b827d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,7 +179,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
@@ -268,7 +267,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
-	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 free_buf:
 	kfree(qg_buf);
 	return err;
-- 
2.38.1


