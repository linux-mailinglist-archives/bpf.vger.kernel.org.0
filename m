Return-Path: <bpf+bounces-71445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9EBF37C6
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA7EF4ED26E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2962E03FE;
	Mon, 20 Oct 2025 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jV/dmDyU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GOAnKjB1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9F28506F;
	Mon, 20 Oct 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993126; cv=fail; b=hAdWx3UFuK7HTgnX+A0Y0RcyWuAM7K15l3yBDVzCnRmtMteD6j58SE+3xMz2VgTw9a1I4M8k4qIGRzDwcIgDMAz1N2Kz83kBLgxjV5pMbPd3+woJMLbc+wY8vT4VCKliBWeEH1xQOjGmr2lddBzkeFCVTuf1HIjLsCXr79cqA1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993126; c=relaxed/simple;
	bh=TCn+2TfE3Sai6xlvNV36ZF6hiSlEQyfgopF5uU27Phw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b28WrKh+2OpMEoQWxEgo8iFzksnh66KNJzCEg1AONRvBEgiGhJ8UhofDVPv9sWzBcValzPIzAnUOD9y8Cacx9Jqkvt1m2WcRs8IPw+posVl+uzl7JP8ZZAhDeJuVDaSZiUjtH/KIWv1VTyAx3u/Z7edoJM6VAd4kLsKr3X1YxPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jV/dmDyU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GOAnKjB1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJukII003518;
	Mon, 20 Oct 2025 20:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mRSU5dz22XcfmohqBvsHhxds5c1RL4HTn/Q0a3OdjLE=; b=
	jV/dmDyU7cBJKsbkBTlzanlw7PZ+Wzxxz1IOhspgL+aej28Ula7ni7uZ8g/SeTAZ
	36/szXUTQhcqpAx4rQnS/vLFNB2Itn/Zwo67wo2I8QwP1FbYSGh5UMI29WRR1Iqn
	JDFfs707vtgkogxXGTLSAeWd3TzgYyGXt64u/IF+qm8O3KxC6sIhcgoGqSO7bLXH
	Yo0GhqLHL/cvzUrkrPL3EkmUPgz25UAIu4s8pW5fI47Qqu0fFJAYTYt2YYlB8ykN
	bp4TVuq9af54aGF4JaNRCvlZzutxWPEWPggLXtsP+hIIRqBS4i/vjQB/Yxzwar47
	NvcXA6jfvrZozEXunvpVQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypu2ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:45:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KK7dBw035624;
	Mon, 20 Oct 2025 20:45:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc4tpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i76ibDCIY2zcLUqoY0JXXvTua0Wzokv5gfHTkWGRxXUD9I/fmFs60YPkiP74zrZXsK2yuuVjGJ3nkDLcW2gSRPSf0xYg1Q41YJn78ydd0TxmrpJp1NA1GoTlm3OMGnWxMeayqb84tGGSsPS9kUSnp3YKGNZ9FFpPzbVJ6UU4nk2KclFUz4TyTnmS84AJIceFGU/P34wFFBtCLqrDkBec36f93BY3hTiRLt3WnbEWo4IhZ+jmrP+cSOHlUsuqOnEZBiHjOUAZ01JLwXpEfwdmMlnkaCqvqgTGuVuW78knyZOo94EvcMMzByo8NwA1lB6cH272Np+6Fx8HRoMtOZfHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRSU5dz22XcfmohqBvsHhxds5c1RL4HTn/Q0a3OdjLE=;
 b=dRYIyEvCEBLNejytMFvsG2LG1tgIgF3GEfgghW7T5zm4iETsIfRvqTwS8dwmW4H0K2mODJwv70ad7D+NdL9/Oa7Z+1kEplrq0ZONlCIPArI0AE+7nuX9ZiNloon+9RM7mHvqKZH/olUnPhEGgnPlXQB8YhumG9DSz9sDXwz2J93qUd4jPn62WLaEu6p7hpfNH180w+RZdktC/9iorL1QROrVqpL6cHH9KnAN4DZVn9F2HXvLjLWUsLzCDnX9vnGbmoBcKcmAmenalpiP5nbfJNMtqSU+uAbH6bcWUzWc0HkiCB7VDMEujONtER5MWwjyJsvKw6zVJZyDwwoX8C7C0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRSU5dz22XcfmohqBvsHhxds5c1RL4HTn/Q0a3OdjLE=;
 b=GOAnKjB1Wfmz+lVKxd2FWHtnpNHZRLnSBq8hSjdkKIOEYlXlCzKN3DyWtMBCNvGNEFosfeaPC1fNv+EbDhHAFTR7S+ab9m72kRuG909pf7jvRVUkpD+Dmqf3+DzGZsEmtgHrqEP9EtdKHRjW4Y4YF50H9URmnsrGKxhcprQQclI=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 20:44:57 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:44:57 +0000
