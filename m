Return-Path: <bpf+bounces-65117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BAB1C4AF
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0763BE080
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE228AB16;
	Wed,  6 Aug 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6/YdyU6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tF6BlxpD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FC1DE89B;
	Wed,  6 Aug 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478898; cv=fail; b=Sy51Wu8hmfj9/aYUPnKrROkeOU4wYpfJjZ4fQ6BEtbKia7HKhj+VVu8KcGNi5L3Hl60dSFAja2VhmLZSIDkTsgTBYl/EXBgEC2zJfNTMtufKPUY3lyWGcfrwZSZgpN8E5vUJemJDzjtM9jr08mFOu40OdEIYUYHwpXvQStpnpBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478898; c=relaxed/simple;
	bh=zjhVaGj4XKk6Rt6USwxm5BNTnTflnpCZEfPmhTqnjfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G8bXN5SnX+eHz0snDBMSGf0cGSDBNtamDeVSGBHLcS2KROQ1ZPCF22wSKjv4rrNxEjNLl1Y+B2CQrl7ONWuMM3SEELkZTYSARW5ccVJ4kSuNL93xkwaMtfd8lpU4fL0owqqBDbISsm+vIiLLJWGc3QjcChfytC5A+qbwfv3KCmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H6/YdyU6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tF6BlxpD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768RepN006314;
	Wed, 6 Aug 2025 11:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZcSIGz2+wHuUqFROjsjQfbnnd8YRwZA9mIt9DnQC52k=; b=
	H6/YdyU6G0v7uJgjr8xgHlHR2SzDvzs0fikA19zICPYC5ifMRNT4yRpFpTj5prGJ
	i3XZvvsdmmTJAfZ0GntiVu7ed77WU3QhKN6jbvMXZV2V+35rUG6q2i8bhfZuJ62p
	vlF1MweIctAICQoFHUVBDUJ13VzEmLpIg35kYHouugNm4s3pDmjfgUno/PhMjImg
	RfapoQ/zjhBguWApkT9DCRZUKPttdKj3vkGStF5IISCHUK5yY5XETL6LsfiE42SL
	Vp/V6PjPZbVCuxriEMASr7+aRzbanM1suGm7JIOxsW5sIiK7TkQ9IKb43EOE8DV0
	DI3DLkBKWGUgwWZKb7olRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve1fwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 11:14:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576AlTcj005647;
	Wed, 6 Aug 2025 11:14:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwww0wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 11:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLetUgOxTX477K38Qmh6xF8zckmHmCKsmkATG8/ZJGBVdDy3n3Fzd/7tQ7rzYsf/ydPVsTSoyGF/lxnXPo+aJqEFNPQ5qwaZruwEb0JZgaEAtuTXvKYaK3/OhQ83Hqw242UZMmoZnzNO2mKLDQRq1+lIfr/0OeJDc75d9QW87cQt2Z3wCqPrlHEMvro2q1yICBwJp0rYuYBz1hYBXjT7jD86XZmqYrqVBtVtFY4lCFJfGrOauZxJv5Gvh/PHIWq3F0+WWFyDIdCHwPRA7nqasUpnFAlMDClWAZ8FLEZb+EBd1nUux0w/B1jZ2fkp2upMHuSOj0d6y3Ocvhs/wjXOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcSIGz2+wHuUqFROjsjQfbnnd8YRwZA9mIt9DnQC52k=;
 b=BjTQMGfpIuGaJP2NdOs5P0GltiCqVau90mgJNfzvDxSNKB6GDYBQ6I8PRvx8hNFXyn4SUwjGWduvLpxue9e+/Vil1yd0V005KaR0oE+7B/b1LaAYUKWaFFyO+EHMOQEpOunSQ8OeYjqV+ifAYhOKzOnTmE46V/TKrV8njwjM0Cym4ln9XQ4d6V5e6OPUqCq16Rlp4RpZTslyVcJWs7FOYqh1U43ddrL6tFfvcnshK/oOnfovEJlR0z6G8pQ72Nkg7/KdJwIawtCrjMeDkBbbpZemJJyQQwBYXq0cy8xG6kg4x4cIG+yU37aabkjdiGuOELbpVzzQiLf9/xlhK4RJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcSIGz2+wHuUqFROjsjQfbnnd8YRwZA9mIt9DnQC52k=;
 b=tF6BlxpDGcHYCGYlHgBzb27wCVbdVl1fpioKdsisU5NfD4kDsRgFxHKmFMk0ZluzX5KYV3ly9kPoi0Yx4a8SIsqSbzSp++0b/YVjnMveNG1PsYb5SQA6HCoGhO1RSaVQ0zAH3MySjGx5KVu0vjNNaWjEOXWr005XC7h/VaO7mMc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Wed, 6 Aug 2025 11:14:47 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:14:47 +0000
