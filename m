Return-Path: <bpf+bounces-61095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6DAE0AC4
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B213B45F8
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106723F439;
	Thu, 19 Jun 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KGoVDFYT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QJVNdwvj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05023BF9F;
	Thu, 19 Jun 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347739; cv=fail; b=O5sL2uefSH8Da5UZtznLnMW+zNkmqYOrk2kkzLVdNLJeF/uAUWLvGGScME0NitKvk1m7bf8fUwUm5g7wGgzb5Uaa8l0NjHRypSKFqPdl9u/0rtEd5EHN+Y3pSkz5+dv59oTNV2yu/OFFzGBzByi9+balT24ccADInDaPrzsK19s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347739; c=relaxed/simple;
	bh=2UoDbDcaneyVOqKcY26EAnr9JGghQS9lwXG19OVPIaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ke8YH/HTar6+yRVeeJAEhxGrkmVby6mmA4lF5dAQzfWeah36x9GfSB5yS+KyTT2f+Yj/HaOw2RZCPCoFxKwrFQbJe9GnwpY27UkcPfgPSEDP43UW+2M7AWEwzGbklMSlzIdduHVtAZIDlKb2XaIxj5mKKwbu9FIklzCPixgUOU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KGoVDFYT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QJVNdwvj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEMbwd029424;
	Thu, 19 Jun 2025 15:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4AvDCJqxTjGF48xohdMzX8Bg9MLAwxg342UISI+sX1E=; b=
	KGoVDFYTY+d2FDrnqe/tbu96o8P4Rb+rNbbeEYoUoaXu7a+/JC8+g16C/xPrMFnW
	XZ/MaTWuxXJ8n69K6DL/qMBwk+8rkM1ZiCnNn9D1kCCKM2WyI5Fm0NoExaywY/9n
	UyEuMRmCOXnHOIbFTGEu3E1c9JVQA+kxMoHdHH+CWr4UMcaYW78YI1faP3TY1tU5
	Tg8qyuvYvHezuS7qT6z7nQ51FJ6CDIiTBNV4ovHjGUsj1LVkrUHd4V+mkV/XovCl
	icqOasfXBBGxJfCswMnLElLl1tJKE/+Qgm2av1Qces6ztsjsVtbOBkzMQK5xUYBl
	3Fz6VWGca6LiePxFTirdBg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xwn5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JFZsOe021703;
	Thu, 19 Jun 2025 15:42:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhbsk30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlWg5LgaXDze2O5oyK3KdkzRVZavPnrLcxhT+5CkbXisMIwLl1/7Ljus8mBMZ4BmXjYF/tkLCpAdMM3sssialzqk82364xSFD93VjDXL6JofxGxbjjKTkpCDJHgoqCg9/QbVG7Fb8dzlq30a0HYQr/5WpLluDkKy3uWyYGxPPZVfOxK+C17tgXK73mE9vjoV0tlEio2GolGXBj7AhBiqlgnSw9sp8NY6tmjklPWvTTxBPGLjPRzn9Mngh8rL7HTFVYf2AycN5kDA1Y+vCOFGMo4LOF6Gc9mL95S6HHq2PFfkWptdL2zILQkRno3/9q3mR3DaZl+LPcTXEKNQmq74pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AvDCJqxTjGF48xohdMzX8Bg9MLAwxg342UISI+sX1E=;
 b=KwCOVGG+8sqi+0WyEuc3V1SBVNmewDGe/IF0Bdg7U4xsVA1lsYwwXlCIkPL79yvB8RELRmd/ViN7but+1T5VoglDbTwEhSlKsknTe71AKxiYo7jZoB72pfV2Lzm+DdqTuSqZ2CtrpmxHbnca8AiaMOhw1wFkOCvvBk9CliAPVajDCaqTNkD3NrWi1peI4f/Sdu394qXVFMdPdw5yVq46POduio9HfwCnESbhV0vteAZCY0/kfT+nRGy52ddYdni1XiiNIeA8JGt+v6Qa/Qn1vg7mz9Fogmgp1ph461KBh/ejkYOV8pu5LgA0slJcaKZgPZwT9Pdlr2e4K/bTnwzOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AvDCJqxTjGF48xohdMzX8Bg9MLAwxg342UISI+sX1E=;
 b=QJVNdwvjcxnbkXqa3eQ4i0dyIveWFal9V8+fC2Grc6YyQOwwuwDN+7KengIkdLdGLr7vQFx1B13VAsQ/f8CuAISIVqFXY3ngS5PLGaPg8vye56NWfRXbiEUlLo3O0G5LuPcI4geqIyRVi6lBfbSP4ekB1r/UsVsW1EEGuJIBaDo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB7322.namprd10.prod.outlook.com (2603:10b6:8:e5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 15:42:05 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 15:42:04 +0000
Message-ID: <6fb578bd-8851-414e-bfea-dec2472c6ee4@oracle.com>
Date: Thu, 19 Jun 2025 16:41:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btf_encoder: skip functions consuming structs passed
 by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com>
 <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com>
 <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 140d446d-9f69-4e34-4a70-08ddaf47d72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzRQZGd2Zjl4QlhndGExaDdJVWxNdE1NVm41NXE0bk1LK0trcU5lc2lkdUxh?=
 =?utf-8?B?MHRVaUFKMVdVMUN0OUtrVU1OQ0R0TzZ3YUFXd1pKbC91TE5ia0Vaa2xETUhn?=
 =?utf-8?B?Z3FYbzhBVkNoOTlGLysrZ0tZZGFsaFl1QzhqRzdBUGQ4bnFXMjR1dDgvc01V?=
 =?utf-8?B?a2FKa0hQcFZQeFlSZkZuOWRVaGVURTQ4UE45c1hoSHN4VTV3TVpMOWg5S0Jj?=
 =?utf-8?B?NFAyNDRzcHMvdEkwakJQanNNZ2hueHg4NUlJWThWWnJYMU82WkdsK3NaRkVF?=
 =?utf-8?B?RGMvb1g5bjVNZ0E1MDZJN2dFd0pFOVpaYkNOY1JCb1NhemV6NGZYZEo5RFRj?=
 =?utf-8?B?NW9SWG8waFZJQXYzVlRpOFNnQ0IrcjZTMW03Ri9yeDgvY2Q3cjJlaXh0cEM0?=
 =?utf-8?B?VkVLVFQwOGVkQ3Y0c1pxSXNjdkhGK1lSWEJjamRMZElSZFBNaXpJWW5PMWV6?=
 =?utf-8?B?VmZlWkNvdFdDQWsxS2pZdmtzdjVhV3BvYUwxaE5QeGNuaVdoaDFpeUtUYno3?=
 =?utf-8?B?MkhLMmxibFllSzZnSmVseTRoZVExOHlpTmRldzlpY3NpUWNlNDU0c3F2Zlg3?=
 =?utf-8?B?VTQvOTVqdWUxTlF1WXRlQlFyY2pqZjF5Q29qb1huNE9FdlRVOWRsMEVHUW1j?=
 =?utf-8?B?c3BCWHY5dlRTTkJvQmU4cGQ4RVBiUHAvTzVxN3lvQUI4eEMxQ0U5SEhkODhk?=
 =?utf-8?B?bWw5MytDT2hrbkdzVGRJcHdqa0Iydjg2ZUJNT0dRdFFQQ2YxdGQ2QTRxR2xM?=
 =?utf-8?B?blgyQXlyOXBIV1ZOajZ6cEhzK1BHY2RpWVNlbTdhSDNNeFZlSmNmd042ck8z?=
 =?utf-8?B?bFBhUk5XRnoyVW9DSjArakZZbmNFTERnY1hUTlBCa3MrMkZGOTZzd0tYaUhm?=
 =?utf-8?B?V1h0bU1MWWZsbUw0UkdUdEJBU3pYcWVrenRDTi9RanJEeFFmbVlIV2hJcXhj?=
 =?utf-8?B?azgxTEpaWnRTb2tkOFk4NVZRclk0dks5TzRkZHp6enlUSTRKaTNOOVFqWDNn?=
 =?utf-8?B?WnNkQ2xZT0o0VlVKQlVhdVBhaHZ0Ym9LYkFYVy9OSXp4UVY2OWNPdVIrU3lR?=
 =?utf-8?B?M3JTMU52Y0Vhd2kwc2ZNRHhKYnVjUkIzMWVGUHRDN2QvOXphUUJUWlhOQ3pF?=
 =?utf-8?B?MUlKdVZLWEhHTEJLKytiSzVINHBMZGhxYXQ1bUNid0FVSnV6akMzSUVjYkVp?=
 =?utf-8?B?YXpYMVhGbHJNdmVsU01UQU9FRnFZZWhnZnhVSlBpUzRKWDNGM2kvSlA4bXR0?=
 =?utf-8?B?OUUrSmo1OXNiZlJOL3UrcWhlbEhTYzg2SGh2MDI1V1dnQk5sYkRtVlFka0xY?=
 =?utf-8?B?N0c2YlZZeGRFNU8zUVE1UVhpOGhVQmVhZlVYOFhGTjFvR1h6aWdJRmNVNW1K?=
 =?utf-8?B?UjVKWVpRdERFemdEemxvMGhMNXlYKzAxamFsNHpkM1FNclhIK09NWXN5c0Vh?=
 =?utf-8?B?MmRPR1MxVGowejh1TE9jZ2ptdDlDSzNPNjQyZ2FZcUl4dlAvbXFxanQ1cUZW?=
 =?utf-8?B?QU0xMFJodEtpczZmTm9ldWw4U0NOenh0WkZzVXJwWFlrNHJVT1lzMnVEblZ4?=
 =?utf-8?B?VW43N0wxa0UvWGlJYS9mZ2JYYU9MN201R21lOWI0Zy9zVmZSV0gwdnAzZHFv?=
 =?utf-8?B?anpZNlBpcVpORnJRNWJOQWVkZGJGTnRNSTNYUXBaajEzcGU1eEZ4MUJ2RXlj?=
 =?utf-8?B?MTU2OERiTkNjbnp6eDZveElxRk1HNnpOYlJ6Q3RodlVlcDZnVUVtaFFKVmU2?=
 =?utf-8?B?OGFMSGJ2MGl1dmtmbVk2QUIyVFhEUThIbC8yYWtQMjRuempNQ3BEam9WUVhR?=
 =?utf-8?B?T1NoamNTSWNRQ2tFTkdQaWVRdFJOODRsWUpESSs1N0dadzdrenIrbEhZeEhx?=
 =?utf-8?B?bWZEU05wcHQyZUV4MzU0U2RTMHpqTkNlU2tGN09uN3VxOXBxN0ErSHJZd0RW?=
 =?utf-8?Q?xTleHVSNMWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjlpenVobFNhU3pkdTFrMTJsYlF3RDFQS3ptZkZIVXdmK0hLeEFIS3A5R01T?=
 =?utf-8?B?LzZ2ZHh0TEVqalBNUkI3TXRqRlpad3NOemovY1djMFJjcWJzclNpL2gvbEUr?=
 =?utf-8?B?alJGaEx1L3RsMHEvVFVFU3pKbC93OGJEV3R5ZEMzcGhFcjlISnJVeWpUdGpk?=
 =?utf-8?B?Qkd0dUVWYy9HeXpCR3hSNlVKMWlhdzRMNTBreHZPOWh0cjI0VTZyL3RINkhZ?=
 =?utf-8?B?YUFiM2t6d09oSHpvUjFlUitDNExzM0lsVnN3T3d0cEdKMFJ6aGVjU1AvQVh0?=
 =?utf-8?B?Qkc0SDNybGpsa3NEdkVPZWxQbGJLVklHRVBCOGtXeHZBeFMwTXA0ZUhaNTFE?=
 =?utf-8?B?UmE3Z2crRHpodzcxN3gvbzNuMkJVSVJwUUZyY2trbHVUeWZKWDJzU0JxaC9w?=
 =?utf-8?B?WEF4L1hzamh1ZFpibXNOM3RHVzNKT0VGOWYrcjBreE51N3JqUUl0RkpuSlUz?=
 =?utf-8?B?Y1ZaSkVIeGU5YnhYRmdDVE52SVR2R1pKR0dhWGtnRjhFSnowOVlCKzNlV0c1?=
 =?utf-8?B?ZlFwa0xRYkZyUytUSmZPeWNYcWRWRjU2U2hkSFFWVmZmendoYjg4OVpoM01n?=
 =?utf-8?B?azNBQ0QvVnhnUDlxRG56STNtSkdVMlA5MTQ0bVRzWjc0NGxqWDdwRnRvNTZB?=
 =?utf-8?B?WmtzQ0grNE5VUXM2eTFrNVhENnVqdXdlK3haT3lmMXlkTmxEZGR6eFQwWFVz?=
 =?utf-8?B?dTFtTWZHQzhDNnJjQlI3aEwrR1RranpRYXNLa3AwQTNCcHNyNVlVWnowNmRk?=
 =?utf-8?B?VjBReEJiKzAzeUlVeGxBUWprVEpDbi9YdUdwdUZwY3B6VTRxN3I5QU9kNGNq?=
 =?utf-8?B?WndJWTgvWE9BUGlaMzVMOVF3OFJ4MlVNZFZlbkdyZGF0NXhUNEswUGdKaDdt?=
 =?utf-8?B?NitJUCtiL0I4NTNtU2lpZGV3aGNiNnpCSHhFcTFBOUZIZEdBYW1zUjFuaXgv?=
 =?utf-8?B?aXNZeG1Ycm51cDI2d1lFZ1dqM0hKUzRWRUpBVXZuUk92eTV2SER5YlhlRkpr?=
 =?utf-8?B?S24zM3RRcW5tdmVRREdXNHZrYjNjSWdUR2c3UGIranNzbm9Ba1RTUTA4N2Qz?=
 =?utf-8?B?dk5Jc0x1ODY0Nzk2UDcyV1JnNjZGUy9iMlJoUlYrcjh4OFlCMldYSkQ2ZExo?=
 =?utf-8?B?amZKNnltcWRqRlBrU2w3YTdYcG1CaTA5ZnRaQkNnUTk0ZS9UMmlqaHA5NXF3?=
 =?utf-8?B?dW9jUjBTNzlGNWpEZndkOXVObWI0b01CVGZjN01iTkNJcVN4bVdGNEZqUWFu?=
 =?utf-8?B?K0I0Tm5vdW90WW5pUVd4a0N2Z2NYbzRiaklaMHhjRXp4eUVBclpMeUhObThT?=
 =?utf-8?B?QjFjd3dtUGRJeS95ckV1MjdsandwM0hxb2NvT24zdlRBdmVoQzBUYS9ySHVh?=
 =?utf-8?B?bGpqQWM3eUZYUlVnNWJCZ0QwMGN0QXlaTkIvTmYwNHF0ZWluK1lJcldmN0pk?=
 =?utf-8?B?SGNxQWIxUWtiZXMwYkNzd3FHdHJva1BML1gwRUhRQU43QzRReXV3aHZwNG9I?=
 =?utf-8?B?ekxhSkpLNlIvSTNTamkyNURjbHVBSDB5SGdKSURDWGowS3RaSng5ekdZcnFq?=
 =?utf-8?B?a2NiUFFoVzloMDJOekRqK0o1akRFWlJLYzhHQk95ZE5nd2ovaDYyRXMyK3o5?=
 =?utf-8?B?UTgvM3NxYnoyeVVhSmdDK3k1OEs1R3J0WFRQc290M08yN01KemtOdWdvNENC?=
 =?utf-8?B?UHZsR2k5K3kzRWJ5YTVnc01vOVFXVlZnSzIrdytVa0NYWEpyb1k2TmZwakl3?=
 =?utf-8?B?eFZGcjFWM1VGMWFKRWhvUFlDOWN2ZndpcTk4ZnNlVVVaY3Z0bjhYcThteDBS?=
 =?utf-8?B?VVhGV0s0TmpMRUR3YmZrbFdkREhrdG5MRHBCTFdvTGZWSVpIOWo2QUwvV3Jn?=
 =?utf-8?B?WkplZDJ4VnNla3lkYjFrY2cvaTY1SjhVamhsdXkwUFpjQ2tURURoa25hRkM5?=
 =?utf-8?B?L00zSjZzVTltK0dQRFd6dlJlTjZscENRdjZ2eldSckNzMGtFTVdhL1dYSklv?=
 =?utf-8?B?NHVDYktwTm9ZeWkwTkhEZDF6QjV2bEVqRVlwOFFZbkxuSzJYR1h4cHpxOCs2?=
 =?utf-8?B?OVNrc3dZQUxsbm5pQ3Qrd0Q4Q1ZZaU9Fak9vTkQxWTZCVGNwc1dNVkVHdkJa?=
 =?utf-8?B?Rms1K0o2WlZJQU1BZUdhWnpNMXJaODF6Rk5xcFM3UHZyZWJiM3NmcEduOEoz?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JciKx4juVNhepujnNrQTnjIWsc0UZFYOjX34FwQ8M8B/AIaBXpZoC69gxWJeqCLfzPK33HiN/R6TFEeeyZzTjhYC2qfOKOUO1OJr66RejwzDqduD3GYr/wjWAobtlwXQX+fTwt/20rxl6tRNk6gmVdcU5BKE/RlENU/LTQQen6DV3xAEGThZ372cG/bK3JmKooqSSnG/u+G6ikFhYgvNjZ/ds9fqrbHk9UT71kY0GIEPq6dNKuJLrQflyYjkd5K0gilKyBZ2TR672b1L0donicB/J0Tr9RLYOSp/ijz/K0tKqUG8SVpS26YNbNPhc6mxY2d7xuUpvGmtTSOVw2aQ/rKqu5BT/4DHQ3WytgxnvsLMOhLm0lOMSczjDWgL7WEAE+I3PAjSuyeeTTCmsMiU0RQIXwCn4X+pTqEInkPsvsX/cRssbaAF9DEPCvjuVQJZkFuEYmZCu/jW3WCZD0eXSBSPjA3Y5WutENqB4Cr9V9G5w2YGe82TscB1TJrG+SxrtSmTbTYGqiuZwl04zpyk61jDpbW2gq+XjO2Zh+D6IdqfjTAXuHyt9wWI+YL7d06VFBYbGyLE0GJh2voy5IMaxkONnKwZsxQdC3R0Pqna+jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140d446d-9f69-4e34-4a70-08ddaf47d72a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:42:04.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DcQFe93zqgXGuZyo7zTWxC8Wx3WG81bti1pNbj4g6viXGkLr/D6RmeeQcBK+HkXOTqPTUr4DMThB7gqrVdnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyOSBTYWx0ZWRfX0/MJ8DZ8b5hG w1Fnv5fa/eph+2taBbHiowkaCYNugilvaF69RBScarmMOx2GOx16hougaiIAvx7zwli1zF4LDbR AMJHKwVBHazkVgfv9ImkakleMgD845IlVWYH0Z8Q63lpeSFR6iKI0G4jo/7i2c0+30si9pwV67r
 LZFRlGH+sPgzVkVMvpoJKGgiAiLKAaBDbO0VK0pCroKEi04WStqmmQCy3chH3jzBCFLBDMklTt1 uoVLmJMOqKKlN6xCu9j0hwv+WRX2db6E0ISCmsl4txP1pWYs5n6EpjCldASg7uCBFFhHPSmKbJL RLBz97BSqZqlab4MHQbjU61SFsKDsl8I/c9D18kIQUXSh7ihiHXmBqY566kBbL5g8PsVaoN99Sx
 79MsuL8GsNSqOz197z7EA73xBClaY9RFfIHHtNIz5ywpcWIQDBr3BL+pFu3J1cDLVtGJVShW
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=68542fd0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=ObeMhEgmooimgHoQkNwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: LTJKgazheb-K_nYXV8RT5M7HBaUDnwuK
X-Proofpoint-ORIG-GUID: LTJKgazheb-K_nYXV8RT5M7HBaUDnwuK

On 19/06/2025 14:12, Alexis Lothoré wrote:
> On Wed Jun 18, 2025 at 6:28 PM CEST, Alexei Starovoitov wrote:
>> On Wed, Jun 18, 2025 at 8:02 AM Alexis Lothoré
>> <alexis.lothore@bootlin.com> wrote:
>>>
>>> - those attributes are not reliably encoded by compilers in DWARF info
>>
>> What would be an example of unreliability?
>> Maybe they're reliable enough for cases we're concerned about ?
> 
> The example I had in mind is around the fact that there is no explicit
> dwarf attribute stating that a struct is packed. It may be deduced in some
> cases by taking a look at the DW_TAG_byte_size and checking if it matches
> the expected size of locations of all its members, but there are cases in
> which the packed attribute does not change the struct size, while still
> altering its alignment (but more below)
>>
>>> +
>>> +               if (param_idx >= cu->nr_register_params) {
>>> +                       if(dwarf_attr(die, DW_AT_type, &attr)){
>>> +                               Dwarf_Die type_die;
>>> +                               if (dwarf_formref_die(&attr, &type_die) &&
>>> +                                               dwarf_tag(&type_die) == DW_TAG_structure_type) {
>>> +                                       parm->uncertain_loc = 1;
>>> +                               }
>>> +                       }
>>> +                       return parm;
>>
>> This is too pessimistic.
>> In
>> bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
>>                               short g, struct bpf_testmod_struct_arg_5
>> h, long i)
>>
>> struct bpf_testmod_struct_arg_5 {
>>         char a;
>>         short b;
>>         int c;
>>         long d;
>> };
>>
>> though it's passed on the stack it fits into normal calling convention.
>> It doesn't have align or packed attributes, so no need to exclude it ?
> 
> I went for the simplest solution, assuming that there were cases involving
> packing/alignent customization that we would not be able to detect (eg: the
> packed attr that does not change size but reduce alignment). But thinking
> more about it, those cases need really specific conditions thay may not
> exist currently in the kernel (eg: having some __int128 embedded in a
> struct).
> 
> I see that pahole already has some logic to check if a struct is
> altered (eg class__infer_packed_attributes), I'll check if I can come with
> something more selective.
>

sounds good; one additional suggestion is given that these sorts of
functions are rare to nonexistent in vmlinux, perhaps we could add some
tests to the tests/ directory that compile C code and generate BTF from
the associated DWARF, verifying that functions are (or are not) encoded
as expected?

I'm working on adding automatic comparison of vmlinux BTF function
encoding for candidate patch series to pahole's CI (so we can see if
functions appear/disappear), but in a case like this a few explicit
tests would be great to have. Thanks!

Alan

> Alexis
> 


