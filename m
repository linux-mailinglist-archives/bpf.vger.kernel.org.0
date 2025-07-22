Return-Path: <bpf+bounces-64049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FBB0DBB3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3CE1C82824
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C12EA48A;
	Tue, 22 Jul 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjSY5jRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3302E9EB2;
	Tue, 22 Jul 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192280; cv=none; b=QZR7Xx2sI4+aXyDIWjFTIg/3Sq7YozQsXrc3elewD6v2P1HTmSPl/teSjgCPFIulqpNr199e5o3VkNUfxDknetsdydtJ+PVUQlde3RFZJJdtqaiSZJ3CEVV9xvRqS65e6mcsnAj5z7scbYEWOMhDvZwLOMoDWG5gc+7uTXa9t3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192280; c=relaxed/simple;
	bh=6bSet/jIs4AZjrA4QRVRmCjsLnxcGRbNF8XwvVtogmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmGaUJoEae7Hd/IWydOSV9QTC7WOI2N+PuP/rzoFIds/vgea0MWjtiGN9P6UfNLnBAFY14wvY1XWDFeWRckmpoWDMJmWAJd4jxA4Ic6lF/Psui9EqjILxuxevsXEyGHpeynMJyj5GKdyK+ad1WDUw9U8E8pLZfwPt1ARRklHtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjSY5jRo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74931666cbcso4467022b3a.0;
        Tue, 22 Jul 2025 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192277; x=1753797077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfSN2l4c7VqJYrvavlefqicQxHjGsCFmso72HdHciEk=;
        b=HjSY5jRo/BeMYuJCeqrOCQfvTYYgz1j7+FknAWT8h11WdQjPKYJR2RVogQVmpQqXNl
         nDMXb7VttjEbdJhTWyoVco/FZ+X/bUoPLK/cLLJ/lS2x/FUQuw4qDBMFIfuw7iGI/wFt
         mtEtNwcYBWQFKfRnY8TVzcgwrGIq0TZ4oQ+8FPNhB84critpTXq76Fzzqgw3VvXQiwO9
         5+3oe5pgKl7RAumT7Ls8jN8HSMmhF0K2E4HcqWEEc3cFD41lfq5sKdjd25lWdOBcLcix
         /0Eta6rcX21PVYylMDrsSxyyXkaBkh8AylohyUWSG9POh6pc49r7SIs56tcNX8SpNAX1
         8cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192277; x=1753797077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfSN2l4c7VqJYrvavlefqicQxHjGsCFmso72HdHciEk=;
        b=dfXDA26RbvF2jbjpz+eGDYyzHUxs6WAxIr8r/Af9yp3QW0CVhnoRJNVOux9kWA6HjC
         BXbNMBU+NBtYC78sjPKyRbvdxxwrCvhRpZ8XgzVOjwvZfwBkQxyx+lVXQ4BqFh80aCeu
         K9mH/NEqMN24qWza9bEQ9ipLsesxfQf7RDFSPVgQZ4JmyPdw5fC1Ejna7eC70FeVJF/W
         OadcTOzNxXxIxto6rYdtvu/mLD4/P+PkR0kR+xIWi4+zrIQmc1KS4EZHCRB99VUpie60
         VkBWTLLrCayXoY8XBiVSGmr13XIAaPjNiLIF+WICzucn0zYPbL3v35YhvB1dzmZM/noO
         W0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUx9MNllUDNjTWhZlP3qYZ6nah/4j4N3pDe6/M3VJCmi+ZUqAr4yHbScNcbzqK5paFtnbM=@vger.kernel.org, AJvYcCWQ8MfNBT++nIj1USPfymwR2TNACDu0loFFJBeeKX7AfEXtZvlG5xDzQ8P/P8QRTnxrdKaOxtIy@vger.kernel.org
X-Gm-Message-State: AOJu0YxaecRmtcg1JMEo2LGyAoqnkgx8ymHUDzujg2PuR9xCJfluqtyk
	+qI1frRP/dPGAfn3p4kkGauEIO4hgX9TyAvb8YHNkv1kY35zHPBu5s+9
X-Gm-Gg: ASbGncvJzdK7g3/iSL43V4EYTsilYZsFIwlkkX0IdSlbwEeh3V38xTZqk9O/pT8E23t
	zHrTS5oDZX3k1BDhLNrqmJlnkm4vh7/iCiSnMUvQnx/3e7jS08PxJYOI4EopYRFjrh+1Eh8hsLf
	z/MWH6ZeSXcLLcunmutVJqWXoleMdfeVTSc/FmqwYWH4fBUS4SY1d2agZiJqO563SB35TfKfAFv
	QcG5F6TGL3sgtRNF2IgHsMXaj6aB1YGg9S4jDf4ZpmdhML3hjrALRCA6LnHl8WQFdkk1ZuVBOcW
	9Ray5tNgflbjOLXKJilEXB1deil9rPNHZWoaxARBKTitg+Av38i0NZKsgYjnWnJLJRd5c/rZGGk
	SiufmJtadrNDbsm2oD2rd1/4P1moRDir22PqYIdIyHG6T7pzn5r/l6b8TCMQ=
X-Google-Smtp-Source: AGHT+IF1txECS8N2+rVOMQa6ZXA3/XztzaqWOOy2pOPBvGSGpz/Xa4Hvd3Atqdn/nx9Z2GxJpZQmWw==
X-Received: by 2002:a05:6a21:2d8f:b0:232:7628:9968 with SMTP id adf61e73a8af0-2390da51452mr32513911637.1.1753192277309;
        Tue, 22 Jul 2025 06:51:17 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm7612924b3a.39.2025.07.22.06.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:51:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 1/2] stmmac: xsk: fix underflow of budget in zerocopy mode
Date: Tue, 22 Jul 2025 21:50:56 +0800
Message-Id: <20250722135057.85386-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250722135057.85386-1-kerneljasonxing@gmail.com>
References: <20250722135057.85386-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

An underflow can happen when the budget number of descs are consumed.
as long as the budget is decreased to zero, it will again go into
while (budget-- > 0) statement and get decreased by one, so the
underflow issue can happen. It will lead to returning true whereas the
expected value should be false.

In this case where all the budget is used up, it means zc function
should return false to let the poll run again because normally we
might have more data to process. Without this patch, zc function would
return true instead.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20250721083343.16482-1-kerneljasonxing@gmail.com/
1. target net tree instead of net-next
2. revise commit message
3. use for loop to replace while loop
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f350a6662880..c4cd4526ba05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
-	while (budget-- > 0) {
+	for (; budget > 0; budget--)
 		struct stmmac_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
-- 
2.41.3


