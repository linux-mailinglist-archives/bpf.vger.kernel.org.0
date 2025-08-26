Return-Path: <bpf+bounces-66560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DDB36FB7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017B31BA7772
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1A34F464;
	Tue, 26 Aug 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDcewxUm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600A341AA5;
	Tue, 26 Aug 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224817; cv=none; b=Dr4Po913BVxdnRapI1j3TG9KvA8kKBjQK4Oz2lDh7LKlTRj7S3DlYQWEf71fX+/nNbwAGPVhORgOPt8LmNV5v+uuovCT+WQ+lKeqacjivaChNRvDngj4wDukOyyMcy5S0AHCTNG7dq8X+MfHjg2bHKIONyGFxKyndk1Fk0N+OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224817; c=relaxed/simple;
	bh=bUNbTnj1hQFmwxgQyqBf0WIlVzWXySVKeBksI4xda0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7DCutVE0wTiSLdsBsBW4sGJ6RzD72M3SJzmiAzxWyRad473YBnOUfQGfNwna/kOicgbPO2kzeUurnadEwtJ+2V+AL8iHCGvMulPrb836ZFLFjHEBaT4fyTJEcCekx3HziQ6o44v6b4TDV7K18ZCHXmHvwkdNo9FkgzoeQwEkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDcewxUm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224816; x=1787760816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUNbTnj1hQFmwxgQyqBf0WIlVzWXySVKeBksI4xda0g=;
  b=eDcewxUmdnivN7YH95A8zdQJgsKesSsZWbjdWQqvCRhjvZ//oIki4STs
   I7DJJ6EggukZ38LvtwKWABBQaMHKftWhgsX9d8eRY0ZClhd5192ey1z3J
   FqY6rf10bu4tqQtvh/b2wx7ooiLpZ0hMk8ubztDiK99DbSROi/JQCIdy6
   rglvMJBbkJp3vHOoZG5OBKdnX4uv7LuaLef75IlQsu4X5Dwa6xuktjIxx
   TEoQc59HsldIpghkqtkJkqEclY1jQ149iWTKjAjnfTbKpIOXVI9D49ADi
   26seDWcqAWCmTSo9gt8q1duvT1XFYM1A7vXAz95GZ0Vj8Z7onM1B/BmoB
   A==;
X-CSE-ConnectionGUID: uLoATYd7Re2wY1qdAD1pMA==
X-CSE-MsgGUID: oH1yM/MTQbWGThCulubkhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46044888"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46044888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:13:35 -0700
X-CSE-ConnectionGUID: 1ED7XHirReKYL0P1+ufTxw==
X-CSE-MsgGUID: cGM/nvP0RFqi7q8kd0aGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562083"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:13:31 -0700
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
Subject: [PATCH iwl-next v5 02/13] idpf: fix Rx descriptor ready check barrier in splitq
Date: Tue, 26 Aug 2025 17:54:56 +0200
Message-ID: <20250826155507.2138401-3-aleksander.lobakin@intel.com>
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
index 600bd83ae3fa..bbbbcd885fcf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3101,18 +3101,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
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
2.51.0


