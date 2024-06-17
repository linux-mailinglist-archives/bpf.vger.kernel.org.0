Return-Path: <bpf+bounces-32337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCF90BBE9
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9771F2198F
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB919AA6A;
	Mon, 17 Jun 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e9tRNIIr"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB231990D2;
	Mon, 17 Jun 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655466; cv=fail; b=tXbni97eQGsOVd9XaUfGq9Eg4sogZkC/QB4jlG8rZ4kv22ieQJ8QUnup7BKqD3SyPDqsMorxR8Pa4G3UZRS784EEU6fgV1IY8sqOP/zU+qZ0ms1QSdLh/5oR5sgtMXfbTNj63S+zSeWHU4eYpG9f31YnSRzIY6Cy6aGilJghPOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655466; c=relaxed/simple;
	bh=EnlJL+A6hrb+lx0OJcd5b43KT+ZkB7ImYpV0nsydYlM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KpF+D/m4ejZuc5g6GUIt7HbKHBsVg4x/ID9V3djxIwsfCqTBrpGDeOe6cd0YPTqBapReTkrD61BtK6zGPuKghKKL/5ulDRlGgjscqECUqaJRjh8ty8EvtasllhQOGxNuIFtlsngJ9b9BoNuU7pTXvX3micXMEvQLQjKFWMgZ+aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e9tRNIIr; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8/Wh2ZXYHLbV0dFC3EWXP0D4Zq5zlKHP1PMzAnsLm68kzDYQ3xzmj5r+8Dpt+843a6qMcBDzj5nIZBZGxSg7Og3YMk3SSobtAgc7PbJ3TaulBn7cENaKx6IVq3HY7Y92fZxDZqKX0mXxaIVdIdwwSAqGevpfPiRD9HbVfcEXRcVJPMZSU2JEeoG8Op6F7pGe8LDnqY1EzjNbJ8A9LFFl/O4BFyhQPJmJ/0t5icsDQi+Evqg0SJug03RPMSvxFagnJsNzy4vLqkhaiZj1ZU3Ea3+kconEmKl9l2gQWP0Ug5iFt+VPI527gWp3DfcHENuZWcdlcF/GAYqCO8OIdDLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F78DgbEfTJ1B0b5oIHR7efzIOfShRafZmsPxBTuawY=;
 b=GI4phL2AFzqJZxmOMl2GwxoHTgn8YAw688zPBjPpWRNzloHLkmgwXoCDWg1/KGbFH9iGVDGvCNkc+Z3O8SJkOfFPpgcHpfvl6JElZEWn445xkvkqqG6f6eGKHjAiqODjayczT600SY51tSu3rZi9V3Q8gr8i5dKJ+VAg26ib79k2rShni9xtwCbd3htYYPdPSpvWNsmchgAYlrL0Q//IfWmHz0rmNVsS6vugCUDYp2nBH2aKfm2QNB5V+0znoh+VoslRZSV4rKS4ku3Br+J/mfnSklAdcbvP0TsMGuEzH2vwDBkMMSTQgCmHBMDxlYAApn1BxTT9UTuOF5eu9QeJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F78DgbEfTJ1B0b5oIHR7efzIOfShRafZmsPxBTuawY=;
 b=e9tRNIIr1ff5rzgMZCfGG6tfuMqJ1cY8/OfFkWKc4xUqvR6M/i2YKCKefARpajFz8hbe8/R0vKT92gGW1rguiRgv+Z2jEnY3EXymXNGcI5wAmLkjt+h1Ijb8dpccGKwctTyga0c0L4SUkmxdSQWJFPBkKqROiKQ9oxGj8BWDY7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:41 -0400
