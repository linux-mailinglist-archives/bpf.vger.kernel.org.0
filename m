Return-Path: <bpf+bounces-28115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD18B5E74
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074DE1F22AAF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4B83CB1;
	Mon, 29 Apr 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZ0a9d9+"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F074400;
	Mon, 29 Apr 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406486; cv=fail; b=e2hFBRSVLEvgdMDd3Gnf5ndOPGX/YxENR7b3YNh8V0tobiCqtO2mFxQNyIC0gfL5v5AhKl48i+FQ58fA/bEktkUs40FS3K5PhES1Ml/Yvv0AtBGgkGSaXQK9BiAUGJgcHDnQw1An2oveXsctkX/Pz/NfMSLJRQqHx5BWwoACiQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406486; c=relaxed/simple;
	bh=tan6HyRzKsbA1Yg2Xo6BYibIcQ9q/CXP16uaDGtkJTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BxrL7n5pZwLnn7lFXcR2CN0lXE6k4wWycKP5gYGMCGwOdCGOlnMyaK96M/c9BT+l+n9KmNcUb1JQXeacWYroqxRFNe/QZyZ0Ybp2HTqrLzXUsTgbGdet4F7SLdAzKBD+gB/2hhskWpX0TQ6Ay0DQPaTsor2sXD5mcNPyiibyiZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eZ0a9d9+; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8A2tiL6UZ9Zuln8wp7/ReLQ0Q7GFXYJz16/MhEHT0IH5vlOYb+Re6kN+uar8FBVAwq0DdaCLTL8M+hz8Dq8vZv/iWQ4Um3zi9ZlIa4YqkvXvcMq9UKGpsm/ne5SqWJ7ODQ/zSN6a+bnPOCOpbPotPJnU7MXAgktkXHSBPnLK8C7IMWlkLWULyivgHyqNCWwYzaUgVtJrFkw2RDDKIljYqCaSScwCjP1LvNXrsQiDwM6SJNqjjJfZAEoPXpUEx3LNMhlJBGRhxKrwUU/xpITsGLDctKcBUscM/tSaAKZexkvFTlM+DjgkfS+THDhQXXfiKhDNZnh9oYnFIvjYquSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYEoCpYTPFT/AE0LwXPc7m5eTmtduLPu3q0N+CoqPto=;
 b=M0V8MXLyTfl8jPCUkdmjC728MPUdRPCYEbve6fINhWQYaxEmLI4m6TdmZmRQvOPLyRbjL+7RqdW+lnEgPvOl4Wu1vD6v3N6d93NAwg/SjN0tfiued2JrZ6rVoMFBS9Qlrl7riJbmZFX40yMwwrOXI35vdM3aO4X9KVNJmvUwTr45MGeH6vNNXwD4ANShpcIp8TBt4LtgNplbLSZFPiTMrc3+HfJRJFhZ0I6esA6NyenE0lHr/HUuaNIYb4HSOayUqvQs60fAlSWuMSE3l9RuuJBydfVUx8QM6UCmcFu5yCPnlPXUKaXUr+Qm2tWOxm8TKgBVxDm4wsUmJfVvGLlogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYEoCpYTPFT/AE0LwXPc7m5eTmtduLPu3q0N+CoqPto=;
 b=eZ0a9d9+mVGCYLu8nmEbEx7yuyiPOxUpWNriLYeKmGxO9QdCJ55/SeckdGaukucRlqaIJ12+6Z6BilWo7+/Cqw/qAVNvz71JvfpGumQhQpA9VTonVu2OZ0BwDoQx0oNI4cAD1rct0NAxOrB8MltYG4ikQYYwaUdAHb2TrLswczs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6845.eurprd04.prod.outlook.com (2603:10a6:803:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 16:01:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:01:21 +0000
Date: Mon, 29 Apr 2024 12:01:10 -0400
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/11] PCI: imx6: Rename pci-imx6.c to pcie-imx.c
Message-ID: <Zi/ERqbE3jnUxhkV@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-4-803414bdb430@nxp.com>
 <20240427093133.GI1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427093133.GI1981@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d1a342-9eac-4f6c-4fe6-08dc68659d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNTZXZFZ0JDd1pkc0FSRCtVWERQYnBja0ZYdlJ2ekxtdEx4VlVEY2Qyb1Ex?=
 =?utf-8?B?QjlkV1JjTzhtMEFHQ1ZHL3FuR05DN0p0blI0eFVRS1czNktkWHMyZTdiUEdX?=
 =?utf-8?B?UVNGdE9ZRlNQeisxcVJZaDJNQ0h1N29EZVpoQW9rekdudStJcTgycDAvUVhH?=
 =?utf-8?B?ZkxaMFNiZjNRTko4dTRwQUZvNFVXc2xFOC9tNlpYeVhaQXdIcU1Lb3k4VExr?=
 =?utf-8?B?ODBSckJCWHJKdVlFYmhsQlZIVnFBZmdlSjhOS04yVzZWSjVkM3VCMjk3VU9N?=
 =?utf-8?B?WmRLSi9HTmlML08xb2ZOcXhXUHljaXNvMWlWa3MyZDBqaFhCb3JhSWZFZWda?=
 =?utf-8?B?U2RQQmk5blNwOHhtTkhkajI1QzEzNjErNEVzVk55UTUrQzRmQ3NXdzU2VmRI?=
 =?utf-8?B?d3AxdG90MXUzbkFXdjJ6Um9SWXNUU0FCaWh2ZTJ1WXJsOVRvYm1nbi85YXRC?=
 =?utf-8?B?cUxTcUpHV3ZEMEpFNGh5SnVKcTNQZHJMUlViWVJBcGZBWWlIbzNEejE1UVpK?=
 =?utf-8?B?cUpFQXgzZzJSZ0tWODZuQzBVWnpiOVNpaXNscGxQMnNoK0JZWjVIZEJhNnhs?=
 =?utf-8?B?Mmo3T3poY0dkTE9TbkVaMVhjeFNQUE1QQUE2cHpUdXZ6dnpKNWRzVXVRSms5?=
 =?utf-8?B?Q3pjYzFpVjF6bW1sWkdVQk1IQlpIaGFyYWh3YndXb0lZZmYrWHFPd29ic0R0?=
 =?utf-8?B?Q3J4VlpDVHZyOXJhenc2NDg1WDRYOU4yL0V5WWFaQzVsaDM3NUhCd2ROTFRM?=
 =?utf-8?B?eTJIdkdhb1A3L1hPUTVCRUpuSHRiRlY5WVc5dE5rRmd0ZXhxeW5uRnl3Rk9X?=
 =?utf-8?B?ZjhhcC8rWnBOcUxOdGFCNDRldzAyaXZJOGtHTzlUT0lSK09qQ0xCc2VWUno1?=
 =?utf-8?B?bmFWTnlFcUdxOVAyWFBoYnVudTdIUEU3b2p1UGFnSzNkdVBxMjlqREZ3dXlF?=
 =?utf-8?B?NDYwckFwYzJHVWZOY3ZpVU5yTnNGSXhFNk1BbEhZTHBmb1RzMElPUytyNkhs?=
 =?utf-8?B?ZExqSFQ4RTQ5YUZQY3RzMEplVVZNQm9WR2tNZlZhOG1NODNycUhsUWVVVmxZ?=
 =?utf-8?B?UytsSkJoYlJvZkNwR3FTcHhZRHQ3b2IwVzFqRlhlTU1mM3pVYW5KQ2RGVCsv?=
 =?utf-8?B?aiswemFBNjl2NHBrdUJNaFlXcndxVEkzTk9aRi82OFZSUUdrb0p4YWtWaDNJ?=
 =?utf-8?B?SUJhNFZYY29JYlA2bnJCVjRLYlpXQ25VY2puYlVjL1ExL0Z0OEdoajBpZ0F5?=
 =?utf-8?B?ZzV4d0I5ZFlsTDBiUlczM211Y0xWenJhTFJnY3U2eFpPYzM3bnhzRXM2b3k0?=
 =?utf-8?B?QkxVaDVPTGlRNktpOUp4eC9jWUFITUdoSWM5VnVTdWlCYWxTTWxqa2xZVzJR?=
 =?utf-8?B?OUdYN3FjWWhmdGtaS0o2ZjFFUlZrZjdqemVnNms2OU82TTN4aFNPcnN1eTk3?=
 =?utf-8?B?eG9ENGFvOEtTOWI0aUxhWnpPMk5XRmlFSzFvcEowQjlOa1NlT0pzVURuSFJT?=
 =?utf-8?B?R2krRVBJVzl2blo1aUJRdVA2QmZVR0hDTjRTSWUxVU95OVYrY0NoUis4OCtp?=
 =?utf-8?B?NDlPbnNneittU2VZcXZQdkc3QjM1MHFUbHZwbVhtMDJIRzVhTm92dzFKNGxt?=
 =?utf-8?B?TzMxaXkyMUk3ZEthWng5MTgwRmh5b2NWTzNoTWNlQkJ5L2xSeGlFSm5LbnJN?=
 =?utf-8?B?T3pIcFpzM0xTUzBmOEM3RlFDa0RTSjQ2M2pvbXlvYlF1MVRZRUhvVHViSStS?=
 =?utf-8?B?ZzVlWUFaYW5lNzdzRDBwUnUrZUJreW9uckF4RmNoT2s0Lys4TUc4ZGVWTlJF?=
 =?utf-8?B?VGtsVDVBSlRzdjFyaFJxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJYN2V2VnhDZTlDcytEU1drKzlKRmNuV09neU53ckpoMmh4d2hmb05jRGxR?=
 =?utf-8?B?QWQxSXJsOVZiMEtPRUFJYXVDbDhGVW5EaUNpM1VVT01yWTE2ZHM2ZHZsWVZ0?=
 =?utf-8?B?SmVDb294WEFMNndadHlnVkt1STk3K1lBeTRMU0tIRGJLU3RaTkkvcmJ5VWRm?=
 =?utf-8?B?bEVuY1l6V1VYOUc5RnhxYUVxU08vZUIrL2s2WE01c0g3RWxlOWlpSVFLMVhw?=
 =?utf-8?B?NWxlY295NEFmU2c4OCthWHkxWDVSamJSVml4aFF2UHpYaXI3T1ZGR2oxcTZ4?=
 =?utf-8?B?cmJwaGN1b2l3Z29TUnhkR3lmOENYTnVDQXN1MXJpMU1oK002MlFvTVE0NWw4?=
 =?utf-8?B?WGRRbktrdm1hejMvWXpKRmMxUDhHeWxxcjBIR0dlZDlDYnVNVDBnemMrRFdX?=
 =?utf-8?B?ejRkOWNJRkVhdDlYb2JMdnB1ZXU1RXQ4QWxORUZ5bFg2VGEyWURhNytHK09R?=
 =?utf-8?B?T3Q3QW5tdm51MUxnOTJpdHZTWjJaN2paU2RGRlBxU0FyZzNNYjVVWjIwZUla?=
 =?utf-8?B?MmViSnR1Tzcxb3BYT2kxMTdqSHhKVUZzVE1NWTUvQVhKOXpHM0tPbkFsazkw?=
 =?utf-8?B?M3E0ZWkvSm56ZEh3VlhDUUV3b2V5QUpOWndCNVJWM0IrVzEwbHpCOUpVNGx2?=
 =?utf-8?B?V3pNSUNHaUFRdlhLRFNBZ2IxbmpyU2pZWmc5NFhvL0FsTXVmQzZ4cXNVWnZS?=
 =?utf-8?B?N096aEE3WlhnY1psbzROUXBtcS9xL1JHZHhkZjNQUXY0SWp1UUVqYzRHS0lT?=
 =?utf-8?B?ekg2UG9QRXY2VXk3elNVNGFnenpHcUpBaFIyc0V4VGhzQm1Taml6MkRxVHNV?=
 =?utf-8?B?RDZpaDNrcklsN2xBVUs3TFA2U3YvTE13M2xBMm1mOGJ3NzdzTWMvUDZxWlNE?=
 =?utf-8?B?R3UvdVBjbEUrVjlqM0lNSDBDcFExejFiY0FHMjh6eTVYMmdtanQweXIxT3hB?=
 =?utf-8?B?QzVWbGoyZ2NvQ2tzUTdQV2xXajd0YmMyQmwzdmdiL3hOVXY5UE1pMmIrbGla?=
 =?utf-8?B?TGxWMjBKQ2VFMkQzQUIzMUNrZFJRSktPNTVhd0IyY2FKNUozampad3hneFpE?=
 =?utf-8?B?eDRrZkp0Und5WWE2WFhRbDVuZ3Q5VzVMdEV3emc4N3BVWWlRenlTVS9mRzBU?=
 =?utf-8?B?cWNZN3RxMXZYSUZtWWt2aVp2U3UvWUhsT3Z0b2ZYV0RhR2NuanExaklOVUo1?=
 =?utf-8?B?bUZxSnhnRFRVeFJWVkQxTDZnR1JuNGlPcm1WVTlHd2JqNWUrL3JxWDBnSGJq?=
 =?utf-8?B?Q0s2OXljUmxYemVsS3B6SDI2dkRlY1N0eTlTa2RpUnFEV2Q5dVpaeUQrcVBX?=
 =?utf-8?B?YS91d0g5WDV4QUNQWlNjcmhvcE56MlVDM2xzNjNvVW9LYjM4MEtUVmNUcXZC?=
 =?utf-8?B?VHFjTG9qMEZIM1cvWkZZNVExNEpvOE1JL2F4MDZXemdIOHI2TnZxYkFjUjZm?=
 =?utf-8?B?S2tLbnlNbDhKYTVaMXV4YURlSHBsRXFZTGl5c2FUcmo2aytack1WaG5WZTFJ?=
 =?utf-8?B?bmcrQ1RtR0RGYnRXaThEUFpHQWloM0F1UEFCc3RPOG45d2VYc1dYdjM0OHYr?=
 =?utf-8?B?R21MVUZzay96ejZsUGJoSWo0S0RFaEhEY0NrL2Y0TTVEWXNhM21pcDJwalgz?=
 =?utf-8?B?UzBWbzQzY2M1UVExWkFaMGVoZ3VpR0gxeTJKd0l1VUFxMWhLT1VjT0hQeFd5?=
 =?utf-8?B?bTQzdVYyMzlXY1lZeDRJOVYzOURRUVNDbUZzRTVBL0paUDVkSGFsSjhKRHY4?=
 =?utf-8?B?UUN5dnBJbFZML3JkYWFPUEN2bnhraVJhaksvRUJJU2svZjRzTDFNaWR0djZk?=
 =?utf-8?B?eTA1QTV5SHRuVE1ieEdnVWhUcjBBYVlqRFI1RlpTTWpEQmlkejk5eXVSc0w4?=
 =?utf-8?B?bWpDMDFnZ05LTmlNekNtY2NGbFBBaTV4cERNKzhSd21BQ0NuYkFDL3JvMzZw?=
 =?utf-8?B?ckRseURsTGR4TitqeEVBOURZUm9WbklRVVdDdlhyWFliNjZVRTJtNVoxLzdl?=
 =?utf-8?B?TnA2ajY5S1JOaENqZjhxOTZaeDY3YlpPK1pvQkU1SDdjamFQc0MwYTJJVGF1?=
 =?utf-8?B?TWl2bEZ1QkMycEM2QndyOFozYytFUTZMZWRwWllaOU40c1E4eFcvcGZ4TmFx?=
 =?utf-8?Q?GuEw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1a342-9eac-4f6c-4fe6-08dc68659d08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:01:21.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPN5ABm0FlUqTwHQPWpKuOxm5ZnAHv8YAAONY39+L+BzeACdYgLLBwnCqYT87F1SAoFe3YR8u3rPoarwPcqsvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6845

