Return-Path: <bpf+bounces-51724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60ADA37C4E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8874F3B15A5
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762E19CC02;
	Mon, 17 Feb 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbHN3CpX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792B1990D8;
	Mon, 17 Feb 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777530; cv=none; b=AYn8Kycho5QOnrfF9bPIX32X+WcdvKBMjQz6KiuhvrO2TwWtaDNeGDQA43W4D+uS62kT+A6H0w7cKq93LTKE9ddXalzAPpUtbXhgq5Df6ymgqRI00fLVu/BV9Uh9WDM81aPZpkRbWbxzSm+pVXpuM6SbrzuNFM1HrLrrExq9ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777530; c=relaxed/simple;
	bh=2MB2tf6LAMpLUYFWZxib5jvrRY4JsGRtJP82nuF5PYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgl+rmfsUvbVd78/N9xVcjwnpMIOWeZft42W78lkhRA9+XxcCAWqKIz4tiCUZuytTnWnBrlLwOWWoldjHf7iiN3p5jMgPWHuiw7BdK7Gw3CPKHT0vyEjYqJnwuvyd12+c8SaPH07YcRKlAr/12mny1+XayFwrgS3noXebZIx6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbHN3CpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644BC4CED1;
	Mon, 17 Feb 2025 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777529;
	bh=2MB2tf6LAMpLUYFWZxib5jvrRY4JsGRtJP82nuF5PYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbHN3CpXfDA+Jz8A5OGVqWLfJJJGqhkMQPSRyPigGEIeRxcoW5sgQvmig2AWyZWxr
	 J7hy3uqtUfqs7LbowB/jLrQIp17W0YA2RtXKwhNnumB4MERkkWRJ5uyPSxPzIZmdmL
	 Rj6Mfb9zE7/hAdtF7jxqQEEuKSJ2gIy0xt4PaXSYiGaDob2hc0OX7QiqRSPhovbAHY
	 5rER3240cEoXrxFVzS5dyzhQDALUDOMPS/q60zbBr63IgFDEjB7YzDykB4Ui2o0QMp
	 NpkIL5ZtYblqW04yEcago8FWf4s8ogxMvgj0prhmTLrchq9q5ZtxMFV7j8YCTMKf8D
	 YyhL7qQSpLdEQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 17 Feb 2025 09:31:49 +0200
Subject: [PATCH net-next 4/5] net: ethernet: ti: am65_cpsw: move
 am65_cpsw_put_page() out of am65_cpsw_run_xdp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-am65-cpsw-zc-prep-v1-4-ce450a62d64f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=2MB2tf6LAMpLUYFWZxib5jvrRY4JsGRtJP82nuF5PYI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXmHrW+DG1RvetzfBXl6OSJHembiNvtlgqey
 MGzxsfqnCuJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5gAKCRDSWmvTvnYw
 kw6CEACqExShtQdojmqEsvKNxfXXHo6SpMDrP2hhZSn4BiLJiz1EqSJqamL9t8AIuV3djZJJF6n
 v3y3dZ1DxD24+iwSyGbZgbbXl/xhCUvxfkVoSbfjZeLSJakfxjf9u305cS2Dj+F6zbVmsNsfn4y
 j3DF1GbujwC4jiHRe2EiRSXlJK3a2g4O8ya9G0PEUeeIF0UsIgNAJdTI6uDg3u4YMlTouMNwWna
 L0PLYNzkpwiGOIUZX1/T9n2+8A2OTpLFdu2EP7i6Jjz1FDmKMljFnEswakVZt8uhlLm/VvOYbwk
 YAvc8QZaauB54N3bEpIt1BwkOfmPKn65ymFa3S2pdwt8Cmt39hwbNqCB+e8sCCJqxJr7AU69Lfi
 WlmFZnrQNP1EfdemY65Dr6b911jMCARUNDKcaBMwXryg8RboQVb9orRka8u2E6Img4D41/tW38h
 gg/uvaP3NPG1wL5dfusjFWrkpPFk2zmJt9gmZ0ekU8kaMOUedXteXzmIVLlpgcxd+fyzecXbGME
 kHBnvH/nIaTzRPNEn7FNRsHB5gJtYn48cH8GI5AK3Lod3uWlm/f8f4//n0ENI+DIAzpjXdTKEWM
 DGLm/VJuEc+9l+EIjV1H2Tp2pykUvtnbBEuaZvXBBP1FrScHAcL7l0HV0OoFc/JoPlCeeriGPI1
 2C8ZIvd1iExSxXQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

This allows us to re-use am65_cpsw_run_xdp() for zero copy
case. Add AM65_CPSW_XDP_TX case for successful XDP_TX so we don't
free the page while in flight.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 468fddd0afd2..32349cc58e2e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -164,6 +164,7 @@
 #define AM65_CPSW_CPPI_TX_PKT_TYPE 0x7
 
 /* XDP */
+#define AM65_CPSW_XDP_TX       BIT(2)
 #define AM65_CPSW_XDP_CONSUMED BIT(1)
 #define AM65_CPSW_XDP_REDIRECT BIT(0)
 #define AM65_CPSW_XDP_PASS     0
@@ -1177,7 +1178,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 	int cpu = smp_processor_id();
 	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
-	struct page *page;
 	int pkt_len;
 	u32 act;
 	int err;
@@ -1212,7 +1212,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			goto drop;
 
 		dev_sw_netstats_rx_add(ndev, pkt_len);
-		return AM65_CPSW_XDP_CONSUMED;
+		return AM65_CPSW_XDP_TX;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
 			goto drop;
@@ -1230,9 +1230,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 		ndev->stats.rx_dropped++;
 	}
 
-	page = virt_to_head_page(xdp->data);
-	am65_cpsw_put_page(flow, page, true);
-
 	return ret;
 }
 
@@ -1331,6 +1328,12 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
 		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp, &pkt_len);
+		if (*xdp_state == AM65_CPSW_XDP_CONSUMED) {
+			page = virt_to_head_page(xdp.data);
+			am65_cpsw_put_page(flow, page, true);
+			goto allocate;
+		}
+
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
 

-- 
2.34.1


