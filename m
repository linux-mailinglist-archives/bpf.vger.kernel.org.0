Return-Path: <bpf+bounces-32332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A790BBD3
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EE41F2348D
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C761991AD;
	Mon, 17 Jun 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BESINQtM"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAB18F2FF;
	Mon, 17 Jun 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655439; cv=fail; b=rsZGeE/Q7wEutyjxyHi0DMlalHZ9HQq/Hb21kU9qUSqmx6aN9knpa3Zd2oEHiHcAf2Mcjqvvr3/q/MMZv2A1EFdXpNtJAn6lS1Tprl1KowMD+I8NsdwuJPtdAzwObVpG77a1c7XVDZTLHC3FxGpW41NJh30NcNzP5QN7IqRP3S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655439; c=relaxed/simple;
	bh=SUt3J5gt+FStBRradlOC9M9pl8+/c5eR3Jyk/HNThrc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UxE24ttpGL8+QJnmCdsFzkbQi6YlphK/4+z6vybeWl0Z/iWP8kx6abzQ7dDzgHfzqWmALAmsQnkYl81Aq1A4+6OwkuJTvfQM7NuTFHHY3LBk3Yg+Tn5x7C82Ljr2lgcIzBwlUg86By6TgGg39jqkmzn8EIAurVzRlUpA8b1LLnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BESINQtM; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWwOxMrceclQv4t2BprHm7naOG92V+vtHCG+m/cLAciSEg7Pn4w8ZmK/j2ES4D7yEFVyLHlG9d1aca/dVFtySxYSr0U1cmqGkFVzRTcntXSvyjbCTx8AjQJXjcI8b5Sz6qukBDnL1m+C4JJqcLgOfVUdLWyl/uUDIyQ4DkAIHzcHCRSD1ol0eJTf+Q06lvidTs3bzgaJzPLjr2nCGeK3eB1YLH9srLhxnkzIHWF/n36wqdUNY3OK9N2nGELwegru1OAEUjwrNy7BlOooVke8sr551updVPx7jgOFmnmajh1sOMthNyU6k8AnIm735Ah7puVtDTn/K9bSKqvs4KgHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE6kgztqhJj6jfZWBLDwCQLkW3Ia1Fl4sVOINitJccY=;
 b=Gx8IlH6OPE6B/FrzAsTERnyyIFQeTkl5bY/DH1xe3NL9pZ30BYG8UAEvP1pq970/X8CZt81TFwOfAJX+4+hFuqpGAC62yJCmt5ZZ/ezO/BtjczWdxiJGtzKqIlYVbKEfiGOe3PlfpafgLKkZ9iEobDQKjAaZKU0z2gJiGryjYQUUHmwKAUNOqFVYDFhvnBclUYK/1R1ddyHKT7decqw+kp1tp3rZcCQf64pLc4Ss7UQmR0Y6PRgLCbaRDoorx50NqiMxG2I+ObLT5675RSPLbFoeFdAoohxv2VvBWXKoKl1dpn/r6tV03D20P3LGZnQdnzA/muE8Ug8KqS+a6XmeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE6kgztqhJj6jfZWBLDwCQLkW3Ia1Fl4sVOINitJccY=;
 b=BESINQtMfKzoB6RIUMf//tNn27Z5D0rNgRoDcx3FI2V9od3cb5NgKcZSscvMIhQooo3s+wz5DNDBtdbOvmHNFihsN4ZbwkMu30gQjEPv4SG3pxjJ1a3TNUbSgvB06Tt5iC9tfViYvho+7fttS/NLB5/uCQRnM6NHL7g/HwsV2tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 00/10] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Mon, 17 Jun 2024 16:16:36 -0400
