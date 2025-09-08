Return-Path: <bpf+bounces-67785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B9B49A70
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E923BB4C6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700042D640A;
	Mon,  8 Sep 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXdq+jAV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490992D3756;
	Mon,  8 Sep 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361492; cv=none; b=af8lnvb2Hoy/iI7rhgTNSTDlrpgv2l1hH8DO79+oMMT4Os9Dl6Cs1H8Qz1XesYf4mTJOmiwmUOd13pQo+i0X8z7aXe6z65R+mtryWFtxlCWd+jytfAMhqDdVOoqGDS+s6znYZqpvOLz2kflT4Oeg11tEyRHYnb+15RoMHBws2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361492; c=relaxed/simple;
	bh=C8OBztZ6vPk8ZFff7QvtWdo3gfREr1untuw3Po2M6Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg5ypKnPyavrq1SYDr9jWJTnDt300ekMQ8HsXrc6kg+2WyGTVa5L4R6AAvtCxFPXDr91mmRIdVhnnmjn97nD3uatlTNm7KhjeETAHkjj1KNFF8br6NhpgNla1CDT6cfKavkyWETHoTSrtJuv541dnjFQlaxBhjl3+a204S5zQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXdq+jAV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361492; x=1788897492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8OBztZ6vPk8ZFff7QvtWdo3gfREr1untuw3Po2M6Yw=;
  b=FXdq+jAVHe4ayptQcWbl1pcZ/hDTKNYD9JPGGjqrWm0LCk+Ck4d/NsZA
   xmGRhCJ4TbiXbPONQG1iqrgqMiTAR1dcAS8sR5j3tw5szeYEyBokzTEth
   omyxKTvRdGtMVkkRXzrBwq/GLBIM/MltlCaf/P704V3L+ZvABu7VNyNnw
   +/IhVcjBPEKBviQrUEDdNomvPzzVutCexu5up7nkAzEx/5fYpYcfOobGf
   v6qMJltmacDQ7GW/C/RKThoz9hYhkCW4TPH4NyixqjNgF40xmVIGW4CDc
   q9jBJMQCovod3wWtyZwFxkQZG8Pcf8V3bgm496LGhrIlNwrxfU1l58Ohc
   Q==;
X-CSE-ConnectionGUID: 4ta2gggQRnOAN8TGKYpOAQ==
X-CSE-MsgGUID: PTQRgypaSU2/QWQJsRc2kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088878"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:11 -0700
X-CSE-ConnectionGUID: yAykBEaGRQyH47xO8bvRrA==
X-CSE-MsgGUID: KOMD6AyzSvOGgqIeAFmVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189716"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	kees@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	llvm@lists.linux.dev,
	Ramu R <ramu.r@intel.com>
Subject: [PATCH net-next 01/13] xdp, libeth: make the xdp_init_buff() micro-optimization generic
Date: Mon,  8 Sep 2025 12:57:31 -0700
Message-ID: <20250908195748.1707057-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
References: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

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
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


