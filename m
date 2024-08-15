Return-Path: <bpf+bounces-37274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2895365F
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66431C24527
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB71AAE30;
	Thu, 15 Aug 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FqmGhiUI"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F519EEAA;
	Thu, 15 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733805; cv=fail; b=mE64y2UlSsvzdUXxtY9uItGQSuWIVTVV1L89KSyAr3t2MnrORUHDSm8NdNa4ZavE5oQDXrq1py0AL+BcIPaTrmEzL/WeTjqRuAYG1YNn4+tjkczvFLLlch4tNNGWoudijByf6xT4iO+po/apAPXnli/Km/SfpTJdJMEFsqYYaho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733805; c=relaxed/simple;
	bh=KZzYhLAfS0A1nGnbpKtVpy42mhCfF6Mzl6GLcwEpGTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSjg8/45YqTfUnUOqZ5DFGlXE37Ll+Hc2dg+W03xegEEChV6nws8ct65765Ya7XRyAQXL43rvKbKI1CQ7CNHW39XVY5zwxgz/TtHD7m2dQOC1XNEz8/Yv5cfQzHT+NzJdrScAEyMaBsMYa2KRjXqXt3RzGtyhAebYiWK0oCpDfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FqmGhiUI; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozfEWYodLlD3BsVuBxWlErqagsgRm/q9GWtB1Esn7BCG9HvSNmmVtgsfQA22bzFeoaPL0zrvBDwgCw2rVtPS+bIlcOKE0i2TFGp1ZFbp/wPB4+nutFBwiFJUxDdoqzH2ZH2jA562TY0le3FMizwfWw8f6R8hK+0ORssSc4wOSFY9407YEWQbZJeddMdHjNebS55kpYCu1RHfTWIUE0vUT6tqtq/9zZoW/jvLAxEIlkJBERVKW/YtfpmJ9hSGBSl2HXgRGIEwzGJDKnzu6CQq3dhEtKiIV5OuGYWd1wyAvx2hw/C5JQ8DTlXqycPb8rU85RHGxkMAYVRF/2ZGPk764w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4UWZKFL85M0y+4a+Q532hhJ6RMFDE26ZLi6RGsKZ3c=;
 b=m5ObchUotOH8c+w4KPBBHd05pw2rUrdHobgPcRumFZuGKRN+243gsr+s4kZthfpEnyAMsGxkbl+vcCVrLE1XZUuJn/d5bDmwW/MXytCtZR24kwT5H98vr+mAShjD3oLEBwybfCcaoW2tkPi3Qom/Qp+y69cj38+MYU85yDbtTvnPP2HK6qAysN5dQlKld12mSKvC2i4D3Ce39sMIdw0qB8/nwfJkbHzNNozWiwggXG7Y96uWii9pSOiceKyRu+9pHRF+F/sx0eJUG8lcko1ENglvh8E7fbcAizQfTglTsTRWJJ4McX575DY4SRMN0GS/LmwyZzpqHJ5MVLVm1Z8AvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4UWZKFL85M0y+4a+Q532hhJ6RMFDE26ZLi6RGsKZ3c=;
 b=FqmGhiUIwYLDo72Bu9kQy3SsQcF9rMe8x30r1A7pcFIV67Yp2CjnJZ2AKad8jd2kaVk8hvYu6snLc8XcpYDihcB8/4seK1xPQUxJhwlBF4hkAFLWzSQ5r4WL9kqcwMKZSL0NGdsRCJKCHIx5IjcsDl6RPd2XEvak9IfAi/L1f0813Q+m2S+IHZ534Ib71Xh8wUiFyUkoVJWgZnKLO88apPtiJ9A0M3gqp9pIpp0DLa+fZMMsKStHG+jyyA6B23a3Ma9bHQ3a0nC0B5/y9bA8BrqUqIoURRtofhXKLU13iv+X9KBvzpmhuVsiRVrsMexBNg2UKQG7C+Hft3pYwbR8hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10216.eurprd04.prod.outlook.com (2603:10a6:102:406::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 14:56:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 14:56:39 +0000
Date: Thu, 15 Aug 2024 10:56:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
 <ZrKIotkhvAnt87fX@lizhi-Precision-Tower-5810>
 <20240807023814.GD3412@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807023814.GD3412@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: 313b4f09-47de-4bfe-a80b-08dcbd3a77c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TldUOE11ekVNZTBubVVUMDNQWEN3amU2YTFZMjB5eW13c3lXN1NLYWpEOXJ4?=
 =?utf-8?B?L1NMMnYzdWxCbmFCQ1crRWpyYVF3R2pITDhKVCtMdkZhWVZqWjBqenROcW5U?=
 =?utf-8?B?aHpWa2hYSXA5ZUlnSVlEMFNvam10dENxT0lyY0pSYm84WlZTWEFubjc3YUVC?=
 =?utf-8?B?SjZ0bk10bDRMZDJCVndNNzJIclRnL1ZaQmNzM1UzbGgyaTQ4OG9NR3JiODJO?=
 =?utf-8?B?QXk5UTlOV3luY0syRkFiWEZ0ZTMrWmZCODFYTXM0aTRTeTNtSUxFenRlQklJ?=
 =?utf-8?B?R0hIYm1sa0xpVGJraVBEdWpGOXBUdnRPL3VkRVhta1B5cmxIdmVaUlBTcWlJ?=
 =?utf-8?B?VHhrOTM1REFzWnZTS3VzS1dSUjl3dUlyb25xNnJ3dTRDQXBHT0FzY2lYa2pp?=
 =?utf-8?B?ek9FYk9uVXUwUDFuU3JxZWwrOFRPWWljQjMvV01XV1JTa3dPdXJPQnJqMzE1?=
 =?utf-8?B?cDVvYlB4WmtpalJmb2lCR1JoV3owd0hBMFkrYXY3WU5uL3RXbGNCeGJqYXRQ?=
 =?utf-8?B?aFJWUUNyL0NhNmhDbHFpbVpKYk4yVjRZcUpGWGM4NXEyOElLUzNXUHdXOTVU?=
 =?utf-8?B?L1pQdy9QcDRlTVNlQk1xZkdCMm5RcTBlL2p5S2lIMW9WRGNBVlBXUHp2Smxp?=
 =?utf-8?B?Z2M0ZjhCa2M4Z3I4RG1EZlladlVtallINkFWMVNQVzhUSnlxZlc2eE15cEtI?=
 =?utf-8?B?U09MQzUxc1JrSldVWUxVcWtFWXMrYTlPajdtdVdDWnp2azVmbkRwNDV5OHZo?=
 =?utf-8?B?TVJDa1dKMTFVZGZjelQ3Q01tQkV3enZsazJabTdHSjJTb2tsM0FpRmRqMHFK?=
 =?utf-8?B?ZDFQQmlIZWZ6REh6YWtMVTNyeGViV3cwSHdLR3FnUVpZWGVoVXJJSkVSdWVo?=
 =?utf-8?B?OFAvRnE5Zzc5T0xTSUNkZXh0c01la0NrRG1XNVFmbFl3THRGd3c1Um4vRHRZ?=
 =?utf-8?B?eWlMeGJSWXhYNDNFOFlReEVKYmRBZzJ2bGFYSjlTcVBEV3pMT2N0ZVZiL1dB?=
 =?utf-8?B?cU9yQUpPVUU4UnZFYktJN3o3VEdCVi90MWVKYWNHMHROaE95OVVray9NV3h5?=
 =?utf-8?B?c3h5a29zWVZjaWhqVjk3TXNqSmlKODZhcmNFbUtKUno5b3F3N2JPVzdDRzZi?=
 =?utf-8?B?cjJ4RURvRUZtRUZVa0N4a3pCeGRqdTB5enV3OHlmSGVtQkdTVExhWGl1ZTNX?=
 =?utf-8?B?V0dHem1yR2o5ZWJodVFsVDVmVVVCWmxLbWRtUzNMNUdvMUtZR2V1Q2N6bWpq?=
 =?utf-8?B?TTM1NFN2TGxhSWlmd0tRdmVZZXN3L09GOEJTYnUxZE81QnJqRURNbWJqNUUv?=
 =?utf-8?B?amE4NnI0anJ5Q3BvRWFJWmJ5RlBmRExKY0JzeGdMT1llWHdPY09JWVRweUJz?=
 =?utf-8?B?R1pFN2NJRHJQK0RXSW1OcHNPTWFxWExoVW80YlBscjBpa1Rici9JR1llVUpD?=
 =?utf-8?B?cmJ3SkdGY1FJditZZzRMcWM1SncwdTJlTmNDZ1RySUJWckoxeFJUMVlhdk1I?=
 =?utf-8?B?dCsreEE0YmloYjFDbDN4dms1OFNVazNjL1FuVFI4ZDZMNHp6VnRYRmtoREta?=
 =?utf-8?B?OTZ4Y3p4YnZrYU8zK1B0MG5kRGNsL1NmSXFyY2FhcXoyNmF0TTFJalIyNUFn?=
 =?utf-8?B?amJ2V1JMbmVWZ0dtS0RZem1FTmtRdmtQRWZocGhGeEtBM3ZCZ3B3TlUxWEIw?=
 =?utf-8?B?R25DWlZIRzJyN0VCQkhrR0J3c091bU45YXdNYS8rZ0txdndkVmZucllsckt3?=
 =?utf-8?B?WXFNcTU0TEJXNjhYNGp0ZmttbjBNaXpmdHZ2Z2xyWTV0aTk2aldJTGQ0T29X?=
 =?utf-8?B?Z0I3aklWWS9HUlg1NWg3NFFUWC9kZ0NVbFdzOVQxZkM3eU1BcGFDVEhPMFh1?=
 =?utf-8?B?SmM5YUw5bEZKb2F1R2ZIejVXTktESi9JS043NzJZQ2RZSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVRrK3BuVUhjYUhSOWVoQ0Z6TzJsQXhuaUVOUVZua3ZGcFEwcHhjaEZja2hU?=
 =?utf-8?B?ZnRPdmRNS1p5YkE5Ymt1L0laQXF0cFh0SDVwVklDcWNQeFFUWmlqTktDNVdQ?=
 =?utf-8?B?ZS82Q0RCYnpZNEV6ZGJnWnRrYTRXZ0F1WWlEcjlEblRFdEtjMS9XRkVWZHZ6?=
 =?utf-8?B?MzU0eU56RzdZd3I5NWJNYXdmNm80MEZDdWNOVVNaWXBRSUp2dU5vdllJVmRX?=
 =?utf-8?B?dU1LVWVDYkptYlVRQUlhTHUyMjRHamNINC94OGdoSHdUOTNGM25RZkFnVnVr?=
 =?utf-8?B?ZzQ0YVczZzBKcTBSQlNNckdUdi9QOWMzaG13bklOVGl4bEpVSmgvSWtPc0gx?=
 =?utf-8?B?Vm1TZ0NQUGx1M1ZvbTBNcmFwSjg3NjJuTHR2RlIvb1A0dll1M2pFenZqejhk?=
 =?utf-8?B?b0lyaEg3VDZVYnRvOGM1aXFadGxocWdXL0xJTlVLclBqTjFPamY0OElXQVh5?=
 =?utf-8?B?c21oTkZYVGczOFNqUENVSWNqb3ZIZ3lIamxoYTJvV0I1a21tUi9sRUdoUlJw?=
 =?utf-8?B?alprN3I4eXNUOGJTUTZUVlBsQldZNjRiNUZMMUFQRXArUTg3clRlMEVHeVoz?=
 =?utf-8?B?cmpSQVpmbUk2TmxMeDJzOERQQTB4RjlGWWZENnQvc1pydXY5cE5pN0pDNi9z?=
 =?utf-8?B?Y01LSG5DZU5TVTdiZ09pWDZvdHBDc2poSzllUUdvVHMrWWR1WmlSR1ZaWGhT?=
 =?utf-8?B?WFJ6dVFyOWFjcS85bTVzYm5jMVRmZmJ6YzFYUlpXR2RTSFBmaDJBdmZ4YklX?=
 =?utf-8?B?cFM1TU5KS0V2aTQrMGptdVk3RVJNdVdKR0lnVFRYL3RlMFlRQ3ZHOEgvLzdU?=
 =?utf-8?B?ZG8zekNnbmpGVnY3TXhSRVFnekREVmQ4RVkrWXFMSDM1VmxqaFZ2R2docEhU?=
 =?utf-8?B?RWtLTzd0dHhPVG56aHpzcnVQNEdBK084N1hleFMvcUp4VlNDUmkzY21UWDd3?=
 =?utf-8?B?SkZzeHJFdjFLbVFIVUszUzdzaU03b3E3TFJzYlBScHpyL3B1U0themloT0FS?=
 =?utf-8?B?ckpJdmpsZVBhazVXeStxU0U2TEJOek1saWN6MjVRdm03N2x0bnFEMFlBaXhX?=
 =?utf-8?B?TlFpNzRqYWdmK29KYkQ5MUtrSzFNQXppaEZDZCtIUFVNMVpvL1lHTnpucFJy?=
 =?utf-8?B?TTREc1h4N0hlY3E3QVNyOW1nOWNIY2hzQnlBNzR0SHBUd3RtTVF4U09QRE4x?=
 =?utf-8?B?WHpib2IvSlJKNFNYWWk3Wi9vY3R0ZkliVzFINTJ5d0F3ekh5R0oyeWVmc1R2?=
 =?utf-8?B?UndDbytaTytJenJRWTJZWkxHUUt3ckk2bVJRaVJCQ1QzVHJvdXFoY2s4d1hP?=
 =?utf-8?B?MDVOakMwQkhQc3AvN0dXR3A2YjJaUUFtWFk0TmNkQjg2RU54cHFVYTZxMnl6?=
 =?utf-8?B?L3JSci9oUFN6eTRxN2tVSVV6ZWwrTW9RclZMNXJXYnpqZVo4ZXEyYVBPZVp0?=
 =?utf-8?B?S0t5Z0hCUzRpUWZweGtGNGpMbzdkSzhyWHkyTytVWWNxVzErWU1KNUg3OWZn?=
 =?utf-8?B?Z0llUG9oSGdBL3d3ZVBoSzR5b1E0V2NQSTNkMFp6TmZHbThzUWZyRHJQSC9N?=
 =?utf-8?B?cU15bFVOYVVYdmRsbmhEREhkNDNTK21hSy8zU29McnNiY29iZnJuUjhJaUJF?=
 =?utf-8?B?N0FmUTNrQnV1aUxwdldEQ2syYjhDUnY2dC9BbzBkai9kRWFwL1ZRdk9ocHFB?=
 =?utf-8?B?VU85eEQyRm5wR2k4VGlDYm53MkRDN0c1QlR1TnF1NUR2ZHNtWElUZGdEOXJn?=
 =?utf-8?B?Si9ib3hZS3JXYzkxdThsZVFVbjl2SDR3anJqQXFXWU92T1YzUlB0UjlJYTY4?=
 =?utf-8?B?TWZzbXpTMlZCRVdoUmIwbjV1L0VETDNrMTdnaEhreVl4Q0s0QmdQSzRiZmVG?=
 =?utf-8?B?bXRFWk9sR3ZoekpjYWZEU1FBaVl3d2JEQjdOSHRDbDFINUtGK0Vad2o4T05P?=
 =?utf-8?B?NEpEZ1B2aGVpY0RMZ2QvYWY2QkxMeUdOd3I1bnd1azJqNTl3aFdFYmNrQnRX?=
 =?utf-8?B?SEs5a2NCNlIrMUhHWUpPNi9zSGJyTjNOYjJaVmExWmdWZnFldjZURnd6clFX?=
 =?utf-8?B?SkhSVWdnM3BaemV5Q21uTG93eWNvRDRQL0pvNjJQZlMxQ0UwMllOU1FpbVhr?=
 =?utf-8?Q?FI3zLp/LO7973NIQYjiz/MqpX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313b4f09-47de-4bfe-a80b-08dcbd3a77c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:56:39.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZHY6S3LCLt6svIqgF81ZeVOhpyApCjPSmscJHODYqUznjMrCuQPUPAmCJrLh6CTAxbM8y5Oh1+CJnyhHeKoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10216

On Wed, Aug 07, 2024 at 08:08:14AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Aug 06, 2024 at 04:33:38PM -0400, Frank Li wrote:
> > On Mon, Jul 29, 2024 at 04:18:07PM -0400, Frank Li wrote:
> > > Fixed 8mp EP mode problem.
> > >
> > > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> > > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> > > pci-imx.c to avoid confuse.
> > >
> > > Using callback to reduce switch case for core reset and refclk.
> > >
> > > Base on linux 6.11-rc1
> > >
....
> >
> > Manivannan:
> >
> > 	Do you have chance to review these again? Only few patch without
> > your review tag.
> >
>
> Done, series LGTM.

Krzysztof Wilczyński and Bjorn Helgaas

Could you please take care these patches, which Mani already reviewed?
I still have some, which depend on these.

Frank


>
> - Mani
>
> > Frank
> >
> > >
...
>
> --
> மணிவண்ணன் சதாசிவம்

