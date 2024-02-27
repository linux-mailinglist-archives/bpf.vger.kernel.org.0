Return-Path: <bpf+bounces-22805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E7A86A1E5
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474602883E1
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB0157E7B;
	Tue, 27 Feb 2024 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCw03z1j"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD07154BF5;
	Tue, 27 Feb 2024 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070481; cv=fail; b=mKtNa7dVYxzv1NTFdV3GvNX2ACoGQACCuhHDpgLNrbLIZi8UGWtMGRMjlJwRGqghh32Y5OLnSBB+jhNfOzybD8T/5rM4/DQdf56693S0T48CAN3hRJpSzLszToi72TBA7iuPDMzxg4zINGfI3dRwFAdXhTkzJVHamONVLXxrB7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070481; c=relaxed/simple;
	bh=G9EHK/0mVHaUz9zEpQNHxMoHdNZEcg1Av5M6Mp8X4CE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o7A2g4MgRL1Zbf2B/Qq0svjiqh21VKiPM0IfdtBlxm7QTRI2n/v113oPcdu9yBTT67NqOuQFeFho+TNfjEeFAIFmpTTgyUSDwa/VhKOz4yZWLvMiHOvCIDHstBlHMbqFerzP1ftCaGiJ92FO2Z5KjBrmwAIHLryJbGjuP4m2Xlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gCw03z1j; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9ZmV9JNz6zsI40rC6f0hbEoKHqdSUFzK8PydFXWZFhsb51OLO/uDD1d0OUCr6tOgFfsq/89vcB7yVfsa7HbpREprhyKowBZLDKKPo4vZBvMqGBRDXhj2n51qbsmKW/Y0VPzGE4dCMIdL2cIMG4XjaX0Muy73ov1ytBAwOWxskbsW+g+CnZGcsAHrmn/knGhJJzWdCmZOS88l9icbo6sHeSq1TOneZeQfZsJcJNVJe6VELizgLeR0f9k/AJ0nGGTj/S3fv0ZmPnxIjieMc7rc/2bQOaQUXa0WNYi7dCidjkT9EESwSufCsQQXRcXz39p/x5DgafJkc5V499kswij1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdrOYJZj22EFcaBPN4ILSseZjQCAK4Lfh/z6ZIVrliY=;
 b=lq0L+AWgiMngMUSNQ4HykBnGNC1XEOiZH6D2id2YMxvwNoNbJEJIacSLN/2qqPwyyqSIVDp1rvGaFsQMwGvx/23xE7/48T58w7LwklIOBrVKz/9F6/tX9wQYKR1gZvS/VbebnUZA/X4v6j+4Ba40F2BdAqSrZB/k6mNjTlKvEtRAyoCwX+9anu5zCHezdkrX/KgKE4sQ8ZnDG3rt3l18WMsRWvgcOfPPOxzfdvaE3PNkr26yK5idMmHlSsUaBKfwrK0iFprtqeBFaYPmMGe/KguwGywVu73SWcCzpRbNq8lgDe5z3VGavLnahgnH/CpxY9qnqA4txrfaxqmbilCn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdrOYJZj22EFcaBPN4ILSseZjQCAK4Lfh/z6ZIVrliY=;
 b=gCw03z1j055XG39Fyz5nxfVoMMH2nfn/HCrn4z5bMm2iW2g56PPlwH8aKCcNG5pRPA3JA+6q64MvoJZOid5zd0PUIPWVOHCkHmUPTRGTYyNW8rMw34V7yej7suSTsK+N1dDxnRwE6Q562QIutKV9IuZBefjsBaay97pXZ1DTWrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 21:47:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 21:47:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 16:47:12 -0500
