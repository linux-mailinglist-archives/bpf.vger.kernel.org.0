Return-Path: <bpf+bounces-37881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47395BCB0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CC285AB7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB111CE71A;
	Thu, 22 Aug 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="giMR6uKQ"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B21CCB4D;
	Thu, 22 Aug 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346211; cv=fail; b=PqZp9ytBzLM9e2eMZuLUhYnD8r6Lg0C3hF2Ic4psMLnSdeNf2YQJbXHhPf3EE2GvkEm/ZQsvcdrwk+gUanZHzl20Hkvvv6/nSemtCZTXC3Nzg7vBvH4hucIaX9SBEP/wdxh445rmxBTGpbR1w1cLLIKsF+5YtAD2+rWCfugW9RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346211; c=relaxed/simple;
	bh=MYCdttdHndW2NLiLL4IGh/IxF6HEJcu2gWB5ZG1Ufbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iySLqVOWhrOjFcRooqJRUunDy4PC+J3Z0No0RA6gOWzfZtaH+HCrXRKVYKQ1ix0cfOUAYQPoo0OGVZr+a9Jb+/vDK1ximU/vA69cP1sfBt8vgYpOi3bNuSaVrBNCjhJx84q0IZvT0NMpMV9bPH7sD0t8ZLBFmQKmyBG0Zh7pgRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=giMR6uKQ; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJaNyBNl1PeXmU/pu5M+z5fQ2I89BeIubzl78oWqQ9o2AHC2jFdhRBQduB9SfvnWU41kxJQ9EqDNWcp6SsBylgS1H+W08XD0LHJp8ruNho9+zBdkkgdOzF0ANe7nfo4vJVcpq/dXrli383vNi0VB3KzPdGOpZFxXCi1BtpGVhEdtNxeuGJXCkg6pidGlkBZbpupcL33OnF5ahXfHss8ovAxRRumlloMBAfb6q7y3+vJTyTjcinUwahtDDVcMugvX8xJgglDIS+WLDQcfzZrRK3DkPQd2R0SzNpv5/I7LAsn0WHpGtwEQ+CrRnuNdQu7UB1MocpJAEbvSixUufJ6Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiRQMPr5Tx2NBqAwwQGc4pFs/EcmFdEPpyrn1MLsmX4=;
 b=U6gnEB4rbnaTWbRVloTLSmQ6/Hl2rgi397vlH3yUhrIiUKfu+gvTUVR1jSLvMJRCSX1H85oYdwHwnvdq4P4bp1dLEdiDSOz/nTo9uNMg7SRYdqC7upZ8AJhQW8GTJg65JWOCnwmSmNtHTLIQaW971lLUrUYjSVW9VPfvNBr9s1zpkEcoGbXsLNwbqml4W59daScTWiMSaUm1sftNpHeAukFSL+jXplDuV/ZoNowoXInaxzbvIEABYQFJmMAzRFT9eZkPnoX1X4V0MrVn21JgwSq2W2T593qvS2fPQowIzIWF6wTUdznDdyfV0RK5ZCYO+wfe/7PPkznmPk17+GUuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiRQMPr5Tx2NBqAwwQGc4pFs/EcmFdEPpyrn1MLsmX4=;
 b=giMR6uKQ7yjy7bAmFiy2GLSZANcNNsnziazFy+XqVYNGDRjAc6Rd9/V0cfq+P6LsSBrXVuTR/Q2fvGKnszP8h3Y3APw8QI7hrxBP20/TjYwgip9ojP6hBW40bKdJpINrqcgAr7qmSBqRxA7gFY9rUa7KW3dcud1sJ0GsBX5LaPguQaxtu71oS22MgxUwr09TZivTjwiKDwxineSR0XCG7p0nnQXqW2GiLeVCnucYO8OUV7ecI/1LBxqgmMP1FYywXHoXjajYDlqXr+hXFBIDE9WWEImxdHlxumBVyJUC3oxywUBDYQyqCO2aedyIillk19KkHmnlxeDKsyWP0iOJVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 17:03:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 17:03:26 +0000
