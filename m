Return-Path: <bpf+bounces-34107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D492A802
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3855280DB4
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806D1514CC;
	Mon,  8 Jul 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VUf1FyD1"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350E150990;
	Mon,  8 Jul 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458552; cv=fail; b=M3mahNrGz/b9cv4jqOaoODWOmp2ItngRmGwgbRb6zLrOsx9wpaSwF/Lry8DMZxstBOnjGBsbybmqkBTAvJzq0CpDzi0mCOS5ggW47S7i7BItxyQHZoEDWndmWOQZ9QlkBZxTb8ZE7uI/ZSIeUToRaG6qgOp4ERnxqKtEK0yHFZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458552; c=relaxed/simple;
	bh=rdBX9SAsLGGVokztvn5vz/ebdrIJ20HWryji5UtWJnk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c7zvWU6ir1Dt19gb981PDEmpD6l5puxg9YO2MO8bSDhUzLduZ4HLT0m1rqqbL9kbi5yoVUfUH9qII1NettlYdVr73e/26Xxl2Iwap/KTJqTOiqR9q1DwGni4qaayJb84GQ9KKT5tCgt+fFCHmUFRK2fi94uTbWxCJIn2ZbpMtJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VUf1FyD1; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGUBAV6euKBz1SkAUPyyHme/DPBtbBFb3WriVsr3LNTs93Gn8kB2OP5vZo9cimoWpKvpzp9uzdcFnfSXmwIwLrqXaMfvuKVMGgR8vYXuCm5fASVdIGg+lQDdxg5v6OGdMPNBexsNhIGZD5po22/BGvQh5sFZGdxQI93mTXvvycycThEO9DovCMacl2zh2+wozAn0l/5hDMowkeChKKMB0zH6wJkSue8n7WUPLmvhy+19qMTqDP7DAIGTkPY4MuDVfgsMrhFSi7kMvYJKHdb3pN3J4ar2PJsx23DQ+NCsWlkQ0EMqG7taw2qc0JGJWu8+8lb/blV0Im5/APB6Z79D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=J2GPY3/hVRs3FNUzTlbk4n3wF2UPmMMQLmpyNnkLHWH/YDkdmYPrncMTIzgWNRBT6ud9BIdiSqxnDP1kTJ3Mw+U2Fxwl6Tga+Utpzc20HAo/eRv8dyd4eLDrf4e6deWzQgovfZ/T+PCOTyKio1p291y1oDRDvPSO4jJiFqpdiUQX00A4SpUonix0T+O/Aw3mVamlOGL2V5SyKJ/XzjPIowWsRfiRtnPTYpiylUNpgZXp5C8UTGEysvhinLs+8hHXiYO6ipMI9Cey1uZpIPqWowpJ0lZQmGzppF31+98T33SJo6nZWB6x5DiDKVzv4w0GzICXw0s38Cul1ZOL8ke77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=VUf1FyD10WW5kzgwPe5PJrwQZQDA86fjzQ0CocEfCB7zgcnavj51mO5jPRhXcptPAFIsRYEMGmfs1gBZjzBtIoPlhx8LjfaSlljnEEeu7K1vRnS8afPqyqM4tOlHdtbFaVzQxYSDuY/XT1HqW0GIKKwCGyxSBXkZ2+2/bRIL9DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:09:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:09:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:12 -0400
