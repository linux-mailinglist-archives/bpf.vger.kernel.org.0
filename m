Return-Path: <bpf+bounces-38974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E6D96D16A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047651F23898
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8951991D8;
	Thu,  5 Sep 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bmQlvThO"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFB194C62;
	Thu,  5 Sep 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523670; cv=none; b=A8E+Ab3r7KiUzZgSyREIRTAs7QSk99wphP7926UKiHZk7a/GXclfMgRMC7QSfAKMaTEzClb2DHpN4eAjzXSgYzf/y3ZEDukF5/IXgfnpgicpSuAm93Ac3LZib0e/TrGfHeDPDIcASp+9+eBXzHq6T+VK9TZG0ZtP7ndF0DwNqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523670; c=relaxed/simple;
	bh=4EHbVjgrbM4gptUSpJ4jRNEvyauzVndDJ1t4bEyXPak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EhO+1pqtpYrkCcCHUyAeRRho7vAQdRpiNCfNkYiileurum/ybPXYPvnRfQn1BsDjctduaS1lS0ped9UrDvzgVknDSK9XGgFP8gAcsaMPYlucXYs5gVw+UZZkZp7BBOak5WEoWemC6BuYgCVEsFnzAiwXmDGlgOuwCWUqgK2RA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bmQlvThO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523668; x=1757059668;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4EHbVjgrbM4gptUSpJ4jRNEvyauzVndDJ1t4bEyXPak=;
  b=bmQlvThOYIED79UzkZ4MiCb1hmsuaXSUDR8GxL24mgJ+cvMdqYegunG/
   /XNN8NALz4eELKg+sQsMgtZwVhmd/Q34QCIQPvgpQPih1XbQOhbp+xDX6
   Rge3p1fnoyzFdCUVk6zaX71Z2Ok35xyglMa40A8II5UHil0dUSWOB9vzy
   Y3MZc4MtOf819VGCW/qDgJnhFPvlpAOkz4i0CsZVol3xBL7h2OIhfYveN
   53+RT+jEzkMt6r55gpjeZAzgOrP3taoez+ICbmB0rGiCmaVxL7QZS8Ax+
   VexZ7dYxNZ6D3xgilurXjTI79kAeim4T4p8FeDGpOMwq03OJpfhfAszks
   w==;
X-CSE-ConnectionGUID: 7ewQ9CGBRIuJm60AkmofCw==
X-CSE-MsgGUID: WKsBOpblQGWUnCN9VrytPw==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34454184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:07 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:34 +0200
Subject: [PATCH net-next 06/12] net: lan966x: use library helper for
 freeing rx buffers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-6-e083f8620165@microchip.com>
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
In-Reply-To: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14-dev

The library has the helper fdma_free_phys() for freeing physical FDMA
memory. Use it in the exit path.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b85b15ca2052..627806a10674 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -114,18 +114,6 @@ static void lan966x_fdma_rx_advance_dcb(struct lan966x_rx *rx)
 	fdma->dcb_index &= fdma->n_dcbs - 1;
 }
 
-static void lan966x_fdma_rx_free(struct lan966x_rx *rx)
-{
-	struct lan966x *lan966x = rx->lan966x;
-	struct fdma *fdma = &rx->fdma;
-	u32 size;
-
-	/* Now it is possible to do the cleanup of dcb */
-	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	dma_free_coherent(lan966x->dev, size, fdma->dcbs, fdma->dma);
-}
-
 static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -1019,7 +1007,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
-		lan966x_fdma_rx_free(&lan966x->rx);
+		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
 		return err;
 	}
 
@@ -1040,7 +1028,7 @@ void lan966x_fdma_deinit(struct lan966x *lan966x)
 	napi_disable(&lan966x->napi);
 
 	lan966x_fdma_rx_free_pages(&lan966x->rx);
-	lan966x_fdma_rx_free(&lan966x->rx);
+	fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
 	page_pool_destroy(lan966x->rx.page_pool);
 	lan966x_fdma_tx_free(&lan966x->tx);
 }

-- 
2.34.1


