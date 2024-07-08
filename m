Return-Path: <bpf+bounces-34101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195292A7E8
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759A71C210B4
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7FA1487FF;
	Mon,  8 Jul 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n9ZDKSkq"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0414B967;
	Mon,  8 Jul 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458519; cv=fail; b=tkAGkkXz5TDrxo6MkXVfIiTpOEdT3bdqDYiQLEdWZ9+FU7LxlcOn+qXNvGWupOTmWJwq96pPZyIllmiExz+tM4ADZsQD17+Fw+kis9AJgfjxKhKK5gSPD2pmEDTmhz64hiH3Av9Sx5TRO9dtWVYIJxWUM2mOmKTcA56Y7xE3AOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458519; c=relaxed/simple;
	bh=Jm6GeRMPxeTBPfJ2OeGnp/OweXbfacd9STdPEml5mz8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p8es6rMmEAAqdCqNzDFYAF1afj/kO/sAW+HJ4H53uwhtUdL7KjRhM1QCduW8BN3Vx+nG+Za22oh/Ml6ybd6wTuLJ9RNpzeHuVFalw74T8+0HM8NycqyoHz24JzWu92Yv1Bi/G0oyiXXm1I4e9ltwu3TqsWeVLSXs7i69ddcAT30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n9ZDKSkq; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhQjdnmIZINFQeTnbcvCvUUbLs9ZfT2qjETlNiyTfjFtAYCoZd3VMPsh6i6mpS430xGb+1rLTAYYZsFH+fFPJloI6JVU0VulRwKtNeX2KQwYTY82Xp80bcSpyeuKKjj28/1+Ff1rynF54hJ9Q1s2zvhH9PlezKtw/HFMUqvjNnRetRbVhpZgFZrw2OpkCFH8gvxTgWEqH7OEgmfQZ6FlAc4Ef8dsrxY2kIN3uiWE6v+PHnW906eaDQwr8qcC5ALnShN5qMp5cRpKcKob3bNqQxUqtyD0Z/Cmj5xIsMLkC3QrExLXaSCThvzdrMWLhvfGM7Zol2xJqHyGG7wJBnc+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmaevdNZlABMzm/iTBpcukEaFZ5SPA983fiKgGailbg=;
 b=DLqTuqBXzAi8I+0ZOY+WS7AK6gp/ubNaSpdiOUv2nENyfOm2woadrn+3MEmw1WNO1szmmCZ/5SVEVgMn3T5SBmhLWiu0Fey8uMiWaywdNlVAuGTE1KHI/Tyj8K4kv6z60RbyzDqkRyjU4zm/1s/Vw+++oYzl/4sMolkb+UzGM2hdzLnkyUM640Ozi66wLzW+g6T4+rFxVc9Uukgs3ULgl06Q5qEVnlODjJQT4lo2bjFT4KrkXWwSNzyZp7URnbtY1o1oskGcv45KIpAZJm9EalZLi86XQIm6uctkNTWOxyQWNHQ8lBMxuFI4Zt+fC+2kavyQJcxCI8kQJroe8zrT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmaevdNZlABMzm/iTBpcukEaFZ5SPA983fiKgGailbg=;
 b=n9ZDKSkqpP0oQ0bW1nxFOf/DLi8S8ptW/yx5OMqjbRCkEJBReOujfelm61lcwY9wC2vYEFP7ZwUDi3+uwpbAe3Ar864BLtvwU0l1WKp3K6TtATC1vkLD2iVq4VENfN/8qpYFnDNGuCszf7YBv8yy6//coOVXnl6j1qDSsgPWdek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:06 -0400
