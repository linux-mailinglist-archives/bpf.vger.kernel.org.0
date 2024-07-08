Return-Path: <bpf+bounces-34105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B992A7F9
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4333AB2117B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC114F122;
	Mon,  8 Jul 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XzdfQSpI"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394D14EC60;
	Mon,  8 Jul 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458541; cv=fail; b=J8+kdb8HgZZrkFiD7KK5BVAEtYptj6RBY/kBvIpMuK4tcG7R5OnFmzP/o8XxMgbi4zY64zpjybOKKWeeKVpoI3sh/e7cBE+bNW2urWIkSX4EvB5JwKMOhVmF9UDM0B0akT5gUKgAjpt6CXg4ygQIQsS0Imzuxfty9GJEQ8XH9jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458541; c=relaxed/simple;
	bh=HYIAvJfigWxKO1L6Jz/0Zv4JYey1PVy/pjpLATwS5So=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aL4U+XAn+qywrcDG2YTWVr6VA+M5C/UJMpIfCO+q8CtERZGKA7rPfxpCAqlwm+A3P1bPChs8MZbQ960LVKS5Ns0rd9oay6E8W99KQCtZl120YucNhTm809aU4cAcfnV8+lFhRH84NFKJS08TkoYi72CEXgDrOt7pRXZRm2ajyGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XzdfQSpI; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsniRIGsMcxs+kbx1tDEGCDoMQzY+efFZzDujfozsVDEFjvkL/TdmLzdqG/ePtYwBOl9WOQZ6uQMRy8Bn/bCYcVDNdhKi0d9mizGvQRoK6n3XhtNMiXNamrqXM4qR/NLkyEaMXhnSOKQzqepXmY2DzV5yzFM/fFrkqcXWpQ0ly+a2ynCNOOSPg0II0tA88WnoakKxytNNzGn7itQnwen/xeFUSh8wz5Xc2NZRv32LQzohXEwLK9lKSNZkd+iclmNoRUJHhl2oBM0NDiW9Cbw/G22BGAZLd1YHDUIGvaxPzQiAMkv6/AII2jG2g1/tetVMhyU5/a4IHRDWOYaygXdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKBaLEu48LO14iN2nWWWFdsRQ8bFoavwOXruitucuM8=;
 b=ZEA5fKyrkcEKUyivJEVDQfOPi+o0eok7VUNndvcKVKZbY5wSUDrHGRSk5m7Dqf7bc6efr5c1bIVkQxcHIQaxvijn/FdeSFpFYnMZ5U4koUoSGTsXGVkZdHwHURLBI8H1WzbBaDOyr0Sgae4UZ4OiO9ka9paZ0y3ZoLOTec7ihh8s8adnkwQXbxhPMpLsbZQTfmqN/gX32x41+cjqClZm+wGqJ17UzW3gsvG2znc05n8GFXGxqAyR8He4Abw+dZcy3ZrWgb5yLToREfE2XPHFwU3lzhqGtjMG0fmLpTmDhD14LzQXBkeIpRyZRb9IiOsJb2fFVaZWAryijnKJcEfIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKBaLEu48LO14iN2nWWWFdsRQ8bFoavwOXruitucuM8=;
 b=XzdfQSpIzLChIyVoCCKHvfA34fbPcdsusOZKmGMce8Dn4x0TQ52+XSoWKe+GoiQrq9X5nrPYxH4QzvfrOegC0RMTex1iFmNBrBccBhs2Wveb8LpRiuscNf4BtGg9Bmm7UN3Xp4UxXzqV1m+8P+hqKePNoMjB74OwnIF+L23KH2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:10 -0400
