Return-Path: <bpf+bounces-45118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C79D199B
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1561F20FD4
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5531E6DDE;
	Mon, 18 Nov 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CP1M+vqR"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDF1E7C16;
	Mon, 18 Nov 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961505; cv=fail; b=o8scxO2SjX366mBfQDJKQ6eR3fwEV91jlUCBJtGJEOn4P5k7fYFosmRguIK7HZmLzAYgKLHte3gEDKKIBO62zY1O7ktUL29/WRj13y5azWiREzrYp1Wr8Qn4Q7Ndwn/0zyY80T7P+uFaMtt3PuDGHe5Y3SZ1Z5SLW7IZyjYb/IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961505; c=relaxed/simple;
	bh=4ra43ajdZ13zOevxF3sZOj0QfYfjuGfS9I8FxESNjmg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qj74d81HWDgxhirG87F2Mns5Xf+Vb+NosNULI72YWgfsAXolsIzS6FMliXcQsv1J3AJZBDL61F8sGeYPo6y1XmWFc9LPwt0YEZIGvLstSkETHIQoeFtoaJY0bgxnr22D3v86shZnqajxZcRMutll+IgoLf5tqJFOa5pFz+HLTJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CP1M+vqR; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbunO8LocqFkqUQkgDbcq8s7ZCY+6EoOiwjshZ1QvU1JF7JwL2HinUsYFBHpV6V8hWlO1V4YNjPznoUmnaX2q6PHUNkr+xpxIIzpzntpxVkxRWP1S3gwUHa6/1m5tjSHF7E6VXu2X9ZEo1g+OrmsM1Z7a+ImJIVPsiqcxFY4ZZ/9Df8mTIoAnZqXc+FA3BXOq4n+f4E17rdDJKqi6OQEWn62Zd+s/z/yWutqM2oMLeKN28S0BPzITBqufEtMIbnaOfATtwzLH/OJcXToxpWGCkm1t/4aByNSDn8ncH7N8dNBtzEE0yKwvZwC9JZq+SFi27WK+SR/ZrfuIsDp0OvBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWivA6yo1jfUnlS+ZnSNsZ+1Zbs/HQey6rwr9gVfS+w=;
 b=wCM4T7hbgrtKC1TZPDUntMtISzf9LFRKDvKB9GDDVeVuXj87QZ54TQR2BnxRJ+AcdpK0tikQKnVz0kr08zBd2AggYFiIiRFPaSwx8TgQ2LHSjM3t8Yorrt4HSYQs4xvuVbyvnJegDU+nsjwqMxLjZzxy31P84RSTnGtuKuHIDAju71n0v42uzh7C0am43kSXhNgRoA+GymVeKRyBhz0QUVp9sZb9lwOPaU1Z8xuCDkYJRdp7M7Ck2B7jiUgMhrrsucEi/qab6hUvlUDtbaxFyqkJC2vYrcrUMvk6jVZsH3K9jvJuIJgrH0NDb0XfmTL00GGCfuF5WYriKxo+xy3pBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWivA6yo1jfUnlS+ZnSNsZ+1Zbs/HQey6rwr9gVfS+w=;
 b=CP1M+vqRZBlKfyZCAn7zIPJinc4OY9zlrxresq8j075su2pjIa3Hc7ZWGjzn/YX4oNaZxUPp8X5hVurAuk5SIBy9dnyXTVvIEciT1zS2vER6oQeUxZgHs3EzE2MaOd2iA/+pS0BoYtVnh91YkgOF+vrDOH4Qk37QSRXpyeK9PjmejO5R88ZSD/ukWK1BxSyM3sXLrUcdC7oaEyqqR3doURiogSH2YTVoIlvJCYgf9r2BDnlD9qOGjUq742UyYo6A1O+vBhc2BtqdPlqqvGujSiJVslZ1nPNcImd6Ve16rLVp4d3IIMWHh5Zy27SzGWX1MVveJjaPHbmYLpInc9CneQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 20:25:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 20:25:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Nov 2024 15:24:28 -0500
