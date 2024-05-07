Return-Path: <bpf+bounces-28924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C58BEBB1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9230CB21632
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACDF16D9A8;
	Tue,  7 May 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qmg+j20y"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF34C8A;
	Tue,  7 May 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107587; cv=fail; b=SgGNcgAT/mgF46jHxhsfqjcZOJzDQmuayOztJGWBpWPsUyj5kxOFRr/sqXwTt6S/R7yJxX0grm9mb2bHUWL9n/792ZTldueJcmJnh2jOgXGzYNB/0TwESUJWDkvDM4syJpBshpQzUGu12EiZlyvTCUc+mJXgkj6vooiZOW6tbIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107587; c=relaxed/simple;
	bh=I2hxRxV57L44y/Ar8CfZiNebGYImVGD//kpc45Axens=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GTPEUziUxdD2MCIVDDWnMNnoPOtVJxdvklfx33wUkgvkTdUZXa+FYkJrqCTiqx7G6UrUiU63bV3+GNrjfKfRTLsYtnDndLExeHeoEQ3J7luOG3u2VDpkPb/4kEw7vgMYetDPJ9vijw0CcxfH9WoJWycrRst6L6bm6JS2VKAB8KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qmg+j20y; arc=fail smtp.client-ip=40.107.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD+L+ZL/0nRk4Bmnp7VZoKoCVBbRlzBSoC4lL7m9TuK23cIIC4td0K2IUbM/rEAZrZz26uEMJsXz0hJs5A8sif9WFvYQ78LGn6Ia4sohqRQmSg08iKxceesJBY4XV7YSN6kHChrlSu8KnP2nGkzK9KhkbAnT7oAoPfd9vvuBG9mpkMxlwl4rlzbj3QTCNGTEaOKXZU9n5PQSHaZF2sSFu04Pa2j99nHTzDjN/OGRKoZHbSIdLsnraOKDDqTAESFxWMTEIsTVeXrhOZKOA0dID+72ABQilFD0ZIPkKHCQIGzuiAzkxibnOXnuTjVxqgqKWLhYEsyZlwlIkpFs7FWFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhnLvYBHJxxqQ1rLgIAXVA9l/t8FfB9pCt3CyrpMmAk=;
 b=fFzq/CeAN2bpiRkscAYHeb/n3I9S1k0TAq0V3jcYAItQpw/H02ynGn4ukedAA+gcYxQTseL1Fkg/LGd20ZdR1ZGmsGj4aaOUsA2RAIrVohssKbnFKsgoCsfdSuTXtN9YmfbOhgabkCvrcGFbctr7gKLPLOFstO3cF1Zo6jbzXxuq5F7ob1bpCFcPOou7d1VHLlteGTpHy1CNuVfSjb1Qu4xs6+SlAiOnSOltWutCtm3+ICB04JUd/AqGvrLBWNZiYU92PP/yNLLXzZg3TuweZUMT7WdxEQy0nq/2WQACilyn7CT77jmHjG9wAYYlrvNbdFM58RTDu6Jv6XfjpTjB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhnLvYBHJxxqQ1rLgIAXVA9l/t8FfB9pCt3CyrpMmAk=;
 b=qmg+j20yGjoq7KDQXaIh7rrldCQc2OLEkTbSiXLXmOn6QhXr4KKi7/6y6ais9Qwvxty0AB8JHSElPFFZBFcktv/R+lqNfy8NBsXNgLX0+u19VCquxY211MVktwIeAGZxKoS1ZJPOJN6MdEcvX5jGqWVJvpRpaz6T1U4NNuPisrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 18:46:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Tue, 07 May 2024 14:45:38 -0400