Message-ID: <fcc81343-4548-49af-a811-ef843522c08f@oracle.com>
Date: Wed, 6 Aug 2025 12:14:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>,
        ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
 <7201b814-aeb1-4f1d-b5f8-3178be1e29bd@oracle.com>
 <DBUQ9HK08HSW.182155MPSBZJM@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DBUQ9HK08HSW.182155MPSBZJM@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::21) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SN4PR10MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d8281c-d7fa-47db-621d-08ddd4da7440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1o4SmthSjVnaWJlTVd3N0pOa3h4eFRWZXhJUEplOWhhVTVCNmFmSmJMQWtH?=
 =?utf-8?B?dXlROFlBc0VaRUpsTjFuRzZ2em0wK1ZpMUxlUGhZa3FxZEdENVhVczd5OXNF?=
 =?utf-8?B?TW1wWHQ0Z3JXUytXMElWMmRVTk40WUpZOG11SzF0UERoWUVwcm4xRE1mY2Zp?=
 =?utf-8?B?YjhkN2Z3cSs4QXZoVjE2Y1Q5NUg0UEJITTA1RFB6T0lPcFFLdlU5ZTQ3VUtl?=
 =?utf-8?B?Yzc4VUh0QkNMMDRNVVNxdmRBNTBrWFFvUm15ZFBrdmtvenFHWEt4OHpXa2Ey?=
 =?utf-8?B?L3g3TkJmbTlpYUJwb0pGRVk4SHRROHk0QWNJcjdZZTJsei8yMSthRkYwRnVn?=
 =?utf-8?B?SHRCeWVZUyttTWtLTzlleEQrWXZiRlQzcWNyWTZOaDBFbk96dzlrU240ZDFX?=
 =?utf-8?B?RUc1WkJoK0VzS1hrNGI2MEdQdTREcUpMeWhsRlQ2UEdjMzJVb2RKdGNOMGVz?=
 =?utf-8?B?VGVNcWltRTdJaVBUMzNYMlorbmo1enZFVGNQeUV6WGI1TmdmckV2NnVERkN5?=
 =?utf-8?B?QS9pYktIcnV4VVFxaUc4Y3V4TSthalBiYlp6eU9nUm5EcVlXczFQK3FYRXFy?=
 =?utf-8?B?UHJMMUhFSXZRei8yQlhLOWpwN3VxM0dQRUY3dTM1Q3NLVE1ROS9OeEtFOWpm?=
 =?utf-8?B?NHNBbUJuNHIxUW1DS3FKNDgvRmg5NHRBVUVzUTZqa3Y3NVAxVnkzdDhyRERu?=
 =?utf-8?B?LzJsTlVyek9oRWlQT1liWDV5eGNVVUdsTDMxWEt5c3BzdGdxUUt1VTV1YkZq?=
 =?utf-8?B?cHo5VDZDdiszOWRsTjU3bCtUd3M3TE9CY0NINS9SMC96bGRsWkhHSSs1bHB5?=
 =?utf-8?B?eXRXWDd4ajhLcVArTjRzVWMrZU1NRS9lWW1kNzg5L0RJbytDL2pWVXc2U01r?=
 =?utf-8?B?VlpxTVpuRmkxZWtIbzhoUVBoOFVMKzZCeEIvMXZIa1plVlhUb29CcUFTczlU?=
 =?utf-8?B?eUFSeTYwQXU4d3A5eWprb2kzaWJmMWthZkFUdlNRaHlKT0FaRDduYzR1R1Zt?=
 =?utf-8?B?Zkl1OThhTjlqaHBTWFV1MFlhUmQ2ajgrMmR0Q3I4VUx6UmZXZitYYktwWVpa?=
 =?utf-8?B?SnFuQmViUE5UOUNjc3RHNmg3V1pSWWMrS0Z3R004emFVTy91MEh0N2Z0WTNx?=
 =?utf-8?B?UjJrb2NDaGR0UlhxWDBYVUpYWlpXSVhpZUlpaUQxZ25LdGV6Kzk5SVh5TTU1?=
 =?utf-8?B?dUtRaitiN2dET2pCWGFkb1IzT245dzNxd2U2N0djRjRIZWxMU2R4L05oSFRS?=
 =?utf-8?B?TkljclBjWFBaaXl1MUZDMW91UkMxdzVlRDVpT2haczJFSGZ6VE9FaDBLUktQ?=
 =?utf-8?B?Z1hDcy9sdllOOFBET29YeWxVbHZnSGY4b1N2eXZOQlNFM3M3TGNuOW9WRTEy?=
 =?utf-8?B?S01kbnMwRFI5eDI3YmppcUdWbjl1V1FZMVdqaTZXWDBRZW1jOGVnNEVRckhu?=
 =?utf-8?B?WlVpRWNhajN4MGZ2VDVIOVFyQ1dRdmZHR1VvWjZ1R3huZjQva2hIYmZaTzdm?=
 =?utf-8?B?RCt4N0Q2NURHNGNQak9GQm5YNXVySzFkRkpKTTRyUndBSEpBeW9YY0xtMjFM?=
 =?utf-8?B?M2dmZEFNUnByQzZNSXg4UUorOEhKYzZINVZqRnRCNGVtN2VQY0lDZTErTUJW?=
 =?utf-8?B?eW8rWGIrTzRSMm9udFJwdHJZdUlTWXdFelloRmduQitwb24zVjFpek5MY1Qv?=
 =?utf-8?B?S255cmNGeFlOQk5aU1MxZjU3Qm1NSmN3QVhHV2ZLS2orT0JCYlFsa2dMWmV4?=
 =?utf-8?B?by9WTCtjMStpdDdMRjNqWkl4UjkvQ3A3Q0xjMWVISUtlSXdUa0pObE1LK0VT?=
 =?utf-8?B?Z01hdXB4cFlaRUFESjRaKzN3cUJYdDZPSzZzU2g0bGZ1OHBjN09XeDZqUWNh?=
 =?utf-8?B?VFBwakFsK3Yyb1pyem1Ra2JFbWZZbmF5bVE1MWxaYWpBVWQwWFRzTTNTWE91?=
 =?utf-8?Q?AYRlphxhc7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFU5allndkJsdUNkRFFQOTFFa01HbUJFeHB0ZzBvaFV0SHBmemRjbm1qVzNw?=
 =?utf-8?B?VFVvbnVLTWkwdVI5UDdONG16dFJyVlNuZHBXV0Q3UTRsU3VOS1pZb2ViTkJJ?=
 =?utf-8?B?d2hpV1RnN3lKMHlRaG1PeW5FTi9VYjQyUWVhRGxSWHdIcFBKeXNsWitOVDRu?=
 =?utf-8?B?VDNsY0FmdWJ0RHU3U1FDYzV4OWEzZ2kwcVMrd0VjUzdlclkyK3RHWllrRDB6?=
 =?utf-8?B?QjhSZ055S0tGWlBrWFRvYnFMZDVuRlhJVWROeVRJLzNKVlBZRUliRmp1bm9S?=
 =?utf-8?B?VkFDL3JaWkttT05BRzhmL2s2OUYzU3NMeERvN1YyQlBSZGZwZ1pyN01jbEJz?=
 =?utf-8?B?c1JaU1BPeWxuYmhsdDk1QlhjczBuUC83UU12b0M5cEUxa0pTcjYvQnJtczBU?=
 =?utf-8?B?bi9TKzVjNHZuV21kdlJValZvOFYzcU1lSy91QW5iVGFUN0RzeGRiRnlQYUxy?=
 =?utf-8?B?cDBoNUFITWhaZ1o2UFdqbWY5djdYN0h0SDlJbSt0anFUWU4xa0E0VGxkTDho?=
 =?utf-8?B?bmtFQXVnZ1I3WHFJdkhDZFprcC9TMDVhSEI2Mno0dExlMGZlSW5ocWMrMmpq?=
 =?utf-8?B?eDhxZWd5RzZia0FobVVDKzhHL0JRWVFGZGRia0dGOXE2VzFWSHdNOHFLaWxD?=
 =?utf-8?B?SWpmWUt0ZmpYc0MyWm1FaVg0cmVpbnNjYXFwRk5SaW1qZ1dzTk9PV01xRkR3?=
 =?utf-8?B?cUpKTHFka3R0SkhGQmp3U0lFcEFyQ1VnMXpLTFRMOTB6Zk16aDFWbHpVZSth?=
 =?utf-8?B?VXJ0c1FRZVVMdVdkZXNNRmNUdTdhYnpHNlhZS1F1SHI2RmdOZlNHZmQwNjlI?=
 =?utf-8?B?b2tMMWJRblY0WTVFamdhZmxJdGFsZFJPV25ZQWwwL3I4ZWZKWEltdDUxMmpa?=
 =?utf-8?B?T1lBeTVQYitUdXBPUnR4Slg5WC9RNDZWdkVleVpYTnUvK1F2TDdESG1qaDY0?=
 =?utf-8?B?UklPNnJ5b2Mwb1A0c3JJRHZITkF1bDM5cnZ4bWR4N3ZWVGREZE53ZEdwL0hn?=
 =?utf-8?B?NG5iNzc5bkgzYkxNOUNiZEx3akRTakxxVXYxRGtseWZwL3U4WlBBUXhFWkdP?=
 =?utf-8?B?THNuREVZN1NZMWdXRHFZY1dXMHlJam00ZVpLZW00ancxQUVaMG4rZTZtY0ZG?=
 =?utf-8?B?bDYyS3RDa01xZCtTNFhwWjYxSURkWjByYU4yYzdCMEVVb2ZaOUxxbFErZm9G?=
 =?utf-8?B?Umd4cjRUdkhRdXBKbGdEeTNFcHlQS0llVWVPVFpUZDJFUFU5dXB6bDc5V2NI?=
 =?utf-8?B?L1RxdWpoTnlvQ3NPSXhsR3VDR0hjMGZ5YmZ1YU5NN3lqTmRNdVp4WlBqNWpw?=
 =?utf-8?B?QTFtVUdMaEJJNGhsT21IK1p6dXNvY3JEUGo3eXJ4cmZzOFU5c0tyMkNFUE5Q?=
 =?utf-8?B?MTRXWmZZU1ZISkVGd2ZEYzFQdktHRkw0MjlzN1RaVHNmQlJVN3ZXR2RlYWNi?=
 =?utf-8?B?UFRkVGRGNlhlTzZSYUd5cUxPMS9ibXAzMTZVMTZ2bjNXRkczb0NJY3FkdUtt?=
 =?utf-8?B?OFlGaXpUSXBwbmFhU3lQZkdtck1LelJwUVNyUEZTUUJKZ3RSUUxOcHVLYzFo?=
 =?utf-8?B?dWZueTRrOGN6U245QUxRUDVOUVJBcEswV213MzlMVUZBVmFnbWU1Z0dsRVk1?=
 =?utf-8?B?dkhibTJhNUQvM0lEbkpST3lhNUZKT1Q1VWpFaWFOem1ZK0ZlRWpXWGwxSllJ?=
 =?utf-8?B?WHZ0YWNQSFJ6OEVjRXJoYlBVQmhYMytXOG9IK1RSMFVycWh2RW5reHU2L1A5?=
 =?utf-8?B?WjZSWUlyQ00rN0FGWXVJS09Lbk1wMXBwTWlZVzJnMlhIU290SWRZRlppckw4?=
 =?utf-8?B?VWUwY2EvaUZIVVBacDk0ajdIYjNFUGJqN3BTSFRFSnRLV1UvcEJzdlZnM1BD?=
 =?utf-8?B?eFBNM0FrNWZEZ0dXNjE2ZDIxbXpzNTBnZDhWdW9pU3o0a3Bxc3NMZFZrc2Ri?=
 =?utf-8?B?QlcwaC9meW9uOEhKTlpNbm1VbG55SU54YlUyV1ZsRTNwREh6a0FsUXgwRG9O?=
 =?utf-8?B?U01UaU9XbHVlWFRQVWlvK3R3cFYwRGIzSjdpWS84ZjhoTldXcTJCUjVjNEUw?=
 =?utf-8?B?NFlEOEgyNm9RVkliYmwzZGdFb0MyeWFjbjYzdFZaaTEwTzJjVTZ2cWpCQS9w?=
 =?utf-8?B?NEE0TFJxWEtRUE9mRnNoQjBGWkRNdTVUZkp4aXZFWWZMT2NaU3pYbFlLNVdH?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6FH/UJmHNFqg1Z8idsFfMqFJXG0r/R8qgCPNuFCsYq8JbgXhZgQBwoxDdVlJYR39CvfhhpxXRTRZ51Yst2DBqtPp5z8DjxI3nQb9rfkZ6a9wgdIjhoRM8iJtDWyC2hdWxqX9o7CyEISQd5aJ4D5VXAFUqoZ+y2bD7yo5hA+larcn7A9zfHCpEbvi0FBKkPB4RUcRSE1/TgJsBcqbEnSbzwBhVhbey/mPIYv0/PexTzcWm0KP3kMF3sALnCinIUkDld9RdjxRXWTX6IK3GuPjTDFwYPx4+TrDODIJcAeFlGYl0JNbTKJKUZyUMq0XeC9luM6fOQ5kUAuoKX9F94zO5W+ZzfsGmcX04rDIJrHIj9CnTBtEq/D+akLXgP8Jd8uJBZp89DC5T6vFnyKm3xulz9YFkbfkXxPsuzQik4HusKPEMozmImKtiRyft+9geVTo6luKW5iMQiqn7VxWz58CbVfPTFFoV9Z1We8kNHqdtoh0mBpOm3qB7E6Cux0wX24BueV/zXsO9171/VfmWsL1xG/8uWrW9eh2clxI4EfvcJwMdUkJ4uvboJQ7k8fpJbeNQQ9RydEwnlOelPbqpaOmV0h97Tvb3lk6HBYMPQhIOpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d8281c-d7fa-47db-621d-08ddd4da7440
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:14:47.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNLWDGZM0zNliwcHxfbA6ioGx2RdZSoOFbokZdytTafuNX9ijY7MVyljaUaMaYcijn9ElxWUDwL4h1x0kpq1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3MCBTYWx0ZWRfXybgfl9nyY8xq
 pKkcYDvvr2DEL2rtgdslNSCeatu8i+b/5DkJgSppTJUbDVZwZGmL84X2+b2T+OSvPYh3Ut0N0BG
 fFBGqCCIPq8malIrkkgcMGj1bAu0UYjr9D7KnJu5oqdAayRWI8wmU9uBR/Qq3Z3rNvfSOtOiJj2
 8hDpCa77wCAqOf3OVMBddUXT8UFcnxlKSmE+GeXbLM7dBax5oAUzUDkcW9BckMNYpPyigdw7sas
 xtiEe/x833ApfhQ8s8YQVp/OdESsM3Yl7ADXaI1NgslTcBsWtBOZIABHhC7mthd35Mt1cZUZg+P
 5yPVk4Mi44FDsJ59x8F47fEb3DnIgHUyfDgvnHYyqNTXnqaJB8K9B3SQKAFvEnIAoE5saBPZAQ0
 RsUkEDYv3JuggZGsUxxWzgz0yAJPKWFWmQY7rE4rr8vg4oQY2sMWBSEDr5w2by7QItfQZUzA
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=6893392a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=wxH95jruN1MKsizTok8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf awl=host:12065
X-Proofpoint-ORIG-GUID: U6wO5O7deRHU7x7NlVdCKLuHjh-o1k07
X-Proofpoint-GUID: U6wO5O7deRHU7x7NlVdCKLuHjh-o1k07

