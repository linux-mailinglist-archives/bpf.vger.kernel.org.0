Return-Path: <bpf+bounces-17519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D180ECAA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D460C281511
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BA61662;
	Tue, 12 Dec 2023 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ca9ke87w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7057EA;
	Tue, 12 Dec 2023 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702385885; x=1733921885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UiwvDZZEBGN+l/sEs2EZd8sLOX+zt/DQye+jA7flp2s=;
  b=Ca9ke87wNAQ3VfhCb1OxfJ2qO7woFpW87Uh3cKfzpGX7kwaGhaZnPiuy
   1OB6WFEFs4/s25aGNXYYGPWptFq3yf3JSS/1fK3t3PUWPLcGG3LdV6g1L
   zl3aRIit3ODKF6EZx01Rh8elU0zp9aBPapKycxVpz7IW7ZNQXhJVyaTJ2
   qiRYWyJjbHhsbLUVzxQOpCIuc7TYqDaREK+utw/1u8qrugrej1a+Bb6Nj
   3XX+WppY+qR6lz9J5Ypp2iR8pYqxNS7oxyg0OR7eT16BZSPMuQT2mQZRw
   D4BOwvaNyDyABo0P6I3AtCbAg3H7KFeXAc6igaegwayijvhB98j8tZAm3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394549046"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="394549046"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896912336"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896912336"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 04:58:02 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org
Subject: [PATCH v2 bpf 1/3] xsk: recycle buffer in case Rx queue was full
Date: Tue, 12 Dec 2023 13:57:11 +0100
Message-Id: <20231212125713.336271-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231212125713.336271-1-maciej.fijalkowski@intel.com>
References: <20231212125713.336271-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing xsk_buff_free() call when __xsk_rcv_zc() failed to produce
descriptor to XSK Rx queue.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 281d49b4fca4..bd4abb200fa9 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -167,8 +167,10 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		contd = XDP_PKT_CONTD;
 
 	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err || likely(!frags))
-		goto out;
+	if (err)
+		goto err;
+	if (likely(!frags))
+		return 0;
 
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
@@ -177,11 +179,13 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		len = pos->xdp.data_end - pos->xdp.data;
 		err = __xsk_rcv_zc(xs, pos, len, contd);
 		if (err)
-			return err;
+			goto err;
 		list_del(&pos->xskb_list_node);
 	}
 
-out:
+	return 0;
+err:
+	xsk_buff_free(xdp);
 	return err;
 }
 
-- 
2.34.1


