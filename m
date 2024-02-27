Return-Path: <bpf+bounces-22806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EE86A1E8
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B440FB24BA3
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0C1586E8;
	Tue, 27 Feb 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTSl7SWH"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AA157E98;
	Tue, 27 Feb 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070485; cv=fail; b=pKByE5VDXQyLKt1ypJSMhFDPV/TzCEC33ufIRuXVYTiDpY/sCCs19P+psQTRTpTLhxzpHzC3z95fzsWmI9qOK6X7F49f4IK1iCD071AK7Zp3+IERz0WFh64KAYpzSangFawOKZyycWthJ60HR6KgKHmtr3Vi2G4DvoLQ3MdeuAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070485; c=relaxed/simple;
	bh=j1GdxC5Qcy58j0c4EpqjxH7NIOJFweXArDeCv3j1l98=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=I7yzeJDdPYSAgN+azlzpZeLVfmLAegC1KsZLzWPn+BPDDTGrNjoa5T2c8dlQN+XJoAQhcNViX5RPOJi6Vk7Y0xZyP1Ztn1oRUU8FJ5NiqWKKAmLImnuKis64iuLcbtpm3R99lgfiDD1XLHJJLBz8T1u88bghQV4CpZ1ZZ/A+Xhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTSl7SWH; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJFn6GWcnfhMQioTmuBhYJklNI2GhqAgD8KH8HxVrQx7wYNK7ucmuRtkOKOQwbrf+q3cEB6+g+41G4Gf7cKOqnN7RuzWuduOKcRTJQhXjcem0I7P6bss82+IbvUc/ZEZ3leWq3a2QQjHpJHEbMFhLqGjNN6rv60mV75BC587xWZdmJA60x/vCslfRioipKnSglj0oTaKVsB0tOkmKl/uzfVgpmVIw88G0obWdTyoMsoRGgODXnnSeYjUyf06QL0emcF1oU5684k8PbIjfdCyPjdABsNQl1EQyErLzMlqHpDjyDat35ORDeQMTzeCTFEQrsnV4iHlToI2ZrAjflNV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWeg1pQ1G2vVPLsLAxibEtEDU4i/0SULIxIVfA5qIDg=;
 b=c1S542zcx6O+u/V3LscOsxeXo9TMWQ7TceCvrCzrb2TSd+MoTLhDJRsyucIo57pfkImK2POLbCbWQoh1Y7nStXGYB7kzT7qhyDzMjHUFw2cAs/saJ2LZRpFqm+D476XNvijvTkhifben2fV2W6fccTVqLolWcOiytdVLE70nCpkKS737k+URrZhmZnvaeg5w1pNKsE5luvKv1xbJdJffXbMEmFqL6h3irnezgOB2cfFCb8U2DBcfz2XH+HNLS966G7noN5lDD8iccxus0m5mGbARO9GSXZJ9fi+iNGKdMK2JbLwh7lROZ3O7Ui4+S6VefFjd9IYDYsvBDKos97tZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWeg1pQ1G2vVPLsLAxibEtEDU4i/0SULIxIVfA5qIDg=;
 b=CTSl7SWHVrHYMMoBY9uIN0SvkdBpT3oE5vIFa9f35Dxm6fjtBK5QHRUB9hyE5/Bs5BtAXnXVdR21jaXdEVFMCEbZ1dfJypd0Bfo+nZHeLtYpKYrQE1tUHkKX3o8aZ2pXkYzMQd6ZcUHJlP0zxpdyxaMn+QS5WBhdbuQh2NNjrZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 21:48:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 21:48:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 16:47:13 -0500
