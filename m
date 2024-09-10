Return-Path: <bpf+bounces-39421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B793972D7B
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F092859BD
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8F18CBE2;
	Tue, 10 Sep 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW3FKaZp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A70188CB1;
	Tue, 10 Sep 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960261; cv=none; b=GCXWq7wfPDrfp5wXI8ViYZKrhtLv/zoJRO2pH9H/rS3KQnyGUD2d0pUU3BQL0MkBrJ2YYD2OHEPZJ1PB6M4WJ6jCRTsKwe37JoS8DgUUeBAqbHzrxwsPAsXp0Wsr9Iszx6jp8i6pf1sGK8hgo8BbL6VHB341cFY1okSCjbuvhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960261; c=relaxed/simple;
	bh=PFNnLTD7CaYjH2DlEg+zMBJShzrODexUAt4TPrsptbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EM9mRL/Igm1CugVOnzw8fcJ0DXUCuAthn7nzE8VlyCJ47EsEoyerFmNpVpz4dtOA69hAsUCr9g5XXDLzTLt3rzfvzC+e6EplRQMCL0Cjt+pmmmzhIQTmw6qbXqW/4txnF3k3ip7h01GoTdQNAiAGJbt7NV5gyzb6AI6L6JL3ZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW3FKaZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8EFC4CEC3;
	Tue, 10 Sep 2024 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960260;
	bh=PFNnLTD7CaYjH2DlEg+zMBJShzrODexUAt4TPrsptbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hW3FKaZpgo++eBc5l63SooSzpzi+fBfsrEIkNRoHuGaMWkzMWLaKxtWyf20kzv9pT
	 umr7nCkjedE94iz3BSzybo1U/zaBqoKNxFNqgUXw4gd/iMWqScCfeVOU9PDWf77J+r
	 ekoGWYLa/dC8YkOCWUaplx/Zl32m55lrQ+GXa+XKhRTeBn3h/FebW8oR88fZPRCGG9
	 flfghLjPLNywT8h6RezfVysZu5QFNOopa9ertEktrYU+GtDChGETN3uNVFA5yDrwud
	 XUq734Z84bdZMWPx+kquiS8ysBK0wqgD3nxayAbyhzBIqxINfr+MvXRmrcDjBx6Pzt
	 jLTpMyyKBQBxg==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:23:59 +0300
Subject: [PATCH net-next v4 2/6] net: ethernet: ti: cpsw_ale: use regfields
 for ALE registers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-2-077fa6403043@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7593; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=PFNnLTD7CaYjH2DlEg+zMBJShzrODexUAt4TPrsptbQ=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA1lwzEKAYECIMoymT9xxBhpiThE42CrDoGc
 c3zbNGzLR6JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNQAKCRDSWmvTvnYw
 k6SKEACngs+2gPgzaPQ+/ezVdfSVB15UCg51nJHpgTNpXIDKj0IXdSirD8yKgddKQHhglT8OTPd
 zjIz5zOjgZRKlMkd5ETbZttBrtBUb5pTZkBK4u+FaeuCQupcEAnT2vbInIIw3Trkb3MM+ffVW37
 5fSgtTKq9GW7nOLQ/a6MbJMxOhFMCm2wfI2uEltYEPAzq1WmTCZVpo0xzhCf0Zld7pnkh1rAfAh
 Y/HzG5YCps5XaXYLWql1txYcKbx5edrVVIZgQU1fM4hHZ/Q2KbOXFBD8xL1YJqzGWxBnoDKWIXb
 0iim+ujDZscKcgUORBaAnhmmhlJMJG2BB9Iu2wwG7HxR/er+Pn3ULnVq953bB1MfCX9vdsbVz2T
 QPN3dbUFPSBN0cKpR0k7NUbVE3p5IrE/qpnrs/Xw75uBmrU1Tf05qv5CwlqP83oTlkja0uU5IMZ
 7fMmjJC8w+MTvWxBMgtFLlhpIKeuP+VRrag4J5MLHCXfheMmF0+3H83YRctctWUKq8qPMYC2P13
 ywfk1/5q6H8b3C577iAXartY+DGqIKbTCVgsOJnH8NCcMkrNiWqdqfubsWvXfuHV7Cxey5yJBhb
 8cWZXVWopsw4e5V8n9PlHX+oAGl9RwbAH3lv5Uvf4KqYVsbiL+6uYXak5t8KOSAPlAAp6gomCCN
 IN0474D7qx7VZ2A==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Map the entire ALE registerspace using regmap.

