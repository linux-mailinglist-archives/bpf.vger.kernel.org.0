Return-Path: <bpf+bounces-48943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B468A1273B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CDC3A6031
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CF1CDFC2;
	Wed, 15 Jan 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkc6gB3J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9A1C1F31;
	Wed, 15 Jan 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954410; cv=none; b=gtv9+svRess4P+1e1afCSivnI9FvrhClz77s6y4CG0/+wF+VPOgdqFRfqcVTEkQuUF59VI2/1hYwxr9k8ZQDF2CHtmAUCb8LGead4xBS8H3Rf0UyY22Qoic5NBMsPkqKc4Xu5Sh6Gsc4INTudfco3jeQZobIMrLVwM3RKo68SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954410; c=relaxed/simple;
	bh=HOveXO1oeLngwaGY9rAv/03AUdBAjULxQf2pO0H97GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH76pOgR5fnScYK359ygErZsHY2fRv8bZ3LW4iEdi3uRZQtKNc1Njb/iNXasMHYR5c7tkncrIQfgHpW/HCr0W+1/A0MTRF9HWM1y/GgM8hLfkh7uKsTiYj0Z7+GAwgpIgRiOnFh/5W6MjY2A5duNxGRsDDxa990oBmGMemOC7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkc6gB3J; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954409; x=1768490409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOveXO1oeLngwaGY9rAv/03AUdBAjULxQf2pO0H97GM=;
  b=kkc6gB3JlKzq7zH2Fq4cZdnCfabiVT8eGGr/UTeS++KEtrvyF02gxfsF
   E+yR1JjjBcQLM0c4s6EDNGNbNdrYPqpjbXPYqha7Y+H2lN67YB73WkhFW
   nYicw4rf+17yo4MkDqG1j/oQiQqZB2WvtTFo3BFh1A4/tZUL2gqyn5tSG
   t3t3oENo31fDrvgCCD+/x3VtPGsloVEvGuElyhPY4eUyFp9r/LyUMxxwo
   gdGN01sEO+NCH1K0YPhhAgKqRFAlLMYA51ymEGf91RW2cjsea03GllLSv
   s/Mb9HA8t7f6oLqhPYfcdhXOnO4MQLgAUBrtcPUfnANxUfyIf4u5p3/f+
   w==;
X-CSE-ConnectionGUID: eZX1gGB7SG6y3dHjbwSoIg==
X-CSE-MsgGUID: cI5xcv4DSKebJdSva2vg3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451847"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:20:09 -0800
X-CSE-ConnectionGUID: Ff5ZEOHyRF2gWvYA0/d5uQ==
X-CSE-MsgGUID: vq72rhWZTVOHRmyYPg6ITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116699"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:20:05 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 7/8] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
Date: Wed, 15 Jan 2025 16:19:00 +0100
Message-ID: <20250115151901.2063909-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can bulk-allocate skbs from the NAPI cache, use that
function to do that in veth as well instead of direct allocation from
the kmem caches. veth uses NAPI and GRO, so this is both context-safe
and beneficial.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 01251868a9c2..7634ee8843bc 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -684,8 +684,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	void *skbs[VETH_XDP_BATCH];
 	int i;
 
-	if (xdp_alloc_skb_bulk(skbs, n_xdpf,
-			       GFP_ATOMIC | __GFP_ZERO) < 0) {
+	if (unlikely(!napi_skb_cache_get_bulk(skbs, n_xdpf))) {
 		for (i = 0; i < n_xdpf; i++)
 			xdp_return_frame(frames[i]);
 		stats->rx_drops += n_xdpf;
-- 
2.48.0