Message-ID: <4896ef05-da3f-4b41-8b76-0ec901ad569d@oracle.com>
Date: Mon, 20 Oct 2025 13:44:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
 <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
 <33a601cf-d885-424b-a159-f114c1d3e9c0@oracle.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <33a601cf-d885-424b-a159-f114c1d3e9c0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: e038a037-69d8-48d5-81ab-08de101987ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEc5NlBVOGx5U1VWS0VMc3RxdkpXUkU3eUlyQkg3WXJ4cTNPODFwL29oT0dx?=
 =?utf-8?B?N1BQZmJmYm0yeXdpTkw2S0RUaTlLMXJsZUVRZm95bzVqU1g4MDBEOUYyZEpL?=
 =?utf-8?B?RVByRTFmb09HblN1cllCdlE2YWoyR1F0R3hUTkVzTWg5d05kbVVla3plVUNO?=
 =?utf-8?B?UUhtb0Q0Z3JWMkNCcmc5UjB4NWh0cU5CanVUMytDWjlOSGhuU3JETHZENVE2?=
 =?utf-8?B?VHFJNmIvMXVtbjl1ek9FZTZESjJ1eloydzhYRUN0SFBoRVVkY243SFdNU1dN?=
 =?utf-8?B?MnM2U0NmeUNsTFIwd1B3akRhYmtRdzV3S0NqY1JSai82NC9sZVZ2aXZ1WXVj?=
 =?utf-8?B?T3Mzb29HREZTenlsSmpSWHlrOC9wUTJ4VHYzazMxb1lraXlEaFcxaHFPbE83?=
 =?utf-8?B?U0FDMnovZFBrSE0vdWkxLytmRGpOTHF3VUFGdnM2OGdYdC9aWTk5QTdGcWRU?=
 =?utf-8?B?RndzNUtJSC9yTEZyakZ4NS83UjBLTFdNdzc5MTNURHpCUUpXbG9sdFgvalFT?=
 =?utf-8?B?U3crNndCVktNSFdNZVM0U1hjQ2h6WmRzOWVQWFNzV3dvYzB1RVRzVE5wYm1o?=
 =?utf-8?B?VU5lT1MxbnQ1Z2tjeTZHa0NJbXVSV1hZTTV3aGFucndYSHRBbEcza2t5QUpM?=
 =?utf-8?B?M1FQdE52d1J5bDBSSy9sN0lxeDBCVTN5MzlOb2o0YkJIMmRTUHI4c2s4OHM3?=
 =?utf-8?B?bHM4emgzQmtkZ3N6UWtGVnlvT3gyWTdWdEY4cWJNM3FWVkNVN1FWbjQ1OEU2?=
 =?utf-8?B?dVZzczhMR3pGbzREOEVXZFBTSDNJZnJUVm0ybWQ0VzRnZndEVjZmNlpTcXhn?=
 =?utf-8?B?SkxUMDJkL3NIUCsyS2prMlU5RVJLdUMwQ2w0T2pHSUVPcnZPdHVhMlorckJo?=
 =?utf-8?B?MGc4VDY1NnNDamFOU2dVMnJqYVU1bkxDYi8xSG10WXJlNWErTitPVEs0eVM4?=
 =?utf-8?B?ZDB3S0VacUtXRmVvbkFTZVU2MGtLSzlmK2dqNkhTZ1dXOExqdC81anp2VjhU?=
 =?utf-8?B?eVhxNE9kSEo1dzdWQmNDVHN5UDFkVjBKeWtHN09NTVNpb3EycGQxRURWam5m?=
 =?utf-8?B?amRDQnk1WXB3eExQVGgxQjgzYXVPdXFnTG4rRkZ6NWVkRnpHUHpiQ3c2UUlG?=
 =?utf-8?B?eVRuemp6YlNvbXRTdm1EV2JzeUx4dS9HMGh0SnNHYklVVXhNR3d0ZGh1ZDBD?=
 =?utf-8?B?dU9sSDJnbjlobDhaZkdrMW13Q2NzS0NxUFJnV0YvdzZKeHp6ZE9ydW9CRlN0?=
 =?utf-8?B?bWNRQkFEd0JzK1FZeHdTUTlPbkhzakdiUVJ4c2tXUUw3NlQ0ZEZmV0x0NGdC?=
 =?utf-8?B?endwbHZUck4xVHE0Qzc2Sm5nK1Z6N3RFQkpLV0pic1FDL3ZwUXEzR1BUdjJp?=
 =?utf-8?B?a0I0SlBTN1VvQy9SOW1MVHNQYzNHVFZVL2ttbWtnbEhMRWJobWNGQ0gweVdi?=
 =?utf-8?B?bUsvK0xoV3luSGhNQ0tiRUhmUWNKM291ckNWcDkxNjY1VzgrMm1aMGhpOXg5?=
 =?utf-8?B?UVdWWVNwVXBwdlYzRVM5dlBTaDNMMVB0eGJQdFQ2RTBISjJWVU5nc3lSdml0?=
 =?utf-8?B?WTFHbXRIRHF6Yk5pbDBqcWhXd0NCWUc0MS9tNnBnRjRGNGVsb3FUOThrZU5j?=
 =?utf-8?B?anZWcTVlRWdWRE9FSHVhTTJ1VlVXKzN2UXRkMHMvMURaeEMrNlhLN0l2Qk4r?=
 =?utf-8?B?bEVLaE9NYm9iWlZvcmdPTkduanYwNWFLNlltbjlYU2RIVTdpNFZJSkcreGdq?=
 =?utf-8?B?M1RqZ3NLYTNrbmRhNXg1MkN2RnhZRXJRZHNFQlRucTVranVMWTVGM1hHMVNG?=
 =?utf-8?B?YWdKU2ZDS1JPcVpsbS9KMnhVNlRxanBnN1JOU1NPMmU3ejNNTUpWK25RRlc1?=
 =?utf-8?B?MWg3QWtqOFFjYmJDMmlvK2t3djNqcnJXSEhocnMwTC9UWWVqVXlBNjdxeHYz?=
 =?utf-8?B?a3k0dENrRFU1dEdHQ3lWYVVNWS95TCt3WThaVVowSjZOQlN1T014bHZId21i?=
 =?utf-8?B?ZEV2ZVo5OGxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmgzV0g2Y1AzeWViUVREd2Zzb0pVMzhoSVRDNExrblJRVHhIODVwZjJJN1d6?=
 =?utf-8?B?ZEpDYTRWY0xVaWtsSjNXeWxlVVJHaUFiaDBLOThoVmRXdkpOK04zZG5tNnpT?=
 =?utf-8?B?OGw4M3RyRHlqV3BSZGtOaklBNDh2UXdCb3RiM1pKVzlPZ08rbjkwaUU3UlQw?=
 =?utf-8?B?aWFXQVQ3VHB0dFRXWU9wbkdYci94a21BY3o4UU5wSDlYQU1nNDJSZTZMdU5o?=
 =?utf-8?B?WDBjWGN1cGdCSlRkZ0ZZM0c4bUpDQk5PYWtkSWowK2lrd3loVTN4QWVLd29s?=
 =?utf-8?B?LzRDNklQNWVFWlI3cDJqSWNiWkhKM2xBQzNlT2tNZXdzNFJhTlpzUkdtbnRD?=
 =?utf-8?B?ekJUcHlVVU5lcXRyZFZYY0J5WUxweGt0RHdBaFpPN0NGZjhJVGt1QUpmVXhS?=
 =?utf-8?B?N3dxd21JV25hOFR4WURWSFFIcjdzNjZNY2UvTnVnRlFmQ1NlM1h2Mmh6YWxu?=
 =?utf-8?B?aTg4S3l1cEN2QVhyckQyT1ZodThkOGdZd3ZaSG94L01OSEF0QmhYTTFyUk0x?=
 =?utf-8?B?bi95dVFOaVJ5dGMrQ1E5OTZ0T1RYS201OU5NdGgxU2p4cDZCQ0IwYVNhZXlI?=
 =?utf-8?B?VmhzeFR1VHBEWnhrUjFMSXdOMVFnNjFhcnBjbVJqdWhPeXRBeHdzTXNVNm9B?=
 =?utf-8?B?NytvU3ZEdTkzdUVaaXY5b1BwYkpxODNoalIxTmE5dHExb1d5SWYzTWdYaUsr?=
 =?utf-8?B?ZHhZdUNrZThPQ3oxTmtlQkJGYVBiakFuSFdDSjA2V3VkamkzbFpUU2x3dFRL?=
 =?utf-8?B?NE5GZDhrSFdzV2IrM0NNNzgvTEcxaWNLZGtyUCs4Z3VjVEJYWEJMY1Rsd3ZX?=
 =?utf-8?B?TkFDVWtGNWUrS0hNaUd1UGFFcmI3RWVpMG9wZ0tBNkxBWWFEaG5SOXhocWNY?=
 =?utf-8?B?eFd6bHpOMUtxTjA2c29oQ09BU2tvUWlHSWJwcVUrNHRKUWprL21RaHZwb3Nl?=
 =?utf-8?B?UlU2UkRmVlRBbGhqcHZvcUFuSHdhMWJUQUFYOEsvM0lOUGRQaVlZU2Y2UWN3?=
 =?utf-8?B?MVlabUpNRjI3SkNBSWtNTksrTFRUWGh0WWdLSE5vby9hamV3RFN2alpGTFZ4?=
 =?utf-8?B?S21BK3hSVmdMc2tKN1E4ZXdrc3ZzbU9sTkQ0bVNsNHBMZXZQUnk3SlhhYmZH?=
 =?utf-8?B?bXZ6ZytadlBxM3VXVzhtWWlJWERZZ3VQVnZZNTBsdTRtZEQ1aThGNmVvZDNh?=
 =?utf-8?B?ZHpPSWRBTEJYd09KbGx4N1NhU2liWjM4dzhVRCtBZjJyL0ErT3I1UEZzcXVr?=
 =?utf-8?B?L0ppMmo3dm9iTjZINHh4MjVBYldaU2VWWStjdEhSTHBzM05ka3IzZExaYkJy?=
 =?utf-8?B?TzVGWnA5QzdQNGY0Z0h0VUNRNFRncDRhQ0VNciswY1lsNVlIVXJiTWtDaTQw?=
 =?utf-8?B?Tm5FdXpZM0FkVTdhcCtGNHZ1YTd6V2E4WmRtemtscmNUOEtzcDZWZmc0RlhE?=
 =?utf-8?B?QXRHelNjbjhwRnB1a0wrczJHV1R5R0hvNXhtSEpUb0Q3bCs4NDlvOW9hYllI?=
 =?utf-8?B?Rk16b0NtZTVpbUduMDhVZXg3L3crVk4rOGJrYUVzTE1DZE11aWMzejBpU0pm?=
 =?utf-8?B?YktSZi9HMUZLcTRTTG1SSXl5c0J1YjBrL1NzS3lKUDdhWUxYckhqRVdodmJW?=
 =?utf-8?B?Z3N6Q2ZIcld4RXJVQ3pYdTQvaWFYT2ZPQWtWOVBHUTNHNmV3OVRpUmFZZmpq?=
 =?utf-8?B?UGc3QnRwbkZyVXZMMHpEMHI1Vk5KUEIvYlVEeEltQUE1K3hWS2ptZlBLYmw1?=
 =?utf-8?B?eUhXZm1NYlBCRlA1Mjg4cy9Kak9FdW4ybkw5ZENzZm9HenlxNUZXb1hWVkN4?=
 =?utf-8?B?RUo3a3pkRE9WdlpucU4zdnlIMkpTK096ZnZPaXdJRDJIL2NjbURVQWtzdXpH?=
 =?utf-8?B?NFJvdTRFTDJud2pYQi81eTRuVVFwbTBNTm9sYllyTGozYTdHYmluZDNGUUpU?=
 =?utf-8?B?b1dzMlAxMk90ejd3OUxRb2xGYTM0MEpIOCtoT2ZtWThaNldKQytBZWxJdUZV?=
 =?utf-8?B?QS9BKzAyeHpBVlZZSG1IV3NuZnVnc0l5bzQ5VXBYd1RzUGtNalJhZlNHaGFK?=
 =?utf-8?B?WVA0QnRIc0JRbVF1SG4xOEQ1UUMrM1VadXR6ei95YVpudVRJOW9sSjl6cGk2?=
 =?utf-8?Q?N69swuk06la02FICTuhqArH32?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vj1uNEe+GZzVq+vK4cdHj42CcAxabBOecdpXAP7kJbOgadl9yBK3ZJN//kxbXVxJTqNRYRjpJG0amKtgXl9n2brok/Lmft7x9yfhPZtR1fY00T0z5nkpJTkuMDRJEGbY3KLtk2SRqhDKSBVi08ynWKQQIaPrcE7zRO/Ji+rkVMrL+cMCU16bQvSM4NXmcYdNxsEQuWdf/jWNoBbduVgTsn/vC4XhAirTUUNgjIi8oU5pMmaxSoj7QJz/gaIFhQTbmyYkcH8MJAo/1JXZS386+wW/hNdrbHMiiP5kaFnva6pqop8q45Ut4Iay6GvqNTzWGLIkVZKkTa184BeaycryMJJIW7DrMrbzCp1t3mOq6/JRvyslbJ3+PHJUWm9TrZYZkqxNH99EBZoab3ZKnN4DVLGhYd3vD1QzshMuRVnK/Sv2GZ9M3O7+x/nG30DPp+e2SnHxSrqYPsFVrbxTuypi3EcJRMV3ckjiuyrMFHEaL4pBloytP+a4JOiW9O+nGjpp4TE5bPN/biCN9gYnOuMj/eB/QWraq7eOwa2KF7ClzTdW9nRos13qZ4MoFan2GoJpdGn2fXheudpWbMfO8uVA+HWZbRd/U5MdV0V2O7Ie8k8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e038a037-69d8-48d5-81ab-08de101987ad
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:44:57.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q44UW0nLrt8NK6Nvdt7MM6U2rSh4u8W5XRrl2UiNzYf4wemPAg3EESijNc8wRK9o3I7QLmWB+o+LeOGKS9PSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7lTEivgy+KO7
 beF5MNKzqSdvWT9EI7E8zkPN+eimv9Lm3N8lB61FlSaPfytBRaQI7WwLI3dDXZtK15nCi2e7L2z
 AnAss3HDv+yDtBoJzYjxtncZeRMjIkdf6pD2q794szFI6Qpae1xER1di6P6rXLIDzxUoqbLR/gb
 o7t4uhGG0NAGkOvewzL5IwLc/x2+qL5NavnUHunS3+7mT9R+q7Jx07DshQ/NSwaTJ4PLndbBN1t
 OcChaS9sEMUbRIWItZSV0Qm4HI81KXqU8/43I8OoJ874gBOCqAGSKGM1Vc+90c49KeX3z41jBb8
 TNAYJr3KV4EFxL/VB+txODDS1ELNJqaDrVSqBjpZytn2ILoLivzZT5dXYpZ9pFLaZDhkxayslV3
 0wUBPBDdELGlm+e2j6CMYP0gQJZBIPl27EkU/QYT4vOGSDy/Uqs=
