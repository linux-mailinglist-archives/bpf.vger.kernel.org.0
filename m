Return-Path: <bpf+bounces-53302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D80A4FB7B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B91892A94
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BE207A05;
	Wed,  5 Mar 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jbccJB8X"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530192063F8;
	Wed,  5 Mar 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169725; cv=none; b=oss9DIzaRMgQ/zyMclFEXGmEUldHiLApAdCiH/ydQclw6BpiH9aOaCn7nkQVU7PqynOPN2YTIIMHuRfo87CNKp8wGMkztICfEb3atmkJ8RaVsqdLZp93FNZeN0fYldp8gY8j9y+tmuYekQjWiNIxV5wt7TyExKQ+JUqk62Ioht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169725; c=relaxed/simple;
	bh=XACdHbDtlSb9oZWYXK0665qeZ/kAstCX3HVLBKUwzMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=peKyHD9RTMTTY/D77a9tId4+cIvGRg1o36KW7hzUwjFQrrVaRtWzLs9rYGb5qHSo6b3ay7OPC8ROC8xy/6bzxqGJ1jac7UBnIh52Ja3uUt1lO62l8rh4UDJg98j9xoTeDDeDiSpmSDFGwdFsDFvrTXbsKPA95l6W3Jg18w0suYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jbccJB8X; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525AERd83282294
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 04:14:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741169667;
	bh=Wryz06ecjFza6cdQ2QRwPLmlZLKpml5XtzADdJCKhPA=;
	h=From:To:CC:Subject:Date;
	b=jbccJB8XF/zh1BcKSkCM2IiV+JgfYNcqsIx4us/h9XLZR6J7TacJZFvPgI9FvQlKU
	 v2g0rxH3E1qb1ag32px9h7yUfQWmuncdYwUiRcyTdPmYjFgmeHqius26aEA2lslg2f
	 8Hd8MhRA4IHT6EBBiQ3tB+c3B/JU+skgRQgqGAqc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 525AERaX085764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 04:14:27 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 04:14:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 04:14:26 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525AEQH4042146;
	Wed, 5 Mar 2025 04:14:26 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 525AEP4Q005713;
	Wed, 5 Mar 2025 04:14:26 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <s.hauer@pengutronix.de>,
        <glaroque@baylibre.com>, <schnelle@linux.ibm.com>, <arnd@kernel.org>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v4 0/3] net: ti: icssg-prueth: Add native mode XDP support
Date: Wed, 5 Mar 2025 15:44:19 +0530
Message-ID: <20250305101422.1908370-1-m-malladi@ti.com>
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

v3: https://lore.kernel.org/all/20250224110102.1528552-1-m-malladi@ti.com/

Changes since v3 (v4-v3):
1/3:
- Get rid of skb from Rx management code in SR1 as suggested by 
Roger Quadros <rogerq@kernel.org>
2/3:
- remove SWDATA size information from commit message
- Fix handling of packets for non-skb type inside emac_tx_complete_packets()
- Remove incrementing budget for incorrect swdata type
- use PRUETH_SWDATA_CMD in emac_send_command_sr1()
All the above changes are suggested by Roger Quadros <rogerq@kernel.org> and
Dan Carpenter <dan.carpenter@linaro.org>
3/3:
- few cosmetic changes inside emac_xmit_xdp_frame() func
- change xdp_state type to u32 from int
Above changes are suggested by Dan Carpenter <dan.carpenter@linaro.org>
- Few improvements in emac_run_xdp case handling as suggested by 
Roger Quadros <rogerq@kernel.org>

Roger Quadros (3):
  net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
  net: ti: icssg-prueth: introduce and use prueth_swdata struct for
    SWDATA
  net: ti: icssg-prueth: Add XDP support

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 417 ++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 131 +++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  47 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  58 ++-
 5 files changed, 541 insertions(+), 113 deletions(-)


base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
-- 
2.43.0