Subject: [PATCH v7 06/10] PCI: imx6: Improve comment for workaround
 ERR010728
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-pci2_upstream-v7-6-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=1845;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HYIAvJfigWxKO1L6Jz/0Zv4JYey1PVy/pjpLATwS5So=;
 b=zB561uGqJm9nhTZui6MMM1U68PXwoHQH8BtR2EZBHf3Rpp0ST6FWxRN8C+vTIapey65ukx+sv
 +lZ8aYZ8JQ3BE9WmsC8srI8gRS5oQ8BINS8GldYQ1YI+RbVPjchD9g9
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
X-MS-Office365-Filtering-Correlation-Id: 0523e833-4fe4-420b-7ee0-08dc9f70a72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHowNDdmbVVPcERqWWJxVFRKM084cEZhVlQzdENBOXJOakFvV1FoRjBCS21n?=
 =?utf-8?B?ZGN0dkhYMVdDVDB1Vm40YWtyNkg2dDZQQ0VuLzJQbVIyc0NrcE51TzdoQm9k?=
 =?utf-8?B?L2htSng0amVaOEtIRWVhV25kNy81bnJYa09jcDU5L1Boc3VSZW9MTFhnMno1?=
 =?utf-8?B?bXZvY2hxSUJ1Mk14VnBlZDFrRGR5ZmpEdGUrZmR1VUlwOVdwWGxHRktDdmpT?=
 =?utf-8?B?U2Vob1lDTXA3NDNTZDgwT0loL1hBYjlPMUZpM0R1RDI4b1pJaDhER1ZRODZm?=
 =?utf-8?B?Y3RFQXpmaHRKM082S1pNNGhZNWdiQVdvYjRYcjYycTlCOE8zT1ZuSGsxVDR2?=
 =?utf-8?B?N3c5eVNnUXhKcXU0WHMyOVg0MkxsekRwV3dGWW1mY3BXR09RaUtZZDZkbmVB?=
 =?utf-8?B?Q3RsOWVNa1h2Wll2MTYxbU45Wm8vRHFGclhYbEZGU0dBeE13cW90cUQwcXZh?=
 =?utf-8?B?aHhxbllFOWpPUUlsVEV0dEdmMW1MOTdGQjRVelg3TFFjamxXcnRzcVpCVWxk?=
 =?utf-8?B?ZERia09WZG9mUG1iOFlGYWg2NDZsU3ZlM29BOVJwK2NVM2R2QVcyUU5HUTRQ?=
 =?utf-8?B?YjZWNVZ5KzRNdDRQKzB5L3dYUkxzR2pRS1VKQkZoUjhLVnBBOE52d2tZOERh?=
 =?utf-8?B?V3Y5WUxMOW5XL3lPSzNNNGNrWG5iNHNhWGR5bmR6WXhqandlQmlCZnZZcWJu?=
 =?utf-8?B?YmFSOFNEVXNzdWlxenQrZFltZTc3SVkyQngydWE5N1lWUDJSQm1CRnFXN2hn?=
 =?utf-8?B?YUN2RS9pcE1Ud0x3VTZ3NFMwZHNDdHVOVnBLcHhWSVFxMUdzZXJIaEdIYVFx?=
 =?utf-8?B?UzZKUzFVaVF6akw4dzM1RWMxRmdHeVQ2d1BIWjJ3OG5kb2xNeW5FM1VFbVRB?=
 =?utf-8?B?bjBxSk1sSmpycGVVbm5SaWFCUGhIQW5lV0VGRGV1LzFVVWFCK2t5Vysvb0Zs?=
 =?utf-8?B?RjlmcTFMaE92eW8yQ2hCMnBidjlkYWt5VndiMUROOTFEWUN0UEptY3FBUzhD?=
 =?utf-8?B?eUJzelZyeXZuT2E3WWg3bFhVeVBXenZ4ZWIyMzByWWxnNUZzNEIyNm5FdEdz?=
 =?utf-8?B?WFhGekc4S0tkUmZZMHN4RnhMM0tvajU2M3B0bWdRL0tyRW9CeS9Hb0FLazZw?=
 =?utf-8?B?Z00wNmo1d1dJdnAwbmJjYVBtQXRpamo0L2xSWFRuOXRIYU1qZEphV01SQjU4?=
 =?utf-8?B?aTBxTWRCdHVlS1NvcHRWMDN2aWh3MXEzVXZ3L09UWUVTeFBBclVDWStiUStN?=
 =?utf-8?B?SHVBK3EyNXFnaHRWQStoZVl3dHBEQnVydVpDS0huK05SdzJQWkhacWI1Z01h?=
 =?utf-8?B?bXF0ZnBxK2hFSG1BVHBUQ2N2Y3BJRzQvU09hMWdEejU5THhUQk5ucWlLeWU3?=
 =?utf-8?B?bGI5Z1lPR0tlYzdlMVhVWVF3ZXVXUmpJalhSLzJ0ODYvbTR2NVJZMnQvMkZr?=
 =?utf-8?B?NmMwSGZTUEdsaUFGWTJmbXpydkFWb3FrQS9KTk52RUFoZTRuQ1dFYyt5U1Q4?=
 =?utf-8?B?ckRwNG1aMDNaY096NmZjckR5ME04eGFBeGMzN1p2cktxREJ0TnhLRTk0cWtW?=
 =?utf-8?B?STYvTmEvZ1YxTytpOGpsQk1ocERSZnhMdWptK3RUUGljWmhLQUtaZHYwVVdt?=
 =?utf-8?B?aEV2enFQQ0dGUFhWNkNmbFJqaGxIa1VPQ0RMZkl0UlBCOE1mSitIN3Z6WE1I?=
 =?utf-8?B?clN1MmhiUlQxeUxPZ0E5N05CT1YwaEhHdE1sbVlSMjRjbTltSytrRVo2S28w?=
 =?utf-8?B?cDlhNnFCUWc2TCtNL3hmeDR5UWhHMmF1Q3RoTGVONW1rWjAwM2VJSWxHNElB?=
 =?utf-8?Q?+l6tHYOVxAkg43gacarubEaiFvcYQFW1GUvYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZRMzAvbVN4TkhlR2orVUR2dkYvdFE1R2ZEYVFCdFl3TFBmREYrNlhXQis1?=
 =?utf-8?B?bHJISFNpTGxnOTJ5b0V4SU9URmF3MEV3RWtZOUlhNlBzc0JFTnVDKzQ3WTJq?=
 =?utf-8?B?RUtNdDVuZEF0OTUvM0FGTEVWN1hjTHlGSzltUWhQSWJSUFczTDRISERFNVVD?=
 =?utf-8?B?OEpuYUpaYWxpeTZrTE9rNUo2a0R1YmRMRHRQMDRnU2Fjd0RQOGo4NmdiQi8r?=
 =?utf-8?B?WXBPT056SGV2Q3lPOTU2aTlsMjdFcXdJbFMyVVdWQ3A2SHZDVWZzZTV5QXpP?=
 =?utf-8?B?WlJMWVJPMEdQcnZjdGdLRkQ2S25YMFAxakdDK09PcFVleHp5cUJGRllZdjBZ?=
 =?utf-8?B?SlZQYVZ1QS9ycFFkeWFmN2luK0dnQ2lGSjNycGNKR0VJQnAwYTJwWXNuRlhQ?=
 =?utf-8?B?QXpOb2lId1MxTm9yVDJPWk1qdUh0azBvQWRwMDlWMUpwRFBMWFN4ZDBPN1JW?=
 =?utf-8?B?dVM4Uzl0MUNzNlF1VUgxakFRWjBnckxsU1NHUm16SWRqb0xrNVhrQnVzN3Ix?=
 =?utf-8?B?czFLZDEydkFHUTZkV3grajhhL2hKc2d2WUp3Wnk0U0ZIS0ZETzkxQXFZbWFD?=
 =?utf-8?B?UjBrclduamozN2xFRzRFTytCSU9paUVFQyt0ZUNhNUpLN2xHRWRPTS96cVUz?=
 =?utf-8?B?WWczcEEwK29RMEMyVTNxZHI5eG9JQlJyc3dkZHhvKzRmRytqanI1N2xyMmhx?=
 =?utf-8?B?YkhtOStWU3BFWWFVQUtYaVo5RlhkUm9BZEV1dW5neDZKWXU2ZkdNUzhaQ2dM?=
 =?utf-8?B?b1VpdmsrS1B1dTRqMVFNZjU0UWVHMzFKQTRiVERSei81WUtqTW56c0wwdWhv?=
 =?utf-8?B?bDBYNGNyRnQycmdKci9vSktDbEVoMFdjdlNxcXZSVzlmVjJVWE9WMEttYVJU?=
 =?utf-8?B?cFBqVXNETlNFbFhFUHQxR0JWSWpucWFzbTZkYkdUQjdyRWUxWWZTbnZ2aks1?=
 =?utf-8?B?MHB6emphQWlHOWU3QU8vTyt0dFVoNVN1M2FRQW4wN3F3ekZ3TytZQWp6bWx4?=
 =?utf-8?B?VjRPdHZmQ1hPWFlTK0RLYkRxQlo3TkltMDV1RFlqclI3RThkMmljQUw2M1Ay?=
 =?utf-8?B?dkhCczNaTzJSRmhrWnhrK2NLcG10VHNUblJIQWlMSmFuSUJ5NnluVVhrZnVK?=
 =?utf-8?B?eWhKdGhRc2dWUjA3NjNUY2dSVGFRMld0TFJ0NHYyUVI0bW94cUZmSDVNdnNW?=
 =?utf-8?B?WEhxSllvVkxPSmgwTHVKbkNDeE5RRUFGMUxCYVRRWnh4NTY4WXF6Vkc1NEM3?=
 =?utf-8?B?alV0aytWTklra2ZkVEJmd2JyT0xzbkFxRU9TOW55dDRIWEtxazZKK0xNYmRn?=
 =?utf-8?B?RlhaUGtaQjViZVR1WnJtWmRwd05tQlZ0cHZhUTNNUlU1QVJVTHhuWWtVdm1J?=
 =?utf-8?B?RkZadjl4MTQ3THNEQ1lua01ON3U4OC8wdWo2MldYcmNiU0xia2xBQ2pjR1BJ?=
 =?utf-8?B?VkZMdXF6YUdWTWVFNUJ5SGJNTDhuK2xtUVRGTWxXWWNJOHBjUU53TVRid2hx?=
 =?utf-8?B?YUlJNmtBeFp3L1pIa1E4VzJoL1ZhcHQvZ2I0VkRsRk83WDFkN2lkbmljTHRL?=
 =?utf-8?B?Q0NDVHBnYzNJeDZ4anZvZU5tSUNOM1U0L29weUJaZEtFcUdaSWxBTkt0MGJm?=
 =?utf-8?B?RWpxaW1xbkdVc2g4aWpTQ2oySzNWWm04SEFmVm9DWG91cFFLMmhMd0tvbnVL?=
 =?utf-8?B?Mkl1aVRvNW9tWGFKUEFxaEdELzNyeDhtN082UTNuUjhpclBmeGhYenFJNkNm?=
 =?utf-8?B?YWtQclFEbFZiK2FZeG91UGM5YWFkdmlTbUkxY09VZGtDQkluV3EvOXlKWG1w?=
 =?utf-8?B?dlFkcVVwZW9odG1nQzVyWDNmcldmMTZMamZ4c0N3c3JUU01LMmxHU3poMlhX?=
 =?utf-8?B?bXVsNnd0Z0tSblY2Z3F2U1IxMVdWQURidStOanUrdkpiR3JVR0l0ZjdRM1lu?=
 =?utf-8?B?K2NpOFlpUi81S05VNy9aL3RxN2wxV1BleDE5cmZvK3F3ODY3a1VZZXEvTXV1?=
 =?utf-8?B?ZmpjUmZuR1BUdUxQUVRCYmJRSEpOeW9iRE42VlNRMGVlblJ5Yk92b1gxUTNB?=
 =?utf-8?B?MzhpdXZrSG9ua0tvT1dMcFltNkFFTXB4OVdYV1ZRaTljY2l3ZFh3a1RiZktC?=
 =?utf-8?Q?dmJo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0523e833-4fe4-420b-7ee0-08dc9f70a72c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:57.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th4zguyJI8cE/hKvw1Y2X2JX+ipMsljqKK6y4tmObOIcdEMTs3zEavs/u2XIaOcDPzSlA8LU6T4UqWbumb7GZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

