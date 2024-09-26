Return-Path: <bpf+bounces-40365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74688987B04
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E675286DF7
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BD18A6DA;
	Thu, 26 Sep 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k2vqNVtU"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00601898E6;
	Thu, 26 Sep 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388504; cv=fail; b=CSjtZ7leBiwEIZTdrY4sM1mHK4puWRpoPAtEduf+DJ04YSQXUA9fp9NXxrili7rUNnX0i2cq2L4eQ1coFKP9kXarZJG/9JSW/8119agCf6569Xo0shmE56k16lgEr6ZjLSrKvGiYQkrLk4/ftthG/F9hysaSuVMRIuCnmhcWNig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388504; c=relaxed/simple;
	bh=ajAZyLgV+oZQd0uLwTR8EeTZ2PcQRwQ2YwA49Ppzjeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p9fn6li5sKtATulT8NtrtMvIeZ18nXBz1ZMzCwD8Jjxyqg0JcdR6lCkup5EYI091I0RLjU/VvL0ZOPxKruxN5phqqfbg0xNN5IJh1fF2nCaoJnTdYGUGtz6H7dwe3qoAu8VYMWlNXfGHs2ze13T5xPjGRgan0fxch/XSsVpcPMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k2vqNVtU; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW4q0L+PIfqkBeCuIk1m6vcTQZMq/YzdjliVAAU6yGP3Y4c5xwS8bb7YrFokPXSebHX2O7KcOvEC4FbqMZXvln5TausM3xXXeh2ZgcSzs0pik2rTbGciJO4mHC1KYarSobbRXaAw42xOj2iMU6mTViKyaXRfcsOPzpu6gMpC5iEvdCxrKL8uEfz0hKepMiZv3qtfh5Aiv6IdZnjzE+OmG35CMdiXrrqlAVZG2EiFyWCyq7XLR6a29kWq7ILH0DCo1CIjMsu25toiMDO0YIpzbS1wfmc9beNkjZ7WXVLu8ThgUd4nMOgKtBEpX79akuw0PL3xmqEUUWsYh5ajiDLvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nARaTiApnM29p7FFkZmqPwG9iKsUGfbVyzLNVeSGHmE=;
 b=Wk0oNvmh2GOMrgW042lG6pOHTXs+tWbu7GaeUcfLeCldRDzMzM2N4qVCyVIU0vLZUboYCxDc0lN7bE8Enb67lyhAu3CqD4tJEoXcpE5gupYmEh/CjhVnImW4z7jV/DXZGH4SeWLf48mF2zZO8lAoTrtHc/BiBQZtachIPZxtKecDyikGUDaSTyqPZEaNyaZj3p/4VfREhFhYpKGGF618DmGwiVQ+uPfnkindPfBKYQJMsLtCoYhqOC5FQki2lj8y0Rj2VMIStMJEOX74BTgBYpZHjSQaqc/68/Ry0TgKl7JYuUEEZ9HoOS61cWM/CJiQNxr8XJFxYwRc1LNbAdURyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nARaTiApnM29p7FFkZmqPwG9iKsUGfbVyzLNVeSGHmE=;
 b=k2vqNVtU0vlGHMvnxIj/fTiHICGgKnNMbFzILy0M64soqrDrdkozb4tGO3cTCwtjKLdMb+UJxmgsb8V6OMC5UXP3FxlmkLHKo9mBOTtI7Www/ucZeiH3rT0fZmjhwBAJSPEun+mwYjYPPJcZVGWzT0/wE7aaW5ZoPspaALSc2JI7C6nYaaiuuh8YWQXZxGNYzCl8HhlGNd1ScHQorEeRHbJjHZd4MCYAj2ksMYvhq9SXbVE+3hqvOtUerop1gUxRs8f66RScTPXn/z41lUDBpnCH/y0Ed5VNbRwOejmDShCVVoEbXX4KYwCssEVlgGA0JoCQhmU07xa/KwgFROtGKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 26 Sep
 2024 22:08:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 22:08:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 26 Sep 2024 18:07:48 -0400
