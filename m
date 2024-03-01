Return-Path: <bpf+bounces-23184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B686E97B
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318BE287620
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B93B788;
	Fri,  1 Mar 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcYk0mjy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FD3A8C2;
	Fri,  1 Mar 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321161; cv=none; b=mD7XBJapfbCITkTNTKPa7Yz+iwF66ynqSsEkOCLH07YeW/8WyOcVu84B/kvXcf4HvDJOkdNPQs5NWcSQeBImHTQ00t2cRgp9SSLnRAL7pxfbR2cH0MxHReHy0lt1Yi6EMGMwWNGQkn+pIgRlR/m16ReadEafayrC7ye1zx1V8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321161; c=relaxed/simple;
	bh=VcbcKSi/es/05E/oFavKkRKAz4CVUSVpneEhHwb43T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZjsRfsuXA9QEzViGeZqpiDZ8SNJdX1dsMci4o1zI88mbKldbwJD+IBLPhdjeCz5sMrwLrPVY7iZPQvteeSnT4n1y5dqpeuqczZLz/zytIBjrR80YkzHcEOIsnaGAs3ksqsdTEikU+02Dcqb8DBlVtCGpMXAeC1O52Xgr04EoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcYk0mjy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709321159; x=1740857159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcbcKSi/es/05E/oFavKkRKAz4CVUSVpneEhHwb43T8=;
  b=gcYk0mjydYsHEHbCoQDVuSL0ulUFBe7SSsqDGn16ilNUkZCjBVFonnej
   SBmXrpRD20wgDbVLAGlJ8Urk/NcsrIt6LvLAD0JMqWaz6roSpskPkRdkj
   7jt9RaW2Ud1C8QMr4Aya4cQ6ZEtPLYOp2zTuQnjgTCNE8SIpVhUw5wvdQ
   pmX4GZXEC3w3evump1EqXcyaCmf2u5DEWWVtpjjLwfrh8a2sj67VHTUIQ
   FpFNnWtAPNyvS0/YLeBD8S9X9EfX4dW2kNy+ZTrwRFelulR4bWr8kpRcU
   79yd/c4VbpH/mzHIMIBr51ciVZwip7jQW2u7LRhU7eB9C8qlYBs8NZMAS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7694922"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7694922"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12998474"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 11:25:56 -0800
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
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 2/4] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Fri,  1 Mar 2024 11:25:47 -0800
Message-ID: <20240301192549.2993798-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
References: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Disable NAPI before shutting down queues that this particular NAPI
contains so that the order of actions in i40e_queue_pair_disable()
mirrors what we do in i40e_queue_pair_enable().

Fixes: 123cecd427b6 ("i40e: added queue pair disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 54eb55464e31..89a3401d20ab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13560,9 +13560,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
-- 
2.41.0