Improve comment about workaround ERR010728 by using official errata
document content(https://www.nxp.com/webapp/Download?colCode=IMX7DS_2N09P).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2c60858b74a09..2b95c41f8907e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -714,9 +714,26 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		return 0;
 
 	/*
-	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
-	 * oscillate, especially when cold. This turns off "Duty-cycle
-	 * Corrector" and other mysterious undocumented things.
+	 * Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023):
+	 *
+	 * PCIe: PLL may fail to lock under corner conditions.
+	 *
+	 * Initial VCO oscillation may fail under corner conditions such as
+	 * cold temperature which will cause the PCIe PLL fail to lock in the
+	 * initialization phase.
+	 *
+	 * The Duty-cycle Corrector calibration must be disabled.
+	 *
+	 * 1. De-assert the G_RST signal by clearing
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_G_RST].
+	 * 2. De-assert DCC_FB_EN by writing data “0x29” to the register
+	 *    address 0x306d0014 (PCIE_PHY_CMN_REG4).
+	 * 3. Assert RX_EQS, RX_EQ_SEL by writing data “0x48” to the register
+	 *    address 0x306d0090 (PCIE_PHY_CMN_REG24).
+	 * 4. Assert ATT_MODE by writing data “0xbc” to the register
+	 *    address 0x306d0098 (PCIE_PHY_CMN_REG26).
+	 * 5. De-assert the CMN_RST signal by clearing register bit
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_BTN]
 	 */
 
 	if (likely(imx_pcie->phy_base)) {

-- 
2.34.1


