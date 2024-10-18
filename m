Return-Path: <bpf+bounces-42483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8D9A488F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375CC1F23613
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D8205E17;
	Fri, 18 Oct 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P9MktG33"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A518D64F;
	Fri, 18 Oct 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284826; cv=none; b=hmXxrJmOhysWKUKretqv/AXzmViSSM1rMgNS2+7FlFLzejp13Zkx3EwYCe9ZzcpBmG8c6wWpUc7a9C281lvU4QkcNCQHKOT/kSJ6Q0UeVFD+Nkpwq+hb127loDhYovGCguCdQdzEdXs3yraIjnjmBXA+CB6o6dRAbwYPYHF8veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284826; c=relaxed/simple;
	bh=0jiB1tRHc2IgEsT0lkF5yK8TzDqhVGpedseWUDNs8HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svwpTZpkXi1nWmVvuk38bz+8PjWYgPDW2mNkI75LDouTbj80w8GdpBqsy3J9PwqIoDcPewdXPbV/wOL+tmIgQBFcHE3iS9itHmehtmp1DjDDTFzd03ZqFsf3kB7qf5g3igH7c47iCvDjcO3xacAP0MPOt1o4T1SfWdZSDKLxiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P9MktG33; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 31F2DC003AD1;
	Fri, 18 Oct 2024 13:53:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 31F2DC003AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729284818;
	bh=0jiB1tRHc2IgEsT0lkF5yK8TzDqhVGpedseWUDNs8HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9MktG33gf9fUSfp6ywesUxei0uEgvl277RPQ0zhTJjzpdekx9LoCPz7uJEvlNjgY
	 IZ7Hg+YbHcmNORrysMhea+fsUk7lZztAT2fPmFXYqtq/sLgOndWepGGk/ci37sxeqY
	 YSi8IVzynC2BIIpavKryYSNqdVIkT0KsdGZqMxJM=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8715018041CACA;
	Fri, 18 Oct 2024 13:53:37 -0700 (PDT)
From: jitendra.vegiraju@broadcom.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	fancer.lancer@gmail.com,
	rmk+kernel@armlinux.org.uk,
	ahalaney@redhat.com,
	xiaolei.wang@windriver.com,
	rohan.g.thomas@intel.com,
	Jianheng.Zhang@synopsys.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v6 3/5] net: stmmac: Integrate dw25gmac into stmmac hwif handling
Date: Fri, 18 Oct 2024 13:53:30 -0700
Message-Id: <20241018205332.525595-4-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Integrate dw25gmac support into stmmac hardware interface handling.
Added a new entry to the stmmac_hw table in hwif.c.
Since BCM8958x is an early adopter device, the synopsis_id reported in HW
is 0x32 and device_id is DWXGMAC_ID. Provide override support by giving
preference to snps_id, dev_id values when initialized to non-zero
values by glue driver.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 88cce28b2f98..b8ee7bf20037 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -257,6 +257,27 @@ static const struct stmmac_hwif_entry {
 		.est = &dwmac510_est_ops,
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
+	}, {
+		.gmac = false,
+		.gmac4 = false,
+		.xgmac = true,
+		.min_id = DW25GMAC_CORE_4_00,
+		.dev_id = DW25GMAC_ID,
+		.regs = {
+			.ptp_off = PTP_XGMAC_OFFSET,
+			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
+		},
+		.desc = &dwxgmac210_desc_ops,
+		.dma = &dw25gmac400_dma_ops,
+		.mac = &dwxgmac210_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = &dwmac510_tc_ops,
+		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
+		.setup = dw25gmac_setup,
+		.quirks = NULL,
 	}, {
 		.gmac = false,
 		.gmac4 = false,
@@ -292,7 +313,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	u32 id, dev_id = 0;
 	int i, ret;
 
-	if (needs_gmac) {
+	if (priv->plat->snps_id && priv->plat->dev_id) {
+		id = priv->plat->snps_id;
+		dev_id = priv->plat->dev_id;
+	} else if (needs_gmac) {
 		id = stmmac_get_id(priv, GMAC_VERSION);
 	} else if (needs_gmac4 || needs_xgmac) {
 		id = stmmac_get_id(priv, GMAC4_VERSION);
-- 
2.34.1


