Return-Path: <bpf+bounces-34104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F692A7F5
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E09280E68
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7A14EC44;
	Mon,  8 Jul 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="afp2h6mP"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7814E2CF;
	Mon,  8 Jul 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458536; cv=fail; b=J45F91ypqKeBY8SIPUp5kwLErjht7GlqG9mCjFm2G38LgsTBhRLz5G/xBjxTnk0TApikcxy3rHaV5m09qufQb95zNLxa554W7rjwdw8/ran3JzVHXvL8qVB39BhA00dRni8pNy1SVxQ/bRzPCUgzJPvzsOaSeLxD7YVuD6wRriQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458536; c=relaxed/simple;
	bh=0PCynYDtS2c/Buu1JgYFZeq5Vw2vOSSVM5N+Ad5tguo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h+xD5saNoimmtPEf5DHieYJgd4REGC3uxxni3Um0QUjlqFHxCeOsRzHUs62TfCuhP8o+RbvD1YVuyHTpsN/YzNcQoj30KqPOTwU1kdfTq4AnE8EO5oLDx2yGBdJViiwiEoQOKqAqQ5bxgLvIvhkPK8Kh2qVnG2DXL5spgp1GZ+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=afp2h6mP; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2XhTrsOcnPgXrfFUeuxE4+ByVKwIBoUrepRbewgfp/s2+inI2VTph3K6T2DyExGlHpo7oMKnng8Jzh7nEmGJ9/EWDIOxz/6aJap05GeNg8fEn23xMkr+8Hrxdz6lPEQbNgi+GJfdmt0dcqsZp5m5tQHpuTsOfU8tTfKDdLeh/qrv40FxNu0Mb7+P16HHY1kpI9al6i06yPRjtAfKsZqJHvyGa+N+ANEwUcmeQYGQwaVChdTIVQsh39cSyEBhezGUZ/VB63TenfHFisAUM9pfhuJWqr1ES9gSkCQlh8nc14ZCtmK0c4rYzQ49su790fUAiqDp4ojP+9anLsCQuPYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0hS/iqnnqj6vsmpa6ZBf3F3fkX+7Gf7/1PukbpIC1Y=;
 b=ZEYiKeh4lRVqeEsDv1tPaUQOQgwK4O0Y39kRRH0E/il5SFXihyTW5qsFvTYW9mad7czDbTArqOTEmJcqm3NNXMLVqGVkVw1XM9sHP1KFKfES8D7sdzEXASBWtCiTlV0FN+FMnH6SNheAVwXWeUP6Llm+d1BuEL0p60x8HiXRCI0HEr1JKYtUry2R8ZQDxBvWAOlBr1hW4gEpHDW+MoT7+vBY0YZjE/ZKwexrCHiBhOirEQFWxTxuGweZIpeRBKPDk7gSGDbO2LpOdy7ea+UEyClvvabL5tD6+GWPhSECo8YFqdoHtn6W1LcLOQnOnErMgvClHWLbziSwC0xjV2RFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0hS/iqnnqj6vsmpa6ZBf3F3fkX+7Gf7/1PukbpIC1Y=;
 b=afp2h6mPoTTCGCAm3WvAg+713oRjiQy+euX4YU9DbQyhjvVxQJd2pl/LgzCKZ+r69g+ZMtEKVZrOu85/5OVwdoeuh03FMbf5bev+en1tIIsIe8kSmp1n8GYTj0sVudbgj+OPW9A0USlKU0TALVeKSANzCh6zfCofEDpfKhZGKwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:09 -0400
