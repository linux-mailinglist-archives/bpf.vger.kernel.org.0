Return-Path: <bpf+bounces-54530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E7A6B5DD
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BFE189D354
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD61F03D9;
	Fri, 21 Mar 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ss5XFq8L"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B401EFFB0;
	Fri, 21 Mar 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544837; cv=none; b=Txta0gbh5WjAmBvs/z95LuHY5QvO/HPqYbXKPYxKc8ff7p/iLffDeXupNDZVETcgHXD6VmP7EBZIuT8OZeY98NeAflitr6GbY+wBIoQBndk0lbp2FQaPJDVjPJSavWAPx0jbxuv/rfxAj88lhQ77HyzbwJFmCPQBIus06xlTTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544837; c=relaxed/simple;
	bh=iQ3f1Uo9PBRmeOIRNc3lzhLy3Ycu/Zb+R/wdm0l71M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAxe9tgTcpcp2PeJvrEKFmyl7ej/bSAoOXNyPbh+4FqpFazo7/UL9rh/eGwXCctnALbzcO2P+Y9a6hzj9wQP+zHP/fCNFOL4TJ86jdbHDW4kCGsv3YsW88x6t2IPGP5/SY01dN52b/f4BQLyQ4n+Y0F00Y1cK42V4WMBd8rnWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ss5XFq8L; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52L8DSub262220
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Mar 2025 03:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742544808;
	bh=zBkFyFej/LjUcEirj4ZJVbw1Q5NfS6rUgggc1XPBP10=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ss5XFq8LA0mUPPXeTRbGotDm6AdtwmosmwCG78Ii6kaD27XwhznnIYw8cVOGAJai0
	 R41m/8h7bQYy2ZkQEDEZtHOKNDy27ikNZDCJpob/7VBZC8HcsbNAeT6gze6wdXOtQY
	 51FxIdjWVmhBi2M+vQM5DI493skyDJclkwtYuZ2k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L8DSl1127629;
	Fri, 21 Mar 2025 03:13:28 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Mar 2025 03:13:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Mar 2025 03:13:28 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L8DShA130300;
	Fri, 21 Mar 2025 03:13:28 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52L8DQSt032443;
	Fri, 21 Mar 2025 03:13:27 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <dan.carpenter@linaro.org>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix possible NULL pointer dereference for perout request
Date: Fri, 21 Mar 2025 13:43:13 +0530
Message-ID: <20250321081313.37112-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321081313.37112-1-m-malladi@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Whenever there is a perout request from the user application,
kernel receives req structure containing the configuration info
for that req. Add NULL pointer handling for perout request if
that req struct points to NULL.

Fixes: e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for perout signal")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---

Changes from v1(v2-v1):
- Collected RB tag from Simon Horman <horms@kernel.org>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index b4a34c57b7b4..aeebdc4c121e 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -498,6 +498,10 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 {
 	int ret = 0;
 
+	/* Return error if the req is NULL */
+	if (!req)
+		return -EINVAL;
+
 	/* Reject requests with unsupported flags */
 	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
 			  PTP_PEROUT_PHASE))
-- 
2.43.0