Subject: [PATCH 6/6] PCI: imx: Config look up table(LUT) to support MSI ITS
 and IOMMU for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-pci2_upstream-v1-6-b952f8333606@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709070448; l=5955;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j1GdxC5Qcy58j0c4EpqjxH7NIOJFweXArDeCv3j1l98=;
 b=sHLG+MjI1/M5kIP42sIEZSrD+trv43x5+K47RWBnrNp91fOrTJvP3S9ztBit9i7BvDPkvYi1Y
 DUI5wS7esjHDGC5VdD7QjbLeJj67kIYtry3dLfFkt+ZSS2ar4NwwfKO
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
X-MS-Office365-Filtering-Correlation-Id: e6fee768-fae2-4f58-8f2c-08dc37ddc4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	31n3bae9EW3Ni+cp3+O5te+D1u0wxMJb7qjXKVhH35XHmNZe4vIehIasr2SnGxRsevDmZFJ4BzIuuzVfLNLg4hQt2EzKWjl0OujgNh+FjdmnPckTlfeI1cHi0uxxqkymUEHFfq9uM2fNVDPCPKN0WN0ps/TTkoOh+gaQr3a9RLSrQOwv+nAUzhwSNEHgiZAo/cDmMzR2y9plmJJkBrnAb9NYlnOzPFuxOrZKMrMWEY3NcZz5OihQve4OmjXZpS1sah2hceaHxkxKP+oqGIMnkwxdO/pSY2ejnOZn77fpQfvw4HX0DO9z9YMMuDd1fbHNuIHXTS/p+q5RQF34as1Hy9HqGiqRea7fdt6LwWH+2Ma2eT0ejjFaJqy2cn9WV/dnBNZHWLx6Y8cuHDuvslgDsQWVWH+IrHqXaLngGzVcRAo+p5Q8b5FDWiKJAf3izPfPfLBVQIZ/aGUeZFN5ye3WkzO6PxU05q1JTSqKC1NYk4kCT6P1sLBEJ35oN2gpi5tipUT8m9jPVOZcwG1wufptsCznR3m2p4NAIXscrQFAlM2Wfm8Pg7G0MXGhsse6v9C1+bpAAnx6MPucaV16LOMccbUxMZ5Zc+1gsi3AcZI/4EjD2E02Taqv+oYlZm0ryLLp5EWu1Z1RifUDT27aWcOJpt08mMoYDVzZi4TkNOJAgxCeyk48XXcV5BixN0QGm8mHkbXC0sGxVfxq+krdBWjAGqaLZhay7ZRfMprmwXxkQfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxZV0dIZ1drOUViMU8vVGtlRXowYUFFb3ZQYVNDOGVKblc1UEdCRjVTWW9y?=
 =?utf-8?B?NS91eGtodWowTjRTZlBjU21lcWlwVUdNU2RwUzFsQUFtM1hlOHVZV1p4eWEv?=
 =?utf-8?B?YTZaam1BQStHV1p6djhaOG1XVHJ4ejVxWklHT25mK0dUZGhzU3QwSDk1TTIv?=
 =?utf-8?B?bFU0UjJwRUc4N203SnNjQk10MW5McHRraStldmtnMXQwRWlYZVVFSmZtcGVO?=
 =?utf-8?B?dWFFaUF6RnJUWTRZaUNhNjhCMFBRRGFvUytWRmMyY0g5UFdwaWxyMXN3UHBX?=
 =?utf-8?B?bW1IYXZxUGhoekpLM1NZQWVvcm5NbDV2cmhYVGR6Zjk3NjF2eHhwYXZjNmxt?=
 =?utf-8?B?emVDRGtvelhZUkIxSzl4blhqNWxUOXpVMzJua2NXWllpM3MrNEdGTVg1VUsx?=
 =?utf-8?B?Q2pCcFJLWVlDdUd3Q0ozc1NuZDdYdmlCQjZnK2sxRGNMb25LYVNOWXh2bGpG?=
 =?utf-8?B?cUgrbEhJZ1J1V09iVUpSM2dPUHFPVVVXL2VEckt6UGkxNU51Q1RtVEZZNUs3?=
 =?utf-8?B?N3lwVEF0NVZCRHBqSzZhT0Y5a3dGbmlaZ2l0SHFZb0RNOHZMcU1UTDQ5eWtu?=
 =?utf-8?B?SEZld1dwWllpK3hIL0pIMDNCMEZiUmUrUWcxcDNlcHlxQkFUUjZ5S3BKWERm?=
 =?utf-8?B?SExJbzR1NWJIZVA5OWhoM1NSbU1ITHVBOXFQSCtVZWJhY2NXL2lHUHlKelhv?=
 =?utf-8?B?ZjZDZ2pMSDdOYjFOQ3RrQUxmVERHN3JjOW5Lb2tsWnpKTkZyZHozeEt0cjFD?=
 =?utf-8?B?Z1hpTXpJK24zbVJxQm1tVzNDTTNZQ01POFB4WVA5WStHTzlqQWkrS3I4SlZN?=
 =?utf-8?B?bmxCTVUyTzFabFRwekxnRWVBOU1YSGZXSk90VjFZRFB6c0VFUThlWndBc2pQ?=
 =?utf-8?B?ejhEb3J2NzVXa1gxMzBobXZpL3pFRGZwWHBvTHdCckNhSkRpR0dLYmRNU0x0?=
 =?utf-8?B?b1VjSUROaTJpdnRNVi83S0VUdk9rWVFDYUJaVUpVb0xTNExZNnM3YU1wb3Ar?=
 =?utf-8?B?WWhjYmpsVFpJd3ZFSE5UNitVVDZzQnpVOWI4RFF0KzJvbGF0bGtaOS8zWUtu?=
 =?utf-8?B?VXNyMzFycFFwZzRkdE5jR0x2MXQzdEVYdEFMNXUxeWNuZWdFMTQ4ZmlUNW9i?=
 =?utf-8?B?MjVGVThIYndNZ1JPd1ZGUFpkT0ZHakVjVXNaMitHQU5ia3VrS0ZIc3JlUHZN?=
 =?utf-8?B?cWlDOVRVYm1Ec3U4eTRHaGRLbjREa2svejBCN1V3MThJRThhcEg1TmFyMUx6?=
 =?utf-8?B?YnVQSTVHOUFGUThqelVqRzEzV3NrbmtoL0F6Tkl5MnNocFFqWjB6SlVtUU5o?=
 =?utf-8?B?TWpvRUNIbmNjWVVmU1VOUm8vMlBsVCtZeFVoS055R2lYL2ZGR0cxbTZuSXBh?=
 =?utf-8?B?TFMzaFpBYXV0WU5BNjU2Sk94QUVkYUJHckdmWThnTmw0dXBpQmQwYVVNOGFj?=
 =?utf-8?B?cVJhaTFFNnB0TmtXamprQysrQ0hJaElxOWdRdk9YMTVsOHRqUEIyTHJWRjhW?=
 =?utf-8?B?dVJLSy81UGsxVktaOVRsYTl6NVdhUWxYOFVia1pNSDh6eFdpVVVsRTdFVG5z?=
 =?utf-8?B?VzFkZHdwV2JlLytEL0tWeG1DSVBKNTA2Y0pCWndDcHMyK2FLK2tZR1JjMlZ2?=
 =?utf-8?B?Y3ZPSGpwbFVZem5ydi80V1RGTzdkVCtGUFBmWXlZNzFIZVlkUHJoVTZzaGFl?=
 =?utf-8?B?bStQaktGWUN4MERwVk5uRE1YSlVFYVh5aVhGQTdHb1ZobVAvZGt5b2dCY1VY?=
 =?utf-8?B?SnJFRUFqTVloWjJROEFNWGpIWG4zWnhOZVFqSHkxYnVRdXFESWNjenpjcm9N?=
 =?utf-8?B?QXVvenJjeHJXQ2JXU2FLV2hXS1JzMXFtMGxRck0rNEpCQ3JZN0ZMaEZ5bG5D?=
 =?utf-8?B?Ykp6RzZtbDdETmIrNjN5Z05jQi9TLzVvYzlKSHdGR0hiMnl6cFU1L0tkSTN0?=
 =?utf-8?B?YnNGNW12WnJHeXJMUXFLcGVVTTByTEs4VVdvTlFhb2I5ZUtkY1kwS2tPTVNK?=
 =?utf-8?B?eE9pWW5NVHJueUlTdzBqYzdpV2hVMlFnVVJKd2J5cE12bHprZXZTSTVnVFFE?=
 =?utf-8?B?cjRxMTQ4Skg1eWd4RG82dGsxVDdqWE95VVBEbWhHM09jQWZWcVMyc0U0NTRP?=
 =?utf-8?Q?IKswjuFQmknjLqy91fFf5/QSa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fee768-fae2-4f58-8f2c-08dc37ddc4da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:48:01.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVCbQr400E1eI/KSwSDLjR5bmR76lcibAlM6MquHH0nxk+rFK31KhhZK/GBpKQhCL2UacY3gMi5oKuNks7Rr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056

