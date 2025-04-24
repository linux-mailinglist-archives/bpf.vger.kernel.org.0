Return-Path: <bpf+bounces-56632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD08A9B5F8
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074C0178241
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623B28E614;
	Thu, 24 Apr 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BzoKXnUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DSlD356j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F3190664;
	Thu, 24 Apr 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518087; cv=fail; b=QvAk7Ybkf7Nc5CUvYXTsWzhR6RQvCFCW9ZW29RAbEm9Y02+mdfO/YPpXE+GJJLytxx9gOtS1KXdIjvII0TKPKGw0p3xUEcdhzSTRg+/7rjTZYB7NpqkYbzXhTmYtML8gqxcSSHCeLUFCozgjx3kaYkRgQg4zNc/HxufpVEWHBNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518087; c=relaxed/simple;
	bh=FV9kMI9zba8PQDQLfkBW/4+HUAptjen1NJ9PS6RMOzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FdgtT0jOTtPU8LTiKHxCl+Wgoq1O/ePyy5vr4r0y//eTp+WlAzXsdmBvL5IFITaTOeFZQvloej4DL6ha9xG+jViPovRK3Gync7NN2QAY2+Fht2F79dzacZNuVF42Ts3lIafCZVabO8f+MrydIDyquhD0hvS/Ej4cfKcysnubKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BzoKXnUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DSlD356j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OGlaKW029635;
	Thu, 24 Apr 2025 18:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vT6tp7KegoGzi6RjP7AAlUIC3TrNtXH1ClZk9OSCPrU=; b=
	BzoKXnUxKIT1W3xlvwLps80oiO7cMbrBhwXHuIpdnyAXQ3ukJtTEEsqPPSTqBrqm
	TGMPp7GrZitVl+bJZ1o5IQU2s4Ik2ck23Kb0mDidPSeU6vNlaMYBEpgk/QSdWPq7
	V4GOM1ed3UZFepSaJCTeV1vURkKJQENQW6eJu4gGGB9TTMO4qrSPPKhAZHLb6rPh
	23OiKN+x8CcR0ColN9kXY4tXYBc06upRAHpoQaw/bij9ydtix63/OEFLWViqcjm5
	PoP+/Ut1mv5dcB72JgM2g0PcFyaD4u/aWK3Q9aoINpxs1PDFUmroNH3PLRiOrY/Q
	HThsr1VN8op16huho6pukw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467s4a8asw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:07:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OH3af9024802;
	Thu, 24 Apr 2025 18:07:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pubsyk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEaKgzDp0gkP+dfJJ+QxfAPLgJ0cqZXwOjpOkCGNTKNRYoJsaVuSPPF3rPNp2aavLwjQdiHh6VqpbmZ1E3Mf4SpwLmuOy11Htu8vqQmiiy8bIds7yGjVBGGel4lY6l/aj+zj21gyp//5v6I/wOrmIw/8qE97MU/Ozxupiw+/N/vmndgmVnM4zmqjCL6K/9Mu2gXM/9lw8CfevczGT6JmYt76ZEnLaTpG2WyGqcws6FuPcsaGU3z0mnCWSTJjqWhrJD0UmQX75tZN6geAyiRdxLGplsguGGimZ9GqA0X+jdh+juCvWTzUYEcQ35l8+Ta395nJUckLgLLcPIpPmlBZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT6tp7KegoGzi6RjP7AAlUIC3TrNtXH1ClZk9OSCPrU=;
 b=KTl1CxUPtUw8Bx+dodQ8kPrNAHZHf4B42WlIqTCpy7Jb7mEuuPSCObIIC4CyFUcCMn4kReLaCOXHHemfUFmOJlDYBV8KfJIFmKKu9HLTbveTlmwl6jve5x3n9F+L+Q84xQkt7c0RmTw8O+zmdvPLt6FF+3ezNO8P1bxcZxFn/L8440HH1So2YMpEeSAOKKR0rCsZMxG4Mqw+pa9RitZrDUossDxXvsMlJ6xnVqZgkzhTAfWQvOIc9WRwoJRxu6XeXU4RbBkoeVf+Gn/+DbwNcUxRkNUI0h1+sSw/A/SkdzCpyqsa3HckJDDsNiKC5+rhVaNz5yPPfqVjOXbtybmBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT6tp7KegoGzi6RjP7AAlUIC3TrNtXH1ClZk9OSCPrU=;
 b=DSlD356jw8QFcPy5LkOX1nAvgddPkMTAwtwHLbjFBIQ0E6doUG6YZrRH0zt0XG2WhyCDwP17vgLh3DgxAq77i4D/L2MN5HlYGPOMbZMWC5RU66rkk/S0i+SSR7sNR7/YcoNT/DuQEgJAoaqhalkOhLukQLzGLn5Llk8YBrStL2Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Thu, 24 Apr
 2025 18:07:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 18:07:48 +0000
