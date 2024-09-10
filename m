Return-Path: <bpf+bounces-39423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6E972D83
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432C328524D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFE1862B8;
	Tue, 10 Sep 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYTVlggZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9B1891A1;
	Tue, 10 Sep 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960271; cv=none; b=ZTAzYIyV8bvxwpfiTPWlO9cMO7mJlQdYU/gt3ELSXSrv4t05ZABrNp+Rkb3o3H9XA+jrWUyxmQP+1zNNnxugyl28mtqL0zyO9RHrv6T+cQSVt2fDGsdEXhIHiEAw6uydr/tKxQlSNJLk434MmyJCvbafTevESnYaST9B1GlbhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960271; c=relaxed/simple;
	bh=5EGPy5Ci3JV09svqH6z3s9p0uaptNCwmvPw8SljHsN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na1S7GOruuU8lN5NXkLawIgzNo4015f8dmrHwOkFcKCSjawsAdzL4dOWxOmrICdFo9E2COVSqxGpMfp1oTIsfyTlBHom9ChN563WWmKPDXdigmH738pII5x1bMNjnOdnNdq7V/YWvGOajIMTNbCgd5MLxnend5UAWVh8WpNhImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYTVlggZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9819EC4CEC6;
	Tue, 10 Sep 2024 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960271;
	bh=5EGPy5Ci3JV09svqH6z3s9p0uaptNCwmvPw8SljHsN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HYTVlggZXxBETx1+KJUp6ZW4lQmnBYn54RyP4keM+jDaWELa3EpcwHcCu7BwnUjDM
	 tHTLkbBhqZmxkmRGBCdqx+2jAVjaJn6yMvWSELUakkPefIudWFKyrK1VKUAJQdYa1y
	 ADDZH+s1ZpPTgNIjkcbjVcrDScrGaNfWVqJfzbqdzM8Y5vTjLxdVr3jiTSONfk/gsw
	 B7sH58zx2F0mRujjPTKuoBBLfZtpVcDbe16KcKCxHMeTe/7thl8j6hdtosfa1cWTIt
	 toXPETJL3kmeAKn7EK3yN4U6H5N0/3xOjCLc6/wjEw/7E79X0P4mt2KuO3fKx7FHae
	 g9uHwslUYNfAw==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:24:01 +0300
Subject: [PATCH net-next v4 4/6] net: ethernet: ti: cpsw_ale: add Policer
 and Thread control register fields
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-4-077fa6403043@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6052; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=5EGPy5Ci3JV09svqH6z3s9p0uaptNCwmvPw8SljHsN8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA1Fhl/vOhzLfkjqknXapB1A3vfDn30qvgMI
 8r1NioujliJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNQAKCRDSWmvTvnYw
 k/QAEACuZI/s7aPFga+cWiHB852Epq+F0US9rk+LKjFgr/3dp2SMu6ALuNq/uSkrxkIfMDiLA6I
 16pMNg4MzYOYRBuOUrl9oTfBB72nSdH4f8uIPG4giT8Q44aLoac8p+6JosqaAls+IcRWNYE33uB
 8idvvsPcJdO2DKxMGvGdRacY4fXX2ueXnKfXQ/1NdS5NHCyMOPNZOx/B1ZWJauN6GSg9TlIIVLo
 TpVU6jgU8EIs2OPyAkePGFmagg90rzDllHmA8RrtVoWiAEi52h5bUAhAdX9YXPD+dDpPNNcWFw1
 a19OZW9j1lA2FT+Vze/CMGDO3pri41yf7NMvlpN5gdrEZIRrSydhLaEUO+DTqXiDtrrlL5sAFsY
 LaNImmd7z0waNFfrQBovYwgaVzthXqgxaO5xIdhfbL2tqYLOeNEZI0iymRNxzL8LAp53BpCRMgR
 OpNBm3hQHKK8k3fkFfA7sAgXoOYHuYJOJ+YimdSaZO4acqf3WebmyhanXihQLmRW1J+pJ6mcF6V
 jWTAXqnbTEYucdan5xuymA55McD9ZU2PTgFzBuxp9LtyUeqNuiuc+mn5vYr535XO8bBNT3HuU0q
 uRz62ZKRjXCofE1vAtA6rntqxXgFKCkhF/U6PeLPurjOJBWD1gPrSgzwnBWVRZTG9moOumt8sD6
 TXbN/73omP92blg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Adds regfileds for Policer registers and Thread mapping/control registers.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v4:
- no change
v3:
- added Reviewed-by Simon Horman
---
 drivers/net/ethernet/ti/cpsw_ale.c | 86 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_ale.h | 41 ++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 9e45470b4eb9..aafe1210de52 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -46,6 +46,24 @@
 #define ALE_UNKNOWNVLAN_FORCE_UNTAG_EGRESS	0x9C
 #define ALE_VLAN_MASK_MUX(reg)			(0xc0 + (0x4 * (reg)))
 
