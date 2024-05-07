Return-Path: <bpf+bounces-28929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757398BEBC5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6D11F24E9B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF916D9B0;
	Tue,  7 May 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UCaex8/p"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3B16EC15;
	Tue,  7 May 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107614; cv=fail; b=OCyHRuMMW5QUzzYFLT0gsUu32jU+yKBtD1Fvo87Js1zCU7m0AOBL/jGJ0MEIdLuCNR1OR6T0fdq+If2iup58wFolxichtigmcKJadRkumwzktMqpG82WB8lkXsqnhBgCyowCM8N/XqprSbB30hR+h841PvbQkA+3w+plB0HSZaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107614; c=relaxed/simple;
	bh=Cpqug5G7k49MqW0A3NFncM6Y5cYEpxavVt54pyo/9Qo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tIJiDmCWHqoTLbGpn2wxisFb5Fz4/Ryfe/ztIKvK2RqfgTcKWV6Mhv0ihZ4wTtKVAzNmBGt6D08NsLA5QdN7K3iTwEOcKggW8JyacQGpPnzs1cy8+jSpLQYmqMG1m+TYK8HwHdEEYOVUsyocIBB0TKIxH99SaZpGsfPJ5ZNlDAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UCaex8/p; arc=fail smtp.client-ip=40.107.8.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X04qXaaiC0595okiuRTgeJ5h0C7PK5co38cw1HDgZRpSWJ36ERX+Qh3nR4VOpSBT0Cty+3NGfllkQlOK7FJbqAJdTpfvx/DxXR0XYmU3FplNGemT5+86TTLdkYcr8NJUqSvaQdsQkBEk4hfpSagS/EUMR2kSEsOuXLt1araawdnkbH2chFTpgc8PoVlSFFHkEmVACl2r06AMwiKh3osudeNMQRPLaGg5DS0Ztsh+ja0vMUdYb2kJ4b0whr8U1tqGFZTzr1uyDXr60Oft6wpqnKNKPWy7uKvZo5Sj/jd2W6nUhnAPiNr9J16IJX9F1vesNCmLSJbvob0Vyn9zTQ68ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nl/ELpxThlz8kTl1lbs0j8zTFjcylBahXo9Jv8iXEQ=;
 b=STE0mmZDrX9hhAOVD7lrmzGPyjuRCS0Ij0oRy60OFv8peYGqJvmHr4DQJ6tEo9neqeJaBOEBMEerFgq/7Shb8dfmggiBLhCiCNlvBGg54aUYHW6GBessGHwqXWeWZNyxpoIfEOQfh0OG3FSS17hBHKcN8bMgDdS5qzfo7uLQ2RaGJxgQ4rabhrQPT3VOrE+zT72mpUiIXsqZ80Qvy6xzXZEK4wvfr+ie+TspltnFzHv92pIrau1gg8rkp941vg62EF7pgmW9fSt0/gOvwKyi2r3IBCRpJFxU/n9ZnkYcL+tFhiSQpzh6fOJ2giNtK8QvzUpnHFoMoiqTYEyKDAHPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nl/ELpxThlz8kTl1lbs0j8zTFjcylBahXo9Jv8iXEQ=;
 b=UCaex8/p1vPPrz21votM0zO6eoLEhHantCIdjlBf79AjJ2ODzaDtXAAiK0GRRF7c4D4SqrzRVuQPWSEx2dHXVPQ6hH7VszRRDULYYFreYt/ks9ZBkA3Idja3tPmJkhA2SgR+4pimqfmtQjfa84IP5W58kY6Qp3z1/ZMrqhGhz70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:46:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:43 -0400
