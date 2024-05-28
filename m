Return-Path: <bpf+bounces-30781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A688D254B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52892B2B3BE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635F180A61;
	Tue, 28 May 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lLpdlxGQ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC41802C9;
	Tue, 28 May 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925240; cv=fail; b=oE1fGXyDqvmXPmQCIRs/H3wZ0+hSVHnwWWew7sb6nEAz/8WRVSCZWZcKHTBqyIggvD1jRqQo6v4C3wBYKijMnnaLMRpFVQt3vQoLIGvXrJFYa7y1zcRXkO1PtUdzptq7RhAQHBpvNtjoLvdFA8F6nxYmQ3osE9vxdD9c5YwEccw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925240; c=relaxed/simple;
	bh=9Km3u9aBE/ZVY+SXd6a188LIRuhze//qBUh8r3MmfkM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ihTQLKAeRbrVF0MKwOxdbMnHTXyujgW40iZ5OWyMhgyG2qo9NX9EHuL3XPQMdnf7PCLxgC71Yu4X0ducHL9lBAujqa0yvhHI3RiFjxGxZi/kTRonQwwu1VkLJc1K+pdzNhKDwOO0/R7yKmphNErS74sj9VBMfG84ew942Xol/wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lLpdlxGQ; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzN6BUiqBXaKGAE3JUap2LmC6R3stJvbhsJLr4Pg/7d3kaBPzXcpTFQjT4dqk3EHRxXCukBuqiJ4Rz2T2oPs1y8xY4n3jGfSKMzTVnu28upoLIDZCHFY1jE+ffLQXhdV5qQW6r/Lr4/IohKi7y+EApo8xYEGh89Hoa69E9xvFmfe4MYy1IV7ZiVqTz/Eu/jDQfvzCOSwkzZi1ECZsPTUAeoU90H93t++gji51WYOg7eiPKaE8RkqgxHrSwdPmxA7a6QcKpQc6B1PY7ZgLMOf/A7BNDKSLTQJ7AvLmXoPDYCtwviSVpQmVaXilqLUbWU2IK++e5zUQFqrbEiRn/4QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC3OeN8RuPZv2SL4sTYPyf2DdoTtNb7wVHnPKUFLeOU=;
 b=cwh0c3Pq/CHDuOhft1DsKJ5KwA55Q+mIYJS93mbYIB6WWQ0dayyyGbnc8/V7DR/Jn+JUesF37dxRhtho9vKLXXj+U2boyVAjs2+XcIDJYXNl1d+fADfaS7PWgQEDMxxtLoaqOeqxPPKcpBBSpqeDhcIRuxgAff43Fjd76LTJ1o8yJfOZrxt8piaFrGbeYKXFRm+XOWQE1J25ZIRaUJBb7i3KMrXEySMXJzr9/rhPeyOT6QJ19KsA+v5LvVaPBm2A3aDiHORsEQykEDeg5xOonjdbkk5mxwpIGhMoZbWmPmL5OlmwWGJwXbk1CZJQam3olkL7ljCCxa0rmZ4oT0Rdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC3OeN8RuPZv2SL4sTYPyf2DdoTtNb7wVHnPKUFLeOU=;
 b=lLpdlxGQQWxWIYykn2Qa9QkudyjbFKIG0O7ZF1ZIhM7sFWZYZu8pFCUM3q+MDyxJMBSKMUm9l8ovSHChbcA7TdssajTafYtBuuFmLsUoZDBbesWfHuGU4VO+DH67ubdQoLx6nfithOPpB4efbhvOEAn9ouJgr7Vss/UTo5zsJP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:25 -0400
