Return-Path: <bpf+bounces-51054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22983A2FCBD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A3816536E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D41D432D;
	Mon, 10 Feb 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+Pf7X/b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cs1Xhbds"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB811BC099;
	Mon, 10 Feb 2025 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225721; cv=fail; b=qKbb1N2joSD2j+cFAsSyKoZTMr2FXpyMuLNoMB+A71sDh0Xff4FsEYppRfEUp3fCE7hc1En1ERfZKXVSZmynsE7++x00pAZhvlFaWns5HVALMC0FgTq7PB8vWma8LzkRI5d43cz3fTk0YCS0nSp1zh9C3YZMYG1l8l9OhF9Qyxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225721; c=relaxed/simple;
	bh=p1k8/e6RQY6ml1JuVzPl9CGhIq/pdJ7ELrxzR/c7w1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0AbFuXxTlJ4uqZ/Tuizy3XDsCi+zMP3iJWOQUgWfC346xi+2ACIQI/lMFRrmA5wMNe+NJ7cWsONi2VXfkLQzglm+yTwcA+zgpwl6sVtr+QBCJ8Xn39K5BjW+ICUKKvuKVkpDKxYl2up0qLM2m/0nW4nEGQazPNnrrM48JIxT7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+Pf7X/b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cs1Xhbds; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AKMcTP024151;
	Mon, 10 Feb 2025 22:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=52Hwz/gGqhbDEfrPnTcSLx5QKZ7J/mGbPs34l/4rkh4=; b=
	b+Pf7X/bNNpHu9EE39EBBnqkkmqFc8NcehUglcfoVxjlOSiKOjI46onp+iw8reKL
	VEDYEUkF+veRbT2UYhrdk1/wOSwlQutD2IV5aGjADPfJMZs24zN6OvNtWktMzHSI
	2ApfFmqNqRSD5Ahk6l2IQwSHUD020s6l9IZtZebxYysVmtpodFXgaHugyRwCHbja
	cokjmozOhFHgSlxE1Qbujek0yGwMzzLh8K08CRVVUxTrUhikOqwtolCDDvAOASky
	3x0RpOL94WT7eAVt7XlO5QVJ8nYQ6x/+TBFbyk7aT1c/ZCRXkGGPPbX0DBShxRfd
	GVvHns7TznN8rK5eUiEdGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qym3s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:15:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ALPJFx002665;
	Mon, 10 Feb 2025 22:15:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq81a83-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9tuw889UhGBreBs+x8VcQB1kUCoS3NBR3/toJLlBEFpW/PiPOI6+J7r/EXBYn2mQNVRURJvaWb0T9NwrjHLD6pSjnSxXjZpppLv702olenIEkDTyHoM/GlGuhsTg2N0e72X+zNSOW6TgmzP+Ay9KNh6Kelacg/Cn48PlFENxn5Mfj1oFM0w51i6wgtAH2rJlYiE9bHRRXXNkO3Uw8IVnPPgx09jsItHDwhRstJk6R8bFKoH9Xi3HrMzXAzI2FDIrQkgVYbyFmve1LiyMRJCA04r+18AcHK/QMMwRgqUGAv+SsX+v1YV5zq4/BpYVexihkvfpTckLN+als44anZL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Hwz/gGqhbDEfrPnTcSLx5QKZ7J/mGbPs34l/4rkh4=;
 b=aVU0doDGvsYU2+2qng3OpHk68iEKbeUbd0YIh+cKlefY5MksEmsghENoJ5RKKG6DycFAkBEKUidr0gd9a6lyYmRiknEfW/qEvv+K/3SdvJ8rlczo+++5DI5txpUq9fbHm/vzx3gtVFx5tv0vCJNr3PVocQlwB865pmkax+pjUnekfnXTYt5keOp/J+4JXMLxEMxrxcbYsvgOy1aLJ2xWgm7XeDISDTEwOgyhJCjfn03p+KBI2YhEL42nljJOFuxuF0IxNhRPCNjPbUrx3MGBloJwwyyr7ffVmqNAonWfY+sbwvd8QqjcEpN3SnbsXk9X8z1QDG1+JnUJu+ZTuj74/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Hwz/gGqhbDEfrPnTcSLx5QKZ7J/mGbPs34l/4rkh4=;
 b=Cs1XhbdsiS7y7LTTYXVyaPGtu+Tddz7yYUK/ixjOq6exiN2aHaHE+n6vxq4OrfhDAdganmms4LUzow7nBl4u/dOM4ltQJ/ZyF9YTO4Uf6/2CW/D46TZiwD5iU9kDNePubFRUWPnocqxXwntY9MVBuHyAB+MO7GygUW+rZG0lyBs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 22:15:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 22:15:08 +0000
