Return-Path: <bpf+bounces-38973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3009C96D166
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBACFB22B33
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7651990CE;
	Thu,  5 Sep 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UPgth385"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35393198A01;
	Thu,  5 Sep 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523659; cv=none; b=aE7smvP4scMkC/OprWxtBm1PK/BdmUEXjOzdG2ydOodd7wLJDPXw1wxWuZJxT648JeKIqjS8gT7QvUJFva83Sk9qWauuPP+0HM1XJNqebUTy2dfCCzf/oNL8nTC+0y6Ohx3x7/G06qlOgoq/QJy8ulHTJCM7kETWnJL5Egx6gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523659; c=relaxed/simple;
	bh=b62wxCPphkMNdqIp8IIYXA+kiVBzUNTWDMg2d+BTP+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rwNoxLakPHkxNRsG0LgQhr+rXxVi4IVZCUBzjZEFY2nonpywDNVMmLz1RO0TxNfu7Wd9QX6EwWsOoGOFA6i0hGlIFPMEU8dpf/fuL75UBhvWkflPGnB/KFCD168DkwOcMDY89hP07Oze6KF0DG7IptlAXccr1xwNJZrZscT7790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UPgth385; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523658; x=1757059658;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b62wxCPphkMNdqIp8IIYXA+kiVBzUNTWDMg2d+BTP+4=;
  b=UPgth385ZtJZcc93KE7JsnVaQ0P8FYQxdhsCqBBD6JWjxUkYGicBBEW4
   LS+ys/pg0e8xQTYxiWvAGV/4ngMgJOFW8No+UNaM0Nbz/4n8wxpG68RK7
   VCOy7UxyBAiW1Nv4Ns2zteFMKdfDREqmUYr8qJU2+syiCu8yAARQC5WVT
   /Gcx5WOIwPl2hme7Lzb76mFx3BdTKa6kcSXsGn1iDqfvLt7e305ujWlf4
   fze14P+WkgqpB0/Nitnt5uy4szvnRlDsH3ykZP7hrWtgadV+gmUYszgdq
   3D2ulD8ueYSdW8gdJvn9R2OolXhp/BXI5dTEuXUvi2PYnnJ/m57OANNU0
   A==;
X-CSE-ConnectionGUID: gT0AKMfBTO+XOzKg9t5R6Q==
X-CSE-MsgGUID: gq38b+0mTuCmHABD4cTGww==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="262316465"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:14 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:37 +0200
Subject: [PATCH net-next 09/12] net: lan966x: use library helper for
 freeing tx buffers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-9-e083f8620165@microchip.com>
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
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 1beafadce87a..6f7e3c27c1a7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -229,14 +229,9 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
-	struct fdma *fdma = &tx->fdma;
-	int size;
 
 	kfree(tx->dcbs_buf);
-
-	size = sizeof(struct fdma_dcb) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	dma_free_coherent(lan966x->dev, size, fdma->dcbs, fdma->dma);
+	fdma_free_coherent(lan966x->dev, &tx->fdma);
 }
 
 static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)

-- 
2.34.1


