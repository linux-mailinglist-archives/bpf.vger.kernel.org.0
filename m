Return-Path: <bpf+bounces-33527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B6A91E7A8
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9281C2164A
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6016F0F0;
	Mon,  1 Jul 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NP60TMr1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F316EBF8;
	Mon,  1 Jul 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858796; cv=fail; b=ij7/3z1artOawhzGa0x/INUY/BPL5v/YMGxv4oU8np2v0YAss/0DUy9WkNzaREHJUR7pBj01mApJs1iexAw52Pfs/QYWiWdN9+Sz0eaXPF7ylF800cjY/zokK2bgTWk8LfSLkGPA677HhmhMbHBgfeape77jVTU8trjP0yEg/zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858796; c=relaxed/simple;
	bh=lcxlVrCjTNXm7FlnxQeJ3wyF4pIT0YPhskZIeKCPbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hv2qI3yVAMbwC74uv4bWHrEXT3jDoJzuc/jfuUEO2RbJa0++i7gRpj+U+Tzom8ohYvSeSwPMW8jJrt+09/QrRUCyNZk5sYvOztprYHAYxtk1xQHwuxIAjD3OSQXtyrWKBQOenvAW8QqxeVR92VU8/8Rg7uNDEKuD29s87yJ13K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NP60TMr1; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfXzKo7X3Ti+JoDh3fZ/5/cDkWRfmSAj5ZDnOc6EY7q2KkQltqSieZlro45G73aO4auweD+fR4IwucMutCVvC9cf7jZJtCmcZqdnsAThURQDyHDx7qCPBFvNmu1FpEVFwJGGJZ6xPItNqaegCrTxYDzLiOv4/Yg2HY+wS3NToLTdLDWpnIEUlBFOYhc5qNmq8xCoyzV4QI4TQkRVWH+vmBJEYV3oDOG30kl8oofUmHLn64+RvevNIUF/UBL1Ei04Ep8YjzEk7tGxbrgcZWDaZxuHqjMmUkvv5h69/QQqijuy7cC1aBjxklCTKPMdZ7p9YAt1dJ5dbJaT7L5Cgf+yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrIGaXCHaYMASAL73kWfklK8djnriafHrij3oBPt22s=;
 b=mufttD5pIrzXT5hlmZl9fmoddsCK2GVIwslAuSJHrSS4oVscYvk+A3PEZV/1NRsu1BIdVWQPDJg1A60fQp3YT9EmGoshv5tuePxlGLjWdAlJ6AIXnomKcOiU7rP5Vd1jUaeBnxv7SM1DKHyk3JYw6L/lNkeZZ+p3JtsVnuYb9Ho9/UsEQ8JY2E/HKIRaVaCqDDKO6zLkhG7He+jynTr2VdxEn4gjxhCHygKMVAMI0bBJ0L0iSiWMsf+T020ftDNgXFNA+T33kxjt+gnX8G8flBuCWV9BRnTxhLcBP3EQwbdEIWnyiWAEu4mLmn7DVqKlUWoPS3HvXxsYijjOdNgjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrIGaXCHaYMASAL73kWfklK8djnriafHrij3oBPt22s=;
 b=NP60TMr1HOntKIaA7Hy1ZV3Kdp3nomFnQ9omYZ80OJAaWkY/X5RMZme+YT2ijeceR7pk6w9dvLF8orFcgA0wowZE5Gwgj5wHi15xufs1MJOkk7MQ/iADwmXWMiGF4dwJk3n0RCY41I6WLKGeWSmCBTN21/H/0FUOOoyHC/RImfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:33:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:33:10 +0000
