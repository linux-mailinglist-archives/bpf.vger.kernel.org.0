Return-Path: <bpf+bounces-49196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB3A1513D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDB87A45E5
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC94200BA2;
	Fri, 17 Jan 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGAXyN63"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40E1FFC5E;
	Fri, 17 Jan 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122821; cv=none; b=r5sYX5am/CQkd4VTxQfnZ5vYnw97gR9rAKY6W84/D7MoZm0EGFV+zGV8JcmPvqQVPVLJtyQ+dnKZsVdAylIDgtOlUlL2JIkbBraqsEGXfrBhY49CFxaW3KDO9fXkBoe5be4XIrKmggCY8JGayaCS+uSoJYNyFgDGwT701d+BukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122821; c=relaxed/simple;
	bh=HeFImfs6suJtHls8FUcWRjjkttBODiWYRmsgzqln0DY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NMs8ND8ZzDCKwvpvkuOsEHptsUlWJU3wFPXRwmxnsDrQQN1LyAjAuqj2ONZ6DJOeL9FtMCVvI1gd+CwmMO7+SeyZ4kRtXBHmUItW90OWBks1iX4JpUDryz+0hcmLnyXYckG6kqsp39ILTLW/ws3H9PSq5QpjdvwFIgrlmTKyWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGAXyN63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A2C4CEDD;
	Fri, 17 Jan 2025 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737122821;
	bh=HeFImfs6suJtHls8FUcWRjjkttBODiWYRmsgzqln0DY=;
	h=From:Subject:Date:To:Cc:From;
	b=ZGAXyN63pwDdPmSu7VOba7a9KiMzOTw+tibeJ/HmZF/Dgkk8s31tyZcXu6nK+FlRB
	 /63ReVamvh6tbRL7BP7uxJ9IVEZcEwmAEjHTSTvj8phGmQll2i+xSQy5ttTfvkAxZQ
	 rMM6CsUydVoCazRb3L6Q0jXiHvhM3Pk9ABrZHXm7QpHrUXgf8YLXJE3Qm64uHVKcZU
	 +h3vQKHuwuV5e+pnE7C9OD/1vKcHyO8U+AUONA5gDGa6OL6DrjSCB/b5yf7EBoNAQ4
	 1FYslseFoHdKsf7Hb717vqLbUuO85FtIYZFSNRo/t1BweaVHkAz9fBmc2GaoEAJgp8
	 1CkdBzqLvbZQQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v2 0/3] net: ethernet: ti: am65-cpsw: streamline
 RX/TX queue creation and cleanup
Date: Fri, 17 Jan 2025 16:06:32 +0200
Message-Id: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhjimcC/22NQQ6CMBBFr0Jm7RjaZoq48h6GRYMjTIRC2gYxh
 LvbEJcuX17++xtEDsIRrsUGgReJMvkM+lRA2zvfMcojM+hSU6mUQjdawnaOb4wpsBsH8YzG0KV
 ybLlmgjydAz9lPbJ38JzQ85qgyaaXmKbwOf4Wdfhfmv6nF4UlGm3rilpja0O3FwfPw3kKHTT7v
 n8BK53uDcMAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=HeFImfs6suJtHls8FUcWRjjkttBODiWYRmsgzqln0DY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnimP8hrknHYRe2dCy23WiG9g+UTMNiJXW+rk3L
 eNMchpHn2GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4pj/AAKCRDSWmvTvnYw
 k4GPD/4o6hXtkcaXGomj9kfQqr0v1G70oNWDRs9Zm8ukf8PJkbTmr9sPJ/Jmh+70phH5utLExn9
 GgBVL0ULKwNn2I6FjIHGpLgJkBwHNyBhHO/tNGF4vTs2iJAzy2BJ2BdIOOZt1Htf7rOMUyIBUZz
 L1TdyBO0bMdFYMNIlfyW0u11HQMHgx/IcwAqRazKOZDK/XGjz12OKMwFOQ3/l4daZai+YMbbysr
 qENeLnQbmGn2ztF7vNSRg4pw+HEE5yT679YypWHuKcANK7x1xHSe+fg6QHHFnp/09er/wBmc6u/
 9IaRmX/j6XSAN5f88kZ63seBgeYGjhQRNPh9b5Qf/jsI7mdQDwc6EkQ5pMhsenNQVG81Nh8eR/p
 6szqdPDM5KC/0dLYX35JB6Nk/Q6Quatn6oWAWY1YIrldekC9DWluY6+rfZXGZVpuFc1Yu6Twugb
 4UqiO7Q8Ukzznqw0peYjb9WyGPGhYj+woF1X6m4BHFwy1p+pC47zJQrjMBloZERUZFgnTiDiy7q
 ig2FDbBeFDHmIpZNTZM6AN9J7L/cbKX1FYsOILsZnPxwlqunyuxVHh7xa5NbW3ZC5x8qt8DKnih
 SZVY+Fc0MhGe3x2VUyrYCSitx0YKmaEOzVP/yD9NOdpyJ+gENg+q1TOPlAjPDkGYs8IjA8rYsJR
 7mv+F+ohaol3ieQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

In this series we fix an issue with missing cleanups during
error path of am65_cpsw_nuss_init_tx/rx_chns() when used anywhere
other than at probe().

Then we streamline RX and TX queue creation and cleanup. The queues
can now be created or destroyed by calling the appropriate
functions am65_cpsw_create_rxqs/txqs() and am65_cpsw_destroy_rxq/txqs().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- dropped netif_carrier_on/off patch as it was clearly wrong
- dropped the probe cleanup patch and introduced a new patch instead
  that only focuses on one issue and not the cosmetics.
  i.e. proper cleanup in error path of am65_cpsw_nuss_init_tx/rx_chns()
- Link to v1: https://lore.kernel.org/r/20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org

---
Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path
      net: ethernet: ti: am65-cpsw: streamline RX queue creation and cleanup
      net: ethernet: ti: am65-cpsw: streamline TX queue creation and cleanup

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 429 +++++++++++++++++--------------
 1 file changed, 238 insertions(+), 191 deletions(-)
---
base-commit: 9c7ad35632297edc08d0f2c7b599137e9fb5f9ff
change-id: 20250111-am65-cpsw-streamline-33587ae6e9e5

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


