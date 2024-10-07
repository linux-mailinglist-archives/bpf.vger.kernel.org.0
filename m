Return-Path: <bpf+bounces-41111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58199992BB3
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA47285716
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F21D4161;
	Mon,  7 Oct 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naBk+bFh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8231D2B0E;
	Mon,  7 Oct 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303922; cv=none; b=CjW0DjHZtBWBwalQaSZ2ypupxj5Dce1cmH1/3QRpRCnV89085axDGn+QEfxXCVhC3L5pXQaAs0eOB/6zLR+uIVcnJfe84pqtICcwDrkXQ03ZiN0yWD3naj+QSKKsstUduhuVaJpJnVkQw7SpyaUTH0DTS+iEYyqB6KY0OPDt8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303922; c=relaxed/simple;
	bh=KvVnpCkxmabJb+RRBOEsAMz7vD62sAxroz3xiSVnRMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdS83PwUHthz0ROOewFqor3z2B4fdbKE3ry+02y7puMXM72K5G6zsS2/qw/DObIBJ2irVAM/mJQRGCr9xsFzXYeZxU3vTutYJNuFhTPPvUEr/HoziXuJDn8d9Ek1pfe8tncOS8mO66Ay725G3qkdyTR0HegSDFbAbily1WI28jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naBk+bFh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303921; x=1759839921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvVnpCkxmabJb+RRBOEsAMz7vD62sAxroz3xiSVnRMs=;
  b=naBk+bFhnZvwYB7pc7C6qWf6vPazfUWfeaP8jUPWWGUTObaetLfWbS6F
   OtNIqE2NuyTcGeGxWt05bH7G/OcIt8e2D0yTPURpqZAdhLiCDJmJeOwm8
   ffZlVy3OXJi66SMMgXBFu3dXmjzOOyYiPAxdMTQoV2YotSXD2hIm6ABWQ
   /nXS+u38C1xtmOODg+6inAH8PVWPgGb7TNQQUJ7EbptyTLP9suVjB4YeV
   ew4LuguyeJW1w4s/nLebaO4Z+Y+CIJwnUlVtTDNMb/kIYYaELhjavbZg+
   JJpE56Ou5WJZGVrQeSaGrfAQqxqpubSwTaVJNKTps93OuxFJw6Cpd/Ssm
   g==;
X-CSE-ConnectionGUID: dJxqkMRdTua0LQD8i9AYbw==
X-CSE-MsgGUID: Ago9T+N5QZGwYZm3w9snoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066380"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066380"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:15 -0700
X-CSE-ConnectionGUID: ce4PpnXUStSBsBCEKCZP6w==
X-CSE-MsgGUID: Xt7OTP7BTaOKqM2e/7JJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250985"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:14 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	vadfed@meta.com
Subject: [PATCH v2 bpf-next 5/6] xsk: wrap duplicated code to function
Date: Mon,  7 Oct 2024 14:24:57 +0200
Message-Id: <20241007122458.282590-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both allocation paths have exactly the same code responsible for getting
and initializing xskb. Pull it out to common function.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index e946ba4a5ccf..ae71da7d2cd6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -503,6 +503,22 @@ static bool xp_check_aligned(struct xsk_buff_pool *pool, u64 *addr)
 	return *addr < pool->addrs_cnt;
 }
 
+static struct xdp_buff_xsk *xp_get_xskb(struct xsk_buff_pool *pool, u64 addr)
+{
+	struct xdp_buff_xsk *xskb;
+
+	if (pool->unaligned) {
+		xskb = pool->free_heads[--pool->free_heads_cnt];
+		xp_init_xskb_addr(xskb, pool, addr);
+		if (pool->dma_pages)
+			xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
+	} else {
+		xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
+	}
+
+	return xskb;
+}
+
 static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 {
 	struct xdp_buff_xsk *xskb;
@@ -528,14 +544,7 @@ static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 		break;
 	}
 
-	if (pool->unaligned) {
-		xskb = pool->free_heads[--pool->free_heads_cnt];
-		xp_init_xskb_addr(xskb, pool, addr);
-		if (pool->dma_pages)
-			xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
-	} else {
-		xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
-	}
+	xskb = xp_get_xskb(pool, addr);
 
 	xskq_cons_release(pool->fq);
 	return xskb;
@@ -593,14 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 			continue;
 		}
 
-		if (pool->unaligned) {
-			xskb = pool->free_heads[--pool->free_heads_cnt];
-			xp_init_xskb_addr(xskb, pool, addr);
-			if (pool->dma_pages)
-				xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
-		} else {
-			xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
-		}
+		xskb = xp_get_xskb(pool, addr);
 
 		*xdp = &xskb->xdp;
 		xdp++;
-- 
2.34.1


