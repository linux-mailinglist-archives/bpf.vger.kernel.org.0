Return-Path: <bpf+bounces-66671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD1B385BA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767B13A8A55
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334427054C;
	Wed, 27 Aug 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltmp5ptJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Ps8phpU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03717E0;
	Wed, 27 Aug 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307128; cv=fail; b=mkStwaLNgamTSd5gWvhR0Vf28j2V/N87fO1tlwZLpkVoHew34AQVwJT3Tbk5jrR7m7yU91/okn34ASMxzmoVn/iUJqTS+s8mznuj6PGVSvtTqI1HJUZzArhbCpyZkglKa029giPGDS7y0Pk77ty1Eg2DvlWS4FpJ82rDNhUvw/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307128; c=relaxed/simple;
	bh=VuUePPEMfBHR2omC3F6gsH4GOF7th1j4ytUVX2NMhmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQS6JM4393etpoi+8p9a/8k/WDv7OBy6IFOtWpREnC2P5hsd+BTDDllNP1vj+GbVEBz9eVFzqJRqAucLMENf6MEFJ0+w3kU+uhfhrz+prcy+iyWJ65a0EzzPmdxpRSm8Li4CbZCh/ON5RiDavdnL22SQ2iV1h3anCIGEwGBi6Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltmp5ptJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Ps8phpU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7uH7G001500;
	Wed, 27 Aug 2025 15:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7KSvaTIwGdFpiG7pHFsmMhnmmm7FxdswWy/rwX8pzcE=; b=
	ltmp5ptJ/lnkK8qv2Txjw7mgXm6cSKO91rzjFs1weTRULJ+nPG1Ew0n07BqwXH40
	ynCafs5lOEnrL4Wsr6MbYWbBWzfeBFq47JF9lcAQ2nRKKjw4xj7C3w85C3MxPS4q
	ISqeLuAXfHe9pFy0XMhMpKYGUWIRHYighbAH/QTvpozZ/SP5YzKdrGVilILS1fBG
	L54qhgRoLfSUeyMrne7+NWahDUQ+7j9MVW3mW9wDyN+g82za5bVLZx64Nd3oPimo
	RMUe98/2NdOtTKOsQOExzw8VftxXKYNfwT0kzR/v/MDoS7Zq+onNMNSj4ZCInnxa
	BvybVw5mx8f392SDumlIZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e26r15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:04:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57REciqq014639;
	Wed, 27 Aug 2025 15:04:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43arshk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdHEOv6imD1rX2G+Lrq2yAPb1PCW3+e2gKFBnqyVRtOxVGJH6ti1m9GrB7T45hQQWirykjA/Gs7bpYfQ+qnWFpOJaIoHKKh9VXS2/JPPtCMOZEsEb6lATUnOIFVPrag66zGAY6a6o7142RQsgb3t6Jer395hn4sfP5l6J5UcWlOHfKW426OR5DkQio71L+FP16CL2LdEgDwdrHWONYMcnqND+1BPwvJpCNgbSU+yq8KoGmVz4fEjX3mjG9VbQ60PW3VZ7epm6f3sQry6MCunv69/j/ofSgDnAv9q13S6DK9Y5YzRwMwp9p7SFSfVXUxAxvB9gFawhLwIPv9fchQvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KSvaTIwGdFpiG7pHFsmMhnmmm7FxdswWy/rwX8pzcE=;
 b=RDxhMBmD8a4SM0dIgxRl8g7CO3Jl7NpMOKn2H5Ok6FCxB3L6rnZcsbTq5jCjZnUuxxcRhoM4+vmjwpiOJT+ZHccGxsMi2sjubig9A9xsjkviNzrT1DozSE58UxMh+OQhOgo+M1E3Lorgydv1wQa+ukzH4SEZisbm11bvVuDwPgNiZhBNoAdxp9HcfGMVTerX54efSQLT8LrvcVGsqkHT2/W/C8akuh0VQKakYI0G/Tqwa0iw2ch5xW2GmUzTSnt1rLHGeBJa/jX900Mv7+32G8t0i7AgCRRUtXiEYJrbbyXRkeFBXyqxEKy6Sym3cX4DoQuLU3RbmeXc+j3Z+spjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KSvaTIwGdFpiG7pHFsmMhnmmm7FxdswWy/rwX8pzcE=;
 b=0Ps8phpUHDE20HlH6UtyT20ZbrXR8Hn8Ib6fKkcOC0AIOL+vs1ElA0hBnqopFTvPOCLWar8r6Kk0l2UYr2cZNl2bBOfB0ll06UCATXplvRIJ07bmDTZLhNqkwOfoDEUnIMxJ11F/nMbK3+FIut+CRRJhYUE2aGHfQhjZhDIwRoY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF76BAA8D48.namprd10.prod.outlook.com (2603:10b6:f:fc00::c31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 15:04:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:04:37 +0000
Date: Wed, 27 Aug 2025 16:04:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <9595e367-1274-4e66-aaea-d95afd2bb933@lucifer.local>
References: <20250826071948.2618-2-laoar.shao@gmail.com>
 <202508271009.5neOZ0OG-lkp@intel.com>
 <CALOAHbCtE-Sjeja3gzGwooWcikGWetPj8k6wqk52_c0hEo5ZKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCtE-Sjeja3gzGwooWcikGWetPj8k6wqk52_c0hEo5ZKQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF76BAA8D48:EE_
X-MS-Office365-Filtering-Correlation-Id: f1639ede-6e2b-4b0f-4583-08dde57b0a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JVOFd1VG5qeDcxQ3NhT0hVazN3ZDZpeFZlMXpDaklqRHRqTCtYa0xVZWVN?=
 =?utf-8?B?RHM1dkN1M05jdm91ZkkzSjBzRTh1UW90KytnSWhodUhBaW04cHliNitmYXk3?=
 =?utf-8?B?NzlpU3I2NlV4T0dOZjJ0R1BoWkY2MUFRc1BSTmpQQ0lQQ2FGNGFzSkFlWS9j?=
 =?utf-8?B?VHdnTy9hcG45ck1lbWtldlhhVHFQK1lPYmhQVnhxdS9odnUvVUg2SCtYMnBv?=
 =?utf-8?B?SnV1MVZaU2JWZHQxbVRiY3VSdUdSeXMwMXZuaUpKSUpNTWZWV1pGOUZxMEhR?=
 =?utf-8?B?RGtkY2dZSTFuZk9XL0pTQk16RmJ6eHl4bTJCRTNDL2dYbXRMQzNxdHgvNjhJ?=
 =?utf-8?B?dGI4ZDF0ZFVTVkpGM1Z3djZSRXhGN0c3bWw1ZjRua0JSSnBWMEhZc0w5Q01G?=
 =?utf-8?B?QVB6Q3hzSDh0dFcwVURMVGNjbXk1Vld2S2VqYmo4NE9SWGlLY3lEYnhsSDFY?=
 =?utf-8?B?ODBrQUFHMHNybDBScTJDRzd0aUx4YWFPSWh1U29KS2V0UWY4ZlBmblpLeXRB?=
 =?utf-8?B?ck5MVVNVTm9xY3h6aWt4Yndmayt1Rk5TYitHRHFhMXVWbkZvN3k2WlU3N0x3?=
 =?utf-8?B?UjVJQmpPcmFWT1hsMWVrSmtYRUhYTG56alJEeVpabjI1cWlRMUVhMEhtQ1dI?=
 =?utf-8?B?U1B2WjJRSzQzbmRITFp5Rjk0eDFac3lwazl5VytSMm01RGZxWXRXVXl0VHg0?=
 =?utf-8?B?SGt4a3Bqd0Y2UDB3Y1JlRkpQVXpSSE02Y3NzUkdYNVRzOVl6ZXRFOTJyaWJI?=
 =?utf-8?B?N1Q0ajhQbmw1NzFCdDVpbkw0aXpFQW1ISTM3aFYxQjNTaUJUNTNhK2dSZmZl?=
 =?utf-8?B?UXI3U0hvZ1BxMzJJSFhsZVAyT3hsZHNpcHBIcDYrNys1OVU4L2NIQmJBblhJ?=
 =?utf-8?B?RWc0M2NNTDBvR3RlN0ZnVzQrcFpvZjN6TURsTFdIaSs5WTFSQi9RcFVKNXh0?=
 =?utf-8?B?ZUNMbzVROGRxNytaQnRYZ0NLN2tMeC9VdkNoUm5JMzBNbzAwM3AzNnl4S1pM?=
 =?utf-8?B?NmR2VjR6THVjdm90WlhJRjBQUFdMbTV3bjQzZHhLeEJJWWcxWklCcERydHE3?=
 =?utf-8?B?QVF0UTdZUU9xaEYxZnk1MlB2aE1manU0VDRZOWp2SnNLcnExUGVKY0RqNVBG?=
 =?utf-8?B?UUk5cS9HcldnWGRHNHR1MXF2ME00Q09NejhhS1dxRGpBeDhlOVNJMW5iVWFW?=
 =?utf-8?B?c3NWTFBDbHc4Mys2eW9kaFRTZEdUQStUcmtXMEVjQWNMMEJKRG8zTzlUWHhY?=
 =?utf-8?B?Ym1NN3RBa2EyYm9EanBsSXZRK0dhSFd1YlB0QWFVdTdWSHhlR2FXdzF0b0ts?=
 =?utf-8?B?V2FlUCtpWGlrazVJcHR4SE04QXVraVdLb1c2ZTM1VE84QlJIVzFiT2tSSlN0?=
 =?utf-8?B?SVBUZUh5aHpNcUhUWEIwbWdTamJWNWF1T2hmNWcwbmJGdkh1VjJyUWEwbHNW?=
 =?utf-8?B?eUlFQWlldnBZSGhJOFViT2NRWG11TjFPSzNaeDBkRHM5QTFDRnJLVmJ6dzZo?=
 =?utf-8?B?Zk00ZE5jMlJaUTJGSVRkQVgvSHg0V3pVV0ZMZkExbnlKTkJqRVBYRlMrOFMy?=
 =?utf-8?B?Z0lrOUduc01jamFnbjdlek5JL3ZjRzV0SzNMOXVMcHpMRVBFZ1ZSdjRCOXJG?=
 =?utf-8?B?Ni9sUDA2YXFHMkhLdDZGNDZrbGkxa1VQb0RYeWRKMnFjWVp6V3lpNW81alZ6?=
 =?utf-8?B?a0dZOVYrdDBDL2p0dGlpYkNyR0FUL0JuY25HYmFWVGlZVmQ4eTZzeHlRbXN1?=
 =?utf-8?B?cFZGU1BYT2I1TncwNStLVXpERWVURVByTWNaTWhZVlQ3blgxUlBWMWVjSVcw?=
 =?utf-8?B?cGU4MUVCSnR1VUdnUGU4Z3NtaENlQUsvOTBSekFzYzFaTTlLWGRDQXBFc3ZC?=
 =?utf-8?Q?Tfa73mqXUGDEU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzR0c21VcU43MmM2b1ZXZStPUm5PMDUwcnBLSkNJODl5R0xQVkgvWW4wazJo?=
 =?utf-8?B?dVRmUFlnSXE3bHkveFhrbnVmdEdnaWlHYldSbFNtVzl1TE81NGNKTUtMV2hm?=
 =?utf-8?B?d1lhU0w2ZTN6N2w3VHlIOWxzTGpvdmg4QnV4RDdkYTE3bmFBRWxLTThpNWhs?=
 =?utf-8?B?bm4zNHowTmtGUDN5Y3UrSjVTaUNvaGJTNFJuZUFrSkNmUmp4LzNCK0I3bXN1?=
 =?utf-8?B?cG9jb2NFb21pTlBXUExxRVBVNTBBcWkvSGpOVUxTbUNiZC9pT3Z5Y3FVdjRD?=
 =?utf-8?B?NC9NdGQ0VERBRHo3R3FNVGtMK3lMeFVQNU5aM1dsZ0ZLQjlTdW9mdDhiay9Q?=
 =?utf-8?B?NlVsS1puY0pWMlk5ZEFzbnY5ZWRPWDhLTmcrMVQydVRNZGZwVDNPYjNXNDcr?=
 =?utf-8?B?N2J0ZFZYc3hoajhqcHZLZEw1U3hiZ3JPdHJWWGE5WHhnSE1OSXd6NE5TTUk2?=
 =?utf-8?B?bTNVRmZpckllNTZmT0lhdkloeGFkbWhkd2UxY1JBZ1laY3FpdnBoVHJmTHU2?=
 =?utf-8?B?YkluUDFoT1VuZCs3WDhkd2tiN1NTOXc4KzhkT1hMNUh5QlhIamUzTWw5VDRU?=
 =?utf-8?B?bXk5bDBxSXhxM2VwTUpLcXdBdDhKOHl0RklxTW9kZXlmbG9Xb1RKWVJ4d0g0?=
 =?utf-8?B?T0kyZ0VoaktNV3hCRTdKRzA3Njl2Qitsd2xFYmdwcy9SdFYwRlVxdjVGWUI5?=
 =?utf-8?B?Vm5MQUh4MmgrYm1aZHFVSDgvWUg0Y1RrTDBoUktGYkl6eWdMRTZDV0dkQUdG?=
 =?utf-8?B?R2pNQWFGNXFJRDFRU2NXRDFGenRkR2lkRCtCaEZwcU9ZU0VOSmRGM3RlQmVv?=
 =?utf-8?B?YlFMNGhaQU11TitIL2k5VVJFUDdhMGNxV1Y5SXZ4b1JmbSt5WEpoTHJuQysz?=
 =?utf-8?B?WTd5VThaS3NkTThGd3ArQ21rQktJQ0RBKzF4K3drMDdWdFVaRjZPaXJNSWlB?=
 =?utf-8?B?NCtxajQyZnRyc1RLN1ZVVENpTmFlN3g4bkVLWjF4ZDVYZWw1WDlzWnBLQVov?=
 =?utf-8?B?K2RmR0s2UC9Qb2Q1b3VxOHZnN3Y2OElLTmlsaGVOZEhXQ1M2ME4zaUlzaS9r?=
 =?utf-8?B?M09nSW1UWXI1Sm05NS81Vy9raGdKczVjeENNd01DQ0VOcmc4V3hROWFveFZV?=
 =?utf-8?B?bDl0ZmZpK2pON3dERXd5WnFqQWtIYUNRTDg0QWprNmxnNzlKTUc3c1pHRTVj?=
 =?utf-8?B?MFl0VG8xbi80SGNxSE05NUx1NHlPYnRvWFU3TllPSytwaXpHNUd0bEptRVgv?=
 =?utf-8?B?V2Q0Y285dzVSbUJkTEdxeUwvb3JBa2lsZGtFM0lYNmdUSkFjcm9EN29KUG1K?=
 =?utf-8?B?WmxZZWRDdHQ3MUlzL2RYMkRET3ZMdDBKTE1rM2Jnb210RzRmNjBXMm9DQ05q?=
 =?utf-8?B?c1JYU0RkSnlpc25XVzNHL092Tmc1aFNscWpYeFYxNnY0b201bU5EVnNsc3NF?=
 =?utf-8?B?SFR6TWdDUEM2aW1VSmdZN1BncVVjT29hZ015dGdCUkpydnlCeFNIK1ZVTmtL?=
 =?utf-8?B?NTM4MXRpckloa1VsTkpVTTY0dGlmVG1UR1VCMHd0TG9leE13OHZ2d1k2WXU3?=
 =?utf-8?B?RktrSnM0dHdSVmZZejVJS1cvOW9VV0srTjZCaUhxeFVCMi8rNmFmYXZOZ2E0?=
 =?utf-8?B?dkRoZlNzYndjVEpKTXl4akdJWk9Vd2h3NGpkYkErZ2phNEg5dnpOSnJsWlc0?=
 =?utf-8?B?RTlOOHRiaHFXVHlUVDJPK3hDNnB0ZkxhNG1TK3RWWUJicGNOTktGOFE4RjBF?=
 =?utf-8?B?SElDSW12RjZHRVNjZm5PeEtjLzJoRDQxdmd2V2t3MTdMbW9oMHBIb0YvdzB1?=
 =?utf-8?B?MktSVjc0MkFhVCtaMDk0SjZYS255emNLL04wQUZad2ZmUW00aWI0MnZqRWpO?=
 =?utf-8?B?alc0SlFMMGQ3MHpiQjVCWkhuTUZqWHhLZXR1OTA4U3VCK1FpcWV1UWhRc1F4?=
 =?utf-8?B?NmFnWU8rVW95VnJpd0ViQWYybm9hVlROZldPNkpjaStxeUU2YUtQMmlKTDhH?=
 =?utf-8?B?WGMxOFVUOVZZNHlVQjZvTktxQ3NhcTZGOUVxSTJiOG9Bb0MveGNVeVdmdTVK?=
 =?utf-8?B?WU5TMVdoQ3ExbTZPdHhCVWQweVY0T0tSTWJZSzBiL3MrbVljMEo1ZVROSGd6?=
 =?utf-8?B?dm5KNURNQUVVVGNFYWhkcnhDekVRSXdFMjNFTXZwZkZSUTFsU05FOTNXSW1Y?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+C64JZBVdP7MNZhiaPnF/cot95P2HmT0shR1T/zrDhwKBYmv7WM5OwjKsMmd4t3AtsHKaX2zLK6sRAbfww7Ok8DD6B0GQMpcVyOXOKm+P6t88lgyd2Pe4pDeHdijiwcciu6HNetR42W62xYBx8kkudIkE2yB+1v07oge4hT0yYTautToUFM+rcm/aHBDPIyo7KBenDnKhyazt2YIAzqOA2mTQV/Ya4wUMczkaUJW7T5RdAJxl5xXz6c1BTk1K3rb0wO1Vtrr0BMBxLe4ewDEdg93ryRNZ8vTynXuGs8ItF7v2tIEMWo6uICxLAFcHhxm05aobb6ICZZLAdAFXMI0iyx/UQcGahn1DvDH5vcJaiufGwHcOmLmRLr3SWFcyVpsWfjKzkbpE49J5FdRIWeiLeXZxjMxFetCc7CCGsuhdnr59Jv1oaysdD6kb7QEKZPcaM2VlsC2NXV5XbltbinFBuqrK0Z0FLyOUsMfxQIllsVv4n+s1BHCFSJ6v1loXHKhGf8i/WLaUkPnpjwijStISrTGYuxkAySxw7NNDrdWeNrKJtr6abnPuDpYJ+SbEJPxksvA/rHT1glN8rNQ8n6de3Z6xmLV9Cji4qQlQDmgBVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1639ede-6e2b-4b0f-4583-08dde57b0a5e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:04:37.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JId0Y/tHmK8M4GnWnlzHo2gEjlbH4jy+e6hIhNbvjCvbMfb1FIb5dBPZa7xlPtNn/HEH38/LnlOneFkWvanvPFyD2xnYkOX88KggPlqUGkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF76BAA8D48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXxbSRgAxzdMtQ
 yaWvmLiP+1oo8XD9GjrpnkO9r9DmWe1wzrvQgHS7yyRIrqcmSJDu1x0OUVzKoGub4pfe+FDFPZM
 IOWY6qioMTmJ4TWh2ZrjQT8JuedvUofnggtFSG5JeUFaw7ZGcb6M6ZGFazbdcjiIT8RrzGwh6v6
 xmFHZjd+sQixAS5Z++iwIbsJ75NEtOEPGd3uUVWokbfa5f+vFUM++wnW4ZEyo+OUaNgKwEo+dAj
 eihl15sqoT90q9qcK8cEoVqOFWPA5UZ5iPoaWOc9xD+xJmYIrtjCJOKDw4D+Ofd0uz/rbC9U3Jv
 zjfdUU2BINPlqMyMcZmZqz2WD0hVUD3ut6sxPAMMsjH+QnOnWrVZC9yyvRZsEYpImYyFuwh6K8r
 A7rR1UYadE3qLptX2bFyYAHs0/8IGg==
X-Proofpoint-ORIG-GUID: Bm_CoLJ7pMwo4w7Dh7z6X_sxUHHfqoFL
X-Proofpoint-GUID: Bm_CoLJ7pMwo4w7Dh7z6X_sxUHHfqoFL
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af1e89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=JI_keyjXabaXLMJ7g5UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22 cc=ntf
 awl=host:13602

On Wed, Aug 27, 2025 at 07:39:55PM +0800, Yafang Shao wrote:
> On Wed, Aug 27, 2025 at 10:58 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Yafang,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on akpm-mm/mm-everything]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-thp-add-support-for-BPF-based-THP-order-selection/20250826-152415
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20250826071948.2618-2-laoar.shao%40gmail.com
> > patch subject: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP order selection
> > config: loongarch-randconfig-r113-20250827 (https://download.01.org/0day-ci/archive/20250827/202508271009.5neOZ0OG-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > reproduce: (https://download.01.org/0day-ci/archive/20250827/202508271009.5neOZ0OG-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202508271009.5neOZ0OG-lkp@intel.com/
>
> Thanks for the report .
> It seems this sparse warning can be fixed with the below additional
> change, would you please test it again?
>
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> index 46b3bc96359e..b2f97f9e930d 100644
> --- a/mm/bpf_thp.c
> +++ b/mm/bpf_thp.c
> @@ -5,27 +5,32 @@
>  #include <linux/huge_mm.h>
>  #include <linux/khugepaged.h>
>
> +/**
> + * @get_suggested_order: Get the suggested THP orders for allocation
> + * @mm: mm_struct associated with the THP allocation
> + * @vma__nullable: vm_area_struct associated with the THP allocation
> (may be NULL)
> + *                 When NULL, the decision should be based on @mm (i.e., when
> + *                 triggered from an mm-scope hook rather than a VMA-specific
> + *                 context).
> + *                 Must belong to @mm (guaranteed by the caller).
> + * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
> + * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> + * @orders: Bitmask of requested THP orders for this allocation
> + *          - PMD-mapped allocation if PMD_ORDER is set
> + *          - mTHP allocation otherwise
> + *
> + * Rerurn: Bitmask of suggested THP orders for allocation. The highest
> + *         suggested order will not exceed the highest requested order
> + *         in @orders.
> + */
> +typedef int suggested_order_fn_t(struct mm_struct *mm,
> +                                struct vm_area_struct *vma__nullable,
> +                                u64 vma_flags,
> +                                enum tva_type tva_flags,
> +                                int orders);

Hm you are doing part of my review here as part of the fix :)