Subject: [PATCH v7 08/10] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-8-ac00b8174f89@nxp.com>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
In-Reply-To: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=1356;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9ZkdHDkA+jFfsgNpx5r6KX8wuw07nzBbE/IHsRQRYtw=;
 b=brEb+xGq16fx1oBIKv0EjLcVKdfsrQASdfoT2xkDHFBNg57mgA7XKhvE/bHRBNtpyhJwOaCPe
 OGHMRWMrPzdCil3m85ef0qXi3DA6GzLuzm9dmiA6AMAvZBRLJ9QDEQX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: db6c048d-a705-4dc4-845c-08dc9f70adc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFJhR3JmZ3B1ZjlOaXBJd0VzUHdCRkNpelpNd29KS0RpMFJ3QWhEQlg3REhX?=
 =?utf-8?B?VW45UkVKYXdZd0Z4UEZvTUZyVVN6Y1lpNG9HelVDTSs5RFdzLytkQmd2TFVW?=
 =?utf-8?B?SGhYdmpuS0lSZ3FPNzQraUNtZGFiTUMwRm5qVW1xdjNXd2Rwdm1wVFdibWts?=
 =?utf-8?B?Q3hQQ29uTkdKSkJlSFRoL3pwSGU1bXIvbU0yRkcyYTZUSUVQV0hScjVpN3pp?=
 =?utf-8?B?bFlodGJEOHhhWDN4S3N0dE1hcUp5eFFHcHI3RjNVbFphNVFqNnFJUUhsdFlh?=
 =?utf-8?B?MUdUOHQ5YUlRVkFvZHJaN2l6ZzBYWVd1NW8vZzk1MU04NXhPMnpjaEt2aUxE?=
 =?utf-8?B?a2xVK0thbTRnWE1CTGFPQ1Btck0zSzdpR0c3cm1EcXBPSWgrWkhCZ1lVNGNa?=
 =?utf-8?B?c1p2UUpyM2dqbWpMaFN4V05Ba0xkZ0FYeFhQTjFka1IvZFJVRmpaL0k5aTdy?=
 =?utf-8?B?RjNmOHZVekNlb0lVMnVKL2Izd0t6TnFoY0JJZWVMczhORXM4WDJ3OWVUMCtj?=
 =?utf-8?B?TFl1cE4xZXN3bEEvVDh2ZjRWZ2dRTFBDR2d5bnAxb3lMWEkyVW1JQ3FQcnlr?=
 =?utf-8?B?dkZJRWNHSmFlLzNNM3BPMk9lVko0RnRjRGdVdFJlRW1CSWRTRk95ZDhxMmZs?=
 =?utf-8?B?MkNLNzdPMWJKMTRuLzBWdXFnTmUxbllKUkNjN3luS1NtNGlteFRVdHRzUzF2?=
 =?utf-8?B?azFlKy83U2sraHc2a1Vvdis1VVNjd2NUK040MVZYc082ZVhNSUxqL1FidXIw?=
 =?utf-8?B?RjBpT1RSbFBxakhCV2t0d0ViVU5KdVhjMXpTTk81V2c3UExuTHp0NzZQQldJ?=
 =?utf-8?B?LzFVL1c2bDZsMXhSY0h6Rm5qNDRkVzBONllFRzhhdSt6OUtYcFRDVHhNb3Fn?=
 =?utf-8?B?dDlKUWhJWW8veTMzNzZwQm1HNFd2cXJtQlBoN2UzYWU4L3F0OEYweVlOYU5F?=
 =?utf-8?B?Q09uNGJnRDVZZlFnZ3hwb3QzV3NoMWhUNkJTQzlib0lRNXM3VG9QY214SDJJ?=
 =?utf-8?B?bDJ3M1h1eFllaC9ta1RoOHJOWVNvOGtybUhzSGFEa1pzZkFBMmJqeFRUWjBM?=
 =?utf-8?B?VzlwTm1qZWYwQjNnWG5MMDQwUUNPbHgyU1F1aVozdnBob2ZqYnlvQUpzUHVC?=
 =?utf-8?B?WHVhOWk2OWthK2FITEZ0a29kYzNJMk80SFFuSGIrYUl5NWJNOXVOWkMxSlk4?=
 =?utf-8?B?Q2tuNnZJRGVwTmE2Z2RwSUljSW5ITnNCNGVpR0dzZ2tVblcydG9FRlRYQ05s?=
 =?utf-8?B?REcvV0RkRlQ3WGNlWERsUUFxYjJraWxlRnMzTSsyallRNE90YjdYTkhZaCs2?=
 =?utf-8?B?VTVzNUV4Zm9QMWp6NXZzaWJna056dmpUbTNVa1BDUHZpKy9UNUpEMGlwQS9P?=
 =?utf-8?B?WHdBWFYyWmkrUXM3czQvYW45VHpXcW5ac0xCdENUTXVjL0xRUUlVWHY5WU0v?=
 =?utf-8?B?c280MXRQM1hzK1FMWGlBY3o4RVIrbDFtQkdPMEpjUUxPUmh2ZmxFY2MweFQz?=
 =?utf-8?B?YTRXNGNwVkVQZGJ2NXlxTTk5RGNIYlFOakJQL0w5Mm5LUEdCQVNsaXNWd291?=
 =?utf-8?B?TU1xbGFOazZ3MSsvd1hra1dNSHZnSEpNcUdGUG1NQml2MzFUbjl1YVFsamFz?=
 =?utf-8?B?bWtOc0VXQzNxYlkzOXN1eTQ3TWhRV3dUYUtTSmxwTmxzbExUdkxjcEJBQU1n?=
 =?utf-8?B?R2RBeE52eWwvOTlNYy9zRUtiSUIzdmt1VWU5Q09NSnJhVG1RbzJ6VWtjNFJH?=
 =?utf-8?B?MFh0TTRST0xPNGNGdnI0MEJXQldidmtPemxXbjQ0VkJGWDMyRHFPOEN3ckdt?=
 =?utf-8?B?ZnBhZnlNMnlTZU9xL1JvNVA0ald5S1p6UUhFd3ZyOUN6NHV6VExpc0hQTEZa?=
 =?utf-8?B?aUlId1FrS3I2Nnd6Y3VqZExKS0VWS3VDOHVNUXc0eGwzK29uaXhwaCsxYTJ1?=
 =?utf-8?Q?Mcc6I6fx6+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW9nRUQ2RUNSOTNnMFVwVlVYUW84d3dWenNyZmNJbHlqbHRJVFRndmk2T0pk?=
 =?utf-8?B?cXRtRzVPazJnbTJXbEVmUjdaeC90RkdOZ3ZnNlNsZ3BVSlB0ZER6TmlKNmNx?=
 =?utf-8?B?bDZTbWZpWkVpbE0vemp1QVMxKzRrcEMwTkR2UGJRa2lqMmJMSnBpVXlQUjVp?=
 =?utf-8?B?SG9SZDRTYk5Ka1FTYzJhVXBvaE5FTVlBWHhEd2ZteFZjckxxNXdsd3hRL0xC?=
 =?utf-8?B?WVhWa1AwVGcyOHdIUlE5MjJ1elpzMjZLRDE3QS81VCttSmhBNGdHSDdHZ2VO?=
 =?utf-8?B?KzkyMW1wdjhOT2ZGNXFmY2IzTkFDMzBwcVpBcDJnS1dmT2krRVlkYXFPK3Zz?=
 =?utf-8?B?aEZDS0lOcUpOOEFWNElFR0RrNkFRSmluTHZTM1lQWVV3enJLMC83ZFFheFJL?=
 =?utf-8?B?NTgvQk1Jb1R5T2pSejBOekRCU1Q5U0ZJbk92MEhpdEVveCswKzVpemRmRWpT?=
 =?utf-8?B?M1RxbWloS0xYekd5NHhqZzYwN3dzQmt3M0N1VWNFKzZuc0d6MUc0NUFjdllw?=
 =?utf-8?B?QlBEMmVxNkJMdnBOWEk5d2NLUlNOY1FCcnpWVVVHZlNaSzE4S0JzNTBCaHo5?=
 =?utf-8?B?MFlGOHQ0RHpmSHB0OG9XZGVLcDlWRjNEa2hRZnJUeU5RZlBnR2pZSlFsNUp1?=
 =?utf-8?B?WE9BYmlKaTR6ek01WFM5M2FuQkJidDJsNXA2V1d4TWRGbXpYa0hMMmdFdXJj?=
 =?utf-8?B?RG9HSHJoWGdReHpFK09PSjFqZDRrQ0o5ZEVMRHNFZnhpQ2VjRFY1dmloaVpU?=
 =?utf-8?B?bjhiWlRLVzQwcmdTUzZCRWRjRTNVQnc0c1krT3RxVFFQR1dXSXViekswUTVO?=
 =?utf-8?B?RkR3c3RqcFk4b1BqUU1RQThjYUZ1R3FCNjRpSkQ0bHRJWHd0aURwVkNmVEpw?=
 =?utf-8?B?Y2gvNDBaWGRheW5wZEY4akFsSjMvWW9UekVWWWp3cVNKc1JCV0NSMjFvSG1K?=
 =?utf-8?B?T1FvT2JHVWxEeWc5bkZOUmJDaXUwT3JIclNobTFGTmNleVUxN2c0eUV3NDda?=
 =?utf-8?B?bTlSRWFVSXBPd3A4ZzRZTTBrSFp3bHNPREp1c2lIUkp6VWVhb2I1QnVrNmdW?=
 =?utf-8?B?em1hMURKOWNJRStSREJvSmNyMzc5bXRUSmpwUW9mamh3ZUo2K2F5ZXJQMzZm?=
 =?utf-8?B?RzMxcGtmT0EwRWxQamg4c242b3lSN3BYR2NESUxCa3FOc0hZSDV2OGs2ZmR1?=
 =?utf-8?B?N3NXUjBzNVR4V01pcTZqRjRuekxad3FBTGlEZUpMYkpPZjdTSXo5dEVtTVFO?=
 =?utf-8?B?NEdwMk5ITjNOY2hsZVQvR05MbTZlSXJEMnRQc0R4Q2Y2SFJwOStqUm42SVBk?=
 =?utf-8?B?cGE2NlFjVkdBYzl3V0E5c2JNQjNjYy9JUHVmRzNESzVEWXRSTG5NM1BocEFQ?=
 =?utf-8?B?WGVkdUd3SW9kRVlUYVlBQ3FrTER0STIxVVhhOWx0VURmMHg0YTEydlZVdGtr?=
 =?utf-8?B?M01YVkRraGdOcTRpUTZvclorT1Nzc3BGVkRjTi9XdG1ha215ekFyUWw0b3la?=
 =?utf-8?B?clp1cERzbTgrNmJFMmI5Vk9TVmlMUE9oZGZEU2owL2JIR3NRQjNZZktYRWJu?=
 =?utf-8?B?OUxRejNFR3B1NTI5dHpYeEhORFgyTHR3ZlgrMUdIWW5WTjdZbWYzY3lGOHNa?=
 =?utf-8?B?WDJlZCtQeDE1UEpRNEpiL01yeXBxdFlUaUZvbjk0YjN4RzA3YjlHSjZqUHVU?=
 =?utf-8?B?eHlLNWp0djNHbDRWQ1hOVWtaMUlQYTZ2Z3VKeHdrRytpZlNrOHdBTUVXdFRP?=
 =?utf-8?B?T0tQaWRHdUdYcnllK1puZ0dWUlFtOC9ZNUphZFEvc0k4QlFuZEZSZkZFK0xs?=
 =?utf-8?B?c2ljNXlOWnJmUjM4ZlBFRVEyOXJ2UGhKcmJrb2ZDSi9xdTVOWjhmcVhsOVhY?=
 =?utf-8?B?SVJZUnphRW5MMldFTUcwaDVZc0czVm90aVpZeGgrQ3hrRER6RHJRR2pYbXc4?=
 =?utf-8?B?T05oTzVMS3dWQXlrUEt4NEhZWFNnTVd0UER4QXRUTzBCSmpldEdkZ05uYVlu?=
 =?utf-8?B?ZGl0WnpJRVJVL1JHa042S28vWHh2UjVaN3Q3SXpCY01TaXlWOGZWeFc4dzFM?=
 =?utf-8?B?cFUzdklhY2VseWFxdWlXOXFvY2xEQUpZMll5aFhxWXFFTjRJRFZ0T09seHkx?=
 =?utf-8?Q?mnfs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6c048d-a705-4dc4-845c-08dc9f70adc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:09:08.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EW76Zy3PHeTOKR4aij5fBhoitsjXTIbFQPwR8oOnY6mwiMV57bjMymdVJhvMXsVniDZo/r76DmldkLVOMYyQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
common naming convension.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 8b8d77b1154b5..1e05c560d7975 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
       - fsl,imx95-pcie
+      - fsl,imx8q-pcie
 
   clocks:
     minItems: 3
@@ -184,6 +185,21 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


