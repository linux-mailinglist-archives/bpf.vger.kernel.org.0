Return-Path: <bpf+bounces-37518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B4956E54
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6091F2145B
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35316C68F;
	Mon, 19 Aug 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jy+vRKyC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BQJNcPqo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999E1EB3D
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080303; cv=fail; b=RDUZA6JK/SEai5cKAI965gih9cogAjSLwpFC0uIvinenQU2GQIivQ8HzuXpu63MVvewZR+DsnI3809+Ee9h40MGJfO4nQTJVm12xLIqgaZPNULPd7jTw9Mpr4FIM1zFpJVOrUeVNeIn9600TNFj07jb8EqNoiRWOlfJSQF0MTeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080303; c=relaxed/simple;
	bh=n8BWC+cSvr9UZGdcL+25PzqrE5xtQKgUnSzCl4I5hOk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ieibf583rTCRfyFBQG6FYjEgBiR+2JieON3N/dcGxcZQKYLV/11NqH/QbOuZPGrWbZuUhVTRKdsKbBjo1Bii5xlXgCLUbO/JoU0myqu5mmKcv2X+kLstfSC1h6ny3w0GW7LrsKCsqHsbdsLfuQtrMms8cPmkpHj3H7mWi6JGtiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jy+vRKyC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BQJNcPqo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6s0Z003560
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ZLSD0pfBAcNri4
	+/9N+vS16xeSJ6+IbpoUrtNT4ftu8=; b=jy+vRKyCdegvHGLgPRmMCHsR0H4YC4
	TkL7nsns/IXQzKZmne3/Nx04Bz/CtL5Lqir0OhCRTgVIuLXRkPowUYZCiJvH9w4V
	In4g5Xc1ZvusfuD2cIyI3/ORvz18WOV6c2rBebk5IPeLyJXGJJvmRow6bg+zsREq
	BbA2u9yrwjXWfpnleKVvXrl86I9rufq739iRGg83jbf7prBZwYiXylt25i1VCkhf
	nzHP7L3BxfeMTQG9e80e+zVBUTc9bCJ+6KXORkMYvJCIidslk8Rdc55rlJPa5NEQ
	yBfxfbtcSrAQUqczpv1lrZoCraOFrezDepSq3h7i57FlmoPWqBm2gWxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4utuu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbH5X013874
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h2e72va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBPfcrLWy9grz3HVh7ODOXiKXviA+aX84WBxTUaxxwKpoBEYs+RVz4sSemQw8S02Elq5Yq0bCS75yIL6M4/KtCNGpuJSzV1rUDpzwlF82l0iOLhm67mCmQTqmrtpHbvNVIkOf3OeKxFLGy9il51uQ5JG1gqOYDri3A2p15vrISvHQhOw4V4oH3F1RXfFxQOtrccuZAcMvjhjFTeHgKDhegpxjTTut/mqxhPq54h0KaYFBHeTVzLms+Hj0m0qJ4HuKlflT40W16PWHPb5CZXJMneH3T7aSduhUn7VYlXs4Duoj/eoJnbqGhr1hHvp6+hdbUBo/Eocr62P/OIHbNctKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLSD0pfBAcNri4+/9N+vS16xeSJ6+IbpoUrtNT4ftu8=;
 b=FmvFTjsAMRyO8Cu8rTMU1uzxWby727zmtr9qpwELDBWG58Lve4KbSMTV5dsN54lblABy4B8FkcUMtlKfKGqKw5DnJT7h/FJLFThs5KXalljocvfLLP0dBuZJjZx17e7mS0k5VOhgqAnwjhQGORM+TZ57RVJ/FlmkKczcDonlDNup1V6q4c9ATyH2Oant+T/FOk6iDc6DfOLo+sXRlNbsrMenFmMQRY4vwxUh5NXoke4TX5tNSYvu8aF1BpP0PWueXIuNBzcxVoD4YfPMMCNK3q2qJ3DLTWCaUa7cVX0+mCnW+g2vMPZ6o5XqRb8Xn+3O0lSYzLRSMcRa4jtqrDPd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLSD0pfBAcNri4+/9N+vS16xeSJ6+IbpoUrtNT4ftu8=;
 b=BQJNcPqo7srgz5JWsXqPeGjoZpCQAICB5q0jAS5b3VGvlbCjYWF1RFnySYsVkUfNd8Cy7aRV4ZWMnb3e5XCBwuj0z/k0PxNhPDLRLvxxhVe3pkiG0ehHBRFF/Rtaw3LmsqIlq/RcRboKuKtixLnL/SlkcaT3csy5jb48xIcy1Bo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11; Mon, 19 Aug 2024 15:11:36 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 15:11:36 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH 0/3] Correct recent GCC incompatible changes.
