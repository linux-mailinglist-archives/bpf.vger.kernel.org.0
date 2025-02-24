Return-Path: <bpf+bounces-52324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D98A41C08
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0CB3AC672
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03A2586F9;
	Mon, 24 Feb 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bVluDuFu"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88222586DF;
	Mon, 24 Feb 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394921; cv=none; b=RxXw6ibH0kq7JPyPlEgYFwN/hhS/akENHWkgekEN3tzJ4ugf2NF9SQ00BjklxXSpGuc/B8WIXojKuxkPssXmY0NEaCH0EDlZHTzUSwgBIsTpoJRNWOLEcy6BBuwMArPKNLr+wcK3iI0hD82StIjfo+MTd3xHXyvEgMsEKXnm7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394921; c=relaxed/simple;
	bh=q18mKMH72Y4UUcWf73SfinzZFUcLW4FTQuzaM83ivAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ly8O+8GP93tyaRv3zLCvZx2ZKr+0yigcoZQVGlcVCCWaNddMY7EAOZdQlKWSo2/qIdBj/ogDT89DPIDxONPl8SmJ+Xndeous/HKku7IqOOEFDqVFKwUWi0+ydJ4UgpmQWKXvcUXLbHI4QUjvby7MibKf0N3qd6sQQKTw2BVOLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bVluDuFu; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB174G874420
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 05:01:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740394867;
	bh=UrJwRS5j0Znv8WvcVKXlmtyolIJX3daZq7dyAqxKQS4=;
	h=From:To:CC:Subject:Date;
	b=bVluDuFu35aMtK+DaebNDRkm+5h3txflRDrM7o2icA9EPwTddFpXH9qdhbB9vHqOF
	 pIs5ILC2tGzJXUuBLOhrDEnR51Ex+Bj/CYw5hj5kB5GFWcAWMxpA/LfihhyTxqMgq1
	 9+j4xElOK7g4OMf2v7J7V5XrFngbtO3L9/cf1xW0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB17lt106562
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 05:01:07 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 05:01:06 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 05:01:07 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OB16qV093011;
	Mon, 24 Feb 2025 05:01:06 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51OB16T6002030;
	Mon, 24 Feb 2025 05:01:06 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <matthias.schiffer@ew.tq-group.com>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <schnelle@linux.ibm.com>, <diogo.ivo@siemens.com>,
        <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v3 0/3] net: ti: icssg-prueth: Add native mode XDP support
Date: Mon, 24 Feb 2025 16:30:59 +0530
Message-ID: <20250224110102.1528552-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds native XDP support using page_pool.
XDP zero copy support is not included in this patch series.

Patch 1/3: Replaces skb with page pool for Rx buffer allocation
Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
Patch 3/3: Introduces native mode XDP support

v2: https://lore.kernel.org/all/20250210103352.541052-1-m-malladi@ti.com/

Changes since v2 (v3-v2):
0/3:
- Update cover letter subject line to add details of the driver as suggested by
Jesper Dangaard Brouer <hawk@kernel.org>
1/3:
- few cosmetic changes for all the patches
2/3:
- Fix leaking tx descriptor in emac_tx_complete_packets()
- Free rx descriptor if swdata type is not page in emac_rx_packet()
- Revert back the size of PRUETH_NAV_SW_DATA_SIZE
- Use build time check for prueth_swdata size
- re-write prueth_swdata to have enum type as first member in the struct
and prueth_data union embedded in the struct
3/3:
- Use page_pool contained in the page instead of using passing page_pool
(rx_chn) as part of swdata
- dev_sw_netstats_tx_add() instead of incrementing the stats directly
- Add missing ndev->stats.tx_dropped++ wherever applicable
- Move k3_cppi_desc_pool_alloc() before the DMA mapping for easier cleanup
on failure
- Replace rxp->napi_id with emac->napi_rx.napi_id in prueth_create_xdp_rxqs()

All the above changes have been suggested by Roger Quadros <rogerq@kernel.org>

Roger Quadros (3):
  net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
  net: ti: icssg-prueth: introduce and use prueth_swdata struct for
    SWDATA
  net: ti: icssg-prueth: Add XDP support

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 421 ++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 128 +++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  47 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  23 +-
 5 files changed, 529 insertions(+), 91 deletions(-)


base-commit: e13b6da7045f997e1a5a5efd61d40e63c4fc20e8
-- 
2.43.0


