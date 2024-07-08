Return-Path: <bpf+bounces-34099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E508992A7DF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB39281861
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A431149DEE;
	Mon,  8 Jul 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktxsFH2f"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1B1487F6;
	Mon,  8 Jul 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458510; cv=fail; b=lYlGKT1aWl5X57V1E1mZQxsYWyMNPM9xcQIekc5vxtmUNWadP5/FLZoIriEffqe9c9HpAS/0G9/TlsDL0AX/iSYU8G5MG6OnfxnvO44LBSKjIxomNloR4nhXbsma0aZXRWQVEMy0OE83/YZAV9RpgC15OLwdBUuyFJou4WrjWhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458510; c=relaxed/simple;
	bh=oJdpnvFrwzNO20vBsTXtf1b6RdeVWZxj8gmAXLfTPjo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bZiaCTVZk+xOKBhmbP5l1aPnRQB20j60TVZpb9uOm5/El2IzdvdPUfmjbMxHSKP3MzptzCpC6U/L0l0vxPE718yFBLPj/pb+q5wwGJIPSJFppGIt0r3mYvmHK56/RKcmPWko4HOOsjKzduz8aET4Hr3TtkFSTQUz8KU5SFpq4Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ktxsFH2f; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc2BudVVbFnpAhm4RXcW8q4nKWAI8cxb/8gCHQLFhiNOIX4JlP1ZQct2Sr2ixUwLz3DnoKpKNwVY/N1sYDKm0M33qtrdUI4OV866nhAXSMFHwmKWcR8JwSajZFndAPpUe7OG+ni5hEcgTX9tdXWRnspZnM9DAe2G9u37dORn32GJoYzzfT3T0Kg+5nhk/+Yn6ML27moTyOtaWdGyzqglCcYP/tjH3Pa/oE7Vz9xo0Y48d3F/IrN5BMlP7fc+ZvRTX2wW3jsYdoJ/++idnXPyeSArP/txTwoTtOErWm4tqhxXFMWAexYyRFmaDEHWZwvHWuSvo00c9PVWYv7hPNORfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AHFoolGVa6F/eMqcRtTi3hGdiBLvFPvivikGVbUnL8=;
 b=L65Y/lLCJX9uUz7a/NJQQrvKOLwQNMyIoX8YHIIMA8JaFM+3kfDCyeYEW/0LSUehfQPyK0p2cHAPWpxnVjQ1+DyW9bVhxmQXRo1+/jgGv8d2ITYZ1zIdUVt9ydcbpk3svEiQQ3OrzlzY9YukCwyTHx+HMVRIPAsadP6EYz9nQoIIwVjp/nQLRIczOYXMVUOERkG/ytEQAq2Jbf3FJAsA36aswPBB60qsiT6OC0YaSCCahVk/YhxOp74GmdSRYS8bSeDECGXCOLxv7NDr1vOFVmZ57l0ihUAjjGuL73oPiDK76RTypVA4QVWpssRXM4c41GGgo2WSwp84KFKjaJy/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AHFoolGVa6F/eMqcRtTi3hGdiBLvFPvivikGVbUnL8=;
 b=ktxsFH2f4jTysCb5ciaiSD6IDeGArRPHShgt9V7S/4410IoJ8PE6qjznnANZ8P390t+AurVV0mrC1bdB2S+bwnBxgUb+7M9K2AtyGtim+nCXNYEQQDZ2SoKjX6FOiHw2u5V5mZYPuivIAVfX2jM8SghFwgxmF1e4Ak1RYwbvyd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 00/10] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Mon, 08 Jul 2024 13:08:04 -0400
