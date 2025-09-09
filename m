Return-Path: <bpf+bounces-67936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46640B50721
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB9A543249
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659D35CEB2;
	Tue,  9 Sep 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtY8XwGy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251542E1746;
	Tue,  9 Sep 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449964; cv=none; b=LFwQMtKKyzRR/yrrP+4i42SlFyqTBSSZ8y25Kcl+opMOQEo7GZYlhaF1vX4oTtlfPtwj+o8eDhw6kh1USzr9YNVJFOU/GXevEOnJMhAcKj06zixHHnmlXWiy+A6AN6ZEdnMxydI3BGfJMZ1i/Mo7SZ9K8zvMLpL+91u41buw7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449964; c=relaxed/simple;
	bh=VAI0WXbXUb5x9r3u4rQKLO6ou4RNUkmvBE8iI+zQUTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlOlg1koGbVBSc15ZUOXuIzkKzgSKo+/nae+lOjVbYwyNIQ3XSe/pC591P9FiZnLpqeharuj9nPKNAiJRgoUWF2eW3poQ1kw94L3PZt0eVLfThyoAnoCbSQRBQitp5NyqxeuFuqt8GCY3yAsM/bULxSJ52TkceGDb/GPZcF5nOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtY8XwGy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757449963; x=1788985963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAI0WXbXUb5x9r3u4rQKLO6ou4RNUkmvBE8iI+zQUTM=;
  b=LtY8XwGyR0lbhEeqAmMLTu5b7lb0Ssml8NXc18oHPZBPdyLk/c97nBDD
   uH8nBj41LGv8nKeMqkMrLWZbW35/dvb779Ia8oVJg/M7mvrvyxq+dumRi
   D/2eMhTXEizFp9CDZLIfhKxvx7c+2jrDtMoxee9EraD0hBeGPVy4/8olV
   +L4J4VRA70EpOEvuw3P4vOJGPtiASAu7AdcFbrRqmVm47FfUcm4MbTDnD
   CzmBADDLVBwZZtJJZvbrRla5UIFG2sVske7f8+EGQujQ8r/DCVDkdAMM1
   r7Q3AZXWXi2R64fFb4Ng3wwFNPWn1InedsSjNxi46FsBgtyfZDTyL6SU/
   g==;
X-CSE-ConnectionGUID: HXhtTh7FRVGubFXicgsu9A==
X-CSE-MsgGUID: 3pjQxB6tQbubOaRIrsL4bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59606757"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59606757"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:32:41 -0700
X-CSE-ConnectionGUID: N005NoPbQnSwMNb53EdE4g==
X-CSE-MsgGUID: Fsb2p+UnQ1K6zj85stz/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173287025"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2025 13:32:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tianyu Xu <tianyxu@cisco.com>,
	anthony.l.nguyen@intel.com,
	xtydtc@gmail.com,
	kurt@linutronix.de,
	sriram.yagnaraman@ericsson.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joe Damato <joe@dama.to>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/4] igb: Fix NULL pointer dereference in ethtool loopback test
Date: Tue,  9 Sep 2025 13:32:31 -0700
Message-ID: <20250909203236.3603960-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
References: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Xu <tianyxu@cisco.com>

The igb driver currently causes a NULL pointer dereference when executing
the ethtool loopback test. This occurs because there is no associated
q_vector for the test ring when it is set up, as interrupts are typically
not added to the test rings.

Since commit 5ef44b3cb43b removed the napi_id assignment in
__xdp_rxq_info_reg(), there is no longer a need to pass a napi_id to it.
Therefore, simply use 0 as the last parameter.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae61e..453deb6d14b3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index,
-			       rx_ring->q_vector->napi.napi_id);
+			       rx_ring->queue_index, 0);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
-- 
2.47.1