Message-ID: <a1b4d24b-9d7b-464c-8055-f8a270082e65@oracle.com>
Date: Mon, 10 Feb 2025 22:13:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/3] pahole: introduce --btf_feature=attributes
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
 <20250207021442.155703-4-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250207021442.155703-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a9cc26-3ba2-4f2f-13bc-08dd4a2060df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzEyNXZGaWFzWC9TWVBuQjNqZ0xQanU3VFNhSmJMRVhnbG1YZ0JJTzdUWTJT?=
 =?utf-8?B?Tzd1WXhRcEtEcEx3Y3loSzNNMjJUSTZUMWhQaWRjdFpTc2xIenU1ZjQ4ZWhD?=
 =?utf-8?B?T05hRkEwYk0rS0x3Q0diOGJ0WVo2TSt5T0tRK3hpUzh3KzVxUEZnQ0FFeG5V?=
 =?utf-8?B?SFFyTXIyWGVRMnZqRU1OcmZmclRrSlB0R3RHRmFZR3lnZURjUzdJN1pibG01?=
 =?utf-8?B?Tm1ucHJ5R28xNC9ZbDZMeEljZ01NdnFUOWxOYUJNcFhnMHhlNzhLTVYzQWpk?=
 =?utf-8?B?UUZHT09pakFwSUVJMHdoZ2VWUlArMFY0d3JmdDdNbGxmbkZ2L2MxWlhWUVdt?=
 =?utf-8?B?cFdJNGNSbGNDVHFPckxqQ0FKbUV5S2ZWMFhIZkkzLysxYTNFdW80SnFEYjF1?=
 =?utf-8?B?TkRVSHg3dVpaRklNSVh4bjgvNHBXcHVvbWlmTTBYendUL0twWVQxUHNwOW9t?=
 =?utf-8?B?M3NwWUxEVk11dS9OdEllWW9jUFNhZmpJSU5RcGMyUGpIVHY0eTR2WHZJTG9Y?=
 =?utf-8?B?ZmR0OHRFYmRCbmpEaEF4Rk50eE9Iem1iTWRZV3RJVFBFVkFXTmk5OGhiNWFP?=
 =?utf-8?B?cUh1cFNaUUd2U0ZuQ3ljK3ppOWlaTkNTM1Fnb3c2LzRjcnlIQ2hxZDluRE5Y?=
 =?utf-8?B?SWF4OFhxTk5FbzlmZG9VemlEaDh5UkZ0NVA3dGZnSFVkOEZrVVVTTkJ1SkY0?=
 =?utf-8?B?b21rVHgrbjAyZFRXenptR2wxaFFaMnR1YXU2ZzdGRnRRS0xvMGFmYWQvVkpD?=
 =?utf-8?B?Tzd5dGRsNzFOWVRjeHZ0N0V5d1ZCOGtUeXV4aDJIOER3NGdTL1pzdDdWdCti?=
 =?utf-8?B?VWFXTGN1cXFjeU8wMWZIc21HTTRnWFdONVRVSWNBWnRMMlErM0t6ZHp2MS9U?=
 =?utf-8?B?K1NxNXk1RGlCZ2dBR3VrdmdnOXZsUTIzNFAwa2dYb0QvcS9SaWV3VFVTNGdj?=
 =?utf-8?B?a00vUXNnOGFaODROdmd1YjZudjVmd3FKdVRiQ3hweUtNVDRxVTdINUxqQ2ds?=
 =?utf-8?B?RjRrVjVocWhqd1NaaDFMM2FyMW1MMVE5Qm8raXFicmdEZGE1TFhIOHRlbFBO?=
 =?utf-8?B?azNoMi9pVWlsWDFXdS9xdFVoTmFDSUFXZlAwU25wc2g4WVJYSWJDN2ptOTBD?=
 =?utf-8?B?Mk93RTg1ekhldWxOUEVLMW9sMjVPV1p1UGduU0hRSThpQ0pQOG55NzliZFJG?=
 =?utf-8?B?UlpCelZ6U2xsR2pvVVE4QUNJQXEvUldMZXBweDUxb0RidHR6b3RRUTFoNCtI?=
 =?utf-8?B?cHovRndST0RxRjk2VTZlbFg4SDh0Z2NuWm9pUkJtQTQxT04reEpaYjdFN0Iz?=
 =?utf-8?B?dWIrQzRIQ20rUEZLYTgydGYwYUhpbDU5YW1FeW4vclhvQ25iSHBsNWRmQUcw?=
 =?utf-8?B?YkFMbHJ6UE8rTlk5S20xM2VkZG55U2JPaHFXTWZxZ0VJencwekxrVXZabll3?=
 =?utf-8?B?K0w1N1BxSURGSE5vVGVqdDlxa1RGbUVKN08rR1FDOGxudUtGY1Y1SUJCZSsx?=
 =?utf-8?B?VnVFWVVBemd2UGhqRTBmR0NUOVdKbCtBUFlQVTZjUFhVNjhnKzR5RDYxdGxv?=
 =?utf-8?B?MlZubjBSNkJXQTJlRUEzWDFmYm50S09Dd2ZLRUpTaDcwNlc5RHVlbnhsZ0FQ?=
 =?utf-8?B?R2Z3c2s1N3F2ZmJ1K0g5ZEpRdG1CMnFsWTZia0pOZTI5VEp2R1FwWXY0cHlD?=
 =?utf-8?B?V3lJem1wbUVsNHBWYW40VFg0a1JreGNVeFZjZXBRd09DNW1QOTVoQmpKUnRj?=
 =?utf-8?B?R3BvSm1jekY5MUNNa2FQaS9kM2NiM0lmcGE4R2dleHlNN1JjZm9tbUdsRW9N?=
 =?utf-8?B?Z3N3a1VjYnhjd2tiM040K1QrMHVsQThPZmJ4SmRjOGxncTJZVkduUkZuVUNN?=
 =?utf-8?Q?69aAFDxITYm//?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzJ5cFN6N0tQRkpCM2NqU0F3N1RQd0RXYmJXeUZUMVN2S2JPVjVQeUQ0Rnpj?=
 =?utf-8?B?NmJJanhqaks4d2NtbjRXVFVBUC9ZUllIbEZkdzFEZmUwVlhJUGVqSWhUNUpn?=
 =?utf-8?B?MFVhNkpGZi9SYm81KzlhaS9hVFBCaW5HUUR4VjAvdnFsMFcydE5pSUoveHB5?=
 =?utf-8?B?TWJSNTFZaUdKWjVKcWRyREgrb082YTlSVlpNdnRsQnZySFJjMEZZUkMxUzQ5?=
 =?utf-8?B?bzJkbDJGT0hrWFp1MGxYaFd0Q2xMNW01MVJPSDM5WHNDS2hFVTlCYUMyVFFw?=
 =?utf-8?B?amNUT29zcmFoa2NSdHlVRTUrVDh5eFZZRldjTFJKYTNNTFB0WEIyWFA3d1Y4?=
 =?utf-8?B?SDl3K3hRRFI1MDlHZkpZdU45MWhCVkcvbnNZZHdkd3pXZndGRWpEK3lLZ3FO?=
 =?utf-8?B?eHdqOERmWnl2ZXZYdndGa1AxdCtlRmZCR2E4a0FuWnl4bzl1ZXBuenRQUEpS?=
 =?utf-8?B?UFEyRHlGZThsRHRmbTQzZUhTTjJFNDFuMlhmR293QWs2bVlxaVhOTlF6VjBV?=
 =?utf-8?B?VFFrZE5ucHlJYkJibGtrUEZtWGdrS2p6ZEl5b3JBV0FqSW1veW1DdnJuN3dn?=
 =?utf-8?B?VksvZVlUVDhUdEI3dWNpTzNCQlFZMVZtcGsxYjV3UU1zM0dUMGRaS1hHSDJm?=
 =?utf-8?B?TW14RUs0b29MUTdlbW9seHRPS1p5b3dsczJoWS80cU9peTFFMnpjUnlBQnlS?=
 =?utf-8?B?NUdvYWZpMGd1aU9udklraThZaVpRN3pBRUc1MnNpdkE5bkdPREVrWTVGSG9I?=
 =?utf-8?B?bDVOcFkwUjlBWEJ3UFVueUltQ003STRNRFIrb1FyckxrRkd5cG9kSlhVWEE4?=
 =?utf-8?B?L1I1RC9ZUURTczJteWNEaHUwS0dLbnV2eDlWSmlCeGdpWEdpR3p3VVFOU2Zt?=
 =?utf-8?B?Nk1oRThHMTdiRkNEdVh4NHI3SkxtT2t4MnF0ck1GQkVaRitRTnl3ZG9EdldV?=
 =?utf-8?B?aTVvd01jM3BDWWZRQWxwOUdWTTdkUTlPdFpUenZ1SmpYdGRwcHpWL0ZFZ1kx?=
 =?utf-8?B?UXFjcTdWZFFRMHFHQk15RkZKRDFNMzM4RWZGLzd4cUp1b3pJQ3JndDBmNTdT?=
 =?utf-8?B?ZWlRUlBtZ3NvY3NuMFZqa0VMR1NoRTlyOEpHajJvbVo0dWt3MHhCNlBDRWtM?=
 =?utf-8?B?SVFOMWdWeGtsUU5rcmd5VWMrQncrMTArY3pMemRSeXFSVklFdE9iUVkzWEZu?=
 =?utf-8?B?dHAwV08xd3FZZTlRSW9kV214TW1BcDl4NWR5d2JaOEx2dld3bmVKaW5nY1hi?=
 =?utf-8?B?M0hLTTIyL0RwTGpEN01FT1BtYzFXS1BUbUttcHpEcnUyWmlUVlhJanVZY2R0?=
 =?utf-8?B?Z21uYUYzWVZUNVJmbmxJQjltM2JqSjIwU2xEdDNuY0ZZYk44NUV3NGludzZM?=
 =?utf-8?B?Ui9XcVhzbWpqbGNVeWtxbUtWTE5vVUdoZlZTbnlsbUNTdTl6WUc3Y2hvZGx5?=
 =?utf-8?B?R1NmUlUvQ0tuZEdpTHdtUjQ4U3FkaTRpemQ0Wjltc3A4dHBDZ21sSEM2Qngr?=
 =?utf-8?B?akMzK3lTMXUzTzEzbVJpbE4rSlV2eXdPYk9HMmdRSU1takxlcHduS1ZxcUhR?=
 =?utf-8?B?a0FzN1VURWtGYkNPOFAyRnFVdFB2ZTZwUXozUVNjTE04MlhMKzVlUThMOHkv?=
 =?utf-8?B?QkphaFhuWnZFckc2ZFV5cmd4Rmh3YWJ5T3hlQmZRVnVhOFBNcTkzb3pWN1Bz?=
 =?utf-8?B?TkJRNW9kd244OVFRRjh6RXpjVWcxWDRwMitQVXp5c0FDbnZ6a3RnaERGVGQv?=
 =?utf-8?B?REJMeitsRk14bVdnTVBzZEZkYVlqQmh0S2pvc0NadmlqZlRLVExpcW5iMjcr?=
 =?utf-8?B?MVY4UnN4blZWdktLWVk1b1FaNWJBME1icndkd0FwKzVZRVJFMnpmQVkxMmZ0?=
 =?utf-8?B?bmp4R2lCdTdwSmFpcUxTdkFka2pRWDdsUXRzcDJsWWRrYXcvRFlGLzZJTXN4?=
 =?utf-8?B?a1RXcFFQSjJxS3BOcFpMY054NjJReXIzVFNGaWJ0WFFpdThFQjlWejZkZGJu?=
 =?utf-8?B?NlA0Y2hyTnBybXR3SjRROFJ3RHZSMWZYanI2dVI2bXh1V1h3YXpYeDNCMjEy?=
 =?utf-8?B?VFdFby9TbHNFWnJsUmxRaVd6KzhSbHdORXlIeGo2OWJubFltWGVYSGRsdWZm?=
 =?utf-8?B?TEtsaXFMS2l1eFJMVEJCVmJ3S0hQb3NuWXg5RGN3ajVNMWlRTmZkUHk0K21K?=
 =?utf-8?B?UzIrWmhzN3F1MHo2cWphcHpTLy9ENmpaTnlPWldieVcwN3diaHlqUjI5Y3Jm?=
 =?utf-8?B?ODNyK0h1WGJWRy9vYmRmY2s2Zmd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vpCA+VzFFROSNPungb5YyYF7zgzUXzI6ZadOukyp8AeqDrtleKkskIw3+KFgnhh3MhN0Ka7PhKcVC2Iu5ta2hTmYULRa6UzVAy/pKfxiH9Gi/JIMz+M9RgRE8gpEqGhS495zKBxK9mOeF8mua2Ww/OYXj/8OQgVhx3/abYGfnwpG+J0vqxO7ZDsPQe8TNws/vgvGLno5loSLA7tqKuUY6R70uChOriXHK0YNopeDbu3kU7GQSVAVlBR0vffcYmQIKfoEJz/8fsThYFw6D+T1/uu1yV+9SD01NxecgGJDeH1+VsI9izB1Q0bU8wcf5Z3CgQtfbm0OZlAEBf60C6nbyIZX6hbHt8wnyHrsA2LBSypYBqNnBHblaL+h43SuE+1E5f4OY94ZCucSdrSzJPhSFnF1Pa4wSNVEtjShIxG94quTVHdSToLC3Ax8fYsD36JoGJY9Q+/j0VreJsUZciOpggsxzbbwi+tOzDYs1qk7vtAzlVrbVAKNWW3vNwIsC5IzIL4sMvh/4KNQywC40CF8jlKdJfLs+bkXSJyVddRzlcjZovLmQ9m56jQw+CWdGxx2k/Xg32x6GCAlFjs2VZw0CpzfUXLamJ701RDNu5O9yIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a9cc26-3ba2-4f2f-13bc-08dd4a2060df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 22:15:08.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsKIRFSjSUSfqZzPmwH/v/vRjGduEZNbbjPIm/rH0Ex4xm8MtcdZZ9FNOHhdEBU2ARAg9jt7UT0Aq1VoD/AjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_11,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100175