Subject: [PATCH v6 05/10] PCI: imx6: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-5-e0821238f997@nxp.com>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=7027;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EnlJL+A6hrb+lx0OJcd5b43KT+ZkB7ImYpV0nsydYlM=;
 b=OIGoZ1KHbNuE5OAwVBmOpVWgR0A2KiKP+p0JiLEqdLDRZoDret84ABeKWUG2I1IXMzA9Easrb
 nnz1ipl1SoSCrueVn4dEvUVGEp1TtMN7C8SLzRxTcZ+oL3MxpZHDKXA
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
X-MS-Office365-Filtering-Correlation-Id: 3af9abbb-5e44-48e2-235b-08dc8f0a8a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tjh3TWthWm1SUXRtWXFEak90bUZWb3BWRkxzdUxDVi80dHZQTHIwVnIvZ3Y2?=
 =?utf-8?B?cVNIdUFVV2ZLTnhKeHVQV1U2bkRtQldXVnpoMXA4NXFDMHRtYXppalY0RUl2?=
 =?utf-8?B?ZnVydVdJUVlrQUZZdWh4N2VWa0YvTkxtQ3QzSERZZDZPekdsL3dsdnB1ZCtY?=
 =?utf-8?B?TXVKOUtxWXVhaWEvNHpzRks0OVRRTHZ5OXNFbHNJWHQyL21EdUY3TElPUXBw?=
 =?utf-8?B?YVo1ZkdZOW1obktqbVNLY25XR1QvUm9qT0RLaXpoT3JGckdkR3dnNDFpaG1P?=
 =?utf-8?B?S2dOUmhzRXJQSHh2WXlMdlowbjV5Qmk2UWlaZGozdDVnbHE5NG1LbHArV05E?=
 =?utf-8?B?WTFWRHhZTmJkRFZ1MDJJYWsvL283LzdneU5YMjU2cFoyRjRPMGZraHZMU1k2?=
 =?utf-8?B?YmFSdTNCNG0raXVBeE5RL0pvbDVLdE1aMkhwUnhKMDF5a045WVhmSmVIMHRw?=
 =?utf-8?B?eUFyWEl0ZEZaZHBET2tmQUlKT2NEWnhiM2p1R1g2elZFd2I2c2tZWFZMcG9W?=
 =?utf-8?B?Rk1uVmsveHdZKzRTTFJrTnlIWk1CNFFhWDBRVEpudkFlTXBlZUUyNzY3K2RX?=
 =?utf-8?B?SDZoeEpub0M2YTVhazZoandqOGoxbjEzNENIZXdmOWNNQ1dqNHA3OEd3WkZp?=
 =?utf-8?B?TUd3UHNmMGdDdzk0dGQ1WWFQQUtOVVhuSmZZSm9aaGZKL2VyMlJrc1BmVUJJ?=
 =?utf-8?B?RVlYOUErNnczYzdLTTVSckFHV0F6enhoVkZuNmx6b2V6eG84NStNRUhTYUk3?=
 =?utf-8?B?cFdnKzJ4MlhyaDNLSVlFeTJVQzl2MVZiTnhqbnJzVHllbkN6Z0pMcHlWajVZ?=
 =?utf-8?B?RUJEQ29SNktzR1lISDJSRWZtUms1RUU2QXRwT0h3QUhER3FNQndTdGEzWDFl?=
 =?utf-8?B?dUZ2WlE2aGg4cWxuSVNGalNWSnhGMk93dlVPYWEzcGhMN0dHbUlrR1ErNDR0?=
 =?utf-8?B?Mlg2a1FNQWQ2R2lCVVhkWmFiU1p0aTZJc2pwUFR4UVlveXBLT2t0YXBYQldY?=
 =?utf-8?B?a0d6Y1luS2J3aVRnTjFuUjJmVmphYVZCa2paeXdQMmRnMTNWS0xzRmVkZk5u?=
 =?utf-8?B?TnBLSDJzZnZVYlVycExSbE9KSkZJbXQ4ZnVidXRxTkc3WlJsTitteVl0YWVv?=
 =?utf-8?B?ckdaNXdUZkljUDd4ZEEzdmEyK2dCUWpPQmVGdXRpNWF0eEdWWVU3QXZ6YUMw?=
 =?utf-8?B?VlE0Ym8veFlwSUhBMkx5YXM3MkdObFJ0VG81alVsaDltU2wyOGhuZS9jcHJC?=
 =?utf-8?B?TzlicmtrWktQMUFQaTlhMU5mK1RtNHVyUzFkOEovSXlMRkZyR0JXNk5DdWJk?=
 =?utf-8?B?UVRSc0tYeFJaNFVqM01SeWVrZkVXK0RCVHNveEdZanhLdUJyOHppaFd2S0pm?=
 =?utf-8?B?cmY4eFNwb0oyK0JBdHBHeG1GWUgvN2V3NVFqdlFNVzVGRW1vTlZnSWlQQk5T?=
 =?utf-8?B?NUpRemdvWTF6alNiYWsvZ1UrbTFob1djd0l1OUJyTDFGNmwzSk1BMEFXWjgr?=
 =?utf-8?B?TEd0TlpWWUM3L0V6VDVFdldSR0lUc2tuRHJmVXVZeVo0a1FsdThQalNFaFpE?=
 =?utf-8?B?ZVJGeFEwMlU0UHpDaEVTbERWQzMxaGE4aW9qTmZXdWQ4L3ZnTVpGSzhNUXAv?=
 =?utf-8?B?MURQczhXbjV1dCtjWDlEbmRCNjV1K1AzTTc2aFVGQUI2VE1sQ2l6cVdxV293?=
 =?utf-8?B?Nkw2RU1zWSswYytrZHljMnFMcTYzTTBHTlhXMVpsYVFlUDZMRkpiNXNpMUJU?=
 =?utf-8?B?Sk9uQVIwbjNxS2drakF5NEVSdC90UmRPZFpCaktxY0gyZWIzUTNIUmMzWDhw?=
 =?utf-8?B?QW9DK283bWY2dysyL3EzR0JMbk02Sms0U1d2VU9IU2NkeGdyRGlreWs4Q3VC?=
 =?utf-8?Q?XDoSKgNi/x0EW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFl0OUhnNTRTUHJjM29ENnRnMkxEWkJOY1dRaGpjSEJIZWJNTUhoWm5vQ2Fi?=
 =?utf-8?B?MUJwQmxLTUtLRzJRckhKanVMbTNnUW0raVNNejh2WjlkT1Y3SXFSNzE4M0F0?=
 =?utf-8?B?REFjbS82bUNSUXZzWmQxTEVDQnh2LzJuT2Vlb0tDMUR0ZXNRbHIvZk5yMFRS?=
 =?utf-8?B?WEF4S1NFRVN4YW5BUzdTQlVYNzFOc0wxQnkxeFFVMHJmNnljWWFMR2hGeVpZ?=
 =?utf-8?B?T2p4dDVjSE91dVdCd2pRV0ZHS3FlTldqVWQxVnVWVE9KNjhOQy9vcWlXa3FN?=
 =?utf-8?B?Z084KzNVYTd5WllXTzNSaUJlWStCdkZ2WjhVWVNRVnZVVUVMZ0dENDNWaThl?=
 =?utf-8?B?YWw3KzBpVmI3ZDlwRkQvb1Rtdjg1WmxIcjhqSlBOci95T09PSjdFcGoxUWFp?=
 =?utf-8?B?U3V1Z2hybHZ0Nnl2WEswdzFBN2pEYlFDamw2aXRkNWRmSWpuQUg2NnpNVUNs?=
 =?utf-8?B?cXQvNDBSSW1lYnN1NTNMejdZaElpem5VR3JWZjhsNWxqYnJVb2JPd1BwOEF5?=
 =?utf-8?B?UWFvODdweUlqdHIyc1g0QVZIMkV2Y2x3S2xONVFjbG04SkRZbnhZNFpTWjVz?=
 =?utf-8?B?Y0JzQzhobHZyb0JLWlpISzhvU1ZyQS9kcEdiUnhpWUxwK2VlQS85NzhTODBV?=
 =?utf-8?B?L2tpdVRNbHhYSVlLK2pSckRFa3pDMSt0a0pySENuclVWaG92YXhhMzFLTmkx?=
 =?utf-8?B?QW0rcUJEaGJ0SHpYUlJ4V1BMUHFucTVZMmxadThGMGNEemdyWXV4U2IxNWNk?=
 =?utf-8?B?OFo3UG9zb0RLS0FwU2tSY3N2UDZZckhpMHNGZnp0bG5VRW5mRVdlTFBZalQ4?=
 =?utf-8?B?VnIyYVgwZ0dHdURpSGRXOU9HZ1I5K3Aya1l6NXJjNHppWXlhbnduamp3TTh1?=
 =?utf-8?B?L0R5QTM0QURnWlhMMEwvaFlRdEZkVU9DUXkzSlY5b2xmOHpRcG9jT3dRWWhO?=
 =?utf-8?B?ZG1RaGovSWs3cEJTRUQwVnhlRjdNeFdkYVhJNFFEQU45blc5WS9OYVQ2aXhH?=
 =?utf-8?B?STR0dHhxbDExLzhjbmN2ckZCZ3M5bHA0aDk5S1JPelFVZGVyRXFGWjJuUDFG?=
 =?utf-8?B?WmpBSVViZDZ1emxMN1FUL1hvWVlIb3pVbmJsWklPekVkN01NVWlvTEhTcndU?=
 =?utf-8?B?S3VyeDYxdk45ZGRnNkx6ODFaMndudHg0S2hoNmNpQjNjSmhxZ2xnTG9Wcms2?=
 =?utf-8?B?Ni9UQm9ueWY4Vk1BZW93QmRHR3o0Ym9PZS9rOXVuQjlMN3hWbCtCMlo3S25k?=
 =?utf-8?B?MHF1RHNFOFcva2ZxczR0eWdLS0s4N01EWWRUa0VwNFlnL1UxRTFHWkxWRXA3?=
 =?utf-8?B?VEhpcFZmcStZQll2VGxOT3lHWFd0ZEZRdHV0OGZFQjRnK0t2VGxIdGtwRG5H?=
 =?utf-8?B?eVNCNjZWQUhETnhReW1menFva1dWL3pRVlBFbjhXSkVGWlkydzh2a3VPQ0cx?=
 =?utf-8?B?K3ArZmFWdDRhNWV1YXRGejh1Y0tuaFFHcUlwNGQvdUNXYVBUV2h5UDd5QzRU?=
 =?utf-8?B?dytpbkQzSGJObDRhQXNWNDdLaEN0a3VlVUw3RjBhWWYxK0pTbk50Wk4rdTZE?=
 =?utf-8?B?K0lRbmVwbTJYTzlueDJqc0xwaVYzQnFKaE1Pc1BTZ3FNUkI5cVZCTk9pS0Vv?=
 =?utf-8?B?Y1BiMUlpRERidzlYZkRsa25wbTlqbmhFb1QwcGltNWFXTDFxWEYzNC8zWXRi?=
 =?utf-8?B?U2d5bHdKY2tSK1VRbUIxTmZFdEtCbXc2dnY3aVRGdW9BbjBvZ0p5aGxKTWFx?=
 =?utf-8?B?WjY3cmQwa3MvMzRLNGJsdW1WeGIzck5mank2R1VhUG5mTXlzSXJnY296YzFk?=
 =?utf-8?B?ZmtleVh3ek1LVWdYSllVWWtqQWsxNFhTNHV6V0FEN2dqclBjM1VjSVdOY3JP?=
 =?utf-8?B?VDNZVC9KU2JxY1U5dlhjb3ZhMXduV2NZM2k0VzFISS83SmJDZkU0bmFvb1Iv?=
 =?utf-8?B?QWZrRGJDdlp3QnRpVmlpVCs3QVFkVE42a09IMDdjL2kvazhJdmd5UmNTNXRU?=
 =?utf-8?B?SlBlYVBYc1VoWnRuMUZVbzB2ZHBZYWFvdEhzd3pXSUNtZGhTQ1A2NW05c3N3?=
 =?utf-8?B?bWRJZ0Z5V3FoT1paNFJWWStiUklXQkM2eGkzMDZzOVFrTHJGVXpuZzZwNURV?=
 =?utf-8?Q?3N54kRoWVzLXIXr7TnfMpqZs4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af9abbb-5e44-48e2-235b-08dc8f0a8a3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:41.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CfpRoPxVAkkUWBdhiEqwl/wwg7IkObC7fM2SQ3YPNaHYkmaox5pxOqzTLxUs3YwS/+cT6TYlLFtxsJmE8biUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ff9d0098294fa..6f68bee111029 100644
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
@@ -1458,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1473,6 +1478,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.set_ref_clk = imx6sx_pcie_set_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1489,6 +1495,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.set_ref_clk = imx6q_pcie_set_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1502,6 +1509,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.set_ref_clk = imx7d_pcie_set_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


