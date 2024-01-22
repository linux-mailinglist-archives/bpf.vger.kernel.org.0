Return-Path: <bpf+bounces-20052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97AB837606
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9761F27071
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184DB4B5BC;
	Mon, 22 Jan 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3vFjsUG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B44878F;
	Mon, 22 Jan 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961815; cv=none; b=CnKeNFpiGyRejBHGejkWlIsiqvhOL77YIDThG7ln2L3eo8cCaGnMY8DhHYvJ4qs6O00mJr0FrasfwqetkSoM/i1rQrtqQLvloUH2mLHOI0fyBcl39HMn5fTAUIJ2ibRahJT+cSmaDJT2unk1AHWnHxZcOWTbOXRoIBwZEN1ehN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961815; c=relaxed/simple;
	bh=9khkhqzvLIulNsCTS8jeOkWg0pFG1sYZYYrSbURPQmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9/llZaKVHcyIxRHEjjCGsuCtvdnqS7NlnYn0KQe3NtykUsS/QxpnM60MAkJoleFsJ4NbqR4m3eJy3BWfwHqoCv9UDEhjlCKeW/Bv1LEbIjLV/mrsWWygGGIk71e4tjoLKMr2Vv/ltv2MNCNVXDEfOh6ok9QD87XD/lZbp8/tCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3vFjsUG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961815; x=1737497815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9khkhqzvLIulNsCTS8jeOkWg0pFG1sYZYYrSbURPQmo=;
  b=h3vFjsUGLXH1ZM1N4Uaesc79zIiuPDvHsNhHf1eP9ZiwAFUvAvUJTD46
   Cke4ePHbN0/oEtpA4Goz0MvmGd5gt0ivTsbAsvsRkvApqfjPa8TKg7P0e
   FvtQIx8qqRTwXeYmAKUaqjlZGV+6EYdJr2mBSn04CbZ3qN+pVsFc1RhwC
   qOmJw1WA+fCh0FGM50XIpCRMQlMOloElafDYpN/IVq73hBMo0eTsikuAm
   JZywfFCZPFp7oK9DftD/5a9pc8fjz3RfAfndhocktS3Mi7rPZMUSG1rdF
   oj5MIxqfLHOrStmMCPgtrw1MNCAs37PqSxvDVwKAQh8VgjqEcvCnLJvGY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995697"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360950"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:51 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 11/11] i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Mon, 22 Jan 2024 23:16:10 +0100
Message-Id: <20240122221610.556746-12-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that i40e driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. i40e_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f8d513499607..7b091ce64cc7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3609,7 +3609,14 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->queue_index,
+					 ring->q_vector->napi.napi_id,
+					 ring->rx_buf_len);
+		if (err)
+			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
-- 
2.34.1