Message-Id: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKWZcGYC/3XOy04DMQwF0F+psibIcZ5lxX8ghPJwaRadGSVlV
 FTNv+N2M3QQy2v5XPsqOrVKXbzsrqLRXHsdBw7uaSfyMQ6fJGvhLBDQAKKXU6748TX1c6N4kpB
 LUfuorHJasJkaHerl3vf2zvlY+3ls3/f6Wd2m/zXNSoJMe4uHoLV24F6Hy/Scx5O49cy4Wg1ma
 5FtLOCzpeSK849Wr5Yvb61mG0AbZVJJRsOjNau18Odnw5ZCDlCC54XNXfvLYthay9ZbiNFTSYF
 wtcuy/ACVApypmAEAAA==
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=5089;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SUt3J5gt+FStBRradlOC9M9pl8+/c5eR3Jyk/HNThrc=;
 b=0n1vVy3unM3bp73zATiHMbYkuDtuTSxCK7KIlywS+t2PhUzozLKXgzwz21YEgrRwu6JfMTi8d
 3Madwku5MshAM6T1jw/X549fsJFUw/uvKBA75I+B5pmbzZemRqFdLyA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b51bd6-1576-4814-fa9d-08dc8f0a783f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHhCT0k4UHR1Vzd6QWNFRHNidkxXamt6NzlrVDRxRHJMYTFTcjN3Rk9NQkdJ?=
 =?utf-8?B?T0NGNURha1Z5ejB4OTFvVERaQUxXNGpKN3dJL2h6SFUvenUyUEZmdjJJWnY4?=
 =?utf-8?B?dGlwQkduREswMkN4cDdHeEJiUkVJNzVqeUZCZisyaDNHeWNxVEF1YWtpb3NX?=
 =?utf-8?B?MFB2ekxRRjV1NnpIbWZRYWM3RWMwSFZyTHBScWF5cVFzSms0OFl0ZHFRejE0?=
 =?utf-8?B?ZkdicWpPWlkxZ2I5SWdXUDRtRGhOeGZTUnZlMExCZ2U5V3lOK3pQQmlnQkNT?=
 =?utf-8?B?UHQ0WXhNUjF1SFFNdzJpbzBoTFhIZ3k0cDRWc1BUV25WYzExdjVrVCttOCt0?=
 =?utf-8?B?MHVQNnRZQ2hIRGtXZXdKM0VhVzBpdytvM0Q5OFU4SGJ3YXREaC9zZ3NMTGhm?=
 =?utf-8?B?V2doL2MrUzN4RkZWaHhtT2xQY0pwUytRanJJc3BOTHRGZ0tESXNPRHpGWW1P?=
 =?utf-8?B?SXdWNCtMZmR1b3BBUExHQkhRTjloTWx3dFFCUTNxOFFobzdDSk9hK2FpQytw?=
 =?utf-8?B?ZmFSbGE3SWwzc0NScTVrNHdDeUp2VEpXR2JGd0FaZWY4Q0dZZHFWWkpRVm9H?=
 =?utf-8?B?djZySnhKWUhkeGY3MDB4VURNUTJoRmF2ZDUrRVk1cklYaE5PcnNGaFBJbmVB?=
 =?utf-8?B?WlI2T0dhdGdEcG5QeFY2c0ZpTEQvV2x5K1RKWWRKakN5MVd0aUo2cWE3V2RH?=
 =?utf-8?B?b0hNaXd1TVFoSlpFWDAxaEo5S1hGVnBJM1orRW5ReUQvVG5NbENOTXoxYkxZ?=
 =?utf-8?B?dm5PWXBjNCswQ2ZLYzZUQlY2M083WWoyUTVvZ24rQzJsb0ZkVGVYQ1F0d3JJ?=
 =?utf-8?B?VlN4WjFJc2ZaTXRXOCs0MmxDMGdGVzZXc2V5aFZseUxPVjlJSlMvRTNDSE0y?=
 =?utf-8?B?QllXMklUQUVDRC9SUzc3bXllcHM2LzNuRS9MN1NXblpPaU5tT3lrUFpJQ1dv?=
 =?utf-8?B?bnl0NGx0MldaU1U0c2M4YVBlS1RKN2I5bXBNeEJtRVJ0OUVPVmF4OEhNMlR4?=
 =?utf-8?B?UHJmNTZ3ZEliQU5jR01ON1lUZk5nV0dUanRnV3RkYlNhL01tNEtaYndwSEVJ?=
 =?utf-8?B?RUV1ZXZVb2h0a2x0b2JnUDRwNnUwVFJMVlJKeDk5OE5pY01WeHdSc1dUUWxr?=
 =?utf-8?B?bC9ZdlZFZ3dzclBQamZ4OXJCNjArRGc3TlNIT3E3Q3VPRTljcVBoV1NaMWMz?=
 =?utf-8?B?SXc1VkFFcnFSSlJiMDdUN2JJSms1SnlRTG9HRDcyTnMra2pTQVF2ZUNydWk0?=
 =?utf-8?B?eDlKVEJxbjR1anJQZWtDWm1LZDFpV1ZoSEp0TXc0bXpERm9qMkY2ZDR6OWRr?=
 =?utf-8?B?Tm5qUld6aTh2RUVHcXcvYUl1ZEFWU2REL3NnQ3VXdHA1NHoxeWI5dXpoTlVK?=
 =?utf-8?B?T2hhbUYzbEtPUWE5bkFUaU5nR1hPcWhwN0xES0hMWWtHZUh6ZWMycWg2Rzhn?=
 =?utf-8?B?aWZYMXpKbEZyblVPNitsYlVRVHlISXZ2RXVCTU9ueUxzUTIvSzhUT0lCT1I0?=
 =?utf-8?B?VjV5TkJMUXM3T0w1K0JFU3hvdmlYNHZGVG1RRUNPdEF6ekxRM2o3aTlyRDdZ?=
 =?utf-8?B?Z2J2cGlER3FwWjYvMTM2S2dreGNSRGRFSUZRL2J6eUJiZkJKN2NTNEJkbnpG?=
 =?utf-8?B?ZHNsR3hpWWpkcEdoSHZ5RGtxbHRtYmJ6MTJFL3RHRUdlYXlrWk9SQ2k4L203?=
 =?utf-8?B?bU9QckpHNHhnVC91bUhUdkFHUkM3OHdBMDB6RmFhTkF4TmJaNnB4bEJWVmsw?=
 =?utf-8?B?VnFXM2tVVkZsWnN2T3RBTldKV3hHcGU0N3BCanhSUm5WYWdqSERuUFpxQXZi?=
 =?utf-8?B?V0dXKzRUQVozWUdEb2VUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlRxMGd5MDJ2M0Z3SHBMYTdPRDZjRzYyVElqR3BhT1pwOHRMZ3g1bUEvMGNo?=
 =?utf-8?B?WTBLWUVLYUYzMFBVT0ZvVjRZWFZFZFpXU3pPQ3NsWW42OWV5U0F1ekpqVVox?=
 =?utf-8?B?WWJUTTVLVHZHeXEzdDVaWWdqQnk0bWk5eDNWV0J4K1R5dlh4VnkvblNjV055?=
 =?utf-8?B?YWNTcFNLZFZGVWdCZGZMeEQyUnZZZXpPQ01WVmJWamwvdXVSd29JK0xUTzdN?=
 =?utf-8?B?VE94MkdadUlXOTY4bzhTVmlidElIelBRWFBJNDJXSTJ6bkhDYysxK1ZNb2JN?=
 =?utf-8?B?VE9Cd3dDVWFCWmlJdHBLL1lGQTNScEppeHkzV0d5T3ZrdFhKSHJISE8zTURD?=
 =?utf-8?B?SHJkRXhYeEh1NDIrSFR2V1NUa09YakJHbmNGR3hIY1p0Z0hPa3I3Tkl6Y0FB?=
 =?utf-8?B?Z0RGZkVTcEs2K00rcmNoV0RsM3c3Y3Q2NTdoU08vdHNUQTY4YnZJc3ZKQ3N4?=
 =?utf-8?B?bFF5ZzVKRWlqekRzRmZ0d3N1VFhuVSsvV2htSXdyTmZLRjU4cmdWTHpXZ3oz?=
 =?utf-8?B?b1lXc2FucnBrREVPR0VaOW1DdDRCQ3JmNGJCN3ZLTjZVeDRpd0tWbElXTFlv?=
 =?utf-8?B?Z2R2RlVOUFNSdkhkbmpyenQ3dm8yZVBxQlZ3TFdzeThHd0lzTmtvWDBkNkJU?=
 =?utf-8?B?MGZuVzNJN2lER2lDU29lOXVwQzZXZFdhR3VMMUxIdEpORGNzenE0TWFrVDNM?=
 =?utf-8?B?c3hHMDNqdklmdlQvM1lEZWp0d3dEd2IzWllyaExhVWJwY2liTWMzYW9iTmx4?=
 =?utf-8?B?K3FlbzF5SVJZWFh2WmRnREdUMkM4MmhNd0hJSVFHbTZFU0FxV1EwamlXVzV0?=
 =?utf-8?B?TStTTHhpS3k3UUIvTjNFNG83TTZ4Q2FkS21leit4TWJFVHpreVdFakZrRXVv?=
 =?utf-8?B?T091WEdZWWlqSGtiM3VEajlScGsvdWpJTFpJemlkVHJXZ3RvS1YxMDMyeU9p?=
 =?utf-8?B?Z3NYN1dyZGhLM1FtenFMaC9wY09SemhGQ0g3MEFJZVMvcG00K2FQUHFlKzZn?=
 =?utf-8?B?N2ZvVlo2ZVpuM1FDN29yY2M1Mmw2b3dsSFRadGYzVzMxVGpYK0xwc2dvK3Jq?=
 =?utf-8?B?RlRmd0EzUUJScVlSU0cyTlp1Z0dFb3lIM0c1MmxLakZWZEFhYWtxL05PRnJP?=
 =?utf-8?B?RTZSSzRiWkdwZWNxNnNYNElIYmU0U0Y3bEhwWTJ2RUkwTlBZK2svd0g3ZFdl?=
 =?utf-8?B?bVVBTjRyMXh4ckNQWDh1NGEranZCejdaRUMrQWFiUldwWGFzOGxHSmF2RXZS?=
 =?utf-8?B?MlBXYjJLRVFGTERTUklSem1jajFzOTFidEdwTmlXYVdQQ2xUWWRrNUlFUndw?=
 =?utf-8?B?UVlHNzlTTnZxV0NiNDlidTcyUEptLytrNENVdEY0em9JcWtBakhmS3E4Slpx?=
 =?utf-8?B?Yys1V1RFNXh5cVVjQVBlcm9oQWplRUx1d25LQTBMUlFHNEFTK3drWDRoeU5i?=
 =?utf-8?B?U05Zb3RnV3hCZk82azYzandseWY0Y0d1bCsrbjg2eUlTdGpNSzZsdUJQVC9s?=
 =?utf-8?B?K1pUTEsrcWVCVG9QS013dkRGRU1jM2tuZG1STHVSQWdkWmw2bnBLdHpaUits?=
 =?utf-8?B?cU5UVmpkWmdhUFlmdTlnRTJZaTdGVG1TTzZDTnhkanZGYk4ybVJsTUFwSGEv?=
 =?utf-8?B?aFlna2VEUWp4RzdMWkJpUzRMVDFyY1dLeHhhb21TZnkzbHZkWVcwNVFEdi9n?=
 =?utf-8?B?RWtzL3QwMUg2S3VnT0E4T2VSazU5UzhVLy91bVllWC9FSnhZZGxPczlHMnVL?=
 =?utf-8?B?T2h5OUpsaTdXaGdaS3JJSVZkeitWTC9uak9BYTRMNW9MVi9jbEhhSk1ZMklP?=
 =?utf-8?B?b2JudDY4elVQSlhMMnVES0p6Qms0T2tmZEFuUGVVL0prQTgzYTI3eDY3MFQv?=
 =?utf-8?B?am83U1QwSDVDMGlyaTFETjRtTzZkSWdhaCtPR3J6KzRuanlYcnpINkJkcGph?=
 =?utf-8?B?cGc2L3NPM09IV1Jpc3VGSEVmb254YVEvS3VzRzVEUkpqUzdTcW0xVmZVWENF?=
 =?utf-8?B?Z1FWVGRQK3Bpejg1eFJzdWZsUENjbTBqZjFVQU53dTE2V0VuWkltTjFWQ2ti?=
 =?utf-8?B?UWVBdnVxMFM1Z3NEK2tzaFJDN2QyMElKS2d2Q0JRZnhPNlcrUFZ0ZkNwVTdx?=
 =?utf-8?Q?abgl3jqvOVsD4eBKg4gqqi7tY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b51bd6-1576-4814-fa9d-08dc8f0a783f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:11.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRlAL0KGb7LetL6VUD98MiP1MKjvRirCMktu7bHIha8lZ1ruD57u+7R9NOQ01OP+ycIo839Dq65BTyadV/Tc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Fixed 8mp EP mode problem.

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
pci-imx.c to avoid confuse.