On 05/08/2025 20:06, Alexis Lothoré wrote:
> Hi Alan,
> 
> On Tue Aug 5, 2025 at 5:09 PM CEST, Alan Maguire wrote:
>> On 07/07/2025 15:02, Alexis Lothoré (eBPF Foundation) wrote:
>>> Add a small binary representing specific cases likely absent from
>>> standard vmlinux or kernel modules files. As a starter, the introduced
>>> binary exposes a few functions consuming structs passed by value, some
>>> passed by register, some passed on the stack:
>>>
>>>   int main(void);
>>>   int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int, \
>>>     void *, char, short int, struct test_bin_struct_packed);
>>>   int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int, \
>>>     void *, char, short int, struct test_bin_struct);
>>>   int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct);
>>>   int test_bin_func_ok(int, void *, char, short int);
>>>
>>> Then enrich btf_functions.sh to make it perform the following steps:
>>> - build the binary
>>> - generate BTF info and pfunct listing, both with dwarf and the
>>>   generated BTF
>>> - check that any function encoded in BTF is found in DWARF
>>> - check that any function announced as skipped is indeed absent from BTF
>>> - check that any skipped function has been skipped due to uncertain
>>>   parameter location
>>>
>>> Example of the new test execution:
>>>   Encoding...Matched 4 functions exactly.
>>>   Ok
>>>   Validation of skipped function logic...
>>>   Skipped encoding 1 functions in BTF.
>>>   Ok
>>>   Validating skipped functions have uncertain parameter location...
>>>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
>>>   Found 1 legitimately skipped function due to uncertain loc
>>>   Ok
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>
>> Thanks for the updated changes+test. I think it'd be good to have this
>> be less verbose in successful case. Currently I see:
>>
>>   1: Validation of BTF encoding of functions; this may take some time: Ok
>> Validation of BTF encoding corner cases with test_bin functions; this
>> may take some time: make: Entering directory
>> '/home/almagui/src/github/dwarves/tests/bin'
>> gcc test_bin.c -Wall -Wextra -Werror -g -o test_bin
>> make: Leaving directory '/home/almagui/src/github/dwarves/tests/bin'
>> No skipped functions.  Done.
>>
>> Ideally we just want the "Ok" for success in non-vebose mode. I'd
>> propose making the following changes in order to support that; if these
>> are okay by you there's no need to send another revision.
> 
> I'm perfeclty fine with the idea, thanks for handling it. Just a
> comment/question below
> 
>> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
>> index f97bdf5..a4ab67e 100755
>> --- a/tests/btf_functions.sh
>> +++ b/tests/btf_functions.sh
>> @@ -110,7 +110,6 @@ skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{
>> print $1}')
>>
>>  if [[ "$skipped_cnt" == "0" ]]; then
>>         echo "No skipped functions.  Done."
>> -       exit 0
>>  fi
> 
> Shouldn't we get rid of this whole if block then, similarly to what you
> have done with the other one below ?
>

yep, good catch, removed that too. Series applied to next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Thanks!

Alan

> Thanks,
> 
> Alexis
> 