Add regfields for Major and Minor Version fields.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v4:
- reverse Xmas tree declaration order fixes
v3:
- added Reviewed-by Simon Horman
---
 drivers/net/ethernet/ti/cpsw_ale.c | 84 ++++++++++++++++++++++++++++++--------
 drivers/net/ethernet/ti/cpsw_ale.h | 17 ++++++--
 2 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 64bf22cd860c..979f741a231d 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -76,7 +77,7 @@ enum {
  * @dev_id: ALE version/SoC id
  * @features: features supported by ALE
  * @tbl_entries: number of ALE entries
- * @major_ver_mask: mask of ALE Major Version Value in ALE_IDVER reg.
+ * @reg_fields: pointer to array of register field configuration
  * @nu_switch_ale: NU Switch ALE
  * @vlan_entry_tbl: ALE vlan entry fields description tbl
  */
@@ -84,7 +85,7 @@ struct cpsw_ale_dev_id {
 	const char *dev_id;
 	u32 features;
 	u32 tbl_entries;
-	u32 major_ver_mask;
+	const struct reg_field *reg_fields;
 	bool nu_switch_ale;
 	const struct ale_entry_fld *vlan_entry_tbl;
 };
@@ -1292,25 +1293,37 @@ void cpsw_ale_stop(struct cpsw_ale *ale)
 	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 }
 
