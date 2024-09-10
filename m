Return-Path: <bpf+bounces-39425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D2972D8B
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7661C24786
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33492190664;
	Tue, 10 Sep 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkzD7+Gm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4385188A09;
	Tue, 10 Sep 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960281; cv=none; b=sdryvADuRTgquiGCJGwYG2ACZJXZIDRxUSZjelKyKSi7dsaXHgT7DYz+YsgO/0Yc1E3f0hUSoTCFGSzGYQTfegtGa1M2IBLt5D21Zlw/4tbw/8B59QWPdwFhKia/dpR8XMATEhRf+2Ps5vFvQQ79Hjpi1D849xYg1ARooEqwKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960281; c=relaxed/simple;
	bh=XkhzSnvw+5dFkNxwBsvjI0GFrEiYS/TMYTriwXBUSCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVUaahOCnk5rjZt+/L2InQh0mWnqDoelbtOokJQTwg7xnmr3+LP3l6iSF0PnZvWsPgG7BzE5cHD+0lAATf0TkXKc6dHz6wl/p2sJkUVhEuVeKy+1I2CM2j2cNakWbacEjVq0jRRs7R9GlMUUvjenWXAeplsjdp19R1mXu2yk9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkzD7+Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC37C4CECE;
	Tue, 10 Sep 2024 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960281;
	bh=XkhzSnvw+5dFkNxwBsvjI0GFrEiYS/TMYTriwXBUSCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AkzD7+Gm2B6J5qwAVqJf5gcYNcMTZYuBjRo8G1W1BM43z9gfU6w6lrTBkRcvVyqxI
	 5B1d0yJ9A4Czyp5VCS2k0Z0R/skxEZI5cj115tKQi7kazhSLzPtQLTO/vryaPl2mBg
	 NdoQqWKEtdIK2vom3jfUqMw0nr8VlCu+NeOLyPMS2GwoLeh5N3ARxk1gGVuYS/7QDY
	 i+FHilALLUC7U4R3EFhXpuOJiJHyO4s7DgqnVgNuEUAfrCriJCWelSNtQGZO2ibuhk
	 OyDfQQFKTaiG5JHkBiqG/R8m5a1mXnTx3THbiST+kzZ4mVVCPBQZXX/NjlB4+U0+Gv
	 9hYaLnA71WIYQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:24:03 +0300
Subject: [PATCH net-next v4 6/6] net: ethernet: ti: am65-cpsw: setup
 priority to flow mapping
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-6-077fa6403043@kernel.org>
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Joe Damato <jdamato@fastly.com>, srk@ti.com, vigneshr@ti.com, 
 danishanwar@ti.com, pekka Varis <p-varis@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=XkhzSnvw+5dFkNxwBsvjI0GFrEiYS/TMYTriwXBUSCs=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA1N2SGIUlwRTcoPwYtwPHf2/tDs/B+nkSnf
 AQAY/VesceJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNQAKCRDSWmvTvnYw
 k2GlD/0YzBOgrE5fWuCktTv3MeJymXE1u9zY86fsC7rkXokxs63yMs2CbbxEFpC1b3f1NQHdM5s
 xzT2e0keX2H4cTFrTuzbJ2GDvv1+aMqL9UuvgXeUkU4wfliYUATWZvolm/u7jLKhu7BGISA9le5
 VGmSkyA94GlGxTi36SraoUEVIymCgDiZB7Rhyxoagf0edrHlP+ECMGN6aXFrUrxea6LFZ6g0g4K
 lToZ9GOG7O5OxlbPqpMUKvVu9ORRrpO3iJvUqYkU1lc66pVURBJEw4U1E0QEbG8wf9fLKjf7wXn
 bU5H8Yg66JjDAwd9JdWWyuQ7eXhF2DrqtYAC0Dt82fHuSG7BGrl317QdmjHa8YcTV3g4MnIx7xy
 V9kUf8tCx6e9ChgYNtyuR7GFEZVlH9q4tyFVHVN5L+d5T7KjisNtwf0Za+zqAc94K5EiRaRXW7I
 InlXiDE/gsUFwqrZ6gIs829YhyBm5YM9BTlQ+BvXIna+xydvbUfpu/mN3oUWl3Jiq/9s6QPKR8I
 rTskpnQG+P3oy0/xlgGGDClRpenrc9fvDvO2vWkh1HLjGK1pFW3KPeQRxBcxZA7AMStNXheVvs0
 cxcKCgxBwuFq3/8G9lhbYQ2GvOZuYnmqEghy15+0MOdgQlS/5F6+49Kyo/q57CDdCSPLvyVEqPE
 uvp+NKU9Ni4BsRg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Now that we support multiple RX queues, enable default priority
to flow mapping so that higher priority packets come on higher
channels (flows).

The Classifier checks for PCP/DSCP priority in the packet and
routes them to the appropriate flow.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v4:
- no change
v3:
- added Reviewed-by Simon Horman
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 76e62351b30b..cbe99017cbfa 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2500,6 +2500,9 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		}
 	}
 
+	/* setup classifier to route priorities to flows */
+	cpsw_ale_classifier_setup_default(common->ale, common->rx_ch_num_flows);
+
 err:
 	i = devm_add_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 	if (i) {

-- 
2.34.1


