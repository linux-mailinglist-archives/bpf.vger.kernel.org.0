Return-Path: <bpf+bounces-34106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C2292A7FE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20979B21963
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51714F9FB;
	Mon,  8 Jul 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lO3JO/2F"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5714F9D2;
	Mon,  8 Jul 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458547; cv=fail; b=uTyH25yyOlOWQIO4Ld4Ti1DMqp0RjcW4+5H9ds9hhYeHoQDtZSuRHNcbG8EcuaIPdhqFaq+0yHAwrQmYB9tyVOT0t0cVyVkgMZIT2WXYnD9VZb/GQSLHuR2ZmrWUeRPwFFBpiRJuf4UNUu2Eq7vEtTq4TSaoMkdYI+5rmrL0Kkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458547; c=relaxed/simple;
	bh=ymgQePC8ggoQS45hlSTw4V4RvYj1NT17SRqn0qqc2PQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AftitpyJhpGCTsBCNplhEC3Kzv5qmIqdw/tdNq8CkQ8ZJ22HwAMZ0Cb49OI4FP/lkRwYKiHcrWfcyL3UZc8i/RnWVGUISgDzQ88GA4srkJnB6zG9tPpG0+McAkWOPd0HW1sZINRY1yCmwazT+iULGkXKTRi3m18H0m6M6D1AYdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lO3JO/2F; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erehdGw4IKWGXTI/s6WNMEQBDpAZNf9ttRBxru9kRNvZIhRs0veSGGNGQywUxJYFCgaqoCvqRQsB8c/J2nUT4jZi6qo2EVpdy4j2Q22PiCe6DE7ACQzY8WRBpfi9BVcUG6C7i7826Ap9iSSPa7p23/mc2ABaQrD4UC9B5PzgPpUNVGSSAtVxUKTyS5pgP7Gjpmx1aGBOC1CWWMgZxHgvfdMCfLDR1PGwgg0Wzz9wVGEEriCWTKCyt4TsCrLabCbXbleOtkPZnLFio/98rQRfKavOZfQvmDrJWwsR+UiIIdW5Hx+2JQkbUxgJLwHADCkBudxEMoc3/YUNeFXf/u2emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiphaEwuqok6wvOgOrxuwycBZ+89P2+4NMqys0e/yxY=;
 b=FHK496Tzh5WyYEISDyGDnnQmaplLlvvITq8n2Ud28YGybGhIgUo7S1woc91eCrXuX983L7aHQbwiZLawMZIiN1FzizkgLiYeNO3/23pwnAXQuHGa3xS0SRhciKy6qgtp74++0An5Yon+NcvISabvsYRXNFfYdrCTwCz8uOJCxCSyWi97yU0jGPX/hhCX1MVsuN7YCcQsaw44aWTFIIyJBgynYv4WDJSm6+Is5yKhVgTK5jfomSpOBx5YC8cUwalAMCiLzlcTpQAg3P5BHYz2OnHhnm0sqUuKi32Z0J5r7ejqssa/8nlH8xuFMtMSOaYbsZs7K8NG78tyt7iAcTXWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiphaEwuqok6wvOgOrxuwycBZ+89P2+4NMqys0e/yxY=;
 b=lO3JO/2FI92jZqc/1lnZ/42KpEApJrmtzomEH4EFvyKNMTuUU5IBcESgPKUcpjmrR9ylhNZ+vGkbJHd/xsutoYwPv4kW5e+3f/So3BcmFog4YQSUhFeo8SkywhSEt0dBI0sGGN3sAQprHD1v0dPPchXu2RpgRpV+yhUQIyNK79M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:09:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:09:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:11 -0400