i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
map to the same stream id. Then config LUT related registers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx.c | 175 +++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx.c b/drivers/pci/controller/dwc/pci-imx.c
index 460d40115935b..782555beb6e9d 100644
--- a/drivers/pci/controller/dwc/pci-imx.c
+++ b/drivers/pci/controller/dwc/pci-imx.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+
+	if (sid >= 64) {
+		dev_err(dev, "Too big stream id: %d\n", sid);
+		return -EINVAL;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = mask;
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
+
+	return 0;
+}
+
+struct imx_of_map {
+	u32 bdf;
+	u32 phandle;
+	u32 sid;
+	u32 sid_len;
+};
+
+static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
+				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
+				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+
+	if (msi_map && smmu_map) {
+		if (msi_size != smmu_size)
+			return -EINVAL;
+		if (msi_map_mask != smmu_map_mask)
+			return -EINVAL;
+
+		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
+			if (msi_map->bdf != smmu_map->bdf) {
+				dev_err(dev, "bdf setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
+				dev_err(dev, "sid setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
+				dev_err(dev, "sid_len setting is not match\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Simple static config lut according to dts settings DAC index and stream ID used as a match result
+ * of LUT pre-allocated and used by PCIes.
+ *
+ * Currently stream ID from 32-64 for PCIe.
+ * 32-40: first PCI bus.
+ * 40-48: second PCI bus.
+ *
+ * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
+ * ITS [pci(2bit): streamid(6bits)]
+ *	pci 0 is 0
+ *	pci 1 is 3
+ */
+static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
+{
+	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
+	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
+	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 mask;
+	int size;
+
+	of_get_property(dev->of_node, "msi-map", &msi_size);
+	if (msi_size) {
+		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
+		if (!msi_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
+					       msi_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
+	}
+
+	cur = msi_map;
+	size = msi_size;
+	mask = msi_map_mask;
+
+	of_get_property(dev->of_node, "iommu-map", &smmu_size);
+	if (smmu_size) {
+		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
+		if (!smmu_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
+					       smmu_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "smmu_map_mask", &smmu_map_mask);
+	}
+
+	if (imx_check_msi_and_smmmu(imx_pcie, msi_map, msi_size, msi_map_mask,
+				     smmu_map, smmu_size, smmu_map_mask))
+		return -EINVAL;
+
+	if (!cur) {
+		cur = smmu_map;
+		size = smmu_size;
+		mask = smmu_map_mask;
+	}
+
+	nr_map = size / (sizeof(*cur));
+
+	lut_index = 0;
+	for (i = 0; i < nr_map; i++) {
+		for (j = 0; j < cur->sid_len; j++) {
+			imx_pcie_update_lut(imx_pcie, lut_index, cur->bdf + j, mask,
+					    (cur->sid + j) & IMX95_SID_MASK);
+			lut_index++;
+		}
+		cur++;
+
+		if (lut_index >= IMX95_MAX_LUT) {
+			dev_err(dev, "its-map/iommu-map exceed HW limiation\n");
+			return -EINVAL;
+		}
+	}
+
+	devm_kfree(dev, smmu_map);
+	devm_kfree(dev, msi_map);
+
+	return 0;
+}
+
 static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
@@ -950,6 +1119,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		goto err_phy_off;
 	}
 
+	ret = imx_pcie_config_sid(imx_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to config sid:%d\n", ret);
+		goto err_phy_off;
+	}
+
 	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;

-- 
2.34.1


