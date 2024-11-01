Return-Path: <bpf+bounces-43791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25219B99D5
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568171F22780
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA51E7C11;
	Fri,  1 Nov 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="azwOSOB1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5841E2829;
	Fri,  1 Nov 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495116; cv=fail; b=mBbZGgipaSTSa1Kv9Ug7ojzu4rSQQ4ErianLGrPZCs9UPWoKE4FZSZv3g24AJT1d+YWYFqz6mOEwqajBWx2fU0WwwSVhKmUTuXnmTQHq/AnW5V19RfhtZOHK3CsBejYBdYLqWYMeZd0UZ2Gqpl85T12E6FL8Lmrz9TFa6HBpp9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495116; c=relaxed/simple;
	bh=H923IcuEQyzA+uPEcS1JQpTm0nIuQQUxCktmluZQinU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZXG1DF9LXq2cOCWxk5T0PMYyQheF24JGAQJqlTCvk55FLSMalJwJr1uHgvYewqYxUah0iQJjEFaKWVCQFfVFu7+QHHXIAfrahszBP8Bh1xZjmMov3R2fuC65Rji4tINlENC4jXf60d6yvVPMltysj96Ln4YgacK1vOQpsJ2WqMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=azwOSOB1; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFV1iEgUtWoA935gI3ADJ67yimkDu/mDwA3BmVy1zETw3e7LD1j4mIxszHXI28hij3UCnrdPSleR6MhetRmGyo6wj2XC7J05Rnf/TMXf4P6kpnkb7c6lnpWXUcq/2Nrmsvi1RarEmTArDT5XZ7I27Z866qnXRWcdxwVWIXDIzfQap03YgimsSMkXtIMD8hvw+e/cFCERri6JnJGJr7tZzKhRLxhinqabvmT+ifGpyy1lJJFQ55pKy2jqQRWNDlHRG4MmVHbqI6ACyWdZGm9EDWfJfS2ZNkfRhCPgAHYjsqfT3IqCRNMAOPt34Cm+iHelZ4Cax/XNcOW34ZsOaZf3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EWh9k/P12ZthR32RK14tFtWh5Qe4e/lMVaslXghNsg=;
 b=atbD1ytmVJKQuNb41KyYmi9SI/nV2Vt5zTaZizmDurcM1Jr9LlAeJgwmCns7ROS5EW+dGXaWpUZ7JYbGKhxKoar2+Z6TkGU57Ldhogy0ub7du+Hw5NaAOInTCu3UkECY7aB80r9v3fkcQNWoDG0HnprNsKWHBVvY+TEib3AoPWvGNtyeooF49ZvpMjPe4hnHBU0w+QXZ+9TaYHvdFdFXiHYRYYx3ojVriDA5Qi4GcOzt6XkSY9UTjbldAAqBZvzHV92tHF5CVDXdTOisGLL/YhB8ld7neZHDH+lyKsMD2XPjLdNTszAIoH5AUAUYknvpp4I328VLA56FlMpIySvtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EWh9k/P12ZthR32RK14tFtWh5Qe4e/lMVaslXghNsg=;
 b=azwOSOB1I3n/Uc4RoGJZFON9NUw/hL8RFCgTAUa7W4vylp2sR4tgL8hRx1Bcn2InmTy8kXNpv31+LCk3Iwr00JzFAVbW/bxY546lY0kXTPVKCY0Q9PT0R9gs/qpNUOZA2n1BE4kBRzefvU9BxIJ4CtpT9U0k3D5ubvhqlXmi+ic54iZhap4Kt7E4/eHTnwnG1THgdTiOtQvup4gSoldihXvirOVvOH2W1lRdktphn9HCZl31i6mQJYNFsbUmKwUTi28ifx7UOKhWrTyASociMLgm96W9DI0jrrJwmoN6gsVtRM+AxPyqLOfpS56hN3vWlP8Xg5S0Ns+cL3Rm8ZJ9PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10502.eurprd04.prod.outlook.com (2603:10a6:102:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 21:05:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:05:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 01 Nov 2024 17:04:40 -0400
Subject: [PATCH v4 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-imx95_lut-v4-2-0fdf9a2fe754@nxp.com>
References: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
In-Reply-To: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730495090; l=8217;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=H923IcuEQyzA+uPEcS1JQpTm0nIuQQUxCktmluZQinU=;
 b=VhHg1V9aDJY4/4HeIhOY1LLz+9EdLyfXH/tZZSFcvLks1BXQ5R22huumGE2Vm0ysDJFQClBfO
 hmGNUsOrh1IC2LCoJqkb2DRGrocVtrqFQfiV1ejjmYikiPlaNLecVNl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 046d74c5-dff2-4cef-a043-08dcfab8de10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmNLVHhaZEhmd2Q2OVM2bmlKUlN6aCtFNmdsTEtOR2xCL0pRcnpPRWkvMWVl?=
 =?utf-8?B?SXZtQ01zZGdkWmEva1oyV0NXeDN4MDhjRlhCMVBGMTA5NmljVjE4VEtPTWxC?=
 =?utf-8?B?aUNnOGJMT3R0aFAwYU5nZHdMZDhackRkTlNFK2VNbVo5OHVmRnhqZ2I4QTJm?=
 =?utf-8?B?UHJXTm9wMUhDK0R1d1k2OUpndlFuS2oyZ0J1cTBYNEhZbFgrWGcrTTdFdHFX?=
 =?utf-8?B?WUlkL2F1MWNST0pUeVJJczA0VWxLdUp6MkRNT0dWV29UazNIMTNoUG5pZ2dQ?=
 =?utf-8?B?VCtzQmVOMGFkdDFkcXlBdlAwNVhDTWlLb0sxUms4NVJpZ0lCcGdoM05aYncr?=
 =?utf-8?B?WnN1Y2pkSjh5SG9VYy9TQVYrWDFwOGh3NUxNaGhWSXA2SHp0R2dhUDQ0bWpP?=
 =?utf-8?B?Qi9pbUxUcDRjc3FVa29oZ3k2cjdLYlpacEZjd3UwbVVTdHBHcW82Vis1TERM?=
 =?utf-8?B?N1pFbmZDRUJrd0dJa1BxN3ROQTczTXFrRHVLWlFqK1BEeHRIaHdOTkJxOWtG?=
 =?utf-8?B?RWNSMEdSOEZaeGJFd29WZmNnTkRMd2h5VFRnWUFSMi91bFQ1VTVrOEtQb0I5?=
 =?utf-8?B?Y1p4eWpXNVcxZnc5bU9CK0tOS1VCUXRoT3NySTVDZ0I3MUhvQytVN2VaL3R2?=
 =?utf-8?B?cERLM2Y2UHpEaVY1SXZ5dGIvK3FFaTdGVHM2SmRUVlVQa0RaNGJnYTM4a2NU?=
 =?utf-8?B?bzBUV2lNaFBxRkZMdUhpTXQ5UzZDbTNpM0NNZDNVV0w4by9qTi9LVm45aGlU?=
 =?utf-8?B?UituMWNEY2hyUk5yNjhKNnp0UmdaRlVVd2YvNjNBQWk4V2g3a2VzMm1HNGdq?=
 =?utf-8?B?T3RMRlBGRms2a2lHYUFBckc1bkF4WUIzeE9rdW52UDNmMnpIOENTY2xUamxr?=
 =?utf-8?B?MjhNYTVCTStrdEVGY1pwUk9mWjFOVHZ2VUE1dDBTVFJVYVJVK2M0d2JhMEg2?=
 =?utf-8?B?RTJ1U25GN2dvT2NrdkJmem1Lc3k3dUhYSFVuL3VES3dQZ0cxYThsQmZWRTdX?=
 =?utf-8?B?YjVvdExGOTgzYlo3N2ZhbHRISDlVZ3AzaE56N1FCZ2xkaE81b1ZJb2o4WS9V?=
 =?utf-8?B?MXlmdFErbHgwMXRkY21CeVJaU0hHd2dVT2tvQno1MDBReE9tYml0VnRQdG5o?=
 =?utf-8?B?VTgrcXMwT0JLeTV3dW5GdHMxbTEvRE5CMzhjWUZoanBwcWRmWjRyZDRYQ29Y?=
 =?utf-8?B?Q0hBNStSbEdldEt6SFdkZkYwSGhETFpXT291SUtFMnk0TjdjSm9rY25FRUMz?=
 =?utf-8?B?WkhoWWdhM1o2NlRTM2xUZ1YyRHV5b2lGL1poSEs0L2V5SWRJbDlzOE9veTRE?=
 =?utf-8?B?RnQxYUtaZjNTMW94L3JpREJMM1gxTnhud1JVQ2lCQW5mNnphUnE0TkFLS1hP?=
 =?utf-8?B?Q01OaXBzUzQ3aWJzS09qSlFtUTRpbGxPQXdhTnFpazlvVUVNNUY0dkF6SnZM?=
 =?utf-8?B?UG5CTEYxMkVMNlRqSTRTc3RSWFQrQkg2WWZxbFlOUjltcy9nRG1GTW5tODFn?=
 =?utf-8?B?b3lWdkZFQ3JndWFlbXI2WUlaOG53VEdJT05SSUNLTng5T0xIaXBIT25Od1dk?=
 =?utf-8?B?VjdPNC9ENHRYUitGMC84aTFFRW5XdmcydjRKV0xLa1NNUTBQVnhkWGl4UHln?=
 =?utf-8?B?R3pReWR0alI2U0Z4aW5wQnRZZTg2cDRQMTVDZlV6N2k0M3FYeW1vUEVGZXJa?=
 =?utf-8?B?RWsxTlM2dk5UR2Q1aHFPeCs5NG5mcFJmR2FVdDhvbzA2WDhuUlJLS042M00w?=
 =?utf-8?B?UEl3VTdRSmFUQVd6em0zT3VqTDJVNEZmcmtDcHRPRWpiNE11cnZ4UjRVSGlO?=
 =?utf-8?B?TUFFU1BiT0NxblFEY3phZXArYnBrelkxTEliNldhVTM0eGRPcGpRNWhRODZ2?=
 =?utf-8?Q?xVdQ9NjLhM1rZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtxNVRNaVNVbTU3UndiKzZMRC9MVG5hVDVxWm5qMVp1czQvbnVDRVZzYmh3?=
 =?utf-8?B?RWZmTmpmckpTMEJUblVxdEg0allqL3VjU09nL3FqNFI4dmlrRis1QnpWc0FR?=
 =?utf-8?B?dkxDemJOeUNwSWE5TmRKb3QvTDlmYVpBalVDQ0F2R0NsUGJCNEdramROekZx?=
 =?utf-8?B?TGR1Ukdldi91NHlHbVhpT1lkN2FZQXJYVkRPTlZjbk4vT3lETzlwYlB2T1Vy?=
 =?utf-8?B?UElHclU4ZEl3QnIzd3h5c1Jya3phRHV2eUYrWW0zTXRUSFRWQytycmlYcW02?=
 =?utf-8?B?UmIya1NlVFZ1Ui9TK0V0M0gvNjhQTm9hQTl0T3FQNEhWU1V0VFdGcllqWlJQ?=
 =?utf-8?B?TFhxc1MrTGl1MUExOXlibFlIRmZ3empIbXR2RnhzOEc3M1JzdVhualdoK01w?=
 =?utf-8?B?cC9Fb0hobWxySmU1dktsMEl6WDNLVzZub0ZjNnpVc0xFMmd6Z2NkcXBnWDJy?=
 =?utf-8?B?eWh6Y1h6a29NNDNaOFhOL2wrc3FBTnQ0Zlg5T3R5OXN3SHRIbXZjS29ZdjV2?=
 =?utf-8?B?eGxVdldUSmFKd3pISDZ3d3lHSTUzUzl6ZSsvbnY5elQ4c29zcFJxZ1grYmZm?=
 =?utf-8?B?Vk9iOW1kbFAyRnl1dUZYUy8rTm5MR3dzdklyWmN3SEhjemh1SWRET3JjNHNY?=
 =?utf-8?B?KzR6U21PTVJNazd1eDN6Z3J4aFBBbkE0bUlHK0t0ekQ0bUgwQ0ZDVHRUellk?=
 =?utf-8?B?L1Rydm92V29Vd2dxVk9hdFBPcWZQWGhON0dLL21GdjdZN1hTY0QzNTJhZmZh?=
 =?utf-8?B?OWFvN1pmWVBvNW9TVCs1UXBtQVJlYjkyWHhESmE4M1Z2S0xFK3oycG03RUxl?=
 =?utf-8?B?aDhWQUVNbzU1emR4WnhVd0xkVVBueDNtR0VyZG11UHBpcnQ4aWVvUVJzekp5?=
 =?utf-8?B?QUFDSDZzcnJxaGFlUjdNQTBOVjBXVitKbWZmL1IrZFB4WXpDSklmR3FIZG9w?=
 =?utf-8?B?MHpFQmdaZG15S1ZEcTRaWGE1YnFRVzlMQWE0eEEyOXkzRTFxam9nWm9pU0N5?=
 =?utf-8?B?SHQ4eFpCd2psNVpnUEFHUzBrN1F6aHp2TWFVUzd4aTVsLzJhZWtTQW05Nmx4?=
 =?utf-8?B?TW9xeEJpT3VYdjhWRUdYTHBnNHhwc3BlWGZPY2wrU09wdHpKWlZ4RzE5aGt2?=
 =?utf-8?B?b3I2cWlMQkdWQ3J2U1R2Z2NvdlUzZmMwVTRRRzc0Y0VWbWRDVjdYUHJPNXVX?=
 =?utf-8?B?NVBkRE5ucE5ZS1lXZjRwbWVXMnlCOFdBN1MzYUFSZEsxVlJnc1UrZFdTc1Zu?=
 =?utf-8?B?Sldqb25pVmxCNkRKa2dZQjR3Nys4TWttK0VJNEZ1Nk02YVdNa0V2L3FFcEN4?=
 =?utf-8?B?NW5RYk1sejJHN2F4cDVpNzRHV2xmazZ0ZmF2NWJwd3E5WURJSWJHMVp6aGdM?=
 =?utf-8?B?M2RNUUlBL09tZmlTbFVQWm82YXdFZUhURkpEbjZVK2JHV3FTQXIzcGNpNW1o?=
 =?utf-8?B?ZUZwdWpod3BodHVLR2oxTUdwVkZockxyUDFXV084cHNCRWFqb2QyS3pRM1Zy?=
 =?utf-8?B?cE14bjFaUm5KWnZGdFBLVmFldWd4NXM3RktGV3ViRjhlUVc1N0w0a20zbk5p?=
 =?utf-8?B?NzI1R3h6L1krbGEwOW1BdjlkenJTdDZjeWNoMy8wTFRjR0psY0haNDcrcE5U?=
 =?utf-8?B?M1pnV1JWbVB1Y0x0QWo5QmVUeVVzbm5tS0VXWUVRaDQwRTNFclo0VFFHeEJy?=
 =?utf-8?B?QkFVM1pvZHFiMkpHdE1venFSZHVYOHNSOGwyK1FPbkgxVnZ4Mi9sWEFNU0RD?=
 =?utf-8?B?eXJ1eDBjWEJRdDFQNzFZdmlnRGdmMkFpM3dValBjL0I4SFBjUERtTFVCWnh6?=
 =?utf-8?B?MHI5bEhtYzlPWE5reXhoeUdnMUtVclBhUGsxbXkxTXhpcU5rV2lpc0tmY0My?=
 =?utf-8?B?VFdhUTF5QklrYkxoLzU0bmFrenlSaGhZQ3VMOVl3TEhMR3dyeHc5OWhhUEs3?=
 =?utf-8?B?M0hDc0NybHo2NS85QjhPMXViZTdQb0xPSS8yb1RobWhOQzRBNm5Ud01aSnZH?=
 =?utf-8?B?MVVLOGZiZHBIdWFBemgrYVFHbGx1eSt5YXQwM2Q0LzBuVytVRTlpMHNiRzNt?=
 =?utf-8?B?NnhpV3k0RytsNUlhQWpOSzZGOEJxa3huRnU0TXMrRnVEMGxtZWwxNTR6VzVv?=
 =?utf-8?Q?kW74=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046d74c5-dff2-4cef-a043-08dcfab8de10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:05:08.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlT5jYTeV9wNh7HYtxZ/nlVedKSn8gVaW9HWKNkgex/IjGqC2QMmKBli8wuPbxZurbbaqznYbNl/lM5+gc0AdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10502

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Additionally, register a PCI bus callback function enable_device() and
disable_device() to config LUT when enable a new PCI device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/pci/controller/dwc/pci-imx6.c | 177 +++++++++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..1be17bc39ce54 100644
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
 
@@ -134,6 +151,7 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -925,6 +943,155 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
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
+		if (!(data1 & IMX95_PE0_LUT_VLD))
+			continue;
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+
+		/* Needn't add duplicated Request ID */
+		if (reqid == FIELD_GET(IMX95_PE0_LUT_REQID, data2))
+			return 0;
+	}
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		if (data1 & IMX95_PE0_LUT_VLD)
+			continue;
+
+		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+		data1 |= IMX95_PE0_LUT_VLD;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+		data2 = 0xffff;
+		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+		return 0;
+	}
+
+	dev_err(dev, "All lut already used\n");
+	return -EINVAL;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
+{
+	u32 data2 = 0;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
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
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct device_node *target;
+	struct imx_pcie *imx_pcie;
+	struct device *dev;
+	int err_i, err_m;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
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
+	 * Return failure if msi-map exist and no entry for rid because dwc common
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
+		of_node_put(target); /* Find entry for rid in msi-map */
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
+			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
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
+		/* Hardware auto add 2 bit controller id ahead of stream ID */
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
@@ -941,6 +1108,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1464,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1761,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