Subject: [PATCH v7 05/10] PCI: imx6: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-5-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=7125;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0PCynYDtS2c/Buu1JgYFZeq5Vw2vOSSVM5N+Ad5tguo=;
 b=4kvuSv3xf6MeaiSIZAJsfIDFdi0s7azcmfkS7aZRg7u5aEMh+kaE7jytNB6IDm10HtELpFA9Z
 MRJD9YLw2wwBhX32TDy3ralFwkHNRDf59AA+3qE2GH4fp1a0q2luYXv
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
X-MS-Office365-Filtering-Correlation-Id: 0cc25eb5-0cc9-4b40-ddf5-08dc9f70a3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BTNlpxL1EyS0RHdlRqZHJtMzdyNGpWMW02UTJ4c3Q0cTltKzlaakF6elJQ?=
 =?utf-8?B?VXIreUR1OHBSRXhyZzdnZnhoWDF6M0U0YnJVS2d6cHBuTmVBbmlaSWZoWUp3?=
 =?utf-8?B?MFlqTjBxSkJ6Tlh3TG9Bb3BFUGhHM0lKQ2s4Q3E5ZU0rdURCR3dkYnZvaXY0?=
 =?utf-8?B?UXd1b2d4dlhQdEJ2NmVvRmZIOWFiNE0xd2NKa0VFVEdNSVNOSHVYcnZxSFlT?=
 =?utf-8?B?UmRIa050cVBmc3phMEU4Y2tKZ3hRa08xa1lqTGhsYzZnK21wRU9ENlhRR1U0?=
 =?utf-8?B?Z3RVS092eUluZWNqT1VVVmhUM002ZmRxU2RPaVhtVHpSdmZBb1dueTQ3VGRa?=
 =?utf-8?B?eFRLaUZzSXQwL09weVlqMjNySjRZNkQwbkd6SU1URktwV0pMcVplU1JOQnpV?=
 =?utf-8?B?YzN6VkhpSDdhZFBJT1EvZ0hQa2ZTQWloRkpweGVtWmhrMUxsQUJ1enk1Z0Zk?=
 =?utf-8?B?RXN0cjRuNWNjdU5nRXpxUUlYbkNBSjlVQUZZUzQ4RDhTUHZ3QTZyV0ZzV016?=
 =?utf-8?B?ZjJhZEJyRjE3VnRWY3c4UzVLRVNEckV2bW41Y1p4SUlncTEzUnVhYkphL1Zu?=
 =?utf-8?B?eHNEU1Z3bEFiYy9vNG5xY1M2K3lscTNxVjJ5V204VktqR29WU2VaMjFjL2xI?=
 =?utf-8?B?cnovSzZzUkJKSVdxWlBaMGcyM1VLUTdRbzJLcGpJek13V3c5c1pJUnBrdUdy?=
 =?utf-8?B?M3dCSzBwbHJLTkpRWlk0b05JZTJvS09MTlJJeHk5aGtoc2NQSHBWOGxmd2p6?=
 =?utf-8?B?dmg5bnplejVqSi9DdWFhL2hoaDIyaGZPREhTS21yV2twbStqcitDVHVyS2FL?=
 =?utf-8?B?dGs4OUpWeGkwQzFMTXNiclhDU25XUUV4SFJ0SXZuQjkyNDg1TVJQY3IrWDFv?=
 =?utf-8?B?WWQxbVdMNHZUK0ptaDhndWRDVTY0UnViMmFudTZHVFBlbjVaRG4wODltUjhn?=
 =?utf-8?B?czBtdzFJV1lDNVFvNEhYL3VXeFhhalN1Z2RzRzU2bjh0bjhwbVNLUDJEWkZJ?=
 =?utf-8?B?WEdOQWFlZ2lUSlRxOVJadURLRWdnYlBlOTRuU05jemorMHNqUUhsbS9YZ3Rx?=
 =?utf-8?B?amFjZTY5M1BSTVQ0SmVoTUFoREVEZzZ5cWxOSmU3SFRmekQ0N2ZucnFLSVdr?=
 =?utf-8?B?Q3U5cnZaNTduelVIcG1WcCtNRVR1WFJJWVVqQWN4YzBjdjJ3V1V4YjN4VFlq?=
 =?utf-8?B?STl1RUZPM2gyUmpudGYzZk1xL2pNd3R0V3NDNjcwR3ZTMG54TGJYUnlIa0dD?=
 =?utf-8?B?OTNJaHU3Y1RFSlJQblJOa0lCbGtoV3M1ZnpZUUpiZmlsSnlQckgwRU9lSXd5?=
 =?utf-8?B?dDBEZlBKRG0xN3ZlT096N2pnVWQyRlM2NFJGMWcrdWlCSTNMK1pEWVVYTC9W?=
 =?utf-8?B?UHowd0JrYkdhc0J2OThUS01RbmNLd3JYTEYxVm5PYko1aWxBQUFsRm9oYTBm?=
 =?utf-8?B?RFB1WTdMUWhIR2prUkE3eFlDT1JsbHh2Q29zOVI0NE5Zb3dzVGpKR3R1MWhC?=
 =?utf-8?B?SkdZRi8vTE5NZ2x2MHh2ekxDMHBmT05SZ2JrbjVRNHU2V1VVMlRIM0FUdGMx?=
 =?utf-8?B?TDlKM1lPZENPeHg3UGtoS1VETkNJNkpjcEtuVHIzd2QxSVdsdTUzU0FVRUNX?=
 =?utf-8?B?M3RZa09UaXJicDlJcmNqTU9Ic1NBb2dhMGp0UU9uTE9xU3hTM2hXcE84TjZw?=
 =?utf-8?B?L0pydHN5dHBkeXl5UzJodW1nUUcraHRsemVTTDZuczk5ZGlwdDkySFNPUW9K?=
 =?utf-8?B?bm9ybjlJdzFEcjlWejdqSG9ySjFTOHRkNnpoQ2RUZnM5WDlFemRXYWhnT1N1?=
 =?utf-8?B?Kzk0WmtWTExQUVQwaDhiS3VydlkwOHRTZlBIZ3p1VVFlck5FV09RSDBuL25Y?=
 =?utf-8?B?MUJLS1NRVnltdzJNRm1ISUlFeFdjcUwyeEkwcEp6b1FZdW9TUlM0TXN0RFl0?=
 =?utf-8?Q?4+A+N+yU14Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZmNkY4UVcrRmRKRlRSVjJ6RS9ZTnZvZ3ZJV2V2K2NqbjFHemhtRkpidzA3?=
 =?utf-8?B?YXdUVFpqcXdocTJqVkdPcTZiaFBVY1M4d1pobnBtVGkwODNTQ2lVZTdYaE44?=
 =?utf-8?B?TXpGYzR5Tmt5YTdqa1pqSHhPTW9vYmJPTGdsd3RGdjlzUWxQeXhRY0VCYmtx?=
 =?utf-8?B?eGh6SXh0RkhReUxiUGRXMUxCakJNdTlHMWIzb3RhOHR6WElzR1h2MGQzRDky?=
 =?utf-8?B?THBWSjJJR2R0VXB2a1JBVUlDeW10SEZBSGk0Sm5VSVAwblM4YlNyRVhkMVZR?=
 =?utf-8?B?WUV0Skw0NHI1aWN6TXZyb0N3VCtxUlhmSTA2cVFKNnB5WERUN2owM21lQURi?=
 =?utf-8?B?V1FWUXhVWW9iaU5IY0Z3RDhyWStBM0VwcWZobTQ3OTJMUzg5Ylg5WlJwK2pw?=
 =?utf-8?B?SWNMRlFtSzlUaGQ3N3o1Y21JKytCQkV1ekxhMzJSZFNJL0NhRVYxT1V5WWo3?=
 =?utf-8?B?TXlNUmVXN2NEdTR5bVhEdzJGOFhXMlNtYUZLcGhVVDJ3dEJmTW9wZ2ROdDBm?=
 =?utf-8?B?UEhrZHJLOHNjbUtkRFJBbXNsN2grNENhTWY0cHQvWDV0WHY0SlpMWnA2cHVr?=
 =?utf-8?B?bWExTlBFT1paQWx2ck9wb3Y4Y0hIcEMwRkxXQWVOY3psenFKS21rNUU5K3p2?=
 =?utf-8?B?MEVQZGRrQkZOQjJFb0ZUNktXbWhCeGpsTWVlYWJObFBmY1I5WWxsU0pVSUpX?=
 =?utf-8?B?WStabnVtOWtBUHVwMUlSTjlJSHcraHc1VmhEbHhyVHlrVFRMMEt2Wm1oLzR5?=
 =?utf-8?B?VzQ0TWFsSE9qR0xjU0FRRFgzb1lPS25ja3pMUU1tYXpXeWdKRUFxZjA0SjhE?=
 =?utf-8?B?MFh5MnA5S09KbzlwRjFoVFZ1SlVFcWxnQXRZK2t1dE52ZGQ5WlZxMjhEKzZB?=
 =?utf-8?B?WFVvOUlHQldsN1F0bWRTelNQcjhjTEsxTDlWT056S21IdHVOTE1OejExVFFT?=
 =?utf-8?B?eTMzZkh5YlhFcGU4UGpJN2hSVk5jNjdiZ2diL0xvd3FucDJtd2lDN3d5enlZ?=
 =?utf-8?B?aFE5VkpJVG1wN3hLbWRlVDFwcCs0MzlMWG5EYTZ6eTU1TSticTFRZjhqWnZL?=
 =?utf-8?B?TDU5a21NV21OZVZaZmJMVEQ0a2lndWtFeVpLZy90Ynp0UkQ4dE4zOU5Hc3pi?=
 =?utf-8?B?Z2xkQVQwMnF1cUlpM2ZIU1ZCTWY4cjdwam9uR3Y0VmNnR0dDcUMzMVlvcndD?=
 =?utf-8?B?T2src1BxZ1FnMGRBOEpxdEpTKzZuWU15VS83VGs5MzE3cXVJQy80bzJZQ2R2?=
 =?utf-8?B?NUIzdzVjY2daTnBSM3RkZmJHWEdYVlFtQlFqcW5XdHZadG10YWk3VjEwZlF0?=
 =?utf-8?B?ZitGeVc1TlhLT0hzUjV5Wk0yc3lTKzRkOUdqNm1IZGlJT002ZE1MOXJqOHN6?=
 =?utf-8?B?U3NKYW5pYzRhaUtIK01xYTZERWNXR0Jkd3AxNTBaVld1Y052YUh2UDFZLzdV?=
 =?utf-8?B?YmtJbnhTcnZzWjQ5Y1hpVTRkZ3ZVSnlrbjRpbitLT2pNdUVrVVljS2lJVkth?=
 =?utf-8?B?R2RmNjFyT2hKODFWNXpNSnU5U2F1MjNEMDBFQ1JNZkRnVnFKSmVOUmYvcWRD?=
 =?utf-8?B?emV0cURvVHJVYlBUTUM1c3AwNUxSTTNydm5ZaFpKUjJock5MQUxsRlFVSW1i?=
 =?utf-8?B?SUR5M0xlYlYrYTd4RW55bkR6WGJiNVVlTXlkaU9INzJ4Z0krSXIraHgrc280?=
 =?utf-8?B?aDQxdmRaUzlIdWtLVzV2dkNGY3JHYmxJSnJ2ZS9LQmhFbk1aYnN1MHE3SGFH?=
 =?utf-8?B?OHQrdTZmaTlOQnlaRjQ2d2NXaEVlaDQ4SU96Yit3RWNac1BaZUtIWmxacmF4?=
 =?utf-8?B?UDFXUFdlcnNHZG8rRmVUeC9nUTdLdHBONzYrYWtValk2akttamJ4cVNWTE5q?=
 =?utf-8?B?RHF0aS95K1hKT3BleE9ISnNzVUlVUTVSQ0lKVGp6cDJwN0lvM0pQTUNKd0xN?=
 =?utf-8?B?NVVIQVVOcTdHTThzN0hWTmlJdDJoMUpsS09PNWljYmlnM0wra25lMFIxbXd6?=
 =?utf-8?B?N3l1ZGtiSVcvNTVCVThWR3JLb3Q0cEtyNHBVYVJITjJFQ1VzbzRjUmE3akN3?=
 =?utf-8?B?bHA0UFIxZVRMY3hoa1JhN09Kbk04aWtqRWc1eThjbWE0SStBMXBrRTlkSUZZ?=
 =?utf-8?Q?G7eQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc25eb5-0cc9-4b40-ddf5-08dc9f70a3ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:51.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNYYugwzIivB9vI8y9flVHQVwkDUm7xiJIgwzntkoGPeoGSZel9r3XbaBrG6mxOUU66VxyifWW56fluvWBB6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dbcb70186036e..2c60858b74a09 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -671,35 +672,75 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
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
@@ -709,47 +750,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
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
@@ -1457,6 +1461,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1472,6 +1477,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1488,6 +1494,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1501,6 +1508,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


