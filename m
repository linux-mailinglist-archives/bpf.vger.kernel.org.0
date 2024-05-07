Return-Path: <bpf+bounces-28925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ABB8BEBB5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318581C2220C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5C16D9DC;
	Tue,  7 May 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPyY7mSE"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7B16D4FA;
	Tue,  7 May 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107589; cv=fail; b=GKQlYalqlREiCXktgip80euLihPm7tj9YDQzbbiTU1oazVdI8VWsCJ8a5psWmGW2md7Z/78czuGJyvFE0CmpYYnqvAxF/Y+KPfwMXOze4XTp0pNiTk4OvlmqLtGmOysVUWHHwhHiLLoYG8577sjMkisALmpI1gnqQcssxaJBqgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107589; c=relaxed/simple;
	bh=YcV+bPfbQ8hPERCV2SDvifRpdqJ80QqWgg+hJThYFEQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kqP1+TCzu/CzqK9l8YJLKcPlyRcgELuDC34678RPcRk/CZleyE4RHS4b5senfFIL1m/T6qRz9vZr6ucCAjcrvPP7VvyH3iXxZjfMKgT6NVqcFUq2FbXQDE8w5u1A8+LhQFfS0GU2IXPoniTQJ4kwSQbNsNtFLihh64UQxP+SoQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPyY7mSE; arc=fail smtp.client-ip=40.107.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv6diUiM95Eu1f5Qu98gYoFhdKy1IJDvX2CGZlGAQh5gOKa4yp1+T4E7iGDjiEJqtns0iXUYYmoOyrHoxtZwtMJv/YbecXhUy2Xdhx77XH58XyiyMeVQUv0EK1Ikl/p6CXnMF/ZBF4mp9SETd1qhq3/cPMddAjQmFlENWwaXViSoXjkNLW5Pha+QC3KTxLrSE3hgOQFn4Myjz0cA9fKAi10SWQvXJ9dMt4tOTrBwx9oxUSrivqJXKP1fpqAqyucZOnd7VNtIEcgKLF1d9zwhArYp1qHLovhCvxwVv9bd/SyaAOiD+6Rn6OTYRTqXs/6MkCPMxlyd8ZYWZD1j7qALoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNogCV8zOg8H4Xb+q+NRE8ieQG+DU65n0HRUvVRx0GM=;
 b=dYZ0KDicNlRd4Y7XfbMuEzy/XpPCNitPtjNIW4b/7QoqrTzx/rGGEVd2k4nCATYrG162PRToF3K7Mb5oPebS3zFyZNyHoPFaVjxkGBDIKdm+/C6104nx6E+dj/byWSu8OmcLS2Q/GxxoaONktB0yFWj9SHYh9Raa3oVQ/wjIdH2rZTtBCIjAk1lm4N8P4kv8uyMJU2n0J3e4GheI7cMv9Ff1TECzdCuG9YTmhG2IzP+RbjrvubohrdhxcjqvhMJHDVhpGSWkMb0KyYXlQ0+IOFurj4Fc/hGsj8nifolo4cME3WnXvWOMMOy0wmnANPwiHE0ij1USOVBAdHrQUxYLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNogCV8zOg8H4Xb+q+NRE8ieQG+DU65n0HRUvVRx0GM=;
 b=mPyY7mSERXgH/us2NuPCyyeJL3DGanG0Md3X9f2dahFKyPAabBDFYSpVy2aBktSPJZ7s+DqDuv3LwQXXYqgKB8eBXaTJGbOxuJmvgXteM9bv9D82NAoz/LpD2qlVAUzXCsDhzXSIuvVlrUeCdLRP9OFvYnfsVWezQQue9IBJY5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 18:46:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:39 -0400
