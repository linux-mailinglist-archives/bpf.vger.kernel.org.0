Return-Path: <bpf+bounces-50682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06FA2B139
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54B41602DB
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242961C5F3F;
	Thu,  6 Feb 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ5y+2Ie"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3A1B4239;
	Thu,  6 Feb 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866637; cv=none; b=TO9EDQ65IfSloIWbrm9wqUP8odtwyTwK/2Gfl2F2hchFtZMDCWD1k0g9vkPD6WZWcgx4CI79Xp0d4J7RnsuojIhArcEGZHTSfgVLNE9TS+qsU9Ya7emVjPBr67vV27qpzYejdjTgDqHCtUoBO2NtaDSrJ+6XgAjzPsP/vZzxQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866637; c=relaxed/simple;
	bh=tCQ2Nhmk3K4pHm1Ho2NAJuNHMIXd4ulXGPcI1saaATI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyElP3u3mv7TtqPzMC7c1BCUVqx30Q3zhn6j1Iq1D1bCSnYoA9LiKwtRBzWqgS9bHRpubZIkIzUbLpb5L7UJ4qOWcJHxXTs68C98mcY0yI0Byw6DsSbKqLDrhdSWv7JSd7yjX5dXavhe/wOrGJYg73s/N/HXWb6P/E7f+dZaADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ5y+2Ie; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738866636; x=1770402636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCQ2Nhmk3K4pHm1Ho2NAJuNHMIXd4ulXGPcI1saaATI=;
  b=jQ5y+2IewCvIfn0t20tc8/39DwpwSvPt5HNQ6bXwJKvWpFuTpPyi6BzN
   5oamj6ex6xYh0DIPjG2TXkHeGnapMSVgE8b+tLB1bY7tHOsDgRIIjVF0p
   sQSL/VRlZi4DzEVwnsWONyH/MgJhQwm7vsLkbGuxGF5Xdfs35wy2mPSW+
   FR13qrbbB1zxavSHt9MsI/Mv3UbuFtmP951crOKqeVl516emlUtDYafJd
   BTGOtsFlWeuhVInIgzwKEPwxbNHLPFZ04jgFReDV8JS263Z89Y0r8vP3s
   Wyl9SrxBKIZzJ+nvM0oXqZZSmDyXZF5eUXc6y90KGTCxvmqxv06tghc1s
   A==;
X-CSE-ConnectionGUID: mdjNCPNATOGkWJo0OFwceA==
X-CSE-MsgGUID: K14FfMpSQquhsI8cTqb/5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49734475"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49734475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:30:35 -0800
X-CSE-ConnectionGUID: vwc6IRvkSbGsC9Kh89PRZQ==
X-CSE-MsgGUID: PShxg+/QQ+O+iGVJRsImAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111065886"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2025 10:30:31 -0800
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
Subject: [PATCH net-next 2/4] i40e: use generic unrolled_count() macro
Date: Thu,  6 Feb 2025 19:26:27 +0100
Message-ID: <20250206182630.3914318-3-aleksander.lobakin@intel.com>
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

i40e, as well as ice, has a custom loop unrolling macro for unrolling
Tx descriptors filling on XSk xmit.
Replace i40e defs with generic unrolled_count(), which is also more
convenient as it allows passing defines as its argument, not hardcoded
values, while the loop declaration will still be a usual for-loop.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.h | 10 +---------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |  4 +++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index ef156fad52f2..dd16351a7af8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -6,7 +6,7 @@
 
 #include <linux/types.h>
 
-/* This value should match the pragma in the loop_unrolled_for
+/* This value should match the pragma in the unrolled_count()
  * macro. Why 4? It is strictly empirical. It seems to be a good
  * compromise between the advantage of having simultaneous outstanding
  * reads to the DMA array that can hide each others latency and the
@@ -14,14 +14,6 @@
  */
 #define PKTS_PER_BATCH 4
 
-#ifdef __clang__
-#define loop_unrolled_for _Pragma("clang loop unroll_count(4)") for
-#elif __GNUC__ >= 8
-#define loop_unrolled_for _Pragma("GCC unroll 4") for
-#else
-#define loop_unrolled_for for
-#endif
-
 struct i40e_ring;
 struct i40e_vsi;
 struct net_device;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e28f1905a4a0..9f47388eaba5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
+#include <linux/unroll.h>
 #include <net/xdp_sock_drv.h>
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
@@ -529,7 +530,8 @@ static void i40e_xmit_pkt_batch(struct i40e_ring *xdp_ring, struct xdp_desc *des
 	dma_addr_t dma;
 	u32 i;
 
-	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
+	unrolled_count(PKTS_PER_BATCH)
+	for (i = 0; i < PKTS_PER_BATCH; i++) {
 		u32 cmd = I40E_TX_DESC_CMD_ICRC | xsk_is_eop_desc(&desc[i]);
 
 		dma = xsk_buff_raw_get_dma(xdp_ring->xsk_pool, desc[i].addr);
-- 
2.48.1


