Return-Path: <bpf+bounces-66559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E3B36FAF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A057A5222
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53973164D5;
	Tue, 26 Aug 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9Zdm4s0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660E313E10;
	Tue, 26 Aug 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224813; cv=none; b=fbtIpqlqMuF5wGUNF20KhiTFolKuRSUxOVbGO5ULCUEzkfaquxjyhS0nQgbw+s7YgQ1U8wZMkjr3fLDHH8RGpMrDxC9OFU++O2VQ9oFLid7qsZCvmvIDuFTNWeR165sDuLhKW3JLFlIlDnSrKSe8Mo9KetyIga2GpgqDofVih08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224813; c=relaxed/simple;
	bh=3azXjeLlMdczMc3oGM/koHv9jY0rlImJEFzdohW82Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD4o0rz6WjfOomGxOHFg6+F/anbauk6yRmKyWVWjfDVHJ2j1qzLCWwB3tu4qWmebI43W9cghBspjYzAx9OLFporRk0kbniFj0JGgcFoHS6dNXC/YToeBZ19l4utnj52B8h8b9/sL8hVPIBV0ZYAli0+DIh65wNMflGyisaJLnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9Zdm4s0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224812; x=1787760812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3azXjeLlMdczMc3oGM/koHv9jY0rlImJEFzdohW82Ig=;
  b=S9Zdm4s0Fhj2pB/83ARCsT6c8CWEOIBY1jIustSHi2VyCB6+bMjk6uGm
   XIk8fJZQS4QzOfLQUhVOmhevt2jlEjV2jUnCy0Nu/Rp+GChz1QyWyoW+W
   zpsXdAQ0sqKBLcqnmo25zIg1/q6PRrgPYs4rpndkU4sh6x/4uyjgUB4K9
   ARrzA8BX73wohOIQCfbHacCKw37k1uMjj6hRNADzQwPw7LnzwHvYEtPPJ
   djUweut6zDrpqvUi1IishVSAXaYEg1cMVqz6GjTqp4rQ6VGt3clY+YL/m
   7LsTdaJU1EmG1sT02541ilgvpZRw1pVFhF+pbhlufEu9iTNJEQl0bHqlq
   g==;
X-CSE-ConnectionGUID: aQycQlvhTRae5OM+7YenUg==
X-CSE-MsgGUID: ChzgUkBNQeqthO/td0EKAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46044867"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46044867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:13:31 -0700
X-CSE-ConnectionGUID: R7x4PETyTROq9x4CHM+oiw==
X-CSE-MsgGUID: fBqtNADmRz6vnUp9R/eIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562037"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:13:27 -0700
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
Subject: [PATCH iwl-next v5 01/13] xdp, libeth: make the xdp_init_buff() micro-optimization generic
Date: Tue, 26 Aug 2025 17:54:55 +0200
Message-ID: <20250826155507.2138401-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
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
2.51.0


