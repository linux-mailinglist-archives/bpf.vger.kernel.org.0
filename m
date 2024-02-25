Return-Path: <bpf+bounces-22652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA58862A18
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 12:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC26A1F21606
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CA10949;
	Sun, 25 Feb 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Kl/5+Vz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgRHsuM6"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD4EED5;
	Sun, 25 Feb 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861124; cv=none; b=ZrRbGYKM0N933twgbzIEVUHtEPHiyHBXIki1DPSIZHzhmd7yvXehvhjCsu8647DYLfLeMKzvIrzYPIWoiHs60i9pYPFX1lKmVijkKGSiHgJKc8Eq3pZx/BuumtT+Un+t27a3Wdl9uYbCAcFlJlxNeX/OHuYV83swPY1NW8mxPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861124; c=relaxed/simple;
	bh=nO+yNgUNWjiWE9FvprklDXQiq6XovnJDIndTRXHt+DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T+yrCuTAQNhgph63X4HoTn10AOjm6ScWfB83XoAUf6igovpE9DvepOc561AA0tpzGPKappcKRu7e4zQzRvryWtkNCvrLyHeUNGjatJfBWqGRJsUeQevBpxSPVvkKAa96rw+48YNPerjR/FPDdkZeiJdMj+i5pCsVo4ykHtuOUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Kl/5+Vz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgRHsuM6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708861121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nd1jp0ik0EQ8lB4/a6qsMXOn4vrUpwGeAyAe+L+hO74=;
	b=2Kl/5+Vz2RGNX9IRizM/tRprQhU4nMEu8+jdI/nwr0dXIDCI62kr4l+QhcvCILGd80SVaH
	DC6u8JNDYaV8iyBldD0qlo5h4WrY5VxvkXSaCHnyiQPaFZ4olgaaE7RvlUFRJZLmFvup1+
	L9V+9ahaQwCwwiqymU0U+TkTwOotKgFoV8Igi6UdB5SeTQVvcuriXBpmHaEyDZv9P2sq6X
	UBzw/nn3eJpc1Jkm4FG3kA+zUxiLw6NAdPiBQEEa2yYCnlA9tLF8gwx0PRZQ1BfiDBEvQy
	uzcPKSylBqADmG/yWPx7kCYxMn6bAvojJCnA6NlXeKR78N/ZMXaWKrGpMkQwaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708861121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nd1jp0ik0EQ8lB4/a6qsMXOn4vrUpwGeAyAe+L+hO74=;
	b=bgRHsuM6ku0+shTnNChydhV6wAmCSP/Ocbdf6eZIfn7IMUd9PaXfAho5W4iOE/wlPp2jjW
	CF5eHWjPceLFAzAw==
Date: Sun, 25 Feb 2024 12:38:37 +0100
Subject: [PATCH net v2] net: stmmac: Complete meta data only when enabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-stmmac_xdp-v2-1-4beee3a037e4@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALwm22UC/22NQQ6CMBBFr0JmbU07iiIr72GIaelUJpFC2kowh
 LtbWLt8/+flLRApMEWoiwUCTRx58BnwUEDbaf8iwTYzoMSzREQRU9/r9jnbUZRVScapSyXNCbJ
 gdCRhgvZttym9jonCdoyBHM975QGeEjR57DimIXz38qT2619kUkIJqixaNNebc/L+Zv9JYfA8H
 y1Bs67rD1hDlJbGAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=nO+yNgUNWjiWE9FvprklDXQiq6XovnJDIndTRXHt+DI=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBl2ya/itUaWlWcQlzoS007kcDGfWCQqL9H4sNex
 3nznKAs996JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZdsmvwAKCRDBk9HyqkZz
 gq63D/9a5xGEBWftDOSIqgb07v1rM8qCP849lIzLis3u5Ys3mwrMSOkDkpj7seZVvzwdqLlMQ5H
 3kcwf6QyiEUXWtabPlmdv2tlBWvmnNS5zQMxu+mlnoC4RS7xAarFnIzcNVaWijGQVpKnfsq69h3
 ZI41n+YI0h9qFJzVObhyifR5u8YJuvzxzHLWsi/npuyGNPYLaWSlS0TL5n5uyDqqH6Kg2KaR+PL
 lTjrwlgNpyKqLJvziYwNDijD0EEmf+7BLYAwDpdD3Pt73WCvpqmKds/M8Khp0qbSwiBS5D9iLRD
 5dAlmBG9rpZ8Kr6Y1DtYy72//A/FKECZMbt9HZ0mtIRVfBTyEOnJMmIbvuCbi++KLOa+jsEtOFH
 xot8ftlqcJRQD5oSOFjBi7LAzGRzxJsMlItbwjNx7pP90dePaAh3VJFGalLtWHX/Rk6/25MIIIQ
 hgvnGsXM/ODxS1FqXLl40YJqe/r0+YzGY48UOWGNuDihY9P3/cg4RhbQmtuVveN1Oz4ap3QDaEN
 x+Q6johoucfQ5yFexV5XjUs9VzCfWCOefLfRFLV/u2zgY5+Ob2YjpQ+B1p4AmTiddeEduUBieyK
 T9TOcWTZ1R4pFX0JnT/TGcJTV+tPJnkd9c6CbeDyzNZxwWAfxHQqDk0RBoseQ/gqGAQJ2/AyhRY
 3QO4vT04ftJz5vg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Currently using plain XDP/ZC sockets on stmmac results in a kernel crash:

|[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
|[...]
|[  255.822764] Call trace:
|[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38

The program counter indicates xsk_tx_metadata_complete(). It works on
compl->tx_timestamp, which is not set by xsk_tx_metadata_to_compl() due to
missing meta data. Therefore, call xsk_tx_metadata_complete() only when
meta data is actually used.

Tested on imx93 without XDP, with XDP and with XDP/ZC.

Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/netdev/87r0h7wg8u.fsf@kurt.kurt.home/
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v2:
- Add more details to change log (Maciej)
- Link to v1: https://lore.kernel.org/r/20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de
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
base-commit: 2a770cdc4382b457ca3d43d03f0f0064f905a0d0
change-id: 20240222-stmmac_xdp-585ebf1680b3

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


