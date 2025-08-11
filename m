Return-Path: <bpf+bounces-65349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C011B2122C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D407500F71
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A12E03E6;
	Mon, 11 Aug 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS/r19vM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14BE2DCF7C;
	Mon, 11 Aug 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928771; cv=none; b=mdTWe2unJDOXH1IX2VJB4DV1O8ZVhTpuSUrEMzW1ju1Nl4OFkvHhjG3dB0e5y/UKULjBuFHE7Ensbm2+lI6Rp/DRWIbAOPESQe5RCuzynGLuIRKnYEMrjhynhwf+YSlzGDEHemss1M350csCQqFja5EmzfDo+j+KnEGkmx8GRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928771; c=relaxed/simple;
	bh=KC9rYeXWUjRlWYhn01scgcJNTloIqkp3Bdcmm78sTrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwZKQZJQ6X7lG+Ig9a0ustcUlopIDvQTWxPRvnR4ivvddALg+NOPlz1NFMdKB6dE0iL5SFZmHsjgEs14Ucd/+I4YtWWN1bky3wo42pXdIWbM22XFMr0TOA/qKeGxtZTKnsuISTM+31ufZ6CJd3jWZu7ZfojhYntoaaQdMCFOo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS/r19vM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928770; x=1786464770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KC9rYeXWUjRlWYhn01scgcJNTloIqkp3Bdcmm78sTrg=;
  b=DS/r19vMyhuMvhgDlrBDmuhafr2EzcHUzr06uiz5gL16WcYYIluGFb+5
   I3t7bkxw+Z3HbTTfNOdJZBLCG5JOqpIb+m2IVUgXVY08fFnEpMwzYAXqA
   7PoQnph/3AVDd+SwGak/E3Q2g+4NPGQOMyjk9QCoopbOtiIfLpQLx7cim
   gvUPqXoAzGNaVUiiEWckEYhOUegWq3V3oVtKNBfE/SrAJuwrnmPjG6gsg
   kehUp0lZNO9FKu2HDf6rmrwJGqSAI00dEn5eaoAAWahhO9cf7TU36Naxj
   L//ixEn1eOUpTFzAz6UmR+ECucBVIplxnTTuGa1KteUcLCKf2IOBTAt1I
   w==;
X-CSE-ConnectionGUID: x/h2FNkJRhKTFDtZdKUHqg==
X-CSE-MsgGUID: 0M9KeVsTS4OseirZXholxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899529"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899529"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:12:49 -0700
X-CSE-ConnectionGUID: zlFoOzSiQFiXpJa2tndgIg==
X-CSE-MsgGUID: xVcgcB+VRjivU8EwObLI5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163149"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:12:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v4 01/13] xdp, libeth: make the xdp_init_buff() micro-optimization generic
Date: Mon, 11 Aug 2025 18:10:32 +0200
Message-ID: <20250811161044.32329-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Often times the compilers are not able to expand two consecutive 32-bit
writes into one 64-bit on the corresponding architectures. This applies
to xdp_init_buff() called for every received frame (or at least once
per each 64 frames when the frag size is fixed).
Move the not-so-pretty hack from libeth_xdp straight to xdp_init_buff(),
but using a proper union around ::frame_sz and ::flags.
The optimization is limited to LE architectures due to the structure
layout.

One simple example from idpf with the XDP series applied (Clang 22-git,
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE => -O2):

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-27 (-27)
Function                                     old     new   delta
idpf_vport_splitq_napi_poll                 5076    5049     -27

The perf difference with XDP_DROP is around +0.8-1% which I see as more
than satisfying.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/xdp.h | 11 +----------
 include/net/xdp.h        | 28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index f4880b50e804..bc3507edd589 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1274,7 +1274,6 @@ bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
  * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
  * head with the Rx buffer data: data pointer, length, headroom, and
  * truesize/tailroom. Zeroes the flags.
- * Uses faster single u64 write instead of per-field access.
  */
 static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 					   const struct libeth_fqe *fqe,
@@ -1282,17 +1281,9 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 {
 	const struct page *page = __netmem_to_page(fqe->netmem);
 
-#ifdef __LIBETH_WORD_ACCESS
-	static_assert(offsetofend(typeof(xdp->base), flags) -
-		      offsetof(typeof(xdp->base), frame_sz) ==
-		      sizeof(u64));
-
-	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
-#else
-	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
-#endif
 	xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
 			 pp_page_to_nmdesc(page)->pp->p.offset, len, true);
+	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
 }
 
 /**
diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..af60e11b336c 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -85,8 +85,20 @@ struct xdp_buff {
 	void *data_hard_start;
 	struct xdp_rxq_info *rxq;
 	struct xdp_txq_info *txq;
-	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
-	u32 flags; /* supported values defined in xdp_buff_flags */
+
+	union {
+		struct {
+			/* frame size to deduce data_hard_end/tailroom */
+			u32 frame_sz;
+			/* supported values defined in xdp_buff_flags */
+			u32 flags;
+		};
+
+#ifdef __LITTLE_ENDIAN
+		/* Used to micro-optimize xdp_init_buff(), don't use directly */
+		u64 frame_sz_flags_init;
+#endif
+	};
 };
 
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
@@ -118,9 +130,19 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
-	xdp->frame_sz = frame_sz;
 	xdp->rxq = rxq;
+
+#ifdef __LITTLE_ENDIAN
+	/*
+	 * Force the compilers to initialize ::flags and assign ::frame_sz with
+	 * one write on 64-bit LE architectures as they're often unable to do
+	 * it themselves.
+	 */
+	xdp->frame_sz_flags_init = frame_sz;
+#else
+	xdp->frame_sz = frame_sz;
 	xdp->flags = 0;
+#endif
 }
 
 static __always_inline void
-- 
2.50.1