Subject: [PATCH 5/6] PCI: imx: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-pci2_upstream-v1-5-b952f8333606@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709070448; l=7121;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G9EHK/0mVHaUz9zEpQNHxMoHdNZEcg1Av5M6Mp8X4CE=;
 b=K+bYLRnhH0hLmty0PqWm//qiHkHDSiODBa1PtVdMj+cGFjNezoYzFmDhnDb7e3sHhOl/B/mkj
 kS7rUDR6uFeCcmL9ZDUXQakhwoh8Hh0a5MRaCJ6jHZbyMEGSrwaxWH1
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
X-MS-Office365-Filtering-Correlation-Id: a63c23e6-4fe2-4d5d-4237-08dc37ddc215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e0FRoCCgKe1LhdiEoOz0xHuFVLBuVc+0GoRp1N4M7XTP44QjughPCPWo0ymx0hvQAl9tmUfV/+xZF6ozjX1WgTfN3tc2rejxO5tauxpVlpwGR42t+L58hBX/GuCTc1QLpx/DnlMYgdLY9PlE6YLHfH8sG1uab1fFmai0OivYJ6bHe4b9khwTIsBvHJrUQ193z1qo4eWwjA9e3JSrPOUjZYlQ534MffTm2Cmrhq0LOD7v5pXBoWwtMRSEAqVly/Tom2bkSFhqx+rGMMm/RG3E5G76Xrd7rE9enFcqsHTX3jaBPq5Lwg+iO9A1tJ7GDwBPEb7dRhQBdDIcthH+Omyefn30nZAorWC2vbWxbflS+MKZ2eJqIdnudNfMydZW1rIbBmUX9cDJtB2gp90L/iSaTqgsP43GvOMXOZRdFSgxqBx6XF+YudOFGZ033mnaTzVk07gSFTrn3kaLiEBadLB0cfADaMETyHM4e+EEiyYCTCiz/f5+i2iIwB/5qixHHqwhyT1HxSw2ZbiBiGJqmEI/aaRWEiPOKvm8nm/LEuMqPrdUW9cqch03JY9AYJlpyUMBqkwo+PxFK7tAf5vzJBPW+ECCLM0wjtHn5XrUgNbt1fHIJP0EisffPWdPWPq+MCJVzVS6/INIAvNzVpZYZefLQxiDQ5yjRsshFecVKzWR9J25w780bqqIjGqRH8/Md/35Ux1y19Ml3XWoQpd3d0yKyx7b7GD1d4z6S1YuCGXL9CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWp5RUplVS8ybmVlbFlZZ0cxZkJ0TjRiWEU4S2Y0cGJ5amZXLytpQzEranUr?=
 =?utf-8?B?cWNWOFkyMER5UmtFVUFVM2FSeVQ1OGFnUUp0MGdOWEhSd1dDNmMxL2JROFQ4?=
 =?utf-8?B?OGFNcWk4elVPTDB1RTkzVmRXdjlDeXBXUTRaVEltUDJVNnVMNFV1bGZCK2Vn?=
 =?utf-8?B?RGpsQmJwRXV6ZFdtYXVQci9iZ1BkMXFzOFVvUG9VL1RpNkpUT2RKUGNlMUtr?=
 =?utf-8?B?RCtPT09sSGZVc1pzN2R4N3NSTjN4NU0wOEJrT2xpOEIxb04raFVBKzlySk1x?=
 =?utf-8?B?anQ5YmgwOTdoWjUzOHlsd0MyZ1lYWGxaeEI4NDhJTUMrdmJncFlGVWtUdW5h?=
 =?utf-8?B?MGxsblozajg5elFSTzhLU2prblkwK1lzMXk3bFNCWlVGYXpXN0F0Ti9HQVBn?=
 =?utf-8?B?WWplc1E4Z3NsUXBsWVd3bXFQaDZMOTlwY0dRUmxQVnMxV2FsYlN0ZTJwS3N1?=
 =?utf-8?B?TDFrMysxbGsrbEFxUDZOUHA3dDZEbXRmSk1GRmhCSStrM0pwNUFNVjhOK2Iv?=
 =?utf-8?B?RTZPbWdza0RxWU5CNEtiQkh5WlU4WXNRNVM3dW9wUU9Vdk1vNzNXUVpLTUd1?=
 =?utf-8?B?ZlNsWjBqdFZNaEsxTjZhOW50QWJOVWEyS1gveGVUMTB0Q2g3dnpQOFN2U3Jq?=
 =?utf-8?B?d29YaVZGR2dhSzg5ZE5wbFlLQXZNNTNyNHFKMjZSZmo1UG9scWFoaVU1YmVk?=
 =?utf-8?B?bHdzSlRqNkFsNEZNUm83U3pZd3RnZzNpb1NSVEkxbXJOK29JN0RvS1FTQWVT?=
 =?utf-8?B?emxaaXkvQ003TTZWaDdsSFIrQzNEVU8xT3IyRkdqRDNaN1VxYWVoYWpTTVpN?=
 =?utf-8?B?WG0rRVlYUXA2U250SndubUdYRStBVkRDWFduZVRkQzBaR2xITkI1am4yUXcw?=
 =?utf-8?B?R0QxSHlSVC9kOGJIejJxSGY2ZXFibmY3bUFodUp0UFBJUWlLUThiUlpBblhH?=
 =?utf-8?B?RHFYb3pPU2hVTTVNL25kQlFzR3ZsMXROSHNHbHlBNk8ybHhQQ1JQR2YxNFhw?=
 =?utf-8?B?a2ZTVHErNzZTNXFmdzNHQkpDdHBoOUpTd0Z4b0t3ZkRUc3hhWHZhYVVKTEJr?=
 =?utf-8?B?ZXRJMFVjZjNtODZGeXc2dlpRLzBjV2NGMHlVZ1czMnVVZUw3OGFJMmxtSnlO?=
 =?utf-8?B?RThQY01US0QxSHV1UXdwb3BCdng5MHpVa0xwNU1iR1RPNVdFanBLMkNoRzNK?=
 =?utf-8?B?NmFIczRQV2RVWWdEcW1wcStMUXd2QS9HcnZ6cm1LV2grMzZRTGpkYTN1RFVo?=
 =?utf-8?B?ZkNBc0hyUGZxZnpFdEpyRXUrNDQvc1FiM0U3OG9GRWZoY1hBbXVaUm50UXZS?=
 =?utf-8?B?bUNYbGJKT3c5NjVTMThzRzk0eVAzdnRPTDh3K1AwY2Mzc2wwVVNMQXpxZE9t?=
 =?utf-8?B?bS9YeDZPSHA2WmcrTXJnY0pFYTVpWHloTDI0UEN4ck5LN1Y0d0NaSGxqVFlL?=
 =?utf-8?B?TjFLZ3IweWJPblh1UFNVcnJoaFE4alp0cXVISURic3RDNTlYUXdLM2lWSFBv?=
 =?utf-8?B?N3RQWTJkdUdCYlF3QUlIZENJT3lQQWpaRGRZMnRJSUFKMmI3UHR4OXZVWVpj?=
 =?utf-8?B?NEhuVTVLd0E1S3JSeXA1SzNFVUEra2RiQ05uOFhWNXZYVVIvdmVlbndoQXNq?=
 =?utf-8?B?Z2tESFhxbkJtT3NpcjhGa0dsNzlmNjBqczVtekMvWk11Y2NJQVlNNys1RElK?=
 =?utf-8?B?ckNTQnpiNytBOGlUZEVJdG1MdkdwY09ETUhoWXprdG1XSGdaYU9MVlJtSDAz?=
 =?utf-8?B?djM5cVZnQ1ZCZ2NpRCs1dWRnYVBXandScFg2ZWIyS3Zld2JiTjVsYW5qbkRK?=
 =?utf-8?B?SHBVYkVrM1BjVEpwdnczdXBXbi8xVFdNenZtYnBLRnI0SGF3QnRLNFFVWUor?=
 =?utf-8?B?V2VHTVVPQXRGOVdRUjViRXBIbUNRaVEveU80aERNWjNGdkVPcU1PSENXUitD?=
 =?utf-8?B?emlqQTk0K0pJLy8xcVc4YUNtb0daZFlDcmxnM3lHWmF4L0xMQmFGRjJLWWtX?=
 =?utf-8?B?Z3pIUTMvMXVsWkllM1A4THk5VDVQMi91bmpjaVhnUmorV2NrdUNnZnR0cjNF?=
 =?utf-8?B?YVZtNE5SRGtkUlB6ajdPN3JYbmR0RnkwT1J3VTFyNEZzbHFPUWlCUVIxUnYr?=
 =?utf-8?Q?iuH+HzCAcLSaB6+CjRdnS9Ffs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63c23e6-4fe2-4d5d-4237-08dc37ddc215
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:47:56.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raxxcEE1xBBdwBPf/0HjDCRJHeRrm6f9M+hjpL1G0u/EXoidgkRDrzZkU13h5nYP6EdVMnUoRzzW7TM59wnS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx.c | 131 ++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx.c b/drivers/pci/controller/dwc/pci-imx.c
index a63ce171ede8f..460d40115935b 100644
--- a/drivers/pci/controller/dwc/pci-imx.c
+++ b/drivers/pci/controller/dwc/pci-imx.c
@@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -671,35 +672,72 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
+static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   assert ? IMX6SX_GPR12_PCIE_TEST_POWERDOWN : 0);
+	/* Force PCIe PHY reset */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
+			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
+	return 0;
+}
+
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
+	if (!assert)
+		usleep_range(200, 500);
+
+	return 0;
+}
+
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
+			   assert ? IMX6Q_GPR1_PCIE_TEST_PD : 0);
+
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN,
+			   assert ? 0 : IMX6Q_GPR1_PCIE_REF_CLK_EN);
+
+	return 0;
+}
+
+static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (assert)
+		return 0;
+
+	/*
+	 * Workaround for ERR010728, failure of PCI-e PLL VCO to oscillate, especially when cold.
+	 * This turns off "Duty-cycle Corrector" and other mysterious undocumented things.
+	 */
+
+	if (likely(imx_pcie->phy_base)) {
+		/* De-assert DCC_FB_EN */
+		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
+		/* Assert RX_EQS and RX_EQS_SEL */
+		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
+		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
+		/* Assert ATT_MODE */
+		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
+	} else {
+		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
+	}
+	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
 	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx_pcie->reset_gpio))
@@ -709,47 +747,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx_pcie->pci;
-	struct device *dev = pci->dev;
-
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX7D:
-		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
-		 * oscillate, especially when cold.  This turns off "Duty-cycle
-		 * Corrector" and other mysterious undocumented things.
-		 */
-		if (likely(imx_pcie->phy_base)) {
-			/* De-assert DCC_FB_EN */
-			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
-			/* Assert RX_EQS and RX_EQS_SEL */
-			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
-				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
-			/* Assert ATT_MODE */
-			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
-		} else {
-			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
-		}
-
-		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST, 0);
-
-		usleep_range(200, 500);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx_pcie->reset_gpio)) {
@@ -1444,6 +1445,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1459,6 +1461,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1475,6 +1478,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1488,6 +1492,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


