Return-Path: <bpf+bounces-55935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31213A89778
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D18F170A66
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6178284686;
	Tue, 15 Apr 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ge7XiiDh"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D523D2B8;
	Tue, 15 Apr 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707985; cv=none; b=Njfk6AYAR031nHQ8+ecx5VqwUUxkuTFGBZYto0qq5XcBilUo93wM3lAln5rBSYRXYdpNGLn2/dwQqAPxHj2H1rp5hUnNYsyBRMAyzfry7+twtUcyo6+TxZ6cBmGtMcCcUDhTsOH9vM6Cwwce0DGgUicBc5s8P+kznzbJuYrnhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707985; c=relaxed/simple;
	bh=mW44MhMfcqSVcbYBiNhj/W76QoOxOmnwJMag0OlHp5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVQB8wnFM4WcjtN2ZSNSA62wTUeqaqztycwoT6SBWsl9grqxi2iD8J7+GTXZ9jwL9q8785QTc4Z/9rQn7jdO4hSPeE6TAXZJM66t2tXsuuXNGqttzBU6vWp1rdf/Q7nsWz9EVKTYdK5fMU75NZDylvCLIZoIkvZ75tN/g+ovkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ge7XiiDh; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95qdf2436542
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 04:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744707952;
	bh=dhN7CQrE/5u72jpN7sVyLSCb0YI7IyBRn8sGikRoHfA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ge7XiiDhwC5PKNTLo8uuHDlFNUHS8RixNAZKY8l6niR0GWVS9F3e7Ek4DQ/UnY3dr
	 8XM8xi/s4JKWTrrTzsxgGeJLE3N/c0CfGUotwJGYktOMXA7fVey9H8dx/0z5XqGY3p
	 34+7HsTRvj7f5xCqk9RAKovUF1Tce0Zoapu1VI4U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95qic003107
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 04:05:52 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 04:05:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 04:05:51 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F95pki029255;
	Tue, 15 Apr 2025 04:05:51 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53F95owf010956;
	Tue, 15 Apr 2025 04:05:50 -0500
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
Subject: [PATCH net v4 1/3] net: ti: icssg-prueth: Fix kernel warning while bringing down network interface
Date: Tue, 15 Apr 2025 14:35:41 +0530
Message-ID: <20250415090543.717991-2-m-malladi@ti.com>
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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Changes from v3 (v4-v3):
- Collected RB tag from Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 14002b026452..ec643fb69d30 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1215,9 +1215,6 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 					  prueth_rx_cleanup);
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
-
-	page_pool_destroy(chn->pg_pool);
-	chn->pg_pool = NULL;
 }
 EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
-- 
2.43.0


