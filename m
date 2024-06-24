Return-Path: <bpf+bounces-32922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A401915163
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D54E1C22364
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E119B3EF;
	Mon, 24 Jun 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WyYlvrm9"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9C1E869;
	Mon, 24 Jun 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241579; cv=fail; b=PJM3qiFbO1duiEZetFIdf/nleejK9phIomR/d1PucC9YsttWqqU/kzcuFmjeaK9YCgk7ymZzOY5+LOdYRfWRZN5iS8PbkpkdhFXZ9/S3lU6Q/gNxj8fAkMb+g/gb4zeUC0umGLBcqXITTAXbv+k/3ChxNHilzJDcnveF1p/6I+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241579; c=relaxed/simple;
	bh=tr2yi8fD8cA/7sWYN0GT4iotnMhmZW0+98ia+qOU3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kz9fzDakDcSS9BgS7Dw5Vr4dwDxqoxY3HFSaa7HeUCFiPZjexhpJ255DP4q3ib3pcQPrCudsDnhz6Cvb9srgcu1ZSEJgefKKpC1EEaIZzNc74JSNwTeP+BVCLh6crTIKBUkkV7annlfKUElIgkwX3CP/Pr5Ce4VfPi3yHAPC5jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WyYlvrm9; arc=fail smtp.client-ip=40.107.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI6cs1lZPgMnZIZAufIv/msxgJ5fxU4G+5L86NhoChZb/RkbnspcOK9v5zN/rfBqY7LReg9UQQrSNV8KR3iaEsGvMM+rydkq189BDr0N68HHM+cHlla4CL3CoQckoPdyOOrCiyCKZnoY8IcdQPFnicA2TO2x5aQWxiPWi6fy33dOOHprzMfyxs7FEWfjwxmV+qm1TJ8yQYZWfJA6GO12H4gn/LnWn2HqNMcYN2ApQYhgGNO6w569qVNjAmj/7U6wWBjMB/1Be0qEuRlWIw9XVWCFkCeuk0wLBs87hOvHnUM8Hio8TVD2MMsXZA1ilABHPoPFuqlbkyTwca2lLgEOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so05RWGHx6nZKzhMgohDhffak1y8WvhHUx9SkwSI9pY=;
 b=NJ4/vgOAUCnfFZP/Qc8Z6dLLmeZGAjJrBcd5ZdCe4f5j0503nIYmUmc3TTwpSoQjDZfQoc3wSPkN6Pn2I7xqz4FJi8f05Y66IhUweQZngkbgZCGgD+s7+ksomZcC8kxR91exEIqTc93f+ZmP+UEE4ePsfOCcrUGcYtkySEMif5XaRkBT3eEjXNg0eFkIlRbavgJXtF5YCwvFIEnojIxQETcsnyJPo7XH5EMEBdBTV8ujWdBo3queUElplEYMcKyeWRAZUiAzhJXMibf95khBPLRl5Ey9KHGZ7zrvd53Zf4mSHdaoGWlBxvEN2oFGrjDEz9hcFQwb01AU9ByLKLtkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so05RWGHx6nZKzhMgohDhffak1y8WvhHUx9SkwSI9pY=;
 b=WyYlvrm9xmYfZnlTADKhN/CNzFkiHSgORwXw+eFNp2KP8H0Ec5mErlFwctOHqSoj2Bc+fnCSRY3RgCi2oxE4Uk1YqXdION617j7neRMSOuRnF1Di0eehEsDKJO1RMuy8mBVEu68kRqbNMrX1YHmOez14ooaJQQ067oOdzfWmL18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10225.eurprd04.prod.outlook.com (2603:10a6:102:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:06:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 15:06:14 +0000
Date: Mon, 24 Jun 2024 11:06:01 -0400
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
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <ZnmLWXvKWRApBwDd@lizhi-Precision-Tower-5810>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
 <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>
 <20240622041115.GB2922@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240622041115.GB2922@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: c8302fb5-768f-45df-34c5-08dc945f310e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3ZNVklnTFAzT0FONm1iQzBRMzhnK2MyVkMvN3VONWZRdmZ3OUpNZW1maUxZ?=
 =?utf-8?B?NVdhcjEvZlhFSnJ4YTlydkFVakF3cGY5eSt0WklPeUtBQ2RQcHl3V3hsT1NY?=
 =?utf-8?B?OEdJUGZ1ZXI0bmpQSmlnRHRrSSt4b0dMbW5SeGlVT2xnRi9EeFg0RVJIcVlz?=
 =?utf-8?B?L0JmZEpGVS9kT0pyeEJyQlNNNmQ4cHl6eitncWJGTG90QmRqWGVWdXFRalor?=
 =?utf-8?B?aVp0VG5pOXNGbFZmWFJZMFMrQ2s4b3Bva3VXb2ovVUNDNWhUMldXOEw0ZnNo?=
 =?utf-8?B?L1poYmlycVBqRnlPTVZnbERqa25tRWkxT0hMV0VuckE5OVl6cWtpZVJKa21z?=
 =?utf-8?B?TG1GVlM1YmtHVmFxQ3d2ekQrUHNvV3c3NUhRNUVkTWdxZ3hsNlNYWlFILzNx?=
 =?utf-8?B?K2J3MDRib3p3UnFoeWJRZjdBVjZ5dXNiQnNXQ08wL2ZucHo1dTk4Z1hCQXJS?=
 =?utf-8?B?T3UrL2tiMHN3R3EzNERRNkVlNERsV0NZV2dFcTNBZ2dhKzU4RTdXS2g4d0Ru?=
 =?utf-8?B?UnBUM01oNGtSVzU5Smx2M2lSOCtJVXRKb2FaelZpcFgyd0FYaEQzVzQ5UzVt?=
 =?utf-8?B?M0EvWk1EVk91N0V4SW9IM1gydUdZR1NsdDh0L3czQmhvQ2UrWm5nT2VYai9m?=
 =?utf-8?B?bWZJb3lWYlc2d3UvREhIeTZEZXhRd2VWY1YyZXdPQVlPREd4bjFlS0ZsS28x?=
 =?utf-8?B?ckVzZTI3VnIxc3VVMm4zTWtKV01vNFFIbDYySHZuek1LRDU0TVZtRlRMOXlT?=
 =?utf-8?B?Y0tpTmZsaHdTSENkM2RxbDFOdWo0WlBwMmV2dkgwRXdrbFcwc01LNW1kUGNw?=
 =?utf-8?B?WDRkWlFzZFhyVm50WUtweUc1V0RrcjQvVzdTTjBGMVB1NkNmM2FzNUpZUU15?=
 =?utf-8?B?OVBsVWx4MHF5cDZ3aTZwdlJsL3J2dnByQTMrbmt4Q1JqUHh6SFQ2S2xpMW5B?=
 =?utf-8?B?cHE1bHB1VGh4TEY2eEFYYktSeC9IbGg4N1hQVVlNOHZQaHF6d2kvZzRXcWRv?=
 =?utf-8?B?T2x4bVdNKzQ5TUQwTnMrK21BN2s3ZlVuS1BRaWpvOEw4SFRRd0lIbEx4LytN?=
 =?utf-8?B?dnVIcE8vUitDKzkvR1c1MkJoU2F2RWRLNk5GUGlsWW8wY1E5dHJlS1RWL3o1?=
 =?utf-8?B?OFM5S3RvRmVYTm95T0NpQmVaYS94MGJkeFVqcDVvYjExNGEvWHpIRjNSbVcv?=
 =?utf-8?B?OEU4V2tscVAwQmNiUlZ2bUZad2JCSmI2NGhhRC9LZk93U0lDa3I0a3JGdDJv?=
 =?utf-8?B?b0ZpaUNhaHhiWGpYeW5DN2wrdUVQek0wUHNNS0ZMUHF0eEsxUmVDa21RdWRy?=
 =?utf-8?B?Z1V1bGFwajJKZVVuTjQvenB1QmhSVUI5ZVZSL05pbC9rZlpKTGRSUTBFMDZF?=
 =?utf-8?B?Y1h4aTN1bS9sNWloenkrdUR5M0lDMzNaTks3MzlCYm92N2xWakxhSUZDb0s3?=
 =?utf-8?B?M0J4Y1ZuQ1doWW1ZMWZxMnlJb0dwbU5oWFgxTEdTcXJocDJJbk12aWQ1ZkNP?=
 =?utf-8?B?dmw3L0xPaXQzcTZRVTB3ZWpTREtxUzB0NHBuKzlhbEdkbFRXd3Y0cFpJK0Jx?=
 =?utf-8?B?VEQrVi9pbU9KVW1MZFRoTWxzbEhWTncyN2J5TUpRVEhLeGxmaVkxMFNFbXNy?=
 =?utf-8?B?dzhyZFJjZDBYLzd4NkU4TVhBWHM4YnB3VFhtcUl1eUNZUkdaVkRCWUE3RUtp?=
 =?utf-8?B?UUY5Z2NsMThVVmY0cGlZUkw5S3pBamRvdUw2UkRta3JFdU9kTDV3bkRVS0wr?=
 =?utf-8?Q?CDhoqj50HPS5yliAMNoNq2K/0aCuv7eM7PKn8On?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkhWU0MzaWVkZ3dQQnJuRnNqaWNWOWZIa05xMEl3NkovUXF2K29wMTVWOGxC?=
 =?utf-8?B?eHdEcThHVURXeERUTEEyTlZQNkljdTRUcWFXU0drdjZnNkN1ZUhkNTVCdGVW?=
 =?utf-8?B?ays3bHFYb0dBWmZjeGc4Rys4RzYzdkNIeDhBb3poNXJKamxQRzlzbzNWTktO?=
 =?utf-8?B?MTVabjV5QjhtL1J1SmpCZXRBaVJKdVh2MERLekdoQXF6bCttenBFK3dIMUVh?=
 =?utf-8?B?K1B6NFdlVjRvVEN5RXlWMjVPY3Z0bWVmbzNuc2YrQXVVM3liMkhXQko0eXpV?=
 =?utf-8?B?MmpnTmdlb1ZNWW5vME83dFVST0dkc2N0WFVXakhPd2thTXI4UWlBeTljTG1S?=
 =?utf-8?B?ZWcvQWhtZHBxVkZGSTZQRFZsN1NCNjc2VXVCN05rai95SEpQL21zLytZcXVW?=
 =?utf-8?B?R3A5djk1ZW01REFsNFVGUUhRWk1CdmJSWkIvWmpCRVgyNnlwOXlXK2tFSytN?=
 =?utf-8?B?MWhUbGF3Y0NUOWt6NjhtZ0pBUkxUdjF2Q3NUVzBVT0plM2Fwb1Q5TU4zQXpH?=
 =?utf-8?B?YTh1c3Q0eUk3SzhGckNybWtLcEVzN0pJZ3RmUUZDMytta2Jud2RBQTVOdlF6?=
 =?utf-8?B?WFl5WDdBUlczdDY5TFFIL0FXdTZTTUo4L0J0ODFUSUE1bWc2WFc5MzJLNzV3?=
 =?utf-8?B?RHhCZnVpUEkyVmR6M1lQdDJXZzdHai9EZ0g0emtpYVZ5bUhua1o5VjJGVXdJ?=
 =?utf-8?B?TGczUkFxRFpUcmc3NlpMMzR5TVJjRU0wL3VnKzEyRWNDcFo4Rkx3aDhTTncy?=
 =?utf-8?B?K2JLUmlTWE56S3FhcDhOVHI1bTZwVDUyaXBsTGk3V1VIU0FYVlRHallqL29q?=
 =?utf-8?B?QUZpemNhZjlvd0k4a1F5ZGU3Zm1tUnpURk1UN1pnelMwaWUwVUlzZTY2Vlk5?=
 =?utf-8?B?SGF4Rk50VFVRREIrNFpIdXBhZURqTWhiaXlBY3FVTFBRVTZWa2RsdjNoeTRv?=
 =?utf-8?B?QmRTNk5xODY1QlgzMEJmQUZBZkZyK1lSNk12ODdCZjI5Z2w3TjBnZEFYOVhG?=
 =?utf-8?B?aWp4VHN4R2hqWmtwaUVsRkJCYStEbXJvbG5RbWxCRzlCQk1WL21odWdiQTVh?=
 =?utf-8?B?QUdEc2RDYVowVWl0SmxURllRSElMbE5zV0N5UVQ5SGlzbVJReHNicTZXa2dz?=
 =?utf-8?B?MVZoTVhvRVUxWnA2UGk2dzNhZlFuY0RwbW1sV3R2MmZXZzhsTC9WaWdyeXRM?=
 =?utf-8?B?Y3ZnbWJwUEs0Tk1ObU9PVFE5c3ZqazFGa3F2dWRjWm5lK1ZEWXdGNkZIUllj?=
 =?utf-8?B?VEtKVmxxbWdFYVJ6UnRIcExDaVIvZkE4cHdaQzROajM4ZkU5VzBaUTVsdVRo?=
 =?utf-8?B?R05yTVhzY0VkODNtbTh5aktSby9zWlJiNThQeUpoazFuUkxmK1dHeTErZS81?=
 =?utf-8?B?V25jTHQxQjFTMmRUS1lFMzdyS2ZCcWcvYVlzZlRvTlBlWmpndENDaURhK0tR?=
 =?utf-8?B?S3drbGZLZjlWT05LM2N2OTJ1MzhHWHl6dVFtbzE2WmxkVlNxOVd3QXdyOTh6?=
 =?utf-8?B?Mm1vMUxVR09oVHVXZEhOTHVDZWxpMUc1RU04a3FPT1RYaFp3aVQwWlhIQ0d2?=
 =?utf-8?B?dndzUEFqWE5rY2lRb3pZVUNpZEZFcHdNSER6Z1hYWnJGOFJjVjFzUHczblIv?=
 =?utf-8?B?Qmdtemt0S3dvSWtQK2s3WUZXWXM4dFMwYjRkV1JOcjlSZDZYQ01tWktHWmRo?=
 =?utf-8?B?dlNrbCtRUWoyWGRJL1BDWDc2WWdTMWVEV3dqdWh4ZG9oUFpORzNNOVVNTHBL?=
 =?utf-8?B?Z2t4YjROblVSSzZDNkViTDhyVXBmc1NaNnBTN3hiVHI0VlRyalNscDR5ckVR?=
 =?utf-8?B?TFA3UVpzU21XTldLa1VxTWRvUStKU2RFdVhTb3NFNk0wSlhrWHE2YXlrVGxY?=
 =?utf-8?B?SzJmb0lIblRlV0pyQ3UyeWJDSUR5NGVsWHlXb1ZmQ3djVVVhQ1FEVnVQRE5Y?=
 =?utf-8?B?SmRKOHkweVF1M3M0SUw1UitvMURkR1hWTVJFNWJOY2NQWnZ0bDRaYUdDcXJS?=
 =?utf-8?B?VzJ2K2tpMnhTUlZZNlRqTWFJL0tQOEtKZ2dOWldQRXhhREV0ZHJmQVl6VUF1?=
 =?utf-8?B?YUNOaUJwcURvUWlZSUlqeS8vQy9QejR5WGwxcDdjSjZMck5tRXZheGcrbmpw?=
 =?utf-8?Q?VMEw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8302fb5-768f-45df-34c5-08dc945f310e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:06:14.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osehLvmWkgV8l46tYW54seRYKkkbdXXr0t3s7RqFO6FwCDLbVtVNtQ8/CAa5QQXoAK1i8usEW9apmO5DfWHbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225

On Sat, Jun 22, 2024 at 09:41:15AM +0530, Manivannan Sadhasivam wrote:
> On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> > 
> > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > controller. This function configures the correct LUT based on Device Tree
> > Settings (DTS).
> > 
> 
> Sorry for jumping the ship very late... But why can't you configure the LUT
> during probe() itself? Anyway, you are going to use the 'iommu-map' and
> 'msi-map' which are static info provided in DT. I don't see a necessity to do it
> during device addition time.
> 
> Qcom RC driver also uses a similar configuration in
> qcom_pcie_config_sid_1_9_0().

It is similar with my v3 version.
https://lore.kernel.org/imx/20240402-pci2_upstream-v3-8-803414bdb430@nxp.com/

Rob don't like parse these property by individial driver.
https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/#t

But if use standarnd of_map_xxx() API to get sid, it needs RID information,
which only get when new PCI device added.

SID problem may take more long time to discuss. Can you help review v6
version:

https://lore.kernel.org/imx/20240617-pci2_upstream-v6-0-e0821238f997@nxp.com/T/#t

I want make bug fixes and 8qxp support to be merged firstly.

Frank

> 
> - Mani
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 175 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 174 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 29309ad0e352b..8ecc00049e20b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -54,6 +54,22 @@
> >  #define IMX95_PE0_GEN_CTRL_3			0x1058
> >  #define IMX95_PCIE_LTSSM_EN			BIT(0)
> >  
> > +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> > +#define IMX95_PEO_LUT_RWA			BIT(16)
> > +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA1			0x100c
> > +#define IMX95_PE0_LUT_VLD			BIT(31)
> > +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> > +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA2			0x1010
> > +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> > +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> > +
> > +#define IMX95_SID_MASK				GENMASK(5, 0)
> > +#define IMX95_MAX_LUT				32
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >  
> >  enum imx_pcie_variants {
> > @@ -79,6 +95,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
> >  
> >  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -132,6 +149,8 @@ struct imx_pcie {
> >  	struct device		*pd_pcie_phy;
> >  	struct phy		*phy;
> >  	const struct imx_pcie_drvdata *drvdata;
> > +
> > +	struct mutex		lock;
> >  };
> >  
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -215,6 +234,66 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >  
> > +static int imx_pcie_config_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
> > +	int i;
> > +
> > +	if (sid >= 64) {
> > +		dev_err(dev, "Invalid SID for index %d\n", sid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +		if (data1 & IMX95_PE0_LUT_VLD)
> > +			continue;
> > +
> > +		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +		data1 |= IMX95_PE0_LUT_VLD;
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +		data2 = 0xffff;
> > +		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_err(dev, "All lut already used\n");
> > +	return -EINVAL;
> > +}
> > +
> > +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
> > +{
> > +	u32 data2 = 0;
> > +	int i;
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +		}
> > +	}
> > +}
> > +
> >  static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
> >  {
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> > @@ -1232,6 +1311,85 @@ static int imx_pcie_resume_noirq(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static bool imx_pcie_match_device(struct pci_bus *bus);
> > +
> > +static int imx_pcie_add_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> > +{
> > +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> > +	struct device *dev = imx_pcie->pci->dev;
> > +	int err;
> > +
> > +	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
> > +	if (err)
> > +		return err;
> > +
> > +	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
> > +	if (err)
> > +		return err;
> > +
> > +	if (sid_i != rid && sid_m != rid)
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/* if iommu-map is not existed then use msi-map's stream id*/
> > +	if (sid_i == rid)
> > +		sid_i = sid_m;
> > +
> > +	sid_i &= IMX95_SID_MASK;
> > +
> > +	if (sid_i != rid)
> > +		return imx_pcie_config_lut(imx_pcie, rid, sid_i);
> > +
> > +	/* Use dwc built-in MSI controller */
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_del_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> > +{
> > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > +}
> > +
> > +
> > +static int imx_pcie_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
> > +{
> > +	struct pci_host_bridge *host;
> > +	struct imx_pcie *imx_pcie;
> > +	struct pci_dev *pdev;
> > +	int err;
> > +
> > +	pdev = to_pci_dev(data);
> > +	host = pci_find_host_bridge(pdev->bus);
> > +
> > +	if (!imx_pcie_match_device(host->bus))
> > +		return NOTIFY_OK;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(host->sysdata));
> > +
> > +	if (!imx_check_flag(imx_pcie, IMX_PCIE_FLAG_MONITOR_DEV))
> > +		return NOTIFY_OK;
> > +
> > +	switch (action) {
> > +	case BUS_NOTIFY_ADD_DEVICE:
> > +		err = imx_pcie_add_device(imx_pcie, pdev);
> > +		if (err)
> > +			return notifier_from_errno(err);
> > +		break;
> > +	case BUS_NOTIFY_DEL_DEVICE:
> > +		imx_pcie_del_device(imx_pcie, pdev);
> > +		break;
> > +	default:
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block imx_pcie_nb = {
> > +	.notifier_call = imx_pcie_bus_notifier,
> > +};
> > +
> >  static const struct dev_pm_ops imx_pcie_pm_ops = {
> >  	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
> >  				  imx_pcie_resume_noirq)
> > @@ -1264,6 +1422,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	imx_pcie->pci = pci;
> >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> >  
> > +	mutex_init(&imx_pcie->lock);
> > +
> >  	/* Find the PHY if one is defined, only imx7d uses it */
> >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >  	if (np) {
> > @@ -1551,7 +1711,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX95] = {
> >  		.variant = IMX95,
> > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > +			 IMX_PCIE_FLAG_MONITOR_DEV,
> >  		.clk_names = imx8mq_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > @@ -1687,6 +1848,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
> >  
> >  static int __init imx_pcie_init(void)
> >  {
> > +	int ret;
> > +
> >  #ifdef CONFIG_ARM
> >  	struct device_node *np;
> >  
> > @@ -1705,7 +1868,17 @@ static int __init imx_pcie_init(void)
> >  	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> >  			"external abort on non-linefetch");
> >  #endif
> > +	ret = bus_register_notifier(&pci_bus_type, &imx_pcie_nb);
> > +	if (ret)
> > +		return ret;
> >  
> >  	return platform_driver_register(&imx_pcie_driver);
> >  }
> > +
> > +static void __exit imx_pcie_exit(void)
> > +{
> > +	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);
> > +}
> > +
> >  device_initcall(imx_pcie_init);
> > +__exitcall(imx_pcie_exit);
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

