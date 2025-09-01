Return-Path: <bpf+bounces-67097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C655B3E045
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091ED3BE1F6
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52530FF3C;
	Mon,  1 Sep 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="et4Rb/Qv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dMftVWuH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD630F809;
	Mon,  1 Sep 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723017; cv=fail; b=p+ZONDBLqcj6QUJXrJS3b5qO3J4sHqExCBqG+SJNLftgtGwwJVV8rqldQEgZDhCrqwg+YiYCLnA5Jd+h/vUmWwsF9qnKDIOjSF2nJBmJZGDtvX5zHqsOnzyU79TihrGAes4LfysJgc/mFBCx051x+EBNQWFrYBc1iXCaERsK+fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723017; c=relaxed/simple;
	bh=L1T0kKvF0utv21EI6/xBtgXM7ZhIS+/9EqSNOFzxQtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SzY/3YsqfgF2pTFVex6uhEnrivN17VRhxv6u9sLm2SE1cy0P1G2oryzSIikz4HnKet57gzxOdSIG84fXF/KBDCx2YHKEwvHkKn0DM/UfSjmdk7LIyVWaquUMVjkiyLCqXlHCf2CkzqXgWBX6LOB4uttMI9YTk5tVBQ3DJkrvgYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=et4Rb/Qv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dMftVWuH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gN8x016488;
	Mon, 1 Sep 2025 10:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CRR5nrLQfNe35I79TzyWM/yuXW9sCFB+G+vCRX1mcdM=; b=
	et4Rb/QvTgXXkwlJ6oINcvmG13/310u/JThPtVkOtd30IVPkWj2Pmli2VRlTwmRn
	04Q3ZrE7BvuiFuoyNvWg20NH/eHuQmUq7RXH0L4Pa3JOl5sOC3m7/5JnyxE748gU
	ofglTkVbXh4w91YIAlEbQz5UWUdP7hX5aJmoyt6sHRFfEYnTkpbDM6yAnmKt5Nl4
	wDJ5oT3lTRAlboP9asf6om+3NhcYxBamkQaaDJ8bfFihsW/B+/EVaSdfGpEkxVq4
	0a6UtA8wb250jTkeWzHYp0bpsnngU9AqnW0lZ+L50CZCHAemNGsWrjYxVo2hPoaI
	N+LG19NFgQEH1he7OAHqnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvt7k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:36:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5818TWbb026754;
	Mon, 1 Sep 2025 10:36:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01m8p8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2FdNMrmeepbqFCAw1FL9p/iNgK1P/pepzskti+9+Zg49kSqMakvVotemk79HTUs8ECs0udMTjeGsRSsJtGpcgGVUHXyLKg8guCzxQL5SH637GCiPATgBmv7N7U8dXka+GELjrd/fRpFAPZuQZBqc2XbxgUSz+t/piGZPuz/pRW+covjjwVpSXYzUS86jHUjjPykx0KB5hGX42qUP16kw8LS+j49pm5v6rSNYy2FrMTPXjPgxOZJ8vWuANrQkKSKIAFyp9JGrVzXkhJdFWV17uBVYx5JRd+RkQkZxWz0mnqgZjOkI8AgkU+NyYG2dbZG0C6JQsF3++UKgz4pwQOG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRR5nrLQfNe35I79TzyWM/yuXW9sCFB+G+vCRX1mcdM=;
 b=plN+dXN9v+Xybphv2mKDf1rO7E3ShrTAtOTsOTrLkciBgEVvhADgdMwZJOMsL5TTcgbJIew2Jk4KPfsmCslYasx8ii8lQOtffbUyREQ8oXvPgpp3eqF3PJihk6xCWttodViX2yD29RDgLeLKMET5ZSykShrB9QNfukacceCah1++j6A+9ywhS9JGIy6h5ripV4Ex04LZ73vygvCUGpKsYTHGCCJTCPcasJRTXXkjExWkGyAadwIB2GJ8YhusCCSYfJffFhEe0wNNv5DQKZWymLd9laK/EaWfEEhQ5TM1JAlR8ujrQu+YSTLFssxMtOB+0ZEkZrUy199DbjFYlefTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRR5nrLQfNe35I79TzyWM/yuXW9sCFB+G+vCRX1mcdM=;
 b=dMftVWuHxeAo1x5h1cXkEqDoRAKIkYEBAmCnFK0QrDmQRADvm2spVJ7Xaq/DMuordsZ1YNq3QHY9PbjjHn+mo2zC3nhtrzPPXyANEvVcrc7CvDHbeQYdPGMgtZtfl+OLpBmucz5F5/wHr9g3GJIFTQ1FzO+lkDySEmiOFILT5hU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFEE36F3C1F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 10:36:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:36:08 +0000
