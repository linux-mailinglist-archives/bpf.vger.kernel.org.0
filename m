Return-Path: <bpf+bounces-9952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7B79F0DF
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 20:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C5F28158C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9E200D7;
	Wed, 13 Sep 2023 18:06:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC6200B8;
	Wed, 13 Sep 2023 18:06:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5306E19AF;
	Wed, 13 Sep 2023 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628398; x=1726164398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WlYbkPJZkUce+Ge4UcLmtKXlVZSqkCwT2W6g3hDwPqM=;
  b=UnOBtai6lCKyyjQGFscZgWwg3tcOtrs5KMfCGJuNoHLC8Kmm1oV82a+N
   OBjwlR2T5jMmJd8YqNz42rTNM7/5HRtUyEOSoFhWoIt/I7qANX5wha5Gy
   riDwB0cYrmsiTt8u/r61NSXaLr7tx/4pLwy0bghh6D93j9yyLluTrWFdy
   Qpq+bNJwV6W0vx9slKJaEADDarnqhUrgDLN9JoW1BFOrXuRMujq26YLP8
   X9gd4iE/IXmV+UpFVG1Q8jzCWmyOvQBHjrJ3Be4uzlGDXyjwwT07b1kRl
   SeagyvxfzyWts1p7VD2Ao7SHZ/1RQhAWQWekWMCLG7Kq/pT3bhpZCfq5y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378659437"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378659437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747418209"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747418209"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 11:06:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Ferenc Fejes <ferenc.fejes@ericsson.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] igc: Fix infinite initialization loop with early XDP redirect
Date: Wed, 13 Sep 2023 11:06:15 -0700
Message-Id: <20230913180615.2116232-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

When an XDP redirect happens before the link is ready, that
transmission will not finish and will timeout, causing an adapter
reset. If the redirects do not stop, the adapter will not stop
resetting.

Wait for the driver to signal that there's a carrier before allowing
transmissions to proceed.

Previous code was relying that when __IGC_DOWN is cleared, the NIC is
ready to transmit as all the queues are ready, what happens is that
the carrier presence will only be signaled later, after the watchdog
workqueue has a chance to run. And during this interval (between
clearing __IGC_DOWN and the watchdog running) if any transmission
happens the timeout is emitted (detected by igc_tx_timeout()) which
causes the reset, with the potential for the infinite loop.

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 293b45717683..98de34d0ce07 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6491,7 +6491,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	struct igc_ring *ring;
 	int i, drops;
 
-	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
-- 
2.38.1


