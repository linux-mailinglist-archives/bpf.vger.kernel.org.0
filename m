Return-Path: <bpf+bounces-19948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851ED833191
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D781F22778
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09B5A7B3;
	Fri, 19 Jan 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAQA/Y09"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48759B4A;
	Fri, 19 Jan 2024 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707085; cv=none; b=ioyfGZMNip4Co8VVTd9HsRhIe/Sf6/kbUA1V/Q1W9HniamVKprIxLvPGDVT7Bn4FH/9tzcgqrl10ytc4DQdvY4uYCC3zD+TQBuonN9+qgC4ap1hEpB8WfvJ1qHgd5xZDF/wZjje7uKDFjCp984M4HW/XxoedL5YblJpEDpYWSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707085; c=relaxed/simple;
	bh=9khkhqzvLIulNsCTS8jeOkWg0pFG1sYZYYrSbURPQmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Of6P0Jo9zrIUqWuapOkG5meKEPnMqHuRhhK39zQAOxjaLlQwdVrpdjE5QeCqG6hpm2mJvntcD8KpUUyPvirmmGZ7ptYhaNISfwI/mPSlg+1Vz69WbDldikiAyIRV6jvWglaS3mPMbwKg9hUwzLFIY06Hq9c6bki+lOv7o2GjaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAQA/Y09; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707084; x=1737243084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9khkhqzvLIulNsCTS8jeOkWg0pFG1sYZYYrSbURPQmo=;
  b=YAQA/Y09rju7cjY4HojJ1JTpVzzs5zRRuS2kwXltlGdzDQa06yyPcDyQ
   n5Zi1XBYVc5tWBGFpt7X9d+1pyIc8cRy1dbmwFuAeTg8IOnnJkH+H61vo
   gqVJGStUyRWlimbvrWekjoDuxZkcu/khnT17U/6x6/9h9vVLDMNm5s1I0
   xZMFjNCGULrzgX22bmTnapOZplRZsu1vHEY9b/hMkgqsw80kS+3aTLLV5
   Mk/xWZfbE/pNPgi7d6Xr+PB0L3QSGBtpKgPJCxUgRNS3JJFnELSenJ20Q
   S2s5RTO36ywlVaN/g6U1E0cKja/vcEIIPr/fhB34HGwKrIZFW2Z4bSVZB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771713"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277469"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277469"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:21 -0800
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
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 11/11] i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Sat, 20 Jan 2024 00:30:37 +0100
Message-Id: <20240119233037.537084-12-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
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