Subject: [PATCH v6 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-imx95_lut-v6-2-a2951ba13347@nxp.com>
References: <20241118-imx95_lut-v6-0-a2951ba13347@nxp.com>
In-Reply-To: <20241118-imx95_lut-v6-0-a2951ba13347@nxp.com>
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
 will@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731961482; l=8650;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4ra43ajdZ13zOevxF3sZOj0QfYfjuGfS9I8FxESNjmg=;
 b=kVJL+NAbutqgxd1uX5vfeVGPOWjJzFuZ3kDhota2Ss/v1k67g0PhGlGVplho1Uj/IPAHMIK4D
 GOWqHTe/+bPAIdIrP9YpvST9YOZYtAGl2SPErx37UReKK/oiXNHQzup
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 167198d5-c537-4224-bdec-08dd080f139c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXF3UW9ZbnlqVHZKVnFwY25EOTJZNW1yMlUyZkw3cE5lbW1GajYzTlp1RHQy?=
 =?utf-8?B?aWNOS1MzN2RwRDVuMGtNK01CR1JvTGlyOW96VTU4SlNGcEZwYlR6bnNnUkMy?=
 =?utf-8?B?SVhKeFo3ZW9XZ0ZrRk1FUEJpQ1dYOTVIdlhCcVhxWVFuSUVtVXpxamxRdVNO?=
 =?utf-8?B?S2xyRUcxSWNtRGNxcHpjSWMxNTc4L1NZMXQ4a3BadFU1VHJhclgzblliWDZu?=
 =?utf-8?B?Y3U2RHBKUjVjS0xyUG1HWmVjd0I4VUp5em5vTjJBVlg3RmhIQzhacnhHYmZO?=
 =?utf-8?B?aGdyVmtBdStjMnhUUzFqMkkzd0UycVJDKzBwaVp6T1grRkROaFhUcHlCSzU5?=
 =?utf-8?B?elRBeTZ6ekE3clU1V1pBcUZrQjZEcGhtR2hNY29GVm5SYXVnVjQvRFpCYlgv?=
 =?utf-8?B?TXBIVWpCOTN3MFRZM040SFZvMUVtQ3lGeXJvZFZLQ3BIN2R6TnprRTNUNFlG?=
 =?utf-8?B?dkllTEoyUmV6czBndVoyS0JKcG5WZmlKSXpmNnA4LzdTY2podVU2RDdWZVdy?=
 =?utf-8?B?MDlVaS9QMWljRWhNem5JcjJxUkRjRno1c3QzSWMvbHBQTER4VExnQ3o3ejVX?=
 =?utf-8?B?UlFmVU5OMEZ0T0U5eXBmZHI4OE9SL0t4djlIOEpsOWhHc015cE5TU3FUb0ty?=
 =?utf-8?B?bjB0YmhobG8rSkN3eHUxYU1JMXhIS0drR28wUkdOQXV2VW5MUWRaL2dqMTN5?=
 =?utf-8?B?ejhrdUp4VXlOb1hWYVRuem9HVklsalQ3M2I1SDVyY2ZrVXFVcnFhZ0NjRnJa?=
 =?utf-8?B?cFJ0a2Qya011VlIxZXlwVVFOdE42N3B3RnVxQ3dhUlJzK1JVSkdGYXBXaWVt?=
 =?utf-8?B?MjRqMCtocmtNK0ZYZkZPdzRHK0U4R1Z4OUs4ZEdiWWtiL1FTTkUwMW9lVkV3?=
 =?utf-8?B?K1RFemUvWUc0akYzd0VPNERCL2E3S291MCsvZ1h0c0R0WWwzUmVXdTNQT2dT?=
 =?utf-8?B?bW5KYitjUTV2eTc1cUtKU1VFaVNSUlVCVXBCWFNqOCtqMVc4R3hRQkZzNmVT?=
 =?utf-8?B?dm96emxjTmpKcTVyNTZ1MnY2NHQ1MC83Q0dTOWtGd1pla1FCbnlhNTdRNTFq?=
 =?utf-8?B?NlpwMWJGMTk4ZUxlS0NCNmdDSGZvSlZ4ekthTGtYcHJNZklUaldzbGFpOEcw?=
 =?utf-8?B?R2pSTGk5U2h6MDA1aEpTL0JKWExDeFB1d2dKUWVGc0tlNFVNS1VBREJXMk5K?=
 =?utf-8?B?TmhnTUpjQ0tRSVpyeTdCWjdNRmhEZjl3OUd5QTdmamdvNExxSFEvMVlpaCs2?=
 =?utf-8?B?bk05Y3VOT25xaXVvRXg1ZHlkZjcraElMdE9GNkNObE16Zml3bWdDQ1VaQTc5?=
 =?utf-8?B?ZklYcDY4OFVWWTJHTExZb1lnQW51cmMzbUFwNDgyUk1Bb2JGOG9rOW92aFE4?=
 =?utf-8?B?b0RuRXJod2hBRUF0ZkpQK1V0OTRQOGJDK0tmSy96dXFlK3hvL0JScWlZQzMr?=
 =?utf-8?B?RDlKa0NVTGdLOWVsY3I5VzZNdjIxQkY0SDBrZU1vS3FGeEVqaklXbnZoWjN2?=
 =?utf-8?B?R2oxRjFLeEQyK1RlRGFRT2RNQVBEZzhKTnpGMjc5S0Q5ZDlqTys0cGQwdnVo?=
 =?utf-8?B?Zk9QUS9iUFFSa0prZk90VkRLRi8ydTlsdnN3eVBacWFDRm5hL0doWWFBaktB?=
 =?utf-8?B?ZGZDR0YyTGxBZXZDcmxSQkNiYUwrVEtqVFNzTzh6VHJJQ1htcnpyclp6N0Zw?=
 =?utf-8?B?WVlKU3U2QVpBQUpkNkFQTGtCeW1RKythNE5lWkhGcGJ4TzJuZG9FWXdiVkxD?=
 =?utf-8?B?YzBwY0NhbHBLTytmM0V3TytyQ0t1SnBheHNWSnVOVWVLSWNkS0dmWWF2YWQr?=
 =?utf-8?B?Vm5HOXdvVVlBQ3RtajE2d2ZsRHcxNmZGWmFKRnVtOVUyZ3RieFhwSlhSbFFa?=
 =?utf-8?Q?zbvWIGj/hkvBR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVpRUozd1Y2SG5paG1yNkJzNVprbzA3OStoU2s0TmVTWSs4Sms4YVBEMUY4?=
 =?utf-8?B?NVJteDV1MWdZNVIzbTRnQVlkMldxR0lpT3RyWk8zc1hoczVMS1c1WDZ3MjN3?=
 =?utf-8?B?SEJia3hvbE1iNE9pTExwS21VaGRFdTd3V0s4UU4xUDY4QkV3ZWdadURNTUFt?=
 =?utf-8?B?aW5Pdmd3L3FuUVZEOVFhMnVwQVdMNFpxd0dQeVoweEY5NEt1eW9DQzJQajhu?=
 =?utf-8?B?YkhpVjhBQllwMHRkdEhuTjZOVzZqektaU0VJWGlmbXJOL2dsSHI1eEltRkhj?=
 =?utf-8?B?Y0g1a3NLRUtTZ1JEZ1VVNjdXWnQyUi9WQlJVSU9BM3dselg5YkpSNHhJdWNQ?=
 =?utf-8?B?L3p1OWFzVVQ5ZkxCczRZQ1NKRUc0ZG9MUDRJNkNwY3pwcGhwcFMyV2NmbkVS?=
 =?utf-8?B?WW9jRnUwb2ZvbjFsdHdleTZaeU9FdllpS2N6WnVheWtMSmlWYjVQVjdXamF1?=
 =?utf-8?B?VVoyUDlBNVhhTDUvTmRJalBqWWsvSVFtTlZ3b3RmdWxYKzhLbytNT08xejI3?=
 =?utf-8?B?RjQ0TW5qeGMwcCs0L1Q4S1cyV0xEcmt0YTFMQi9iV0V3bEtRenIrRjJPenZW?=
 =?utf-8?B?NVp3Qk1KbW1Hbm5kVnY4T1dDeGM0SDVoZkU0K3BNS0ZmNTE3VkFIUlcyaVVQ?=
 =?utf-8?B?dElmajhDQUFKcDBBa09QUlhuck1qUE9Tdno3MnJ4bGlzV3F5SHhXbm9qNExv?=
 =?utf-8?B?cTMvY0cyUnZ3NXNueG1aYzVGUmtZZDNkVWlTMnAyRFl1bVF5MGgwdVMrbEov?=
 =?utf-8?B?ZHVHL3RKRHk5dHRSZFp5ZHdTb2hvbm1tbml1RCtTNGtSVWZ5TjZrejBqSVFk?=
 =?utf-8?B?Nkg4RTFUa0tWUTJaT0ZTTktEU3llT0t2Z2dkTmQxUHJSS2t5TXVFaGJQWE5G?=
 =?utf-8?B?ZFR5SnlNTHBSZzMrdndPR0JaUkNvWlNvVUVrVmRIbVhKdEE3bWhFZG9WdzBy?=
 =?utf-8?B?VmZ4UFV3dWp2VGE4WCt5TTdNU0dZQUVtTUIzcFJrYjZ1N3hzc1VyK1h0b2M2?=
 =?utf-8?B?ZVZlNVNrZ3JXVmVvR2JYU2pWeUR6NWtkTnZZblhDdXF1ZkFvdXFnU3dtcGc0?=
 =?utf-8?B?aHFVb1lpakE1b3FUV0FBQjBhWDh0S0ZFTnN4OGlxSytBU094cUQzMXhBM1pI?=
 =?utf-8?B?dXFwQk45blIrRGdwbU0rZVhmczJEa2tQbjZCR0x0S09XMHJKNksrQjN2QlBq?=
 =?utf-8?B?ZFprcWxJN0FyK040UXY3OE9md2txQXdkekcxajc5Z01SOGoxWlVxazBLeGdr?=
 =?utf-8?B?K3FQdER6aXpOaDVJcDl5RDlrRmJpWHV6RE9mRXdYRncwN2M1T0JOaVpScENq?=
 =?utf-8?B?bE8zTVZYZWhBQWoyTk1ua1M0SnJrZGgzR091RHAzdzkvTE9jektyeUpsMUc4?=
 =?utf-8?B?Qkd0Yy9RZUFxYXJHVnNKR0EvYmRPb2dmclpqZzFKMFkvUDlPdGlrYnlDcStx?=
 =?utf-8?B?ZGRnbEdCcXI4cVdkMUFpUDA5UGFGdGpNeG1UQ1RnaDdnZG9lOUg4WlBYUmJY?=
 =?utf-8?B?MHB3empnSXNsSEJKQ0xNamVmVGhQQ0ppTXVnOS9RVkpZOGMxVWJCTy9oTUs0?=
 =?utf-8?B?aG1sZ0dMWFJjNzN4ZW9US3ZPK1QybG50cFRsY0dHWjhxZmFPZ0hrZ0Njd0pR?=
 =?utf-8?B?a3dwVk5RUXhMQ0xGeTBGakZmVUN5VDRwUXFxRmpqa2hPQzRFQjIwQUVwdkxq?=
 =?utf-8?B?L0xZZEFtL3l2QmlhSUJWejBFRTJBUldJcFVFNGg2OXdOZEwxNFdrZHhWOVRS?=
 =?utf-8?B?S04zblJZUXU0dEVMU0NWYzBpVVMyWFdaR2ZyOHF1Z1FyRm5pOW8xY3ZaclRK?=
 =?utf-8?B?V29ySEdZMzJVUFo4NnRYeHpOVmpCa25USUU0RXh6MWFqck8zQkVvVW4wb3Az?=
 =?utf-8?B?enJ2VVhubkQrVW5Rbm1oajhKTytValUwenUyMndFQzRyTjFjeWIrZ1hhZVlq?=
 =?utf-8?B?MDc1ekZsMk1DQlJqR1duWk95Wkl6VVFnWlk5WGp0NnJzSXZwZDF0dGJBd2tS?=
 =?utf-8?B?d244TlVZb2NSUkVaM1poNUVPRFAzbm1nNmhuTVFRbytPSDN1T0M1cHBuQzl6?=
 =?utf-8?B?MGV1UHFjT1VaQzZiSklBVTBNVXJjOElDa0x4V014aFl3dlczM01IY2liZmhC?=
 =?utf-8?Q?DpDY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167198d5-c537-4224-bdec-08dd080f139c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:25:00.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek6AZExrO8kGF6/GxsARCjlhq/3+Mc1eOrniEAxQzjnqiB38KcopwSb/F8I9QFeiqqwcAWWg+2nUFqJq+sLaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Register a PCI bus callback function to handle enable_device() and
disable_device() operations, setting up the LUT whenever a new PCI device
is enabled.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- change comment rid to RID
- some mini change according to mani's feedback

Change from v4 to v5
- rework commt message
- add comment for mutex
- s/reqid/rid/
- keep only one loop when enable lut
- add warning when try to add duplicate rid
- Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
- Fix some error message

Change from v3 to v4
- Check target value at of_map_id().
- of_node_put() for target.
- add case for msi-map exist, but rid entry is not exist.

Change from v2 to v3
- Use the "target" argument of of_map_id()
- Check if rid already in lut table when enable device

change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 178 +++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..725db9987fba8 100644
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
 
@@ -134,6 +151,9 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	/* Ensure that only one device's LUT is configured at any given time */
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -925,6 +945,154 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int free = -1;
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
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+
+		if (!(data1 & IMX95_PE0_LUT_VLD)) {
+			if (free < 0)
+				free = i;
+			continue;
+		}
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+
+		/* Do not add duplicate RID */
+		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
+			dev_warn(dev, "Existing LUT entry available for RID (%d)", rid);
+			return 0;
+		}
+	}
+
+	if (free < 0) {
+		dev_err(dev, "LUT entry is not available\n");
+		return -ENOSPC;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
+
+	return 0;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
+{
+	u32 data2;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+			break;
+		}
+	}
+}
+
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device_node *target;
+	struct device *dev;
+	int err_i, err_m;
+
+	dev = imx_pcie->pci->dev;
+
+	target = NULL;
+	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
+	if (target)
+		of_node_put(target);
+	else
+		err_i = -EINVAL;
+
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 * Return failure if msi-map exist and no entry for RID because dwc common
+	 * driver will skip setting up built-in MSI controller if msi-map existed.
+	 *
+	 *   err_m      target
+	 *	0	NULL		Return failure, function not work.
+	 *      !0      NULL		msi-map not exist, use built-in MSI.
+	 *	0	!NULL		Find one entry.
+	 *	!0	!NULL		Invalidate case.
+	 */
+	if (!err_m && !target)
+		return -EINVAL;
+	else if (target)
+		of_node_put(target); /* Find entry for RID in msi-map */
+
+	/*
+	 * msi-map        iommu-map
+	 *   Y                Y            ITS + SMMU, require the same sid
+	 *   Y                N            ITS
+	 *   N                Y            DWC MSI Ctrl + SMMU
+	 *   N                N            DWC MSI Ctrl
+	 */
+	if (!err_i && !err_m)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
+			return -EINVAL;
+		}
+
+	/*
+	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
+	 * controller, do nothing here.
+	 */
+	if (err_i && err_m)
+		return 0;
+
+	if (!err_i)
+		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
+	else if (!err_m)
+		/*
+		 * Hardware auto add 2 bits controller id ahead of stream ID,
+		 * so mask this 2bits to get stream ID.
+		 */
+		return imx_pcie_add_lut(imx_pcie, rid, sid_m & IMX95_SID_MASK);
+
+	return 0;
+}
+
+static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -941,6 +1109,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1465,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1762,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


