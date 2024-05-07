Return-Path: <bpf+bounces-28935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B18BEBDD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DC61F23656
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AA171E44;
	Tue,  7 May 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pj48bWJx"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B616D9AC;
	Tue,  7 May 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107647; cv=fail; b=W8KQJ4Q5+h40ZvpZfZaF68T9PHFNg3mPSoAPQPZsEaylvKsnWJq2p+c1TwcSW8EUX9NHms4+lhPu12kT3b6kpa4x/8LMVKpj7jz2C2gjo4Wi7Yt9QIn9FDhReZ/DUxHpgl/RlqWP0bkY6F7dYqus+P/OlaWW7tS894kkYcnZ7n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107647; c=relaxed/simple;
	bh=rRm5SujhEiX9hVYVjrxBprduIqi9bHP431kr+qPwfZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FelqPxWTz34Cb6my9812JjQU+SohXLexrNO1/OZaxOlC19gJITP/RefXojUfq+bObGJHy6bLyYd+c/2MztzYB9KPuBphduEbK8Onz2Px1iG3CbAM7iHmswzr9gYux0jXWY6qA69iqDzFSEee6MOx5Arb58LYB8tNrDb69NwfyGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pj48bWJx; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVC0slsCU7m6rwCaqyU0zemLyqnpdMNp4/iBP1A0gATqMJ1S/lok8CgSg/V/C78FNhHI8JZmSa8tJ4S3fX6L1mer3lx24/ZrpnWzNr2NTvqRfusiAQQCLt+puocB4OJ/1Xd4eiDXAj2kKYivPI56CtMD5QSwoOJsIMWZ3Bmxt12AbLWIt/Bi5ptzvJXTum0Rxg6xVFXO30zUmj8N+w38Im9WegGGgKT25AO8akFGhnPXMmyx8NHxsflfOZA8FP5zzK7ZGX5vVTILiJ2zm0ybv66Um5TiXCgko87QcMyRJCXoRfDt1rSM682gF1YnJGz5fbSyh2dpleYS+6Fm/WUO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gTTDoBfA/yf91PPA7MqT/q+r+bNwi1FVYdnjZCH/pM=;
 b=AY2iTw9Rt+1nZPoVfXCpaRXzhL+ij8CHgco5qb7EqRaCAG3mT86wFxS1C2y+yqEwvJaOUvmx17q/8JVp0pmWVxsygSqGsC7TBHMUW77nhXg3lq5ePgFpltsQ2nZKd6dqvBuE27cMGT6c9GdmcH5VDBsLrJWt3nJmiFZN9NoaTR9sgxhD3EDq/dCsiJ+hdWWY1NSg9MOv6O93foeVRqnXtqxJfzxXZywcmTFImsip/D9TU6YXY6BJz+fFFnpFng+BeCOb2htK6Kn1TzH3Y1sWvKdVduDhpaWsIRavXLfFg9NCMLfhBOiRZJIRn0kkeWjkpCJjdSeQbXTR4hegnYDlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gTTDoBfA/yf91PPA7MqT/q+r+bNwi1FVYdnjZCH/pM=;
 b=pj48bWJx3lGiBnoAHuTDveo/2hVXXWvQXRKRg8ZhyodlObgQiMLuQ9dTCJ0NQXPRhPXICQbejmbCAg8o7Q3EWryvI40z7FpRgu0QKlYLJioMsNY/ZSeGeMkGuHu1lcBThziwXGc4iAe+p7WtSRV+958TekhI9LpCN2H9bURyPgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:47:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:47:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:49 -0400
