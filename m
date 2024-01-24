Return-Path: <bpf+bounces-20270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E883B218
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D8E1C212E0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB013473F;
	Wed, 24 Jan 2024 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHycEEM/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F892134739;
	Wed, 24 Jan 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123806; cv=none; b=CiizUypvPxMbJRfHdS7H1Qf3kWCKqcMNWosS3lD5yWT8+pLx3jFnaoXi86UqD/CasusDYSKWjygW659JsuezMMDgYndjMtqQC091HcRKFh4Zm8H41/I8fguwwN8mohqd+qrsO7RDQVVZTLQf0ew0oB+UMchI7TWeed1aJAHX8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123806; c=relaxed/simple;
	bh=hyVcLKKSyJqS9Zme8/U6n9DKZXPgJ09DwO+/MIW/b9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUJCtbHr70uJJtKR7Hz9jypirv/iCuhvKQe5eRxj0eCHr5KEBJtwRjE4B4jWSsJF08ZxpGWRLfH4L1aaKWdZLg3WZS8CqJkxKS/EhnU2PxeNbqWQ4CQ1i882mLlIa1Vh3Yp47wVa2p6uZX5vh1YYZ5bH6LMSBTHt7t0MvG/0w9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHycEEM/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123806; x=1737659806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyVcLKKSyJqS9Zme8/U6n9DKZXPgJ09DwO+/MIW/b9o=;
  b=fHycEEM/PcOjDsjF4Gi4O6cdlNa7YmdLkmBR2FCb6aEHQSMZXlSZvyGR
   gyJ9NBqttlGYuHdPxcaOpbLoJnjdRgwJRJ6QtLg0jWb67P+X/JtMdB46d
   kJh2/oA/WaeteqhBkj8GkMAwdkdykpO9j853tqW2IHVcQ3EPuBf3bDRyy
   ijmF+LF7/WMbMLIj/M8aQ6586Re2oTG4BqkwTmJNcw7RtoP8ddqxNPqGH
   gP8Xh+OaxqdgpeAVT668sYJvjX0rAjeufPMJNwz0pyyIJTEjAj7yOBMiB
   1tnHEWtzbHBlHYsOoe0vm4Ii0RZ36WFyRZs+OQQgaKm/orsm6WF8xwBnS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823209"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553507"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553507"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:41 -0800
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
Subject: [PATCH v6 bpf 09/11] xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
Date: Wed, 24 Jan 2024 20:16:00 +0100
Message-Id: <20240124191602.566724-10-maciej.fijalkowski@intel.com>
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

XSK ZC Rx path calculates the size of data that will be posted to XSK Rx
queue via subtracting xdp_buff::data_end from xdp_buff::data.

In bpf_xdp_frags_increase_tail(), when underlying memory type of
xdp_rxq_info is MEM_TYPE_XSK_BUFF_POOL, add offset to data_end in tail
fragment, so that later on user space will be able to take into account
the amount of bytes added by XDP program.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 99d5cc3aea46..4a912fba5c7e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4093,6 +4093,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	memset(skb_frag_address(frag) + skb_frag_size(frag), 0, offset);
 	skb_frag_size_add(frag, offset);
 	sinfo->xdp_frags_size += offset;
+	if (rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_get_tail(xdp)->data_end += offset;
 
 	return 0;
 }
-- 
2.34.1