+#define ALE_POLICER_PORT_OUI		0x100
+#define ALE_POLICER_DA_SA		0x104
+#define ALE_POLICER_VLAN		0x108
+#define ALE_POLICER_ETHERTYPE_IPSA	0x10c
+#define ALE_POLICER_IPDA		0x110
+#define ALE_POLICER_PIR			0x118
+#define ALE_POLICER_CIR			0x11c
+#define ALE_POLICER_TBL_CTL		0x120
+#define ALE_POLICER_CTL			0x124
+#define ALE_POLICER_TEST_CTL		0x128
+#define ALE_POLICER_HIT_STATUS		0x12c
+#define ALE_THREAD_DEF			0x134
+#define ALE_THREAD_CTL			0x138
+#define ALE_THREAD_VAL			0x13c
+
+#define ALE_POLICER_TBL_WRITE_ENABLE	BIT(31)
+#define ALE_POLICER_TBL_INDEX_MASK	GENMASK(4, 0)
+
 #define AM65_CPSW_ALE_THREAD_DEF_REG 0x134
 
 /* ALE_AGING_TIMER */
@@ -1306,6 +1324,74 @@ static const struct reg_field ale_fields_cpsw_nu[] = {
 	/* CPSW_ALE_STATUS_REG */
 	[ALE_ENTRIES]	= REG_FIELD(ALE_STATUS, 0, 7),
 	[ALE_POLICERS]	= REG_FIELD(ALE_STATUS, 8, 15),
+	/* CPSW_ALE_POLICER_PORT_OUI_REG */
+	[POL_PORT_MEN]	= REG_FIELD(ALE_POLICER_PORT_OUI, 31, 31),
+	[POL_TRUNK_ID]	= REG_FIELD(ALE_POLICER_PORT_OUI, 30, 30),
+	[POL_PORT_NUM]	= REG_FIELD(ALE_POLICER_PORT_OUI, 25, 25),
+	[POL_PRI_MEN]	= REG_FIELD(ALE_POLICER_PORT_OUI, 19, 19),
+	[POL_PRI_VAL]	= REG_FIELD(ALE_POLICER_PORT_OUI, 16, 18),
+	[POL_OUI_MEN]	= REG_FIELD(ALE_POLICER_PORT_OUI, 15, 15),
+	[POL_OUI_INDEX]	= REG_FIELD(ALE_POLICER_PORT_OUI, 0, 5),
+
+	/* CPSW_ALE_POLICER_DA_SA_REG */
+	[POL_DST_MEN]	= REG_FIELD(ALE_POLICER_DA_SA, 31, 31),
+	[POL_DST_INDEX]	= REG_FIELD(ALE_POLICER_DA_SA, 16, 21),
+	[POL_SRC_MEN]	= REG_FIELD(ALE_POLICER_DA_SA, 15, 15),
+	[POL_SRC_INDEX]	= REG_FIELD(ALE_POLICER_DA_SA, 0, 5),
+
+	/* CPSW_ALE_POLICER_VLAN_REG */
+	[POL_OVLAN_MEN]		= REG_FIELD(ALE_POLICER_VLAN, 31, 31),
+	[POL_OVLAN_INDEX]	= REG_FIELD(ALE_POLICER_VLAN, 16, 21),
+	[POL_IVLAN_MEN]		= REG_FIELD(ALE_POLICER_VLAN, 15, 15),
+	[POL_IVLAN_INDEX]	= REG_FIELD(ALE_POLICER_VLAN, 0, 5),
+
+	/* CPSW_ALE_POLICER_ETHERTYPE_IPSA_REG */
+	[POL_ETHERTYPE_MEN]	= REG_FIELD(ALE_POLICER_ETHERTYPE_IPSA, 31, 31),
+	[POL_ETHERTYPE_INDEX]	= REG_FIELD(ALE_POLICER_ETHERTYPE_IPSA, 16, 21),
+	[POL_IPSRC_MEN]		= REG_FIELD(ALE_POLICER_ETHERTYPE_IPSA, 15, 15),
+	[POL_IPSRC_INDEX]	= REG_FIELD(ALE_POLICER_ETHERTYPE_IPSA, 0, 5),
+
+	/* CPSW_ALE_POLICER_IPDA_REG */
+	[POL_IPDST_MEN]		= REG_FIELD(ALE_POLICER_IPDA, 31, 31),
+	[POL_IPDST_INDEX]	= REG_FIELD(ALE_POLICER_IPDA, 16, 21),
+
+	/* CPSW_ALE_POLICER_TBL_CTL_REG */
+	/**
+	 * REG_FIELDS not defined for this as fields cannot be correctly
+	 * used independently
+	 */
+
+	/* CPSW_ALE_POLICER_CTL_REG */
+	[POL_EN]		= REG_FIELD(ALE_POLICER_CTL, 31, 31),
+	[POL_RED_DROP_EN]	= REG_FIELD(ALE_POLICER_CTL, 29, 29),
+	[POL_YELLOW_DROP_EN]	= REG_FIELD(ALE_POLICER_CTL, 28, 28),
+	[POL_YELLOW_THRESH]	= REG_FIELD(ALE_POLICER_CTL, 24, 26),
+	[POL_POL_MATCH_MODE]	= REG_FIELD(ALE_POLICER_CTL, 22, 23),
+	[POL_PRIORITY_THREAD_EN] = REG_FIELD(ALE_POLICER_CTL, 21, 21),
+	[POL_MAC_ONLY_DEF_DIS]	= REG_FIELD(ALE_POLICER_CTL, 20, 20),
+
+	/* CPSW_ALE_POLICER_TEST_CTL_REG */
+	[POL_TEST_CLR]		= REG_FIELD(ALE_POLICER_TEST_CTL, 31, 31),
+	[POL_TEST_CLR_RED]	= REG_FIELD(ALE_POLICER_TEST_CTL, 30, 30),
+	[POL_TEST_CLR_YELLOW]	= REG_FIELD(ALE_POLICER_TEST_CTL, 29, 29),
+	[POL_TEST_CLR_SELECTED]	= REG_FIELD(ALE_POLICER_TEST_CTL, 28, 28),
+	[POL_TEST_ENTRY]	= REG_FIELD(ALE_POLICER_TEST_CTL, 0, 4),
+
+	/* CPSW_ALE_POLICER_HIT_STATUS_REG */
+	[POL_STATUS_HIT]	= REG_FIELD(ALE_POLICER_HIT_STATUS, 31, 31),
+	[POL_STATUS_HIT_RED]	= REG_FIELD(ALE_POLICER_HIT_STATUS, 30, 30),
+	[POL_STATUS_HIT_YELLOW]	= REG_FIELD(ALE_POLICER_HIT_STATUS, 29, 29),
+
+	/* CPSW_ALE_THREAD_DEF_REG */
+	[ALE_DEFAULT_THREAD_EN]		= REG_FIELD(ALE_THREAD_DEF, 15, 15),
+	[ALE_DEFAULT_THREAD_VAL]	= REG_FIELD(ALE_THREAD_DEF, 0, 5),
+
+	/* CPSW_ALE_THREAD_CTL_REG */
+	[ALE_THREAD_CLASS_INDEX] = REG_FIELD(ALE_THREAD_CTL, 0, 4),
+
+	/* CPSW_ALE_THREAD_VAL_REG */
+	[ALE_THREAD_ENABLE]	= REG_FIELD(ALE_THREAD_VAL, 15, 15),
+	[ALE_THREAD_VALUE]	= REG_FIELD(ALE_THREAD_VAL, 0, 5),
 };
 
 static const struct cpsw_ale_dev_id cpsw_ale_id_match[] = {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index e12bb2caf016..2cb76acc6d16 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -36,6 +36,47 @@ enum ale_fields {
 	MAJOR_VER,
 	ALE_ENTRIES,
 	ALE_POLICERS,
+	POL_PORT_MEN,
+	POL_TRUNK_ID,
+	POL_PORT_NUM,
+	POL_PRI_MEN,
+	POL_PRI_VAL,
+	POL_OUI_MEN,
+	POL_OUI_INDEX,
+	POL_DST_MEN,
+	POL_DST_INDEX,
+	POL_SRC_MEN,
+	POL_SRC_INDEX,
+	POL_OVLAN_MEN,
+	POL_OVLAN_INDEX,
+	POL_IVLAN_MEN,
+	POL_IVLAN_INDEX,
+	POL_ETHERTYPE_MEN,
+	POL_ETHERTYPE_INDEX,
+	POL_IPSRC_MEN,
+	POL_IPSRC_INDEX,
+	POL_IPDST_MEN,
+	POL_IPDST_INDEX,
+	POL_EN,
+	POL_RED_DROP_EN,
+	POL_YELLOW_DROP_EN,
+	POL_YELLOW_THRESH,
+	POL_POL_MATCH_MODE,
+	POL_PRIORITY_THREAD_EN,
+	POL_MAC_ONLY_DEF_DIS,
+	POL_TEST_CLR,
+	POL_TEST_CLR_RED,
+	POL_TEST_CLR_YELLOW,
+	POL_TEST_CLR_SELECTED,
+	POL_TEST_ENTRY,
+	POL_STATUS_HIT,
+	POL_STATUS_HIT_RED,
+	POL_STATUS_HIT_YELLOW,
+	ALE_DEFAULT_THREAD_EN,
+	ALE_DEFAULT_THREAD_VAL,
+	ALE_THREAD_CLASS_INDEX,
+	ALE_THREAD_ENABLE,
+	ALE_THREAD_VALUE,
 	/* terminator */
 	ALE_FIELDS_MAX,
 };

-- 
2.34.1


