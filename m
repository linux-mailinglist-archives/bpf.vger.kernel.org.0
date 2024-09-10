Return-Path: <bpf+bounces-39422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B8972D7F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AA2862A3
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA718E77C;
	Tue, 10 Sep 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1hFymu3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD331862B8;
	Tue, 10 Sep 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960266; cv=none; b=YCofBGx81na14sUJ8pNIu2peYUHE9mEBI2uLdyITlfWWXus54A+OECGC9PtAw9qgNEqhWaM+ZEdvcpkDIcfy3M0PIIGpd4sVr+cD8WCFuR/QnWWRx78SopT2oxvRps9C1NBtkp/gWJDUzvah8z1p3PdzvNVSTWvZA2hmpwea9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960266; c=relaxed/simple;
	bh=E1GSVGXmKxLAlK+LOwY9GuD3ZhcHQC6riVbOdVBvdug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9SJfhKge5ttyw/0hFl5EMOslI+tEHEV3EuoyDLpMNozPUjocyCIY8u/k6JdR3IzAt/C1jpShdwtAAQ2uKKqbzBJ1NLDqM+wKKqUy8QnmbNcUkK0lFlJHk7h8BcCpnYIXzesuPTH65Zx6xvHx+P631fpyQCcHoc3nMnFO7b8SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1hFymu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688FC4CEC3;
	Tue, 10 Sep 2024 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960266;
	bh=E1GSVGXmKxLAlK+LOwY9GuD3ZhcHQC6riVbOdVBvdug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S1hFymu32omjgdlTbmPtJimo+ExIUSsIErxs4XKpZRTN6fF3MPfTc8cz8GjO2g1xr
	 zHYC/pxOKQKMpzZvgaGohMRI5TFPYbaqcMPp0dH8nr8A1DH6A+nxj1CrXTHRnB4IKB
	 d8QuqWN0WLGB0sEWBAB4fLj3pCx77+TN4an7fWb/1To7hQJzKN5mpuTD30TCHQW3t9
	 ajMPrqispr3js0iqDov6LANFc+bY7demUYnllCn1tK+exYAxsCFsiD9B1LrMex4CP3
	 4pua4HW2t6w1SP85E7sfAftz6GjBeVq1srGGuVFt/oXPUFoxV+5RX2TNMIHli/WrKX
	 JxdyB5UJqipkQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:24:00 +0300
Subject: [PATCH net-next v4 3/6] net: ethernet: ti: cpsw_ale: use regfields
 for number of Entries and Policers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-3-077fa6403043@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=E1GSVGXmKxLAlK+LOwY9GuD3ZhcHQC6riVbOdVBvdug=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA1NMK8q3vTnC7Jy6dtIRAB6vdgaRYyp77gd
 0OOYEC3666JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNQAKCRDSWmvTvnYw
 k9mED/9KsNqdtUIC2sZmXXP2Fo1hVMVB5qSk24APWblTth0yP/nKKH68zrUvfC71queB/KPvXWU
 Xowqe+3Qz00tUdShO675REZ0AUoh8JXIHYK2L8TTkgwoMOABr9uNIGr2bBvbSKC3fPzpfDg/1tA
 XvA/xq3CODEeMOcu3z/yAEQoavcDj9PxOieK6s9HYSE8E26mOrXS8vR9C1aw50IItrCfduOMcrr
 U3NEdmrKukyACA81eCEV7UEW8gnmZw0oXk/lGOQccm35DNPBfxekclTysvyC5rjO3IYAcfFSTD7
 CDizUQiWsOmzELbcXNLUDlDIL2nT3cx8qrXEQHvVlRdDn/m87J/EpySRlAJmJnZUqqz7qh4DnMF
 sOXEj12FiyouQtuWNljrYYbOw5z9lbK2zdLHRKv9QuQfVbjwWveDHhyTEjHEo2Apf+gHVNnSp83
 K0ifg3R4M3PAj1ALZ2Ec9v11AAC4yOFKNegXybw4MLcc68psdXeaZShjhftcYCQLyyGem05QT74
 69LnGxcGCgNvjwpN/btnBXD2fLRRWC5bYnfckKELRoXADj6+tGUYnOdVi9NWdWL6YbevseuQ2ua
 8A/VhWZcBWtuAwPawdgXz5fm0ao+rJhv/BrHaG0CDb8BEiwd3dKCyTjW0GdILsvIQoNIyL+iNob
 8Edblvr+F0LCT+A==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Use regfields for number of ALE Entries and Policers.

