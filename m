Return-Path: <bpf+bounces-43114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89B9AF57C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B61F21C8A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42021949A;
	Thu, 24 Oct 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhKjr2Vb"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF7219492;
	Thu, 24 Oct 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809318; cv=fail; b=j9YA2vZqgldhxaGXEUNeZtc+GHkP5ZICX/VXmvPKgyU6TJfWLhwq+LjCrHtTNURLIHdaLVjh9+8UXy5HQRXHLvs+TbnBPkaE8mGXaaRudUbEtjRIe21J5OGA2IJ9KevpDc5NtLG8S58/UMpLFenb1QPxebsEBg7hwKPX/yHk/AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809318; c=relaxed/simple;
	bh=++Ra5UUPQByKYlOdODjlqMpR2reTqaPcz/EXBHMKqmo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TGItrHVedDyuMhw6dO+ZentrkcA2oHyEwNEmtLVvuNJsdftCExQtt9V968OENF9seKXxy5n/QZ6A/6j6Tvym1+crdMa1ZVCaHBdnBMEu+A965oXaqCNr9klCGu6l+p7nbU6L3+oV6gOLuDWAjmdUD5dubeY30lrHKjMpQf/erug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NhKjr2Vb; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VD6hsDcwD+8N1eNnQGc0xuT5JeiIkOCK5unUsTWaLYTBJPn9Lix2nrcbE1+Bt8v/aSENZl94JrUGFpQPJ57UB465MAp4mtkajPauxbZQ5xpGdq/9bc+wU3F3iSrm/8nYtgrUlnGj2PtOlkum9he64azqvvoIkKtFZFfxZP8Ev3mpZNPDIlM2KOTroFIbAy4wHXI73ZzgQMUVC8lgFfKkFdtu8SWHkxai2JBGp/0ZLTBROtfKau43wjqFP4SK0YOIhCho4SwR18FjbUbF0PC5bDXL3kAmL0McORKSXFF5/PcljOU5vilmQxZfU+ieZP0Evx+CcUJAyTBaSu9/L06H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw1r65JSYmrG2SKNClARjtA2eh894aOhfoVKCDGVrxg=;
 b=UkG8FfIDiB6afFbdjoHcJgn/fUH/pC7ei/WCsFcGAH+hx0Oh0E4iZMwyn7Kz+aePwEEPnkJtja4tffg2zXdG+jUrWD3UWbHCJ884weP/Jc31YhS0JwweZEUm7tlT+2RlETNtjS51F66fWlYFJ03qIRVfKIBgWjs2WCzRGUPmdGkCD7hXTyr9V2siSLpUX/3IgTFeGvCn5/gzTKmdgZKn3+F7WDvrGQfOEDF4wf4uOOa5ueu7UWmsnMIM4EyANgnjXV9XLeFX6VRbq3UTLI+xtoN4P95nSTgLxagvbONOuNert4/zpAEIDW8PWJFUHiDBhd4gYXUTeZaReH5q2x9h1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw1r65JSYmrG2SKNClARjtA2eh894aOhfoVKCDGVrxg=;
 b=NhKjr2Vb1Py968TsDzn3cjpJADr/URphKDe01L9NEgjuEHNPq9h1nawV3CUYz56ien/ScFYVVJMALpvnN56WzbyhRadcHgHGOOV1NqxJCIWQrCkUtHLPig0pab7WPrSECSZmAcD4mQR5rXB9VrKnW1TGTOmnvPrNtW08s4N3Od/kAH0Jd1Kszb+vAnX+yWSKqSkjrsnsaLnsntREFyfAkjmbcfUJPs3g4YuTt7wwy7hsSNloFMFWnh6AZEEkx30PAqAjVkPlYbiHLxIwVjI+HrHWIOKCm2tQp5+Y1ybwwApUdn7GRkMnvn6pm2ESzMeMBhcx7t2nAcrGeAh8wa3N4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 22:35:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 22:35:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 24 Oct 2024 18:34:45 -0400