Subject: [PATCH v4 05/12] PCI: imx6: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-5-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=7027;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cpqug5G7k49MqW0A3NFncM6Y5cYEpxavVt54pyo/9Qo=;
 b=lEu/WKLevwLBU+GsXyEDwvrd1ECLpXCE+545syYEZrWi459n2RA8Kly2lP5zalZ9HTiR+1r5W
 Fea6U/DC0OED4frS1NOFa2IqxnLTcpo54e9NgZsJt7QhU/DJh5OAcP7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: c0271a42-03b3-4e7e-a494-08dc6ec60d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVU2WFczRVhvdTVYRzk5Si8xSTBoVnlDbUpLTCtuRDlaTTVrcTdNODlTYy9Y?=
 =?utf-8?B?RjNpdjVvZE00a2hLR2g5eW0yYTdmSFVEMjU5YVB2NWZDTk1hNE5ab3NBVkt6?=
 =?utf-8?B?UjY3elFqOTVQWTE4WnNvcnh5d0FoYm9NQTNMRVJ4YStmb01lYWI1RmhhNGFm?=
 =?utf-8?B?K2FKalBLN3EzWXpBWGFaN3VKNGJabTdVem5JZHl4aWc2Yis3bW5KRVZYMjZF?=
 =?utf-8?B?MXUzOVo4M1ZYNzJWYTczN1I0NXJPNXVZR2l0em1BM052ZFY1QlBRRzZ5Vm9w?=
 =?utf-8?B?MFRIODZ4YjF3V2lXOC9iZFA1VDM0R1hpblpSS3B5anJBei9LU1FnemZGSm03?=
 =?utf-8?B?NjhQYUtpeFVHRGFqZkxrZXgzQ0xQTEJlMWhmN2kwdjU0dmlXZmJhb21iT203?=
 =?utf-8?B?ZFhSUHBDUFlOaUhaaklrdjBXTEhiaWt4b2hOeVc1MmhDM3dOMTdpNHZsc2Vx?=
 =?utf-8?B?MGIyQlVTYjYzTGJTV25zZ1lOcW90QXhjc0JSZm01RnVwb1QvZS8xQlh0ZG1q?=
 =?utf-8?B?V2tPUXdqeUlrSkJqNTdZSkNMdjNXblpYQ3c5Z0hkY29aN1lJRzR2TitJQWN0?=
 =?utf-8?B?ZEhmbS9IbjlkTzhSS2pvS0lrbkpQVk4xcXlxT2FjVzlDWFJueTE5WjVHR0li?=
 =?utf-8?B?K3ZUd25OQzJJZHpEbU8waUhkUkJTcWExT3dvZGR1SG1CN1NxbWhQYWs5Z1VQ?=
 =?utf-8?B?MTZTbzE2dzNnTUJ1a3FiakF1RUhPNlFGY3BlK1NHVGwyT0FBdkhzb2ZNTk5D?=
 =?utf-8?B?UlF4eHZHU3ZSY3Y5MXFGMGVMNmFYMlV5U3R5VE9ScWFKdWJ5bkMrNjFjNVd5?=
 =?utf-8?B?SHFQVDB5SDJjUDBkWnV6Y1hweG41Nmo5VDFEOXpZZS8waVh6L0o0MitJdnox?=
 =?utf-8?B?TUhYRW5vOXM3SVJGTlBqa0x5WnZBMkhndUMvbC9GMnVxRlBvdUoyTDNneXVq?=
 =?utf-8?B?K3h1Q0Fla1hxejhmWFNJNmh2MnJFZEt1Q2o4OVBldGF3YVVwRmNkN2s3S3p5?=
 =?utf-8?B?NTAzMDNZT055U1g5eDZDSjFmR1Z0WkxkNlB5ZTZuT2h0V3ZPWnoxdFVrMith?=
 =?utf-8?B?ZTVzVC9QaEtCcEhYVnRhQjcvem55SGlySk03QklDQXNCVk55SmtRUlhWQ24w?=
 =?utf-8?B?R01ocDRkbUNLOFoyZnRPOFdudnpMbG1hYmJVaC9ac0xsejZZN0pMVEVuSlZ2?=
 =?utf-8?B?ZGV5ZjNoeGpDVm1ZK1VtbGRvNWdwOXJ2L0tFcjA3MmxET2sxT2N6T0hKZ2lO?=
 =?utf-8?B?WVBSS3FkK2RidUZIUDZkQ1ZuSWY3Z0o1NTFKbnoyTTdRK09Uc1ZTZE1aL2l6?=
 =?utf-8?B?c0dZb3lOdWZzNmFiYXdIelE4MFk1OGluSTVuYUdEdkxyVUV1NjZxLzBIWk5Y?=
 =?utf-8?B?azRkMTQrQWNOUGpCc3lqUDBNd0JXalpLbGV2SkpoLzlHQ3VvWTlndEFxaCs5?=
 =?utf-8?B?K1FpcHAyZGY2TEQ5YXlGQ3BVR1dXaDEwS25EWUpQc3dwZUVkMDVKVFZDeDVr?=
 =?utf-8?B?WExzblJCU21aQUNRS0daTFBiNGRTV0NPS1p0VUdlV21DeW92dGdvMjZPYXBz?=
 =?utf-8?B?UDZvRzFLa1p1OXdETzFNUUFJcjROVFVkWStVVEJjM1BTcUJVSk1kUDQzY1Nv?=
 =?utf-8?B?UEFKOVkyTkV2cFNLdGpzWENsRTZmbFlpSlN5bXpIT0FBblpXQk0yWDlUVlpi?=
 =?utf-8?B?K0hBMEUvbnVWRVJQTHlMTnVSWENSSWw2U20yMFJWSGJHek02MEE4MUJLa1gv?=
 =?utf-8?B?UEV4MEdmZ0crbEtoTHJrbENqZHVIb1liQ1JLWFU0Mzg5MTNJaXdrUnN2WVVN?=
 =?utf-8?Q?O3Cnw8zQsyJX2lbcdVTXLz+gW12+3Je2FU/us=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1hwUDh4MXV2TzZNWW5naW5JVURjOEU4OGswNS8rZFlzUExteVpRZTZuc0dE?=
 =?utf-8?B?V2NpTlJPa1ZZM1FNeUpkaS9yWm52TWFYTG0yME1UVUNzdGt1V2xQamM3dnFT?=
 =?utf-8?B?M3JaOHVGMUpOSDFJTXZ3aVhIRytLM0EzVUFtWGM0VFB5TFhrZE9BdzZxQVZx?=
 =?utf-8?B?RkVGbysrWVlwd0l6aTFuV04vMUlCOEwyM2hpczlNeEtVSWpURzd4eTVhVTVt?=
 =?utf-8?B?eDVPT3VDRWcvYUIvZFhiOXg2NU0wSkI2dnZBV0FPbUkxZ1BFd3RRRlY4Z3JZ?=
 =?utf-8?B?MWszdCtxakJ1bGg0TlFSVUh0cWc5ZmFrSzA0bjMxcHpSdXFVbVA4RFRtTEtv?=
 =?utf-8?B?VE52dFJHZThoWHVEbTBKcS9sUGk2RDVhcVhqV2lzVDBrYmU5cVMvOVBaVlly?=
 =?utf-8?B?aGt4QUQvcG9GZndSdzY2aDc5eEVuYmZVcUNNSzMxSERnL1Y4M0xRSlpudUt0?=
 =?utf-8?B?UENFZ1ArMUNSc1J3U3FzeHRNVHdOMTdIREpXdGoyM2hLQ21PdkJDOG9MSVlq?=
 =?utf-8?B?cVc0U0R4ZTdyNkZmSzNvZGhVQ09tdHN2MFo0ZGJ1QUhKZnNIcHB1dUJMUnQ3?=
 =?utf-8?B?LzhoeFQxSjB1a2RtODFERG1IV09NS1RDMkxjaWQ4eUcwUG1YYkhXRDlrb0F5?=
 =?utf-8?B?RFh0YmF3VS94QnZJbWVrOWZBR0lxVXZwS2E0QlkvWHBUbFM1QlNUY3crdEtP?=
 =?utf-8?B?YnFiMkFBZm1HZFdaZnFoRVpXaDB4ckNWNWRRbzltZTI0WjVRZ1hlVm1RTURX?=
 =?utf-8?B?c3BOWXMrODFvRFV3V2orNmVJWlFVMTNlcVovNklxUFNSaHZ5NDQ5QnZpUDIw?=
 =?utf-8?B?U3poSXF5bVhiYloxTlVYckZJRWVsbmhDb3hrb2ovcjFEVEp6RytBTysrV0hQ?=
 =?utf-8?B?bGpBYmxLMklkUTk3c0VlRFhZNDRTaU9aVTRKUnJwWnF5UDN6RXdPUWxCSDJZ?=
 =?utf-8?B?d3hyVzgrZTZYMzlleXA1T0VVWUZuU0JiVzZtbERGU0JwWDA3UU9qY3NBODNi?=
 =?utf-8?B?V2gvbzFRL0thR3VoV25Palo4QXBnaGZHeTJLYjNiWURyaXhVVzVxZmZsWEMy?=
 =?utf-8?B?QU0wMmR4ZGt3MGFPYzJrU3pib0FLbVd4UkNYOGx2Qzl4ZmlVKy9ZWXlYYlZn?=
 =?utf-8?B?Vyt0MjNWZWFvazhkUFhURmU1ekl0SDUyQTI1VjZsZDFxYnUwYWcwWEI2ME5j?=
 =?utf-8?B?czZ3ZERxUVhoUHhGMmNNVTdlcEk5a01oc0ZtM0ErSXQwSUxwZGFjQU9uZEpa?=
 =?utf-8?B?cGhiRVo3cTRIbEhocVRialBMcmlyQmZsa0tDTEJEKzhIbWZvWllIK1hVSTlw?=
 =?utf-8?B?c1R6LzliZTl1aWlVbU9IYkJHdTNuK3pmUGJVNW5rcW42b3FPbGN1K1dQaWlw?=
 =?utf-8?B?R1RiRlR1eGd6U2dBZEV5OWVuNkl3RkhGRGNNZXJ2NG0zR050d3NjdEpMcGYv?=
 =?utf-8?B?YmVYSkhxaFBzb0JHKzVlSTVXclJZTXdNbHVidTI5S1ZwMUV2aXRIcjEvSHdu?=
 =?utf-8?B?eEl5RUt4QzBpdmhKRko3WGttaHJyTzNUOE9JZFhFdjZMWU5BTEdxNTB3T2xO?=
 =?utf-8?B?bGxSNXYyMkV0NDFWOFpBa1VIdk5TVzEveGlWaXBRSFhyMWdxUGs0Q3lCOEg4?=
 =?utf-8?B?RmxzMEJGenhqanJsZlJOM0hsWUpYS2NFbjdpMjZZRjF6K3VDNVRqaEJCZFVk?=
 =?utf-8?B?a3g2UUUyMFJhbnV1NlVJU2wycDNkb2tvU3JTK1lDYWI5OXJMVTE5dEMvK3Ev?=
 =?utf-8?B?L3dPQktFendydnVLQ09QaTQwSHpzZU1RRHpJQzI4MXRGZTd3WHFacm9iY1Bp?=
 =?utf-8?B?Y3E3cDJFbW5aM1FDOGNDVzdDUy9tN1gxUTRUaHp2V3M1c2hCc0hNbW1LclU3?=
 =?utf-8?B?R3o3ZDFJNG4xUWdJZDB6L2w0aHRuU2UrZWlORjBRMHJ6azloWW8rOE4xenMx?=
 =?utf-8?B?ZHJ6MWdXV1J0TnFwNXRERzlqZXA3ZVNzKzMxNUdSMGtCMzB3NzhJcC9pVFpo?=
 =?utf-8?B?Z3V3aDZnWWs4LzNZamhPNDJJcW15R0NPRTVnR1c5QjZSOGtGQnY2NExkTTVz?=
 =?utf-8?B?WHFkdS93VlZnYThzeklyTXpsM0JBZ3haWFYrd1hOZ3ZTZ0dVaEdlNDQ2RDVM?=
 =?utf-8?Q?tqx+4JnWUwjg43WGyMGnHUcig?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0271a42-03b3-4e7e-a494-08dc6ec60d0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:48.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KszmCK5zHC0m2Q4kON4cTUQDZIzGZsS46RJEd+26QsyJ++wbNQaLlOBUmvv9dUcKGVniQ5Hf7ptSsEifRBgRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index cf1b487b3f625..7396f0d51119a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -672,35 +673,75 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
+static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+
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
+	if (!assert)
+		return 0;
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
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
+	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
+	 * oscillate, especially when cold. This turns off "Duty-cycle
+	 * Corrector" and other mysterious undocumented things.
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
@@ -710,47 +751,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
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
@@ -1448,6 +1452,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1463,6 +1468,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1479,6 +1485,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1492,6 +1499,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


