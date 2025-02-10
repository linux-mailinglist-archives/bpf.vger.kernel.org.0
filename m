Return-Path: <bpf+bounces-50954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998AA2E98A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9851D3A5789
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CD1CD1FD;
	Mon, 10 Feb 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HdLthlgv"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620F189902;
	Mon, 10 Feb 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183684; cv=none; b=P2+aZd6VAN86OWd8FmWey0qL1hudNXkECMWpADX4UPQcyJ3dFLhOu1g+ChuvHK0MKetJu9YO5sZdvdATIlz9Vk4lXDc15uppOLZjtDl7yDEP0gGVKopsJxqYQuC/d5BswjASpvz1GLPWzKWuCNEurs5kjaAM8GxpqVVKSsyn508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183684; c=relaxed/simple;
	bh=B7Kq2rKssdmycg6AHQ8wjUEjTHe+vUQTk/r0jPRw5m4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bz0JegXaCHNOOP7HKgVOjsgVwhsvPWcSTARvAWMUVs46G3Mr1HtHdZGTN9t9wD8jXT8/Dmv0BEzMAutTLKbGFygNVb384Qc0X4y0O7e+mr7SEz4t6ejzGmZOo1DOlto2yRp3r303EGpWKBut5zPLH5eaCoiUmh25qfrw5l69/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HdLthlgv; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AAXwEJ3393375
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 04:33:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739183638;
	bh=xqlYCFRr7znYUe3dXWqah+daPf6vzdIUhiZ4PmBjuEI=;
	h=From:To:CC:Subject:Date;
	b=HdLthlgv/gsJz9xzuJSVgeENYwLh0WiujXZpqKl0qigdKg0XNcY61UOIqxbOKC6MI
	 lQW0t+3KISxODdWGi0wDcYMY80PtNBEHr6sZzZjf4KroXtL9t44/LmeXVzpCexv/DB
	 YUxat/TJprDDVAvPsbNoNcluBezDqQ+E1a2ocfAU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51AAXwId027014
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Feb 2025 04:33:58 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 04:33:58 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 04:33:57 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AAXvtG108867;
	Mon, 10 Feb 2025 04:33:57 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51AAXuKc021822;
	Mon, 10 Feb 2025 04:33:57 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <jan.kiszka@siemens.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v2 0/3] Add native mode XDP support
Date: Mon, 10 Feb 2025 16:03:49 +0530
Message-ID: <20250210103352.541052-1-m-malladi@ti.com>
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

v1: https://lore.kernel.org/all/20250122124951.3072410-1-m-malladi@ti.com/

Changes since v1 (v2-v1):
- Add missing SoBs for all patches
1/3:
- Recycle pages wherever necessary using skb_mark_for_recycle()
- Use napi_build_skb() instead of build_skb()
- Update with correct frag_size argument in napi_build_skb()
- Use napi_gro_receive() instead of netif_receive_skb()
- Use PP_FLAG_DMA_SYNC_DEV to enable DMA sync with device
- Use page_pool_dma_sync_for_cpu() to sync Rx page pool for CPU
3/3:
- Fix XDP typo in the commit message
- Add XDP feature flags using xdp_set_features_flag()
- Use xdp_build_skb_from_buff() when XDP ran
All the above changes have been suggested by Ido Schimmel <idosch@idosch.org>

Roger Quadros (3):
  net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
  net: ti: icssg-prueth: introduce and use prueth_swdata struct for
    SWDATA
  net: ti: icssg-prueth: Add XDP support

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 427 ++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 129 +++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  50 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  23 +-
 6 files changed, 540 insertions(+), 92 deletions(-)


base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
-- 
2.43.0