Subject: [PATCH 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-imx95_lut-v1-2-d0c62087dbab@nxp.com>
References: <20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com>
In-Reply-To: <20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727388480; l=6401;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ajAZyLgV+oZQd0uLwTR8EeTZ2PcQRwQ2YwA49Ppzjeg=;
 b=/WiAr7yqAaBdN7zKkrqITQ1LzVkObYwiuQBCZE4CvVtqqUnA/j6Xfbv5369dpRB1Ys5CqbSZh
 2qtomGwigmECtUUTwI2FpJjgskLlCASYLee4vC7U0Acss7fPXxzNE3O
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: c8768ffa-8a08-476c-65f8-08dcde77b9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1SMTZPbEJvdUhaUFZFdzRXaU82S2VFajZmK0tUSDlkS3dQTHN3Q0FNaSs4?=
 =?utf-8?B?empJemgrYkRnamY0ZVAxUXdiZHdVOWgxei9TTksxVHRRQ2FwVHNIMENOMU5C?=
 =?utf-8?B?bWVTZ2EvVXVkQkwySG1qZGV0cG45ZDcvL1NHK1RDWWExenhIY2J1VmczbXBm?=
 =?utf-8?B?bHRVbko3M3lRRzZQV2JnTCtPSlVjOENTR3EwUFAyOW5ZbnJia3FnNFhwRW9i?=
 =?utf-8?B?S1VlVWlsVVh6Q2RYbGk4RCt0c0hnT1cxNUFBN0lBYW90ZFhRc3JEa3dZMGl2?=
 =?utf-8?B?UmdwUVJMMTd4ZGRHai80SjB3cVRLR1UyVTJkVUMyMmVBcW5rQTNPb2l0L28r?=
 =?utf-8?B?cDVMZGpQQjdLMVk1aytrak90VTFTWXJ6bVV0WUVIanhNQ0FQdHY2RU5xaWlu?=
 =?utf-8?B?LzdjMjNvSTNUc1dwaEZzblo2V3F6Ym5QT1lvWnB1bXhmZThuZFpxb3g5c29m?=
 =?utf-8?B?R2oyNS9FS3BuTzNsR0lLK1Z3MWQycFo2SkxRNHhaTmtiS3JaNFpDaDJsalc4?=
 =?utf-8?B?NHduSUlTUHd1OUJzVmRmYnZqWkY3cDFqM2VBQU1XRXB3L3ZyL3htUC85N1Nk?=
 =?utf-8?B?dEJpb3E3Vm1wVTh3THBDRXliNmZaTXpTZkpyekVZM3o3T1ViUmpQd1Z1ZXl5?=
 =?utf-8?B?YU5WcVBSNUo2b0p0K05pSUEvcnNsaHYvUmF4UDJpVW5pdXFpR1prb1hZMURw?=
 =?utf-8?B?Y3E4N216dVh3UkN6M3l6Zkpjc1lGdmdpS0pwUzRJcW5UWmVjR3M3R2MzQlRC?=
 =?utf-8?B?T3NWSm4zOXRLZHRFWXhWK0l6RU1FR0RITWwwOUhDUk0rY1l6blhiZjdqMllW?=
 =?utf-8?B?QkNTZGVTT3k2RGtlTVhWcmxLWjhsaVF1M0E5NSsyQkp2bnY2ZjZ4OVNvR0Zl?=
 =?utf-8?B?ODF2REhuK2k0ZzdTdnM5dTBnaUFqM25uMUk0QjhuUHcrT2hURlFzaDVyZGxz?=
 =?utf-8?B?UE9reWxsYXJvOHViQUs2Tkw4RUdIN0tvdWoxdytTZENicU5IYWkrOWFHcWRk?=
 =?utf-8?B?ZmwwRnk5Z2NsMm4vRzNrY0RKSEIvNFZ6emRtWEVkUU05ZFRKS1JQZGZRQmg1?=
 =?utf-8?B?cDFGL2JpaDBKQU9rSmhuUHpnMkhqNGhrRngycVB5ZVRRUnV6N0FuNnJTTkZX?=
 =?utf-8?B?WUkyRVAxU1hLZytzWjAyeWhETDJZdmJrMVJEenQ1ZTdxTXphV2VVVnk1TVJ2?=
 =?utf-8?B?d0FtRnVzdGYrWXNYd2lqZlZxWFQ0dTlITmF3dnVQMElWdHg3a1ViRlFJTGly?=
 =?utf-8?B?S2t6WVRNcSs5NmlKWjZTOC9ERzRqcTBMYVovc0o5TTB3cTN0ZG1zakRaMHZM?=
 =?utf-8?B?MVJXZ3RhQllTQUNENGhJWXhCSkhQbGhKT2k0cDNZeEJST0FBTnRlUEVBUzF3?=
 =?utf-8?B?UEJZTHRoSWxJNGlvNmFjL2tJS2UzVEhtSlBOVXRxY3RWallBZElGbm0vOHAv?=
 =?utf-8?B?MlQxQ2xsaWVZczJJTUhselNZeXdYRFIrVlNlaDdDRkIzaWNBQ0QvblN6YWZD?=
 =?utf-8?B?L0NEWnJkUEFSaDJvUTJ3eXpzVjhRTURHNDkwcVE0ZlBvckFTY0lPeitaYiti?=
 =?utf-8?B?Q1g5eGxOWUtnYjlra0dLeW0vMFdZVlpZRVQyTmFObU9DWjc1ZkxHNHZRSDF3?=
 =?utf-8?B?QWFicC9zb3dRVzNPUjVBbzdGVGttY0NJeTZMMG81YWU2dS9XbjZqOWNZTlFp?=
 =?utf-8?B?Ylk2VEFYN3g1MWk0YlJkNlMxajZkYjFZclRyR3NBVzN5SzErTnBqdm5QU2Nt?=
 =?utf-8?B?MnBraVNRVlpXbHZIVkF4bk1aUmV2dkJRYUFTTDRnUEJIUThlL0ZNNDg1R2Z5?=
 =?utf-8?B?MEZFNEExR3JoRzFyc0ZQUlp2ODFSV1FaY2JyMUxEQkIxa04xQlh6a2ZJRFJN?=
 =?utf-8?B?ZXRlaUorcTFRK3F6TG9NNDl2RFlhOG9DSHB0U1dBbTRtelh6QjZiWnlkRHRT?=
 =?utf-8?Q?/yIE7U+bEUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0grMDd5UnVQbDdJWERlbWFFZWY4TmJjaE93bklIN2lhZUppQmlmZ3ZzL01j?=
 =?utf-8?B?cFlFYlR2aUxtL1Mwb0c1cXdwQTFRc3lra1Uyd0YzN1F2eHdJcnNleVU3eDFW?=
 =?utf-8?B?YytDNkRkdFNMMklXSGdBakRTSWpwMXduT3BoVjI4SnZnOGRwc1NxWmlPRHdz?=
 =?utf-8?B?eTFLU2dNZllzais5SmFlYTdJaTJ0TjBPVlBjZVl6ZjZYRThJVEdibzRoT2tm?=
 =?utf-8?B?L2NudFFER3lNa1JXUFE1QkhXR3dkaG9GRFBDbFFFTVNkeDdHbURiRTFGLzdx?=
 =?utf-8?B?b0h0YXlTQTFVTUhrVnlpSUc4UmRLSXZuWE0yY2NVMEduMXBhb082RkFuOEZl?=
 =?utf-8?B?NWFmMmd3Vm8rUmJLOGRLRTBqM3pobGVoMWZxY3BXVW9Mdncza3l6MEFpK3V2?=
 =?utf-8?B?cWl6bHM2MHRvbFVJbGtJT1g3T29QNm1YdGl3Z0FzOFpGYldFbUliS3JHSEdS?=
 =?utf-8?B?R05vbjNYOWl4bW13Q2NKaVBWbmJVTzN0N0R0bUQvVVYydmhhRFNVTUtGb3RD?=
 =?utf-8?B?LzZZL2plRkFmblF4MWFxakJQeGtjODN4TVdlam5DV2F6ZUlaRU9vTTFmOWMv?=
 =?utf-8?B?R3lhcG9jVEFtaHV2S2RmWm1xM2xxU2RqcGtPZWw2OEN6dzFwaTAwRlQvWW1E?=
 =?utf-8?B?ZmF1eGxyNWx0NW0rRFhjdHpJcWs2TjNrNVFsL3dIZHp4Nm1wMktGUmFreUky?=
 =?utf-8?B?bmZXL2p6Q1FpUU5lMitiL2piWHlsbi9MMU9FZ3piRVVUYXhtRkcwWm1hSVpv?=
 =?utf-8?B?VjNZK1VZek9QUllXcjFvUXBkeEwyMlRySk8wT05CdXlxT0NqcmMxUU9mL0Nv?=
 =?utf-8?B?eHpzSVVyVGNQZGdjQytmcVdkNEJYOTYzeE9saVExWWlFSEQrNHdvb0MrWTFx?=
 =?utf-8?B?Z2k0N09qdnY2dGIxK09KQ2dpa1dQZTcrTjhKMzBaWUxVL3Y5dDlOSW5wOTVh?=
 =?utf-8?B?Wis4NnhiR3diYkE5bTV2NXdWZUc4MFd4SXlNbXR5NlRwT29CdFF2S0pmTFV2?=
 =?utf-8?B?bmRYQ0FhT0xWMEpKWnNhSytITTczYmc3akRrUDNOd0FVdzFsNFV4Z3hXcGRz?=
 =?utf-8?B?bmlOR0JoUyt6L05GdXRaZ1V3SVF3UFo0aStqa2Z6MXBqTXByZkVXN1BIQTNU?=
 =?utf-8?B?aTZHdjhoVy95SWErREllM25QMW1DUnpaMHVucmxybVR3QzcrUHJlcE9zcCtx?=
 =?utf-8?B?Y1NBdG52WEFKRlo5KzgyS3FIZGRkcldrRlZsNVZkeUhhbS9SVU42YmVGMEYz?=
 =?utf-8?B?YkJXSmV4Zk9RRXhVZVpNZ3c4YjUySHBpNHd5bFNKc1huVEJnSS9rNFZpRDlF?=
 =?utf-8?B?RitYc21IM2h1bml4dTJjOFI0bkYwTDJ2Mk4zQThFbUVTd1Q0SStVdmpvalFJ?=
 =?utf-8?B?aDh1VGNGTWliN3NkWHQwaGFvNVdmSmpHSTRMcUFxK203NUZrNlZiSFhVclUw?=
 =?utf-8?B?VDgzdnRub0JQdUVscGxrRENxNVVabC9TY1dkOExoNnJSMHhTUWJoQTA1aTlQ?=
 =?utf-8?B?UXBib2xQSW85RHZ3VERydzdNQkhackpEaERiWW9sVHdiREN0TVhKQlB5OGcw?=
 =?utf-8?B?S2wxdUZieVFJQVJFZExJM3JpMFdhTjNTQ1IxVXNLUjQ4R0hUZGsxTXd4aDVu?=
 =?utf-8?B?V3FZL2JsMUx0empucFFIQUZpTjJTSFd2MTh6Tk82OCswWEt2QmpvRlpQc25X?=
 =?utf-8?B?YlFhbkljMXFYbVZocDhIMWp6ZzBWTXNJOFZXSkZSSU83Kyt1dGk0YW00QnVm?=
 =?utf-8?B?cjY5V2UrdUhaT04wcWJ2cVpRc0FwLzVTUG5qcXh6MTNJQUlYb0ZzNVU5UmxO?=
 =?utf-8?B?bWxXK3I2VGFoTDBXVmx3ZzNBN1lvb2xjNVJUUEFGb3ZXRUtVaER0VURjbk5H?=
 =?utf-8?B?eGRVVXIyUG9KZTliWjVGaXV5dVNiSkhTcTk0UWpZczFucld3bjlQWnBaU0R0?=
 =?utf-8?B?dGcxd21tYyswZWwxbUNQTVM2Q0FwMVJEOEdwTDMyMWMzRitlSkwzQWV6WWNl?=
 =?utf-8?B?SHg0R3E1VFpMRk5kdVBHZU1CeWxKWk04a2ZGcUF1MzhLK29MMDVTRWVMRTBk?=
 =?utf-8?B?b0s0cFZDdEcxNlQ2cGdKb0Q0b3hYL1JNOHJOQVYyalNHMFBuSXp4cGFFR204?=
 =?utf-8?Q?55xs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8768ffa-8a08-476c-65f8-08dcde77b9cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 22:08:18.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SkgU/WIRf/9Ta4ZmNLH/RKr6Q7Kkfw9DD5aKH5GxwSzN7To/JaUT1xOYGi1KnOi3DkAesoCic37nLaxgL0jsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Additionally, register a PCI bus callback function enable_device() and
disable_device() to config LUT when enable a new PCI device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..1fe07f64d0d88 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
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
@@ -82,6 +98,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -134,6 +151,7 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -925,6 +943,111 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
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
+static int imx_pcie_enable_device(struct pci_bus *bus, struct pci_dev *pdev)
+{
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct imx_pcie *imx_pcie;
+	struct device *dev;
+	int err;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bus->sysdata));
+	dev = imx_pcie->pci->dev;
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
+		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
+
+	/* Use dwc built-in MSI controller */
+	return 0;
+}
+
+static void imx_pcie_disable_device(struct pci_bus *bus, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bus->sysdata));
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -941,6 +1064,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->ops->enable_device = imx_pcie_enable_device;
+		pp->bridge->ops->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1420,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1717,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_HAS_LUT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,

-- 
2.34.1


