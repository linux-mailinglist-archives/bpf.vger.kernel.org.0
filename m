Return-Path: <bpf+bounces-41110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC13992BB1
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FB81C2319D
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA81D4146;
	Mon,  7 Oct 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbXMDhx4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB561D356C;
	Mon,  7 Oct 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303922; cv=none; b=Ub+gayl+IvV4YKsETNHXdb+PnshWoXbnfKicXLy8CHx5tIYYRJjR4Y6IAg/xn2UT+YBdzxlUZI8qnx8RwCPd6RuJJT7+pmWLa889c9mTtpBJQ1KBkrw/QNR7+y6MI9H1OFRX3eXhmHo7sYedfy2+zMnz1+7kAQpIh8zOGWjT1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303922; c=relaxed/simple;
	bh=IQAa3vOt+XkyPeriYThtqnyUYqqLHkBN4ryY9KHhEuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKBCuJgCRdDrrRDvfdGtf768OzRMFzqpBvjMLGvft01eT5x9yq2kgM7rtBPRK3bpTLbRJk7dnXLHhkMUvK+phrywRDCxlW8aAXjj7o8tPzODj/x/iGk/C/5aX8nxwchrPOpRFW8U5DktY5Db4BpkV3yHBCy36fkbJlrwHj5adZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbXMDhx4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303920; x=1759839920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQAa3vOt+XkyPeriYThtqnyUYqqLHkBN4ryY9KHhEuI=;
  b=fbXMDhx4gI6o5ydvIrN1TVXlaQWosShX/76ya6SNN8MzKmtSTs+KW3uX
   4D39IPbuyYazv/UAYeoYhPKLZPne1muVzhsuOzCnwQyLapEsxBnbxX9Pr
   v7skXEzZXf/n8QPhFotgWCSc4xjMo7Hk5C+GlCsdRuxMu7kJxAbOBIrOR
   kvcXxhovf2nY+hB97G2hHHVzDbOZtE/T2gOxh5z9AcMMjo/968aYnggkm
   RROoqLNSl5MIJQcWf7emh7uWqY7kqhcewAG6T0aIfvtBhrXKbnP3g6Vgf
   d6zDURocQCkXBIRF3iQv9LlkA93mRs6WtJTl66iKDsWXIiQCyOZX3xqtJ
   w==;
X-CSE-ConnectionGUID: cGDgP94ISKqsUQxZO+Gb8g==
X-CSE-MsgGUID: x+RfsCNlTMCA4SNqepxo3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066372"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066372"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:13 -0700
X-CSE-ConnectionGUID: /jIrBlz+ShyO/lfrO3X4RA==
X-CSE-MsgGUID: Tn292JxYQtio6w+YrEbi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250948"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:11 -0700
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
Subject: [PATCH v2 bpf-next 4/6] xsk: carry a copy of xdp_zc_max_segs within xsk_buff_pool
Date: Mon,  7 Oct 2024 14:24:56 +0200
Message-Id: <20241007122458.282590-5-maciej.fijalkowski@intel.com>
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

This so we avoid dereferencing struct net_device within hot path.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h | 1 +
 net/xdp/xsk_buff_pool.c     | 1 +
 net/xdp/xsk_queue.h         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 468a23b1b4c5..bb03cee716b3 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -76,6 +76,7 @@ struct xsk_buff_pool {
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
+	u32 xdp_zc_max_segs;
 	u8 tx_metadata_len; /* inherited from umem */
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 7ecd4ccd2473..e946ba4a5ccf 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -229,6 +229,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_xsk;
 	}
 	pool->umem->zc = true;
+	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
 err_unreg_xsk:
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 406b20dfee8d..46d87e961ad6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -260,7 +260,7 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 			nr_frags = 0;
 		} else {
 			nr_frags++;
-			if (nr_frags == pool->netdev->xdp_zc_max_segs) {
+			if (nr_frags == pool->xdp_zc_max_segs) {
 				nr_frags = 0;
 				break;
 			}
-- 
2.34.1


