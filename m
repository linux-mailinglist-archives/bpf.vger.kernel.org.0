Return-Path: <bpf+bounces-38978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B596D178
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFDC1F23A62
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDD199E9A;
	Thu,  5 Sep 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IUOifNLX"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231E199235;
	Thu,  5 Sep 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523672; cv=none; b=mHx71tSaNKwmCUo/i8954gNfUcPWYB1bZ8BhfkfipQZDOsYRfTd+xQohlqDJkU9PlZQVHqsmtSTwuRMS/+8I86jd4fLw0Q1U28YydVt3swgeokm2o8lJJVFCxrHIwdzmEDIsLXccTjMGbb4BwxkOhN0DRcz+nFlVAX+oTZYAUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523672; c=relaxed/simple;
	bh=enBgGVDxXDeOvUWp9Qkmhe33qeG2l9fMYt0BhW+oop0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o70eCRycixFG3EJDG2+sYxlpdxj8zSnn7u2APXdj9w92Q5AVNUEw9A11pXxUsA7VOIGuf4lwuYvHGQApv3CWnG1cXJRPlSUqrf34+ZO6/GaMIgvQ3r9cjYpKu1uE2KGvJa+1hqd/wdL6FtzEHAinhb6Wy2ZuV3AFg0QHqYRuHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IUOifNLX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523670; x=1757059670;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=enBgGVDxXDeOvUWp9Qkmhe33qeG2l9fMYt0BhW+oop0=;
  b=IUOifNLXvca7jmWFsALdPVQODGZXh7EOGRyPWMTIZru6cdv5Vy0sbioh
   p9DbW0HKt3lAipqA/sZNnF+Zr6isLTZ74TPyD+h7tw4k3JfX2m7ZThbJs
   IIHojpSQBH620Hr66Nnvu9FIQRJuhRxS+Ug5allY0wgDBGjgG1UpUjvjY
   WnQqa/sc91ZjpkDVxB/bOzLa8ayKRr4w0CBJdbiNLtN/FLPHrTVlVMxPh
   l6+QlbdzahRPYs/WrdGwW6fipe9GSsDSo7MysczVLZsLsKGR0QIq3+YX6
   Nsb5wsU089GJorm6L7I5SeBAUltlpC7TdnhPOGT0ZZDbNZ08BHL8jvu6x
   Q==;
X-CSE-ConnectionGUID: 7ewQ9CGBRIuJm60AkmofCw==
X-CSE-MsgGUID: njXZDGOkQmqXJF8nseyeEA==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34454189"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:22 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:40 +0200
Subject: [PATCH net-next 12/12] net: lan966x: refactor buffer reload
 function
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-12-e083f8620165@microchip.com>
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

Now that we store everything in the fdma structs, refactor
lan966x_fdma_reload() to store and restore the entire struct.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 4c8f83e4c5de..502670718104 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -810,14 +810,11 @@ static int lan966x_qsys_sw_status(struct lan966x *lan966x)
 static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 {
 	struct page_pool *page_pool;
-	dma_addr_t rx_dma;
-	void *rx_dcbs;
-	u32 size;
+	struct fdma fdma_rx_old;
 	int err;
 
 	/* Store these for later to free them */
-	rx_dma = lan966x->rx.fdma.dma;
-	rx_dcbs = lan966x->rx.fdma.dcbs;
+	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
 	page_pool = lan966x->rx.page_pool;
 
 	napi_synchronize(&lan966x->napi);
@@ -833,9 +830,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
-	size = sizeof(struct fdma_dcb) * lan966x->rx.fdma.n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	dma_free_coherent(lan966x->dev, size, rx_dcbs, rx_dma);
+	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
 
@@ -845,8 +840,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	return err;
 restore:
 	lan966x->rx.page_pool = page_pool;
-	lan966x->rx.fdma.dma = rx_dma;
-	lan966x->rx.fdma.dcbs = rx_dcbs;
+	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	return err;

-- 
2.34.1


