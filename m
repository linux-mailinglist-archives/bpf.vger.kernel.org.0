Return-Path: <bpf+bounces-20262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB483B1FD
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2050D1C20DD4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F109132C20;
	Wed, 24 Jan 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eo17r0nn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1E132C0F;
	Wed, 24 Jan 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123775; cv=none; b=bo0oiBDgoJ830qw5bvPSKfIbAZCDKDRYe5cldKmFcJNYVraAGNT3EOpTaS2Bmhue+HRqNJ3im+uS0C/F0isPaDaFQtH7Moa63XtkSuCDEANV3zMXEAQxrG7GK663NcaVlEVot93P9hWl+jz4+1R/8eL+Z4jvm5gjJp5QomtcLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123775; c=relaxed/simple;
	bh=eJyulSxFkLgss8vVHYcG6J+Lt6BM/8SR04Fb1v9dFa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4/FkVUP5FDOXOzkEGjPaEJ3psCYhaydVxbK9Gy8wEOSPMMrXbyMbu+VYOJc+6iEIB6yWPQBucueXJYfdBRKvOYm2LRUEiLHh8TmMIl9MFp13GQHWd0mNZ1wNAKB6Jhbrhe1J1I7/+UNLStJZGdwQX27kdyKGfVgD9fr9CHA4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eo17r0nn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123774; x=1737659774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJyulSxFkLgss8vVHYcG6J+Lt6BM/8SR04Fb1v9dFa8=;
  b=eo17r0nnihaUc0V+cHDqGBTk6do59NG96Rz/tl6oYgpP46k2JF9HrO13
   Kg29v5GWx2QRfjTsFV1y1yy7rCjfZcWCjnZvLg77yAGPzmGR7Lf+FhWod
   2DNBIKYTv2BSUCFlvikmNvW0Lt6taHRGGBBzaUlmghbwPs5CEjFuCCWQQ
   7/+M56AeGRmO6zA2YwJnuywpP9wXXVjDcAyG8uiGGBuRbJEvQ1MeXkr0T
   L732sYUI1NhQJoHwXjaIwofeL8oRc/EQqXOsVcSh/tQ2qb4hwoTylrlV6
   a35HsPC/Bb2t0rqYBJsII77tKmdkmwnGbA7ibC/6eZuvwkhNrOpYIyWp2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1822927"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1822927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553438"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553438"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:10 -0800
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
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 01/11] xsk: recycle buffer in case Rx queue was full
Date: Wed, 24 Jan 2024 20:15:52 +0100
Message-Id: <20240124191602.566724-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
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


