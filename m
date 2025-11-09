Return-Path: <bpf+bounces-74037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D33C44844
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 22:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6AF84E1E82
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EE25D527;
	Sun,  9 Nov 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEefhM+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BB24469E;
	Sun,  9 Nov 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724352; cv=none; b=HoSx0SLDeHsWgkg0RJ20SsNcQotSCMStM3OBnh5oFrJ+Q6b47TTWvKJ0kfIY0Ul3N/L8694RLhyYZ6wQBqtFH6abr657/WuR6i1sGsxMhhBfbNEk1r30xCBiEUlbPZZUn3J3UCNOYECGrvurb7+QMdnGX4gDLHUNB/BkNDfXNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724352; c=relaxed/simple;
	bh=kVgnVQO18a916rVySKF1mV8rRyJyvwESYEk0lLLgQaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iv0JD+PS9YFaSNFCUBs3XhH2Ad5bq0rLnV/qbM/qik4JMVu5KYJv2GLGOgIp0fNZWdYf/CAcGdbOklqvjthgMUXRATiiPENGVYMajejQ8yzAl/GhbZyfKnZOvXwGuYyI/GIeUeEhxtZJCFcv4QYZQZUzZGnwZ0Roj2zS+aAbs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEefhM+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECEAC19423;
	Sun,  9 Nov 2025 21:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762724352;
	bh=kVgnVQO18a916rVySKF1mV8rRyJyvwESYEk0lLLgQaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEefhM+wvXEy1rWWzumJC5RPb0gVAJSBqN7mRuhwxH8PvDdhBWgEqFwZStqMEMNF2
	 taGAZqeHs/RbkUh58PsASM2X92CWWgOBU29vC8wHuFqIVesO2YFSWtrDJ1g4pA9BWX
	 Ndwi6/JkinnfIsIFh+LYcbKrXszHMCzdV2Yb05W4D7wHhWEECCbELc8MHuaZoC9pbN
	 yG55Zlnv+nUJuyCyEbr40jdhms4NDQ30g/7UyhzZFAbnhtSqT3Rsd63NwqT37D79PD
	 J/AamRW5kFyj6MEW2UI68kpWObmACabj4HDf6WuqwSzA8XYRRMRJKoZqXpL+hqbqTG
	 JKvmi+4MlwgMg==
From: Roger Quadros <rogerq@kernel.org>
Date: Sun, 09 Nov 2025 23:37:57 +0200
Subject: [PATCH net-next v2 7/7] net: ethernet: ti: am65-cpsw: Fix clearing
 of irq_disabled flag in rx_poll
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-am65-cpsw-xdp-zc-v2-7-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>
Cc: srk@ti.com, Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=kVgnVQO18a916rVySKF1mV8rRyJyvwESYEk0lLLgQaY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBpEQnaoZQaCDOcP2jKXsqaIb7Y4IAM39JiwAlpR
 whm4N5Vn1iJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaREJ2gAKCRDSWmvTvnYw
 k+n2D/4n3QLBvZL+Ug6lzBiQ3yEIJ54RMQhXfWtoHhcZT+Wor3emaGkM+iZ3o3j+ObQhNfLnaH9
 nqj5dWuuKVXWirrXjeIcgudnU6FcaO1DUY8SH6+H3jAtspFAI0Ne/eaRWCMNtEgdWw+tjR6Hki5
 K/HF/m38zK2UzGqBPhSr/wFUiT7E94Xgvn30dEZEYJ2GMF0F9bDmsQLWkP12bD0U9M0Tkku8r3w
 YZbH/h+iY986+tLVcgL9bV72urrYlAFGtzfkoUzGwTD0CN0Gk8qsiDwPEfwAb/wpJMR1NsOhDiX
 RCa3Errmmt2VRD/ViOAbkobEfNRFsSGke6jrDeQ7VOeNJn6kIzrBtCDWZISg1orpImNpZLht1qF
 mBW2x+s/+/nJLMMTyZA1eo72nRW0gu+ugSQ0JIwcuvdTFPn67sV+LRwgJusoBUUyeUbhdquF/Y5
 EGMIRdGhkkVp+y4wSeZhmrWjyThAbUPh/ECj7mqphqLz4Ecd+osPOwtHjeQfZnJ+rXLSb+PAjqw
 7+J6wPI83RIPktGVBgGr7kLkPqmSSRCTgs6NEEwDMp9x//wKe+AN1+X/PS48nmxQF2kYsJCzZsO
 NxWZ3LNtNVHwlyhZR7SEvxnM1T77zq0r9uYfJmHk1iqhaaOaUBNk+HA4ER1KeBvte0Fc7iehK80
 Dnd1EZKdXkopKeg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

In am65_cpsw_nuss_rx_poll() there is a possibility that irq_disabled flag
is cleared but the IRQ is not enabled.

This patch fixes by that by clearing irq_disabled flag right when enabling
the irq.

Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d1048eea7e4734873676026906e07babf0345f5..c0f891a91d7471364bd4c8b7d82da9967f1753b8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1778,15 +1778,13 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	dev_dbg(common->dev, "%s num_rx:%d %d\n", __func__, num_rx, budget);
 
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
-		if (flow->irq_disabled) {
+		if (unlikely(flow->rx_pace_timeout)) {
+			hrtimer_start(&flow->rx_hrtimer,
+				      ns_to_ktime(flow->rx_pace_timeout),
+				      HRTIMER_MODE_REL_PINNED);
+		} else if (flow->irq_disabled) {
 			flow->irq_disabled = false;
-			if (unlikely(flow->rx_pace_timeout)) {
-				hrtimer_start(&flow->rx_hrtimer,
-					      ns_to_ktime(flow->rx_pace_timeout),
-					      HRTIMER_MODE_REL_PINNED);
-			} else {
-				enable_irq(flow->irq);
-			}
+			enable_irq(flow->irq);
 		}
 	}
 

-- 
2.34.1