The variants that support Policers/Classifiers have the number
of policers encoded in the ALE_STATUS register.

Use that and show the number of Policers in the ALE info message.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v4:
- reverse Xmas tree declaration order fixes
v3:
- added Reviewed-by Simon Horman
---
 drivers/net/ethernet/ti/cpsw_ale.c | 25 +++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_ale.h |  3 +++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 979f741a231d..9e45470b4eb9 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -103,7 +103,7 @@ struct cpsw_ale_dev_id {
 #define ALE_UCAST_TOUCHED		3
 
 #define ALE_TABLE_SIZE_MULTIPLIER	1024
-#define ALE_STATUS_SIZE_MASK		0x1f
+#define ALE_POLICER_SIZE_MULTIPLIER	8
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
@@ -1303,6 +1303,9 @@ static const struct reg_field ale_fields_cpsw_nu[] = {
 	/* CPSW_ALE_IDVER_REG */
 	[MINOR_VER]	= REG_FIELD(ALE_IDVER, 0, 7),
 	[MAJOR_VER]	= REG_FIELD(ALE_IDVER, 8, 10),
+	/* CPSW_ALE_STATUS_REG */
+	[ALE_ENTRIES]	= REG_FIELD(ALE_STATUS, 0, 7),
+	[ALE_POLICERS]	= REG_FIELD(ALE_STATUS, 8, 15),
 };
 
 static const struct cpsw_ale_dev_id cpsw_ale_id_match[] = {
@@ -1402,8 +1405,8 @@ static int cpsw_ale_regfield_init(struct cpsw_ale *ale)
 
 struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 {
+	u32 ale_entries, rev_major, rev_minor, policers;
 	const struct cpsw_ale_dev_id *ale_dev_id;
-	u32 ale_entries, rev_major, rev_minor;
 	struct cpsw_ale *ale;
 	int ret;
 
@@ -1447,9 +1450,7 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 
 	if (ale->features & CPSW_ALE_F_STATUS_REG &&
 	    !ale->params.ale_entries) {
-		ale_entries =
-			readl_relaxed(ale->params.ale_regs + ALE_STATUS) &
-			ALE_STATUS_SIZE_MASK;
+		regmap_field_read(ale->fields[ALE_ENTRIES], &ale_entries);
 		/* ALE available on newer NetCP switches has introduced
 		 * a register, ALE_STATUS, to indicate the size of ALE
 		 * table which shows the size as a multiple of 1024 entries.
@@ -1463,8 +1464,20 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 		ale_entries *= ALE_TABLE_SIZE_MULTIPLIER;
 		ale->params.ale_entries = ale_entries;
 	}
+
+	if (ale->features & CPSW_ALE_F_STATUS_REG &&
+	    !ale->params.num_policers) {
+		regmap_field_read(ale->fields[ALE_POLICERS], &policers);
+		if (!policers)
+			return ERR_PTR(-EINVAL);
+
+		policers *= ALE_POLICER_SIZE_MULTIPLIER;
+		ale->params.num_policers = policers;
+	}
+
 	dev_info(ale->params.dev,
-		 "ALE Table size %ld\n", ale->params.ale_entries);
+		 "ALE Table size %ld, Policers %ld\n", ale->params.ale_entries,
+		 ale->params.num_policers);
 
 	/* set default bits for existing h/w */
 	ale->port_mask_bits = ale->params.ale_ports;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 58d377dd7496..e12bb2caf016 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -15,6 +15,7 @@ struct cpsw_ale_params {
 	void __iomem		*ale_regs;
 	unsigned long		ale_ageout;	/* in secs */
 	unsigned long		ale_entries;
+	unsigned long		num_policers;
 	unsigned long		ale_ports;
 	/* NU Switch has specific handling as number of bits in ALE entries
 	 * are different than other versions of ALE. Also there are specific
@@ -33,6 +34,8 @@ struct regmap;
 enum ale_fields {
 	MINOR_VER,
 	MAJOR_VER,
+	ALE_ENTRIES,
+	ALE_POLICERS,
 	/* terminator */
 	ALE_FIELDS_MAX,
 };

-- 
2.34.1


