Return-Path: <bpf+bounces-68554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7968CB5A3EB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911C2582429
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721182F656E;
	Tue, 16 Sep 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXsIuqub"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1F2877C1;
	Tue, 16 Sep 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058095; cv=none; b=WLttdX2KPwcVL0UTr42MITGU7GBB21jb8y7KRnWwFSOMNpF2Bi8zv81H8UlLNj2G4voBpAQyVtMoG34nBhnQ3j0CZiEI9zRyU6yfBh2ANKpHGNggCckD1q2O8i3GW/zUJhAUQdaALCFiM+DcfkN3WtnAbudGk+i3sLK+rLugSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058095; c=relaxed/simple;
	bh=BPl166YN21h4BFRWnix944JEgOG8sMF6PNAmKrKcrBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAVYOQEnLDdFidkrOYJVcUwIh21oL59hS3XP2r3w1qc7RcaVpk6rDIyZKOfi5gO2tsE6DI2bzzkK/82dt2Kj92dQQl4GMiHQ5YBY6StEAnD3c++OZfNgLsEAmJMxm1jWtcuT4okj6qOdnBg1Z/o98Ok/tWLbQKnDNewYoHuwAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXsIuqub; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758058094; x=1789594094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPl166YN21h4BFRWnix944JEgOG8sMF6PNAmKrKcrBg=;
  b=AXsIuqubwbVAQyQaTdM4tu/TxWhvGD18Yw5dPHrDtWzFTad05aw7Y++N
   YuRFfMAHW7L9dCOhGtvyzC1Vur3MCYZcXThDHCdVRrbGKTZXrmu0WnOvg
   sXSZQ7TlobMRbIB7PezyQibl2rDaom/qLPS3U27awF8nN2IWgFRTiSRy5
   DIa5CmU2nVPHOP26WuiLGnH8wrtiKF20S69BzWHpFlV3ZJTDK5ZvZQDqD
   FyKljuqdeYVx9f4lBgvQKbn+QaFoCxEMFAVXu0nAdzEGXopvMwrG/CmKv
   x+3XvYix6LMdEcocL88K+/cer7/yhiuwjAAASoDC8Lom4HiTeBnbIm1qG
   Q==;
X-CSE-ConnectionGUID: FCCkk/bzRtqpucxJZ6rJjw==
X-CSE-MsgGUID: VQw+JLLOSMGhUs07s2jHNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60410761"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60410761"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:28:12 -0700
X-CSE-ConnectionGUID: PDMzQmwnQ02uyX/xdzgGZg==
X-CSE-MsgGUID: ZYQ7p8/gS/2u7Oxtu14cyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="180316934"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 16 Sep 2025 14:28:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/5] i40e: remove redundant memory barrier when cleaning Tx descs
Date: Tue, 16 Sep 2025 14:27:57 -0700
Message-ID: <20250916212801.2818440-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
References: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

i40e has a feature which writes to memory location last descriptor
successfully sent. Memory barrier in i40e_clean_tx_irq() was used to
avoid forward-reading descriptor fields in case DD bit was not set.
Having mentioned feature in place implies that such situation will not
happen as we know in advance how many descriptors HW has dealt with.

Besides, this barrier placement was wrong. Idea is to have this
protection *after* reading DD bit from HW descriptor, not before.
Digging through git history showed me that indeed barrier was before DD
bit check, anyways the commit introducing i40e_get_head() should have
wiped it out altogether.

Also, there was one commit doing s/read_barrier_depends/smp_rmb when get
head feature was already in place, but it was only theoretical based on
ixgbe experiences, which is different in these terms as that driver has
to read DD bit from HW descriptor.

Fixes: 1943d8ba9507 ("i40e/i40evf: enable hardware feature head write back")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 048c33039130..b194eae03208 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -948,9 +948,6 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		if (!eop_desc)
 			break;
 
-		/* prevent any other reads prior to eop_desc */
-		smp_rmb();
-
 		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
-- 
2.47.1


