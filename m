Return-Path: <bpf+bounces-22804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B086A1E2
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D63C1F26F4B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518C155A2A;
	Tue, 27 Feb 2024 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S92c4uMF"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65CF1552F7;
	Tue, 27 Feb 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070477; cv=fail; b=sesdjGLuAfNbFEPsbLR/xKc8tqoAUsBakkR6uUd0/FWgD/Hf5Gv+xBHCc3X5bMCXzQC3vpfivzABoxRLfqBvhHm0gEXdoUyeaiK/pcGwg9zPeted6Y/+VXNcVHCsow2u0mrvZSD8LINarMxu1TB5nIvLEBHlBkyyc6r6yNZm01g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070477; c=relaxed/simple;
	bh=cn/ufN623D22XcRlM3N35TFCdHgjo7eM67GEijjta8s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s8b2i7jEr4kBHmwBldeaUOrzK/SENr/y0olD2Zj5DfIFKu3F1fnC6SSf1bdeZCXlmqMxHIppy8mXTDaBYQFjAsqKRt5MZPf5BWLK4U5ccXR0UmLJllREM8Hr6nGfn7/4ctRCAH+retu5q6g/WHxU8qkqF3gixYitm1W5Ox31PuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S92c4uMF; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9NKSOSc6iusRKS/Abs24Iem1nJ8XCgtCIbFkcSoqGazhQp2LKVu0qET9qdvb9VHDuDwx18WsIX+97VCxUYhg0LP6MsduqlEmJq/A8S7srIZGMk88hYcpodMXmqA9MGOb+JfbfI/nfXfGLKQNH3FVKs9lLg1iFjdZBDal2A9m6jh/q1nwSNqIGg2bsHLF6KK6srgY5sGSAbTFfwo1H1+M4N0nJIqZjuIaB8e7Ss6Ck/+haI+AVH/duiSsgqJQMLJiQMICKkopmB5Hbkmv+wcQRAukBiur0XL1Sy8Q7jawcgXhRH9VoUuE+zzxD94AWFv8VOQ017SI9a6+mjiRgzjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9NwUPHoYMcETkXgNCojiyj5+UdKPIeBtSfBhZUFfuo=;
 b=Qk8lAj/UjvMu+y8YmVuuYRKaHF2Nj47uX04O2qCEbpvbU/EQh9NpV/OIYj1QLujPiFpq4W8A5x7vjvLy0lqL6D6p55JOxLd/2yVDxuyr4eMLetQVBbURBXQeURNBYc/9bjTHNRX5N2FuiMAy6fE9PAMn5nvMWWIQO2fRXyVdROBLMxhW2tPbiIW6HQqNr00oQXNO9SofH5oe5uP0S9wuHzHHEsa41GiEEKAJE0OP82IsC6WjNZ7c+QOyim7IUXrYDV3ICcFs/FqsXwlBwK4kld+wfmLuZNfaRGat8PkG1cAA+pKQs621xNkVOPNMZ4f0cPoUmcPQ9D4+yNKFYuN1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9NwUPHoYMcETkXgNCojiyj5+UdKPIeBtSfBhZUFfuo=;
 b=S92c4uMFynNSR2cf6L7ZDbtWKtLXVlH4GSDMu6L5Q0jrCVyoGEQU+MunKwLZLC5WtuRT85dYAjzlEwlGOCWuZ/FAn+AB3iznGE7D1MP914QxzmmxlwFjycF2qr7XKMLfplSZzXBcDCVjZLFLRMaTcusIUpEGkgG0IEct1KJ35VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 21:47:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 21:47:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 16:47:11 -0500
Subject: [PATCH 4/6] PCI: imx: Simplify switch-case logic by involve
 set_ref_clk callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-pci2_upstream-v1-4-b952f8333606@nxp.com>
