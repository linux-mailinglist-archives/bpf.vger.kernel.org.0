Return-Path: <bpf+bounces-40769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A092698DFE4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7271F27736
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026E1D12FB;
	Wed,  2 Oct 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwr+Tugz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239D1D0F62;
	Wed,  2 Oct 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884497; cv=none; b=oETiGKaIl0z/jzyVR7bol/STo/wBPqUCIDCqoGclWKi2VGFXgD/DQHVko8MO+mXuuw3kYTHCZkFpOWdETJ1MHmVUvyop/1aQx7pQNhpxPr5BxFiPc1AMX8U9LLb4mJ8qPwlxn2NccqdRlJ0EhgStZNmq5uvoLTY2ARDnXIjdJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884497; c=relaxed/simple;
	bh=DV/83EeRCdUT8m1wE49UQiPVoAIyVRRBwfAlT4+3F0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKXq5Bk8jwG0u5U2qXTqAG2gIg0zp1TFucD4BbkSs7reb+KdWNpHUT/pozb90wZE+qObPLdeHef4NzQJgoMcv7gmL42h2ztSaZUEdTYN9pWrL7QXPHrGHjweEMpPtmiBWEVigzw8ibdEwby3zeGsdt6f/kTRB2giAT3yPJ8Tc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwr+Tugz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884496; x=1759420496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DV/83EeRCdUT8m1wE49UQiPVoAIyVRRBwfAlT4+3F0c=;
  b=lwr+TugzsVbTxajri4ixunozEppTAuRcg7vh+pwOsQAkf1YLNwFtVL0y
   j+hOGiMbHfl3QEbeiJs3Bci4SAVt5fzL9QgH1agmQgKJe1/sFnTpJrGcl
   Wt3UqxMX4O+XJzBfZ1FDlXt/UGo20zq6lK+/n9t3NLkxIj1339I88nBHt
   nkES/l+xJmkYF5OH8uTsSq0PzkbAloBqUNLXTLcGWrJU0BwyqGmO4xBBX
   blwMGWd91E1CVYP1rAyfh6bnAXM1WoCzFNV285s+rIWpwbmYudkr494L8
   jQMGKCEjnsC5xgtkNfZmKBAd907X9mJLfQXg2JP1XijCbhgu52xLaY06N
   w==;
X-CSE-ConnectionGUID: uj5xontNShK5vsqJ7KPEiA==
X-CSE-MsgGUID: /nxeH6gvRfyMreQwtX964Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762976"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762976"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:54 -0700
X-CSE-ConnectionGUID: hcJz8hXHQAWzzchD3t6bFw==
X-CSE-MsgGUID: T+nPtro2R1SbD82w7KfpNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628787"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:51 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 4/6] xsk: carry a copy of xdp_zc_max_segs within xsk_buff_pool
Date: Wed,  2 Oct 2024 17:54:39 +0200
Message-Id: <20241002155441.253956-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
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
index 468a23b1b4c5..8223581d95f8 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -77,6 +77,7 @@ struct xsk_buff_pool {
 	u32 chunk_shift;
 	u32 frame_len;
 	u8 tx_metadata_len; /* inherited from umem */
+	u32 xdp_zc_max_segs;
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool unaligned;
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