+static const struct reg_field ale_fields_cpsw[] = {
+	/* CPSW_ALE_IDVER_REG */
+	[MINOR_VER]	= REG_FIELD(ALE_IDVER, 0, 7),
+	[MAJOR_VER]	= REG_FIELD(ALE_IDVER, 8, 15),
+};
+
+static const struct reg_field ale_fields_cpsw_nu[] = {
+	/* CPSW_ALE_IDVER_REG */
+	[MINOR_VER]	= REG_FIELD(ALE_IDVER, 0, 7),
+	[MAJOR_VER]	= REG_FIELD(ALE_IDVER, 8, 10),
+};
+
 static const struct cpsw_ale_dev_id cpsw_ale_id_match[] = {
 	{
 		/* am3/4/5, dra7. dm814x, 66ak2hk-gbe */
 		.dev_id = "cpsw",
 		.tbl_entries = 1024,
-		.major_ver_mask = 0xff,
+		.reg_fields = ale_fields_cpsw,
 		.vlan_entry_tbl = vlan_entry_cpsw,
 	},
 	{
 		/* 66ak2h_xgbe */
 		.dev_id = "66ak2h-xgbe",
 		.tbl_entries = 2048,
-		.major_ver_mask = 0xff,
+		.reg_fields = ale_fields_cpsw,
 		.vlan_entry_tbl = vlan_entry_cpsw,
 	},
 	{
 		.dev_id = "66ak2el",
 		.features = CPSW_ALE_F_STATUS_REG,
-		.major_ver_mask = 0x7,
+		.reg_fields = ale_fields_cpsw_nu,
 		.nu_switch_ale = true,
 		.vlan_entry_tbl = vlan_entry_nu,
 	},
@@ -1318,7 +1331,7 @@ static const struct cpsw_ale_dev_id cpsw_ale_id_match[] = {
 		.dev_id = "66ak2g",
 		.features = CPSW_ALE_F_STATUS_REG,
 		.tbl_entries = 64,
-		.major_ver_mask = 0x7,
+		.reg_fields = ale_fields_cpsw_nu,
 		.nu_switch_ale = true,
 		.vlan_entry_tbl = vlan_entry_nu,
 	},
@@ -1326,20 +1339,20 @@ static const struct cpsw_ale_dev_id cpsw_ale_id_match[] = {
 		.dev_id = "am65x-cpsw2g",
 		.features = CPSW_ALE_F_STATUS_REG | CPSW_ALE_F_HW_AUTOAGING,
 		.tbl_entries = 64,
-		.major_ver_mask = 0x7,
+		.reg_fields = ale_fields_cpsw_nu,
 		.nu_switch_ale = true,
 		.vlan_entry_tbl = vlan_entry_nu,
 	},
 	{
 		.dev_id = "j721e-cpswxg",
 		.features = CPSW_ALE_F_STATUS_REG | CPSW_ALE_F_HW_AUTOAGING,
-		.major_ver_mask = 0x7,
+		.reg_fields = ale_fields_cpsw_nu,
 		.vlan_entry_tbl = vlan_entry_k3_cpswxg,
 	},
 	{
 		.dev_id = "am64-cpswxg",
 		.features = CPSW_ALE_F_STATUS_REG | CPSW_ALE_F_HW_AUTOAGING,
-		.major_ver_mask = 0x7,
+		.reg_fields = ale_fields_cpsw_nu,
 		.vlan_entry_tbl = vlan_entry_k3_cpswxg,
 		.tbl_entries = 512,
 	},
@@ -1361,41 +1374,76 @@ cpsw_ale_dev_id *cpsw_ale_match_id(const struct cpsw_ale_dev_id *id,
 	return NULL;
 }
 
+static const struct regmap_config ale_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.name = "cpsw-ale",
+};
+
+static int cpsw_ale_regfield_init(struct cpsw_ale *ale)
+{
+	const struct reg_field *reg_fields = ale->params.reg_fields;
+	struct device *dev = ale->params.dev;
+	struct regmap *regmap = ale->regmap;
+	int i;
+
+	for (i = 0; i < ALE_FIELDS_MAX; i++) {
+		ale->fields[i] = devm_regmap_field_alloc(dev, regmap,
+							 reg_fields[i]);
+		if (IS_ERR(ale->fields[i])) {
+			dev_err(dev, "Unable to allocate regmap field %d\n", i);
+			return PTR_ERR(ale->fields[i]);
+		}
+	}
+
+	return 0;
+}
+
 struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 {
 	const struct cpsw_ale_dev_id *ale_dev_id;
+	u32 ale_entries, rev_major, rev_minor;
 	struct cpsw_ale *ale;
-	u32 rev, ale_entries;
+	int ret;
 
 	ale_dev_id = cpsw_ale_match_id(cpsw_ale_id_match, params->dev_id);
 	if (!ale_dev_id)
 		return ERR_PTR(-EINVAL);
 
 	params->ale_entries = ale_dev_id->tbl_entries;
-	params->major_ver_mask = ale_dev_id->major_ver_mask;
 	params->nu_switch_ale = ale_dev_id->nu_switch_ale;
+	params->reg_fields = ale_dev_id->reg_fields;
 
 	ale = devm_kzalloc(params->dev, sizeof(*ale), GFP_KERNEL);
 	if (!ale)
 		return ERR_PTR(-ENOMEM);
+	ale->regmap = devm_regmap_init_mmio(params->dev, params->ale_regs,
+					    &ale_regmap_cfg);
+	if (IS_ERR(ale->regmap)) {
+		dev_err(params->dev, "Couldn't create CPSW ALE regmap\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ale->params = *params;
+	ret = cpsw_ale_regfield_init(ale);
+	if (ret)
+		return ERR_PTR(ret);
 
 	ale->p0_untag_vid_mask = devm_bitmap_zalloc(params->dev, VLAN_N_VID,
 						    GFP_KERNEL);
 	if (!ale->p0_untag_vid_mask)
 		return ERR_PTR(-ENOMEM);
 
-	ale->params = *params;
 	ale->ageout = ale->params.ale_ageout * HZ;
 	ale->features = ale_dev_id->features;
 	ale->vlan_entry_tbl = ale_dev_id->vlan_entry_tbl;
 
-	rev = readl_relaxed(ale->params.ale_regs + ALE_IDVER);
-	ale->version =
-		(ALE_VERSION_MAJOR(rev, ale->params.major_ver_mask) << 8) |
-		 ALE_VERSION_MINOR(rev);
+	regmap_field_read(ale->fields[MINOR_VER], &rev_minor);
+	regmap_field_read(ale->fields[MAJOR_VER], &rev_major);
+	ale->version = rev_major << 8 | rev_minor;
 	dev_info(ale->params.dev, "initialized cpsw ale version %d.%d\n",
-		 ALE_VERSION_MAJOR(rev, ale->params.major_ver_mask),
-		 ALE_VERSION_MINOR(rev));
+		 rev_major, rev_minor);
 
 	if (ale->features & CPSW_ALE_F_STATUS_REG &&
 	    !ale->params.ale_entries) {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 6779ee111d57..58d377dd7496 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -8,6 +8,8 @@
 #ifndef __TI_CPSW_ALE_H__
 #define __TI_CPSW_ALE_H__
 
+struct reg_fields;
+
 struct cpsw_ale_params {
 	struct device		*dev;
 	void __iomem		*ale_regs;
@@ -20,19 +22,26 @@ struct cpsw_ale_params {
 	 * to identify this hardware.
 	 */
 	bool			nu_switch_ale;
-	/* mask bit used in NU Switch ALE is 3 bits instead of 8 bits. So
-	 * pass it from caller.
-	 */
-	u32			major_ver_mask;
+	const struct reg_field *reg_fields;
 	const char		*dev_id;
 	unsigned long		bus_freq;
 };
 
 struct ale_entry_fld;
+struct regmap;
+
+enum ale_fields {
+	MINOR_VER,
+	MAJOR_VER,
+	/* terminator */
+	ALE_FIELDS_MAX,
+};
 
 struct cpsw_ale {
 	struct cpsw_ale_params	params;
 	struct timer_list	timer;
+	struct regmap		*regmap;
+	struct regmap_field	*fields[ALE_FIELDS_MAX];
 	unsigned long		ageout;
 	u32			version;
 	u32			features;

-- 
2.34.1