References: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
In-Reply-To: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709070448; l=8514;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cn/ufN623D22XcRlM3N35TFCdHgjo7eM67GEijjta8s=;
 b=UXlwlz3Xv717sRD52OM1TRqCgJjSfwkHQbd3CGFzlt2RMMQX9xBAZ4Hk8nOGcdhWKGcgcVLDR
 FYT7VAPiz0+B3nCLSgfIAow7vmQlGcCHPzSC7wSe0pR0x7cHeEC6oFn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6e0f52-be8a-4979-e4e7-08dc37ddbf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ju585KNPUwSscCkSy5A8M5PeSQ4HNhL+rBWcX5Y51Uhjzu7iZ9cz4yL1VcwAvS8hIkiPWkwkz6LxxoAdOjoWhwPLbgdHSwTh8IRUrcDl8IYDF5mnTcrAyo2DxPTHQhqrgeURyXIVGuwYnz8fpUe3GOxFd5qd7jPA37tTbILAYRF6QqlLBToobr9EXS4AJe1qbWgJbQy/IT1RcynjLucYT2CNIWN8Jc4tKF0dInKxmzsTN3SpgUEDVvstsGjBi669TX4GjV1cz3e0rV2X7gVnzIkZBfwPiFyTLCzJU6hTB+khuNVzfxR/w1aOxpcMSGy0s0s2uWS/C3IG9eB/s/GupTJq0n4VALbPqyKR3zjEAuv9L5j3NCYNjuTedy4B1fYENaYufIdBUfcqu7B/HDidhlRjNDt0bL9k4TOElUe9Mo7VWK3Fb37UyC/BY0DB/DDpgWjecGK9VCH1PgtI3BST1T68/BK0bx6LJQ2cND2qk/wHWmP4Ehxk8H5bEObBDxJwAkmFLIF7frKybOAa/0w2Ul7MGqKcAtSxI0qhuYoQ8B4P7VK6AuvJ/caglfKwoJ57pLgJkf1vqxlq4fK9ormMeqap55WU+EFAHBqHzdzK+YEDpePaPhkjYUqOaDJuwmeSQwRnWhwU01NWCVzZEP8X7Dlgkuz784aq6hJXuu7b3psrBDGWAPCIigo8fdlqM1ZHMllV3kZIS1nuHlbNjYn796x62vVAAgMDWySt4568VcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VnZjYvVFh4T3oxZys2OUQweDlGdDdITjJSNkRyL2FsYThQNDZJelo2MzB2?=
 =?utf-8?B?UEErYkRrQ1FxVGo4VTZ1RCtJcmF6ZzB1NG96Z3plNnM5NUJTbmcxaUhVb3dR?=
 =?utf-8?B?RXAzZm5PQkZ1Sm9QNnRISXhqVHd4dnZkcDVmMGZBYWhtS04yV3JrY2dRaFFw?=
 =?utf-8?B?YWFFcEF5N0ZaVElud1RiUUQ4RU5YdThOWm00cXdhNmFWTkhnYi9IWlFwMGxw?=
 =?utf-8?B?Z1FzVk1uSlVwbTZVbmNGZ04vQk1PUXI2TFFJaHRiR2llMXhuMmlzYUNQY2FI?=
 =?utf-8?B?L09qUENwWkJoa1JKUjFZalNrRDBZZEgvSy9BRXVPYmVWL09HMGlOQkMvWitl?=
 =?utf-8?B?MktEZGRmK2RXbW5ZbmRzV3prbnlMQUdRd3JsT1pxQlRFVDAwV3htMDh2WGJC?=
 =?utf-8?B?UXRzQUNVMkpxM2MzYkNSQis0MjNoMzhLVzFYVjE0K3pLUTUxc21YZXZWZTYw?=
 =?utf-8?B?WEJ6dFE3UmRxWWcrdUpLckg2QUZzdUVLb0RlRXFFVFArMWJGa3VXeGVFUGFp?=
 =?utf-8?B?Um1RdVI0WVQzaStUelNCSlZnR3FoNmZNZjhPdDhOeWpjKzhXUkVUTWxPNnFJ?=
 =?utf-8?B?QUZXZXJ1MlFrREdPT0dqbXdGYzl6Ny9vTUQvMldJbVhjWVRpM2VhVWZscnBo?=
 =?utf-8?B?aGljUDBwL1puU3lMUkV3Vm1YODJ6c1FTYkVtS3FjeWhYWVJ0bGhLMnlXUjJ6?=
 =?utf-8?B?b2M4VzlGd283UGZvVUk0dEU0SHpyNG5NUlFRY21oQ0dSSE1yUlFBeXBDS1hK?=
 =?utf-8?B?TldLMzdDOExBelBJd2dSVkV4NHQzWDFrdzczNlZMQXQ3NVR0R1B1K2dFcjlP?=
 =?utf-8?B?WUYyalY5V0hyTVV3THhZTVhnaVlNcFlYWFQwcFY0aC9pQ1hQMTF2aVdXNjlM?=
 =?utf-8?B?MlhwK2Vjb0FDckhlUXpxNXBSRUlJY2E4T2ZKUDhxWldUcy9tK1pLaUFVTGFi?=
 =?utf-8?B?bVNxQnFLTUVzTU9Mcm91c0pwd1hzOWR0ZkdiY2VUNlVmTTkyRG8zOHgxK0g3?=
 =?utf-8?B?T2FodjJJMTg4VEc1ZU56QWVtSURTWGVoTFZvNEJNVGZyMGtKV1FyODRnNWVp?=
 =?utf-8?B?bXVXK2NKYjZhQy9LR2FMUjRPZGYwOWxobnR3TmRKUHVhaUt5bWRyckh2Nlc4?=
 =?utf-8?B?dnpqcGx4bVBQd0NXQkJMK0grVTQ1ZDc1djR4bjR6azZQc2R1cis4VlRUcVdS?=
 =?utf-8?B?eUwyZVRHdzFyNjJCOHZlTUFuWTdreTZmZlNOcGRlZ1hibUhGdHB6QTVSemUv?=
 =?utf-8?B?TEFZNW9kTkplMW1raG4zK1pwMlozU0QxM0NldThyeUJvRS9WVjBneU11SFFF?=
 =?utf-8?B?aDNzRnkxOXlhdTZIeG56SC9GZ2FpY0R5RmpJMkNTNXlwNUthWnNHbXNSR285?=
 =?utf-8?B?d3RHUDdqSW9tbTRmV2sxZCtCOTNGRHhYMU1LTWc2VG53U004a2RCR3hBRXdu?=
 =?utf-8?B?RkpmK3dlT3VzZld3UmI3Y3ZNQTRHQzVXYVduSlg4bHd2Z1RjQ0RESUNOS2Yy?=
 =?utf-8?B?dkZTMnBySGJPTytibUhQWWJqTlh3MkV0SC9reTNka1VGTkl3aXkvOUVPZHJ2?=
 =?utf-8?B?WGNaZUIzWjNwQ0M3MWdMMGJzb1FwNWZsTGFFSGZpSUgxb2dTMWl4VkpzQzUz?=
 =?utf-8?B?QXBSTmxjWjNRaFZsdGxaYW9iWW1teFRMWEVyUFcrbnlLVVJnTlRmWXo1QkV1?=
 =?utf-8?B?cEQ1dnBjdmVVMzlDMm9oeFpoOWlmaVFXR21iQlI1K214Y0tzUytLeUo1cWV5?=
 =?utf-8?B?RXhDRmNFWjZDN0dteEI0WHB4RS9zV2R3K2lPamNkS1VDTXBWY3NMOWdTcUVB?=
 =?utf-8?B?Tm9GdXF6V2VVcHhJaG14RlhiRGh3YW04eWRka1V3dzVGdzROVllIRTZhOUZv?=
 =?utf-8?B?NlExVFZ2Y1BBcFIya0x0c0plQ1ZObjRKSTlMMHZibExOQ3RtUTduSnA1WHBq?=
 =?utf-8?B?MnV2ZGZwNUNyZmMwVzlReW5QQnoxbk4xMWFWSU1LVkM2a3lNOEhJaDFPMjFl?=
 =?utf-8?B?anBzM0EwQi83OTdUbloxUXkzSVF0UTdOU3haOHIrVVBmTDBHWUZuNDZ3OElj?=
 =?utf-8?B?TzRNMG5aVGZ4M280MEdwN0pmRk5yN3hQOHpQdlZvNjZkUENmdmZ5OHFwSUR4?=
 =?utf-8?Q?aXoGXMxwECpPfaC6YiXlqUvfW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6e0f52-be8a-4979-e4e7-08dc37ddbf4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:47:51.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yF5Z3jUtvkv/pyu5AlzpUOzfLP6AjMvO+lIv6sRZCxTPsK7I5pZyBHjYU6FClVa0TgI951kzxJ1U/td2tDhjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx.c | 119 ++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx.c b/drivers/pci/controller/dwc/pci-imx.c
index e646ad70a2a5e..a63ce171ede8f 100644
--- a/drivers/pci/controller/dwc/pci-imx.c
+++ b/drivers/pci/controller/dwc/pci-imx.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,77 +586,54 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
-		break;
-	case IMX6QP:
-	case IMX6Q:
+	return 0;
+}
+
+static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
 		/*
-		 * the async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * add one ~10us delay here.
+		 * the async reset input need ref clock to sync internally, when the ref clock comes
+		 * after reset, internal synced reset time is too short, cannot meet the
+		 * requirement.add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
 		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-		break;
-	case IMX7D:
-	case IMX95:
-	case IMX95_EP:
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		offset = imx_pcie_grp_offset(imx_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-		break;
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6QP:
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_TEST_PD,
-				IMX6Q_GPR1_PCIE_TEST_PD);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	default:
-		break;
-	}
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN :  0);
+	return 0;
+}
+
+static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->set_ref_clk) {
+		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie ref clock\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1462,6 +1443,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1476,6 +1458,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1491,6 +1474,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1503,6 +1487,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1516,6 +1501,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1527,6 +1513,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1538,6 +1525,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1564,6 +1552,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1575,6 +1564,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1586,6 +1576,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


