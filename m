Return-Path: <bpf+bounces-38742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C396900B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 00:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B791F2266C
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8A188019;
	Mon,  2 Sep 2024 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FNJ5PwzE"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7495FDA7;
	Mon,  2 Sep 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317513; cv=fail; b=HDed1VHzUyHk4b6fTA1j+RhoOake77n8j9uJjMSPVYk9ljeD5VacRSBft5PZr3/dI5KvxRW8GOdi196HubXTJzD1Fc7QCF5xWcHFOJtYWfIrVeuLPYKt5x4jXC540doyH6JraiBsYvz4iaXnysEq9miXH1b+seLHzIncZRrqAjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317513; c=relaxed/simple;
	bh=kVswFOjs651JjXYS4KYpCPRbACbGNFg8PAG/lMesT7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEggEUoALFc6F4pn4udILbzLiXrRJDg8iyKfqLSkb/qhnE0jx+XkJeb8GUJav3arXu0pFMm4ap4qWse1EzZhgJmyIBGu/XHpiGQ+DpojevQiidukV6oHS3Fxt4CasbRpdmPU5tGOQ4fc+Y/XHsIffebAE7QGRHh+0uI76b6m+VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FNJ5PwzE; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRqrgS2cX4S+wGqm9Eu3ydDg3AzTWCUC/40vjB50NJX3cwy6+9rHmZgZfZqCl8jl8CObozaCcdzCqkR78aCMdc/SKWbUzrfnIgUqbnj+X6NwN86c7eVg7Qn9yf9oJ7H3KKLh2/tM9DbKqPp8+5i8a5WOUFk5gNpeaelfpkquiRTGVHM0zxYp113JiQ1ahrmIPPJJRHCAVuNg5a7WiL9y9PL+X/+kGMvdYw4mP8Su3Sw4z5bH3W3a4bku1Jciwfs22zqde+m0wuDpKAbZU3R6qDuKWJat2tS7lWROqQG/CjcTdyxLTeuuUAb2Mc103CG8aZTbFoCUC/yyxBbXeyk3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVswFOjs651JjXYS4KYpCPRbACbGNFg8PAG/lMesT7w=;
 b=cybcZ3ZB6yxG/3SkbwygwFNZhyoEGyWLM0MluQlLnsnRwBTQuSqyh+3xubpWPZR+yGuWMfFmWZdueStNRvSkNreUzyndzj86RvFUvNhjIQ3Loj2DZtpEwFF6lDsBMxpA9AE3euDur17pOWnfoC2usa1m0TPvoj5IbNHoQ5e5bjt9oXK1tawozUnRWFUrRjh+NpPqYHZ8quzgpDDPhmZbCjlqIZRhgsTqlkRa8I6AcY7Qd3tGRve+ApSqyxcvgY17Mb1V5+FETFEktuQXkEDNvjVkWm94w5M/2AgZJjPtEfWeglB+lOZ7MdLLPr12ANNj83OBIaFzPHD/qxbU64jesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVswFOjs651JjXYS4KYpCPRbACbGNFg8PAG/lMesT7w=;
 b=FNJ5PwzEMUPwr6pSGK4pcS3oga0xmgCYpwti0kS2V/p/SvdLrkF3D/i5Uc4TmkleoA1+AlbZk1ZghXo7jpn2ZWkBfXxHtNSCQ0zpcPXA+VcZGysLGnczuzzahObcccarB5iYBjEERuiKn1DfTgG3cyKPebNjpHXSG7BAhMJjTbP8ayq2PhhP5i7/sWeWltce9P7NNwrS37bNJszHMnTHdu1Qqgo0X4vJcJnny2TGAvpOumH9gfnfOWRVvE8ldCM5B79naY1NLNFe3VToTR+twr184x+6OtoaWk49BBlp8YLCL3Q1vdPjxp4hXJfy/ZrebV1X6vaD7jLYF5LKMmjzCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10606.eurprd04.prod.outlook.com (2603:10a6:150:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 22:51:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 22:51:47 +0000
Date: Mon, 2 Sep 2024 18:51:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <ZtZBeL6LqpIKseXc@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-1-b68ee5ef2b4d@nxp.com>
 <20240902211240.GA228125@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902211240.GA228125@bhelgaas>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a644bdf-756d-4b89-66ab-08dccba1d2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VW82W/KUvKL2S7j4AApiQ+agVTf+gNBkkXNQN0ume+K/BrV3RsmENRb9soY?=
 =?us-ascii?Q?w1BX3JYpJjT07ISt9J5z5iy37Uz13VRrW8fHBrtmcb+SABQD7LAJLBS7P4EI?=
 =?us-ascii?Q?f6w1CnOgVW1VjRfmTRPKF6nhCR6soYPkCmPc0oj3R8bNklYjI4QJkC+2Pp2x?=
 =?us-ascii?Q?bueoKkE5yOs6+u7OBA0Co0wQNOko1yO5huwncVhZ0imcZODfu5VIbHDjX5vC?=
 =?us-ascii?Q?0Ph+H9iDeuRAu1v3M7KmvHBnh9ty0g0Cjl3CONZQlQQ1kTGeNbWLKMBj14cT?=
 =?us-ascii?Q?UA7iZ5bQmKAAoJCipHG0E4QaBcvQOiUTMFBuHChhqbcpR+C00CXcdnzv536y?=
 =?us-ascii?Q?pLEcml0lRxtqwNEE3ODZXEMgWvITh0+QDk59IHXsY8Y4J0HZ01I7kdy7Q2X0?=
 =?us-ascii?Q?DMbsb9sweKtoSG7bMdA7f9yOd0dhxOEAhQBFMlD9FCmkSgqbiJr37CQi+REY?=
 =?us-ascii?Q?KoiCy/xUnjzcX7g9FZGhJzG5thPjaguJtJ1cv2I+HvmQToIrZFuq3FXkJooZ?=
 =?us-ascii?Q?B685uhn+qBUhnfRKG2RYX39qCSwAVFEiSS2lZJ7BYgu0sUNuSBPGhEOCr7DP?=
 =?us-ascii?Q?c0eDW5/vtkkPa8JWA6WKSNzyGyRK81rs5jBqc/fhEY+1pMWLFiP5sV5BE26y?=
 =?us-ascii?Q?/T3aenVpHoozRfnV4EntGeNg2s8dFAhR4zQp6oqOO4chtsvTxFY/IEBzgwAR?=
 =?us-ascii?Q?TlC/MluXOalmvBjD4K6pucZRt7be12qgjL28xHeApJg5IIUre6FoqQaTsFnH?=
 =?us-ascii?Q?Y/JZ6NxJ/7ByIV/AYr578NUsiPzVHNcQdmzpTnrXWdtOlXXFZXootU0wSpf1?=
 =?us-ascii?Q?1n++/mk3DFR4d48znPNlCGr16p9Rh3AiMTiqjsvDtf3gRjyEiNuJeWlOGlkq?=
 =?us-ascii?Q?55A30haIgO3/1Jkt712AYXI4YUEYcdn35n3FItiXJrrmCGgkLc1KvpWsZOFI?=
 =?us-ascii?Q?Oejvrm2XUQPGfNIPwCvLRaxGU5rkLMM6Kl3glMNCpV9n0SVHGZXnykf36Vl0?=
 =?us-ascii?Q?CNf6Cxp0Z2vj3ZdL/oNgABdLNTJTNtO3Uaz5SdtOBtdQzgb95XZdsatyYxpH?=
 =?us-ascii?Q?MncSsRyhh32w9XhaRQlJ/R1ZY+pp2OKul6Cy5O2ZJ7DMyjRpKlOxxfVY4yWV?=
 =?us-ascii?Q?/46Q8glOOLf+1PAh8BhFbeXTW1ewTy63yQj0vpnufpfI7oTdYCMtcXUEGl15?=
 =?us-ascii?Q?bkA+08L8w/SmST0rXuY6qH3rvXPIcLqYAlGPirQ87HF/YPpSvNcF2DcSBV8b?=
 =?us-ascii?Q?SleNta0tq5FoyKyAh0z/Ml+4FYaMrDuBlrLg54XJJnLTSuZII9D4299IdbQI?=
 =?us-ascii?Q?eUwhNBsrB9i6R0ciBieLbrKm77LASPODOX6pLwl2dBeVkeYNsJrFZe+0WxdN?=
 =?us-ascii?Q?i7cSiNTAgIPmwh/wTj+Gw1+CNx/TiLOgsh8BKoPuCngVrocERg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtU1EwseFx/vxhrF2gPtsbti6/b8lUl0eKwBGYP5GkOJ2grM76zyx/lGAVA9?=
 =?us-ascii?Q?z3tSCFpWujV1smgthag4QObl3nw2juN2tQz5oZdHQirLPA8SuK2VLfFR1jaj?=
 =?us-ascii?Q?6pi3aEuxHqSAFEghY7xY3yH7PcXQ5Iy0npTriQevZymxU68CfrmVb+bAOQOZ?=
 =?us-ascii?Q?0d3V9epocBNxVfaRKNneFUu/SriclhSB4rIK72vzV8697DNpyH+cQsu7BV8t?=
 =?us-ascii?Q?7UykwODzxZ0JLzlVVB0qRh7FG72vH+kS+uXr/JByt9YYoufZLGBdPlVeusLP?=
 =?us-ascii?Q?VV4neYEhmIAnqCTnlrcihO6C9U/T8luTCAxo4auNUNGgSw+gYLrgV7NDNXj3?=
 =?us-ascii?Q?WDD170xzbVvOD0V0GjvqbMRuDPTF8xOUGPkBzYuCnJ4ejeUhtIL/S1lOdiVN?=
 =?us-ascii?Q?sfmUiNJ4toi055w6gM7RZJPLqqXq7KzpdMwjyhJqEe308ltf713wR/Alx1sa?=
 =?us-ascii?Q?TTP9n2QnfTON0uHaKidLc1Rs1kFYMEPQx2SIRQgSHZ6bh8IxtRZX5Ug5AjUC?=
 =?us-ascii?Q?AUCVOu8eIY95AYlEr+sK/AwD67P3s2VaAczx/V3rIqbZYZgFyFwBKbKd/02d?=
 =?us-ascii?Q?T2iAB6SIFZUPEvQLMCJZesRR7bjmVopHiJGcebKMJ177nVmCbyHQGbYkEw5l?=
 =?us-ascii?Q?BQZDszgIEEfYokTeshqy8/FLvulEexZ5yHY1D/6bzyQmRy7o9SwXcYj+TpYu?=
 =?us-ascii?Q?abnGvWnutih67aEb52gLJA8Y7eOEzJqsay8E1TdKfS1/wWdlXOad9lrL5k7s?=
 =?us-ascii?Q?yG3XYqSG6fgV4947OFQp0XSPN5C/fcEXTaTYV8xaUnFKXi8s/4/opgD9r3TJ?=
 =?us-ascii?Q?tc7NjGiQ5DArQX+Ijux9let1FG+2l2jZEAvLOGBDdRZRxn4io5Yuf6Xqn2pP?=
 =?us-ascii?Q?gJHFa/e38B/NqeD4QsLHdPJIdPs+d+kdVhwe1lXuPyqY07hhHLef4RXQNvWM?=
 =?us-ascii?Q?ZJwNYgNMRDptC9G6n/sPhX0Vz/JLjzJjBqofJBqGxroS/TCY2+kLGdzCpv8G?=
 =?us-ascii?Q?JGOwzMS43lJQhNttUk3Js3W5U45WAcaK2OA022yKqSUdNXvsNqNdKPjq5qEE?=
 =?us-ascii?Q?qbckNWnDqfQnmstkwMF9XXi6fetj07aeT8QqgVDbbF1dc6KlIAjHZqUBIR3P?=
 =?us-ascii?Q?8rO2WOIt67zDvZsjvinlM0ylyVonUwaq2OEBJMwtSHS88qxAnObX50XLm5Y9?=
 =?us-ascii?Q?2wEaO6Kqzcu0X0vZCHpaEl7dx1WuybXipWl75iH1UBOzJ7Xr/x86uf5ILufB?=
 =?us-ascii?Q?fmO95wuWol2QFWa3VoFmF4VFjgkHN3CzpIziLxZCammN8gJE4c+82eTTTHo5?=
 =?us-ascii?Q?AhQUflymdFutWXFCciSXSE3I0HpkbSs2sYM7eL397REl+X6s/Kl0VmykU0wB?=
 =?us-ascii?Q?hM1T4nQwMw3HUNj7/CyM5soaQ7hQ/wdbDiYM+p8FUUb0NNEZ33+sSTD8V74x?=
 =?us-ascii?Q?fiJGenlyFlgg+Qu6ZViFrV+S54s/ssPcCp13DQs5nKIy+hDWU+UHfRyFuz4i?=
 =?us-ascii?Q?UATcJMGZHz/aNxuLLu0XpE1/PGoIvH1Bl+htBXED2tnMWsB5LbUxW2VC8E0Y?=
 =?us-ascii?Q?dYZyoEAAVNgTtEdhDgI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a644bdf-756d-4b89-66ab-08dccba1d2ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 22:51:47.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riYJ4vmTKuOG4/xYxryMmHS30L+U5dtvPxbGUX2iVF7EUsr+xH9rFOdZojQnJt8Fn2cUBNwlrji8hGUVAQ1naA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10606

On Mon, Sep 02, 2024 at 04:12:40PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 04:18:08PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Maybe "iMX8MP" in this subject should be "i.MX8MP" as in the subject
> of the next patch?
>
> And if so, maybe it should be "i.MX8MM" here, too?

i.MX8MP and i.MX8MM is more formal. Many other place in kernel tree also
use iMX8MP and iMX8MM.

Do you need me repost it?

Frank

>
> That seems to match usage in the rest of the series (although "PCI:
> imx6: Add i.MX8Q PCIe Root Complex (RC) support" uses "iMX8MP" once in
> the commit log).