Date: Mon, 1 Jul 2024 14:32:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <ZoL2W1Blrhzf19oM@lizhi-Precision-Tower-5810>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
 <20240629130525.GC5608@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240629130525.GC5608@thinkpad>
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 030de6b5-4b62-41fa-2c40-08dc99fc4280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFRneWFscU1PVkMxRHlzYTZQbmJJN0hDdytHWUI2V1BoZGE5QlRZOWZJRW1x?=
 =?utf-8?B?bVRXMGJkSUtlb3N4QURkMytMN3N4dkpUVjBiQnk5aVNhd0V4NWIxZDJJZGlC?=
 =?utf-8?B?RlZKOGp3Z2ZZd2FUVXVSVXlyZ0ZqMkNrK2RQbUlINW9VS250ODJRZzBTZ1Uy?=
 =?utf-8?B?UndNTmhlSnVkRFpmQmRyYkZFVnZtTVFpbXBnRDJDUEhxM01UdDhjSWt1aHMz?=
 =?utf-8?B?Uk9WaDRkYTdseHlQTlhvd09vNnV4cVh5Y3U0SDNNTUhPTnl0Yk40YlllS05w?=
 =?utf-8?B?azRTdFhtWWE5Q0xESFl5SWN1ck5XY1BnY1J4dnJhd2laTG5PRUFoTlFBQWc0?=
 =?utf-8?B?QUJGNTFYbDEyK0tzam9tcUVEUWI0enBUWk1xbGNDNjkrL2pnMy9PQVkvdmpx?=
 =?utf-8?B?NHBXODdIZEpaQzNhRG1kbWI3VDMyTGlmbVFwRlZ1bzJ6T1dHZFlnb0JQdUps?=
 =?utf-8?B?eUExVmk1a0dsdUcrZmtyUStTcUFITGZpVGh2all1ZTQ5RXkySmhtZnFxalI1?=
 =?utf-8?B?d1VNeCt6YjhNalQ1OWlPQmk3UldRaHp4eUhWTUI4bm91ZWRrYzdJVGxHMmpU?=
 =?utf-8?B?TTVvdFpRUklWbkh4NnBXWUswUDE4dlZXVm9FcWU3L2tRVEZTMW1kMUcxYnNX?=
 =?utf-8?B?VHFHcmdScEpIdUhucDlmUXVwQTRJUHl0T1hXTytLQWt5NG9kcmVvenpUZ0cy?=
 =?utf-8?B?b2JvMy9YVytSd2oydHNYRHZWUlAwSDdkbklvd0dkbHlYL3lqYWUzZW8ydW43?=
 =?utf-8?B?ODgzRTdxQTIvRDAvT3JlOU43Q05PVlhSZFRNWjZJdk9rRzZhOFUxOWV6NjVl?=
 =?utf-8?B?cWsyZUJOZUNvN0ZaQ2NKL3RKTlIvbllsTEk1V0NrOFo5VHdmK1FVdlFRaHJ0?=
 =?utf-8?B?TXlCSU5RcHB2OWt6U0ZSTC9KMmtUVjFTdi9RNEdCVEJxcXBLa0RqanZLbUFM?=
 =?utf-8?B?bDN0T3V3Q1VzV3JvTXk3MzFwK3hSMENsa3Q5bS9CUVVqeHBxMTl0ajMzWnhu?=
 =?utf-8?B?ODdqZUlXV012c3ErY0kxNnU3aFp6Z3YySjk4N1AyT1pmR2NiVDVSakZ1Z01Q?=
 =?utf-8?B?aHpvQytKMUQzWVVjNFBvanZrRnB0Rjg1NWY5dk93WW0yVkVxZHhqYW9SaGUz?=
 =?utf-8?B?SkV4TmdGTHhjamNGQitCR3lHSnpxODhQY1NNbmxJdEtzN2RUVTVITUVBdmVH?=
 =?utf-8?B?TGRSaExQM1pQUk5MbkpWQmtIVkI1YVRldC9CZFF4QlBsamZOZ25QcU1zMHpv?=
 =?utf-8?B?RU1MWXkxNnFOQ0tVUFZtSStWeHRFV09YTFFicU0yOFU1ZENGWW5xdndYTXZH?=
 =?utf-8?B?UjRocmplVTVCYVBnWFN4RVZqbkxvZmZjQ2pqaU1OQkgwQllKS2ZLTFFKdEN0?=
 =?utf-8?B?MVF4YWxXZGY5UFV5d2FIQVhKSVFZRURHWmZMdmxrSEhHN1Q4ZWk3MGpIYXpx?=
 =?utf-8?B?NGx1RlU2NmQzYUU4VmduVWVlMlVCcW9tbGhzZzZsOWhNRWxXRk80cDdWbS8v?=
 =?utf-8?B?Q3ROOWdqY0tPbW9JR1pOb0lPOFhVZ2pMaks4QlFsdlhvNFlyWlBYSnNIS0F3?=
 =?utf-8?B?amh5MHRJWmhIWllDa0dleVB0ZVZvWUtpbC9qVVVEQW45VmZXeWlFRkdKQjFK?=
 =?utf-8?B?YUtjUGF2RmgxZldwMmhaUmhPTFlrR2IyeE0xN0lXQjU3eWg5NDNYQStuYUtD?=
 =?utf-8?B?T1E1eFRaSlBzTFhWbm1IWS8zZE40aVRPU0FuYlpsQ1ZjRHVrRktKZ3V0SXBC?=
 =?utf-8?B?NUJDVU1nTDlhdzRHZWxNOWRGQXJDVDZLWHVGVVBFRU40OHNqMTB2V09NdXFY?=
 =?utf-8?B?UXZaYjMyVDdIVTVwUkp0QVhGbmlCY2dkY2Jyd3paNFhTRldpWnlKaGxxYjJ5?=
 =?utf-8?B?cW5LZDJWOS9hUHllYzFmZjlvMVVwY3MrY0RJTm1RS1dLYVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJPVGtsbFppREhWWjJzbEhES2kxNTh0STkwWndqWVZFWkh3M2xGT29qaHhl?=
 =?utf-8?B?dm1BaTZsWXQxd05xcEExdGJUdWRBc0Y4Z2FzelBicFdPYXlMTkd3cHZqY1k2?=
 =?utf-8?B?a1hYdUZOTms1VFlBSDJnMStGTXZCdHdzVHlGaTdidERxRUMxOGlXb3FWNWRs?=
 =?utf-8?B?emVaanZZbjdtQmVrbkdCUzQ2dVF2Q0RweG9hZnhsZWhJOE11U2haL21ha2Yx?=
 =?utf-8?B?cUt2ZnFCaFRrYWxUK1BIMVA4MG8wNkovd2diTVdmMGt5eG5HejRtNkRqbEUy?=
 =?utf-8?B?MHdRcW9LaVo5U04xRGg2dmJISk1raU9FV21MV3B2d0RKakpmcVVESjBTdmNz?=
 =?utf-8?B?S21aY1hrYktJVkZpODR3eERtY1JtR1B2Q2s0bElFdUY2REFzVmFUUHh0M3k3?=
 =?utf-8?B?bUw3bXJwYnhpZmpuQ1pmT2Q5aDI1M1BXTjR4K05JZlVUdkVxNE9DNmQ0anZQ?=
 =?utf-8?B?RGhrL2htRHlEUklTS0JCSi9JSi9abi8xYXUxcFk0TEVBVmZLRGlYM0pqbjE1?=
 =?utf-8?B?Q1hMRFJXVlNlZTAxNVJ3MFkxSVZjcHF4K0x4MVVxbFZBQkE4M2hPeUU1a2cr?=
 =?utf-8?B?Sy9HVS9oVnBUdnpzY21zT212N0cxL3hqcXZnb283NllLQUkwR2F5Y2lLWGxJ?=
 =?utf-8?B?SmV1UWxqckF4a09LcDBCTGVMdmluYlpkRXkrUGI3QTBzK3d1L1YxaUhVaGN1?=
 =?utf-8?B?NEFCcU5jWk8rQjFXVyt0QkhuYk01a25GaEZ4UEkyeHY1dFNGd3I1RSsyc3hI?=
 =?utf-8?B?QWNyWlV0RlkyWVJwTTR4WGlwcGwzd0JlWnJuSlhhNG5QTU5sOWgrZzdLcVBj?=
 =?utf-8?B?SmZITStnVzZ6dy8zd3dsc24zc0h3Qms0bGFKZXZBY01VcU1YakNRV1lJcThR?=
 =?utf-8?B?S1JQWnBtL2xGWmVGNG93bGZtZEU4VXFTQjZ3eUUvQ0hxVE45Um00aEUraUdr?=
 =?utf-8?B?OHg1ZzlLaGJjNE1ic01hR1o5YnlLVUYreWFjbjZWNnVId3lITWVzZnl6RERU?=
 =?utf-8?B?c3hzellvaytkNEJzVXVjMlZoeVkzanoyRW0xaDU3NC9rQm12Q1Zzb3d0VjF5?=
 =?utf-8?B?bjBmZ3EwWGVrN0dtMTJiZ0VUaE1ZWVdqUyt1d2tRQUtVQ0g2ZE43aEgvS1hw?=
 =?utf-8?B?WTVWbFAyYWc1NFZQclBVTUx4YlVnSlIzSzlHNlMwcFVpYWFmN0tKaXhZOVVE?=
 =?utf-8?B?R0NPRXBGSzRZVmRiTHE0Q1JSZnF2dHEwNVYrdENOc3dWOVVGZDNmRFdDN0ZS?=
 =?utf-8?B?QnpiaURkcVFralc0NlQwenhjZ3kzS2ZpTVprTEFZV2hCSFVDZkxBQUxNOGww?=
 =?utf-8?B?ZzZFZXBYM0d4a2JzbWJHWWN6S3RJYVdCK2M3U25xN1AzNzk1VkxRdVREL0Ux?=
 =?utf-8?B?RmtMdDdkZC9uc0o2a1BBdzBtcXlGYnFaVnozSUJPY0NBY1lKa3JWZEtwejlF?=
 =?utf-8?B?bzZuZ3hSRFlwMStKcXk3ckUrcU05L2lWVlJzNjY0OHlCUGs5VENwb2hSenNX?=
 =?utf-8?B?MEdjWDRTWXg4T0NzelJwSmZqUUx5NDI5Z2NaTVExeW1rVGFNWmZKTXEydXdT?=
 =?utf-8?B?VDBWUENXWmpVeGIwejZrdXdnOWtLVUJhS09SMFhLNUZIVFlXOVNremVNbG9j?=
 =?utf-8?B?ZmhxakF1dU4rR1ZOWldjNU5QZHphVHVEaWxHdFJ1L2E3SHkrdFR6TkJhbE1a?=
 =?utf-8?B?bHJ4M01EekdGNysySk0xOEY3eXlydFpzT0hmbTk1WG5KKzRzQzY2MXhOTmdq?=
 =?utf-8?B?RUY5cW9VdTFiMFBnUnEwaTRDYXJRZDlONXA3R3AyR2k2OXJwRklsOTEvOGkz?=
 =?utf-8?B?a05FRVJqdDM1cVVpQm9WNlZlLzRnc01sNThncW5sVnFSSk1JWE9RVGR3UlpU?=
 =?utf-8?B?cVlYdFBUc0I5NGcwV1dMTy9FWWZCa2hHTWgxZXh1VkdKUmVMQXhxMmk4d285?=
 =?utf-8?B?aldJS3J0NWVQbndqM21ZSUNNT0M5TEgwLzJ5V25lOUZlRHBKY1dyQ3NYR3gr?=
 =?utf-8?B?bGQyK2JTaW1SU1U2NXViOXdESGRxbDJ5UStadjFPMHhoSWFlVStMRVg4aWxw?=
 =?utf-8?B?b0NhQ2NVSEcxRFptS1F4MFRNdW9idGREcCs4MS9BR1g1OFVDVWQvamNRQ0tC?=
 =?utf-8?Q?bhK7XQTqXJCaQCn86TlpcFwHk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030de6b5-4b62-41fa-2c40-08dc99fc4280
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:33:10.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJw4X4TKj/IOAY/oNqhtFK+tSSUKKb5o/3A5lmcoiSj1Bt2lLsW5rL39Sez7C1SG/nzd+ozxzJT+OxXy6p60+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

On Sat, Jun 29, 2024 at 06:35:25PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 17, 2024 at 04:16:38PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
> > hardware alignment requirement.
> > 
> > MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
> > aligned to 64KB.
> > 
> > In dw_pcie_ep_init():
> > 
> > ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > 				     epc->mem->window.page_size);
> > 
> 
> So this is an alignment restriction w.r.t iATU. In that case, we should be
> passing 'pci_epc_features::align' instead?

pci_epc_features::align already set.

pci_epc_mem_alloc_addr(
	...
	align_size = ALIGN(size, mem->window.page_size);
	order = pci_epc_mem_get_order(mem, align_size);
	...
}

but pci_epc_mem_alloc_addr() align to page_size, instead of
pci_epc_features::align.

Frank

> 
> - Mani
> 
> > Set ep->page_size to match drvdata::epc_features::align since different
> > SOCs have different alignment requirements.
> > 
> > Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 9a71b8aa09b3c..ca9a000c9a96d 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> >  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> >  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >  
> > +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> > +
> >  	ret = dw_pcie_ep_init(ep);
> >  	if (ret) {
> >  		dev_err(dev, "failed to initialize endpoint\n");
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

