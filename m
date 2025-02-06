Return-Path: <bpf+bounces-50683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF9A2B13D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4185C188C138
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0F1D5AD8;
	Thu,  6 Feb 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbrvLmCt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB61B4239;
	Thu,  6 Feb 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866642; cv=none; b=BtZo8K1lyDbc84Eq7lBvIZfJWyMuhskHH4pMi8Yx3GtG5Zpc5s5l46yVPBoOmPuDTGajoHg5atdFlVUO0sOmSp8OtP0ewYYVTPDwRR62ikQav0uSAKTegFQpZNeP/61zTazbueiatI/hs3sQZvLDsaVipUaGui71MaiiQTptU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866642; c=relaxed/simple;
	bh=QT+oHjlIPggfbQlgJprfaj60Qp6VDwquMDsXmu0uwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5Ekz7WpZYE8QKcxfGGZDk2mRYsTMSIpzCgcvfyHN+vhyLsbMnyBaUga/5euA605R1KNE8lgmuv6+kMwacDsDZcfCgFqmbXnc7WLpzjGzqeEgOC00kqp9qeK9gXTjzzUQuUK+U8zJbVcxE1I9i9v8l0WvnhMGAz1B48RYcfDgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbrvLmCt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738866641; x=1770402641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QT+oHjlIPggfbQlgJprfaj60Qp6VDwquMDsXmu0uwD8=;
  b=NbrvLmCt1JBE3amaFggK/PLn6ohNamHiCUFVP/37AcWB70l/iP0ooxGe
   9Y+7vlgAobuq12Ud+3bilbYMGPMG/xbFbKQSe4aMkQalX/i7o+UG4SxV2
   ZoLrvN5tirGLVcX9I1hTlvLYefgR6AnBbhaSwDwsyECbX42R52P9Q8PM9
   50e8ndfC8qVN/QB3pq/XBaG7/Au7azhnfepnvtmV3X3dV8ctyd8nP7MYN
   klyqUjldp+i6Xgd8A4qptz3GtJ/7WrQz2Pltw9hVjAXZ2UVQ2BliL9QAK
   Mdr00wretvZvQI+84gCaM4S/J+K6UDJ0jupiJXrBD+baXZPlm4Dp5T8o0
   w==;
X-CSE-ConnectionGUID: H3Jj9lpeTLeZovkowNYgXg==
X-CSE-MsgGUID: 4cw8zu8hRSyniyjWsL+LWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49734500"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49734500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:30:41 -0800
X-CSE-ConnectionGUID: Z4lY5usIS7CbEEMkjaoYJg==
X-CSE-MsgGUID: 1PCNebL5TEOK9nJo6zwdVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111065899"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2025 10:30:36 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] ice: use generic unrolled_count() macro
Date: Thu,  6 Feb 2025 19:26:28 +0100
Message-ID: <20250206182630.3914318-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice, same as i40e, has a custom loop unrolling macros for unrolling
Tx descriptors filling on XSk xmit.
Replace ice defs with generic unrolled_count(), which is also more
convenient as it allows passing defines as its argument, not hardcoded
values, while the loop declaration will still be usual for-loop.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.h | 8 --------
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +++-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 45adeb513253..8dc5d55e26c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -7,14 +7,6 @@
 
 #define PKTS_PER_BATCH 8
 
-#ifdef __clang__
-#define loop_unrolled_for _Pragma("clang loop unroll_count(8)") for
-#elif __GNUC__ >= 8
-#define loop_unrolled_for _Pragma("GCC unroll 8") for
-#else
-#define loop_unrolled_for for
-#endif
-
 struct ice_vsi;
 
 #ifdef CONFIG_XDP_SOCKETS
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8975d2971bc3..a3a4eaa17739 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <linux/bpf_trace.h>
+#include <linux/unroll.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 #include "ice.h"
@@ -989,7 +990,8 @@ static void ice_xmit_pkt_batch(struct ice_tx_ring *xdp_ring,
 	struct ice_tx_desc *tx_desc;
 	u32 i;
 
-	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
+	unrolled_count(PKTS_PER_BATCH)
+	for (i = 0; i < PKTS_PER_BATCH; i++) {
 		dma_addr_t dma;
 
 		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
-- 
2.48.1