Message-ID: <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
Date: Thu, 24 Apr 2025 19:07:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
 DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
 115a4a9!
To: Paul Menzel <pmenzel@molgen.mpg.de>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0170.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: ceefd138-36c5-4d26-237b-08dd835aebf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUtpMW5lYUFOZEhkdis1RE8zYS92aDQrV1VkM0dDeVpmYkplZSsvbXd4UTV2?=
 =?utf-8?B?RjJhd3hXTm4vVXZrOUZMeUVHd0tYa2VaOUIxRjFJM3VNVVNQUytrQXRycWhx?=
 =?utf-8?B?c1djd1dXbmlINGxKSFJCQTlHcDRjMzhobiszdDJZMnYrekpEZ2FnYmNTa1ls?=
 =?utf-8?B?ZHM4eEFKL2w1WGhSYnBMeG1xYWhvNlJFTkd4ZVdEZUYyZXNOb253Z0o1Y2c2?=
 =?utf-8?B?eGpTTlZJUjJhVHpVaEVORG0yRklsMHFmMTMyOGlxWm9nc0NiL3RSNGp0ajFH?=
 =?utf-8?B?MTYyL3VNM2I5N1B4RHVEU0hqQm5IRVJOcDVXdkVDR0NYUUNQRkR5NVhoZFda?=
 =?utf-8?B?MkJvZ1U5bDhFY2x6cGpEa3dhY0lXSW90SmkxSlJqVDZLVWFPeTdZRmxYaVRR?=
 =?utf-8?B?U0lyZC9KTjA1LzQ3anlUYTlCemlGRGJKZVYwRkV2aWttZzF2d09PWkdWZU1v?=
 =?utf-8?B?eCtDbkx1VDJ6SVZ5SnNpWVhNcDlFYXAxZVgzY09zaG1pZ3h0eW9NaFFSN0d0?=
 =?utf-8?B?VTI4dmx3SWpDaUFzcEtkVDdpbWhLV05yYmNLYUdaSmdZdkltUXRsZEdsRjVH?=
 =?utf-8?B?YzU3ODdrYkFMS3FHZDdsUU5Db3haMjBDQjZWYzJJbzBOSXd0dDFlMjVMa202?=
 =?utf-8?B?N200VWRUOG5peGtDTEJHaTVuZVVLNklzUHh5K25DUm5sMXQwRXVvdUxZaWlo?=
 =?utf-8?B?d2NSZlBqcllHV1dmM3JVa3pCWXkvWWxxbk83Ymg1Ui9IeTlPUlU0SVRDWGRW?=
 =?utf-8?B?T21BaHBuQUR3ZFFaSXp3L1d0T2VFY0ZRWjViSkg1T09jMXJYaGRHWnUrVzVk?=
 =?utf-8?B?eE5Ybm9iTjNPT2pZOXNuVnBxMi95V1dxNU52QWN5WEk4UmM0a2xlSHFhUkUv?=
 =?utf-8?B?YVZyT2wxcGYvb1hLdnpzdnJTWjE2VU1iWTRibm5idmQvZ2FpaU0zVWkwWUZJ?=
 =?utf-8?B?WE40WUkxdkE5WHoyb1lRMi9oWHNVL2NxellrTVdQVE5mWDB0L1JyYVZ0WXVz?=
 =?utf-8?B?UnhlMFlCajlqUGx0TE5TSEdneDd0Q3BRbys4TC9aZW9pak5zZ012N1VrdVQy?=
 =?utf-8?B?L2tFSVI5cGFFRVc1VFNNVE41ckxpemVVdU41clFvclUwNkVZWi8zRHBDSGNx?=
 =?utf-8?B?RGoxSjNGeWlIWWNnVFlranp4c1BVcml6YUZiOUxTOElDTklYeGd2b2pKWUhp?=
 =?utf-8?B?ZkxWVmVoRzZCZmVhM0NVbXlrL25JZkNnVFpUeGU2U3d5amJhSmlFS2RPOFBq?=
 =?utf-8?B?Rk9RVHhyczdxMzlyWDNjVmYySFRHemtUYTVRYmR4V0NiRTRxeHliZm1TNEpT?=
 =?utf-8?B?TVA2MEg4YjVMcVQzZ0RZeUd6Y0M5M29mbnNmSHFyQndpcWxOU1lsTjdQdG40?=
 =?utf-8?B?Zk5NRDNsYmpnTUR0OHg4QXdjeXgzU1J3MG5PZG9jNEFUMUJQZEpqcFlNNjlF?=
 =?utf-8?B?RzkvMlZZM1kvR05td2FLcEdOZC9tZk1sRlhXN2kxdk1xZHFPcjU1SGQxVUFR?=
 =?utf-8?B?ZnpvS1pXaWM2MHVWbnNoZGsvaUtodVVHbWZIbTBwY2ErTWZpZVpwTnJvOXdi?=
 =?utf-8?B?cjhxVFUycjZBZWt2WDBYWUR0eWRaVjkzNWY2S1VDU2tyeGNPS1hzeW9yTGlX?=
 =?utf-8?B?Y1RPTXpQcnZFMXZtQ1FlalpIa2lVZGNaT0VDY0dvN1BaQlBkWnduT0NFRlE4?=
 =?utf-8?B?TExUK0ltK2JtanI4ait2NEQrMCtGUVZ2OTZQU1Nkekw1UXdzeUhWaFVXRHYy?=
 =?utf-8?B?aVBKNlVuMXFKRU52LytyeGF1b0phblZ0MjJ3dFFITnpxTW91VnVTZ1RWL2tX?=
 =?utf-8?B?bERNOXoyL1FMTmVtcUlYSy81R3ZYaFk3Ujk3K0RUZGp5UlNIRTdDdUVKMXJE?=
 =?utf-8?B?ZGdwaVdpU1dKc0c1S0tOejRKWEtBVElzcXhPTDJSNFp0VFZBQ0wrcXc0cTd1?=
 =?utf-8?Q?6unxaoHfml8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T09EUk9SS3ByZUdaSFNKWkZlMkJITE10YzVTbXp4bVBpRDNwMjUzVGtHSmxt?=
 =?utf-8?B?WW1NWU0vRGJTYkt2cGMwaDVnd3lSOUh5MkNXR2wzc254cVJKTnZ3VmtPZEhK?=
 =?utf-8?B?TG5NTjdNT3R4Y3JoK2k5Q28rMmRqTTRqOXN1MHEvMHduaEtHbFFyV2JBVHVB?=
 =?utf-8?B?MXhFd3BMYWZ4MUJtTjBGRXBLM1ViRmIxYzY4clBtNFQwY1dObW8vd0ZZZFBB?=
 =?utf-8?B?VzZMNUxTYk1GcUhtTzloVnNsNEZ0K0x6YTc5V1h5Vkx0U2U4ZlBPbkQwamEx?=
 =?utf-8?B?R1dmOWI5L1RPNDFkMDR2d0hWaGlXOEdLUExpbTlVNUxYTGZ3MlJVdWhnSjA2?=
 =?utf-8?B?cG1zVFpVTlA5OHBHN015Y1IxTEtoT21VS2ZXVVJPcE8xLy9MYklyY0tqZzhW?=
 =?utf-8?B?R29iWkhCNDVRaWQyTHQrSStsait0amc1ZVJCNGIrTVV6WWxxeDlnMU5VNDJL?=
 =?utf-8?B?QUdPREZDRE1LZ0lweThsalBjdHRRdzl0RDJ5eGphRWEyd2t0ZEdXRFl5WFhk?=
 =?utf-8?B?Z2dIWHdPNjhaL2RIVllXVUtGdjFYM1RXcXlzN1JTL3RxQlU3dHhDTFVnZk5V?=
 =?utf-8?B?ZExLeHRRLysrUVBvV1VFTXk4OWZWYVFuazZ4UWRqeGJIejlVQW16dTJ1Nllo?=
 =?utf-8?B?dVAybWlQYkxQb1FtMDhrdnZtYU03Z3lTbC8zbjVjOGdrc21BOVRhejFqUFhH?=
 =?utf-8?B?RVBtN2xKdENqdGdmV1lkVUVIWmRab2NoTWx6TGd6UloyZ2pLWWNkZStBSFp2?=
 =?utf-8?B?a0ZIbE5zTWFuRElVOUhFZkpSNmhGNFBXZDAyMVVPZWtpNEFycW9wK0Z5Rkt2?=
 =?utf-8?B?TE5xMTFWVkVPYXdFTE1hTEltN09FSEtuTnZ4WWxiNTVXemNQUDRHQXdBL0pr?=
 =?utf-8?B?VWkzeE8yTmM4bTF5NWhJanNTTDZPRHZTTUQySUtGWHp5ZThhS3RrenBkcmxP?=
 =?utf-8?B?eGRyOVQ1RlZML05VdGxidlhiK1FKTDNNcVd0a3hmdk96dVpYNktxNjAvZ2Zi?=
 =?utf-8?B?YjlvN1VEZzFocnExYVozWVZWR0tGajdXeHl5SEU4Rlh0bXV3bkhIMnJpeHFk?=
 =?utf-8?B?QlFXaW56S2FqbWV1VW9lYi9sUzd2bXJVNmJiTjVQZkZUaFdXWFRpMVBNU2NU?=
 =?utf-8?B?MFQrV3NWd2NBQW8veC9yT2RQMTdwalcrMkx4aHJzYm9TemtINjhJYWsyNFgy?=
 =?utf-8?B?Umc0L3U1U3JIS3BFUXJ3elZLNzRYMWtiSFk5NC9QVW81ZlZEYjRhYmpUa0Ji?=
 =?utf-8?B?cWlqLzZpaEN2OERGY2QwMEwxNjVQQWJNUlk0WjJmdlp3ZThlVm5uOWJTOUI0?=
 =?utf-8?B?dXgzRkd6cDJJWjFDM1M4Yk5ETy9leXlGY1pweGwza0lLY2kwU3lzbk1kRXRi?=
 =?utf-8?B?UWdrMUtXc2hNZUVOc1RYd2ttUG50dE9NZVpIcm4xeExmcitQSkczT2UxWnJx?=
 =?utf-8?B?NEZRNFY5L2diZ1VXbEpZS1RzdUd3SzZQTXM2ZEljTFIrRzNpbEk3MzAvQ2NH?=
 =?utf-8?B?aUdwRHRqb2ZqTkZ3aXIrem1ybk0vYWV5TW15ZHo1cHRBRUZrUWdKOXUzQURr?=
 =?utf-8?B?TUxWMjJkYlpEaUJHWXRLTUpvdkFNNkM0UERqWFB6YlJqTUVuR3hkWjgzL0ky?=
 =?utf-8?B?R2R2TWowRDFxOTVORDg1NXNockJtaS80N25MWHBuTlFrZFNVYWM4RjVOVFpy?=
 =?utf-8?B?Vy92Rk1IblpzU1hWVUp4ZTQ3QVdEb1pJNmtkalR5bXpScCtSQmt5VFh6bXp6?=
 =?utf-8?B?cWJCb1g2cDEvQit2NWg4Ti85bk5kM2lIUlpWajYyMnpOME5EY05XUTZjVjFM?=
 =?utf-8?B?a3RRL1dBaXNXUXY0anZKMUc1VUhuaURkOWVlVDBqbmh2MWdSKzh3cXNKY2RV?=
 =?utf-8?B?b3FORWl1R002NTBhNVgrSDZZcWptVytTc2tZUWpZN0FUT3duN1I4eDkyaVQx?=
 =?utf-8?B?SUh3N0R0eGNWYldDUFdieUFWNVZUSkphR245WFQwSVNGakVLdUlOUGozdlNR?=
 =?utf-8?B?MGdhdEdpUW4xR3pjdHcwZkppN0NtSVA5ekdROE9XZUFldmhoc2RpUVFnU2RP?=
 =?utf-8?B?Q2VRakIxOUFrcWhkWktxSTVHUWlzU2htZTA4Y0lDdDlrSGZtS1YzNldPQjV3?=
 =?utf-8?B?QkFxU2JzOXRYa0NQWkZtVno2dFVJV3UyMk1TMXROZFR6WGVmUlpaM3BKZTQr?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5jWPVxO+fZFYeyHyueKe0b3m37m4KAzoAoIcYtG27FV38ig2Raet5JrUrNQCdlUU89rQGV4+lBGtBP1ifZ2sHy/E7zjGFJ89Nb33tAPjfYlWc0mYzhhdnn87WW9Y9w3RPKum7TMNu7LsVXzAuSJPnn45CONsXXXVH65GtFZ+gG9s5YGDOLc+vXNBlyQcVsOacXf4aKZz66v+2q0xCI/M1nvhD0zWT8omGL3JG1dkp+vHTD91Ca3QJ1uhqESU46yFW0qNgBnhfBHqIEKz1w9SVdXMgBUuVe3KelkzIIRRpoHQs+Boil7NbrgbjtBRbRMAkJXsT1Npz+JmI59NRrW3KCa8yEryLF6XXTFCMfH5rafAdVsB4vPQQxonwCKL8+mG55RVqUYY6HRgv2FbmdwnPMo0IXuh0YUvIbu18d7rBe30mOKS0/QDpChzx7REAyV1cCv1/H4XNIEyV0UmpNdq4ywIZ2ACABaywvpUiE/vIoboMGGFxlFBLyPRdB2vHHoBWIBlwQtpGD7E7l3poVQBiDgw0+N5jHqfAiISzryP5CCj3vm27oDnf8KOnBEs+iYKCwbILJ869gmzJxGERrhwhzqXw+GN2tMCpOwV2+Ypw2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceefd138-36c5-4d26-237b-08dd835aebf5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:07:48.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG1q6u09DJimCCb8anvoGBm6/cYrwCGt2bZb+dKzVrXcHqX2llEoroHJE6JLd898Wqv0klX0CWaWY4M0o7WM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240125
