Return-Path: <bpf+bounces-27554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AFF8AE95E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D11F24A2E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E526139D1B;
	Tue, 23 Apr 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tyt26JRB"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAF135414;
	Tue, 23 Apr 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882252; cv=fail; b=H+iBOlpC6z92CUpeAjDY4s0AvE4eaGGMJ4VI/EHMhmj1d7caATb7OeGPvdvUugxn+FFpnrsurcZtHezdaMUQEk2sXtzPOZa+XHDG4Se5PwUPHdLvwEFMecwoqMrtXjg6YDaBjtR7mEdIy1WNMX2Y5qTizd9zWwdHnOKyeZ7Qoc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882252; c=relaxed/simple;
	bh=aGTCHanwi7v1ZY2J9Z/cJUKW9hhllbyWBbgCQ+jEUXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKepgW5+X+nqdmcZEDgdRD7LwRCIeRK53CICevCiQ5mNEFR10a+aBu2eQHf3QvwIVwdJ8tdlq3UoZHBFT9in9aovmK7xuQSukBmYYnlCWXA4PC92BHkyTGcSp4Xm94D/skYM2Eii1CSI80Ijr5/E3zsBEczEWkc+XP+B5DoDz14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tyt26JRB; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j30mJhd5p/H4iuWNNjLdFijVlTNo2G0TYo1Q/V3MJ9DcY4omjAVzTZavNIu6vg4OK1ou/of8PAQZZJ5yJLWGyc6U3Ses4PZhkgS1tflV2x407a6wmjze9LcIwm2hYPiUxQlnhT6GThQ8VMjM1GSnvKtQbwx53JAJGj1L+DSTBcbGVeyMD9ZqeCpKUxH72Br30ek2akmSho8dMO3+OfNMd9qnVS6ppqeNVqHoZqAoVpRWpObWf3lYMXQhRfYlYvERxMI5s11Vl6dVRJQbNnyNOAgmzd9lOs8HFylrJCw6CC3IVZMkW0EqQyvCTpgYWOuaTvp926QSpF5WT9LN14E8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjXs8kk8Wi/BhjF1T5NKm5EgDHB8gMAnNp6RwSMwp4k=;
 b=IEemni+t2WT3l8lVlMrtcjOmGwS39gBH7wEnsuiaPuQyEa1B4PNX1I4k2zSFEwbYk2ucGug5kVJwHNtxQ1+4DpBCtElbC00ST5mt/jWP11nM4/vac2oz638dClRHSRKtLcG+cue7/4nzlwl3Oqsxhf5aVZqK6c7balfT93vui7bhKrMJNk98TL7cXnq10VfVCQSNMSesF9K4Sm1UFZ4/NYaJ1TURrbqq1HA7Q8WjdDzEGW2XydxHIsYplSfljltfZl2+iFDR4GBwl+IxokToRvMbjH3KKJNSGY5Nz2IVJP1mpvG3jcjsauQlogym+f4n64QoR0q6yUmClj+R+v5nDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjXs8kk8Wi/BhjF1T5NKm5EgDHB8gMAnNp6RwSMwp4k=;
 b=Tyt26JRBE6G4h+euc2DGDyxTRdaqg6SzJgV7C0YEt/5JOSWJ3juU9MlAJf7jWCMMEuHSjvhNbB+rY3mH9O4KVFxbBTzt6QWdPKUmHfuR/Sf+6qPquj53bFNZmWZXRuYBs/2Al4SbStCbB1Gmvaf1BezMG9k/9TXNsCcViOD/9Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:24:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:24:07 +0000
