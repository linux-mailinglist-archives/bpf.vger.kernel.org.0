Return-Path: <bpf+bounces-22493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB985F4E5
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F22A1C228B9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBA3A1CA;
	Thu, 22 Feb 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWlwlCPH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxGKK76k"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4432383BA;
	Thu, 22 Feb 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595135; cv=none; b=U34GG6cr7z2B3ZUPRD55l0jG8AyVs/NECuQEXMqr6xxOWGh+TGy+Ib5Jj3k8TfDfLIktDONzQOtR8j927njyarJdcqeEAxrIN12OG2yVeUY/+GW4cvLpaATP7f0xqNKNQwIkO1gm8ckY9iAMpq6lv1dp90oBejWxzXW/af1QDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595135; c=relaxed/simple;
	bh=+uP4Aru1jO+hGv9BqKIcoveDNM3YshsEp66xmEqSbno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B1NPUGM+akC9686BxlOYi6GIqU9lfGL4vqapgAUQRyFXCVQBPyzhhCCZAitG3msn70OyZUSteByA0sxeEWa0bUtO2aToF/k4q9lRQP1QHUzRlOmmPiI2WBLUPBV0Sb3SoH/ABPSIz2Mchvppk8T5f4rMkGDtSp78iYMzakfwsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWlwlCPH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxGKK76k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708595131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hDPIpDaJ04CEUJVADkl2USSeO4nobgJA2IAQrE2lwHE=;
	b=MWlwlCPHtPUyElbQv/nVU2F1JnjJPVHNU1v4NMGQVnceTPlYBmk730QRsnUAbF5Bouw0b1
	JTjQUIj4wG4y14dr34p4CO/QwGOtWJ6PeVYq69oTsT7DD5rcXp0utZDgqicu1QLOfnjcR8
	mSjabYhLhcuQnvGjbUCtooPIMWyEwIHQ8eQ3qfvtuhM5tsbrEMp3Oj2+JAv/pvilHPRNyY
	bcb9rCFScggMxDNfgoMIGWC/iFnwLbcxIQ4u7fZO3Bal8PwPMcBbBxQy3Xp3R6skTfo69g
	EXH7K4mZb6MWNLaWMKODzSHY1cIfip3+iZkkA3zWpnjNVD4iSfzXetDZ6nV1og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708595131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hDPIpDaJ04CEUJVADkl2USSeO4nobgJA2IAQrE2lwHE=;
	b=MxGKK76kOYzpcuMnnAUCOVbNmESzHb6aCMutTvsQLIIUHJP23j2DIJOSXjviCIuu6cdl1R
	WMZvWpOyK0iyVEAA==
Date: Thu, 22 Feb 2024 10:45:24 +0100
Subject: [PATCH net] net: stmmac: Complete meta data only when enabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALMX12UC/x2N0QqDMAwAf0XyvELN5pD9yhgjrVHz0E6SIoL47
 6s+HsdxOxirsMGr2UF5FZNfrtDeGogz5YmdDJUBPT48IjorKVH8bsPiur7jMLbP3oc71CCQsQt
 KOc5nksgK6ykW5VG26/KGzAU+x/EHwB3qpXoAAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=+uP4Aru1jO+hGv9BqKIcoveDNM3YshsEp66xmEqSbno=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBl1xe5krMQNx7AKgDQ6kfscGrcYyY+wgvhNsbdr
 Kmy6KpDJkCJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZdcXuQAKCRDBk9HyqkZz
 gtgZD/9wcuhH+3J6snCA+Xn8jYNRSY8o2hCaqYmzqiuZynWNp1AnKnPkyPthIVuAEISiPfb0JBA
 PnX2WzT7WM/dtNW/XlxuEsMvVc4Lm35eIWmmpHJHJ1AUgMeXddxYuahrST726AQU7+QWptGBkEE
 BMOSuJ/rEfWDUZNOR5twXV/O9UoHQ7EAnUIMTOuIwLerhi+lFXwC6wSsGLKmjiS08wUT83BYzlf
 NgQDZy84CxY2fuKV110GB8aRS7pju8paZtZJhL8CFCOcNJ6aq/nZdqV4Fa9H357eIQlqqHLzPOx
 fE1dYu1xPhKErWfn8vQCfLWgz2lHEogDAPHBR8ZFnrSPgbhc9DTBjA9h4E6iO2ybC3i6H7/zWLX
 yCJEG0n7jXeKPS+Zf+DridZyGPdKgyKBcClPaikmc9HBK08EvmegFSHGA1zkiNxjAgt1LKquSJ1
 IUetlz69p/YrVM6Qx9V01sPejfbeFviQRl35RObJWpopx9ug5n8W2ohr6DNszdaxKjE8ju8EJh7
 x35G4bx8HMPRbl68atdLaeStK+15pDdwDPZWAuojghO31sk6u6MuSlQjgMjbKAlEZ7NjyupFlQU
 B1Ayqlho+unvlf49pa5YUCJ8eULvhvw2Eh/8j7YC5nYr2eYRbrHI2kzgSPRJ8k1ccK4RUJ6V9Bh
 91tc+TF+qX/qSKQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Currently using XDP/ZC sockets on stmmac results in a kernel crash:

|[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
|[...]
|[  255.822764] Call trace:
|[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38

The program counter indicates xsk_tx_metadata_complete(). However, this
function shouldn't be called unless metadata is actually enabled.

Tested on imx93 without XDP, with XDP and with XDP/ZC.

Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/netdev/87r0h7wg8u.fsf@kurt.kurt.home/
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e80d77bd9f1f..8b77c0952071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2672,7 +2672,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			}
 			if (skb) {
 				stmmac_get_tx_hwtstamp(priv, p, skb);
-			} else {
+			} else if (tx_q->xsk_pool &&
+				   xp_tx_metadata_enabled(tx_q->xsk_pool)) {
 				struct stmmac_xsk_tx_complete tx_compl = {
 					.priv = priv,
 					.desc = p,

---
base-commit: 603ead96582d85903baec2d55f021b8dac5c25d2
change-id: 20240222-stmmac_xdp-585ebf1680b3

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