X-Proofpoint-ORIG-GUID: qK2Tn4oK3vVyvC_LOEwuvyb-KuZFOTvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEyNSBTYWx0ZWRfXza6NHw1czNeG CUk5+c2VkKjVnlrnTceBOVGlAkxJ1ODkUpp5l4bZ5iLGUCJwsHo/OTthbHS7/20bppOc99wUuD+ lMAdnGjzVpgWYigHORjbHL1ni0kKYh3UXweQEMHEMK1BPAOZwLj9FF4sff7lZm/mplDzl31VlWU
 HGLQuyKDcV97wDst8iuaDPzZICHxQ+h9cBRH9GXpIUsUHHW4vM8/dsnC64phTzT5LrHUbc4BiEr WuKZqUlSwQ1D39boF/HC0HboV2PonwFe1U5xdQ6UkBVdepo35WEsIr/N+Qv0BA7Q8QnsDIS49Pc i7Fgyh9nOtVA45agV7kC5l+QonfE2F91jObmGSb+Bpu1cPO9imr2DrqAaZ7bCU6WKvVnR8XGQkv y54UyaNm
X-Proofpoint-GUID: qK2Tn4oK3vVyvC_LOEwuvyb-KuZFOTvR

On 22/04/2025 14:33, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Trying to build Linux 6.12.23 with BTF and pahole 1.30, I get the build
> failure below:
> 
>     $ more .config
>     […]
>     #
>     # Compile-time checks and compiler options
>     #
>     CONFIG_DEBUG_INFO=y
>     CONFIG_AS_HAS_NON_CONST_ULEB128=y
>     # CONFIG_DEBUG_INFO_NONE is not set
>     # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>     # CONFIG_DEBUG_INFO_DWARF4 is not set
>     CONFIG_DEBUG_INFO_DWARF5=y
>     # CONFIG_DEBUG_INFO_REDUCED is not set
>     CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>     # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>     # CONFIG_DEBUG_INFO_SPLIT is not set
>     CONFIG_DEBUG_INFO_BTF=y
>     CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>     CONFIG_DEBUG_INFO_BTF_MODULES=y
>     # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
>     # CONFIG_GDB_SCRIPTS is not set
>     CONFIG_FRAME_WARN=2048
>     # CONFIG_STRIP_ASM_SYMS is not set
>     # CONFIG_READABLE_ASM is not set
>     # CONFIG_HEADERS_INSTALL is not set
>     # CONFIG_DEBUG_SECTION_MISMATCH is not set
>     CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>     CONFIG_OBJTOOL=y
>     # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>     # end of Compile-time checks and compiler options
>     […]
>     $ make -j100
>     […]
>       LD      .tmp_vmlinux1
>       BTF     .tmp_vmlinux1.btf.o
>     die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
> DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
> 115a4a9!
>     error decoding cu
>     pahole: .tmp_vmlinux1: Invalid argument
>       NM      .tmp_vmlinux1.syms
>       KSYMS   .tmp_vmlinux1.kallsyms.S
>       AS      .tmp_vmlinux1.kallsyms.o
>       LD      .tmp_vmlinux2
>       NM      .tmp_vmlinux2.syms
>       KSYMS   .tmp_vmlinux2.kallsyms.S
>       AS      .tmp_vmlinux2.kallsyms.o
>       LD      vmlinux
>       BTFIDS  vmlinux
>     libbpf: failed to find '.BTF' ELF section in vmlinux
>     FAILED: load BTF from vmlinux: No data available
>     make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>     make[2]: *** Deleting file 'vmlinux'
>     make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>     make: *** [Makefile:224: __sub-make] Error 2
> 
> Help how to get a successful build is much appreciated.
>

