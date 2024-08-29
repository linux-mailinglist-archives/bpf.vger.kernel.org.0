Return-Path: <bpf+bounces-38395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC549643DA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692B2B21E14
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62771A7AF3;
	Thu, 29 Aug 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLKrs4n9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE41A707D;
	Thu, 29 Aug 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933029; cv=none; b=lJUwo29//2sDWqcjgC2jk3I6wdrnpG97ZbugFMPKF7Ceu4se9zptbdTfcKxLvym7BO575BJJEKgRxNmER268pk0zPgax1hjrIiYrl2uyvjxM9+9IbH1qdNih8mA1XJJWZBtbP5qE6Lf5iUINjLPikAD7EEY62Vc3BSX77Rqsr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933029; c=relaxed/simple;
	bh=GHCT7Eny5kworVq/bVRbh0/g6kq8ndCladI6RYKjfZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMbNAwl6etT6fmZcTlaAXUteyl+5k9gsiZsPFQpqrtzeMjHjACYSQKi03Mf7yZaq7ugklOXYojE7hN8EJFQmpjQsjgQoudAnKbaNu1O1WNZPJnBLyuuONC/Z5FlVee+UUH5avFEJ0vsUTPatkBzvhzGPIFyS147cS5MzSz7dG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLKrs4n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C445C4CEC8;
	Thu, 29 Aug 2024 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933028;
	bh=GHCT7Eny5kworVq/bVRbh0/g6kq8ndCladI6RYKjfZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sLKrs4n9s8Nn5O4DFdsHMc3MnWkhOwsHX06/i7t0SBUU5jyuXWljkuqaF4UE1pYZd
	 6TAK02Q14hVBgSn5K7nG4adND09eJ95QpRaqDQwLwmUb/S1lewzC+y1v7DqN2+H4PA
	 2Kr5r8e5iXMElLug7Vw+FCVwNdkqZXxhc/9/vGFRrIs5vYNud0vzRPFb0eOGvNSzKx
	 iAFXOwDU7gofM2bIljfEAOvhpQyf7J7iXvARMUHxpqH8dWT43MLywX3wOaKBo7PoUX
	 RMZLyA48tV5O9lEWJshPWnqIuoHZ/hQFBy1VhbDsQd+9U/4M9o0Veg7RPlkF0/LEQZ
	 BBtvw9rnlBK5w==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 29 Aug 2024 15:03:20 +0300
Subject: [PATCH net 2/3] net: ethernet: ti: am65-cpsw: Fix NULL dereference
 on XDP_TX
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-am65-cpsw-xdp-v1-2-ff3c81054a5e@kernel.org>
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=GHCT7Eny5kworVq/bVRbh0/g6kq8ndCladI6RYKjfZU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm0GOYInJM1XuAwIFmU2Dbw0vgdjHGy05PqofiE
 xmQ4Q5BouqJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZtBjmAAKCRDSWmvTvnYw
 k6xBD/9cjNmmUOkVF7bjOpO6lhvey+mUmi24pb60reELEzfBZ1cZrDzzlpinwEB4OjzlwbMd7QB
 7BArQR/93N0bhJQbaOYRIl+8KmRyOyslRhwYeISGK9Spl/sHxDibfr3CuTti44AeEBaJE8klV67
 NETAJioTH89Yjc0S+UOqged7JP0L9lB7HuiOyLhyHalLo6/wVxcOfk1K3dG3mfDm7FulUptZ/5m
 eEkmEOx3sbqPgLGiRdExyQwocVq9+M1PF2/i1gG+mrQ1enAChiMvp2COHOoBA68VcdENtqParp2
 r6NIRzW4iYxED5WMfJISnaDB3X44bhV4GqPh0FslxWX1A3mYXuvbplr6K2GCQmgKeeFXNFnpDJM
 voX+79cJgSt0narzSu04X4MD5CHDBZbLev5hqhCY3vl7SzZghsUTRhspydpHnXsT6xE1PzYEW9+
 7LcAV3HDRIN5fjI7U745SzF/iiEBtknJIqfdHZlcqAe8dKdUWlcAMLtTktR/EnToSnlP5k722Lk
 ACanXpE5x1dF+CjrpS3pMONy2h0BicGTBw9A/c4/CA2UCdxzsvM6qzYy0o/1pQhVGB+2jPmYeJ8
 UjgyyvhHVDOn8aichY4ifkbvjp8XkRnIZpoHNLf3GdFBFpPWQI5jXggEguDLprtkhoD9jDwTvfF
 iTizEGGYv6SSjEA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If number of TX queues are set to 1 we get a NULL pointer
dereference during XDP_TX.

~# ethtool -L eth0 tx 1
~# ./xdp-trafficgen udp -A <ipv6-src> -a <ipv6-dst> eth0 -t 2
Transmitting on eth0 (ifindex 2)
[  241.135257] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030

Fix this by using actual TX queues instead of max TX queues
when picking the TX channel in am65_cpsw_ndo_xdp_xmit().

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9fd2ba26716c..03577a008df2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1924,12 +1924,13 @@ static int am65_cpsw_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 static int am65_cpsw_ndo_xdp_xmit(struct net_device *ndev, int n,
 				  struct xdp_frame **frames, u32 flags)
 {
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
 	int i, nxmit = 0;
 
-	tx_chn = &am65_ndev_to_common(ndev)->tx_chns[cpu % AM65_CPSW_MAX_TX_QUEUES];
+	tx_chn = &common->tx_chns[cpu % common->tx_ch_num];
 	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
 
 	__netif_tx_lock(netif_txq, cpu);

-- 
2.34.1