X-Proofpoint-GUID: jFS25tsJGYoNmPidd2Z2gIvbNssts_nM
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f69f51 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=3g6lvTd_0HygLE91AdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: jFS25tsJGYoNmPidd2Z2gIvbNssts_nM



On 10/20/25 13:11, Alan Maguire wrote:
> On 20/10/2025 17:01, Yonghong Song wrote:
>>
>>
>> On 10/20/25 3:53 AM, Alan Maguire wrote:
>>> On 03/10/2025 18:36, Yonghong Song wrote:
>>>> In llvm pull request [1], the dwarf is changed to accommodate functions
>>>> whose signatures are different from source level although they have
>>>> the same name. Other non-source functions are also included in dwarf.
>>>>
>>>> The following is an example:
>>>>
>>>> The source:
>>>> ====
>>>>    $ cat test.c
>>>>    struct t { int a; };
>>>>    char *tar(struct t *a, struct t *d);
>>>>    __attribute__((noinline)) static char * foo(struct t *a, struct t
>>>> *d, int b)
>>>>    {
>>>>      return tar(a, d);
>>>>    }
>>>>    char *bar(struct t *a, struct t *d)
>>>>    {
>>>>      return foo(a, d, 1);
>>>>    }
>>>> ====
>>>>
>>>> Part of generated dwarf:
>>>> ====
>>>> 0x0000005c:   DW_TAG_subprogram
>>>>                  DW_AT_low_pc    (0x0000000000000010)
>>>>                  DW_AT_high_pc   (0x0000000000000015)
>>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>                  DW_AT_linkage_name      ("foo")
>>>>                  DW_AT_name      ("foo")
>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>> deadarg/test.c")
>>>>                  DW_AT_decl_line (3)
>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>                  DW_AT_artificial        (true)
>>>>                  DW_AT_external  (true)
>>>>
>>>> 0x0000006c:     DW_TAG_formal_parameter
>>>>                    DW_AT_location        (DW_OP_reg5 RDI)
>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_decl_line       (3)
>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>
>>>> 0x00000075:     DW_TAG_formal_parameter
>>>>                    DW_AT_location        (DW_OP_reg4 RSI)
>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_decl_line       (3)
>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>
>>>> 0x0000007e:     DW_TAG_inlined_subroutine
>>>>                    DW_AT_abstract_origin (0x0000009a "foo")
>>>>                    DW_AT_low_pc  (0x0000000000000010)
>>>>                    DW_AT_high_pc (0x0000000000000015)
>>>>                    DW_AT_call_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_call_line       (0)
>>>>
>>>> 0x0000008a:       DW_TAG_formal_parameter
>>>>                      DW_AT_location      (DW_OP_reg5 RDI)
>>>>                      DW_AT_abstract_origin       (0x000000a2 "a")
>>>>
>>>> 0x00000091:       DW_TAG_formal_parameter
>>>>                      DW_AT_location      (DW_OP_reg4 RSI)
>>>>                      DW_AT_abstract_origin       (0x000000aa "d")
>>>>
>>>> 0x00000098:       NULL
>>>>
>>>> 0x00000099:     NULL
>>>>
>>>> 0x0000009a:   DW_TAG_subprogram
>>>>                  DW_AT_name      ("foo")
>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>> deadarg/test.c")
>>>>                  DW_AT_decl_line (3)
>>>>                  DW_AT_prototyped        (true)
>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>                  DW_AT_inline    (DW_INL_inlined)
>>>>
>>>> 0x000000a2:     DW_TAG_formal_parameter
>>>>                    DW_AT_name    ("a")
>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_decl_line       (3)
>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>
>>>> 0x000000aa:     DW_TAG_formal_parameter
>>>>                    DW_AT_name    ("d")
>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_decl_line       (3)
>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>
>>>> 0x000000b2:     DW_TAG_formal_parameter
>>>>                    DW_AT_name    ("b")
>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>> change/deadarg/test.c")
>>>>                    DW_AT_decl_line       (3)
>>>>                    DW_AT_type    (0x000000d8 "int")
>>>>
>>>> 0x000000ba:     NULL
>>>> ====
>>>>
>>>> In the above, there are two subprograms with the same name 'foo'.
>>>> Currently btf encoder will consider both functions as ELF functions.
>>>> Since two subprograms have different signature, the funciton will
>>>> be ignored.
>>>>
>>>> But actually, one of function 'foo' is marked as DW_INL_inlined which
>>>> means
>>>> we should not treat it as an elf funciton. The patch fixed this issue
>>>> by filtering subprograms if the corresponding function__inlined() is
>>>> true.
>>>>
>>>> This will fix the issue for [1]. But it should work fine without [1]
>>>> too.
>>>>
>>>>    [1] https://github.com/llvm/llvm-project/pull/157349
>>> The change itself looks fine on the surface but it has some odd
>>> consequences that we need to find a solution for.
>>>
>>> Specifically in CI I was seeing an error in BTF-to-DWARF function
>>> comparison:
>>>
>>> https://github.com/alan-maguire/dwarves/actions/runs/18376819644/
>>> job/52352757287#step:7:40
>>>
>>> 1: Validation of BTF encoding of functions; this may take some time:
>>> ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
>>> sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''
>>>
>>> Further investigation reveals the problem; there is a constprop variant
>>> of ip6_make_flowlabel():
>>>
>>> ffffffff81ecf390 t ip6_make_flowlabel.constprop.0
>>>
>>> ..and the problem is it has a different function signature:
>>>
>>> __be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
>>> flowi6 *, bool);
>>>
>>> The "real" function (that was inlined, other than the constprop variant)
>>> looks like this:
>>>
>>> static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
>>> *skb,
>>>                       __be32 flowlabel, bool autolabel,
>>>                       struct flowi6 *fl6);
>>>
>>> i.e. the last two parameters are in a different order.
>>
>> It is interesting that gcc optimization may change parameter orders...
>>
> 
> Yeah, I'm checking into this because I sort of wonder if it's a bug in
> pahole processing and that the bool was in fact constant-propagated and
> the struct fl6 * was actually the last ip6_make_flowlabel.constprop
> parameter. Might be an issue in how we handle abstract origin cases.