Date: Tue, 23 Apr 2024 10:23:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZifEfKrWKFJ1dFkM@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3055881a-0155-4c4b-7e0e-08dc63a108c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDRwV0dDQzRhWC92aHlqTXZNZmxycXQ2dnVINzY2TEdvYjRMYzBsOWk1Tm9Y?=
 =?utf-8?B?RlRpR21mdzBCVmNsYnB5K1hlWnhISkp0R3BiOVdpbkhsbG82eWdKWXRXbUpT?=
 =?utf-8?B?NUVrSlR6VDRKbW1wT2xja2RPeVdpdkNXdzhQVWFsMWlDb0VBazgxa3NNdEds?=
 =?utf-8?B?YjgyN0pKTS82SEg1SUo1c0tGd3lINE1lUG9zeVFSSTg0U2QwQ3I4QmxqVEVq?=
 =?utf-8?B?SzlYOTh6VDBvV0dYY2Z3NDB4aENkdlRYVmlua2xvc2hjc0lqcmJQaFY2Y05s?=
 =?utf-8?B?YnZ1bCt1L2trYkQzQ2VYcFZGK1BXT3d2V0t5aGhQL0lIUDRadnRhM3NKTWtO?=
 =?utf-8?B?MnhkK1lSSVVZT01LZmZkMDJaZm9SQ0VQRjM5UGtRMGVjSFBWbFNoV0RmY09k?=
 =?utf-8?B?ZlhnSEFaNURpL1Z1cXNsOHdvaVN6TVZoZ1lnQWFqMGNabk43eksxQXUyRUlk?=
 =?utf-8?B?clhsQlJvZFF3b2w2Tk5hTFdxVzdJbkxKM05uU2U3OWJkdGhicGhoTmhmQzds?=
 =?utf-8?B?c09NL0VnNVVORjBERC9MYzNmM0N5dTd1NkZiczBDRncydE5ERW9ERXpPMXNL?=
 =?utf-8?B?TDl5UStndERRQ0VPWDFZMFY2TERXbW5QNnFIQ0psTmtBLzRxN0o4M0NCcHpz?=
 =?utf-8?B?MFR0VERyTSt4ZEFXVzdDNExFMkh0RDZMdm81eEo5OStPcC9zeE1JRWxselUr?=
 =?utf-8?B?REVxRE40bGVBdXJqTWdRTnZscm1qVjJmeGZSY3YyZEd1MlFTV0hCM24xQmph?=
 =?utf-8?B?OERLOHcwYXk5RzdKR25aS04wWWVja0h2YURWNzRuaFVXRHFjd3MrVFphcjhP?=
 =?utf-8?B?SHdJS0JIdURFdDZOSnFEVXlzaWNoUTh6VjBmcVoyaDVTb3E2ckRsM1dDVWNL?=
 =?utf-8?B?bXpMakVoK2dsMFVjTXRwUEVzaE55YXY4Mmk1eDlpODdzTmF4djJxR1c1ZGVV?=
 =?utf-8?B?Z1cxV0Y0aTZaTzFkU000NU5TdTYxTHM2eEo3N3EwblJuZUdOSmZoeEFYamY3?=
 =?utf-8?B?V1lycUlRL2xWeFpGVmt6WW40ZC9XREQrYURDelZOcFBWMGhwSWdmY2QycStK?=
 =?utf-8?B?VytTY2dvK1Q3bGpRcFZ6YjdmTUdCWEM3alUzWTlYeWRDRkV6MVF6cmg2SmEx?=
 =?utf-8?B?emVvSmhieGFYaGJIbll1NkJMTlhWdkdEQm9nbU1XSlhxYWJHK3ZXd1RaVTgz?=
 =?utf-8?B?NC96S3B0blM1cnJweWhrbjB0UEVNOWtPNC94bXZ1R0t4YWVWWHI5ZGE5a1dB?=
 =?utf-8?B?SVRuRS81a0pMZk1LdzNaQVhzNHRKYVc5SU9vMWFLRmkrTkliTUpvMW8wazgy?=
 =?utf-8?B?TmlkbVhNQ1V6d0JPYnl1d3FpM2QxZ2FJVVZNOGNkSFNOTjZ0eDB5elJkVFRP?=
 =?utf-8?B?b1lvMFZDS0lPeTZ2Y3Z3b0dKL3FCSUtEVkc0SXo2UTdad05CdHp1ZUJZMWtJ?=
 =?utf-8?B?aDllcVRWRURpVzNTUmV2bUUzc2pYTDBoWDFDZWV4Q29jK0hzWHVuWGlaMW9j?=
 =?utf-8?B?UEE1Vys4ZTRCUW0zMDFRMFZGTHNiS2w0bkxMck1hOGhqcUxGZDRTTVVPZDQv?=
 =?utf-8?B?RngwRXF2dmw3SGFrWkxDR2pSMzdJR0JLS01UUkxaa0hZYXgwRFJ5MVJqYld2?=
 =?utf-8?B?THl5emVkWTBUMllDQUczcE4yelBtRXdkWlUycmduTUVlN29sWEY1WE9Cb0ZN?=
 =?utf-8?B?bGl2eXg2dnlTY29BYlJZeFppeE9YRnhDVWZEeUYzTDl4cVo3TDJrbTk0NVA5?=
 =?utf-8?Q?ZfkjqWurE6F8wS31B8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVpJOHZ1bm0yQ2I2Q2w5NFl2MGNGWkVDSm00MFg5VWhnaklGUUZkMXBsMlU1?=
 =?utf-8?B?ZWhWZkNwY3pmMGdZNmFpV2t1ektlcnhlbDM3UUhIdXJDRmptZG9BUjc2QWNF?=
 =?utf-8?B?YmJqMUdNaFovOTlsM2EvRm8xb2JBVUlEMlNUYW15OGJzYjBYeWdPZmtmek9n?=
 =?utf-8?B?R0U0TU5vTER2T0JhdDFieEIvcnpPdnNpMUFjVHl1bVY5NEZDdkpDbTdjOGZU?=
 =?utf-8?B?dE1TL0ZaM0hYYXJlNHNCa3VqMVVCWi9HYUZmQS8rUk9YMDFQTkNDcjRLOHBm?=
 =?utf-8?B?Z0xhRDdSOFdzbUFYU0JEblh1bWVDZjhIUWJvVkNTSjRKNzBGWWZnbnRyTWhi?=
 =?utf-8?B?TXV6by9qWHVSZGFEQUtoWHNkTSt3WHh6Qzd3UHZDdE5ieTlORFBEd1Q1UlhW?=
 =?utf-8?B?cmkrQTRaRXozUGZWemV6Z25NcElrVFYrcGoyLytoU0RTTm53OTVndFlPWXds?=
 =?utf-8?B?aFpuWExkbTM3R2tzOEoyRzJQdk9xRTNyeTc5K1d4SzBQWU9lZUVlN2pydUVH?=
 =?utf-8?B?dTZnTE5mK1BNLzQ1ajQxNWZ2dE1BWVIyc21YVmNGb3Z1ZTIyUDFWOGNjdnFm?=
 =?utf-8?B?UndlNDZUNm8za2p0MEtpS21LMWVSNFVwMk82MDhuTVVsL09mS2hvSnpuVTd4?=
 =?utf-8?B?NCtyQ29zNG5zb01Uc1llWEF1RjFEU3VydElKek9JKzUzQmVYMU1WVHVUVTdE?=
 =?utf-8?B?MGlGbW1BbU9GQkJrSWE5UE52Q2NYQTlqQW9TcWZMbWNXOFZNb2hzQ05PanZz?=
 =?utf-8?B?YjE4dmN6Y2E3cFZwM0JTRFovTndvcGNmdDdzM2pEakdQblJGM0NxUXQ3bEZH?=
 =?utf-8?B?QTFVSGdObVRIRGtnSTdmYnhpSUFwNjc3dTBwOVI0TkhUL2pPYVRzODZLZlor?=
 =?utf-8?B?Q3VYMDFCSUNXMU9Zd01pTC9ZTkZPbWpIbXJKZnIzLzgzVE9DOWNIbEx4UE1C?=
 =?utf-8?B?WVpkbklrbmlqTjVmVjd4dVVXZjlRUWdRSEJpTEJ0bmQvdDRUejZSSVBsOFRp?=
 =?utf-8?B?Mk9pR21PL29xZW9XTnpMbkhLdUZBYnRTdEV5ZDZRWisvMG4xcklrd0FCMG9r?=
 =?utf-8?B?MW1LSU5XaFR5akQ2QlV0TUViWlNsanpoZGUxNmhYQXdFN1VSU09FT0RFdHgz?=
 =?utf-8?B?ZnJoUEVMV0xjN0hZNGtqbWh3UER1RjQ3RFk5UmsybDRCR1BJQXZHejgrZXpC?=
 =?utf-8?B?Z3JwL21ZNEhUYkpYYno5KzF4dVN1WlJoK1V2eVBVS3ZzaWNvNXRQVXY0Nk9K?=
 =?utf-8?B?MEVsNlRqMVRLUFVhRXUxdDlkSDQzUnJsb053Zi85RTZBWnBubGFQSlNiQldK?=
 =?utf-8?B?Vy9Qdzk0N3lwcC8rQkVQSzUzQ2RFN1JvMnY1Z0Npa3pneGprQXNRTS9DSkRz?=
 =?utf-8?B?ekJaQ0p6SGNBeTUvTUhhWFRCOG5yNFRnUVhtUmlneFVEYlJQRTV3K3BtTkZq?=
 =?utf-8?B?ckJjMC8zYXpUcjQ3N01Ha0poSmY0Y00wK21VYjJoU2xFVVhJOTlFUU9ua3hu?=
 =?utf-8?B?M3dhZHVDbnZDdm0rWEIxOU44Y2NOUldPV2FwN2ZSckhPSUpzdDYwZW96NFd6?=
 =?utf-8?B?bm12eERvUW05S2JUTzlFNFN1Smdtc21EZ3NTOFlYdDBmWU1uU1dndzhyOE5v?=
 =?utf-8?B?QlY2cEpPVEVEWW13YS9WR1M0M0FIZm9ReEhvMEpmWTdreUNFTWxyQVdablhT?=
 =?utf-8?B?ZEZxcVBjS1hLdTlKZGpUc0ZOVGpzdm1DNmVtNk9qMVRlQWpoTUVLcHlRS3lF?=
 =?utf-8?B?SG9sS3dWRDZxYVpwUDNBSE1xOU9qUHBnMzhWZUJrQTlmcUtxeGM3MitmVEFD?=
 =?utf-8?B?K3c0MC8xd21nbHpIa2pwcFJqck9tRG9xc0xxYmZPMm9ZTzdNNGEwU0M3ZVJo?=
 =?utf-8?B?YW9wcnlXRy9mRlZtUTJJejJOWWlEdUYwN3pOR3BJUEhuOHZNakhIVEJKcnd5?=
 =?utf-8?B?aEtNZ0g5YmR2Nm5MYzRSd0VUNGpZWkFVSVpwMTJwejRNUVpnKzRZRm9xblFR?=
 =?utf-8?B?TlpoMkprUEhUN1cycjBub3loVTVmSTBsODV5WWxKUjVFVDJhdTE0VTJlV082?=
 =?utf-8?B?QytjMFdJTEVWOG9pSFpRczdDMkhYczNkeE1UOFBnUGpkdUxBYVlQQUJHZW1H?=
 =?utf-8?Q?OH9FjHj87RRLr8T9wnR1KMGdL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3055881a-0155-4c4b-7e0e-08dc63a108c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:24:06.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPnN/JlAEswN6BkA/hyS5iVHepDF6C0gkZNKKp/l5hHFkrxnGuCeHyjtgibT7Hf3ElWDDqnyLB0AD9yXz2uwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

On Tue, Apr 02, 2024 at 10:33:36AM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                
> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            

Mani and lorenzo:

Do you have chance to review these patches?

Frank

> 
> Base on linux-pci/controller/imx
> 
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Changes in v3:
> - Add an EP fixed patch
>   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> - Add 8qxp rc support
> dt-bing yaml pass binding check
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> 
> - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> 
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> 
> ---
> Frank Li (7):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Rename pci-imx6.c to pcie-imx.c
>       MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
>       PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
>       PCI: imx: Simplify switch-case logic by involve core_reset callback
>       PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
>       PCI: imx: Consolidate redundant if-checks
> 
> Richard Zhu (4):
>       PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>       PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe support
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml        |    5 +
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   18 +
>  MAINTAINERS                                        |    4 +-
>  drivers/pci/controller/dwc/Makefile                |    2 +-
>  .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1173 ++++++++++++--------
>  5 files changed, 727 insertions(+), 475 deletions(-)
> ---
> base-commit: 2e45e73eebd43365cb585c49b3a671dcfae6b5b5
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

