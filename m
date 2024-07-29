Return-Path: <bpf+bounces-35936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5E93FF2D
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDFB2204E
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1A18FDC4;
	Mon, 29 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RvhfKkGe"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D918F2E8;
	Mon, 29 Jul 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284380; cv=fail; b=X/9MEgAvEZIQqJG/knd9QAWv74JMeXnW8uYc+xXhWACWipxnPpNENKiYHVojJmKB4XsPi3fO4UI4N6vI7lteEoSvdupV7xl/4vR115ijvjmNyckTMAGoOgoK3nRLzgVzNvTM31pcyAhullHPPzHN33crIeLCu/3oP+Lc0aorkJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284380; c=relaxed/simple;
	bh=Oi+O5DWRmBU/2zRPk+Ym6Fw5V6Zsw9Kds2smM2X+BaI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=umK/j1xtjB+geV5Bl6mm/8xNCb6gjQPKoB+z6XffXknsf79vR8Or3zqM/yC5khDKwipTZhJtZ2iq5tt/KxPq4FaZYidyGxB/Wzequzaw35qg7MemmKJqsM5vgddgeqNV4rhzgEG2USPGFO1CQMgx+pzVqkk49WwnkSLfqx+Yfdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RvhfKkGe; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnQihyrfsYD0G2PxFv0iRF91LFXjHWx4Zqr6+CEhfzX/v8rTikAJZgXM0DDuvkhlC+tFJzBOXzFirUHGk2ISVj9xnk9WoJnHo2GJrGZTPM99UyXwF5sR7HzsuCqP1yS3heb0AiP/29sDC6/XxJUSO+0FKS6zrr1Ulqa3JPBMGO11eurtm2cq/eoxSYYqUpHnMzd+4eXjNjPaOyoF9j1Eg8mDHFpjtdVLD1Nk9Xx6UY+cekhOsGoVJlxAzq16bOiLJxj/DMh0FhCK4RtL4Z3hNA+ypUakVWVCfXN2dBy93J7zPwbGqm11KenvywFnldbelDNX6qRspXVtDcLxiL2tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWGOx5vCfCxn7WgB/8DuSXhHQZCIIY3Ww2nV6/gA1sI=;
 b=yubfl4x7LRvKcNwcKZ2LuT01M2iicLiPFdClf4gdRgdnDS09jH05Zm/c9XqKR1bPE1EcXzsFq1tQwoPo19HjbfRo/W6vhZU4UOsPhgLOhf8E+gkzcXXRl2+gVwcbqn93C9s23AhSp+6pZOKnI7eIsQthmNf3DCsKxd4fSXFNlPHQX29oiTfcWrCyiLfyrCp3ca0oSWiAnB0aMfV5vrdHfLpj632ZeR+5URZbYmPXjTV0nW6az7moJH3+QHFp8bRvIWjN+j+MUy4yF3oib46o571TYZPRsgu9BSlXtr9iy3F6YRznr1n78Omp3jyCp/Z5+LCOYHUnHHgXr8giqQr1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWGOx5vCfCxn7WgB/8DuSXhHQZCIIY3Ww2nV6/gA1sI=;
 b=RvhfKkGe5EEYBSS3fCb+QqPbWjNBHpbync1fyDLaY+v4HDsssslYZqxinBHB07SPJAKGJyd54HyF8A97NV4GqmlorWyzgxAE9+0ZxP/rVDeSKrcwNlghgnIK0+b+42Cv9LiJ+f8h+gQedF1khAcaTG2f36lZSfS1xf3WBrAwVjoi7iM8mJf6M6QaTCa0yNBMfhq931OKR1nt4pOiZia5nt55Vfj93RNny7xDnGDDJ2jixko5PdBWRwHMKLX07p+pUhp9joudNaXWXMj1Fyoz/LVYnK7W8aL0pqDXUZYdC46J9KgT6rRS5E0+4XMW3Q4+ZJTytUgR/z8iokbsu9gyfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:16 -0400