Subject: [PATCH v7 07/10] PCI: imx6: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-7-ac00b8174f89@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=1048;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ymgQePC8ggoQS45hlSTw4V4RvYj1NT17SRqn0qqc2PQ=;
 b=TrM60Y7asVn1m4bt/Xnl+3qy4a/0HjqwFx5F5fyYSyQB5yOXguHQnz0zfqO0GOOKY7orOuR55
 NwnqJE3fh5qCW72KT0b+KHDTgiNFiUkOVmaD7bzFRNBIm6UKodrpNDu
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
X-MS-Office365-Filtering-Correlation-Id: 62e4727e-61ad-4124-0a60-08dc9f70aa69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0l2b2M2TkNnS014UUQyV3pDdm1PcWs3OUVoNU1KM0F3cXBxS0xMK0RJYVdQ?=
 =?utf-8?B?azJPSzNuRDNyMC9LRFkyNU5PUmllengzUC83T055Wm1TcTVNOEFVZUFnaWs5?=
 =?utf-8?B?bzhNdVFQbTlEYzIzTWc4Y0hlK29XaGhTeXhabFltUUdQVnpwQmQvZG9OWHc5?=
 =?utf-8?B?SkZTS1hmV0M1MGNjRjJSK0l6Rm5LL2VqZTY5UUgrY1JaY3lTZGF4RkJyclVh?=
 =?utf-8?B?WGhMR2tBSkxEbWhRMjJTVEVERDd2emVCZ0lCRE44VWYxY2RYcXBuZFJFVzhy?=
 =?utf-8?B?SjVjQ2hHSW8wdldtTHA0ODVDQ0pzeHZRWGlSaFlkekpOcWdmbkwwbVhEQ20x?=
 =?utf-8?B?bmZjLytDbU9yYU0rWXNzRHhaUENYOGcxT3p2QzdMcEFidm5DWnpnVzhhZUpS?=
 =?utf-8?B?bEY4TlAvUkhYQmhkOFJZQlltOUN3akRQZDFuZExjazFHVG8wMHVuWUtZSlZm?=
 =?utf-8?B?L2w5TDgwakZPMzhmVjF6NTVzWEpXUXVqK0ZGaTNGSTBCUkhjV1V3enRTbTBy?=
 =?utf-8?B?Z3JrWDQ2TEtSdlJITkcyeFc1em1GT2VVVHBmZTYrN2RybkdqVWJ6MENSZVRz?=
 =?utf-8?B?QUpsNmsxNVpYd3JCY1hucFU5U3dncGFxU3dFNTJtSHoxSmF0YTdENlBhL1FZ?=
 =?utf-8?B?RXF4QndqZHpvTEI5SmdzS28ySldkcldPUGhoelBPbGJqWmV1S1NxYmhiRnVQ?=
 =?utf-8?B?ayt1OVJhaFVJVkIxV2c2SHFjeFFlcytPc0IyaitZMDU5WFRVdnluT2w5Y2ZY?=
 =?utf-8?B?Vk01MWdRTlBrK0VnRDZ4Yk1aYmRZVEg1bHBIeVZZdUZBU3VmTFhMeWl0ZGN4?=
 =?utf-8?B?b3NjM2QvQ3UzR2t5TEZnek1sOTJVTktrQ2k3NHQ0NkVZUUxvUGJGSEI5NFQ3?=
 =?utf-8?B?dDlhUDBVOXh0WE1QekRGemd3eFZZdGgwczhqQVMvZ0FwVGtmMDZWZURJSC9r?=
 =?utf-8?B?cTE2TVU2S0I1aDFuNWJDcW1xSC8wa2hBeHZLc3JWVGNuMW5JdFp6aXZxeFBv?=
 =?utf-8?B?SFlOWXNidnpaSCtiRjRhcElmcmVQWHVGTGhXalJ2UE5ESCtDK1A0KzdNUnVy?=
 =?utf-8?B?SFJjSmxLdmkxcEdBMS9JM0dDajV1dVVITGdDeXozUGJjRGVDVU9WaUFVVkZD?=
 =?utf-8?B?TlZub1o3R2JxcEpBMW5aZDNZbStsRUxLTDJxTENSTWZOaTBWTnRRWnVaN2pE?=
 =?utf-8?B?TVJCQTVVTllZR2xiYVNsY3FVeGxzcnAvNkkrdkx1WmFJYVNWRk1jVXBMOXRH?=
 =?utf-8?B?RU50SEdGVHQxM0NyejNDUXFyRUlxM2doemNSY3hYQ2xBZzJwSFVzdU81OFhm?=
 =?utf-8?B?M1lHZ1BSZTdnaVkwVWQ3VURkZUUvR0x0YzRzZ1doRzJFNWJHQ2NYengvMWFT?=
 =?utf-8?B?aWx2azhyMzlGOHZ4bnE5MmdGbTlBQ1oyYTVRNzlWanJOb2JRNTJpeEhkNzNl?=
 =?utf-8?B?cEZvbTl6QU1PNEhQL3FWckNBWWJWT3JOYmUrTnlGbStmMzhrYnMyRitTSnlC?=
 =?utf-8?B?Y0h0MmZiWElvcVlzVStmc2NjdXFEcDlHR3A0cG9WSlhtZHp5Rmg0NmxEYkFn?=
 =?utf-8?B?c2VpUzdudTloQk81czJvRU9tdDJsMm1BeHBsbTBJSW1lM0JrSWlEZzNwYi9B?=
 =?utf-8?B?Qm5DTHNod1V5TDNGT3YvYXBoVDlURHM5WW5OTC8xMVFoY05qWmFNV1cwYm9W?=
 =?utf-8?B?ZTR0cEtTcElCYnZqNGF6WFRLbTF0S1dOYWpFOGtLS3BzN2djUTY2Sm8vQzhK?=
 =?utf-8?B?aUdjQVk4Ym54bEVXem9OZlpwQTVIby9ZUjVvaXpTbEdEV2lUMG9zVHhyYXpZ?=
 =?utf-8?B?aU8zanhQakNKM3NhOThWZVUxNTdYTGNoRVRCVFBXMzFBQysySFNaYUVTT3A2?=
 =?utf-8?B?NUxidVh4RkpmMkllbDJVQnUyUE40SmdrN3Z5enV1Y0hzRjUxTGE1S2ZsWU1u?=
 =?utf-8?Q?mE4y0OTxw2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHl6UzRQRnE3TUU3cXRKVDd4TGUzbE1jUkJvbXNrK1A4VktqSlp2UllIOGlz?=
 =?utf-8?B?TWdORmlNVUs3Y2krbUozWEQxd09vV00xamxwV2FZd3VNMjlNeVBQN3duSVhP?=
 =?utf-8?B?ZGFQM3B3bUN1Y2tBMk82YnpYeFdVZ09LN0JqaThyTDVRUzd2NDhocGh0aEJm?=
 =?utf-8?B?cmpDS2ErdlhXd0tGT1d2R2NOZTdKSWcvZGI1T2tydFYrdTJlOU04Q2ZzeE5Q?=
 =?utf-8?B?cGdLdUgwTjlYWEw2Rkl0VWdFYmxza2M4SVdGbUdrbnRpOUFYUm1RRHNKV3h4?=
 =?utf-8?B?U2xMdm5Fcy9WbGNnR1V5OTZwOGI2VDZtb1ZNcVhGRlJPL0xadnAyTmFNMm9q?=
 =?utf-8?B?dlZ3ekVYbms4ajdyWFJNa3pLa3o4NndhV09NRWFnd2ZUakFXQlI2bzN6VTh4?=
 =?utf-8?B?ekc4bVZxRFFnYnp0M1ZKVnRhQkxNeGpSR3JZMTREQjFPUTJ4eEt6bE1GMEFX?=
 =?utf-8?B?c0RReHRjUFloZS9pSFJkb3NYWWJ4MUtPSmJUOG5FLzN3ZGNVWXd2U1ZPcFVW?=
 =?utf-8?B?T3FBeDFhTFhTZDRWdGFISGJ4NndDMjlkMnlZeE5LUlc0MnJyRXYyeEVqWE1j?=
 =?utf-8?B?NmZJM29aSE0xNzNhcEdxdTk4b1BqNjlGYkc3T0puVWowZS9icERyQUlhd09i?=
 =?utf-8?B?MFZNQ3JGaFRQWHNpRnFFMXVJUXl6bUVEY3NPS0lBZGJ2WVhCRTJKcjhjTVpa?=
 =?utf-8?B?bWluQitwYTd2cEhHLzYvZXBKNE50REN2dGVtUFNCOGlXUjRXdW9SRXNiR0ZJ?=
 =?utf-8?B?SWVxcEl3T3ZrSE94bHVSM3pGUmt5WWRUajRqWkFjL2Q3WitNSW9FRmpidlg5?=
 =?utf-8?B?c2NoR2s3amV3bFEySVF5aGRwT0RzMTAzendTU0hKcDNoY1I1bGVZd1lrVk9T?=
 =?utf-8?B?L2hPK2FUSU9TS0JNaVB1bHA2djA1R3BpZng1Z0JmemdoeVJ4MUV2WTZyaTRD?=
 =?utf-8?B?ZlBRMFA1aVNYN3hJRE5UdTlLUDdybzNLTzJMNVYxcllGcHp4VjhDY0RiL08y?=
 =?utf-8?B?ZDdxY1lkWTd5eWFTWUlUaVo2YjJOWHV0ZmYweHduRkF3b0ozelNheWtKQWpG?=
 =?utf-8?B?T3JUYUtnRkFkbVdhcEsrWUdVWVE1MVJXcGRFalJhdHRQcDFiTGpVdjN5eGVs?=
 =?utf-8?B?alpJcjR4K2FzN1BhK1ExaWJSZkIyR2xEaGpaamhuQVZhV05xQ2M0c0RPOUdx?=
 =?utf-8?B?L2FzWHBkRUV1YmFDOUJLb3hXZGFEMWxBN2lLWkwwRWhDRXFQUHVBSGdPN25B?=
 =?utf-8?B?TnF2cGNmUlFsanhENW4yVE1rcHJuV2JKRGd1QVUwb1BqL1ZNUHkwSVhsUXVt?=
 =?utf-8?B?UzI0Sk1EeTFjdXJMdlc0UzkvczlTMjZyU2RCeDBmZmVKcmd6T1lLU3FBZjdJ?=
 =?utf-8?B?bHdWYkplOFRvcUV6aXBlWUw2NzNLbHVIYURFZGRReWdJWnBJOER4aVF1aGtr?=
 =?utf-8?B?TXBzNHh3M1JpU0VCNkpYblNHRm55RFZTMCt1T2toeEpjVWNzUGFQdldab0c1?=
 =?utf-8?B?TCs5OFZuOXNmbjVTTkozbmpDVktwTkpzVDYrdVkyUTJ5NTFSZjc1U2Qwa2g4?=
 =?utf-8?B?RTVwYlcrQmFMOTFMblozWGdUcDJRVzFlNWZOS1pvN1JpZndqTlJML0FRaTRk?=
 =?utf-8?B?VWZCOHU3b3BlRTd3UzNiR1I1WHBYTDNpWm9yN2dVd09XN085TUtuWUxZc3B6?=
 =?utf-8?B?T1dXcmRPNVdSU2IwNkZucFZGeTFtMHJnZUdiejVwMk9XUmxSeFQyZUF2cG1E?=
 =?utf-8?B?OG11QUdETHRmKzlINkdRYWgyNkFsanhpMjVlaWd3NmZncmZLUEIrNWkxL0NF?=
 =?utf-8?B?U2NsYk81VytqWnQ1WmkvUVdzM2JkRko5RjRFMGRzTTdLRE52bEdhbGxIOTFB?=
 =?utf-8?B?UzJFSzNUU3djYXlldnBacVNlTUlTOU9oU2pRbnJBdXFwMWtTVU1OQzhWVENK?=
 =?utf-8?B?aDVQWlJDc0Vma1ZlYVZ5M0lyWmhEd20yQkQxOStlK2ZpQzNrSkxsKy9ObW1l?=
 =?utf-8?B?dGkxQm9nczRZRkhQNXBHdnhKdWl1SDlCckNqWkRWdnVmVWRWWGpvSzRNbFhK?=
 =?utf-8?B?MWVUZzFUa3Z1eCs1SURCeGVDb2Z4dGZuYmF4NVEvSHhKZkQ1aFdST0ZRUWU5?=
 =?utf-8?Q?uDIY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e4727e-61ad-4124-0a60-08dc9f70aa69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:09:02.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3U9wz387UdSi9kqiFm431Vl7wBygjX+UEn66Uv/hE5Kog+aVUXfgYKMrZatJSHi0zqlsIl5MtCZJ7i8YLIxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

Consolidated redundant if-checks pertaining to imx_pcie->phy. Instead of
two separate checks, merged them into one to improve code readability.

if (imx_pcie->phy) {
	... code 1
}

if (imx_pcie->phy) {
	... code 2
}

Merge into one if block.

if (imx_pcie->phy) {
	... code 1
	... code 2
}

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2b95c41f8907e..57814a0cfab8c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -954,9 +954,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
-	}
 
-	if (imx_pcie->phy) {
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


