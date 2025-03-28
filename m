Return-Path: <bpf+bounces-54848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944DA74824
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AE816D3DC
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4321A434;
	Fri, 28 Mar 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gsGV9xaA"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E7145B27;
	Fri, 28 Mar 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157488; cv=none; b=piosKOIzo575wNG+MqU7HGX9pXA8e+cDtIxQKkYV8aYw1ubXeMSF/LG2JTZgzYC9krEW0nQT0wJhLK/ccfU+byr1AmVmXCMxXGZW2Dol6O16yMB/QxlS1slQNXphbSDffF8THKzJ1maJWq3pYA/UC+HKD5TFKWGJLeq5+kU/6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157488; c=relaxed/simple;
	bh=iVw60BEA2krbHbofHTYSpqiZR94LQ81lsSJtwSYv06Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be5khWyFIUdjqN+QrRNuALsce/SOJygqM/ZhXLtw+E+MZQWE/8kUdjvD6m8OJeaE4eGkDd6bOtXKxSyHfvHirh1gdPWMdrUIAn+foUIwZn/yuJM7HvWEeVOGNhKi5quzNEpm28otpcZeIIsWtA1LpSbiKYlK5VuNA76wVeJIY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gsGV9xaA; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAOBEY2125516
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 05:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743157451;
	bh=WzSH/o0yISBtN/3+MZcetAOZsEZpTvcCbzXAjwOkb8Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gsGV9xaAHMmPy1rHi1dOhCeZf0FE7F+3XKD2NykL5ccYevwcPWBR+9GToP5hK7M8d
	 G1hmiYmginzjO83ypN57ryTPqRYDDoyfk8y7MnUsIxCAPKuad5dQDjdEQ9+r+xn8C3
	 O9EUSdLsDqSJiRp35M7YbyLKJaeUTJm+Cyxag3ZI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAOB4H079346;
	Fri, 28 Mar 2025 05:24:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 05:24:11 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 05:24:11 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAOAAv080265;
	Fri, 28 Mar 2025 05:24:10 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52SAO9gB024929;
	Fri, 28 Mar 2025 05:24:10 -0500
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
Subject: [PATCH net v3 1/3] net: ti: icssg-prueth: Fix kernel warning while bringing down network interface
Date: Fri, 28 Mar 2025 15:54:01 +0530
Message-ID: <20250328102403.2626974-2-m-malladi@ti.com>
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

During network interface initialization, the NIC driver needs to register
its Rx queue with the XDP, to ensure the incoming XDP buffer carries a
pointer reference to this info and is stored inside xdp_rxq_info.

While this struct isn't tied to XDP prog, if there are any changes in
Rx queue, the NIC driver needs to stop the Rx queue by unregistering
with XDP before purging and reallocating memory. Drop page_pool destroy
during Rx channel reset as this is already handled by XDP during
xdp_rxq_info_unreg (Rx queue unregister), failing to do will cause the
following warning:

warning logs: https://gist.github.com/MeghanaMalladiTI/eb627e5dc8de24e42d7d46572c13e576

Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 46f500b90b17..3c0ea9044e18 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1215,9 +1215,6 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 					  prueth_rx_cleanup, !!i);
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
-
-	page_pool_destroy(chn->pg_pool);
-	chn->pg_pool = NULL;
 }
 EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
-- 
2.43.0