Subject: [PATCH v8 09/11] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-9-b68ee5ef2b4d@nxp.com>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1424;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=12Cbbiu9BR34/GLddVOaZuBe4oG4iPR7q4gdUQjxKJ8=;
 b=45QXLun5CqPuBggVcPv0o+7DIUMg0Cp5T8psvYuguwhDz0Dh5D426ZYU6argSivtHqLXPgy/4
 dhMd99llr/JBuDMXGLpSYWN+38aNu59ROGnHyJbEn+alfdyQNn9lU1Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcb3906-f421-4dbf-99dc-08dcb00bc333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1FKQmp6R21SQXp0K1dBekxPL2VOcEZ2aDZCU3BSVzdybE1aQTVVZzhaQXF3?=
 =?utf-8?B?VWYzc1VXTEMzcXl1dG1yQ1c2aWNIcTFhaE9sNDYwNHc0dGcxbSttUkFtbUEy?=
 =?utf-8?B?VHlobVdrUWV6RXc5VDNGK1c1NHlMSTRQMjZYZHExYWVXWDJJWFRValNUOVFm?=
 =?utf-8?B?Rk9PZVNhZ3NEYW8rc0lpY1U3a1l4ZGMzT0lWLzJOSUF4RGg4cFcwRy9vdi8r?=
 =?utf-8?B?cmRBZ1RjMldpRjhza0I3ZmNSRERoZStxSEw2S0RHV09ua2NRcXNMZUZndzlY?=
 =?utf-8?B?MGl6MWxLZndaY3hGdXpvTEQ5Z0EyaktBdVFQeUkzRFFUWDMycElGbldkVERr?=
 =?utf-8?B?TU8wMDlwUGNyNExaNWx5dVlqUEI3UUhnV3V0K202NUhUVjFDcEZLbWRGSWNX?=
 =?utf-8?B?cU1ldXFReWM0QnRiRldERFBZRWIzT3Y0YlhXRGxXbjUxZDVwaEFFYTlqNWhl?=
 =?utf-8?B?eFlWNVpXL1I0Z0kwQVNjQ3pFU040NktZY0lwNG9LMlZaM3JMUDYyb2hDekEz?=
 =?utf-8?B?UmY4RFMwWkloUHBmTTRtemNJYU9TV0NoWC9PeVFkNWVsdWxEMmlKRUdVZGUx?=
 =?utf-8?B?S1BsYTV6SDU3bU1iV0kwZUhZMFh0L2hWYVhCQU52cUdaemE3ak1hVldGZGhG?=
 =?utf-8?B?VEo4RlZZYUs0SFlDM1kwNlYyQTRFY3BjWFdSN3lzNUY4SnFud3BDMGhvZnA1?=
 =?utf-8?B?SjBvRzFSbDV4Y2NneW5adkNVMkROb2Z4SjN1RjNROGhoVnJkRWxjZFkyK1hk?=
 =?utf-8?B?SWhSYmxsSWx5REZSZFp6QkVpdEh0ZWpDOE5hMUJxMXoyQndYS2s3UDdBcUVF?=
 =?utf-8?B?L0hES0RhR1haOVdoZy9ROVViOUJXcllYVXVEVjNTRlE0RFRyQUgrbUFTSXNI?=
 =?utf-8?B?YU1BM1pHRkFMK0o4UVcrMkdZallwMVJnWkdsc1ZFNytwTkV4TXF3QStVblJp?=
 =?utf-8?B?R1RoREtsZTZnaEhlNW1FTGtCQVF1VXNJTEVIUU9kNUYxR2JsOTBxOVVReU5G?=
 =?utf-8?B?ekl2Z0h6ZFlpV1NCdldGOTJPcWJOMjdsZHZpcVBpbVIzVEEyNWVPTjR2WFVt?=
 =?utf-8?B?R1pJNTBOb3RZV0NhL1JLNGRMc0JrMFltMlhmRWp2ejhacUhiVGh5K1c3aFdN?=
 =?utf-8?B?dG9IbDh6b3Qybmt5Q3ZWQlNDajhRRkFDMVBsTUR4Q3cvSXVnQnZRZlV4VDZV?=
 =?utf-8?B?UEVQLzQzOXZZSTc5Z3VTY2ZOT1BwUm5YYnc2Q1ozMDAzbVpnVmgyWmh5Zy9L?=
 =?utf-8?B?cHE4b2c5Um1BOGUxd0Z1Vks3SFVMNHIrK2Jtd3FQM01GN2Rvb0FKWTFjekRF?=
 =?utf-8?B?Y3BBNURZRGtNNDJYRWd0ME1Ib1F6QWZ6UGd0RU94eDBJWVdHR3RpZWlHMDRT?=
 =?utf-8?B?Z2l4M1ZSeFA4bHZBMUE2Z0gwS2s5Tm5Qbk1adzhsUkVUNWlMa2hnd1VkUzdP?=
 =?utf-8?B?YUhaRFZCSTdoWmNLRDZrOG9iZHFzOU1XN3FkbU5jckxzNE01OXd1OHV4UWhX?=
 =?utf-8?B?U2dLa1QxbHRHMGFaTnV5L0ZaVm15K29zNDJwbmVWc0pOMXJzOFdwdDVYZ2cr?=
 =?utf-8?B?ZTVZWFFCZElMem1mRWxNYUwzYUpaaTR6MmdTNC94cDRBUkE4b3g3emtxYXFy?=
 =?utf-8?B?NitjRTVOVkpueU9wRGRXTGV4YWpyNExMa3kyalNZSUxwQkFQSEltMXdXL3VW?=
 =?utf-8?B?aGtHRFhMTXRjb1p0eVBpNTZoaEkvdjRLWEhmNG01Mk1ZcGRaMXg3MHJSM0RQ?=
 =?utf-8?B?Ti9jaEtNaGIydmFxZWNmQnhpSzUwb1J5a3c5SXc5dit1YmZrUURUZFZYRTl3?=
 =?utf-8?B?aXkydWx1N1lGQUFOazlQaGhRTWYrUnZVdWg1Z2gzczRGZTlSYmorNE5EcWgw?=
 =?utf-8?B?alVJRXFjNStuUU9XZmZYa1dsMy8raW1aSllCK1RHczBrYUZJeldJcml5Qm5R?=
 =?utf-8?Q?qeFGA6KCiJw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmJSTDFLbkt4SzRSUndnZ1dmc29sdlQ3bk1XYjJXUU14ZWk1dC9UVmlmNll2?=
 =?utf-8?B?SkxvaEFJNkN5bzRMakxwOHBoSER2RGFUVVp4eWNjY3dWSzhWSk94bkNJQi9q?=
 =?utf-8?B?TW1nYWRheXIzRE5VaWVjT1BJSXdUamQ3Q1NhTDRzbGdOQi9ZV0svTGtLL1ZR?=
 =?utf-8?B?MUxCWXI5NFJGVlZ1azVCdnJQYzBjbWlGZ25SVGo1aWMxZnRhNUxMdnkrVFlP?=
 =?utf-8?B?ZTFZaUVKcWcwMjhvcWl3bHhJMUxGZnJvK2g1RUNVUXppYm1KZ3Q5bjBqREdG?=
 =?utf-8?B?OUE1Q0crZk5qdzE5Q1RFTGdmQnJaRGZEUjMyTGFScHl3aGM1OVo4ZnB5dVl3?=
 =?utf-8?B?ZS9xMEtmdnBLTXFmQXEwQW53MjJPWFcrMHJKN052VWcxVEZaM3gvUWhQNEx3?=
 =?utf-8?B?YmhJOEU2N05DRTZCcHdCTlNQY0dDK0h4MDdkQlJGWDlpOGJlekRFbGYrNm4z?=
 =?utf-8?B?cUlqVy9yUjcvZGwvSmYrZDNDN3lWOUo2Rkg4cGxrM1VmY1Z2bHAvUVh4cEsw?=
 =?utf-8?B?V1pQV2toSktmQStaVnV3bGgxYkpEY1BnTTFuaGFOQWs1SnJySmR4YkFFcy9v?=
 =?utf-8?B?dTJpMmcrdDkyQlNuNzJ3VEhaU3M3bmJrMzhVTTJIRXY0TmYvZWM4R2NWenBK?=
 =?utf-8?B?dy9uQWQrS0Q2ZDRyNUZVK24rNC9qNGJpdnhJQnZDQlNyNm45aStuV2FVbkd5?=
 =?utf-8?B?WTNrSm1lZkxiTVRzK2IrUERubXlPMWpOUDVTWm5nbzlzSVFzSG1hUkZFdG5o?=
 =?utf-8?B?S2pvTWt0bnFBVUV0djNjU0ZycHhMWDNGQXpEOExFS05RaHp2d1JqVkZOSDRS?=
 =?utf-8?B?YVdoYlZkd1hBemY4ZHd5R2tSZkM5SDNMZEpDY0NtbGVoL05MQ3ZrQUJKNllP?=
 =?utf-8?B?Y1llMVJOY21UU2J3K045aldaRk5mMUxMLzlCTWJyVkw2a2lGbHV2RWtlT3dr?=
 =?utf-8?B?QVhjSTlxTjlqMTlDK0IzRk1aSk5rc2hlSEZFY0o1NXNMcWlEMzZlMms5Y29J?=
 =?utf-8?B?c0o2YlJ0cDE0ZXRSUjZkNVU4eTF4Q0lqbDcvcmFBZE5MSHJHeXFWb285eEdo?=
 =?utf-8?B?TE1ualc3MVE2MzdycGk3YjRWRkVQVDgyVUNCRlJGK3ZYMFg3M3hxUDB3SmF2?=
 =?utf-8?B?SEN3ZllKMi9uMEdPMUVnQW1JeDZDdHBQMWhJTlFMSHJ5WFZwZk9TckYrbXlV?=
 =?utf-8?B?L25pR2JnLzhJM0I5REcvRnNuNmxlWFdncXVYZ0pTdGJNNDl4SUtLazh3Mzg5?=
 =?utf-8?B?UmZ6a1p1MUVmNWI0QVpWRGRBYzJFdUZnRmZSZzB1ZEJsU21BekdVUU01Ylpp?=
 =?utf-8?B?aTRpK1dTemx6MmFOYTA2a29pN015akNoMk1XWjNZUGNpb2U5bjJPMlI0bFlG?=
 =?utf-8?B?V1hzamRDNVhSOVVUYmtLZGViV2k4NkdtUXlvaldRdDVjcGFBeUZJYVJJR1ZS?=
 =?utf-8?B?Y0ZYaDl0MVNxRWlrazNZRnFaTitaam0zdVNwSzBrNWZaVm5PcVBFbVBmRlcr?=
 =?utf-8?B?VGtZbGtOQWtlZmxHeWN5VTRMc2ZFMXhTZlBiT0hmcXplZVFqN3hTTmFSUWhP?=
 =?utf-8?B?UTgrcGNMbG40SkluVmNDVlJBZUw4a0UxYVNIVFBFelZNZmNkNmtXa0FhVlo3?=
 =?utf-8?B?VkZ2Q0o0ZWhTTllPSEkyR2pEd1FueWs0WEJKRGRNSllmQTFpU3Y1QWU1bXFa?=
 =?utf-8?B?cmRGQytmVTVkVG1FMUp3TStTRVlDUFd3RUxidHZ1bmV1NjZlVE5GLzAyT1Jn?=
 =?utf-8?B?aUVGNzQ4SUVWdXNDbklIQkZmVnJuWjZ4Z3ZFVU5yVTM2aXdYVEVrclJjSkRG?=
 =?utf-8?B?cUZWQTRDeDU0UHJZYWR3aDBvQ3hFUVFxbi9iTXYvaXl3dWZ5eGhUNGk5ZURU?=
 =?utf-8?B?c2VZRWZQWFE3dnZ0dk9IcU11ZDlZc3MrRmpQcVhVQW1GUDluRGVEd1lOK2tN?=
 =?utf-8?B?VFpTUjUwVm9UczUwR2Y3WnpBd2Uyc203a0l1YmdPZytTVzJSRGp4OHh4ZlVv?=
 =?utf-8?B?YllIRVNhalcwTzB0QTFlZEJMWk8vZnEvN0dFWERFMzZtK2I1TThpU0hZWnQ2?=
 =?utf-8?B?Nmx3bDE0WTB0TTRTR3VYKytybk9UMk9SeWo5N3F3SDdKcVAvMTdlRU90ZWpq?=
 =?utf-8?Q?yf6lvkGXEARfX3rWbyGLs5seK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcb3906-f421-4dbf-99dc-08dcb00bc333
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:34.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMHGiugzNjGRP99CLVYip27yYkONduDvaMTivapq/xiwK6zZzOtFUFeKS7CjWGe22j+7WKH88X/P7/2VTh/V1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
common naming convension.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