Subject: [PATCH v4 01/12] PCI: imx6: Fix establish link failure in EP mode
 for iMX8MM and iMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-1-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xoxDn+MAsMCimd0wOl6G3C1M0+8a1hMq0JrOR9jgWlM=;
 b=txg6As3KcI6mOVHnc0/xjYotiu8vNM79HNmEQ+CdRoAqJpUEZyzcsWQ8ZM5IFKNj6T6qZT/X3
 maY87uil+5ZC3yKRyYRq1BDgEZfXWkehY48e56/mddt6SXn6YRcVqcp
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a883aa-a5ca-4916-c539-08dc6ec5ffb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUpPd1o1SXJZMy9PdGF4eWdwYVNsYUY4WG8wUnRIMjNBVHBKL2tJT1A4THJ6?=
 =?utf-8?B?MEUwYk1GZkNGTUphUVB1cUxuanpoOU0zNUpuK0FreUYvYk9HdlNLMXhNcjNY?=
 =?utf-8?B?bWkvRzlVUkpmUHZ4dVlhSkpFZnFwdWYrME1tUVBsaFFxTEtITk01OGRlZWxG?=
 =?utf-8?B?YXVDOXc2a0Nlc1dQWFd5cVhRcm5Nd3E5aDFOczFEWWIxSjhRTkl6ZmhIa2pX?=
 =?utf-8?B?OUY5VW00ZTE0K3g2cnBCUXEwSVRBbWtad096S3pYcHB0SkZ5dkRyYjRLUGs4?=
 =?utf-8?B?YmRybGdUMTZMV2ZMMHNUNjA5cFpEekYzT3NHM0JXZ2tFN01Tbk0yaXFJTkdX?=
 =?utf-8?B?QzB3NDNnV3ZaZjRORGR4dk9jZS8vU0pTSU0rUzlabTA4OTBnL1l1L3ZPREVV?=
 =?utf-8?B?K3dUVzZXdDZTUUtXWXNMMmM2Tjk4dTc3MnJZWmQxajVnVWdoMUlQZXVNY3FY?=
 =?utf-8?B?N2Y1dHp1aENYckN0dVNybVkyT0EyQ1Y3Q3dQVzY4ZTNHZmwzZEUvSVhDbUk2?=
 =?utf-8?B?d3l4VjJwZHBGRkNTU3diRnpDMVA0VUxWdVdEeDFEeGwrVTBNSzUrMmUyL1FG?=
 =?utf-8?B?T3pGTWI1NUg1KzRndVVPcE1kR3NJRjhuck15MVZmaEZVUUJpcXZBWHR3ZE80?=
 =?utf-8?B?VW82dWNsRDNsMWNqMVloZlhPU0V6MDN2SE9nbkU5SFVDQ2ZKNjVLRlgyUFQ3?=
 =?utf-8?B?eENFaEJaOXc3bngyeEhjaGtOaDkxKzB1M0RFYUZGMEg1NkgzbThYVWtWcHZC?=
 =?utf-8?B?bFBaSzdjM2ZWVjZsSjJBcVRJOVEzRTlLVjlsMDBwZzBUaFk1TFdaLzZZdGMy?=
 =?utf-8?B?Wm5YWEhlY1BteUlsakFvb0ZUSHRHN3N4NjNUV2JqYiszczUwSFg4OFJ5TUti?=
 =?utf-8?B?UWh6Q1FiekNNWmtpRkRWbFN6Y3J5UUsrRkFNZWZXdmtzdno0WUx0K090eHZH?=
 =?utf-8?B?a2RmRzZXbkxuTFgzZkJ3bERvYnd4aXdCY3RUc0pFWVZ3dEwySjFJRzlEN0Ur?=
 =?utf-8?B?RE1SVENQSWx2NFcyV2NhT0ZsTmpwc0c0TXF2aFJ2N0V3dmR2cXl1Q3hRck5S?=
 =?utf-8?B?d09QK0djRENMV1pLeUNHNDBTOVptU3pJeU1BV0pjRVVqOG13N3BaWnZOYlZh?=
 =?utf-8?B?MEtmV3VpRlVJcjdySG44STBMN3Z0MVV2aWlOOHpMaEdFQ1pDVDdtcEhQOHBm?=
 =?utf-8?B?T0VCckxYQm5WdXQyTTUzSmw1bG9HWUgyYnM4ZkZmS3lLVzZjdWpVN1dDbnVv?=
 =?utf-8?B?MU42dUsrNnQwZGxHQUlnenZPSjlyWlBsdllaMDYrdExoQy9ZSDFIOTl0V29D?=
 =?utf-8?B?R3NVRElLVWpvWTltcEhPc3ZnUkp6OEdnNzhUWkV6bmxweDU0a1FVaUkwaXZx?=
 =?utf-8?B?NzhmR2FHOXRBMkNmemVHV0E2RG1CamhFOHVqT1JhdHdFcWNRbkpYUEF1Y0l2?=
 =?utf-8?B?cEhKQ01EbTF1Y1hKcEpnYzZmZWZGS1ZBR2VqR0RCOEE2ZEJTSXJIMkxMZUFz?=
 =?utf-8?B?SDIyTllDaFpRRjVtblQyMDlqTVRoQTFpR1lGb3FSWFVOeXBHdnR5SUE4dWRQ?=
 =?utf-8?B?cDUzbTlVZDhOdVh1QUVQcGhJSnRFUmY5SXRUbkNJejBSZDlvZEp6dW9yVERj?=
 =?utf-8?B?dHpsWENFNDRvUXZhTVpRV3JuUjRzK2xzTW5zQjVHR3NGUXlhY0pHb1lSS1d2?=
 =?utf-8?B?RTA5RXBqODVpdzk0T25iQUpEUEkwdTJ5R1FDOFRHZlc5NnQ5dDlQWE9waVo2?=
 =?utf-8?B?NHZKREN4L29OMXBlSTNPVHpWWlZkaS9ROG9oeDdmMVFidGZ5WkRONEl3eTJU?=
 =?utf-8?Q?C2Q2ven0O2AGqjz1Qs7fwfrNsN3zrvBn8t4aE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhSWkxMNkgvMnZOVXEzUmc4MzVoOVloVmM0VkxtS2dSRWZEbkprSmtHcGdV?=
 =?utf-8?B?ZXZjUEV4T1NCTEVmTzlmR0U3YlJFSTcvRHd5YXR3NWU3MVVHNHpvaWx4aFI2?=
 =?utf-8?B?cWRKMEwzblg4Q3B0MVFOdkpTSzE1VU5ud1RLdEZpc0F6aHIwbmZTMnBCSVBi?=
 =?utf-8?B?N3BJNnVQOFQyVmNaeG1PT0h5bW8wM3NDbVlYbHExOWZkVWYrSTRVNEtRdTJU?=
 =?utf-8?B?Qkx3YTZQZWRRa2ZxSk90djNvSlhtaTdMblNPYVYycVVWR2FQeFdxM2JacG5J?=
 =?utf-8?B?VFFqOW5JVWV1WGs4OG8xZ0ZQUHNwUVljN0QvKzd4eE9MRCs4WVlrWEJXNWl2?=
 =?utf-8?B?MHU2NXV2U0NNN01JbXhrajBaS0ZnR3ZDL1ZKQlJQUys2bkNaY29pYTg4TkVS?=
 =?utf-8?B?UXR1QXBuc1BFRVRvb3FiY1IweERNQ3krTWh4Yjd0VllEMjBrWmd4azhneTlq?=
 =?utf-8?B?c01Ea3lKMnNkZStXcmd3U3BaRGNEaXNCTStLdEx5WEpFZmI0WXp2bmMvdy9h?=
 =?utf-8?B?UGMzWmVDR2lTTDhZcER1WFM0UGJ4UGhpUU5zYjJHWEhMTEx6aFpnWDJ6bjUv?=
 =?utf-8?B?dTFEVDE5ZTB0WUZJdHpPaEcvdGxkZUNQczkxUFB5NElMY1gzMVArWDJLb2k0?=
 =?utf-8?B?aTBPd0VhdEo2bm13NzFYbUx0aDErUkFyc25XbGNuTXhEWUJSaE8vU0dKUlh6?=
 =?utf-8?B?VndFR2xQY0l2SEl2eDJhNXBqNW1zMkNGdENuUDVIdzU1MlY2M2VsOWZlRFdy?=
 =?utf-8?B?R0xtU2NPa1FwMHk2cUo3WWlKZEM3Ky91SGk0UXJ4ZmtJV1N3L3pVTysxT25Q?=
 =?utf-8?B?Q0F3bXdRS2ppS25ORVVHNldySjduUXlQdFVTbjNULy9oalE4WjdQa2FpZ2NE?=
 =?utf-8?B?WGF2WGszek15YlFMQ3ZpNnJYREh6Q1MybWhjNHoyZlJIY3YzTE9KMExPQVRS?=
 =?utf-8?B?cWF0em1FNjYvSnFjSHJvVVUwYk5JN2NoR3A4MGJYa0RQRlhocFZ6UFYwRHZi?=
 =?utf-8?B?ZmNhWjFXUFhEZ0d5STNuYkZ1OGlPS2h3N1VxbmlyRHcxNVlvd2F1MHM3emND?=
 =?utf-8?B?eVZoSkI3UW9KMEMrZmpNdTZocWkxcHBweTNoT09ocGZMZk81aW90RDRUSmdp?=
 =?utf-8?B?YUpaY0hnNlJsYkdWdUxlSlUxbm85WnViYUNia2pLRGw0MmZFL2F2SmkzYjd0?=
 =?utf-8?B?TG5uaTVLVnVmWEZXSkp5VWQ2TkgyNDJhSDZjUVVlYW92KzRHUWNzY2JQSFdJ?=
 =?utf-8?B?L0ZJdC91d0xyenBzNFpibCtaaVVVNlBTZGsxb1g1S0ZBbnZCK0pGZUJjdnZC?=
 =?utf-8?B?bTFISytIS0FGNlUyVHpPNGw4cTV1TlpWZEVaZER6Kzg3TWMxSldyaTh0TTF3?=
 =?utf-8?B?Q1M2K2dHNVROWnlRZGhiRGJLNWpIaDZWY1lwRDZQU2VWeDNsbk9WTVUwcm1H?=
 =?utf-8?B?bVJrT1oxVFJMWHY5NW1NclY2LzM3NnBOMHlKK0I4ZFl0a0tWRjRiZ0I2SHV2?=
 =?utf-8?B?UVhjVUJvNHlPMmt6VFhqczQ1ei8yYS9pQWZoNDZFNVQ5SnRDM1owdFA3QTY2?=
 =?utf-8?B?RklVUFFVZU50MXlkTFIyS0xPSU5CdkZMQjdVTVY3SlAwSHhNb2F3YUhNSmd2?=
 =?utf-8?B?dEMrL3Y1eTdYcjZOem5sNW9CdEx3bXB6ZUZlQ0YydVVKV21qS2VKRFdhdmkv?=
 =?utf-8?B?emxRWmVlSStGOWRtZHpPWTBuQ3pJQ1NDanBpbHlTcldkOXoyZ2w3bzN2d25z?=
 =?utf-8?B?aWkwQXVXcmZHbXkzRlBYZndTWk9IL1lobndjWWl1WGV5VGRLODg0WlpEYjF2?=
 =?utf-8?B?Vnozdys0Z0JNYmo4bVB3N1BUaTM2RDVzeXRHa1JySE4vQzI2djI5bytDbE04?=
 =?utf-8?B?c0E5ZUF5WEZVclJualRlbjhYcjE2VkJ0eU5lSUhhMzBtVWdnSW5KcWt6ZEU2?=
 =?utf-8?B?L3FDcDByOVdIeHY4MXU0NHZXV3NVZDhHWUVoYmFvdU5RZ1VHNGRONnRFOFhw?=
 =?utf-8?B?LzJnY0VSb1QzYzBWZEU3VXlubWVkdkVqbGw2ekhsNlJFYVIyY1MycjFvbzgr?=
 =?utf-8?B?NXFJUWh2NE5ObERHemNpbGRzYjRVUzYvM0o0T2xFY01ralJ2cVpDYjdvcVlK?=
 =?utf-8?Q?a9ZQHKOAckoNVs7vJC2AJldt4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a883aa-a5ca-4916-c539-08dc6ec5ffb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:25.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9tM9vHOWeDxWLNloUwmejTGTR2Uopf+f/2HHieWGAgcPq/Q92bUBzPczK7hzWqChZKjm1gjaPpJQSMrgTEiQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204

From: Richard Zhu <hongxing.zhu@nxp.com>

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This flag was overlooked during code restructuring. It is crucial to
release the app-reset from the System Reset Controller before initiating
LTSSM to rectify the issue

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 99a60270b26cd..e43eda6b33ca7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1568,7 +1568,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1579,7 +1580,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,

-- 
2.34.1