X-Proofpoint-ORIG-GUID: rfpRYNHLY9GMorGGpiY3VtMZ4fQy67X_
X-Proofpoint-GUID: rfpRYNHLY9GMorGGpiY3VtMZ4fQy67X_

On 07/02/2025 02:14, Ihor Solodrai wrote:
> Add a feature flag "attributes" (default: false) controlling whether
> pahole is allowed to generate BTF attributes: type tags and decl tags
> with kind_flag = 1.
> 
> This is necessary for backward compatibility, as BPF verifier does not
> recognize tags with kind_flag = 1 prior to (at least) 6.14-rc1 [1].
> 
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Needs update to pahole man page describing the new "attributes"
btf_feature, but aside from that LGTM.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c |  6 ++++--
>  dwarves.h     |  1 +
>  pahole.c      | 11 +++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d7837c2..0a734d4 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -142,7 +142,8 @@ struct btf_encoder {
>  			  gen_floats,
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
> -			  gen_distilled_base;
> +			  gen_distilled_base,
> +			  encode_attributes;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
> @@ -800,7 +801,7 @@ static int btf_encoder__add_bpf_arena_type_tags(struct btf_encoder *encoder, str
>  	int ret_type_id;
>  	int err = 0;
>  
> -	if (!state || !state->elf || !state->elf->kfunc)
> +	if (!encoder->encode_attributes || !state || !state->elf || !state->elf->kfunc)
>  		goto out;
>  
>  	kfunc = btf_encoder__kfunc_by_name(encoder, state->elf->name);
> @@ -2553,6 +2554,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> +		encoder->encode_attributes = conf_load->btf_attributes;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index 8234e1a..99ed783 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -89,6 +89,7 @@ struct conf_load {
>  	bool			reproducible_build;
>  	bool			btf_decl_tag_kfuncs;
>  	bool			btf_gen_distilled_base;
> +	bool			btf_attributes;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index af3e1cf..0bda249 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1152,6 +1152,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARG_padding_ge		   347
>  #define ARG_padding		   348
>  #define ARGP_with_embedded_flexible_array 349
> +#define ARGP_btf_attributes	   350
>  
>  /* --btf_features=feature1[,feature2,..] allows us to specify
>   * a list of requested BTF features or "default" to enable all default
> @@ -1210,6 +1211,9 @@ struct btf_feature {
>  	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
>  #endif
>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
> +#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
> +	BTF_NON_DEFAULT_FEATURE(attributes, btf_attributes, false),
> +#endif
>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024
> @@ -1785,6 +1789,11 @@ static const struct argp_option pahole__options[] = {
>  		.key = ARGP_running_kernel_vmlinux,
>  		.doc = "Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes)"
>  	},
> +	{
> +		.name = "btf_attributes",
> +		.key  = ARGP_btf_attributes,
> +		.doc  = "Allow generation of attributes in BTF. Attributes are the type tags and decl tags with the kind_flag set to 1.",
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -1979,6 +1988,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		show_supported_btf_features(stdout);	exit(0);
>  	case ARGP_btf_features_strict:
>  		parse_btf_features(arg, true);		break;
> +	case ARGP_btf_attributes:
> +		conf_load.btf_attributes = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}