Yeah, I think most likely 'autolabel' was const-propagated and *fl6 is
the last real arg as you suggest.

I'm not an expert on the IPA optimization passes, but I don't know of
any that would reorder parameters like that. 

OTOH, I see a few places in kernel sources where ip6_make_flowlabel is
passed a simple 'true' for autolabel.  That sort of thing will almost
certainly be optimized by the IPA-cprop pass.

Note that you may have _both_ the "real" version and the .constprop
version of the function.  IPA-cprop can create specialized versions
of functions so places where a parameter is a known constant can use
the .constprop version (where 'autolabel' has been dropped) while
other places where it may be variable use the original.

IPA-SRA (.isra suffix) can also change function parameters and return
values, but afaiu it does not reorder existing parameters.

> 
>>>
>>> Digging into the DWARF representation, the .constprop function uses an
>>> abstract origin reference to the original function. In the case prior to
>>> your change, we would have compared function signatures across both
>>> representations and found the inconsistency and then avoided emitting
>>> BTF for the function.
>>>
>>> However with your change, we no longer add a function representation for
>>> the inline case to contrast with and detect that inconsistency.
>>>
>>> So that's the core problem; your change is trying to avoid comparing
>>> across inlined and uninlined functions with the same name/prefix, but
>>> sometimes we need to do exactly that to detect inconsistent
>>> representations when they really are inlined/uninlined instances of the
>>> same function. I don't see an easy answer here since it seems to me both
>>> are legitimate cases.
>>
>> The upstream does not like llvm pull request (associated with this patch)
>> so it is totally ok to discard this patch. Sorry, I think generally
>> we should only care about the *real* functions. But I missed that
>> you want to compare signatures of the *read* functions and *inlined*
>> functions.
>>
> 
> Yeah, it's all a symptom of the fact we are trying to reconstruct things
> with incomplete info; these are all tradeoffs but I'm hoping with the
> location info we can at least provide data about the tricky cases rather
> than simply skip them.
> 
>>>
>>> I'm hoping we can use BTF location info [1] to cover cases like this
>>> where we have inconsistencies between types in parameters. Rather than
>>> having to decide which case is correct we simply use location
>>> representations for the cases where we are unsure. This will make such
>>> cases safely traceable since we have info about where parameters are
>>> stored.
>>
>> Indeed this could solve the inlined functions problem. Again, please
>> discard
>> this patch for now.
>>
> 
> Will do; sorry it took me a while to get around to this one! Thanks!
> 
> Alan
> 


