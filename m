Return-Path: <bpf+bounces-30777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2438D24F8
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA71D1F270E7
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6317DE25;
	Tue, 28 May 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oB7fY5JN"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1117DE1D;
	Tue, 28 May 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925217; cv=fail; b=l3z+ByZ3IuznMADsbvigLUDRkntUmSjpGJat4kaJwBkaKUSR1114jVeLd57+9qh8paevEWKJjLVbTpjCc7Ywmu/n1f7bFYo/OJDnW2vJkQfvfYf6hoe1LIPKHhxfAiCMZBiqHHUkfYlFwdXtkJWntFf/XtKZy2dsOT0B+GEk2CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925217; c=relaxed/simple;
	bh=4Z/jtzADCobosRpqG+x9r9Q2NIoYvwiipmKvOkgwitM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WIVnJaXd6ta4/f56R8qGSJmWnOR7ryeXFU0onvGQfsZxnQMM4Nc3MqaSbALNqoCt/BHgEhCdax8fXtLmvvr+fxGwqbr+JDd/nXLLom9ENuHtRl55p6A6Cg9HSo3citDRCYsjOFG3UYVoV31ME+tosv1tnSyKepNLyRSCKU7AkdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oB7fY5JN; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPXUT/xRc0h1/t7ttkGLbqLTT8LRTXClCk2/tKwgZpeMHdUbNejLSvKInY1i7yf8ERe1a4Lx1sPyZU3GNwX5NeTkkRWveXlFPqZuQck5mYrbvRS+z+5GzgNs5Z7SWuqujiNNYQCeYjmGMuLWI4f5QeY8KBs4B4011NEbYaL1UrjYjHfc5r3bQ3vbHQaKthzMFaRZMq2OKQQQ16rVwE6XtismIqjoM/korCE/B0BXT7aOUva5fHseeyMThJ7ydvR+KMi8zqFspHw5veJgddYkkkuGxyD5WQ5IuqKZlPdXYN/q5EONZ/7a/AZT5L76I862RED6TmMNRJP05pv+e5j08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0JhgvnJpQxFaI/hR2haZinhHcelur0CB3uuFQTrWMo=;
 b=MX4IQ9VzlS80z7F65OoeFbTuFm2MBUxsthcewPizKWXnreJqEMEGasQY2MWKlzyeG1mowrNu2kCDBFANxnIuFC4aKbTq6WOmrB6Vhpf6xWZnPJdGfDOQUkjgwFruAbpGVEr1xMySxzkqnztMD1IAFRqCz8KQiI7d1rxry6p05pWHz2yiy2XOPY31P7/up7XjaIXZS8kw0wUg2AkbhOjNMPXONpVGG9dqNU8stogAOyjKu2wqWKaFSLkNH76XA1R1vrSo7auIXK3fmfr47UtFBuIw1/HcQWxpR0Vwv/Bz8aOab+e34nJ/DTvJIWCDqC7VLzE0wP+4sFzXRzfNXVFNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0JhgvnJpQxFaI/hR2haZinhHcelur0CB3uuFQTrWMo=;
 b=oB7fY5JNi3arscSxLQbuJRByo9SV7aa+ThY7HunkikX4aOKQlOhOmMNZfN0fU4brOlcj48IMJqcFa2RykA3UiwKCl7zDDiCKieRLTPiSgjK7/JniMWOLjpOl+oDLaP8gNLpu0b90ROPE4gboTmLCZANeyhzCjj6sHD7vKt97dJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:21 -0400
