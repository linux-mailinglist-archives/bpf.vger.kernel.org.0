Return-Path: <bpf+bounces-28934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10278BEBD9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E463B1C21360
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30902171085;
	Tue,  7 May 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7Hl1ujY"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2016F911;
	Tue,  7 May 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107641; cv=fail; b=D/rD1V/jZpOCJqTWifu1G9sSzYdUmSBLXxAU52PLVfW+38gJXp3YdT/SPtSVzYlvtCkxODfGbFrd0OGnD+O5btTZ0H4NB3NYZA0PjCk6yd03JsgSDcMy/4GslIVzOotHUolbulcJf4YmueDegW5x7+NY0qS8IWIDK35LZR3WnxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107641; c=relaxed/simple;
	bh=ZVcPE4dOaT6EXgzn2/jF23hc8fTkYFYmiyfbQxh1zCA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pSLKIESrBEV9Y/lZqI9V/7hwQqUuH0OGX5IAj5hkG8Z5h1gewfjKTB9Nq+rHZdpSly1ebaIkseq/ISHD54vLfjbwjAqNUOofIm8URxquHDF8cCgdfnlGDMGmOrq2lm1zLLOj2FWtewScbiCBh1vL4pYUUataqFDSzyOkb+rcYNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7Hl1ujY; arc=fail smtp.client-ip=40.107.8.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFasrKR8D6WtKDiUrrj9XwOdVh0t/oUD1WGUVUhDnuDPW2Ku4ISPE3602NeRYdHXffcLDTRAt8LAxffehCIck0sI4IJEI9fsfR23Kz0q+sqf+IZmUGrKLTDBAC/7uQ6p+W5VM+unOmVF3RD84O8SNhAiKJyVVaHzfkjmI4JT4awghpsOJ0acmp+XtDoGKz/iER5fA9254mK3L6PO1jKLKTbn0uyOT5r44f4/xnIcyyFo89A6XsOZRIU80ewRBARBZbbtESdoNmPVfh6egfDnynaGo3+k3kQ84jQ6wLOSxVzd/sMLIKi+qXPMEp1iTUU9uGBnjbdacjDr3ao5abRk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7lkqnRaz7I/AFHpfK0i9KlaovJZS3cHmfRuCx3nJQY=;
 b=eIWMUNVoiFyYGlpEJ2OH1TG5KCKGi6L/C85O+DRsTBNAYIcEwkgn53xWu4EMa2vNat1/hQCrueE8sYNjRMO4MkC6IXbq+toXC5jB9J/sAcsFglgfuevcsAE4Hoshunz42yrLYLLGmd153gw/cXMUBX2KqUIqhhF0VCPdQq931mi/ZnSwUlpIhWz/VFjSIqSvUsot8abJ2wx4oHfsjyMe4EwKx6glEYxBWLayuOW2T8rRO+9nlT6L04TKnHYB96IBgWk1q+Ns37GVLejhdx2sghO6pNOLpPikGPk+ABjYkvt+OqIzUPdm5Zb/zISaWt7VGQsooP/UZGqenC8nFNDQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7lkqnRaz7I/AFHpfK0i9KlaovJZS3cHmfRuCx3nJQY=;
 b=b7Hl1ujYtM7kHYXgbC85HYhYHnZ8PqiJys0/xCMDhPhbV5hcHxu42eHeUjwLvhFRdel/IDHxbEIaoTKOIb2KDl7zHfs5kpzFKhR1Bz36FPoexl7JHuDNgxZuOvXUE/l61Jsgn72psqablaRPwhuYY18Or4EmwoAI9xHB/9oEPjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:47:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:47:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:48 -0400