Date: Thu, 22 Aug 2024 13:03:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZsdvUwuvmW/+Agwd@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
 <ZrKIotkhvAnt87fX@lizhi-Precision-Tower-5810>
 <20240807023814.GD3412@thinkpad>
 <Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 06800868-150e-4d33-b8ec-08dcc2cc5699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0N0Q3p3MmdzVUJrUDEwR0JuajZBK2d1emRBeFVKVTJYQldRVDFsbnh0OG1W?=
 =?utf-8?B?eWRvK0N3dUVuZ0R3bVVlckt3RzRza2duWWozV2lmTjN6Yk03aW53R0hTMnFV?=
 =?utf-8?B?UHU3UTVHREZ3U1JYWUhvTHYzK1VGajdrOThqdytEdEFwR0h6bXgyS3FTTUlm?=
 =?utf-8?B?N2FiWGxDSkRmZjRFK2xrMmMrdFc2NUZqSUlEK2lOL2hUQ1I2RDN6KzlLUnFk?=
 =?utf-8?B?dmkwZWVvSTc3bDVRNjZHNUF1dlJMT2dZUGFmS0pxMlZWNlIwd1ZvblVJdFpQ?=
 =?utf-8?B?QUVFbStWbzlMY3JZeE03S25EZzdOMi9QQ1ZkcXQ0OHI4OE91aWw5dDgxalVD?=
 =?utf-8?B?MWdOT1Bqc2lrc3hrUTE1Uy9QNUQ2d3o2U0VHRFhMWFVXQVlROHdBZmoxV3Rr?=
 =?utf-8?B?bE1HVzh5dXRlMmlzOFBXdmZqRWZOUVhZL3E2WndVMTQ0R3JXVytBSzF6Qzdq?=
 =?utf-8?B?WHh4ZDhEMHV4ZkJHY3JaenNDNzJ3Rm5wSXZydElTaHhGb2w0RG4wMU5iSzZw?=
 =?utf-8?B?Mkd6L3g3TnRkR291b3d4MDhyZFRBeDAwdVcyMVBQVEwwa1RQV1o2bnV6RmY1?=
 =?utf-8?B?UE1sTVhZNlBkR3BtRVdQUnFReVNtTnl2V1ExbXBjWGhDN1UyNVVPeXJNVEx5?=
 =?utf-8?B?Z0NpSWR5MndiWEYxZkFuRURwNGx1N3F3MjEwdmc0WHdjcmJQaHR1QzZZY1VU?=
 =?utf-8?B?cSszS2FaOTdkdVlUZ2dRN01HZ0N1V1NnR0VMK2w0U3FnSTIzbjF1amlKUTdq?=
 =?utf-8?B?bFRhbGhTUlM4MWVGR293cVdRQUExWENlQXoyQ2hNUkN0VWFKdVRoSW84T0gv?=
 =?utf-8?B?V1BXTDIxTVhodHdyNTI2SXQ1SUJ0VGdXOWlWVy9jSkthNDhuNGxtblpIQXdJ?=
 =?utf-8?B?TERKQUp0U0FhUWhiZk9mMXBNOXZ0SEtLMHlaOXliU21lbnM5S1RTYWxEeWVk?=
 =?utf-8?B?NFNnMGx4MExoY0NTY3VWR0NPNk5HYU80QW02UkUyZ2JtRmEzVjlXYU0vbjlW?=
 =?utf-8?B?K1RHUVFpNkpVaVd6T2FGS2ZOSnNHdVM3RC9qM24wR1ZpMWZGb3k2RFhBMDFn?=
 =?utf-8?B?bUczNHdlYmo0c3hvMkx3Y0JFZHhkakR4K0VIY1A1MU9xUXQ0RDFISnhzWUVq?=
 =?utf-8?B?ZjN3RUR1U1VMaHZUMk5hRjhESmFzRXdCeTdNL2xjYVYwNVhHSmpHSUprYVBv?=
 =?utf-8?B?ZVg1ZWZBRUN3QXVvNXJ1eWkwZ3VlVERJcFMwS0d6UnhZNmU1dTN2SDl5OStO?=
 =?utf-8?B?UXMxcTV1emxuTkJzWUJrTXlXS3ZFTjIxa2V2SkJnNi9QdWQ1dlorL0wyL2F5?=
 =?utf-8?B?K05aS3QybVJVZWY2RndLRUprMXNWcDRqaVFsMlZOdXZFMlROd252NDY0R0ZR?=
 =?utf-8?B?M1B5WWgwbDYrbjVtNG5YVVpHVnpRQ1p5dGJxWGI3OGRCWUo5aDJMa0prdzN6?=
 =?utf-8?B?bXk2T3pkS3N2TkU2MTVDdGwrYzBoYVhLcDlKQVN2QzExRksrbTBacVVkQ2hG?=
 =?utf-8?B?YW02eE5Bd3cyaENONjNSRmJuK0xVbU0yeXFWT3Q3ZEpVb2Ywc2wrUEdVbk80?=
 =?utf-8?B?U3EzU1NGZlNnL0hhVzhoaFFPNjlKa2Q3MHp3MnFpaDZhQzJzVkN4QlU4a1dX?=
 =?utf-8?B?MER6N05SQkFGRmIwZ1V4b3VobnNsbUpyODBXRUJDYU5JTlI2SDRKMHBuRVFL?=
 =?utf-8?B?a0tlRU5SSnVhbzdQaHpaRzN1d2J3Nk9rYXFNaWpWMFRNbjFmM1VvLzgvQjZv?=
 =?utf-8?B?ckEyeHZFamRZMGZ5ekxkY2QxS05aVXlGMVJmZUwvREdqQzFSTEVOMHY3bGND?=
 =?utf-8?B?OFU5aitEYUUxSVRFcUU4R3h6WnRuYzhQcnJYUkVoTjZxTUgrL0UyZmZNZ0Fk?=
 =?utf-8?B?UnpvZUdxaW81NWV4YldHNjhMZnZjczZibTJwb3BTd2JOQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTBhZE0zR1QzVGpsRzVwRnpUYjY4UE9FalIrT1lqamc3dkxCZDh5cmtzOCtR?=
 =?utf-8?B?aVFMRW90Q0IxdytkR0EwY2JZb3ZHUy8yZEE4NVF6dmFFVUxVZ0ZMM3lmbDZG?=
 =?utf-8?B?dUhVTUlESlcvbE12MUFXcVVMVlZwdE5GNWpwMVVveEs5cTJkdE9BcWZiSzIv?=
 =?utf-8?B?R1ZDUjZqL1Q4ai92Ymd2QjNudFJTdnBGcmJBRGJGRmV4VmcrQnZFZDRoamx6?=
 =?utf-8?B?Z0I0Zk5vYmtmcmpISmVkS3RXWCtwaFJBeUcvUXJvOFkwRmlLNzYrWm5FblZW?=
 =?utf-8?B?SFVqOHN1WGljYU9EblppWUsxdTViZTdUL3puZ3EzZzFzeVpzTTVBTW50K2xD?=
 =?utf-8?B?cm13WVVUbXZkaHlxT0JiT2wxTjZGM2pEd1g1VjRudmsxdVlCL1VpazR1Tjc3?=
 =?utf-8?B?KzlOYVFRTG00Z1c2UW5adDlodEFYc2g0aFZxR3VnREhYdjZJUTRBUVRPdlJx?=
 =?utf-8?B?S2lrSHQwUW1vTUNiR2JFK2c0VnpBcU4xL1VPME1uRzhqaWdEWlhNTVUraUJj?=
 =?utf-8?B?Wi9vVjQ5VTE5aTF1VGFZM2hQbS9ya0hGYm1LVjdvc0tpQmd5ek1LT2xWK2U0?=
 =?utf-8?B?YjFBdUtLK3k0UGVOWmliaG90MkZBczU5MVlKYzdHeU1GMEZvVmJYM0dIdnBL?=
 =?utf-8?B?WDZpaGVZcjMzUnRSbjJKUWhtQVZhK3N4djh1Y3BCenNmbXg3WVk3YVJhNDlz?=
 =?utf-8?B?bnBXeHZzRWxZZWdIdHJXRGhLajMwR1g5TjlHbEt5aWNvejNvTlFiV1NESFFU?=
 =?utf-8?B?c0NoUjhzaGFuOFdpdjJGTmVTbVkyTGhQSFUvbU54enRlcFhEbHZoWmROZ3lI?=
 =?utf-8?B?UVVJYnZ3M21nM3ZBN3J4RkZwM0xxb1g4WnN6QjRxSW9GdUhzcmxsYlpPNDZ5?=
 =?utf-8?B?Z3ZtTmRmdEJTeUk5ZUtVSFQzRW5IekhiYTJDWGlqTDhwUjR0VldZbVNBeUdY?=
 =?utf-8?B?NjFNYTExTG5ybkY4UEYrMlZBNkJ3SmxjWnpyUkh1WFFLbXhUcG5ZUklPRCt4?=
 =?utf-8?B?SjFQeHlXaDFJdlROMmtpUUVLNWo1R1pCL2UzQVJWUVNwRW5LZmpxd0VsZ0NW?=
 =?utf-8?B?K0ZrY2hxNlRZTUM2STd1YW91MTcraHR6QXlNQmVTNXc4czVLL0hMWmx1Nndq?=
 =?utf-8?B?dFpLRFd2VjlvRFMvaXFEZ3h1VnVDU0loR3pLai9rVHZ1bWp1eWt5anZpaEx4?=
 =?utf-8?B?Rk5PeHdXdVpidzlzaW9EOGZIYnJFZHYrUG5aeW9CVkNJR3dZdlAvaEFNN3d5?=
 =?utf-8?B?OUQvR2lqWmRmT0xNT1l3M3R2anNNRWtISFNUMFR4VEpFZDZZRS9yVVR2WDMx?=
 =?utf-8?B?Ynh6ZUoxWWpoaGY2S3JVWlR2QkoyQ1BEdUhXZWh5cWJ4SkoyWDZFUjRENEV0?=
 =?utf-8?B?eDBlbmhSbHgveDg1aG4zUVlhVm55djhLSlRuSERqQUZheGJjMDlDbGZXUlM1?=
 =?utf-8?B?ODR4UkZOTmR5NDk3T24yRjllbW5Vb3hSZFRVSjVFbjFWNGVnVVZ2bUNPejB4?=
 =?utf-8?B?Z0llZTFGS1BKcThmQUdoWXVNSWhrdnVzMzg3YnBKRXZjV0VzMlZsWmJLUm5h?=
 =?utf-8?B?RXV2UGdBS0pZWVo5aTB0UGNUaFczL2dTcFY2UEhOaTM2Y1JWQnQ1MnMrRFJ4?=
 =?utf-8?B?SkcrdExlYzM5NmY0TFlzY1hySHZ5VXl5aEoyOXVsc1J5TE0vRE9rNFlGT1da?=
 =?utf-8?B?ZGRxRVFoenhLWDRxRkpWRWx6Z1k5MUphZDh6M3dRRkZYNzRkeXdCRzJ6RURL?=
 =?utf-8?B?NFhJNEo5WUNhZ01tYUNQdTZlc0g1dWhNYytMK2tTMHhkTXZZYnZjUmIwUmxs?=
 =?utf-8?B?bDJHUGlxVExObDRlbjd6NVA4N1NyZCs0QXdHTDZMMTFoaDluQ1dlcU5ubVA5?=
 =?utf-8?B?MW9yaG1EWkx0QU5hREN1QUxJdjNjSXd4anJGa0xLcGMrbFZNU0JKeG9yN0xU?=
 =?utf-8?B?NFQ5T1RkZXdTTG9zZURIOGJVTUM5K2ppZUZPckNrMHJkUXUySXZuQzRVcFU2?=
 =?utf-8?B?U0xyUXJxM1R2aFBXRDYzbU8zSXZJSlpOWlRuWlNHTXdOUExhNTR1RnEzUFpw?=
 =?utf-8?B?NXF0K3ptV0k1aW4yVDRLSGtyNCt2aUxHOTV6RmlNaUpqSnNKTjQ3czRnbTFB?=
 =?utf-8?Q?XUz4g53ziIn8m18SUUifdIECy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06800868-150e-4d33-b8ec-08dcc2cc5699
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:03:26.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDWfYuI/eZSZU4+mB6yeJ7mL/Eyiw6XuGCMKUF0ZmErGIl+PVnNtYpNPs5sHlmDBedfzUzd7Rv5XLeRPbh5wcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876

On Thu, Aug 15, 2024 at 10:56:27AM -0400, Frank Li wrote:
> On Wed, Aug 07, 2024 at 08:08:14AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Aug 06, 2024 at 04:33:38PM -0400, Frank Li wrote:
> > > On Mon, Jul 29, 2024 at 04:18:07PM -0400, Frank Li wrote:
> > > > Fixed 8mp EP mode problem.
> > > >
> > > > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> > > > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> > > > pci-imx.c to avoid confuse.
> > > >
> > > > Using callback to reduce switch case for core reset and refclk.
> > > >
> > > > Base on linux 6.11-rc1
> > > >
> ....
> > >
> > > Manivannan:
> > >
> > > 	Do you have chance to review these again? Only few patch without
> > > your review tag.
> > >
> >
> > Done, series LGTM.
>
> Krzysztof Wilczyński and Bjorn Helgaas
>
> Could you please take care these patches, which Mani already reviewed?
> I still have some, which depend on these.
>
> Frank

Krzysztof Wilczyński:
	Any update?

Frank

>
>
> >
> > - Mani
> >
> > > Frank
> > >
> > > >
> ...
> >
> > --
> > மணிவண்ணன் சதாசிவம்