Subject: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=7874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4Z/jtzADCobosRpqG+x9r9Q2NIoYvwiipmKvOkgwitM=;
 b=Uw1Wl9+TsOatrqdwWVMpCTuvwQFy14QL1sJI/Y5TfyZYNjtnTkAM5o3ieXFJ2yYm7A5nZQkBs
 FbQEY7sl2TFAcNNWXvK2HHt7Etau0Cqaw2HrquN+U6VqLGeuYhowsz3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: c085ab92-9185-4cb9-5490-08dc7f4dfdb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjhRZEVuaG5rQTRLSHk0M0MyKzlTUDNMbmNVblV4RFphN1F0M3c1amsybzVo?=
 =?utf-8?B?MU5QQi92cTgrMlhXdHhXTnhVSWp4OHczbXQzeVdRUjZ3Tk00YmxRLzlTNGd4?=
 =?utf-8?B?dGZMbnNkeGhFNW5FZFI3YUl0NllGTWZPalExcFpSSFoydlhRdzhTQjdKeWp2?=
 =?utf-8?B?M0p5cDJkL1VWdmVudEVheGJGekpvdk9GVzNxWHdEc3E3YjM0WXYzUlVGOWV6?=
 =?utf-8?B?YjVVWHVvYmIzQVVXTVdxT1dVNHFjcWRJZngvcUVuaURtL0tzK24weXprbEhK?=
 =?utf-8?B?NlFnMEh1TU40d1VhNEhtMWhWejFvdld6cWlTQlFRMnhGTzhNZXNWcEI1NWZI?=
 =?utf-8?B?R1o4ZVhFOUI4c1NYdG9LQWo5MkFIUG1YN0FKd201L2w2dkpCalljZVo1Mkdy?=
 =?utf-8?B?OHVzTER0YjBRT0RlRkIrWnYxT29XZ09HZjRGbHRNeTdQR2VxbnQ1RjlsUElV?=
 =?utf-8?B?WjBmU0duSDVtN3FDRGpHUkNBNTZHN1lYRHNiR29jRFIzVnp3SWk3TzdQaEdD?=
 =?utf-8?B?YWxQWTcyeEJMdHZnTjRobDhURTBmZTNjY1U0cTdWNmdPdUlGcDlyV3RlemhH?=
 =?utf-8?B?ZzVRNXRXRFZqQzZMek9xbGx2OEx1MWJSYlRsU0dRTmhzTk1nTk95WlRDWk5h?=
 =?utf-8?B?a0R1TzdSb1lFRlA3SGdJclB1Vm1BOFVhem04eDNTVjBwZUJ5Rm44T0txdDVW?=
 =?utf-8?B?d3cwWFZjbzIxMmo0bGd4YnFhcGNUWEplK1dSbUFzWmRhRkc1SWZoMy9IZjRa?=
 =?utf-8?B?UVBPNDdzNWFLNm5wYzJhSkNKSkdYR2dYNW04b1hZK2k4dTdhT1UwOHB3QkxR?=
 =?utf-8?B?UHJxTTZpclhsTktNZ2t3T2JHYW1WaHZlQzVSK3lOc0hQaVdITWxvazFtRXVa?=
 =?utf-8?B?cjREeXlUY0FYSWZUeUZvb1R2WllkVHkvdnNqMStTQU5iSzZwQ280MHFBbUJh?=
 =?utf-8?B?cFZubVZRYVVoQUdWRmN3cjlKZjhOY1FvNUVWWmp6SWJwZEVmN3p6SEhtdnR6?=
 =?utf-8?B?eld6eGZmK3pJcUhNZzJGTVBNelRXa3NDcTUzdXRjN254RnBSbHphSStaQWJ1?=
 =?utf-8?B?OU1UVG13SFJCR29wNWlBMERBUUZJTERWNVNTNEZ5WnR1bVEwL0dZM1BDaWNQ?=
 =?utf-8?B?akZZNWtBZStCU0xhN2VBbWtUQzFEd3psampCVEtCWGdscjFyb0V2aktSRWxY?=
 =?utf-8?B?OHNwNDdwenZqZ1BCb0NEMUYwcUhLOGJRd3hkWENyVFdaZDVKREZJM3ZzNDZy?=
 =?utf-8?B?R2pBTFdLWjVwNFErZXltcFhTQW16UTdDSzBZcVNTVEZrQzd3N3NUQWIyWmVi?=
 =?utf-8?B?SlNxYUxWZVFWN0duMkZaMDQxU1lzVlh3cEx2N1FGcjRXeFpsRzZQbG5IVU1p?=
 =?utf-8?B?d0wrNTdPNTR3THA0KzRKQnpmWmh2UFFvZmc1OXZEODlNSkc5MkQ0KzNUNlpu?=
 =?utf-8?B?alB6VFNVSEs0Z1lUc1FpeUwyWXhiZER6OFNWcTFydCtLRk8wTk1TR0pYQ29C?=
 =?utf-8?B?ME4xeXZ1UVJvWlhQWlJQR2lIb1RkMkJVRGh5eXdhQnhpUTNoMEhLUkc5Yjd5?=
 =?utf-8?B?UkhTQzN3VFE1WmlKT0V3Kzh3ZERCakR6azZYSXZqampjbzdrUWs5TG1LVVZr?=
 =?utf-8?B?R0xiQ29OWFlmQjcvQmtOUUFMYmVPazB3SmZtOFZtY3pnUzVhMjFaVWFnY2tM?=
 =?utf-8?B?akoyNm8zK1VvMGhUaEdub25OS0xPSlBYbDlVWmpQVWhpbDRNUXNDS0Z4VUZm?=
 =?utf-8?B?NXVpUFc3eWZQYWVvMTNqRGxSaW1HazEyaTRJRllXYmhQNk94OGdEN0VxQlNY?=
 =?utf-8?Q?Qq+k8HzINu24GLcOkbehU1rH3B2/PU7BqjEWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVUMFZJNzRjekpyS1lXOXFKMHBlZmRrQ2pKM3V6YjNrVjdPS1FtMUpUMXR2?=
 =?utf-8?B?RUVyeGQ0TmJlODY4QmFzdkx5THd2SnBNWDJsbEtjcTBNajdvS0JWTTdPci91?=
 =?utf-8?B?dHpHa05oMitVaGVMdmpYbmlYZGs0SEtSVGVwN2E4V3ZPMGk1bnFYMzdKZDgr?=
 =?utf-8?B?aThuSk12VlM5YTR4V0hMNDVHOU1FZVdIUHZpSjFQV2NneTVJV0FlZjFtTHVB?=
 =?utf-8?B?aERQVlVPVVVFa2Rzc0VIblVwWGhsNFlCZ3FSN1NtK01qSFpuMVlUSVYxNE85?=
 =?utf-8?B?OFlKcjg3d0xRT3o0ai9oZkJXNzJUOVlXQ1lWTithRDRCb3ROSjZXSXBoTm5z?=
 =?utf-8?B?ZzFSenZFbEN6WWxMUC9DdmE4WkIxTUF4RDhNa0VnSHg0MGxrK1k1WG9ncEVh?=
 =?utf-8?B?YzNUZ2RLb3lYdVRRU0xCV3JubGUvb0VxeitpK2RrWm8vNTNrZWtXbGhhdVFS?=
 =?utf-8?B?SlI3enUvTkxwZmtOd0V2ZEQwR2VWTTFESVNCWWZoenk4QTgvWVRVUkZzU01P?=
 =?utf-8?B?dWpXeU5ORSs1UmRlYUJkQjZkRlFlNVpaT0pxb3FjQ3cwZFhnWVlmR043OVBS?=
 =?utf-8?B?ekFMekNpWi8rM2RmcEw5T2Z2aXVSS3gwYXRldnMxUVVDcDl1TXEydFNQVzFU?=
 =?utf-8?B?ZGNyVWRkWjBHTU05SnNIUTc5YUJvOUkybHVpN3ZERkpZNWl6WEo4ZTJ0ZkJ1?=
 =?utf-8?B?QkFMTHdJWmhoZUVBckRvdEFTMTlvbGZoS3pKUk56UEhTbXVBNzRteElGSkYx?=
 =?utf-8?B?VHM5SzVJZ2xoRUJXcUtobFJjUkhRY1FOS2R1TUxPVmhxNTJSY0JyZHdIM3BY?=
 =?utf-8?B?MFg4VHBEV3VVZk5nbk9tNnVka1ZKVWhiWk5YU2RiNjRMUHhodnUvdEVUd0FR?=
 =?utf-8?B?OHF3Y2dpSEZKdjhtemZZODdYQ3E5eHRIT1JvelUvdUhSMDhPNGpTQ3paM29r?=
 =?utf-8?B?Mzhva0NYRlB5NUIycWpyZXpLTFZvUGw3Q21tTGkwd3ZBY1FSYklWMGtvakx4?=
 =?utf-8?B?T2M1WXYyQ1EwZXBibHVrTXN4U0pydisrT1NJNGJGNTlJYlBPaE40Zms5eVNC?=
 =?utf-8?B?NlNvVUlrYXNwWmE2bVVZODc2MzA5elhPOXo3dTJDRi9IeS9yZXkxYUMwTEx5?=
 =?utf-8?B?aFV0blFjSTNIQzlaVU1XZHlrZjdQNXpLd20vMzR4RXlIc1h6U0tmV2srMVM0?=
 =?utf-8?B?NEFSc1VIZVJZMXFDT2x2R3JWT256elhDOHR2Y1dqbkc4L3hYM3VxZEd4Y1JT?=
 =?utf-8?B?RG51ZGs3ZVFRZHZnUlQzRlNxSGF2L2V3VTdKRis2VlJHN3F2NXRKa2tUV3VL?=
 =?utf-8?B?WlJuOVRqaGhOeDkvbmFDckM5ODBlNjlLbVMrcThrQ3hzWHlBSFpKN2VtQjZP?=
 =?utf-8?B?UlErc2F5NjBKQklQaE1tQTRQaXlUV1dkKy9jdTlZdjNoWEtRRkZxL0sxMzlw?=
 =?utf-8?B?cFNYSmVaaGVWKzNSL0t5R1NRcC8vdlR6WHh6ZHJwd25SY2dXQzlUN2FaVmNh?=
 =?utf-8?B?LzVKWmZ5TUp6UFFDdGt4VllLMTQ2UGh4VThxM1VjUkZoWHgzMENIZ3F5d2NK?=
 =?utf-8?B?Rk0va1JtUmFTdFpNb1RoeDV6TVF3Zm81YUdEMTdoazQzWmQ5bjFKMzhMUnZC?=
 =?utf-8?B?TXdMdGkvUVhEZWpxSjdEWHI4ank0ZmlYQ2h6M1hrY2NzSHRlNEN1MDRwcEJT?=
 =?utf-8?B?Z1d2ZFVFdytkY0dUOGlYMHNLYkF6SkZCcHlHbDc1RFRhdHE3a09jdEpocWJT?=
 =?utf-8?B?Q0JMQnFJamEwTUNubGJROTVZaUgzbFQvMDNybjdqRG5TZWhhK2tzNzBERFBj?=
 =?utf-8?B?U2J3eW00Z3lLdzNGQUJFeVM1b2liMjdrMWdhM2QxbUt2NHNaSVFqd2RHWDMr?=
 =?utf-8?B?MGRJSEI0WHdxbFUwaHhyWVUzelc4UUoxeU0wM3pReXNTTEhnUzZXci84MlVC?=
 =?utf-8?B?VVllbTRIRFRvdktacExDcGNKQTZDL2RPQlpWWUZxa0JURWFUeGlHdVlsa2JK?=
 =?utf-8?B?WTI3Z0xzUGhKcGlubCtLZk9hazBrbTNhNlZEZTJtL05YK3NzUldLOTV0Mzl0?=
 =?utf-8?B?bFpLaENQMC85V0ZpQ0Zma0dUcm0wZGIwTFJEaUVteERXRGtIR0RBTC85TVh0?=
 =?utf-8?Q?o0QQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c085ab92-9185-4cb9-5490-08dc7f4dfdb0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:12.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcJ/MdDzbLU+Tn575ABpigb21tACcs7Ivp+0n2L5iBg+bOJOoWrqEpcwjXFDwNB5fvtpJXAhRRDo7nc1Rjreiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