Subject: [PATCH v3 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
In-Reply-To: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729809293; l=7490;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=++Ra5UUPQByKYlOdODjlqMpR2reTqaPcz/EXBHMKqmo=;
 b=Xnj1jOlE/HzeXRsQUoFRSJNlKXL//4xmQphSrwpQd7/t83Iv82dDXfA3EJ+n3bgH9AZkSGDGs
 ix+4FTCLsaTBF5t6H41A/uqaNdROkSdnZAW++8S9SExrUt5gy6ba13P
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cb1f34-51cd-48a5-ea34-08dcf47c1f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVwdzFUa1hHYWJablAxd0Z6MnVwcUt5QnhiMDl6VzZHTlpBNVcrZ0tkb0NH?=
 =?utf-8?B?OVZsOVk3WUc1WGdKL29XckNlL0FxOTFVaU1DTHZ0RThaa0JPeXJBUmwyLytN?=
 =?utf-8?B?RXpoQlh0c3lRdGxXTWVCR0pDMEV3YUZ1RTcyZ042cDJtS3BQdGp1eWx4akJV?=
 =?utf-8?B?TzF5QmJBYlB2bHJSMS9UV0JsRi9zT21NQlFFMVFxUWRBeHQ3Z1VRK2tsODJz?=
 =?utf-8?B?enZvWW9PWWJZTnozdnFrQkdDeWhZSy9uOUxlRldPSGgwbm9SeU00YmptV3VQ?=
 =?utf-8?B?aWE4S1ArSE8zRDhKSGhJaG1XZzBsMHBXbW5Pcm5aa2tTUzRnZEhsN0JZN1BB?=
 =?utf-8?B?UDBNd2pGSVJ4OVJnMXpsajRqQlRlZExadzZqZGtmbjl4bkVIU3AzOExha0xk?=
 =?utf-8?B?Nml5M3FUU0Vxd1VCOUNua0hsTzRrMEc4dEpVbTU4V2puWmdkclpwRHZSV2Rw?=
 =?utf-8?B?YTg3UWpJOXZ1VTYzL01IN2ttMVFQM2pjcXJNUzRmenVKMmJqdU9tUmtwSXpQ?=
 =?utf-8?B?dHVFeEM4WlBIRjIyRWhYVlYyQ2FxZEtJUnhzNVNCS3VBaGxpV1pTRzdxampI?=
 =?utf-8?B?c2VmMTZQUDBDVmNCSXl6blYzY3BXVm5yWFJJVFVtd3ZZU0ZBSUszVUZsZGt5?=
 =?utf-8?B?ZWZ5UTRXbmthNVNFWjdLMHRsMXdIS1l6VWUzckM1QlljZVZVd1NNRUlDalNQ?=
 =?utf-8?B?eUlUcWptT2hON0g2c0pKZ0x2TmNzZW9hVFEzWDBHTDJ3azJMd2tkZTlZcWU1?=
 =?utf-8?B?MFZxOEw4cjFnbUMyejAzQnRROWpHaUkzc0NZZTEwK3MyVndXUUMrclNhWmZJ?=
 =?utf-8?B?enBPZGt4TWJxMkxEZ1dnZTlua28wOTlOQ1VrMGZFS2RCcnErVmk4Z1FWQ0FN?=
 =?utf-8?B?NDQ3dWN4ekFtenlGd3VvdTJORjlNMXNvN0ViNjd6Z2RCWU1ydmR4a082cE41?=
 =?utf-8?B?T2toQkJBei9EK1FmZGVJZlNnZHgwVHB1SDdnUE9RWjZncEFla0RiTXdYdUFY?=
 =?utf-8?B?c2RXVVdOR1hGT1N4YjRvUitoQU9BVWhNQS9sQ2ZNVkw3TWpRZkpHWVhEbE52?=
 =?utf-8?B?VEp2RjhsalF6RDZWMFJIbkJpUkFIc0QvanVGM3VtRWJHbVVSZ01xSjdaWmk4?=
 =?utf-8?B?d1REK3l6U1NjYmpGSlZPNVVUNU1LQXl2elY4blZTRnRtaEh0d0ZML3RKbUda?=
 =?utf-8?B?SEJNR1RmRUYxY2IreGx6Y3RNZWpYSW5wRUNxeGllVWlDWExRNFpmblFMV2RR?=
 =?utf-8?B?S0g0S2NFKzJ0RkxFT3NNZG1lRUkxY0R2SmhiT1VEUFMwN2NiNFNUaG9VZUVV?=
 =?utf-8?B?K1QxVENaL0U5Wjk5Ujhmckt4N2twZG1VVXVRZU1oSUJnZkF1VHBIZXNCbkli?=
 =?utf-8?B?YVBZQTdSL2ZZcTNPQ09UWElaL1Z1WnJBMGI0SUFHRzlHbVVFMkI5SWlqWXBF?=
 =?utf-8?B?aGk5M3JKd01oNVhsMHhHenNJZlZicFBLWDZBNHRnU1pZK3BrQlNLaGtMTEh6?=
 =?utf-8?B?UDV2WGM5bnkzdGY3OHVMSWlsd1dXYndHUThoWjJvUkczQmQ0dlR2ckVOeFE1?=
 =?utf-8?B?UEpKa1hqWGVtQlBRNFJub1FkSjNQQmxwdU44dXB3VFZxM2FHd3lJRGRZdEJZ?=
 =?utf-8?B?YzZsRHRDRkY1S043Ty8rV1RkeTAzeEFrTC9SdlBvWGZsL2JWbk5EWURzNlZP?=
 =?utf-8?B?a2FGdnJ6S3VORFBoeUlJZjFtdlNXdHZzUXJaQWVtWGdkVWFWQkNHK21oQ0dQ?=
 =?utf-8?B?eW9FWnlLaWtaeEVCeUFzMndZVTIxWXJnQ3FEdWVlaG5MUVBrb2FjUWhxc2U0?=
 =?utf-8?B?bEsvRmFLbXg0elIzVzlYdVhLRWhzSXYxY1hQV3F0TWc5MWFXbmtsUnArOWU1?=
 =?utf-8?Q?mAbw/Z0pRmTVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGI1cUlEeHpYU0tabGVrRDlQN0F3a1M3ZGUyNlZVV3ZzM0dXTk1SbFljbW15?=
 =?utf-8?B?OVhCOUJIcGdoUk9YRlNxL1BBekJpZnFmbXFhSnZEMGVVcjdpd09KN1RaWEhG?=
 =?utf-8?B?WkwyMXg0cHdocklIZlVYRHA3c2ttRkI3UkcxdDhLVi9BZzFmVUtjdGFZSHBO?=
 =?utf-8?B?VUFpU3VKTTlBam5pN053NlFiKy9zMTJBMFM4aDE2L0t2dkg4MnF5QW0yWXVs?=
 =?utf-8?B?MzlXRDBPdDB3bjB6eVNmdE5nVk1lVUprQk1DL1UvZG9XeEhhcVBOYWE4d1or?=
 =?utf-8?B?YWhBWHdKNEpUTm5uc05KK0VCbk95dWx5QzMvTWZyRGZaLzhGS2tlNllHS3Zz?=
 =?utf-8?B?bnhoejBvTFI5QmxqY3UvRkpYcGhCRmRrd1FIUkhtUHVDNGt5cmxEUzFlVVJx?=
 =?utf-8?B?bnlJNHVsMHVlbGNIZHA3SmNwb2RPSnNFemlQOEt6Z0QxeWc4WmdiTUdrNDJ1?=
 =?utf-8?B?NjRpOHZNTDhUWGJRemhBWmE2TWVWWFNsL3lmYy8zdDJabzBIdG5UQW9GclBF?=
 =?utf-8?B?bVlibStMZ3NOREZEdFpFT21pTlN3a1hrclJFa2QwRVNCc2p4TElUSmEwaysz?=
 =?utf-8?B?N3BOamN6SzlwdDAvam0xSzBvTVhtUHgrNm5Ub05KU2xJNzdDa1B1dHovRlEv?=
 =?utf-8?B?TnhGN1RaMTk2U2U1RmVubFErenhvRVRWS0o2Qjh0eHpXTGNueEptanFkNXdQ?=
 =?utf-8?B?Y3Z6QUlsWnZPbjUzbFJLT1JuZHdrRXl0b1B1VFFaS1NGbHBiMnJvNVVQTnZI?=
 =?utf-8?B?RTFCd2EwNGN4dkU0blFQT0hUaVZPM1E0MzlXMlFjb1NMcmJmeTRvclgzZHc0?=
 =?utf-8?B?ekZVWjBmOXVKLzJhUkVpcVlCZGJ4aWRIK05ZKzg4Z291aHJCbTJrcTRXb3Rz?=
 =?utf-8?B?d09sWUtOdkx2OEVxVGNSZlBiUHB2NFgyMzJMcTJsNk01RStDV2c2WmZoOU51?=
 =?utf-8?B?cVk3VzR2RjlZekZOcExwdGs1WDFkNlkrc285enRUd01yQnlydHlBN1hYYk5O?=
 =?utf-8?B?VVB3M1BxSmhVT1FVY21yWEtMd0lpaGdyT0ZPNTc5MlVMdXdrMWU3UEoyQmpx?=
 =?utf-8?B?Q3dORVZyRlZwV0pDelMrZHg5eVZWdnN4RldCNlNLamZEeC9CKzhRdlNTeXFI?=
 =?utf-8?B?aEQzbUxjd1NUY3V6b29ObVdMciswUjNSNU1kTGFGMkpwOEtDK0lTVnh3aWFn?=
 =?utf-8?B?cGNUMHc4RTM1UXdSZ29ZZHh4bjFkZS9HbnF4c2RMbTQrbFFvZXNxa2lhK0x5?=
 =?utf-8?B?TDFnRjdtRXJuZGpneFJ6SkFvekJMSDE2RG1FUDZqbmRnVlIvUkFUYUJPSUlr?=
 =?utf-8?B?R2RneUpuNnlRWHZRcmNXSnhtWXpaR0ovckE2d3VZb01YSTJ2aWpNSjdFQzRP?=
 =?utf-8?B?dVJZeDFrN1VnU3hEU2FuamVqQXRCV1BEQ2Q5TGhidi9kM0VGUEZUalNWUVdi?=
 =?utf-8?B?NmxaQit2d0pZS0pEZzJQa2xqTUh6YVdVYndTSTd0VUVqYVBtWWRvMm1VRlR1?=
 =?utf-8?B?dkdPU2ZVN1pyOStsOEFxTEVGSUxEVy9SZGUrRk9EdmtyVWNZNGNZYTdHa2h4?=
 =?utf-8?B?NEcwM3ZOM081T0srL1prR0pQbGZpcW54bWhLd2lsRHdKNmpFZjAybVNZNnZH?=
 =?utf-8?B?ZEE2Nlg5ZWROZ3d4ZFF1ZGJweWJCQTZ3ak51NlhHSThtd3hhdWI0Tk4yakJG?=
 =?utf-8?B?TW9WYW84QS9razZhVXUwOENYcmJ6RlB4VTFTK1FRK1hIc0hzK3ZhZjk3QXZL?=
 =?utf-8?B?ZTBPdFV1Rm1WU1Vpd0h3cURFOWdTSDJFRHVaaU9nZVA4cFBBTTdqaHJCdWpL?=
 =?utf-8?B?WHltR0gydVVJV29iY2ZBOTlaancwVXZaM3BnY1ludkRaa3JabnBTZEl4ODcx?=
 =?utf-8?B?NUFHMmNjd0ZqUU12Q09IVnVjemk3b3liSDZVa0YvZnNFeG5IMnpnaTV0VW8w?=
 =?utf-8?B?WnNPYjBhYlBRRE5ZVzNTUVJTNGJtRHNtNEJCMlQ3aHVTL2haMkFFVVJjTkN6?=
 =?utf-8?B?clcyK1RkS3NiRE9zanZmbTArbFhuODlhNUlyMVhqL1ZQczl3M2NsRzZROElY?=
 =?utf-8?B?VWlpYlQrS3JyZzNsbndzR2oxL3JpOUNZK0s3bUlEMUNaOTI5aVpLTGxyZGN4?=
 =?utf-8?Q?kNBFvrGfbcyWm01dPhs1dr29R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb1f34-51cd-48a5-ea34-08dcf47c1f94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:35:12.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFj2j/i2g/JxjIZRqe8E2tZ+HSJWyXTL7U6vFY+8ud2XV/iWyyqQmxvoqwhfEgG2NHnADkLtmDJXl8Svgeinvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

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
Change from v2 to v3
- Use the "target" argument of of_map_id()
- Check if rid already in lut table when enable device

change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 159 +++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 94f3411352bf0..95f06bfb9fc5e 100644
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
@@ -925,6 +943,137 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
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
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
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
+
+	if (!err_m)
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
@@ -941,6 +1090,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1292,6 +1446,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1587,7 +1743,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