Message-Id: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPQcjGYC/3XOTW7DIBAF4KtErEs1DL/uqveoogoDbljEtiC1E
 kW+e8fZOHbU5Rvxvced1VRyquzjcGclTbnmoadg3w4snHz/k3iOlBkCKkC0fAwZv3/HeinJnzm
 EGEXjhRZGMjJjSV2+Pvq+jpRPuV6GcnvUT2K5/tc0CQ68bTR2TkppwHz21/E9DGe29Ey4Wglqb
 5Gsj2CDTq2Jxm6tXC0t760k60AqodrYKglbq1ar4eXPimxywUF0lh7sdvWTRbe3mqzV4L1NsXU
 Jt9as1oiXXbPsgkOB0nVN87Q7z/MfPdyn5dQBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=5867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oJdpnvFrwzNO20vBsTXtf1b6RdeVWZxj8gmAXLfTPjo=;
 b=RwfWdQT2Lp0uhLOnkMhSlMJj1IIM7OATlEdLnTlw1uNGhwBjk98gok1HEIrpEcBHIO+KvIeQ4
 qLm6hXKd06lCHNhp7UrjkiV47PuOXHdJIbOwcDbazSsE46SB6gONUeM
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
X-MS-Office365-Filtering-Correlation-Id: 93352382-50cd-486a-8132-08dc9f70933c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzNtakRRU2UwOVNDUy81MHoyT3JES1l5a2NNVVVoNFZGRk81S053ZXMydS9W?=
 =?utf-8?B?ZGk5REpGV2craVFoTmludnk3eHpDUmFHMzhoUFBtTTllc0FmcWw2SlhRaDk5?=
 =?utf-8?B?UGpwQ3hKZlk2azdqVy9ia21FeWtISUxYeHFqaXNIaE03MFdwZ0FlU2hFYkFk?=
 =?utf-8?B?Qm9RU1cvM2pET2FaN2gwTTkyTU95QWhuZC9xRmhKckpqOVB0MWkvK0hDUUJP?=
 =?utf-8?B?azNQV1FyTGp3aXkySEZpbzIwZ0dsUGpWdC9vUFQxQVlLNTFacXhHZXRVOVlq?=
 =?utf-8?B?U2dteWE4T2Z0NUpDY1NISEdDbkNHaUdQdjcrRUpQVTUzNTZtU0hqZnI2KytJ?=
 =?utf-8?B?YjlEam41RFEzNUVIQmU1cExDaHhJMC9mTVZ1OTdpakZLb3BzV092L3RXNzh2?=
 =?utf-8?B?M1h3RmhCZFQ2TzRHSEsxKzBvVEJPSllSUHBONUlCU1Rwa2xTaWsvK2ErWk1F?=
 =?utf-8?B?TW9mdGpuV3RyQUNGQXZyL0dpRWVXTWFZbkFUNW5Ka3RCMExNc0dPbDNJOVJv?=
 =?utf-8?B?R1YxY1NDYURsR2lSbXF3Y1ZXRHJkTGpNR2NGSFRyOUVweFFSSE1meGY3dUtT?=
 =?utf-8?B?Wnl6ZjRqRFpvWGFBLzRDM2tremtZOWM3bTErUWtYbDJTWS8vcU8zbU52WTRV?=
 =?utf-8?B?WFU0NW5wNGVVb3ZGOGhyQUhhanVUajdwT0IzWkdRQXplWTVPOHdJU2UzRUx0?=
 =?utf-8?B?UEdoWDJMbUlpV0ltb2dJdHlxeXVRSC92T1lJZ2s2ODlqeXhzazNFNjhFb01T?=
 =?utf-8?B?d3gzcmRYei9pb1pYS0ZBWlFmaU5ONUF1cUFKMWt2WDBuVi9QbmlvVWh1MjF2?=
 =?utf-8?B?b1VDK0I5aDI5R0ZhbWxqTFJzSXZhTGt3UE1FYmRIVnFDN25mekVlUTVtVkFa?=
 =?utf-8?B?cnZmN1ZiNE5WK0s2SlVYMHJVT1dLWjRKVVIxK0VSWHFuYStiWjBEQUhtc09u?=
 =?utf-8?B?NFdBRldWSTFiOXZBRk40SnBRNEJkUng1Y2xkb3NaNEh3OS95SXdjdytQRE1X?=
 =?utf-8?B?VTdsNEwzbVJncGlVbGNFL2NqQjBpcDczTDlQemhVeS8vbWx2OXBkdjAvc3NK?=
 =?utf-8?B?TkRqMnhWb0Q5MVhPYUYyWlIxVVBmTjJjQ20yaTdzNGNtRHE3Zk1oRTVMOUlW?=
 =?utf-8?B?WVE0ZVR3TG5vMTJsZnUvZ3BINlRIVFdQZ1VoNnBnNGcwNGQwN2hyMjl4NjVT?=
 =?utf-8?B?Nms0WDlNTzc4N3pySTl3OThCVGZWSmp1dmx2NjZKM0FyR3MzOUFaRlVzallq?=
 =?utf-8?B?bURzeUw1S3VmemovYUZTWUZWM3BQUW9sRUtadzBwQjlQLzVFYVJFOEhoWjB1?=
 =?utf-8?B?VFBXU2d6K0dSazJxcGdLNnA3SWlqTDJLRjY3T1Vpd1F4eEk5UFJxNDZvdE95?=
 =?utf-8?B?dk9JaWp3ZG5JTWdDN2ZYdk95eEgxdFpMQ3ZUZHBFL3dReUtCaWZsSEp5VEVJ?=
 =?utf-8?B?cTg5QTNMMWlKemNNN1JmTmRNNzVwamFpdy9UTjdZenlVa3dJQjVNbzQrcTZo?=
 =?utf-8?B?NUpESzRxY0s1WlBCd2pKY3Z5SmcvSytHR0w4MHJSQkQ3cHA1bVFkOXFMR01D?=
 =?utf-8?B?SlBIV1RMUlhvdk1FUS9wMG5TM2duZVFVc2VvSGFOczZHNUZYMjlyd3hrUlRO?=
 =?utf-8?B?d2k4b0RKKzM4NHcrQXRHTXV6cEJJa21FdHF1YmgwSWZRQjVSQmszcjJaaitK?=
 =?utf-8?B?TUd2L2tScXJkd0w1d3RBZ2xZVk5uOWlPZFg3M0xCeDlxZ3VmU3puWkhFd3Rk?=
 =?utf-8?B?U3p1THFub3NyMVJ3eFpyNzMyM1JvRG5raVRhRXc4NkxkNExhRnhuOFFXU29Z?=
 =?utf-8?B?VXBlcnZCeEczVVRkZ2FXTDVJUHpzaEJZeUFOUUVZWHNuSkwzeVlOS2hnQTBw?=
 =?utf-8?Q?WYySVakkJlzS2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC84U3lUcmRpbDlUNzl1azYvVUI3SmRKeXZXRmtYVkZWS0Y1eUlGWDltdFVk?=
 =?utf-8?B?N0VnSllZNnc5Y0ZsaGNJTHk3YjEwdTZtTXk3RnBhOGpGZHBWMVJxc3ArRlFx?=
 =?utf-8?B?SDNtNEQwOFo3bGVxYThMMG5Cb0M1R1ZlQndSSWd5dFlPY29sSm1DV2dZWFN1?=
 =?utf-8?B?OEhwYWJJbTdpSGtLZlhuMkxDQy9QcGprWitUbUZJV2o1amp5WituamNGd2ZY?=
 =?utf-8?B?eFJJdEhCMGZEQUYydjhYTytRcnlTTm0rdTJlR01BeXRIeitQVlRUTU04cTY1?=
 =?utf-8?B?Ymh2LzZRV0FieUtjQ0V4NjhDMmJNN3RaV05QZXk1VnpvOU9Wbyt1anJUWU1a?=
 =?utf-8?B?Z1FPL0JvOTJEd3RIc1VKK29xU0w1amtlaXlhQWJFQVV5RzdpY3l6TXo2Rmo1?=
 =?utf-8?B?dEZCWlNmeGlUcEZwaGtFcWVaaitYU0hsYjc5Mk9rNmlvakNBREdKRWMzRnZI?=
 =?utf-8?B?ZVd0Z3VIbTVjY3p2c1R2b2ZtQ2pxUzhjSXlCd0RPckc4d09ZL2tVMGtDdnlZ?=
 =?utf-8?B?YnlaNDNCL2Zqc28yR2c0anVHK1J2blBvRXZZeXNNeDhMN0NXNlRmbmo3RHpZ?=
 =?utf-8?B?S3hEb292MFdaSlRqQXhyOFRCK1VnYlZUd1JFc0N6QmRmYzQ1ZHVsUlBlczU5?=
 =?utf-8?B?Y1h2aHNsQzI2MmdnbysxTllpY3pBNE5FeG1CMEF3WlFCNWtERXF2UlMvRjVT?=
 =?utf-8?B?cTdqNmIzd2tEb1VyeXBlTFRaVUpsMzRuUWVUS2hHNkMzNnJ2OVhBRHRLVnZu?=
 =?utf-8?B?VkNONXdPQmI2ay82cVZ2VjJqY3Ywd2NVcjRHMnA5aXA1STlmakNqNG1WcC9G?=
 =?utf-8?B?SWwyMU9tWjZuRnk5VFpPQ2VkU3VkMlRnTWRYRmVxMWIxbFFSRHhnTnowU2po?=
 =?utf-8?B?ZXJTdG1nQXNPdzdubTZ2LzRJUFdVL2lmNjZiczF2QUtuSlMvaTlwRU1yM3Z3?=
 =?utf-8?B?SEo0YjQ4c0VjNjV0d09rUVQwcEx6WmxSNkxIanI3Z1ptUS9yRG9tWE1KRHNs?=
 =?utf-8?B?N0tRcThJMllSZWJQQzN5Si9GTmNLQ3Q1OUIrTnhCTWJsbnQ0cExyOTZSOG1i?=
 =?utf-8?B?cUlub2svVk9EenVhNUVtYWdsVnh4c2RkQmVZUFd5eFFOa2pPSGNSVUo4RjVn?=
 =?utf-8?B?NnJEUWJnbWFRQ2YrUGxlN1QyUHVQYURqRG9BUzI1TUdhMnhhNENocTVVRXUz?=
 =?utf-8?B?TFo0ZnFrcnF1c0l1cFQxbXN2UTNqcnhyT2twVFBFYnA0WjBCUk1hNElmdFJT?=
 =?utf-8?B?ZEUxUllaUDFDV3pPV2UvcjhISWtnWDM2dGNYVXFFSjVaRFlnei9HSi9iSGIx?=
 =?utf-8?B?R3J0N2xUdVFSTVBHcHUzMk41Q0VtaE9TaGNBbnM4Y05DM2daQVRxQ3lZTHln?=
 =?utf-8?B?dVQ2amVpaVQ4dWtpUFZNcU9Xc0gxNnhodFpGeUI4NGZUdVJKa3paRzhlMTdZ?=
 =?utf-8?B?UE1xNE5DaU1EbVJxaVZxellnNHlFTGJsbjlYejRCV1UzN1JNdzB3SGdFVnE0?=
 =?utf-8?B?MktmOHNlOUtZT01DVCs3enlTUDdKL2JGR2U1U3BuQ3JnOUNQWFBxQWtWY3A1?=
 =?utf-8?B?L2RXT0xMRmc5YklaMWhGOGZKOUFpM2lZdmVXUXc2ODRkeVBDNHhYSTFUaHB5?=
 =?utf-8?B?Umk0VzE5MGYrWEl6M2FLaCtNZlVmSnhGM0tBTTRnSEpHTVJuVFZrSUg0RUhy?=
 =?utf-8?B?RFp5TURINjZGRUhic0xJa3NyN0l1RlFuTmliekZPZWNmWmNQZnJzV05wRVRo?=
 =?utf-8?B?dUVjZ1UvQ2RBMm5CYStFc0kwMmk3Sk1ZTUVEa1NkK1A3WDU3VnRtcEtEUWNG?=
 =?utf-8?B?ZVRhREo5Wk82TG10ejM1dHFOVnRMdldXdEg0VHIvQWw5UjF3UFl2V0s3bUY5?=
 =?utf-8?B?WTZSQzZ3VjBOVDg5QzVjSm5BOW9HUjVmSWpzcTlqb0E1R1pyUHNkN05xZFlI?=
 =?utf-8?B?STF1WmRDQzYxNXdubmJEbWpscDdOYXBuN1ZwbGZXWTN4VVgvVkxJV1BtZ0s2?=
 =?utf-8?B?MGw0eGJkQ3B2emtqay9TREhEN0tEVU8rV1BPbjdvTVZVQ3hYeEVUN1AyQXg1?=
 =?utf-8?B?clYyamt5WTAzNVdSMERJV21lWTlUT0k4ekg3K2V5MzkvYkFGVFlUNjd5ekFU?=
 =?utf-8?Q?cNRk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93352382-50cd-486a-8132-08dc9f70933c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:23.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pBAbaaNQT7Rc3vDefr605EshAiqQOXwMZ5DerBEysLa9CfOYdnEFIn/PabIjBGKaDyGCvnYNqVth8H0D3+jFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

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

Changes in v7:
- rework commit message for PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI 
- Add Mani's review tags for patch 1, 5
- Fix errata number in commit message for patch 6
- replace set_ref_clk with enable_ref_clk in patch 4
- using regmap_set(clear)_bits in patch 4
- Use exactly the same logic with original code at patch 4
- Add errata doc link for patch 6
- Fix miss "." at comment form patch 6.
- order include header for patch 9
- use cap register to set_speed for patch 9
- use PCIe in error msg for patch 9
- Remove reduntant ':' at patch 9' subject.
- Change range to ranges for patch 10.
- Change error code to -ENODEV for patch 10.
- Link to v6: https://lore.kernel.org/r/20240617-pci2_upstream-v6-0-e0821238f997@nxp.com

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
      PCI: imx6: Call common PHY API to set mode, speed, and submode

Richard Zhu (4):
      PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe root complex (RC) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
 drivers/pci/controller/dwc/pci-imx6.c              | 1005 +++++++++++---------
 2 files changed, 553 insertions(+), 468 deletions(-)
---
base-commit: 48f0407456e4e68319a5cfcf409ceb57902acc54
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>