Subject: [PATCH v7 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-2-ac00b8174f89@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=1316;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l14lKtYuaY1+3koIMWZcDAe9ZGgSegJpQYHD4eJEreI=;
 b=nGTCzoSrnG9T+MK3JZPMjCgvuInupZ10wJn1acT2nGO4CsBe7gZMW2HOvPwHp2Rzb0k3fUhNp
 MF3yxSZjlFVB6oUj/n8/b6Jy7/TNFUwNgx0tsUaI3XadIeJ/M49P5BT
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
X-MS-Office365-Filtering-Correlation-Id: bc482cd4-f661-4da4-913a-08dc9f709a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1QwUWFVRTl6TmFrUmJ6ZmZJUEY3UXdMQlFIcWJDSnFvRi85bTZrektDR3hM?=
 =?utf-8?B?VXYvajBUa0hoTWd3SGFYTmxHV0FHOUFmVExIQVlONE1YMnEyWFI1NWZWZmpT?=
 =?utf-8?B?a1Z2VGhPUEdQMmlTRUFSRCtMTXFWUjhPeExyVUppUWM2TmxreGRwSFRBU2s5?=
 =?utf-8?B?T2s2SFdMMnpDQ1FwU0d4T1RlQkpMZUNEVW1kY3RFNmtKcGVNN2VhdDhXMzJS?=
 =?utf-8?B?Mi9sYi9abHlKQXpiUXQ3N1NMam0xMnpqN2QwZmVRVHRXdy9URnVhYUduSXFz?=
 =?utf-8?B?TjJWR1lZdkhBcUpndUhsMDVXY1ZuUjNpVjJaaFdhTnpPRzNLcExjTDVreWc2?=
 =?utf-8?B?ZzZKMFFyVjBaVjh4Vy8xQWIyVWdWR0xiaDNXNUM4WXRUUTJyTlFZWG96dVJy?=
 =?utf-8?B?cXZLUzc0a0JCT2VNMk02RmtDQWFrSUpMdzVyNS9GODZrYU5yL1VyRUg3WlQv?=
 =?utf-8?B?T3RmRkpFK2h3QTd3Y3NqUllDRUI0Smp6VEp6d0VDSW4xWTNmWGZHWnVSaU5o?=
 =?utf-8?B?QTlHM29XU0NNSy9iOTM3Z0NwU00weWhWMDdNc0V1RWRMd3orR3htcUxtZmVi?=
 =?utf-8?B?V0c1V3N4MElpRFlVQ0NrZzl6c1dZRVl2aG42ZGc3TWZKb0c4V0FTUm1ybTV0?=
 =?utf-8?B?aXZ4QXhKR2xqVUN5bnRsa2ZCYUpUN096ZUdsWndnVXJxVjdvcWJWRGpHQzNI?=
 =?utf-8?B?cjZ1TlJtdHNib2dpc3grdDJwaVlScjg2N1gvU0dlRTM3aW5XdmpmTEpqZDlR?=
 =?utf-8?B?MC9UOXExWkdKZTVHazI3V1gxQVd5bVAxS05heXFPdzlwQXFoUWd0a1RtVXFn?=
 =?utf-8?B?K1lZN2owK0p3TDNPcnBzTGoyMExqbUxQb3Bvdy9IZGRHY0V0YnQ0YnpqajdR?=
 =?utf-8?B?Wmk3ZTdGcWtJZWZ1SVdLRmdISTl6aUhVUXl5VHQ4M1ZubFRwY2dmMUdaTzdW?=
 =?utf-8?B?NEsySTRGaDV0WDV1RnJDQWlOU3pNQzk0NGQ4c2V5ei95eXBjSWh3cGYwRURh?=
 =?utf-8?B?ZTZyQU9BTklmakF5S3NpUGd2QlBlMnpseXFCZTdENDhnSXJHRVc2ajRNUm5D?=
 =?utf-8?B?MUMwcTY3OXkwM3l1VHlVdERyNlJlUjI4RHhDTDJKRzhhWThvS1hsdTdaMHRP?=
 =?utf-8?B?ZGFNZnFtcXJRTEhMa0VGcStLTG1uL1Y0Y1lJempXcFhYN1R2dnU1b0YrRTJs?=
 =?utf-8?B?bUNpVzFQZXJsTURnVjB0eGJPQXNDaDhOMmt2UTI1SG9vTE8zR2JlVFRSRUZ3?=
 =?utf-8?B?QXB0Y0JNRW12WWtMRE5ocWNQOVZiZ3pvdUlneGpvZ2tWMFBNdE5SUXpHYnM4?=
 =?utf-8?B?Q1JpOStNSWh3RTBZVWRsSkRsV0NtYWNKeVJxVThXdzFlQUphVVVzVXJPY1BM?=
 =?utf-8?B?THlUelAxVnI2NGVjK095UTIyeGl4clN5WHRlM0NBRHYrRHhjMkZPTnFScFN5?=
 =?utf-8?B?cUdGS0tjNmdacERwQURTNUpqNDlCY2hlUjBnQ2RUcjZuNDUrUEE2aWJickVF?=
 =?utf-8?B?UFpybmozUGpPMnF6TU9MT1A1a3d2TW9rVzdEWmFqMlBWeWpVMThoWEl4WWdv?=
 =?utf-8?B?eEVkV3g2b1BZWFR6eWhLRVBxRkxNekExdXVpb1AwWmk3U0s1MUZPd2NGZVJL?=
 =?utf-8?B?SWtZc1gzSHhMMjNHbEhCQVhkSkJJWjlHM2E5Sy9VOC9EbEd2UU51ZGZrWlNU?=
 =?utf-8?B?K3Brdmk3dlhSN0Z2Qi9qS0YwN0RDTGg1TTBFOXY4SWlhZUxNcHpJdWFnNWVW?=
 =?utf-8?B?STQvUkNTUlpNSFFJRDZSTFVKbldrSzNkc3pkRG1NOHhpa09VZTVDUG03YzdW?=
 =?utf-8?B?UGwvMzFHbE8rRjg1bDlLdVVyVDQraFBweVBKRlVTUE5DQXdrR2Q1RmNpNHdW?=
 =?utf-8?B?cHpweXNsSEtLdlpWSXZKODFKTHlrYXZ4OE8zUzVteWR3T0dpODRSd0RBRmlL?=
 =?utf-8?Q?YvtlC0FIjxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFp6L2NjYTRCS1BDelducy9kVk56MVovVnlLRTMwM1Byb1ZWRGp4SWVWbzlQ?=
 =?utf-8?B?WG0weHl1bDRNSlV0K2VBZXd0WWxxZTVDK1h3Z0ZUTi9HbkQ0ZmZmckJEMDFv?=
 =?utf-8?B?V0trTUZySlozcUtNcHlaclZSTndzcFNUQWFjM2RMT3RBMXlyS25zb04vdFJQ?=
 =?utf-8?B?WUZtK2xWUjduSTBWS2JtclJoaU5xdExjVk0zcTNKeWJMOSs1TWlIM04ySmcz?=
 =?utf-8?B?VFhycHM5Qjk2QVBFMEZ1YVhSTmgxazlyMHJacGVia3BQenA1ZFVENUR6dmhO?=
 =?utf-8?B?YkE2dHNWL1JDcXMvVEZnTjQxTWIzOXIyOEV2MExYR09SSk5rdXU5di9jYmY0?=
 =?utf-8?B?bTEwZ2dCcEhPaUh0STI3T0VhdHBPbzUxcEp4V2l6aUZJSUlBU1hpS01xMi9w?=
 =?utf-8?B?b2VteGVsM0g0SkZoQ0lKWEMwT2U1cGpKSThRdFZMcWszSmVGZ0hKRTcwT0pI?=
 =?utf-8?B?UHJVRzNFc29jNHpjektFTFJyYzZnK3FaQSsxYkZGOXloTzNlQ0U2cEJuUFp5?=
 =?utf-8?B?UVNRdEpGYUorNEdzL2FRaWxKbTFjaTNVdSt2aENwaHAzczlMSDkxYkUweHFS?=
 =?utf-8?B?M1JwZytQWTNMcUxacmhXTkpFcFdrUG04WTVtY1FCbW1RMzhaUWwyWVN6NWVl?=
 =?utf-8?B?cjBGV1R5ZlVnWUExdUlULzlMNkVGeDAxTjY0QnAxWndaNk83TEM0TTNzbVAr?=
 =?utf-8?B?TkpWR0N3L0RtOWJGU0lkcllMK0Q3TDRkemp6ZUhPTVRyTVN6OVlzcGZ3N1Bp?=
 =?utf-8?B?OGFWcTdNUndrclkrQnVEWFN0Skw3cjF5YjhseGw3Mm9JTkpRMS83WnEwWkVB?=
 =?utf-8?B?RGpXUVR1ais0WkJaRXhRR3BORlpYM0J5N1gzaDUzdXpSUmtncXZoUWtFUkNX?=
 =?utf-8?B?Q2xkNkFmVTNCK3RCaVRHMUx2V0dtR3RJdlJySFc1Z2ZqcVQzK2psUnBsK1BW?=
 =?utf-8?B?SGQ5MlVTMU92OCtlcWk4QzNBTXVIbW5WejlpZzdCbXFyeFF3akdWT0MvcG1J?=
 =?utf-8?B?UU9DdzU2cUFkTkI4YXhURjVGWFFSR1lCWnQ4bW1SYnpCMzc2SzdaRlhtKzZE?=
 =?utf-8?B?dzFCb0ZvY2MzVkRBODcxVTI0RThVU1F0dGNTR3BINkhESVl3YU9pdWZnWXhw?=
 =?utf-8?B?TG92ckpGbEZLMUQrTTRmUVpzU2M0Q2FxVjZSR1RlRDhZYUU5NDBSVHFkY2lP?=
 =?utf-8?B?Q2ZhNkFHVjl5YmU4dDZMS3NjN3p1SXdYbXB5bGFBdndXVDZhRy9aUXQ2cHFN?=
 =?utf-8?B?SjJ4QzVIaFRTZndpNXNsakordXI1SmNyR2FBRkVjNk92L29oZlh6WlNvc01I?=
 =?utf-8?B?WnBwOEZPTGM5bWgyWjJhaGJKdjRGbG56dHB4VHZUdmx3K09nQmkxSzU2V25B?=
 =?utf-8?B?UkNHRlJJUU1MSVQrVStaenBLZkVjeHB0NHZRK0pHSmQ2cEJxQlBjTmg2Ymtl?=
 =?utf-8?B?bms4ZHhyb2VLQjJaM1NabTg4ZUZQU3RERUh2L0UwVEF1c08vWlRKbFY1TnJ2?=
 =?utf-8?B?TzBRdXJScnhla3d5S1MraFBSK2RuTWt3VXdkVS93ZmVCRDBpWEF1QzN3V0sw?=
 =?utf-8?B?ZnVhSU9tYjgyZGhnbjRhTUtLVDA5OVdDWWNHUzZTOGNWMnVVem9xKzZaVG41?=
 =?utf-8?B?ZUtLYVFuSlpoYXBLTEVYRk5LMzBtZjFOUFlDSHo1eHByd002V2pQY0ppSGZF?=
 =?utf-8?B?azNzSzJUbDc1SUtsNUJhQWp6ZC9SODN2bEsyUGptSmFjbnFYbHhWQ2RRSWpz?=
 =?utf-8?B?YlhJUHJJWnMwRWR5NWtVQVUrZnZCYWIrdVNMQTNxT2VYeTRhSGZUTy8zUzlh?=
 =?utf-8?B?NkZFTVJWSEd0RnBJR2RLUkJWUmpuQWZ5RElERkE5QTBrTTVlcjVDNDFIVVgr?=
 =?utf-8?B?bG5MdGZHUUNqRjRsSWdzQlFhYk9JNzhOanhGTXJQc3BvbU9JYWVrbWJLYTVV?=
 =?utf-8?B?cklFTTZLRkZEc0wwaG93WGdMdUYwUlZOeHRDMkRIWlpJV0lGdTlDU3c4K0lq?=
 =?utf-8?B?SXNpcGJUVkhKRW5sUEkrRFJaUTJGWWFTbFBRY0hSbmFDZHBsYllzYnVoQUpl?=
 =?utf-8?B?MlROQnNxWU0vbTNTV1RsT3hMQXN6SzVvR0Z3UGFWblMxT0xIVUpNZXhsK3lo?=
 =?utf-8?Q?wy40=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc482cd4-f661-4da4-913a-08dc9f709a13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:35.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DU4ftsBgM3fdzyWuzx10FcUA8w2ljNSb4U1pS1cDUPSfhMgGPmMwy9/81fR6bzOeFAPA+Qq4zK9vJCMtqrH7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

From: Richard Zhu <hongxing.zhu@nxp.com>

Correct occasional MSI triggering failures in i.MX8MP PCIe EP by applying
the correct hardware outbound alignment requirement.

The i.MX platform has a restriction about outbound address translation. The
pci-epc-mem uses page_size to manage it. Set the correct page_size for i.MX
platform to meet the hardware requirement, which is the same as inbound
address alignment. Align it with epc_features::align.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9a71b8aa09b3c..ca9a000c9a96d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");

-- 
2.34.1


