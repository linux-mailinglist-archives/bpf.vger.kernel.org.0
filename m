Return-Path: <bpf+bounces-34109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B55F92A80A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE94E1C20F50
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213514A635;
	Mon,  8 Jul 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fW3B6Cuo"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815815253F;
	Mon,  8 Jul 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458564; cv=fail; b=BNWR0K12ydUeF0JwUJXWLHaPB9joy6XxWLZJs8RWgchFgA+WHlMQFA6dDuYeRqxhzDzYHd7UoLHcqIGdrtoeJmPKg3AcjdsFjORPLriAecIo63QfKOsk29slaOzl9uDMbqAHtlRpk2WjEce5A1IfDMXVhSZs9li3rQ2iM4rDJZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458564; c=relaxed/simple;
	bh=3pumsXExIZES/wQ7p8FUfOIADVYn/d9v336SFPD/EFw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GfmZSH6eAUEvkL/sYPKBxqIfY6iWB49b2oLatq6o1zxrL8nv56Rtfh0bXrKEb4LVofzaZSsGQzTEjofOQHeMW18PKUTvUs4epj2jH3CTVvWY4UCi0qCj2yZDmpjAmg5G4Z3yw8kgFGoCkmm3TEIgdaup0PPWclI+xAoGsB3HJMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fW3B6Cuo; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVM8amH0m/aPdPyBBNey///hZtNhPdLBuZneMrBuYl+dLPTbdhaDkveAwowK0t/BwvANZLZ5CwtlLOVbM3x2yUHmeUC+EvB+aPwx+/WISG818cb2NEt7pDN9quiZolpzFLtIrRWtVYbt6ZQcH6Je3FyPud2sA0QirI3beqD5N6Ovr5sHv3rx+EokRzmUYk2yIHjqXbk1hp1pY2VrPa+wrPxjIVTf4wxpsGdvMwzoGKZZe2IH07qovif6K090f+CI8TyM/I6lKqrIXSMXMjkpnEDPbvhOftbITo3au8QN2h2LP8wels8Co8SmIGGY/y6dpIOvHUwBvLqNIIQ2sk3zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZDtjLHt/nOYLulAatb6/N7XJedpDA0/1tsdJEj6zH8=;
 b=ixU1r9fWufMqEgwCnG7hGa4rnQfO0cgMcWiQ2js73eqrSPR58SMNTQXNB46IUmtdddzhtFsvI8MMng/k8BYK/hhYzcDme3HN5e1iyAY58VptmZLZtHMMppMCevtVIYfZ/FI/pQcwwL8+aiXg5roo46o4NB63pRa252KmQm+hKWtLayp+0ST8tXTJtBl8ApU9l+JfCOqpkcLAZw9tVM2qXChIhSUK2VErV9fy5yjjXGvEpA7dFVWSTlkbWfjg3Fn1HoWtrnQAJcYIWbHWpl/ZQp1Izx+Vmxu7CLGyAB0GomN7O8Q7aYiMVehgiFr0sdpTo/6V6q7VXcHheWSZ4veO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZDtjLHt/nOYLulAatb6/N7XJedpDA0/1tsdJEj6zH8=;
 b=fW3B6CuoMdul+Panys5D3fWqSfCzHVmdn0Tu56G0xfc6Nmt2L+bzGYG5UKlfRKlm4oFxdkoIIbnL3pWI7dFmnG/0YqcG0BJWkxCoKfmscoyA1NGQaI+1prNZztlAv1FO07bjTzOiPM5hB4HVs4KvixZRSO1FUwGnVZHbgmabdNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:09:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:09:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:14 -0400
