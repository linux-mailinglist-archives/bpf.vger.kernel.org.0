Return-Path: <bpf+bounces-64718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15258B16436
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D545E3B7908
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447F2E174C;
	Wed, 30 Jul 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4L/6gg6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258B2DEA7B;
	Wed, 30 Jul 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891698; cv=none; b=t6LDtHfTtx0ibbOisumqEnZLn7Yhn4zIST05YP/Ejoq1AY8Qj2zrnfdupr79eEXL2q/S6I/SiIcdtbn8uIVFdhY16BUmyQDTiygIzvIYdwE/O6eT0yFlJHBB9kjFW6VPNlCpTN2r4RdGjbmDqJPMk4EOXFsJIs2XA5WJkmqLwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891698; c=relaxed/simple;
	bh=21YseSN5/gmTF3jvrArd5iFQeZPQG0Im69mIuZCLtyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih3CCBhGXR+TkP5wsLqvfQKXMv4eC5Wa9Modi5YkrU+rZ3jdvbvDpquxMAUzHkqNznpDuOgFUtJvSbg/fZV5ELdm3Un9aMlSr2vSi+af9vxG4aEKKPXXWRLmpAQVTGa2+REF6H2FiBbPcjIJlCkY+PwkEqRnzTIdD7wd0mAEr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4L/6gg6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891698; x=1785427698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21YseSN5/gmTF3jvrArd5iFQeZPQG0Im69mIuZCLtyk=;
  b=l4L/6gg6/Ab0sXw08t2FCKSJPH/70R0YmF32VFFu6g9EkK/q7qpE+gWD
   cPLj2/KRa3pbV8gxzgUQtdtWnT8iqNoohOgTUJM8BjkobIVfPNpRj3m0l
   zVPaDOg7PYlRvcHnc2pUr143ioJal+Sg+qNZYty42BFt8eAnSg7E32BLS
   4VXwyEEOMqooJuR+K3YgSIiJ/TuDAhM7PNOrIVxa/d0RxcqrjuPk9fdeA
   gUMpdXMTL/YS3pB5L90NDLWaK68s3vZ+Fseqz+EaTx6SaAiAmKilWBpdr
   zqbZxdsx7F+BAC2f+3JQQwJNJBrGqVq2R1WnA/Nn9RVAw6UHpHBLzIfTx
   w==;
X-CSE-ConnectionGUID: WHhhrHxzS8e5wUDH3D4yCA==
X-CSE-MsgGUID: ddRxex4nTPuvnBRgimlpZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278842"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278842"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:08:17 -0700
X-CSE-ConnectionGUID: WeqyqDqhTIWoo/Dqx7k60Q==
X-CSE-MsgGUID: T9trWTwiRaCsu2cjePyqJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812913"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:08:13 -0700
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
Subject: [PATCH iwl-next v3 07/18] idpf: fix Rx descriptor ready check barrier in splitq
Date: Wed, 30 Jul 2025 18:07:06 +0200
Message-ID: <20250730160717.28976-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730160717.28976-1-aleksander.lobakin@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No idea what the current barrier position was meant for. At that point,
nothing is read from the descriptor, only the pointer to the actual one
is fetched.
The correct barrier usage here is after the generation check, so that
only the first qword is read if the descriptor is not yet ready and we
need to stop polling. Debatable on coherent DMA as the Rx descriptor
size is <= cacheline size, but anyway, the current barrier position
only makes the codegen worse.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1dba069c8ff6..87366064fcbe 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3186,18 +3186,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
 
-		/* This memory barrier is needed to keep us from reading
-		 * any other fields out of the rx_desc
-		 */
-		dma_rmb();
-
 		/* if the descriptor isn't done, no work yet to do */
 		gen_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
 				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
-
 		if (idpf_queue_has(GEN_CHK, rxq) != gen_id)
 			break;
 
+		dma_rmb();
+
 		rxdid = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RXDID_M,
 				  rx_desc->rxdid_ucast);
 		if (rxdid != VIRTCHNL2_RXDID_2_FLEX_SPLITQ) {
-- 
2.50.1


