Return-Path: <bpf+bounces-42176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C89A0780
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B7A1C2106C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B517D206E7E;
	Wed, 16 Oct 2024 10:36:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF566B67E;
	Wed, 16 Oct 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074965; cv=none; b=boZUs3XVczc3ZdsFl4gqdN2ct8OKSO8zVVO4yr+fR66ro/7Cv9b0uPX9NPf6v+iW9CV0NvJQziRuC9PM0HyQUYBnRAzGn/A7GFOLXDyS1CaNlLHhht0kWbcRamWQ+CkFXBYhp+jv2T1pvR0PMeUWGjwKKDthl1YhDRINzQg9wFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074965; c=relaxed/simple;
	bh=hMs4Nlp5piHlMNWS23qtbOCe57gcJPPLsN2HQm/Rv5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsorNBRAKejbNEsvVfZxD1yyGpCfZ8C1yjmt2NTKyuIJjp9zqkmIwR3JPljU62tld6aTCbQfQ6lFSoRDDOl8t2MB0IvaF6NbSjnEfp+uEA6xhOfpgu9lzkIGXaT1OKLM8LfBv3xmeuTZwR2w1uvW52959In72zFoFX6nBErsXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XT6nX4DXrz1xxB0;
	Wed, 16 Oct 2024 18:36:00 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B4F6D180043;
	Wed, 16 Oct 2024 18:35:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 18:35:53 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<andre.guedes@intel.com>, <maciej.fijalkowski@intel.com>,
	<jithu.joseph@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
Date: Wed, 16 Oct 2024 18:53:10 +0800
Message-ID: <20241016105310.3500279-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
which is zero, this fix smatch warnings:
drivers/net/ethernet/intel/igc/igc_main.c:2533
 igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'

Fixes: 26575105d6ed ("igc: Add initial XDP support")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..c3d6e20c0be0 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 	res = __igc_xdp_run_prog(adapter, prog, xdp);
 
 out:
-	return ERR_PTR(-res);
+	return res ? ERR_PTR(-res) : NULL;
 }
 
 /* This function assumes __netif_tx_lock is held by the caller. */
-- 
2.34.1


