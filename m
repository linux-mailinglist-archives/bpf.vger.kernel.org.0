Return-Path: <bpf+bounces-18530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120881B889
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6CE28E096
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202078E76;
	Thu, 21 Dec 2023 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPv2gPhT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14377F39;
	Thu, 21 Dec 2023 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703165228; x=1734701228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJyulSxFkLgss8vVHYcG6J+Lt6BM/8SR04Fb1v9dFa8=;
  b=DPv2gPhTpWO+uz32TyqPsayrBC3h80tDM1tnoPukdCzaN0ZLU5XhjhoU
   tFMaF/0Hs2J0RspFhUA07B9t1oF5W/VO5+8tf5YYs29UXua0efOnEN3oq
   ddFcV1XS7jhNyF5WyTnwtD6sZaIrbwfbg2QpdJVqndhvsRonl5GBg1zY7
   ibkWdrXZfEsFReWPS3LYhz/76VjD6+wIfIAOWmsiCI9dHUOlEgtkNSs+Z
   W7uoJ3FvGOym3b0RXgemv33wxmmbbdy9l09tYnYKLeX2PBYMzbPJZ405W
   rYCPA/ow9ADDDRQ4us8m4QTPUqS8sM430g7X3z4SKZzo9uyZhH94++fOO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3205545"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3205545"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="24955779"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 21 Dec 2023 05:27:06 -0800
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
	lorenzo@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v3 bpf 1/4] xsk: recycle buffer in case Rx queue was full
Date: Thu, 21 Dec 2023 14:26:53 +0100
Message-Id: <20231221132656.384606-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
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
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9f13aa3353e3..1eadfac03cc4 100644
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