Date: Mon, 1 Sep 2025 11:36:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
Message-ID: <9179bcd4-db43-451e-a4b7-77eb5b32d097@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
 <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
 <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local>
 <CALOAHbApv0Sj25La7EQZg7UBxfvkfMXpGPtNrYKABSYpNV6ORA@mail.gmail.com>
 <a4d0857f-1520-49a2-a717-3e74325f2d6f@lucifer.local>
 <CALOAHbBaC2sd578CCT_15R64P75MAtYopm+pDrRqmOJpaOB-Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBaC2sd578CCT_15R64P75MAtYopm+pDrRqmOJpaOB-Dg@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFEE36F3C1F:EE_
X-MS-Office365-Filtering-Correlation-Id: 5107cc67-6846-4178-5dc9-08dde9435ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zy8zSmJ1T2QrQ216dEVFYlFUZGRSMTBOOWtqeVhod2YzeXFLN09pYkQycWph?=
 =?utf-8?B?Q3lKYTMrN2NBUnlpaDFUVWhnM3lqUTBZTmhJUEMwNitrQmtTZTJqOFNwYnhX?=
 =?utf-8?B?dnE0QkhyMUJGQ1VHOEhiRmJPRkV2Nys0eXFydG0zSVMxbC9mNmgvT0hmai93?=
 =?utf-8?B?S3ErQS90SC9xb1BMK2xtaFcyWlpTUHVoR3QvZWJnM25xcXJhc0hJVU5tMTA5?=
 =?utf-8?B?UlVXV0Q4T2NWcTZoU0VSWTFLcFZ1cjR3SVBOVXBQczA2Q0xZYzVqMFNncXVX?=
 =?utf-8?B?b3Q3MkNyNFJITnFaQ01iRlBKZk15NDhQenRlMXM2akFZb01HTDBIWEZuUTl0?=
 =?utf-8?B?bTBoN2JUR0RRN2RRUlZ6Y3N2NHpLQ0FPY3hLczBOZmNIL0grcVFrbXRyajNZ?=
 =?utf-8?B?RG5UZFQ3TStzdlhoRjg4a0FHRmtVbUlscjZJRmlPcFpXZWZlK3pFNldDNnFz?=
 =?utf-8?B?ZUtKU0x0Wk94bmx3Q3RpdW45d1poTk92YXE4eGZ3SEp5Z3FYeEs5V1BEK0hP?=
 =?utf-8?B?RUhnMjVDMGZmNHZHbkovL1B0YnVIWGZjT3FCb3ZGRFdvNU5wU1d2WjBCY21N?=
 =?utf-8?B?eUZmOStJSXBPOXpZZE9xbStxZmlsNHBlSDgvbS9CUVhxQkU0b21DYXo2dVRK?=
 =?utf-8?B?WUtrbkl3eERIOE9Bam8zN0JQMnlRNHVZUzNaY0FPaXZqaEdFV3VSYit2MlZa?=
 =?utf-8?B?MU9jRmM2VGU4aXh5N244dmRuMHowZytxMnV2NURlRDU3Tzh1QUlMVUl4NU91?=
 =?utf-8?B?UUJPNzRFcllSeEltZHNwT3RtVWtXTFlUTzZrU3F2OXBFWG9HUlFDRTJqTDVV?=
 =?utf-8?B?MjVKdmo2eFdhK0lzVkE2Ri9uL2N2VlN0RmxQWXhweXNyejZxayt1MGUrc0VD?=
 =?utf-8?B?WE0yUHpUQXBwV0MrVDhZeHR1bXUwbjVwdlAxcml4bnFxUkFqSEVxb2JIcGp0?=
 =?utf-8?B?RVNJSWRuRDliSFdKdFI4OUJTU1N6eTN3SHhWTUdnUTVldWFKMElkV3hYV0dy?=
 =?utf-8?B?a1l0ZThrSHJqMGxGbWdDSUdSczhXRHVYbGJwMkx0L0hBcVBLTlByanF3UDkr?=
 =?utf-8?B?cEo0SlRNVkZWcnhCZytoWHlmT2Z4aU51ZVd0NlNINy93REFUcnNXSUtaTUFi?=
 =?utf-8?B?ajJZMlVIOVZveXU4QkEvbmo2eHdpS3BmOUs1L3dJbnNUa1J2ODhTMG9MaSsx?=
 =?utf-8?B?UFhiQkFiRG53TmNReG9BbHdhalc1a0dtRFh4T0VkYUc5UDBudGhVYmw2R2t3?=
 =?utf-8?B?aUx3ZDkrL3oxZ1pOdm42NzN6OU5qcVJ2WHpzSDhWNUMydzZOVUJELzN4RjZq?=
 =?utf-8?B?bHBCYWthN3Vob3B3Uk5pczl1T0xqaGZPTU5lTmIrZ3hUQXpoTjNoUkUrT2xn?=
 =?utf-8?B?WXdha290b09GQ3hLUjliV2tEL1ordWNoWllPd212RWNkOFh3QVVWMXA5S0JM?=
 =?utf-8?B?S0lEbmVERjhLRUpCSERMSjdPTjJDSERpS2t4cU1JdXpWWmhyODB3M0F3Z3Jh?=
 =?utf-8?B?YXZ5SzJPQnU2Mm5wekNYRk83YVhHSGRwTThiREllY3dKOVdQMEZYa2xoblNZ?=
 =?utf-8?B?WkEwczhuYkVsRDI3UHpuODUrSGliT0lzU3E3UCs5aVFWbE9rTzQxUTlIUEhm?=
 =?utf-8?B?NjczVStZL05ZeGkvSkp6OE1BT2RFdG9hMSt5ME9hQy9yZU9tTmpzdEZSZEZz?=
 =?utf-8?B?OEhzQ2Q1WS9RV2tzc2dkYmtYa0E3OGdCUXUwaDU0R3FnRmt4UUU2SXhiaVYw?=
 =?utf-8?B?Q3FucE1aNGo5SWZPNG5Kb2xYOUl6bXhRU3o1ZjVYVktTQ2k3eFdFMGZzMFdP?=
 =?utf-8?B?SEtORDZZTmZKemNPcnE1N0g5V2xsZ2lyUUcvT0lMMG5LbFBqb3ZYTDNDaVpR?=
 =?utf-8?B?bU1WNmJVT3ZxVlBmalF0VCt5WEZVR2Vnd1NMQTcyTzRwOXVJRVdlSEZ3Y2Fp?=
 =?utf-8?Q?+BfwrVQ4MHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2VyVWZXODZwczZ6OStkd0xEbDQ5U0oyVFphdDhFelZHQi9YYU01Qy9OQUlC?=
 =?utf-8?B?aEJlbERxR1ZNODBtSTg1ZExwRlJtbjhVQng0UndRZnV3dkRPeEZ1a2hHSWc2?=
 =?utf-8?B?dHZwZENLak1yV3o0OHBUL3FLU0ZSQjZNWmE3a0R5TVF0bTY2ODhsR0hKQVNn?=
 =?utf-8?B?N1cwUWNUVHhjMVJ2eWl2aUQvb2N5bmNwR2pTd09tZHAwMkUvdnBhaW02bmhZ?=
 =?utf-8?B?UW9WU1c1QXo1R3lMV3YzMkVldzlPUWowRmpIYXh0SEJLSlFGcS9lZmlFU1Fq?=
 =?utf-8?B?OWVIRDNNUjJaYytrckQvdkJrSVVxTWN2Z1gzNE9qdU5QeTMzWVhNb0x6bjlL?=
 =?utf-8?B?enZxMWczM0g4UkxqWVFqdms1WHMxVFdFVWRtK2RuMGI3Y0hKZFNINjVPV2pK?=
 =?utf-8?B?VEZ0Vm5LZDNta014bU5vcnZEemdRckMzbjUxS3FqOURzdFZjQkxsWk5YVExR?=
 =?utf-8?B?SldsMlVMTjk1UnZkWjE5dE9CRStraFVub1NUa25vM2NoaUpoYnBZZVFWdDJU?=
 =?utf-8?B?N0FUWlVMaGM4YkdudEkvL2hiM2ZmdVAvQi91cFRkTC9BOE5NUGpUZ29lZjdE?=
 =?utf-8?B?SStxSVZrcmhaS0ZOaERGZERBQ2ZEQTJKTTQ2SEdVNHhmLzlKZUQ4OCtGMFpx?=
 =?utf-8?B?SkpMOW52SGpMektpNXF6dWZOM3ZjbFdHaWExMGFZUDRKR1FiVkRKWWZKRkVo?=
 =?utf-8?B?TWFwRnUyR3RrU0FYSUFjZVFBMVUwTEdSWjFWN1RVUklhYklvVVZGK21KeWlM?=
 =?utf-8?B?RFJ2eisxZ0FHRGZEdG9xbjZEL1dTZFE4UW1YK0h2Z3MxSWlGMWNDZWJrdjZW?=
 =?utf-8?B?WjVmcDg3RitFWjh1OGZxZWYwdnZrdkF0d0tFZkd6bzNVcDRBdzg3aERSNjJp?=
 =?utf-8?B?eFltcUZLQTl1Qjl3WEZ5M3RHRTYrMEIyYWd3SC9iSG1YM2lHV2N0bmtwSUYw?=
 =?utf-8?B?bkZqdTF5ODE4VllrYlkwMC9IMkJ6UkdHd0NZTC9DTHF4NkVycHFLY2ZQK3Q3?=
 =?utf-8?B?Q1FtNi9rdjJyTUlEamxRQVd0d1pkTFVJOStIM29JejNGVy9xNERCODRMYWpI?=
 =?utf-8?B?SnI5ajNpeHJNVVhuUTFjVGNSMEFlQnNINWRBWlJZYmlCbFpqMGVEcWpLaWc0?=
 =?utf-8?B?eWViNncxVjVtcnFIbWRIazVIVlNWTGRoS1MveVA2WFk3K0hROTQ3Z3Yxc2gw?=
 =?utf-8?B?K2VrbFl1T1pGNWZ3WlQwdS9hM1JIUlVUcjVJRDlqSGttSC9ocEVHTE5mQWVW?=
 =?utf-8?B?Q0RGZXYyWjNjQXR4OU5weUdtQkd6Qk1iTVdXY2JIOCtBcXFrOGRySHcvRk9D?=
 =?utf-8?B?VnpmOUc4VmMwU3laMmtleVA2cGV0R09RSDVGeFBzYmw2OTdhNWgyZy9SQk93?=
 =?utf-8?B?WkduVWZhaTVKalRsZFBtQUM4NVZMWXB2a3h1eXlxZU92ckc2ZmFMWFEzTDN3?=
 =?utf-8?B?a1NSZDZSRFlUZGlxZ2lYbVZLdFVOaVpDVzdnWkRKQmFscmNlY2YrQnI4NFZj?=
 =?utf-8?B?elBab3F6VXpkYTNyOHlwc01WdEh2c2paNWYxaG1sVTMvMzdkNzRrQndzTHBF?=
 =?utf-8?B?bkhla3BFbEpESVlrSDBhcVc2czEwUndaZkovczBGSWVKbHB0UUNVbVlMbklN?=
 =?utf-8?B?RFJWSzc3UVBMOUM3M3FQMjg2OFZISlhveVo3T1NCUFBudDZ2bHNhQXJxWE92?=
 =?utf-8?B?TisvVkpRR1hHZjVHZ1Z0aXA1Y01hRW5YOWtDMDB6LzM4VXg1MmxBMzU5Sk8z?=
 =?utf-8?B?aFhLV1dyajlhMmR5Q2x3MjA1alBMUG5GVE5WTmNlbzFhTXNOLzdBeXRrQ0hq?=
 =?utf-8?B?SS9zN3c3a2w4NHZNa01lNVl4aFYvYUpqaGJGSTRxVG5ZU2ljMkZRQVVmK1Iw?=
 =?utf-8?B?VFBwKzBZNjNiejJkNVR2eHBGSWthRTdkTmNrLzRBa1p2TnNVUkV4Wld4V281?=
 =?utf-8?B?Q29JT2x2Q0QveC9rV09qUnRld1FRZHBuWHgyMmFVaXJoWnU1NHo4aFZabWJa?=
 =?utf-8?B?YnVleENFNlpydkcyZ1FUNVNxL000QkdrVmNkZWVONHR6c1FPbllKK1JUcnBt?=
 =?utf-8?B?UnhpK2Uzb3MxZldxS1RSdFJERmRTVVFucXFjekltWjhmWHBQNHM4Q05ncXha?=
 =?utf-8?B?RmZBK0RNck9rNGFVaHVLQi9tUHU5YzZBYmQ0aFJmb1B5MjREdkNQSUdZVHZ0?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Piu6i7HSYRLkBYp9xmrM7Wt7Og/SSeEoxHIx4XtrawnqQVKHQ9zBjcGuEI7xhIg4rUqt2/yPfuIpkujNWH4WGdwG4AQdjk/y8TGMva2qTVmbAJE623JzBSSAEXnL8yfjqDhW1dBARXXbgpGN103HoM0nPs7v3aHQfqrYsX1MiNKkksJRlngoMSjm4jKHzkhJXZY5OI44NET/qj5n8bhk4ndtBbMck+J6QaZVzx9XqUAypKzIO7XdVxTCcjjBRuz1LnmLz1FGMaLm0l2l0BPKDxoJmeeQ5fNnzw6eGYPAoeydze3oyHEWyS52OfH+FzBgcXa7J20QpuWfAASwxaVS0RHlpSsv0zn0w6mQTBbweE/BmBxWzXQoQM1+zu6A+NO5wodfeFcE+Oa8haiKQrW1wQo/Rj75fSqYEckX97HYcMcPYxqSyBxfk3vevT4hVEH7eTqguqoM/isxoBLhCDUZ2DC8J7q7bDbVypQf3WjLMURisRQNxaU4kPjWLGwp7Yab4Xza0TnGZzmOi2KxXNB7nLudiqJ8wcJ50C4qFxhqCnzHhdA30QSwxVhs7dFS3VZSOwERA9DV1gxS9rjDSdBf7jsB0Xd64oFSzytHZHV0U3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5107cc67-6846-4178-5dc9-08dde9435ceb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:36:08.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+B6ioR06CLt/eumSnYDTCPqUdYw3vhu93p4QN0tj+NiVGTWzwWBWwvlXHEyE4kkico1Mlx+At676/MphUZmZQNQy6Fxjlz73XK9qPDVp9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEE36F3C1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=796 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4PGuL8wZyhb5
 SqHoID9j5LB/mGISf0kFUOrJGTSTHg2KsjYMB0Lb0YOEpD19+fAzb01sOsdlS+7dU+fJdYubnKt
 WAWjq4+04VJBRM588anLoywnBT4Osq2UPiQRaMGVe+bC+xPb8UjWrMalx1Zqxt5X3oR7FnfpHKn
 LyIeeAJZ7zRSnURMLZ8tGkagehmYVswF8Sw0qxfdMIG4SHatK57hXZNIXcSsJMBEhpGl0Y+gMC1
 PWwtOcKDy35268hUYwxZQccRzwXg3Vl+HcG1j4ehOncl6ddY4sk/iFiLsqqh0/YyU8ExKXtGxEw
 nnvMmSDmQG0anRSKqQRqRVRUgAmVoSdG4obQVxc+OPazYsWKuhPuUVNWWEt6RxoT74PQc4UjgPX
 E5LANJMY
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b5771d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=r7DYRul_BLxhT-Vn5vwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vXiJbTGJktn_uKzgIUEL01hFrj0z1FcG
X-Proofpoint-GUID: vXiJbTGJktn_uKzgIUEL01hFrj0z1FcG