Subject: [PATCH v4 10/12] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-10-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=45O/Z6HdjXbmyLNxdhyNfezc2z72stjqhDhWD7DVlek=;
 b=9pk9TRw5qEYgwsxJrNxHDYiTh43vqgWOHK938A44rBBYbM7vWaJHd/zzudI49yRJ8//CaX5LF
 pmOpASngQzKDivvBF/E1ajxzTZmDkCZONYujc1tO7MVcF3Te487Wn50
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
X-MS-Office365-Filtering-Correlation-Id: 7a8e12ff-fde4-4613-d1b7-08dc6ec61dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFRrQ2pEbXM5Tm93Ly82YnBrNWNvaWRnd3BXblZObm4wUW5uTzg5SWdURHZp?=
 =?utf-8?B?M1pBQldHR0VkVGQ5c1VWQkVRZFdMUmVkeXJ1NmVRalZrZEpXUFFuMlFvUzU4?=
 =?utf-8?B?OThBandTVmZnV2cvMmJjVE1nYWJEdkdaTTJXM2o5YW9CMDQ0QTFqOWxxcDZT?=
 =?utf-8?B?bS9Eck9TVVFYMTMyNHJ3c0hRc3ZaOWJpUjdsMU4vZ3ZSMDdtZ0I1SWE5WGwz?=
 =?utf-8?B?L0Zya1JBOWFFZXNIZmJVdG9nS3p5bXBOL1ZsMWhISUVocU1oR1BIbks1TkFX?=
 =?utf-8?B?Y0lPVjROdzIyaWhWRlpiMWtvWitzbWtIaVZCWmlkaGY5M2NGNW9EMmJKZW9J?=
 =?utf-8?B?TmhiclN3SGJPZEV2YmhQN3RGNWc4dVVNaDl5N05RU3ZNditUQW9qVHVmaWsy?=
 =?utf-8?B?QUdFc1REWWJwSU10N1pkRDBRbTlNV05Jd0JNMzV6SExIaVIvN3Fvd29xWnQ2?=
 =?utf-8?B?Vi8yWFVqME1iMHJObnpPQ0IzR1dPMkNtL0F0YnQrTU5jSnBpbzNnSEZidUlZ?=
 =?utf-8?B?S1RBUnd1L2ZQSkxlQUNwa0w3TGN6OVlmUFJmQTF3dG1WVm9VdVVsa3JEcFVC?=
 =?utf-8?B?UmFmYjh6RUx6UWVHcUxTYTRmR3FCakk1KzlpS09pQno1RW02WXRIdVVhSkhj?=
 =?utf-8?B?OWdSMllHMkpGZkllRWdJWU5OSHFGRlh1ZzhiQUdYVE5JN0RtdkE3MG85bEFZ?=
 =?utf-8?B?NWlodSt2cDkrZlVhMURtcU1SRWt3Sm9Kb2lMVE1sa283ZzVTV3pDR0ppRGlN?=
 =?utf-8?B?Y21kaW5YZjZ1L3V3SW80QUhlbmtVRDFYM1NENDVIejFmLzNqVHBWVVFSVEVE?=
 =?utf-8?B?SmIrbStHZWZKUVE5cjNXdUM1SnArdlQvY0lLY3c5WUk2YVlJSWpYSHVxNk9W?=
 =?utf-8?B?WVR2NURaWHdzMXVPQW5RZm04SkdTVmFWLzRhWlFVbmVTUytlblhTWVJaK3NC?=
 =?utf-8?B?Qy94MW5MVlBjM3ZaOG5vaUlsUDhQQlJrL1BNRDBvVWRLYk55RHBJb3RabVRk?=
 =?utf-8?B?NEsyT2F2Z2N1ZFBYUkVRSk1Hcy9nVHhjNmw3QW0wcjhDMjZOOGJVQmRqTXJF?=
 =?utf-8?B?L3I5dXlkWTlTOVc3dytjVFl6aVEzYnB0RytsNlVMTTNZRGxGOUdmK1NPSnNk?=
 =?utf-8?B?Ym1Mc1pWWDFJS2NtSXgxVnZGaVk0T3NFK0h4SzBESUdiSm5xWXhFWHV4VzdI?=
 =?utf-8?B?OUJESTJtc3JrLzhhNFAyNFBxRTZPS0d2TGhkVHVTKzAyWHEzb1ltWjJHbENj?=
 =?utf-8?B?c015aWNjZDcrdEJZdEtFQWs1SFRHR3lWd0Z0Sm80cGVFbG8wQUMvRVUyWkRE?=
 =?utf-8?B?OG80RjNEZ0RwRmEzVUxwUUFtSWFxZlZkYVVGUFZ2TXVVMTUrQTZCRlRqd2hS?=
 =?utf-8?B?eXk4QnpIUkx2TFZhUitKbk5mL0s3UkVRcWZtVGh6NiswY2lsWEt2YXBvN1A0?=
 =?utf-8?B?QUU0c0xwejhLMUcydkhYRzVQZktyTHhnSGRKZkFEaGRoeDNkQW5xbW12Nkkr?=
 =?utf-8?B?NHMyS3RDTmJycUVWRGFhUUp6d0MzL2ZuWjVoeTBiZDUvc3FlSGl2Y0J3UWt0?=
 =?utf-8?B?dGRCM2NLSUlEQWN5MWJldS9PUUlIem1Hb3BNWmtWVC9zZ2NldzlpMTRybmRp?=
 =?utf-8?B?Y0Y2UU9pVGNaS25EL2RZMldxclVlbTRBVkd6aFAvMzI5L0ZiVkI4aytGb0c0?=
 =?utf-8?B?ZXYxLzJ4YkhxNzQ4SWUzakhja0hiVnEzbkYrcXZEblREYzBjS05Gd0VFSDc0?=
 =?utf-8?B?NzFCbG44dzRYcjlvODZNTTBGTnJrMy90M1hVUGxYYkdZUTgrTDFlOEEvYlZB?=
 =?utf-8?Q?A0sOthQzknIDPAh2VKvd7MV/V3O39WCNySsBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjhLWHZaYTc2QlAzWWlUd2sybDZDNGhDbTZIUDZiQ3VWWGFkd0t6U1pmdkdH?=
 =?utf-8?B?QnhSSS9sWGZPcGNhVnJvQ1dQNVV5MVhGM044RVVSTndLUFJ6SjBlS0dOcUlm?=
 =?utf-8?B?RW9aYUMxMGdDRVk2R2ovRVNYRmZPRGVMblhENW1WZ0tDYVJMTE9TOU9Mc3l5?=
 =?utf-8?B?bkxRQzl3OWJVNGtxTDhmZFR2eHdhdlBJL2VTZkF3QUJCdG01N0ptc2MrOWsr?=
 =?utf-8?B?em5MckxrSWRMSDhhbHJiZVpCaS9nZ3hiOEN4Si9aSzc5QXFRKzV0ak1QWkhN?=
 =?utf-8?B?Yk9hNmpPRUNqNXI1MHh4a2pjL2FZMGZ1SVFKc2F2RDRHdUJQcStyQlNIeFdt?=
 =?utf-8?B?b1hHdWlJcVNCcDlMZlNVT3BKSUNIVmZQRHNXWlNYUTVxMDFmU0twQzBEanYy?=
 =?utf-8?B?OU5hamJjU2dMc0NHcTNLMWxsZG04OW5BUkJITFJUZGpCRXdGa3pSaVB4Wk5E?=
 =?utf-8?B?azJGQXNiQUhneWRVdGRxTzFRMEVSb05jQ2JFdk8wamxLYVBVdHNVTnUrV09R?=
 =?utf-8?B?MDAzOU9iOXRGMEEwdzFGOVl2RGdiNENndDRvWmdnMHNWb2xmQXF0UkphZytN?=
 =?utf-8?B?bWh1d2NDK3Q4Z0Zyd1hMazBJYnJGM3BnNmJVRmNJWVBnQ3kzOXpxTzFKRTIv?=
 =?utf-8?B?V2dveFl3UWh5ZEhwNWsyMUpEOG9UMVZ3NTd3YmszblB1azlhaSs3VHlBb2xO?=
 =?utf-8?B?SGdmZkRPRDFHa1YyS3lwTVd5cVRZVFFpWEZCdUgwSk41Z0Z3aW13RGg2V215?=
 =?utf-8?B?ZCtGWkw1MlNSR2pWcjIrcmxaVDJQSDc3a2Q2QmJkbkp1N0txZ0s0amVRMTg3?=
 =?utf-8?B?V3NMSjBGZ2taKzBKWkhmTkQrZGtWanUrWmpTSWZJcFpRZU5ENjRoNDhsSk1u?=
 =?utf-8?B?dWV5b1ZsT1A1Um43OVBTS1pQL1JSU28wQldKcWk2MGZXVklmbVp5T3FKdzVh?=
 =?utf-8?B?N0NQTlVSTXFUV1V6YUI1d21GT0tWbVdZS3JzSlFwUUZmUDVJdmRlTHhhVzFL?=
 =?utf-8?B?Vm5mTUVxL2FVWjhNOUtBL2JITmpxNklxU1RyalZndlpjZEFHVmYxZUM3bUVF?=
 =?utf-8?B?c1NGSXF3NmdtV2pueEVPK0dZN2liSUpBVXNoUWVBVlVNMlFmcVpxUGlMYUhP?=
 =?utf-8?B?cWp0d2o0SXl0ZEJMSEN0U3BYUk5Xc25LdWw1UUVZK2NMc3hqTDdBUDZ5Mmta?=
 =?utf-8?B?T1RpRWx3b3g0VFNQQlZJeU9Vdk84V0xnOVc5Q0NFbzFmaHlGRE4zczNVeDMz?=
 =?utf-8?B?UTJaY0RCZmxKNTBCNnZST0JUL2F6cGJrRVF2VUQ3MEdHVDZKQ0NsZGdSSzhq?=
 =?utf-8?B?V21QNHhPNWFsSjByTm5iQkVhY0FicCtNYTdPYWYrREtQNlVaRGZYaFN6RDBU?=
 =?utf-8?B?dnRMSWU4U09TQmpZOGZPd2lwa2k1RHJHS0JYem1XdFJsRWNwQ3RMQWZJK291?=
 =?utf-8?B?Ump0d3B6Mkc4RVZnbzlvRjM2aEN4SDhEclRKRFkrYVR0TU1WWlFEZGdpbWJj?=
 =?utf-8?B?S0EzekFmVnU1MUhHZFB0dDJsR2gwY1JBWXYvUzg5NmowMFNqUElFdXhObnRW?=
 =?utf-8?B?VHJ3UEd1UnVqN0FpVjg1OHppREtlNk5ndW1mamo0OXFlLzNsdzZkOE9sbE5N?=
 =?utf-8?B?SUwrQTNiNng4UmVKa0NoeVRKUEI5ckEvOUY0c0VGcVJtYXV3aXFhY3BYNVBi?=
 =?utf-8?B?MnQwYXJmYWo1b1BjazNwbXBBVVhRMXFpdFNmQVlyQjA1UzNDZGUwKzNCVnkw?=
 =?utf-8?B?alF0Zzdpdnp5Wm5YK0FQY1VvS25qSGFBWEYrc0NkNGpBRUo4RDZKVEoxNG1C?=
 =?utf-8?B?cUVwQ1drRURZQTY5QUFKTmVqOWpqdzcvUmxvY0pBZDlvSVBHSEhEUmw1MllS?=
 =?utf-8?B?K1E4TU1wcE5ENG1tS1doRGRpV0VCMUtsdGNJZmUzaUVKbEIrd1ErS3V1RG5r?=
 =?utf-8?B?akFteUpvbzVwenBjbDNjVGVZK0ZjSm9vTit5bEZLNjR4Qjd1L2VzSHE2a1NV?=
 =?utf-8?B?Mk1la3ZKWjA1YUZLVDZtcWRjMnhneStFbExjaFFtMnltaGdoMHFDVnBpbHdK?=
 =?utf-8?B?TDBPc0VIY1VWUGJ2b0d0VFVBWUE1K0NETUY3b0xRWURiYThpOHlYOVZhUWNZ?=
 =?utf-8?Q?7XOLP2Aagp1ngqwsFEH9KLEcO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e12ff-fde4-4613-d1b7-08dc6ec61dfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:47:16.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x504eAceJBE+apObBX5mrBRvPW8E2lE/i/UcNOHq2UZ/rbws6L4s+J2ouTW7AxOGumfaDU5XoThEeQctJzYIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
common naming convension.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
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