I think a respin is in order anyway so can tackle in future version.

Not sure the test bot can try out patches though? Not seen that before (nice if
it or somebody on other end does though! :)

> +
>  struct bpf_thp_ops {
> -       /**
> -        * @get_suggested_order: Get the suggested THP orders for allocation
> -        * @mm: mm_struct associated with the THP allocation
> -        * @vma__nullable: vm_area_struct associated with the THP
> allocation (may be NULL)
> -        *                 When NULL, the decision should be based on
> @mm (i.e., when
> -        *                 triggered from an mm-scope hook rather than
> a VMA-specific
> -        *                 context).
> -        *                 Must belong to @mm (guaranteed by the caller).
> -        * @vma_flags: use these vm_flags instead of @vma->vm_flags (0
> if @vma is NULL)
> -        * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> -        * @orders: Bitmask of requested THP orders for this allocation
> -        *          - PMD-mapped allocation if PMD_ORDER is set
> -        *          - mTHP allocation otherwise
> -        *
> -        * Rerurn: Bitmask of suggested THP orders for allocation. The highest
> -        *         suggested order will not exceed the highest requested order
> -        *         in @orders.
> -        */
> -       int (*get_suggested_order)(struct mm_struct *mm, struct
> vm_area_struct *vma__nullable,
> -                                  u64 vma_flags, enum tva_type
> tva_flags, int orders) __rcu;
> +       suggested_order_fn_t __rcu *get_suggested_order;
>  };
>
>  static struct bpf_thp_ops bpf_thp;
> @@ -34,8 +39,7 @@ static DEFINE_SPINLOCK(thp_ops_lock);
>  int get_suggested_order(struct mm_struct *mm, struct vm_area_struct
> *vma__nullable,
>                         u64 vma_flags, enum tva_type tva_flags, int orders)
>  {
> -       int (*bpf_suggested_order)(struct mm_struct *mm, struct
> vm_area_struct *vma__nullable,
> -                                  u64 vma_flags, enum tva_type
> tva_flags, int orders);
> +       suggested_order_fn_t *bpf_suggested_order;
>         int suggested_orders = orders;
>
>         /* No BPF program is attached */
> @@ -106,10 +110,12 @@ static int bpf_thp_reg(void *kdata, struct bpf_link *link)
>
>  static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
>  {
> +       suggested_order_fn_t *old_fn;
> +
>         spin_lock(&thp_ops_lock);
>         clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> &transparent_hugepage_flags);
> -       WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> -       rcu_replace_pointer(bpf_thp.get_suggested_order, NULL,
> lockdep_is_held(&thp_ops_lock));
> +       old_fn = rcu_replace_pointer(bpf_thp.get_suggested_order,
> NULL, lockdep_is_held(&thp_ops_lock));
> +       WARN_ON_ONCE(!old_fn);
>         spin_unlock(&thp_ops_lock);
>
>         synchronize_rcu();
> @@ -117,8 +123,9 @@ static void bpf_thp_unreg(void *kdata, struct
> bpf_link *link)
>
>  static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
>  {
> -       struct bpf_thp_ops *ops = kdata;
> +       suggested_order_fn_t *old_fn, *new_fn;
>         struct bpf_thp_ops *old = old_kdata;
> +       struct bpf_thp_ops *ops = kdata;
>         int ret = 0;
>
>         if (!ops || !old)
> @@ -130,9 +137,10 @@ static int bpf_thp_update(void *kdata, void
> *old_kdata, struct bpf_link *link)
>                 ret = -ENOENT;
>                 goto out;
>         }
> -       WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> -       rcu_replace_pointer(bpf_thp.get_suggested_order,
> ops->get_suggested_order,
> -                           lockdep_is_held(&thp_ops_lock));
> +
> +       new_fn = rcu_dereference(ops->get_suggested_order);
> +       old_fn = rcu_replace_pointer(bpf_thp.get_suggested_order,
> new_fn, lockdep_is_held(&thp_ops_lock));
> +       WARN_ON_ONCE(!old_fn || !new_fn);
>
>  out:
>         spin_unlock(&thp_ops_lock);
> @@ -159,7 +167,7 @@ static int suggested_order(struct mm_struct *mm,
> struct vm_area_struct *vma__nul
>  }
>
>  static struct bpf_thp_ops __bpf_thp_ops = {
> -       .get_suggested_order = suggested_order,
> +       .get_suggested_order = (suggested_order_fn_t __rcu *)suggested_order,
>  };
>
>  static struct bpf_struct_ops bpf_bpf_thp_ops = {
>
>
> --
> Regards
>
> Yafang