On Sun, Aug 31, 2025 at 11:16:27AM +0800, Yafang Shao wrote:
> On Fri, Aug 29, 2025 at 6:49 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Aug 29, 2025 at 11:05:01AM +0800, Yafang Shao wrote:
> > > On Thu, Aug 28, 2025 at 7:11 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Thu, Aug 28, 2025 at 02:12:12PM +0800, Yafang Shao wrote:
> > > > > On Wed, Aug 27, 2025 at 11:46 PM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > > > > > > Every VMA must have an associated mm_struct, and it is safe to access
> > > > > >
> > > > > > Err this isn't true? Pretty sure special VMAs don't have that set.
> > > > >
> > > > > I’m not aware of any VMA that doesn’t belong to an mm_struct. If there
> > > > > is such a case, it would be helpful if you could point it out. In any
> > > > > case, I’ll remove the VMA-related code in the next version since it’s
> > > > > unnecessary.
> > > >
> > > > If you lok at get_vma_name() in fs/proc/task_mmu.c you'll see:
> > > >
> > > >         if (!vma->vm_mm) {
> > > >                 *name = "[vdso]";
> > > >                 return;
> > > >         }
> > > >
> > > > So a VDSO will have this condition.
> > > >
> > > > I did a quick drgn()/printk() test and didn't see any, but maybe my system - but
> > > > in any case this appears to be a valid situation that can arise, presumably
> > > > because it's a VMA somehow shared with multiple mm's or something truly god
> > > > awful like that :)
> > >
> > > Thanks for clarifying that.
> >
> > No problem! These weird edge cases are... weird and hugely confusing. I should
> > document some of this somewhere, as it's at the moment more 'oh yeah I
> > remember...' then having to dig through to figure it out.
> >
> > The "/dev/zero file-backed but actually anon if MAP_PRIVATE'd" is another fun
> > unique case.
>
> It would be immensely helpful if you could document these cases. We
> truly appreciate your contribution and the time you've invested in
> this.

Sure I will add to my TODOs :) I agree it's not great that we have these odd
edge cases and do not document them clearly enough.

Will get to it :)

>
> --
> Regards
> Yafang

Thanks, Lorenzo

