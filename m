Return-Path: <bpf+bounces-50218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50EEA242FB
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452B23A8A9A
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC411F2C2E;
	Fri, 31 Jan 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLyQoPBz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6F1F12E5;
	Fri, 31 Jan 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349675; cv=none; b=lKqjazAt6/DFFS1VQZFYktaxko9TMpNBcHtVBzTwRUVNFF7iprU2wy4633gKODgZKXWObCNDB/2mOVQUwRWHvAabDlXFfqyLEAz9ErleyggvwRYfBGtmDJbpcHvgAuhVzQkWMR1weP/1ayw63E/5cIDrekzgpysiyqaGtQFHRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349675; c=relaxed/simple;
	bh=rgVQbtWIks3iWTbytfkRjsT4ii5dCBR0+KEICAY4jwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQTnWlaBv1mfvVTxBYvDLjpZe3KgjL9f8C1Ql4tDZGbe7lS3oBYsP/jsd7538XZvD+MejtaqNrRVaaCHzuyulu7TxSG8i40pdp3qNWAWjwtB7VGLmYfeGLQW7FWjF4b4kcDfPFq6HN78kJth916ycnrPWQmquZHGpxTu2jxtuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLyQoPBz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738349674; x=1769885674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgVQbtWIks3iWTbytfkRjsT4ii5dCBR0+KEICAY4jwY=;
  b=XLyQoPBzraZTmzk8L9HgSrP6DZGpFOSEVEyducIJ3zBBZkysbVAS7rkU
   8dnChZmJ+scK2A458TsSjXm3nnIJvQ6WP/KRzynQ/CpZnmtEOiUzMhIoQ
   oTGqcthTzu8hDU9JWuLjbBq58pZeKqTGnUN1bTD8ES3nrwtDr2l1D7Pui
   6mfk1clh3Rjc8nwrBEUoBtZbf8NbdlIYRdDKiFFTFh0yRPnfLBmaH2XAN
   PXJx+zlcqeyGFtEVOixtHXlLKTHClsBriHZ6BjtX3Uea6rdU7rRWFNXgI
   v4fgTfRUWmaOCHQgo60IzDsUiga3SR8jDC8hyJfspd4rCI31LztLhVcYL
   w==;
X-CSE-ConnectionGUID: 477qBg0dQmK2+xv6yf2ZKQ==
X-CSE-MsgGUID: fCN91iQwTTuXU5HMxL1QPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38163418"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38163418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 10:54:25 -0800
X-CSE-ConnectionGUID: qyLy044ZSeW9tbPwt/3n9w==
X-CSE-MsgGUID: FxmeFDznR2iOLwdoic3hlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110149722"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 31 Jan 2025 10:54:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	horms@kernel.org,
	xudu@redhat.com,
	jmaxwell@redhat.com,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 2/3] ice: gather page_count()'s of each frag right before XDP prog call
Date: Fri, 31 Jan 2025 10:54:12 -0800
Message-ID: <20250131185415.3741532-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
References: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

If we store the pgcnt on few fragments while being in the middle of
gathering the whole frame and we stumbled upon DD bit not being set, we
terminate the NAPI Rx processing loop and come back later on. Then on
next NAPI execution we work on previously stored pgcnt.

Imagine that second half of page was used actively by networking stack
and by the time we came back, stack is not busy with this page anymore
and decremented the refcnt. The page reuse algorithm in this case should
be good to reuse the page but given the old refcnt it will not do so and
attempt to release the page via page_frag_cache_drain() with
pagecnt_bias used as an arg. This in turn will result in negative refcnt
on struct page, which was initially observed by Xu Du.

Therefore, move the page count storage from ice_get_rx_buf() to a place
where we are sure that whole frame has been collected, but before
calling XDP program as it internally can also change the page count of
fragments belonging to xdp_buff.

Fixes: ac0753391195 ("ice: Store page count inside ice_rx_buf")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e173d9c98988..cf46bcf143b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -924,7 +924,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[ntc];
-	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
@@ -940,6 +939,31 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	return rx_buf;
 }
 
+/**
+ * ice_get_pgcnts - grab page_count() for gathered fragments
+ * @rx_ring: Rx descriptor ring to store the page counts on
+ *
+ * This function is intended to be called right before running XDP
+ * program so that the page recycling mechanism will be able to take
+ * a correct decision regarding underlying pages; this is done in such
+ * way as XDP program can change the refcount of page
+ */
+static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
+{
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
+	struct ice_rx_buf *rx_buf;
+	u32 cnt = rx_ring->count;
+
+	for (int i = 0; i < nr_frags; i++) {
+		rx_buf = &rx_ring->rx_buf[idx];
+		rx_buf->pgcnt = page_count(rx_buf->page);
+
+		if (++idx == cnt)
+			idx = 0;
+	}
+}
+
 /**
  * ice_build_skb - Build skb around an existing buffer
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1241,6 +1265,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		ice_get_pgcnts(rx_ring);
 		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
 		if (rx_buf->act == ICE_XDP_PASS)
 			goto construct_skb;
-- 
2.47.1