Date: Mon, 19 Aug 2024 16:11:26 +0100
Message-Id: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: eac2c775-1659-4e7e-8b0c-08dcc0613828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aD8tvksmnTkCOSt3Uuk4kQan+WGdkXnKh7pGpvngv5qSKznJwUz0farP4EzY?=
 =?us-ascii?Q?fYTV7xA4S4Jr0kEGJpA86XZ1H7m/y2ShtJdmi9N16oPXsz37puuc/nrHidS6?=
 =?us-ascii?Q?qVznap4Ues+8gDa1jtLmoy/bfBNDJcXd5Z6ulJFrEJw98+QMxTDC0rW1qOlc?=
 =?us-ascii?Q?mVHKJX5dnJy46gQfvxpYHBcXN8P1sxygSBkyTcgg5i3L6W4j57kas3RhOLVB?=
 =?us-ascii?Q?JK/tnYQ1GbZTGthYgcI3FXMwYIvb43h4zm0OCKAbbzHyk2pHr9f9yGUe28L5?=
 =?us-ascii?Q?4wWz5gL1yJ2tBmejSeJQnVIOEivkMK3ibWSxwXocIQA4GQP6L4Atpy5hVLbV?=
 =?us-ascii?Q?YqG6YonP+D46uEGnQHVxLUMsuBe7xC67LPfFr50q0XzEvZoVbCLPXlIbg7kO?=
 =?us-ascii?Q?8jRTk5LrVn+rkPU9/cB+wwJtOW0XEdQQiq2rErLV3KtilvwfhmRE9hIR9dB8?=
 =?us-ascii?Q?sc1aJji6W6R3Ggs3fIwQHFwA8+V5Y+Hjeeey7YyIs5ukBusVp7nMnwosnuRw?=
 =?us-ascii?Q?ui6TGvds9/G2eHVkyhlpeq8uPX/t3b6ATSobe6YapsLORBetauzxVdiavWjr?=
 =?us-ascii?Q?Mqau3Bo64f/LpF8j3IK9xjc4F1aZfdMQSIWSVlXFlZ+tcaSRvFEBTdVCAnEV?=
 =?us-ascii?Q?dpn07AzxQ1KB45Ltuej88Am/kn2Yfyi17MrwY10cu1xsmHhl1XQml2jspxDR?=
 =?us-ascii?Q?60Ne4PNvJXlNHub/WzRcdCZXmG7Y07LHodp8sU/57t5OO5zzW8XcMfmykpHi?=
 =?us-ascii?Q?sV1mP86LbrxIRhN1UkmjT5KPk2HJAbS5lKRGpKrZ1MPBPh41ZCe1GCGyfVq2?=
 =?us-ascii?Q?5Yn2laXoQUJf5P69T2gbZIN9XbDYbvigjLjLVx0EJ2d8yrgLKUuNdO45fHik?=
 =?us-ascii?Q?9vuaGA9d2InYiwT30qVajlHiM6jLAQhjUz1PfGppbu3bNHTWJn3nZU1r9DOa?=
 =?us-ascii?Q?irFglvbQXXFDPPcu/WV3iOBDeneC0nU96LoMfxa6KgZ/IcgIS4iwX8IYIbv7?=
 =?us-ascii?Q?dGAukBldbdD1sWEDhxCyr/95x/xUA3laL+tpr3vJKE8lMNcMC+obXnep/iOI?=
 =?us-ascii?Q?4oO38RgOOfuevdxRTJ0epY4Ozf4UYBzFzzVyFhMmMl5mXiGPjbqEj7BKlPPD?=
 =?us-ascii?Q?z5PXQlT4P4VVnVqe1POMAImXXCPCH9wxRTyqsRwNF21MP6E/2PkzbxLCkzfB?=
 =?us-ascii?Q?LuCPxi884vOGmSeFGrezb9FoGcKaJ9QBJu5vgGpKRKAOVUS93mzsZ92s2MYX?=
 =?us-ascii?Q?cOPOqdO0JGnmKR3CmGUKi6SfF1R4tP8OJs7sunM6oFN58+NDsEJMTY44jf4G?=
 =?us-ascii?Q?GSnii6kkppnxSShdmcG3IgryPpcYqX7mmDOrbsM8PW0T3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XyRnvgmUTOTOqWZzehSS0rwkb4JV05v1jPWktK00zCTamkv8ZxtBy4hqZTHg?=
 =?us-ascii?Q?PN+FLMwDmMGFisjdk4Z6XtAOazDBWma2Ct5MtfbOE1yicq9XUxP7b2gsiMba?=
 =?us-ascii?Q?Y86nMKU7nXTrpRmlKHPyi10UNgVneL4K2lhkD48A880r9n/A1ea9mzkepzww?=
 =?us-ascii?Q?Ht2DXLa/jhk/O34DADAwzmWcQmHdww775w14bZ9wAZ+cj2xKxkpf2rOQ7s1Y?=
 =?us-ascii?Q?B8EMF5jdwABr/+S/vKJQ6NHyALyeRjOj/yzpzugvW5x/IkaQEcBRcSJxyzJx?=
 =?us-ascii?Q?AwW1LCfgtk+Y0rO6qXJ9PCcK9l3B49u5oqOMN8Xp5nKWKQ8Bir+y4YkNOp6K?=
 =?us-ascii?Q?4ip8Lg+TPkBEQ0E5zcnRmmIe+smeihNf8MCZHMgePamkOj/fF0iSvtHhvOKE?=
 =?us-ascii?Q?NkZu967P7hhwwfQ7DTsM0Hi9vtWnToQ2LxD2kHnqLK88RVm3kgwygunYEg71?=
 =?us-ascii?Q?liIHbMd59SvWZ9V0foJUJHTeZSHQIvvMzb3Rhrz0XcfGfwI8811Nx+Xenm6r?=
 =?us-ascii?Q?O9xeU4zXojVn4j97mLc2lSpSK2w0HSe6bOL+FuFhcLaZVeJ2CgPeEpgI4Ort?=
 =?us-ascii?Q?kebGtL90BslskQ9OhzDEKnRacZ+wlJ502gMxbQzUsK0NJirENEh//ZvFEoR+?=
 =?us-ascii?Q?FJdxJncJ+VsGH3McFbYAtxjazgHsx8+bN4qr44xqXCvn68EMD7gkh+gKfLMN?=
 =?us-ascii?Q?xEYKYNTo0MAiGi1eYYf23DIvPu4JwBDk+L84JXIUgAVTwUPKh+Mfy46RhdEh?=
 =?us-ascii?Q?hV9gEGhojxT/WcmgpIjuklualWgX0oeZcT8lupxnD5b0WmgdOHiFxrLNwRta?=
 =?us-ascii?Q?EtBPjbEXbD4bjkzGLlIQE2IMy1+GN+3Tuz26arXgXbUKav4muiUO0ir+by8n?=
 =?us-ascii?Q?OQ4scGEGZRQ+LrWOIB5Vs1vZhIIaYPwa6bSBVGQxMCdR8rUVonvnN5YyjIBG?=
 =?us-ascii?Q?trHgyVo4X00RadVqxgs76wN0hndkryCbGq5/dB+yxjNppxBOHgObEmJ1yhi6?=
 =?us-ascii?Q?7W5HQcYlUeP3DQ4zVpqcolcFRtzjQEu/szV0aPiPyjSz+AKEjhkw3oH3/HBc?=
 =?us-ascii?Q?lsLHyJ4Rewg1Ybaean496+b6I0Et/Jmj6BvqGUqT0KVm+5qqZLWS63rhR+gM?=
 =?us-ascii?Q?JE0ogKkpuxS5rvBDdH1JwcuPHWlNSPJDWyGnyXlrUo6N3qeccpiNV3oYbVCR?=
 =?us-ascii?Q?dnveidaZAYahmjcT2uR/io/gqFeOUPUyhSEBR4OTTgAa9sh5XxUSp06B50Hq?=
 =?us-ascii?Q?E/UT8wgDz0QC24VLfu6Cx9YQwm39kQfKqX/LC7+NfdWidZfFcWRy7Li9tFUq?=
 =?us-ascii?Q?A3vJ7c7I8UnUXFFpDgy6Bi6XUU1qpWCd8uyaK1zDM/wFJrAZSLt2JrNnVopO?=
 =?us-ascii?Q?AH+eMz5s5o1Lc4HFKf9aUvy4U0IyMg1Lsu6zTodOL+3WmkrAG7fMziaZGz5f?=
 =?us-ascii?Q?VABsWEsukshVSgVr7++yUe5iTrN9pyFLuEBelWtaGXwDshMtif1Vaa1jslJy?=
 =?us-ascii?Q?gWkXx0ecM5WlCRItd7XuMneb0/apmKqfbmzjFqobr0AuD7XeArMsBe6oz5lq?=
 =?us-ascii?Q?PDRL56emJv0tqwcHZYoRavSeBK9l3TrAe6096E/bHwyyNBj7knag5YwxUheZ?=
 =?us-ascii?Q?Wgb7b5z/oOYO1AR8vIwIDTY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NPogfCtungbQTljpwVrMiKq1n67AMKEt3EW3UI/2gxKgVAcQPDCQkNmQ3ZM89gdYtuJ9ZN8BJuNZhNoyim2y93tMd1u0hI0xyKzqxzDSIRhOn8NTqAQnbvBq7WnWxapsmw/ytr3imXlqHL2zk3gqX7UTmsKOldA1CfH+KH+0VGEif4qqtO81R+DnyvKKEIAl1FvxEn2xOT1n1QMWbvwREzY4vsrajvLRjyJKr4TigMeoP6Gph/to9X5+Z9+CnCJeDmtke8mhfLQINaEl/iX2DFY5+mC/aHvfjdHcLr0l1i08XGfhJJ56nerwneAu0PXmOrK7Dfa5ZO1rlX3HSLqsF18MQAUcCvXXto/7+DCOhWwZGZyG5+4SAgfJePtA2ZsFSun6tRQaxfvPEGr6luuNO0rz+q+WOiMo5BQLwY6aAvJE/Uu+j5FtDX4jZrWWxF7ZDuaosts5Y5mKkR04xhygTODfvgMINwJMQ+tI+7BYl23fWMwRVIyWqIo4BTCSXKjY3E3h2rxq57lPUtJas3PIkdYKy61+qyAPM5kBGUXvn82JsplI1wwAR+tnJ83slLVvEJdKCbP5aasgJ0ry+0kptSRQSeGUdWabv/AZbb6xR78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac2c775-1659-4e7e-8b0c-08dcc0613828
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:11:36.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /53qF6Mz/tphGnHN9ZN526gZE2NDk3D0Q2tP3ANpD6v2EnE+FKSwClhNyyvvRRnhgDozVeCmdv5GfkvfAZkwTUiFyHFirHRFU93XJI9988s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=972 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190101
X-Proofpoint-ORIG-GUID: tPWcdw9JRiSSMmRAHuYTchPCOKTUsQ5w
X-Proofpoint-GUID: tPWcdw9JRiSSMmRAHuYTchPCOKTUsQ5w

Hi everyone,

Apologies for the previous patches which did not include a cover letter.
My wish was to send 3 indepepdent patches but after the initial mistake lets keep
this as a series although they are all independent from themselves.

The changes in this patch series is related to recovering GCC support to
build the selftests.
A few tests and a makefile change have broken the support for GCC in the
last few months.

Looking forward to your comments.

Best regards,
Cupertino

Cupertino Miranda (3):
  selftests/bpf: Disable strict aliasing for verifier_nocsr.c
  selftest/bpf: _GNU_SOURCE redefined in g++
  selftest/bpf: Adapt inline asm operand constraint for GCC support

 tools/testing/selftests/bpf/Makefile                          | 3 ++-
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c | 4 ++--
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.30.2