Using callback to reduce switch case for core reset and refclk.

Add iMX8QXP and iMX8QM support. PHY driver ref:
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=82c56b6dd24fcdf811f2b47b72e5585c8a79b685

Base on linux 6.10-rc1

To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v6:
- Base on Linux 6.10-rc1 by Bjorn's required.
- Remove imx95 LUT patch because it need more time to work out the
solution. This patch add 8qxp and 8qm and support and some bug fixes.
- Link to v5: https://lore.kernel.org/r/20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com

Changes in v5:
- Rebase to linux-pci next. fix conflict with gpiod change
- Add rob and cornor's review tag
- Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com

Changes in v4:
- Improve comment message for patch 1 and 2.
- Rework commit message for patch 3 and add mani's review tag
- Remove file rename patch and update maintainer patch
- [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
	remove extra space.
	keep original comments format (wrap at 80 column width)
	update error message "'Failed to enable PCIe REFCLK'"
- PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
	keep exact the logic as original code
- Add patch to update comment about workaround ERR010728
- Add patch about help function imx_pcie_match_device()
- Using bus device notify to update LUT information for imx95 to avoid
parse iommu-map and msi-map in driver code.  Bus notify will better and
only update lut when device added.
- split patch call PHY interface function.
- Improve commit message for imx8q. remove local-address dts proptery. and
use standard "range" to convert cpu address to bus address.
- Check entry in cpu_fix function is too late. Check it at probe
- Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com

Changes in v3:
- Add an EP fixed patch
  PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
  PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
- Add 8qxp rc support
dt-bing yaml pass binding check
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb

- Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com

Changes in v2:
- remove file to 'pcie-imx.c'
- keep CONFIG unchange.
- Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com

---
Frank Li (6):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
      PCI: imx6: Simplify switch-case logic by involve core_reset callback
      PCI: imx6: Improve comment for workaround ERR010728
      PCI: imx6: Consolidate redundant if-checks
      PCI: imx6: Call: Common PHY API to set mode, speed, and submode

Richard Zhu (4):
      PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe root complex (RC) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
 drivers/pci/controller/dwc/pci-imx6.c              | 1004 +++++++++++---------
 2 files changed, 551 insertions(+), 469 deletions(-)
---
base-commit: d9b6deec8e0a49b3ade6559b68c6a77ded0f4a8d
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>