On Sat, Apr 27, 2024 at 03:01:33PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 10:33:40AM -0400, Frank Li wrote:
> > Update the filename from 'pci-imx6.c' to 'pcie-imx.c' to accurately reflect
> > its applicability to all i.MX chips (i.MX6x, i.MX7x, i.MX8x, i.MX9x).
> > Eliminate the '6' to prevent confusion. Additionally, correct the prefix
> > from 'pci-' to 'pcie-'.
> > 
> > Retain the previous configuration CONFIG_PCI_IMX6 unchanged to maintain
> > compatibility.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> You should not rename a driver as that will break existing userspace scripts
> looking for module with old name.

Generally, pcie-driver will be not built as module. Anyway, it will not
big benefit by rename after second think. Let's keep the old name.

Frank

> 
> - Mani
> 
> > ---
> >  drivers/pci/controller/dwc/Makefile                   | 2 +-
> >  drivers/pci/controller/dwc/{pci-imx6.c => pcie-imx.c} | 0
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index bac103faa5237..eaea7abbabc2c 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > -obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> > +obj-$(CONFIG_PCI_IMX6) += pcie-imx.o
> >  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pcie-imx.c
> > similarity index 100%
> > rename from drivers/pci/controller/dwc/pci-imx6.c
> > rename to drivers/pci/controller/dwc/pcie-imx.c
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

