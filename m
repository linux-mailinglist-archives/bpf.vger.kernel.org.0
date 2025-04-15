Return-Path: <bpf+bounces-55936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1EA8977B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F036216C1BB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152227E1A7;
	Tue, 15 Apr 2025 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ub4eQxzW"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2A289357;
	Tue, 15 Apr 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707991; cv=none; b=sP/sm/gq9zHDsuix2LFym018CLh6WCRaYgxn8sALxqgWhxULYo7ehHMT0iJI0MyISunByjVhjy+7Xb27NoPzpOtkjF8Rc14xRUOSeiL5qfNperjjLO0at9p7gMTMsdRCya6Wnd0PsCyLnXgyjgGUxBpMyehUHt4jSoC7qpqgKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707991; c=relaxed/simple;
	bh=SwqYHKdJdLoovSs29qeQIztDbSM1TuvqLAVPWM0G19Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je5Hc9x26+ehFm484adAJCo/wXEyLWUv7avkLDrT1uzezWir9ll24haZ+M/XHs0OWTlYz32jZz4WVcd9v3CQt8TQhjWhGMcRFfkEgVEjlCxnBCEHZH/I8nNpN3n0TpTXhZB1JUuc7zPPMRnDDXBQo6aRNWVi5mmaNoINJWsUMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ub4eQxzW; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95wGH2996245
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 04:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744707958;
	bh=zbbMws7/JHr51qmHgB5wtBPMnAvtKhFkR+q7a0rSNgo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ub4eQxzWW27JJe6N0qadN8dFErC+Lhph4tzFUZi5nNBT8/Cwlw74266Y72rDSgjjj
	 fzq9+wFEhh5JK9HFxuPL60pPI589jFMtfH60pstnROOeddhzyRM8zc4OrllXNMF8WU
	 VWwl6ljMNLKy3tLW62AK6D3NRFeaocOWqwzOZpvw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95wUn012296
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 04:05:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 04:05:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 04:05:57 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F95v1N029324;
	Tue, 15 Apr 2025 04:05:57 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53F95uu5010969;
	Tue, 15 Apr 2025 04:05:57 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4 3/3] net: ti: icss-iep: Fix possible NULL pointer dereference for perout request
Date: Tue, 15 Apr 2025 14:35:43 +0530
Message-ID: <20250415090543.717991-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415090543.717991-1-m-malladi@ti.com>
References: <20250415090543.717991-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The ICSS IEP driver tracks perout and pps enable state with flags.
Currently when disabling pps and perout signals during icss_iep_exit(),
results in NULL pointer dereference for perout.

To fix the null pointer dereference issue, the icss_iep_perout_enable_hw
function can be modified to directly clear the IEP CMP registers when
disabling PPS or PEROUT, without referencing the ptp_perout_request
structure, as its contents are irrelevant in this case.

Fixes: 9b115361248d ("net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v3 (v4-v3):
- Fix the logic in icss_iep_perout_enable_hw() to clear IEP registers
  when disabling periodic signal

 drivers/net/ethernet/ti/icssg/icss_iep.c | 121 +++++++++++------------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index b4a34c57b7b4..2a1c43316f46 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -412,6 +412,22 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 	int ret;
 	u64 cmp;
 
+	if (!on) {
+		/* Disable CMP 1 */
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(1), 0);
+
+		/* clear CMP regs */
+		regmap_write(iep->map, ICSS_IEP_CMP1_REG0, 0);
+		if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
+			regmap_write(iep->map, ICSS_IEP_CMP1_REG1, 0);
+
+		/* Disable sync */
+		regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0);
+
+		return 0;
+	}
+
 	/* Calculate width of the signal for PPS/PEROUT handling */
 	ts.tv_sec = req->on.sec;
 	ts.tv_nsec = req->on.nsec;
@@ -430,64 +446,39 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 		if (ret)
 			return ret;
 
-		if (on) {
-			/* Configure CMP */
-			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
-			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
-				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
-			/* Configure SYNC, based on req on width */
-			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
-				     div_u64(ns_width, iep->def_inc));
-			regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
-			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
-				     div_u64(ns_start, iep->def_inc));
-			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
-			/* Enable CMP 1 */
-			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
-					   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));
-		} else {
-			/* Disable CMP 1 */
-			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
-					   IEP_CMP_CFG_CMP_EN(1), 0);
-
-			/* clear regs */
-			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, 0);
-			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
-				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, 0);
-		}
+		/* Configure CMP */
+		regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
+		if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
+			regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
+		/* Configure SYNC, based on req on width */
+		regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
+			     div_u64(ns_width, iep->def_inc));
+		regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
+		regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
+			     div_u64(ns_start, iep->def_inc));
+		regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
+		/* Enable CMP 1 */
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));
 	} else {
-		if (on) {
-			u64 start_ns;
-
-			iep->period = ((u64)req->period.sec * NSEC_PER_SEC) +
-				      req->period.nsec;
-			start_ns = ((u64)req->period.sec * NSEC_PER_SEC)
-				   + req->period.nsec;
-			icss_iep_update_to_next_boundary(iep, start_ns);
-
-			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
-				     div_u64(ns_width, iep->def_inc));
-			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
-				     div_u64(ns_start, iep->def_inc));
-			/* Enable Sync in single shot mode  */
-			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG,
-				     IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN);
-			/* Enable CMP 1 */
-			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
-					   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));
-		} else {
-			/* Disable CMP 1 */
-			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
-					   IEP_CMP_CFG_CMP_EN(1), 0);
-
-			/* clear CMP regs */
-			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, 0);
-			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
-				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, 0);
-
-			/* Disable sync */
-			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0);
-		}
+		u64 start_ns;
+
+		iep->period = ((u64)req->period.sec * NSEC_PER_SEC) +
+				req->period.nsec;
+		start_ns = ((u64)req->period.sec * NSEC_PER_SEC)
+				+ req->period.nsec;
+		icss_iep_update_to_next_boundary(iep, start_ns);
+
+		regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
+			     div_u64(ns_width, iep->def_inc));
+		regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
+			     div_u64(ns_start, iep->def_inc));
+		/* Enable Sync in single shot mode  */
+		regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG,
+			     IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN);
+		/* Enable CMP 1 */
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));
 	}
 
 	return 0;
@@ -498,11 +489,21 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 {
 	int ret = 0;
 
+	if (!on)
+		goto disable;
+
 	/* Reject requests with unsupported flags */
 	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
 			  PTP_PEROUT_PHASE))
 		return -EOPNOTSUPP;
 
+	/* Set default "on" time (1ms) for the signal if not passed by the app */
+	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
+		req->on.sec = 0;
+		req->on.nsec = NSEC_PER_MSEC;
+	}
+
+disable:
 	mutex_lock(&iep->ptp_clk_mutex);
 
 	if (iep->pps_enabled) {
@@ -513,12 +514,6 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	if (iep->perout_enabled == !!on)
 		goto exit;
 
-	/* Set default "on" time (1ms) for the signal if not passed by the app */
-	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
-		req->on.sec = 0;
-		req->on.nsec = NSEC_PER_MSEC;
-	}
-
 	ret = icss_iep_perout_enable_hw(iep, req, on);
 	if (!ret)
 		iep->perout_enabled = !!on;
-- 
2.43.0


