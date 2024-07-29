Return-Path: <bpf+bounces-35928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708993FF01
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8E1C22512
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DEE18A933;
	Mon, 29 Jul 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRSoHEst"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE5189F32;
	Mon, 29 Jul 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284335; cv=fail; b=VJ+58BeRcRl6KmEN4YhYoYEMRKHrFUmF8JwUvbHRese2hQDVW9WINNRQvvnBBujOD2EakXQ4Mg36H4MiLmRUrEHY02QkvamBZenoI3njkaeu/8AhBNhkv2ls1di3WNXKoowEqUwuxXdg1gZkUNayeLTW/DgNF0UO+e2lx2VaP28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284335; c=relaxed/simple;
	bh=8GmiRwyjVCKueLmdifQiyf0cCBkDTU3PrvdlV3diL4g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T7ij5M1vkYQChLBDi4vINK8b7GpgjEkZwbtmEeK40JT9PuCA8ayKEpQZL6LvJp/8CY/YtBowwuSv0XEwEb6qToSLA3bxHhTOi9rzHVn8Df4V3yFqlxsZWZF+pglIBjIJpmQC/UBP8mEKG/+jQ4bOFJHnZZsVxUmeSiSWofAeSgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRSoHEst; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYNVVdVt52R4fLOL422Qei3Ep4ENW5xGR7nuIrHgPNvUJntoOWryLeGvh5cGRT1mJReN1FmtIlbETt4adI8F9UK/fI0BCSYQpAL8EkfylpCx3vD4oZnwCFXuq2MY0fKbT+UEvx7yF6xiVUWUtBva5XMZs2p+h6KmSPPnBO4/+V6U7vOCYxTwbJYlMbyqA2Vdkqgy/Q0VUk+7Mv51dCmlrIXrKU2+zxv9VkGVlIq+3IctdFuMF2JFXHIIYzu7igeJugFtGvHaaV5xB1jA711pwSoMJbAdg26EFwgqzCK5SGgFDe+ds8rRqNkCO5dztQ3hSC5QeXlXRJGUg0/Jt88zBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjsqd2/1ET0LWcoUSUdzjlUigoVzTd54MwQNnEHQLvs=;
 b=YZ8LZW40IeLmgHlNrZ0nkuD0xQavwQ18LpUaQRaa78EORdiWsXiU4FEn4UpF3JyjS9POBvk+jMPIlpW2dk2kTeXTbqOn3pesgm1KUQ5xPFcGOEdI4cknTV54f95VoXR4LOotmsW4B+5wT7gMUqGIpgbsN5wvMennxBH0oVxnidxxlsB1SegFe8E5b3eGz1LxSOOiHJVu5R+Vnr9VzbNzHzL9D7Bt6+7wdXGmYNi0KQHp4sYBp5Jzl6otiMtiYZJXUux5X4oJWvZ4oWcnE1uselR2euZ3bVSZKcrv1oW10LG+OTX0F+SU53LYzr8NA+8TDoubuh04zdhpzWY60FS2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjsqd2/1ET0LWcoUSUdzjlUigoVzTd54MwQNnEHQLvs=;
 b=jRSoHEsttZ/9z30jf9MCcKAs8D7glUd6SlPupxfhdwz2Q9OCc3YUkrHWlcozBDTuIb6Nz304u6glNrKbrskwrll9WspWD0nl0mxn2JTPR7lM0ojmZfshbRTwpdoVKymjNbaXEVSQm7gNGIMnsaRgiFBDEEpGRCT3p82IKKMCWAfyvKSbD8gwfj5ZgwrHAPKv+XQA0tn2GR84EHYoHhFGW6hSbsVs0mfdL6K84dTi3snTRf4p+1wsoob30fQOgbJC0xeGCjr3Qso96tWkVEizM4ByJibwsB6zWtJwmJpWbFsxAPmy/3QFNL61Nmh82c8oH1woXXoA1oCkoqDAxg2yUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10240.eurprd04.prod.outlook.com (2603:10a6:102:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 20:18:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:18:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:08 -0400
Subject: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP mode
 for iMX8MM and iMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-1-b68ee5ef2b4d@nxp.com>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4IHOi9CJvMn1ca5R2jW29usLRGHmger6EqZbIy6/Dbk=;
 b=KpWFGa26Bm1FnWL63CkuSxfnwAGRolWwm1eFMwWb0J0UAW1ZfWdWQKW1iszBgmvMiX7fKYxPz
 1Hk50qhYXLdDIs7zbIpnnuweXVQwSa1x0Or+dslcT677FDmVOh6h4Tc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdf62e6-5fbf-4bba-1cab-08dcb00ba832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVlpd1JMczFGYzJRbVIwcVl2c1o4a1IrSkJWb2hzTlpNWllDU0pDOGxnWkpV?=
 =?utf-8?B?S0I1cE54cXM2VGlNQzlHN1RBM01vMGRQb25CY0l4enJNRlJJRS9KUnlEV0VK?=
 =?utf-8?B?cGE4OFh3WXozc09QdGQzT0xBQkxsaDZjcEpRNDVvQ1dRcHY0bVpJZTh4MzA5?=
 =?utf-8?B?NVFhdTNyQXd1Z0dEUGFSVzB2TjJQOURmVFREa1Z4cWhmdTFOODdIVHNSZVUx?=
 =?utf-8?B?V2ZLYUpDVSs3d0RXazBLOVhTdDMwQlhZZlY0RFFCbUVHb1hTMVJCUmRSRVM1?=
 =?utf-8?B?RkNQa2x1Mk12SHVRTlZFZHRqZ3IxcXFkY1RPeUtSS20zWnRsTVY5b3JBcWw2?=
 =?utf-8?B?SjBjcXN4M3hQbER3ekhWUW0vT3B3bDlTREZmK1dkMlJXdWJNbnhGYTBwdTlZ?=
 =?utf-8?B?YWEwZkg3di82VzlHN1BNUnZ0aTNzOEdIc3ZZTzVSbkRta2J4SW9WY29qYnNY?=
 =?utf-8?B?V0kzdllObC9sWk9iS3FHUWdYYWNpSGZGWXdvZDZ5M2psWHNQbklZcUlsbU5S?=
 =?utf-8?B?NFMzWEN0UytJTVF0b29FWkN3d1czMjJra0RkSXk2Snp6ZUpaeDBoWXFrU05I?=
 =?utf-8?B?UDBIREF0R3NzUmhibzVueWxvNlBpdlhSOGFpZFBoY3RnOXBmQTFqaGsxdjNn?=
 =?utf-8?B?T2hMMHBwdFY3bXEzWFZIaXVDWXNVRklRYU5TdUhiSkpqS2xVQm90aW9JMHky?=
 =?utf-8?B?QVNzaEFZUzJ2cEQ5a1hjYzk3Z0NyZjFtYVMxTk1vaEFsUzRMa0k5MHkwTHFh?=
 =?utf-8?B?MVlndGxZSEtTa3lZeVJPMGltekV0TVZNa0dMSmJ0eUxTbm9TS0FiR25oOE02?=
 =?utf-8?B?MDRCYVVpdTNuY1FwdlAvNzZIdEhzMnFjKy9RWHZiZmI4a3lUZmFoeGdjYm5K?=
 =?utf-8?B?K0ZOdWgzZk9pNjNIMytUaW5LQXIvc3h1TXBFMTROL25MWDdGMXVWNHYvRXFs?=
 =?utf-8?B?WU1NZEIydEFMMHdqc3dZdUk0enBYZzdUUVd3UFNwVnhYZmlUZTd0ZTBCSnB2?=
 =?utf-8?B?RTdPSHhRSWViVkNrcmJSbENyMVpXaE5DdzNNODVXRGpjNXlMOThKa3p3Tyt3?=
 =?utf-8?B?V0IxVmpaYW9oTlZuZWhXZmlrNWhjNFJCQjdSVWVJd0F5ZjcyZjBUUjhhSWNs?=
 =?utf-8?B?MlN3c210dEVTVzZ4MDJXVDlVSDNpRWREU1RaNGlWZmZqUFZ3Zkw1N29XejBQ?=
 =?utf-8?B?V29NVlFzWU9ES3lBS0FlSkJjTFRVL0VoNjFUNjFYNU80MFBQZEZ1V242MzIw?=
 =?utf-8?B?UFZzQ2pQaG1lUUFwc0xBcVpJWjFEL0ljNmFoY0hSMUIwcHpxNDAxMUxqVWdq?=
 =?utf-8?B?TVFYdnMrWTZpMTRrckg5Vy9VK2pGcVBVL3A0My9LblUvbUNLUTZDY1RaeGxD?=
 =?utf-8?B?aWt5QXltYnZkdEEvd09zS1Rid2M5TGU4QkVjNlhweWV6bE5ZUEZvdUtyZFNO?=
 =?utf-8?B?VW5jc2lVWlIraGlvRE4vRFNBc1BMR0g5Z2h5cVF0NkIySlJTVzNiUmZnWEhv?=
 =?utf-8?B?Vkc2dHcrMVZORG1aU0NscGt2d3NLVkxLbHdMVTRpQ09HZ3ZPSjB0T2h3MTlT?=
 =?utf-8?B?aWFrL3NONlExNXdCcXoyZWYrY2s4S2c0b3BVUDhUdmRaUHVPNXhIQXhyNEQ2?=
 =?utf-8?B?UWx5bEpOZ2l1MmFxYVlFTUJETFVJbmJXQTVxUGJ4OHpnRG5pUC9JZjEwYVdk?=
 =?utf-8?B?U0tFeVhSSVU4YWxuWTdiRGNjRFVtRnVteXlZbzhVS1o0UmNsK1d6VUd0OHZU?=
 =?utf-8?B?bktPMU1Dd3QrK2FxTFZSK2IzbHZQeWZscXc2RnY3V2JLK1RCTzFxU2J2WkR1?=
 =?utf-8?B?MkhFWVJDYTdlbmdGUmtrS2pBRGRsd1dVQ2VNWGZRQ011a0pnUEZtT1Vma3pk?=
 =?utf-8?B?YXhrdUMrbEtxYTd4WHpyRUJXMkJUTXRYNVdkRlJnL3IxaStvdGFOc2VLTVQ2?=
 =?utf-8?Q?Uz5I4f3U+M8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk82MUN4WitLUTVDdmlJR0pBRDdzK1UxK1dTQkhsSS9RRCtqajNXMTFjQ1hz?=
 =?utf-8?B?ZXNiUVBQNTJVeWJ3UkVCY3VDcTQ2UzJXb3I0ZjZia2hnZzI3enIraVczQkdj?=
 =?utf-8?B?YzRXZk56UDUwV2JRRkhlbmdxQjBnVWpzMFlPWmNpYys4b3BFY3lSYW8rQjlJ?=
 =?utf-8?B?NkZPQkZmK0xlSlBCMmN4TUhQdFIxdkZnTmdPeE5sY2pWc1FrVnJDbFZKazZ2?=
 =?utf-8?B?S3l2UlMzdDFBZE01SE9XNmkxQzBWR1RadE9ycUR6ZUdFb0tabkF1Uy9IS1Ix?=
 =?utf-8?B?SjBKWlJBR2pPK2JVbjNSKzFBQ0VBaXJBMmNvTnE1cGRKTVBDMDN2ekMwVGlV?=
 =?utf-8?B?bzBRd1BKeXJiSHVkVTRCb21MOGNpOVNiRXhLdzBheFJyTDVick1hd3o0VXJM?=
 =?utf-8?B?VlhVb2ZpK2JFTndoc2taMWlBS0FINUVWZ3cxV3FGbk4xMXUyQ1BSY1pJdHpS?=
 =?utf-8?B?WmhQMFIzVXhKZy9lU1doV3drWTJLRUpTUk9VdW5GYWJmTGJmTnJ6UkJ1NXFV?=
 =?utf-8?B?My9GTC9BSTA4MlYvNXlId0FFdE12SmhRNEp6V2tjc1dYTVNUaHN1alNuQ01T?=
 =?utf-8?B?dkYvRDF6ZGl0ZUhpVUk1dUhpSTQ4eEVsc2hQSm9hbG1BZ25CMDNsRXNsdlZ2?=
 =?utf-8?B?cDFiaTIvWnlTTGM4K2wxaWlCVWJobkhiVlk1b1RIWFcvUHdhL29VbDdVdmNL?=
 =?utf-8?B?U1c5UVNFVGFvQW04d3lRUTh2ZHNJdjJMOXJnQ1ZPR05kOFBibGtydURQdVEy?=
 =?utf-8?B?d1pOZkp6Ykg0TFc1SDRHZ2xzMWcvWmlqSVZQMmorMnVKZ3hEcVkydzRSOFFz?=
 =?utf-8?B?bHdWM00wdlRVU2ZzVVU4RHc2YjFucm1qTGc4eEFlWm5iSm9jSWtUVWRJU1Za?=
 =?utf-8?B?ajRnb25QWTJhZ3VnWnJMdjhkTDRxclhVU2F0Yml5R1pSNEY5ZDlOQ1FJeDBE?=
 =?utf-8?B?MHBGOTQyd0dDdlZpemNlUkZWMG1VK25KVFIzNThrVTBRY2NiNWcxdDU2Zy9t?=
 =?utf-8?B?NE9yeU9iZFlJZGUrTFhXWU1yVTcrK1gwNFdVWnZZYWJ0eWZmdUVpbURINmJn?=
 =?utf-8?B?bktCelowdkRzQzNQQjdPUkZrWUJYUlhHcEF0NXcvVjMxOG9nK0d3WTAzQ3ky?=
 =?utf-8?B?VllZRkZaL2h4K2o2aWhOTUhFL1l5M0tyRHNvWGRkbEhoMlEwbkhNUVRNZWdH?=
 =?utf-8?B?MGdzcDgzelZwRml5R2s5RG5zTnRXL3MxQk0relVCREVRZktoc0psK0QyTTZU?=
 =?utf-8?B?WjlSVTdaVkNSek54ZDJIbVpzQmZhaGw3UzcxS3lBdFJCdWMweVFmNkxFcDhD?=
 =?utf-8?B?VDk2UGhjVzhMNWx3ZFRSaEFwM3dlb2svWFVLNDhwT1pXeUx2MTdrOGlrcVR2?=
 =?utf-8?B?YWV1TE9Zd1JQZkk5aWVYYTZqaHF4bjZLaTQwcEJ0QWlRb1M0L3FoSmxuSG1n?=
 =?utf-8?B?dXBGRGVHOTVJYXJKU0NJeGZuem5leC9qRU0xR1daRGM5Q3J3ZmRWU3JHcC9p?=
 =?utf-8?B?M3luUEpKSjNRa2hNcnoxelRsR3FjSTBTQzl6NW5xbi9jU2dyempaRjdrVFVG?=
 =?utf-8?B?eFYwbkNSUTBOU1ZaN3Y4N3JTMUFRWjdnRVFkOU1mbU1sdEFrNUQ1UWFJVldY?=
 =?utf-8?B?UWpMZ0pRQXRqQ2pMZTlPUlprOUdKUmZSRHdhT1IwUXM5UkFFRWdHUmprKzEy?=
 =?utf-8?B?eG8ybVBVamlNYzk0RTQ0YVczTm8xUG51ckgzcWkwWnBUZzFINnZmYnBZdFpE?=
 =?utf-8?B?U0ZBRVlVRzZJLzArSXg0UktEdmE1dG1IVXRzYmYremhXUnEvbWd6Uy9JdCti?=
 =?utf-8?B?Vk9xbVZyY240QkNtNURuSmM5VG4rdXpveUR1cEtwOTkyWHU2WjE3QVIwbUhC?=
 =?utf-8?B?Z2VZZVdGUFhaVE0rNThOMDRUMjd0dk5uZzNVSVpoY1c0V3IzLytkNmxVNFkw?=
 =?utf-8?B?dVExU0pCUmVBR3BFWURMS3AwR1VZek5XcFdVUitCM2sxOWpnamdyOC9Rcm1j?=
 =?utf-8?B?TXY1YkNsWjhhUkY4TmE0M2NvN1JheVYvTVVEdTRBN29aQWw5YlpzZVhPc1d1?=
 =?utf-8?B?bUM4Q0hhU3ZHcTFQdk9FeWw2U2pCNlYzTDNFZ2gwa29uVFhFVGY3dEpOaVFN?=
 =?utf-8?Q?3UkeAMb43GaYaOLy979FA5tSY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdf62e6-5fbf-4bba-1cab-08dcb00ba832
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:18:49.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQ1hedcu9iJEB2yvToVH47p8jEcHCu7nIyVKlGuOgTFBe16vZVMAf0svY5jbQ+2QmNp2KKreB2QQhbe/OUTj0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10240

From: Richard Zhu <hongxing.zhu@nxp.com>

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This flag was overlooked during code restructuring. It is crucial to
release the app-reset from the System Reset Controller before initiating
LTSSM to rectify the issue

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 964d67756eb2b..42fd17fbadfa5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1562,7 +1562,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1573,7 +1574,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,

-- 
2.34.1


