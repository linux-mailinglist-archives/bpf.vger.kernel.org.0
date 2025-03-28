Return-Path: <bpf+bounces-54850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE8A7482E
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DD13BC4C6
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9221B199;
	Fri, 28 Mar 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UjTCfmWL"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F0218E81;
	Fri, 28 Mar 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157506; cv=none; b=PiKyn/F04n4rP8ThPOjzTK0ySC4Zn1B/Ah1TFI/gsEba3t4z4DUW7Ylfzz+h0+41dnWX1bdMrrXZxD/kcP+Wiqxq92HRrdo1lGr+q//Q05QH13u8CCjhJN2pYvz8kX/+BipPVWoNWnoSCEvOY3f3PqcZjIzQsOOqk2EoByRI+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157506; c=relaxed/simple;
	bh=VxUgKafT4KHR2xDe781AhbpVJyVma76wkzz6s4SiyOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSE/gTCHAoiM7XoKZtOxnPG2KajD8nuLFhoQVelpwLzGM+O/QzFmrU58NnEd/RypyHHM1vzenOhDeHygE8jReNwHftoiKZYJsTFKkKYDREPWw+/CBOVDx4MEnYmbqjHEBei2KanHSUHby90HIi2z4e3fgwLpIK7n5sWSNuudPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UjTCfmWL; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAOI4d2096894
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743157458;
	bh=u4tP25R7wKXZmeyNdNfbQrRvdEC/iStfy1ogy2I2G0I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UjTCfmWLI9GYR0caRe30ghn8tIfqDc5srFVpP7vmtK/+KstuxiYWS+FuDAeES3aWF
	 rokLxSYI2CjCR3IJKYQD4DFALV7BRsCRRwJoBTa+YLxHkp+lPfKQXtsmRHknWQihK5
	 R87n2zxhtHoXlOwluWmryQXO8VlYaSTIV63R8t6w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAOIer056909
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Mar 2025 05:24:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 05:24:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 05:24:17 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAOH0Y004266;
	Fri, 28 Mar 2025 05:24:17 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52SAOGom030930;
	Fri, 28 Mar 2025 05:24:17 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <namcao@linutronix.de>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer dereference for perout request
Date: Fri, 28 Mar 2025 15:54:03 +0530
Message-ID: <20250328102403.2626974-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328102403.2626974-1-m-malladi@ti.com>
References: <20250328102403.2626974-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

ICSS IEP driver has flags to check if perout or pps has been enabled
at any given point of time. Whenever there is request to enable or
disable the signal, the driver first checks its enabled or disabled
and acts accordingly.

After bringing the interface down and up, calling PPS/perout enable
doesn't work as the driver believes PPS is already enabled,
(iep->pps_enabled is not cleared during interface bring down)
and driver will just return true even though there is no signal.
Fix this by setting pps and perout flags to false instead of
disabling perout to avoid possible null pointer dereference.

Fixes: 9b115361248d ("net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v2(v3-v2):
- Add Reported-by tag and link to the bug reported by Dan Carpenter <dan.carpenter@linaro.org>
- drop calling icss_iep_perout_enable() for disabling perout and set perout to false instead

 drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index b4a34c57b7b4..b70e4c482d74 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -820,9 +820,9 @@ int icss_iep_exit(struct icss_iep *iep)
 	icss_iep_disable(iep);
 
 	if (iep->pps_enabled)
-		icss_iep_pps_enable(iep, false);
+		iep->pps_enabled = false;
 	else if (iep->perout_enabled)
-		icss_iep_perout_enable(iep, NULL, false);
+		iep->perout_enabled = false;
 
 	return 0;
 }
-- 
2.43.0