upon the appearance of a new PCI device and when the bus is an iMX6 PCI
controller. This function configures the correct LUT based on Device Tree
Settings (DTS).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 175 +++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 29309ad0e352b..8ecc00049e20b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -54,6 +54,22 @@
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
@@ -79,6 +95,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -132,6 +149,8 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -215,6 +234,66 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static int imx_pcie_config_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		if (data1 & IMX95_PE0_LUT_VLD)
+			continue;
+
+		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+		data1 |= IMX95_PE0_LUT_VLD;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+		data2 = 0xffff;
+		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+		return 0;
+	}
+
+	dev_err(dev, "All lut already used\n");
+	return -EINVAL;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
+{
+	u32 data2 = 0;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+		}
+	}
+}
+
 static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
@@ -1232,6 +1311,85 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static bool imx_pcie_match_device(struct pci_bus *bus);
+
+static int imx_pcie_add_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
+{
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct device *dev = imx_pcie->pci->dev;
+	int err;
+
+	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
+	if (err)
+		return err;
+
+	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
+	if (err)
+		return err;
+
+	if (sid_i != rid && sid_m != rid)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
+			return -EINVAL;
+		}
+
+	/* if iommu-map is not existed then use msi-map's stream id*/
+	if (sid_i == rid)
+		sid_i = sid_m;
+
+	sid_i &= IMX95_SID_MASK;
+
+	if (sid_i != rid)
+		return imx_pcie_config_lut(imx_pcie, rid, sid_i);
+
+	/* Use dwc built-in MSI controller */
+	return 0;
+}
+
+static void imx_pcie_del_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
+{
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
+
+static int imx_pcie_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct pci_host_bridge *host;
+	struct imx_pcie *imx_pcie;
+	struct pci_dev *pdev;
+	int err;
+
+	pdev = to_pci_dev(data);
+	host = pci_find_host_bridge(pdev->bus);
+
+	if (!imx_pcie_match_device(host->bus))
+		return NOTIFY_OK;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(host->sysdata));
+
+	if (!imx_check_flag(imx_pcie, IMX_PCIE_FLAG_MONITOR_DEV))
+		return NOTIFY_OK;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		err = imx_pcie_add_device(imx_pcie, pdev);
+		if (err)
+			return notifier_from_errno(err);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		imx_pcie_del_device(imx_pcie, pdev);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imx_pcie_nb = {
+	.notifier_call = imx_pcie_bus_notifier,
+};
+
 static const struct dev_pm_ops imx_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
 				  imx_pcie_resume_noirq)
@@ -1264,6 +1422,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1551,7 +1711,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_MONITOR_DEV,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1687,6 +1848,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 
 static int __init imx_pcie_init(void)
 {
+	int ret;
+
 #ifdef CONFIG_ARM
 	struct device_node *np;
 
@@ -1705,7 +1868,17 @@ static int __init imx_pcie_init(void)
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
 #endif
+	ret = bus_register_notifier(&pci_bus_type, &imx_pcie_nb);
+	if (ret)
+		return ret;
 
 	return platform_driver_register(&imx_pcie_driver);
 }
+
+static void __exit imx_pcie_exit(void)
+{
+	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);
+}
+
 device_initcall(imx_pcie_init);
+__exitcall(imx_pcie_exit);

-- 
2.34.1