Subject: [PATCH v7 10/10] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-10-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=4317;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wGqQ6/UbFLcRJ0QNOV7fQqSOcB4pTfQ/KMdX6Q+OqFw=;
 b=MN1SzuF3MRZV2gesPwoxaixsEwQyQyu4DY/Esh+VjHpBQy7JkkxInqjT4NNBkVw9bhYqGolL/
 Zv833wJjANMB7lRKYa/af0hPjrFl3y5+dm8U3YMTbzE9lTonrJL8Ak3
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
X-MS-Office365-Filtering-Correlation-Id: 221c84d3-10a6-41e0-745a-08dc9f70b474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3JIOGt2RHBYaWxrRWNoTVYzeW5oQzI1WGRJMjRJbkphejFQR0xCZmlXOVRu?=
 =?utf-8?B?YUZGQm1CZG0xYStSTmhKWkUvYzRRU0xLTUZ4ZzE1NFVXWVp5b01WTTBPQms1?=
 =?utf-8?B?OVpLckJUTkM0QWR0SCtQTDN6b1NETHlWWXo1ajhNYWZmbDBzVGZBbGVRcTR4?=
 =?utf-8?B?K2NUb1R3NS9PZXU0UUNsZ1c1aUo4bU9xVnhKWmptTkgxYmJPSWt4R09QOHha?=
 =?utf-8?B?U2dKMnRVQllKcnVGeWNIVmRGUkdYSVNUc1RtWnUxWTlkNjh0c3JEUUdhMktP?=
 =?utf-8?B?Zi8waDFxUXoySDRTZnJabEs3ZjMwTGkyYVg2cHNyTkVvdFdaemErMk91dXVq?=
 =?utf-8?B?V09oYkFWOUQvd1BPS2lkNzRsL2t5bysvSk1QMGlrZUY5NFlESXVjTm5zMVpL?=
 =?utf-8?B?OFFRVlF1aysrUnR1bzJwb1FsUVcycENaamttcWNlU2xKTmU1MTlMS3BmSFlY?=
 =?utf-8?B?TlBoaTZJTDNXQ2F2alpVZ3I5dkUwR0xJbjhlVkNic294MmdrSUVMRVllVHpm?=
 =?utf-8?B?U1pUL2hPYUFmUllwUVBLbDNPdjNHWnlNR0tPcENrWExIQ1hRVTB0WkR1Wk5R?=
 =?utf-8?B?ZlZpV1VwYTAxQk5WbGV2ODFobFJJVll4QkphRC9NZnpSWWIvSWJ6RFlDTmoy?=
 =?utf-8?B?emNoZUlMci9IUHZuVXVidGRRUndCWUZyRHNlM0ZnVTNuQkttQldTRUp1UEhw?=
 =?utf-8?B?c0ZMa0tkc0NiNldiZ0t4R2ViWUVxZnNxVDZXMkVBM0RMUHRZLzVISDBNSkZy?=
 =?utf-8?B?dXprTG1WM2EvbG5wQnhlcG80L2lGdmlsazFzRTJEUEdsNDVYeTB4MXhidzBz?=
 =?utf-8?B?VU1uRDVNUCtxYS95RDJUQ2VPSHp1T0N6UTF0RnZYVDVrSXRZNXQrakk5NHNL?=
 =?utf-8?B?QzhTbVI2QXByeHZZV0grckdJOVR5NWJxeWZRTk1CUm5DSTNXaU8rd3VnZUdk?=
 =?utf-8?B?ZFI2MGtYeDgrR083UWJILzJBUzhla1N3bVE4Ry9OaXlNUDgzYTVLb2pkelIv?=
 =?utf-8?B?aFk0Z3EzNXhFUVk0Y1lIQnJmQTZJOGltRVFFWHowN0pMeGVPVTQvRzJoZGhU?=
 =?utf-8?B?akdHUEs3UWxnODA1cU1ROUhHMm9ma0ZEN0Q5YmpkZTFERjk3TlNhTEFxblIr?=
 =?utf-8?B?bGc4YVFFWk0venpreGZ0bU0wQTh4RG9rdDNQaGxLQlhvQ3ZLbTJFaTFBSHht?=
 =?utf-8?B?STFxS1MvdkdWdFBaSTFWVHdxU081cmMya2NhT3NFWUY1b0l4ZDJmSUFQS2Ra?=
 =?utf-8?B?KzVocWpFRnBvWmZ5L0NCZzhVSXhqL1FqbVMvY3B4RlhnVkhHdG5VSnpZeDR6?=
 =?utf-8?B?Z0xBTXdZWkpva1hSb2dDQzM1OFFoei9UYk91U2NpSWZkMHNTSWROVXMyN0VU?=
 =?utf-8?B?VCtqck9rMUJma2x0T1VKdFdFTWZzY0l5M3hrMGR0bWZ0QmQyR3VtU1F4cjlj?=
 =?utf-8?B?YmlENE9xdjM0K1lpRWpCdGtYU0dXR2RJWWlKakl3TzZCejliOEFRcXRxQzla?=
 =?utf-8?B?eGJiUmJDQWhwVzhBcTJIeVY4dTI0cVU5ZHhGcmQ0QTg1akV1SVluSXc2emV5?=
 =?utf-8?B?VEFDRHNXbXpRaUNtZFpyd2NVcUh1M3J0UjJCS0c4SWw1eTlTVk9jY0lvQjFD?=
 =?utf-8?B?WTV2WGVibHhRZTdDTVFVQWZYMktzZWQ1cy9sdmF1aDdoK0Z3NHRtcnp6YUcx?=
 =?utf-8?B?TVp3UlBJOVdCZjVuS2FrbjJFUE1YQkJRcEovNlM4L0YvZDFydnh0OW5LWjJo?=
 =?utf-8?B?dUlBVnpDcUwxYU5JcWVoT2tqR3RTQ08zU3d1TVJ3ZmJaS1JhS0RmeC91dHZ6?=
 =?utf-8?B?OVB4SGY3NHhPdHpDVG9hQXB1K3lPczFXTkNOWXM2ajRZM1I1M1RtTU1jRWhB?=
 =?utf-8?B?cEJpRVM3Tm40MGdlQXJhV2hnbVZzTlFYZUxldytydlc3YnlZNENqMjQ3T01q?=
 =?utf-8?Q?Wa8lM4jI6xY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnh5MUNDa3BQejQwdUhPZmZsS1A0L2ppN3hoV2lvMVpKNVhrVGxTY1Q0RHUz?=
 =?utf-8?B?RURCNUU3bDJhV3psU09nb3l1bEZpU2RDdTBybnJsbncxbmJPVlRMbEJaMTMy?=
 =?utf-8?B?c3V2eVVERnUzdFh6bDZBY2FlNWdIYVpNRVM5VDNHQWlsbGQzNFppVmtPOGxW?=
 =?utf-8?B?R2Y0L050VnJxSlVVT0RYTHRBSGxoWW9veUpMOStjak1pVTZZV2lOYzdDNEtm?=
 =?utf-8?B?SUR1K2FDWjcvRktJS0FuNmNSKzFHTnN2V25MR1hDdTVoc0gyakNJQU1uNkNy?=
 =?utf-8?B?Y3lGVW1DdVRZRkNURGc4VzBueElNNVRNVnMxdzk0WnFVQlVScjlzQ3doQnA2?=
 =?utf-8?B?bllyRDVUYi9iVTdndTNoQkQ4RjQ3eUNPeE45VXc4WmZlYmJKd0tST3VrRnBM?=
 =?utf-8?B?N1hXUitwTWlyYlMyaitDc21ncEIvWGZlYUtOaVFyN1Y2VmFPS29DYnlFWm9I?=
 =?utf-8?B?OGRyTldLM0hTSWt1UlEyT1hac3JQT1hYL2FNc1J2cVMxaUxMMjZDTGRldEJ6?=
 =?utf-8?B?YmdJYnZEZW9SSTAxV1c4R01HdFE3SlFWQ0Q5T3JnaEtZQjViK29vSmFYL0Jn?=
 =?utf-8?B?ZzBaYUExdWRVNUxFZU9OZ3B4MjBTM0F6eHZybXlTakhrZndHc21pck1OWmMx?=
 =?utf-8?B?aTJYQ2I2bGNuZlVYR0NOWFZJSmVVaFdIMTMwaGpVTTlCSS81aTdodnViMG5a?=
 =?utf-8?B?WmlwU0p0RE5WSk1tbVc0ajJCSC9PQWRlT2Q3WXpHM0RvUEl1TkxYUXJkejU3?=
 =?utf-8?B?V1lFSWRINC9pcmk2UjJ6QWFBOEx3UTdQRWdxQVFyejJid0FUNy92ZUhXS1lm?=
 =?utf-8?B?UTNTOUdGc0wvZ0thaHByc1BLdlF3WlN2aTR6NU1lYUZyaG5GYm4rdEhpU09q?=
 =?utf-8?B?ajJIYjc5YkZxbzdGMyswaE9ZckRqbkxpaGZLU1JLeGUxSXV2U0IwdkFQeXhN?=
 =?utf-8?B?YVFLRjQyKzhSNHU1WU1FWnZ3OWJRcmJSZGpRYlFaSml4WlJYYlBrRVFGYWFZ?=
 =?utf-8?B?WWtCMUcwL0loRkVYeHhGUFR1SzdnK0l5SGZRemcxdEJHcWpBVDY0NnFLZWR2?=
 =?utf-8?B?T3p5UGduZUFHSFcrUzg4UnR2aXh6MVBodjhVUzd3clhXa1JNU1l5SU11cWZU?=
 =?utf-8?B?RGhoZVNWaFRNSmh1d0p0L3ZEaGFnYitETkhNTDJIdEVrMXlwQ29WaW1vQkpQ?=
 =?utf-8?B?ZTlrcnRUSVF3b3R5NnVBeWRrUysrSVBiOWVBRi9tTGt1OWFKMnZlOHRkczQ2?=
 =?utf-8?B?c2U0bnZ0TmZtTHYyRTAwY3g0MTlDdWlnaXUwMWprc0dzODBJWWR6V09WOGZX?=
 =?utf-8?B?MmFPTzZrdDZQZ2hxYkpxcy9USDFZT2hZRWY4a3ZidnEzM3FSTk04eEhLTXp0?=
 =?utf-8?B?cjlCYndZSCt3WEYwTERoRWovTTExajhrZVpEWFYxUXZxRFFZRlRQVUIrUEtw?=
 =?utf-8?B?ZG5kQUUvdXdBdWxMc3Y2aVVXRWdLVzRGOU54OHdSRi9TdGhsRnBGL0NtcVdO?=
 =?utf-8?B?elVtbWI3RmtEZHl3ZjJnaHpHd0xobnhOVzVSZ1pKaDUyRTNlenRnYWZLWkNO?=
 =?utf-8?B?L3BVMUtNcG81aVExNEJMa2d2QjRwYjJabWMxZEs4OHo1blpINmRudWc2QkdC?=
 =?utf-8?B?SWQrTm9vdGRyZzBsTVBqTDllWTFIMlFJVWY0WjNpaXFKWHBEcU5GVGtKNm1a?=
 =?utf-8?B?Q20vSkVuanNtN0FOUzQzV1V2SW1mMklhc1FiUDBBZjBUejZCaWRKOFlwUmxT?=
 =?utf-8?B?VWtacGF4OUxrWnJsL1pLNTZ3WjNNZ0NyUy9JV29EMjdGZnZPdFg2R2lLMXFI?=
 =?utf-8?B?NWgvVnpGT1VmZHpqd0QwdTVwd08xdDhlNWRTTlJJUVoyWVJQbE1YWGNCY0xQ?=
 =?utf-8?B?RnNtd0R4THNkZ24rQTZDVlY0WGQ1Mm1RMFcvd0Fsa0EyUVprT1F5VkhxRGJi?=
 =?utf-8?B?L3JpZzhMYWV4ZDJZbTlhaHd5OUdGN3BLaU5DcHJyOUc1SGlFMFNld1R5QTI3?=
 =?utf-8?B?YnhNY0xReDBvUW1uZ2VBUkpieHc0UjdWQkY3RENaaGsxZ1kvK1JLZmlXbjVE?=
 =?utf-8?B?ZHl2alM4TzBXUTg2YXR6QndLeVo4TUgyeHR3alQ5U0IvQlZJVmxMdXpYcUg2?=
 =?utf-8?Q?7rrU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221c84d3-10a6-41e0-745a-08dc9f70b474
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:09:19.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDZ1mAkKSZLWiDNQ7YM3Rzs/l8doutK2dBFWlZGHZldGsa6771W0Dpm9X1C+0aGmFVJ+FItQ3zbDYU1vwuD6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

From: Richard Zhu <hongxing.zhu@nxp.com>

Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
the controller resembles that of iMX8MP, the PHY differs significantly.
Notably, there's a distinction between PCI bus addresses and CPU addresses.

Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
address conversion according to "ranges" property.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c72c7a0b0e02d..4e029d1c284e8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -66,6 +66,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -81,6 +82,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -1015,6 +1017,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	offset = entry->offset;
+
+	return (cpu_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1023,6 +1041,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1452,6 +1471,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
+			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
+				dw_pcie_host_deinit(&pci->pp);
+				return dev_err_probe(dev, -ENODEV, "DTS Miss PCI memory range");
+			}
+		}
+
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
@@ -1476,6 +1502,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1579,6 +1606,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES,
@@ -1656,6 +1690,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1