Message-Id: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANJ2OmYC/3XNTQ6DIBCG4asY1qUZGETbVe/RNA0CVhb+BCyxM
 d696MbUpMtvkuedmQTrnQ3kms3E2+iC67s0xCkjulHdy1Jn0iYcuADOCzpox5/vIYzeqpaCNoZ
 dFMuZRJLM4G3tpq13f6TduDD2/rPlI1uv/0qRUaDVJed1iYgS5K2bhrPuW7J2It8tgjhanqwyU
 OjcVtLI4tfibtPno8VkS0DBRGUqgbDbZVm+hyEVpCABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=4795;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=I2hxRxV57L44y/Ar8CfZiNebGYImVGD//kpc45Axens=;
 b=+XE+jiu1fT1jxHtUOK4RuWcPWUUlv7jngL/fKOthIjRuDVf1I6TXQ+EYykCZaUKHHSOyQcT1p
 FW4+bksL7WCDdSIJwcbZWP9aIQYeagQwng5p+zMjOonN6VVNl1AdGVl
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: ae20b9ad-e65b-4f56-9a7f-08dc6ec5fc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHEzYVBvcFArSkQrajdxQmQzRk56cXE1bjJVc0tHYm1oMXE5RlhpTkgwL21h?=
 =?utf-8?B?eHlnTnpNbXgzazFQTEgwaHMya1UvUXNTalNpNkszU1NqS0xEaFpKWHltb3kw?=
 =?utf-8?B?RTFZSXREVmhPYWlFVFZtc2JQRjdhUFNPNW1UTUZIUk9MY3NPNm5ETU41QW44?=
 =?utf-8?B?bmZVcnJ1TjFrWEpGV2wyaVlNc1hNOE4rWVJ2Qm1rZWtyTjE5SS9uaHlGVlpC?=
 =?utf-8?B?MzFzVWFoUlFXdW0zb0wzWmorOWhLNzkyZlpSYndMLzd0Mzloc1J1WWl1Q3lM?=
 =?utf-8?B?OG5sRnlJNUxqTUJ6YjFpVFdxL2pvamFMWjlJUjVWN1BDS0ZmcTY1b2VWdzNi?=
 =?utf-8?B?QWFRS3gyUy9aaTVDaklSVDNXamt4ZFQxQkFWMHlFR3lYd1E3c1E2QzlmNlNK?=
 =?utf-8?B?SktWWHVDSWV4a2FOSHpOODU0QjdvNHBKaVVpN2xHUStBS3lSc3R5YnQ5emNX?=
 =?utf-8?B?cnVWZmgyN0dURnptSU1HR0R3VWUyTWlvcjY4ZExKZ0RzOWpzRU8zSG8rQUVv?=
 =?utf-8?B?dmRrbTEvSE5sRzRKcHVvTE45WWd3M1JwN0kycFlOa0crRkZUMEdYcXpMaGQr?=
 =?utf-8?B?a1hNbG5GVWFicFN4YzVYdEtJQ3N6QktmNUhqUldDOWZtOFlCdHhGcWI4SW5z?=
 =?utf-8?B?NVlya2lUTmRFc0hrdVV5UTRnUStPTkRQdW5RSy84bDk0SThUTEhKbi9kUHh0?=
 =?utf-8?B?ZlllbGxjWGtsVEdmVVRCY0NhT0xVc3RVd1lpWnlBdk9zSG5uS3ozcklBMCtl?=
 =?utf-8?B?S2JnNE92d0FoZmo0MFpaZFpJQmtPWDlBeTNMM1h2TDhmZlJJL2tDbU5CNEJw?=
 =?utf-8?B?ZDVEQ2pvVmlpNGxzSEk3M29mb0pSOTIzZ0Vkb0pBNXdUYmM2QXV5ZVlNbnJy?=
 =?utf-8?B?akRiUU9hSXNpcVF2OWpySFpPc0lmN1UxNUFJSnFzb1BhbEQ0SUQySDdvcU90?=
 =?utf-8?B?UHRkSDhYNDdqWUh1eWE1QncxL01SSEdudktxV3Nzc1pQK0U4dEh0SUtVMVBL?=
 =?utf-8?B?RGhRNGk3Mzg4bWo3RWRqdEkxRUw4NzVGT1U3K3UzaE1oUDAvemhlK2ZzZWJP?=
 =?utf-8?B?NDdwNWVuc3JkK2FUOFZWV0VkVVBCMFF2QzFpR3ROVFZLQ09zL0UwZU1aQ1k2?=
 =?utf-8?B?YWRoRURuTlAyMDYrOWFHWWEvdU5IdytTN2JFNXBCd3FQeGcwK1pZUWdhNUlz?=
 =?utf-8?B?NkM3TnBBRndxTSt5akpvenEra0xhQUprRXl2a0xjSkt2eDNRTzFqNHFqRWdq?=
 =?utf-8?B?d1Z1ei9DaE5TQ0dXRVFjVWF0Yjg0YWxhZ1pQczJMb2RsWWY3VnZCNlFIMWNH?=
 =?utf-8?B?bHIzY2t1SjNWNnZoaXFSWFVnOXBXbk04MktGOVp3VmUwS1ZRL2p5RThLUy9N?=
 =?utf-8?B?ajZNb1ZoNnlpZFFvZUFhTkQ2OGFPalYvbXRHSmFTa3lFWS9XOUpHdXgvaWQr?=
 =?utf-8?B?UzYwL0tNMy81bGNlY08rcFdFQ1pudDltcFJJRllZQ1JpRGt4ZklJUTR5Rity?=
 =?utf-8?B?d3lnbS90Rm5naWZPcE1RTUZ5VjUzMDh5RWZ1UVVTMGNYVkRFbUNQTy9UaDRO?=
 =?utf-8?B?RHI2d0VwY2pMWlljSG1QUDRtOTVHellFSlY1NEpIMVRpV0NVbnY1cXFnYXox?=
 =?utf-8?B?Qnp5QllOeFhtQnd5eW0yOFg4bkwyS1BITHBjcGovdnZIM0xmcXpQTjh4d0Fp?=
 =?utf-8?B?K3Z1VGpIUlJkVEU4TVd0SGJHbDBnREx4a1dRMGtPSGczck1DTnlDb2VINHFN?=
 =?utf-8?B?aVBnVnVtMW9iQVh1ejJ1TEhxWkRWYkpLaEFKVkxQSjhTU2wwZHJwU015MC8x?=
 =?utf-8?Q?InYVv6xsCc8VDMxB6r2Hr4Wf9sGVWUFmM37bY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWxBWGJGcDIyUFR5MG42dXpMcmFZSlJyZW9DQ24wR1h0aXFtdmNpWFR1eUll?=
 =?utf-8?B?ajBmdDZMaWlCQldpSmRtQXc5L2lOMlZmN2EwNXNaNTNBRC95ZTJDRFdlV3Jv?=
 =?utf-8?B?YU9RYm1QaVpZUGp1SWhlVVl5ZjZYOTJkNXhIUGQ2eExMVFB4QnhpSDEvc3E1?=
 =?utf-8?B?eVlEaUJRN3M4ejRlY1BMNWNNTkkzWXh2L3FuMk5VY1ZvaW9ZTlVKcnQwbGtn?=
 =?utf-8?B?Qnh5THJWQW95VCt0cDRZTXhyOStFREMweE5PWm9NVDJjcEsrKy9hN2g0ZFR2?=
 =?utf-8?B?NksrQU5mSW11bjE1cThLYXM1WWZHV3l4WUFLL1c4OFlIMnJRVzdnc2ROQ0R2?=
 =?utf-8?B?cXBDRHJKS0gyYkp4YmYxTWJVV3BDSHBqR2JQQXI5cGhZOGViU2VCc3ZGWGQw?=
 =?utf-8?B?K3ZoTkp2cGxTTUZzT1phcnpvUzcwYkY3YWZOQkk3VU5tWS80bVpnTjh4Qk0y?=
 =?utf-8?B?MVNCUnovMXJSREwxQ29pSzQrdng1UllSblpJNnpiRW9DMVVwaE9VdytRK28x?=
 =?utf-8?B?L0JoQmM0N3VabmhCZDMzeFNTbzR5dWw0TVhBYlhyaDJydnZpUUI0QUZuT2RB?=
 =?utf-8?B?S2lrVHhOVFpZOFNqcE54aUhURmtpanpweTFKeG9SenpxRkZlOFI5Um8rcVJz?=
 =?utf-8?B?Qk5OdWhoUE5Pbm9kdDBRT3ljVU9KSlh5YWh2ZGFwY1BncGIzSmtHUEU0Y2dN?=
 =?utf-8?B?b2lmWlA3L1kyTlg0Q1NJOUd3RTZSaEFuS2FGMitER0JFRHNMTytxRVA4Zy9s?=
 =?utf-8?B?cW9heG5oMDJ1b0RRb0JPbG8rMmxOWFFONGdjU0hnMk9WK21Na2Q1NDFtM21H?=
 =?utf-8?B?ejVQa3NOTzYwaW52UUFzZHNZNzYvVmRSRklpcDI1UnhnNmdHb0c0cmxqbzBT?=
 =?utf-8?B?VUtsRmhkNUFZWlF2NVdVM2RlUDdrc0R6RVZpbEpER0Q3SEdveHRpaFNva0RK?=
 =?utf-8?B?N1I4WTJDamxJQ1N5RlBib0hGemQ0Ulg2R0ZRc3YxNUxHSzVRcXVUQlpqMG0v?=
 =?utf-8?B?RS9COEkwZ1d1c1dGS29TV1gzMlF0SmFrazBnSC9RaDZsN3VWMG5sVG1ETEFK?=
 =?utf-8?B?K2FKemFrdlRzRzhhV01QMDAzUndKeUJrdFNkVSs2NGtTNUR3d3UvZk5zUTBz?=
 =?utf-8?B?Um1aWUNRQjdLa241UFZ6MGZ3QzdhZVh6MnBxeTh3Wmw0Zko3QlUwNEprL0tv?=
 =?utf-8?B?c3ZqVEtXTTZXRTFrSmxxWjJoa1RqdUFaWTcyMWxBUkNZdTExemM0NUFJbXls?=
 =?utf-8?B?ZmNsb29kamEvdXZHUUdPS3l3dm1iZStaa25WR1EwaTd1VCtueHJaT29TZkw5?=
 =?utf-8?B?cU80Z0s2bzVlNHBoZjdZZ3lsS1F4TWpFMklzUHd4a1BJTG9IYWlWNFRHZ0tP?=
 =?utf-8?B?VldtYVl2WXFVWXdNZ2pDczUzRjJVMTU5eUQ4R1pubCsrcFJjREpzdWtIM211?=
 =?utf-8?B?Umx3cTRvdk5pYkZ5WDFqajZzZUZ4NU9CZ0g5aDYzcVZjTmQ0TE90bFZEZSsw?=
 =?utf-8?B?bkw0M3dlcy8vc3FkcHQ3TmUzQXhRc2h0S2xleXA3Ukx0MzlxbjhRUkxGV3Vx?=
 =?utf-8?B?b1RhdWhmT3dYUCtKT1BjMjBvcTEvU2NuSzZUVnZXRVJiUzhTZ29JRWIrMUFw?=
 =?utf-8?B?RnlucE0xT01hOURjaDdnaXh2eUhkaUlIak1vaVd5c2FBYUM5b2xvOFRSK1ov?=
 =?utf-8?B?ZThKZk1iSXNyYWVycmE2OUtjMkJmVHpCRmMycjdsTy96NXpvbk1GMEN6Q1VL?=
 =?utf-8?B?UlFPVUcvN3lNOXhJUjFBWjVUMktoYlFQZTNWY3ljajQzcFBLY0NiZXhzajYv?=
 =?utf-8?B?QnNiSHZDQ1Rvbmp4WEYyWFFkUDFlVDJydTUwVnZUeTI4dHhGS3piUzBQMnhG?=
 =?utf-8?B?STlGcGM2NUlrdjB3eVg2dGk3NXRSV1JwQjNQSDV0S0FCc2RCZFlBeExkbExo?=
 =?utf-8?B?QnVrUlpNcVpQTlpPQm9BQzJUWkszTURYbjVPdEFKTFJRQXk0azFNaHphZ2Vr?=
 =?utf-8?B?LzI2TisxcStRL1FndXI5eXJST3I4UHZDVmZtNTVUcUdPMTI3QTdoTjBHMGxw?=
 =?utf-8?B?VTlCZUZtTVNJTldRNjc3cXIyMEgwSGNwM01qa28vOFJpOHVKRWdUZ3Z2SFZq?=
 =?utf-8?Q?gehipZUDrEcDBH8L+//cbG5ze?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae20b9ad-e65b-4f56-9a7f-08dc6ec5fc68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:20.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc12jDa0RzCNXDx3L1pCLXKovSdEriEhiM9fOOl0yYFtkyFxW37XAsDfP+Fl+FRlYVO7zYgmpvo1OXI186WKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204

Fixed 8mp EP mode problem.

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
pci-imx.c to avoid confuse.                                                

Using callback to reduce switch case for core reset and refclk.            

Add imx95 iommux and its stream id information.                            

Base on linux-pci/controller/imx

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
Frank Li (8):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
      PCI: imx6: Simplify switch-case logic by involve core_reset callback
      PCI: imx6: Improve comment for workaround ERR010728
      PCI: imx6: Add help function imx_pcie_match_device()
      PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
      PCI: imx6: Consolidate redundant if-checks
      PCI: imx6: Call: Common PHY API to set mode, speed, and submode

Richard Zhu (4):
      PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe root complex (RC) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
 drivers/pci/controller/dwc/pci-imx6.c              | 1193 ++++++++++++--------
 2 files changed, 736 insertions(+), 473 deletions(-)
---
base-commit: 9d8b196fd12e52820a40c21297a97ea6186aa87e
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>