Subject: [PATCH v4 11/12] PCI: imx6: Call: Common PHY API to set mode,
 speed, and submode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-11-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=2344;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rRm5SujhEiX9hVYVjrxBprduIqi9bHP431kr+qPwfZU=;
 b=WnHtWsp2PCQ89Q1ObmF3XJCsbhZXA9pISVqfFPDcdZvNNlXxL+QnVzS9Awh0VaZGnDJc4pQFV
 LpJsjSeWcV8AYCsOyL7PfeeZ2dJyupXyMN5LEntzJxC+NB0RcLE+lhY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 577e8acb-a1d5-4427-4e5e-08dc6ec62161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3BGYkdRMFE4QnUyS2RHNEg4Z1E2TGNwS2JSUTVTQkVzdndVU0JIS1FvRkJF?=
 =?utf-8?B?MzUxa0JZSy9zWkYyWUR1MHJ5OXNqZnVSa3NSc1owODUzdzhHQlQ1RzJ3MnBs?=
 =?utf-8?B?c3NlUVJscE1kY3pOUlFLeGtUUU82OHJ2dEZXNjBxWi9zQ2RHcit3UG55TDlL?=
 =?utf-8?B?MGxTZFNUSCtnWjFDSUJLdC9KN1I3Z1ZIUlpMazUvTFFVcXdJUElEZ0VhdHFw?=
 =?utf-8?B?V0FBTUp1S0FIaUZTZ0FGdjBDMEtqYXU1bDZvK3dQMENhbmw0NFFheWQzck9T?=
 =?utf-8?B?NFN5OVZvejJzWWpxMjhZOXRSYnF5M1Y5YUJobXg3eWFBWkZqNUpLTmVlYjNR?=
 =?utf-8?B?ckg4cXVlSmJvUjhpSkZDcXBpUm5HOFFUNVA3ZWxNOGZyeW1VdFNpMkFVblFl?=
 =?utf-8?B?c0hTYjhLVVJNeXV6V0EvUEZBaVRGUDk1cjBiOStJb1J0V3hwSEtSM29sUEpO?=
 =?utf-8?B?K1F6MWpTSVQxV2FBSlRDZ3ZndVRNc0FCdzRBY1NtWVZ2WURlNUt6OVN5andt?=
 =?utf-8?B?TUZpMjJlSk1Da0RLcUNxaXdyM0xtMW4zSGc1UEdjWWJSRFFxdklLVFpNTmpT?=
 =?utf-8?B?VlZtNTIzTFhOdVVHR2JvaGZyUDAxaGtBcUJrZDFrWlZqNzZta20zK2ZwSG1a?=
 =?utf-8?B?T3c4VGpacC8zZHB0eW05VEZUNnFTRm1kWTFuWml6UW5HeXpsZWNhTk5HdjA1?=
 =?utf-8?B?Wk5QSDE1R3ZRTjBkaWYzUGRlaWZ2a0xuOFMxZDhmMW5HQklKQlR0c08yOVpw?=
 =?utf-8?B?emVzNjVrdjcyUEppSThJdlJtT0ltTGVadUFKZ1VsUWkxV2VpeFFmSEhjMVF0?=
 =?utf-8?B?M1BSRStkV1FxcmttK1VPWXdnL0IxMkhleTdDbWdDV3p5cmxNejRhejJMMVUr?=
 =?utf-8?B?dSttdURkSnZpNTRONHlXMDYzekdTdkNmTkMxNWo2SGluQXhVYWJwdEc4czVR?=
 =?utf-8?B?akw3MzkrQTA3d2wvemNmSnA0OGswNXQzTDR6SEhCSVR2VUlSWEZTOSs1QWJS?=
 =?utf-8?B?SHRYdmpDRSs2Z0d5UnhFUHBlQXdzcnh4dGxOOHBzZ3BsYnd1ZmFIRWF3UTVp?=
 =?utf-8?B?enlTRTdmRkx4TWtTc2lOcnRzK2FmL1VFL2JmeHVNbXpobWhVN1NtdGoyTFdv?=
 =?utf-8?B?a0FlZGhyTzZCQ0dEVFZQMHg4blowOUdsSkFWZEd6NGJxeU5GT25NRTAzNEVX?=
 =?utf-8?B?UW5UdGhtbytlL1UzN3NRalczRXo2MjJFY0hhdnJXZmdaQWRhcGVLOVlRMjZ6?=
 =?utf-8?B?b1g1dEhaVDJNNlFIK1FJSVhJT2dVbzJrcFJHVG1NV2thVjZBUkpacVZ1SzZJ?=
 =?utf-8?B?TWN0YzZ1ZG9aaWdoL0tXMWdxWUZwSE51dlNjbk0zY3g5eTZ4U3lhQ2tuMnFE?=
 =?utf-8?B?djB3RVJCR3RXSXlVZ0MwcE5NdGtEZ1dsUi9JQ3A3RllsNWVJUjBpcys2eG0v?=
 =?utf-8?B?c2JTa2dSQVBhdE90Z0l6MTkyVXVMSlZHSWNXRUtha1JORzZIdWdBRUdtUExZ?=
 =?utf-8?B?ZEZ2VC9UeHRKNFNITy9RcGExYVZRYS9ubXlCTDI1RnNXNHNYM1A4Ly83N2VB?=
 =?utf-8?B?R091RzMzUTVEU2FGcXdXU3lFQXRpeTNCSy9NRnpTVzFIQ0hSM0tHWXJTeW1n?=
 =?utf-8?B?TUp3UEVrbkRaaGlMakpMa21UZU9veFFBYmxhT25KMEo4OEVjVUpmTmtpblcx?=
 =?utf-8?B?bUFwSGF2K1lCY0FNYjlXWFNQaVJCU3BCRUR2aXpsVlZnZkhaYjM5QXB6UEor?=
 =?utf-8?B?YVY5MHl3RHFBYUxub1laRWtWejhZMUtORzQwOGNMbzkyYkRaSllEakdpZ21L?=
 =?utf-8?Q?+vCZ4EclE0+r+0aNCD7nMV6kpUmSh4B9pDLSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uit2UVRWYjdIZ1VwSVhJaE1tUlJtdFI3bVN0TWEvMnJXUmlBeXZONXNYaUxU?=
 =?utf-8?B?V1MyQ1RodFBPMWczWWpxZCtJTWVCMWlUSzR4OEFGVFdMN0JiZjYrY0EwZytt?=
 =?utf-8?B?Y2FwM0dDLzNjNFZ4bUVidUNnaUtUdkZXYlBUU2huZnhxenhnaXQ1Y2RYaHhH?=
 =?utf-8?B?dEFCMFBhcnRNOEVaZWN4SUJsNkc4TUN1WTNSUnc2L29FSzY3TjhjTWltK2gx?=
 =?utf-8?B?SmcreWcvVWdiVjRCMXkzVVVnS2YvNWYxMGJXK1hGbFpwb0JSeWxyS1k1Zk9S?=
 =?utf-8?B?aWk0OWZwY2c1MUN0U1BGM0c3SEV1TnVsMDlMN3gvL2NhakU2RE9QUWpaSmxZ?=
 =?utf-8?B?UEE2ZVFrSDlJRWZWWGxUSzJrOWhlSVZVMlBObkI4M3JGb3k0MkU2ajk5ZThW?=
 =?utf-8?B?aE4wdk53RFZJQmRmcGxFOXZrS1JDa1N1amp0Wjh4Ym5OOE5QclplWnRONGFq?=
 =?utf-8?B?N1FNM3MxUS9tUEFvZU5ScVpFajNLY3o2SzNIaTBKYUVDMUI5NURqRUJPKzdl?=
 =?utf-8?B?bExsN3dPR3J1MDQzeHlkeldBeUwyVS9SRE5NSm1oMUhqUnVIeUxvanVFS3NX?=
 =?utf-8?B?ejFJczRGWlQ0a3VyelhrVDJPWFhRUnlWV1JLcjBaSWs5K2x5RkVjcFBYYklp?=
 =?utf-8?B?MXNCSWlLaUdpdXBNaTJ5OGpucHI3MFlIMVFzQnhQRmFGLzdPekF3R1c0NWNJ?=
 =?utf-8?B?SHk1UXhCV1d5UTYrcDBDZ1hLRjAvRkxZY2U3K2JGK0JBNWtVdkx2RldBbWdN?=
 =?utf-8?B?bnpKMHh3bFBLUEtJVkF3Z0trdnpSOGVTVkp0RkQwMzM1Y3prYjJRdjI3N3pW?=
 =?utf-8?B?eVMxWE52T25XTytELzh3LzJkcHhNR2tYRmVzdmhIUkpJMkZtaVV6N2xWSjJ1?=
 =?utf-8?B?Wk1pTEo4aHFiUDh0NjlCZng3K0Y5Z1VNa0hVWEg4UFVCVEJoUFZ6ankwSzRo?=
 =?utf-8?B?bEdiUVlMNXBqYjYyeEppZUZaRzFVRnluVlRMQ3hZUXQySUpCWlVrR1Z5bmFt?=
 =?utf-8?B?UC9IV1BYNkNrOU5MNG1lQWEwY1pqVlZYQ3M2bWlxSlp2RVVNcUd4TC9xS25v?=
 =?utf-8?B?WHNaZGhiN0p3Yi9CbXF0R2tpMlE1L2NFSUlRaE1HVmVnRnlrMmY4WkJnZm13?=
 =?utf-8?B?MDRnU2xnZjU3ZlkrSHdVWHdRQXJXSmd6WFg3RllFTmVWOStRU0pNYmVKYysy?=
 =?utf-8?B?YnQ3cVFCZ1FaTDdHbFNJeURIeFRrZ2hETU0ybGx5MlN1VnNTWjJOU0YwbmQw?=
 =?utf-8?B?MXVTZWlMMStnTXRWYnpWZ3dLMVF4UE9pcmUyVGIyZmNwUmlKbFZnSmxJT2tz?=
 =?utf-8?B?SGlLekV3QVhNWThaM0hPUitZMUJwTzBNT1lZL2VSemJSejlCRHE5SG9RUXVv?=
 =?utf-8?B?S2Z4NEFKVkY5YytRNXErbG51UHRNTm9ZYjMxMkVPbmpLV3dlQmc4aFl3d1BW?=
 =?utf-8?B?aUF0ZTVkcFpSUW55QVVGenkrMnEvTUhGRTgwTnVVK2IxT2R3UXlrVFpKK2Vm?=
 =?utf-8?B?UEFwQjduYVJRNXg5MnhEV0VkeElac3BWTW9jeGtvYU10bkZwWUdGT3ZrL3V4?=
 =?utf-8?B?b2o1czRMTXZTUndOeEx4U2hUdUFBeU02Z05XVEJZeGI1YXYycmRDSXpwRncw?=
 =?utf-8?B?SWdzMGJMcUlqL05kT1lxdzk0RENaSmJuWk1QeEpUb3Fwdi9HaUxYcTFJS2Qv?=
 =?utf-8?B?Y21tYmhQdS9qTDJNNVVXMWhlTlJmdkNZUGdsQjNtb0RVbE84MWV1OUFWbUg5?=
 =?utf-8?B?VkxtVHNQMm9XVWNZMFNNL3hPUldpNFVvVzNpejhPMHhFM1R6dVBCUndpRStZ?=
 =?utf-8?B?Uk5RWVVsZjB3c1E0cElGMzh3STV1TjFpTk5SaHhKeGl1S0YxZWl0enZBUklx?=
 =?utf-8?B?cHQ4bFZHTkJYb2NHVGJUTDNCZFF1SEJUTHZuVWdJSHFWc0VCY1MrUkVpV3ZT?=
 =?utf-8?B?M1RybVA0WjNEWUtDaVlCV0hEcmFUKytXck9Eak5CTGZyM21VR0pWemRyMEI4?=
 =?utf-8?B?ZTVVMTVoMXhMY08ramlVNmFRYzBYTXdFQWx2TzN0ZnhXeUtHaGpQUlhRUjA4?=
 =?utf-8?B?U0YvZjFFdCtvdTdCSGNlZGR1M0YwdEFCQWNKQk5vWU85dmFNV05WOUhWWXN1?=
 =?utf-8?Q?t6AQfuVyj9HMWxwjwCZzJ9Xj5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577e8acb-a1d5-4427-4e5e-08dc6ec62161
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:47:22.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvrNUWcSTYaHBRMGb/2tH2Oe3m8IcLfb1K1D352gy2T62g3yZIPHSLBCLJfG77LzK/rhBQvymM9HjEJa/MGoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Invoke the common PHY API to configure mode, speed, and submode. While
these functions are optional in the PHY interface, they are necessary for
certain PHY drivers. Lack of support for these functions in a PHY driver
does not cause harm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9d53b545540c6..df623977d8fe6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
+#include <linux/phy/pcie.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -308,6 +309,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
+	/* If mode_mask[0] is 0, means use phy driver to set mode */
+	if (!drvdata->mode_mask[0])
+		return;
+
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
 		id = 0;
@@ -887,6 +892,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -899,6 +905,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -1034,6 +1041,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set pcie PHY mode\n");
+			goto err_phy_off;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