hi Paul, I haven't been able to reproduce this one yet with your config;
I tried with bpf-next + gcc-14, then switched to linux stable 6.12y +
gcc 12 as that more closely matched your situation; all works fine for
me. I'll try more precisely matching the gcc 12 version; things worked
fine with pahole v.130 + gcc 12.2.1; from your config looks like you
have gcc 12.3.0.

Alan

> 
> Kind regards,
> 
> Paul
> 
> 
> PS: Using pahole 1.23 I get:
> 
>     $ make -j100
>     […]
>       LD      .tmp_vmlinux1
>       BTF     .tmp_vmlinux1.btf.o
>     pahole: Multithreading requires elfutils >= 0.178. Continuing with a
> single thread...
>     Unsupported DW_TAG_unspecified_type(0x3b)
>     Encountered error while encoding BTF.
>       NM      .tmp_vmlinux1.syms
>       KSYMS   .tmp_vmlinux1.kallsyms.S
>       AS      .tmp_vmlinux1.kallsyms.o
>       LD      .tmp_vmlinux2
>       NM      .tmp_vmlinux2.syms
>       KSYMS   .tmp_vmlinux2.kallsyms.S
>       AS      .tmp_vmlinux2.kallsyms.o
>       LD      vmlinux
>       BTFIDS  vmlinux
>     libbpf: failed to find '.BTF' ELF section in vmlinux
>     FAILED: load BTF from vmlinux: No data available
>     make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>     make[2]: *** Deleting file 'vmlinux'
>     make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>     make: *** [Makefile:224: __sub-make] Error 2