Subject: [PATCH v5 12/12] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-12-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=4309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DnYV5g+L/9C8UBBjY2j1EWTxEjBk72r1qGX5/5qY8s8=;
 b=nafkjeouL4yNTUHEZE68/rAO6X+XSX9GRj4hQIvrgpB+XcYpfm3f3weOO1EWfi+kdiYwOoi5g
 bVxawtsrgOzCTIKcEcUUWJGlg6m5sP5WRw2Ebhu0tkA8E8uKRVKgIgR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de7c32c-c21a-4396-1c74-08dc7f4e0b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmp1NVdzVDVRVUtyaGhNSVZlV1BNdEgyZ1FYcXRTd1RrQkRObnE1N0loaWV5?=
 =?utf-8?B?ZHFwcjl5TTFwd1lzR1JaM3U0VEZlYzhEcUdHYmRFcGZDNktWSTh6aUFhRXJz?=
 =?utf-8?B?SzRMOU1PZHIyeTZrVTh3Mm9BbkNibHFrNi9XM0JxcTllTlNub1BhRU5BLzd5?=
 =?utf-8?B?K1ZkUnByclZkNXNIdFFUK3BySGFxTHhUaDliR2dhNTN3YVpIT1N3WDVBVkVT?=
 =?utf-8?B?TnhOVzJKdytoREpiTm5CV1pMMTE3MDZRVzdoZU9DWkd6WXhhODdMQnViZnFS?=
 =?utf-8?B?QmozU0lSYjVRQWs1NGtTS1gvaHArRFhrWUpFUTdKM3NhMitSTHdwclhGMk5z?=
 =?utf-8?B?WGNZbG5aM2tyNVg1NTl5a3BuTmFJZnhhVVBlYS9EQ3ZPWS9qQU5sb3krQUE0?=
 =?utf-8?B?L0orLzQ4MGVWUkp5UERPeFFhTjJNem5ybEh4M3lBVE1qL2hISk9VR21mbWxi?=
 =?utf-8?B?NUhHZGpEMlpic28xS2lNR3ovREdmVDlORU0xcVA1eEZGak5iNkVTZUNMc2Qr?=
 =?utf-8?B?SWUvemdiK2lRSkRub2VJZU83bUdJMjlxWXY4czdMUDh0N3JMWVZYUFZaa3Qz?=
 =?utf-8?B?RWtTSGJtN0FyTTd0bHZYamtLQ2F2T2t4c1NGQmZHaXMrdkZLeGVPS2c4MTRi?=
 =?utf-8?B?T2REZTlJdW1oUC9LZkJPcVNsNklEWWJpejhOZ3ZReVpmN0tsblkwNjBnKzBM?=
 =?utf-8?B?NzNCdXVWL1gyWHd3aFVKcFVOQXQ3aWp1eEpONlh1UjlYRVRZRy9hclorMkxP?=
 =?utf-8?B?MC9ueVdBanJ1QXNMRGhGd0hDQmFjY29sbWxBTkk0d01UTmVrMXNkb1lsRHBF?=
 =?utf-8?B?UUorSlJXVWMyaGxIeC9LTW5kRjRCR3Awd3JhcFlCUjVoOEVucUZVUmkyRldI?=
 =?utf-8?B?QURyNWcyWVBjUjFoRG5pUmI2eEcrOHhWRHFxcnhRZmdqU0FWSHJJRmZ3a0sx?=
 =?utf-8?B?bzlVWklSNjN0WjlJb3BLYmNJYUlpRS81YjF4TWpqSVpBZ0tBN3B4bFZqaENN?=
 =?utf-8?B?MnJaVzJrUkUyUURzWnplbkJpZ3JISGtRRzBPTUU5Mlp0TEVSY2xMdy9PTXZW?=
 =?utf-8?B?TlZFMk9MWWN1aWRodVBzQ1hUd1NrNk1qeU9QVS9PcmVJcjQ5c0p0T3BlcnZQ?=
 =?utf-8?B?U2IrdGVVVHRTUGNkVVNPU1FramdJUE9xNkdDdFp1M21DNG53Nkt1L2liT1Q0?=
 =?utf-8?B?TWRxd1FRcGhvLzZDeWgzQWJQdVRUbFdZVlFQK2t0Vnc5ZmtYUFdhYTNHd2Nv?=
 =?utf-8?B?TW04eHRWb0tHOTNqcnRFdlp2aXdQV2krNXd0Z3pHSnVoa0ZENDZ1VWJQNWE3?=
 =?utf-8?B?b2lIUS9PREQ4MW1XWUtJSmJLNWwyRFVaTjUyQVVhQXBxald3dWJ3TzRQSlUr?=
 =?utf-8?B?TmZPUUpoUDhsbzhhNjBFQi9qd05NNUN6aDk0UExMYmYyUVl1US9DNUtNT0ti?=
 =?utf-8?B?MjdYaC9nWTNxNDR6UUZFM2txWVhXQ21LWWhvdE9GVjFmRE0wOWpJTlFPRGg3?=
 =?utf-8?B?VDJmWkt4bUs4OW9NeUFWRXh4Mmk1c2NvOUM0M1RDVlZMay9iSkk3bU1TVG1v?=
 =?utf-8?B?R3l2QWJRV1BuekV2Y3Z3bGNva25sbXFKejJ3RGN2WkE2ZHlRa2hmdDFrbXVl?=
 =?utf-8?B?MUdESkhtVFR4T1JPbUQrN08xd3hIQ01EVlExYXRjQjZiYVRIL29kOTRzd003?=
 =?utf-8?B?VkoveFFNOEEzd3ZYUktZU1pCZ3BMaFY5VFBOcnJpSXN0QWlrdm00dXYxNHB4?=
 =?utf-8?B?Nml1cVVHOTJSb2xWNXhRWEZGaVRQMm5xVWc4UTJqRHRIWTdQMUZpUWplbTdh?=
 =?utf-8?B?YnU2KzdYcVlURENaLzZjdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dml4YzVSRE9xZytaZ0IrdVV0dGoveEJZdVdwankrTjluT2FGTXlLa0FMMkdM?=
 =?utf-8?B?N0x3SEhLTFViKzI1WUNOVmVCeUZqcDVxYnhZcXJsVG00Rzd6YnZjWXVmYTV1?=
 =?utf-8?B?QXhuVDdaaFB4cTJMdTJCbzd0dmVJS3RQN0ZDcE1kZVdUaysyZUFKLzhPb3Vq?=
 =?utf-8?B?KzhJWjI2R1VudzFFcitaVmNXVzZ0TTFzd3dMTW9wc3UyaFkrMXh3cVJpM0RZ?=
 =?utf-8?B?TG55SllvaG1TK0EvanMvK2NBdFJjSVc4VEJTck9ueklEWStEaXYrYlF4Nkxn?=
 =?utf-8?B?eHByN0N5emtrQTJXSUM0UkNJRnhmNUpacHhtRWlINzdsUUZTRHBvcUErK01t?=
 =?utf-8?B?R2UrbDFtUzFPbEpDeGwybm9GaE81dThwWVJ0em1LZnJzWWxFU1drRStxY3Ey?=
 =?utf-8?B?OXhnWG5sZ3YrakM4c1hCNFU4dWVVU2Y4Tko1OEo4ZEI3K0NucnJ5dSsydzhY?=
 =?utf-8?B?aU00RHNRY0xwVmtBVm5TeUdHQUFZa09wZkplWU0vZXFWdGc5ZklkTGI5RjZj?=
 =?utf-8?B?QWhJc0hnbTYxakxuQU5oanhUL2VIa1RpNUVaT3VDSHV0b3FNdmlFbjUycVRQ?=
 =?utf-8?B?bGtjWEttUGJlL3hHdDk1N0NnRUc5Yk9jYkRMdUt2VzNTYm9NZ0FrVFJ0L01w?=
 =?utf-8?B?QkNSSmplakZRakRIdlpvcnZ5cW9LU2IyNXRwL1VKMk8xamRrTExXdFZNS1R0?=
 =?utf-8?B?Zi9KMWpjKzRPeGdhVU41dklmMXlvTE54SUppTHk0eHVseXoyWTR4Z2lKSGxj?=
 =?utf-8?B?VFNwKzloTDlCYUdrKzR6T24wQ3JZOWJyZ2VlWjErMURrZDMvdkdvRnFKUlJr?=
 =?utf-8?B?REkxVlNWSlE1QUhIOUM1NnV2NzIwdHV0ekkyWGdCeEw1REFnNkswQ21ienN0?=
 =?utf-8?B?Q09yMk4wbWdjSG0zaGMyaWFvL1FudGVQU0Z4dmEyVGd4bUtlaGpYb0xTdnRX?=
 =?utf-8?B?V3ZxN1pDR204QTQrenUvYk1qYytSZHpSWm1ScTN0d3k1WVNkUXpMeThNTXdE?=
 =?utf-8?B?ZDBPbnNNaVFQVVBKSVpjUnhLVTdGMnZTY2NQQkg3S2VkMUZTb2czYURsR1Nm?=
 =?utf-8?B?cVdBeDlRZjh5NFVkc0h4S1lXL3hxdmg3TUdOangyK3hnUStiL1ZNam16YzJS?=
 =?utf-8?B?T29qMStST2lET0RrVGNJQlh5TElUN3V3MGd5bUVQRVF2MXhCME5Ma3JyZGNV?=
 =?utf-8?B?NVgvOXdKZVhDMzlteFBjcXVZeEtKYTkwdlBiak9xaUtpWTdsempwNWpRb3Vq?=
 =?utf-8?B?VFdPS0RBZlZ2U0MvVUxKVm9jWWdnOVEwZXFicG15RXNSQ0N6TklTaDBmS1R3?=
 =?utf-8?B?QUM4TE1wR3BLL0tyQUJaQVVVZlQ5OVpFYmxNQU5VNVF2UWJ5bExNU01CdUJo?=
 =?utf-8?B?ZUFHNm1UK05SYWFTVTFpOElZcVk4clQ1cWl0Z1dsOW9tZkoxVVo3clVrMTZE?=
 =?utf-8?B?d3dCRHhUeEVXcnlaektTTndPWnEvbDdUYkdKTjlLRnpsZExMV0Y1OWRMUkJr?=
 =?utf-8?B?ZkxCbWNvajBHcmlUU2NKNFpoQkF5Y2lneUsvdHVHYWRCTnFTTGxTb3N6aXJ6?=
 =?utf-8?B?dDdSVkpFT3R2Rjg1UVlQejdsVHNoTzRGdEZ5WWI5NysvS1NtNXNyYlFVaHdY?=
 =?utf-8?B?R3ZGRjdQL0VLR3JPOXpFS28wam9vS0Z0Y0JmaDdMdnlYa2Zhc1FRSnRNekpX?=
 =?utf-8?B?SXdLYW9LUnpuclozZGlBeXVwamlNYUY2S2RyNmwrTC8xcGlmZEtnQkZVQXFi?=
 =?utf-8?B?ek1NRloxeHRQQTJ0QVpPREhscXN0eFpXU2psTzQyVVd0M3dNTWhrVUcyTUVI?=
 =?utf-8?B?MW9Qd2k1NGtLSFFJQ2dDOEk4NlpIem5TeitKdXp0aGNoZUpUTjF1SzYyRDZa?=
 =?utf-8?B?MkhsK1k4TGN5ZHU3YXFoUWs2MUpjTTVmL05UNjNXaDZ3TU5tSGZqUkNrbFRX?=
 =?utf-8?B?bVo1NmZqcFVzRFFESENlUDR3NVBTdEUxcEtKU0VLVVowMExkQ1lkTmltck5a?=
 =?utf-8?B?Wnp0a2oxckZ5cWR0SkxhMkZkNFZITUlRZzFWUGIyLyttVDVwU1gyMEpIYXRz?=
 =?utf-8?B?UUlLTGIxTHN5bVBWeVczYVJqQzlmWUJkeGJMMXRoNWNuNGVUTUpCeGtmYVUy?=
 =?utf-8?Q?QDJU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de7c32c-c21a-4396-1c74-08dc7f4e0b46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:35.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeZ7FL5p46O0AlHYHM5QxEf0dM3OpQbI/0cE8o3pMJQSdqTlybTqJkgYtsOidld5xxkDnmfV0tO3uHUzujFOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

From: Richard Zhu <hongxing.zhu@nxp.com>

Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
the controller resembles that of iMX8MP, the PHY differs significantly.
Notably, there's a distinction between PCI bus addresses and CPU addresses.

Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
address conversion according to "range" property.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a725ef6ed0cb..62713a0e381fc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,6 +81,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -97,6 +98,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(9)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -1086,6 +1088,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	offset = entry->offset;
+
+	return (cpu_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1094,6 +1112,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1593,6 +1612,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
+			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
+				dw_pcie_host_deinit(&pci->pp);
+				return dev_err_probe(dev, -EINVAL, "DTS Miss PCI memory range");
+			}
+		}
+
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
@@ -1617,6 +1643,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1720,6 +1747,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1798,6 +1832,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1


