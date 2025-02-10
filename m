Return-Path: <bpf+bounces-50991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B250A2F050
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D4F166C22
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11C23CEFD;
	Mon, 10 Feb 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYojaCmr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883D1F8BCC;
	Mon, 10 Feb 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199156; cv=none; b=HY5FueCRI/KgbKA9IA/WxZ2Jqtx7qF/HfoBz5+/KCqRGe6VmFjoYM72idsv7B7WxwlYcUZhRLsipQ9MaLJGhQwkIaHZg2Xnwq6vXOYyLCPgUYpHoelqU8ynUVsaZjB3La0NrFMDZrnAeZ43pNLSlpnzZnw1qjtrnTqA8bWMZ45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199156; c=relaxed/simple;
	bh=HNcbYnzHO18TyVd6ABCg4Wajlo8GzqSxCWV3Zsn7hkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRvFjbnjuT+bofvC1utpCHucvfY/A7s4lbKzUlZF3PeLZ00EyqQpcL3iMKgqKpjj+MkTyFNovwAD6DAJapCIVanhljQeG91MCQZdmZ81qnZFPUcYXPDzX1U8w/4Z31fdaHwSkOz4rDvcd9Ns3bDwE5Q+i3+GLLrj5NZNI/CqLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYojaCmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023C1C4CEE6;
	Mon, 10 Feb 2025 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199155;
	bh=HNcbYnzHO18TyVd6ABCg4Wajlo8GzqSxCWV3Zsn7hkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qYojaCmrwCxldnXH3qTBYPOqlqPPcOVrgt9Rtw9THaL8Xu6GZ155qUg5omCvMilbC
	 QYLZhiY871+nZi4k6avHqC8xgThwyZ/Dg/3mWUPzas72IONB1GuXYRVw7cBHWfMwLA
	 akDl+SXI0eeuXvlk4T9m0MUK2B99yiahxg+UYSMIRZcJg5HnsIWleXPb0jmtcf3gH5
	 elApzBHvDuZJIuZEXNxQS6eNAwg+nR/NG9e2S6NG3hUkTkFwBy9iBHwm4imfeMkTZV
	 VZAkuboF+wcFLBKM5NuY8DbWj9jbGpcVpdRRLoSe2RTu9ZP16A5+6dmpBF8Q2t9dq9
	 7X9tZWNMnF/UA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 10 Feb 2025 16:52:17 +0200
Subject: [PATCH net 3/3] net: ethernet: ti: am65_cpsw: fix tx_cleanup for
 XDP case
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-am65-cpsw-xdp-fixes-v1-3-ec6b1f7f1aca@kernel.org>
References: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
In-Reply-To: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=HNcbYnzHO18TyVd6ABCg4Wajlo8GzqSxCWV3Zsn7hkg=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnqhKiCPZFRwQQnzzDX1Za3HRlmO8EtOYKxR4Eq
 dxKAmLUEe2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ6oSogAKCRDSWmvTvnYw
 k17xEADEofTjt0PuuvMAa+WeaALn9lkbgeG6I6m4p/gMSoZUDWNdaavMSHHFzqcgiIMfyvp2d3U
 hgZvSLtm/Bzd2oufPS053gCX7CusrMbYO9yfig690PoqpNahgYmlW+ScgsIxQl1dclZSEoA3Hci
 duBsU62mtRtOr36NLTsL96n2f71m83+oMg+blKg45LE62mkW2qU0XWWWoBZ/GzZ/kLV4dzq0icA
 LvBp/pl+hv2vKz8+X2hIXl4wprNMdPnr+Hg+KyyZsir6ZEv5Al+bDddQ8ISaLMouuinivH0EHZn
 +Th9wYFW12S4xmIYxUCmJYbFmqsT0nC0hPZl17M/Y6GF2wPHL7I55I+fqnsHueOBrE0BdmtFCIB
 RvqpJAMglI32znRg6DN/LBFp3yYC3jAM/n0QFeQ8IxSn7gyiJFmBv/3o1indiGBU4xQdq7f3UdD
 0JLeRG8kEzUuhAcY5Y7iisgK48R3GVs/RXBzIzFc3AW1iUCf6cz/zC207yqQKiP1hKyoIHnQfUE
 lcWMza1HOFrVf6XwjaXcNfuHxS/wcPsEoC7MK3NYIOoxOpintNupRPYkih1XHWusJ08/ab4nKyv
 8Qc9DCrl9+46HUvbuB2Y0Fo3l3E1vjYTMU0KreyeEpIlLItxL+drFbA0QubFHQZD+tgNE4KTQth
 UpTZqleGUGXg1VA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

For XDP transmit case, swdata doesn't contain SKB but the
XDP Frame. Infer the correct swdata based on buffer type
and return the XDP Frame for XDP transmit case.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bee2d66b9ccf..a2b6a30918f6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -828,16 +828,24 @@ static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
 static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct am65_cpsw_tx_chn *tx_chn = data;
+	enum am65_cpsw_tx_buf_type buf_type;
 	struct cppi5_host_desc_t *desc_tx;
+	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
 	void **swdata;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
-	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
+	buf_type = am65_cpsw_nuss_buf_type(tx_chn, desc_dma);
+	if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
+		skb = *(swdata);
+		dev_kfree_skb_any(skb);
+	} else {
+		xdpf = *(swdata);
+		xdp_return_frame(xdpf);
+	}
 
-	dev_kfree_skb_any(skb);
+	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
 }
 
 static struct sk_buff *am65_cpsw_build_skb(void *page_addr,

-- 
2.34.1


