Return-Path: <bpf+bounces-51723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D301A37C4B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E5B3B1351
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3C199FA4;
	Mon, 17 Feb 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGOJHkdu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EB1990D8;
	Mon, 17 Feb 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777525; cv=none; b=usZBDGooMK8O56+CcDSFxFCESpcTnsQSd1CDJ/Vhzg+mo24eyB7e53zi/DNfMdb/i2162ufKhQmhbBBaU7gviZBbHx48XnaPOfvETYOlekPRQ1HdWP5euuXBBhR385XXyzQ3Co0XZnlru4HKBCwHlwHv8J1A/sh/wNGu3YMGAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777525; c=relaxed/simple;
	bh=19xJLjvkq62RYJ4N9p/9R4u1MMong2jAKqa9m+s/dsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJDcNODXJ/OvviaiBPB4uOTVDChQMD/OqE2lfPK9P2itPikrvNLv46du/+/PXm4OzMouOHrNcgIvLgdaarX9OIhDGLhnUTqYbfMy2CY1wJqNfXK6N1r+C2Hi/Rm4S1+P8yx0s5Kdzi/gLkPqfaK+SKRyFHZiCYbAZClSzprkRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGOJHkdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1EDC4CEE2;
	Mon, 17 Feb 2025 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777525;
	bh=19xJLjvkq62RYJ4N9p/9R4u1MMong2jAKqa9m+s/dsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RGOJHkduEyk1GbjvEuUyb7HhKBErFCqi0R5pkYnsHgBu5pNxHVoCJbLsq6tGbjcS3
	 9+IhoE6bOpEYAgPJAmVw79DtwhUSJor+D5TdvWV+EQYLMS2Fov8mOA0M4Aw4fkzFGp
	 yBYMVIqj6ktfSsQW28W8I+yQcGXdntaZWSOWMFyET0HUBHCh8v8I/J8XxYotdZcRyr
	 8PwvaD7gNhUimRipyTHAmAB0poF7rEAB+/R4nJ7QIHFKOa8zf4ca/Tcwf/TtIpzvLH
	 6p1mc37Uua7W1hPQLuE74f2dd1QnB3/6oX3kzM0Pe6SveKcBo9XVIcEWrnYBOyNYz5
	 LQWcib628Xngg==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 17 Feb 2025 09:31:48 +0200
Subject: [PATCH net-next 3/5] net: ethernet: ti: am65-cpsw: use return
 instead of goto in am65_cpsw_run_xdp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-am65-cpsw-zc-prep-v1-3-ce450a62d64f@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=19xJLjvkq62RYJ4N9p/9R4u1MMong2jAKqa9m+s/dsQ=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXlxkw4cQojYstASGutsETzAYig7hoQdZ4hf
 zrdzlioTC2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5QAKCRDSWmvTvnYw
 kzP8D/wLweYTaize8cZmX+F/3+PrppDz5e2vmz4gd5nqlpp8eZ/YwJrv4W8Hy3UWggLBT5C8YhX
 i+YL/5C0/T7qghCq3pafZbr9MXmoyYpRzyam+qEuRSY4xwPC/xXW86jusgZ+Ehrh07b2XFqtI4/
 pZfjEukDPBj3IrA6NVdWx8d7yT59UhWjICENMV8cGkThhata+z11Gv9124yxG7r5W9CvfzyQUwt
 02A5M84vPRFGcUPg1Hrc1ulag0J2jNDm0672q+/IL7ppmJyQcsQ4xr/Eke7DPOXST1AoKxUZjDI
 COTc+hGnW7mNZYMGmONfID6ZH/1zhpxtoJvVRoNSXxIZuU9+ITfZD8yThhwtVCOQy/Y3/JIu737
 sW9Gag0npXxvAbrego3qXG+kCvxAMrrYTJDB3iPbWHU89IonCekSOuwh3WillkMJCsCWI40ZqnI
 CPRewInysCPI77rZEuRt7sZQss2VEjY0bV09Yz2bnQksRoHp8QkjA2RQzuMD63YMK7JH4TApNut
 xmVRZ+yE0iONyYQX7tTInp2Ry8HX0SgbyXQxi4QwYmKtvgB5F+FlUS+QjFtuveM9wcYIIhxKg/d
 0nTCO9f8FSrBUoKfQ/XMJrwQPGmxElaK/3LX8wzbOAp/04+I426F8U0/jANI7WLz7r/fPqO0oq2
 QUeW4PID05+T2ZQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

In am65_cpsw_run_xdp() instead of goto followed by return, simply return.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 6bd4f526cb8e..468fddd0afd2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1193,8 +1193,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 
 	switch (act) {
 	case XDP_PASS:
-		ret = AM65_CPSW_XDP_PASS;
-		goto out;
+		return AM65_CPSW_XDP_PASS;
 	case XDP_TX:
 		tx_chn = &common->tx_chns[cpu % AM65_CPSW_MAX_QUEUES];
 		netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
@@ -1213,15 +1212,13 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			goto drop;
 
 		dev_sw_netstats_rx_add(ndev, pkt_len);
-		ret = AM65_CPSW_XDP_CONSUMED;
-		goto out;
+		return AM65_CPSW_XDP_CONSUMED;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
 			goto drop;
 
 		dev_sw_netstats_rx_add(ndev, pkt_len);
-		ret = AM65_CPSW_XDP_REDIRECT;
-		goto out;
+		return AM65_CPSW_XDP_REDIRECT;
 	default:
 		bpf_warn_invalid_xdp_action(ndev, prog, act);
 		fallthrough;
@@ -1236,7 +1233,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 	page = virt_to_head_page(xdp->data);
 	am65_cpsw_put_page(flow, page, true);
 
-out:
 	return ret;
 }
 

-- 
2.34.1


