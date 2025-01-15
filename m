Return-Path: <bpf+bounces-48950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F386A128F6
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38D3188292D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE51A239C;
	Wed, 15 Jan 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPlrx8fS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031F1991AF;
	Wed, 15 Jan 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959392; cv=none; b=MN5i2D0QumdSeO5AEDvyq+EjfMb3DiIfQ5dDA47E5zjz6nD5sdteAAr49sDnkXZscoauIrwEO2ZIL5/wW6WuMotv/b77qJFYIdFX2T9k4jhUveqnVjeli3MYd7+mmDFLvYkAPxL6byIaGSWm05a6TfAYC4LRQ1iM9FhVwNjlTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959392; c=relaxed/simple;
	bh=FF7NIpBO4KNtHeGTTIJE41zdUxNi60jZir5WWjnpILk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVspGhXg6NnLzRYzJl7M5zi6DmGu/BwI9QYzzKH/h3SdEMCBprSdzKHQzjMFY5BYjDIXjT6vNRuwdDTx9KB/Z+hTCKYDNLgvRW/WT+cUsZgBWBwDVj/bkdz8Bi85stdpbAO+pFegpD42pAojNnoo1JAVZpHg7cpE4CZSxWzgzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPlrx8fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2943AC4CEE4;
	Wed, 15 Jan 2025 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959391;
	bh=FF7NIpBO4KNtHeGTTIJE41zdUxNi60jZir5WWjnpILk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KPlrx8fSXEc5xHJmhEurTM/TLNgafiQCVLYt0ceAMNkjyyExLivfJn4EfP+qog8PB
	 SoePhXZhMmiVE9LwydmBwQ1I6zlO2fVtt3LNePJLRTp81ivcgToX1WaLzz31pK4ATP
	 x+e5M1a1l2Wq/FXmT2YRRhhkqsgI6bFwYDKdRZA0F6Oo5dBun/iDTsxCDAnW/fgG9/
	 3tWl8EFe8R+KElIiu8/CSKWBkIkLqbSKrQgv4PA5QDuWWmgijK8CGevKC/MnkvmXsT
	 tHi77RJfEBswnG91tkRDG8QS9zP0svdt+KaS48mPCYrdR9HYcPHz62IOLAKkjbCuAK
	 ENLCr3jNjY/ZA==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 15 Jan 2025 18:43:00 +0200
Subject: [PATCH net-next 1/4] net: ethernet: am65-cpsw: call
 netif_carrier_on/off() when appropriate
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
In-Reply-To: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=FF7NIpBO4KNtHeGTTIJE41zdUxNi60jZir5WWjnpILk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnh+WXn6RHnacu84s4TbA+fl8R/CJWNLPes9QHC
 n+dfp7NMnyJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4fllwAKCRDSWmvTvnYw
 k44cD/9BwXx6NOhJS1PPFmdglONqDlAJZvvtVbb1gOeFqyDIZyVtJXWOehNpcQdqcscohBHCOmT
 UmZpOAyiGjTf2Tq2k8rfUXDbyTi8+3Wb2noJf1uRAtLIjD92uGk53fN7TNLB424Pxe59HKAX4ki
 CJQ/mHEKhHtfKFVNHLEd6IGzrttGn+xzPeiAzE8YZguWOhJ70I+EGb8OzCEt7siJIL+OwJwvg35
 oXLyxuuoI5MV21IWquUjG7y9MNPJkLc55gH1dba3EHlCQ3mzukjacRy3Rn/GhQnUGLJRhPUcQ7i
 Fmhv/2wI+9WKmQR3RCRdF6RIYBzNiYFarogx0BocPu06OcnfhpHiSQPOna77zja/GL+mGg7dmpf
 268H3jXO4tNOz9bxqyDAaVc4bQGVuDhKiSvX5VcF/6k4ZgpPBNnPZXcuxeoBFH2OM/MpIFH0Bi+
 Q76UQvU1oDn9xHORInoilv4hSeKZKZ9JSVftEbVh97HFFOU08s9N1NxVoG8Hfua2J1maWqPbLel
 6kKq2Ez1FjizJwwoMrHjtKPCioqGJ5sKMXAKAftjJSXaWYWzdB4wc/D2ROzzsJ5gaCDnLXg+27O
 nat1ZSpVo0/pVvHzxHx8L84VG5h1tsZIuPm6I4AOmHlINFcJqU7P1VO4BUfT8go3782ttX4ltVt
 xTe0pIQ9ChAYgWw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Call netif_carrier_on/off when link is up/down.
When link is up only wake TX netif queue if network device is
running.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index dcb6662b473d..36c29d3db329 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2155,6 +2155,7 @@ static void am65_cpsw_nuss_mac_link_down(struct phylink_config *config, unsigned
 	cpsw_sl_ctl_clr(port->slave.mac_sl, mac_control);
 
 	am65_cpsw_qos_link_down(ndev);
+	netif_carrier_off(ndev);
 	netif_tx_stop_all_queues(ndev);
 }
 
@@ -2196,7 +2197,9 @@ static void am65_cpsw_nuss_mac_link_up(struct phylink_config *config, struct phy
 	cpsw_ale_control_set(common->ale, port->port_id, ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
 
 	am65_cpsw_qos_link_up(ndev, speed);
-	netif_tx_wake_all_queues(ndev);
+	netif_carrier_on(ndev);
+	if (netif_running(ndev))
+		netif_tx_wake_all_queues(ndev);
 }
 
 static const struct phylink_mac_ops am65_cpsw_phylink_mac_ops = {

-- 
2.34.1


