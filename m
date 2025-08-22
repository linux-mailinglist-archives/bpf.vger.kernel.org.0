Return-Path: <bpf+bounces-66288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEBB32013
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827F5664C1E
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B7248F6A;
	Fri, 22 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYEHeqLV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cA6Xree6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05023373D;
	Fri, 22 Aug 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878276; cv=fail; b=QWLBnmqNYscIQDTbvFYoJDWkeXhzlsj700QwvjKfI96v1lidZTiLUZVnlgP3wQXOdAvwd7LyRCwp33bzKoHUUbztgS2NOQeBgcxvHcQ8DkhRvdORfzO8eekpch2MoZaiUqiC/dt+s1KEgs6D2/hsiBbezOHqoubSm45egSn6QHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878276; c=relaxed/simple;
	bh=wxVvdqoq3FFnRT43u0ikmEQX3UTlq7Ca5f6lybmKD6M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qy0ZzEAGC4hn5v5AJoIx/MYpPvVAj8wgQPNJR8hAvm+JlFH475Xzmj31Mhodc83jqYJ+WuqemvDi3fqx9wM54mxXldA1/jFijaSLhp2RdCG84FMtgsi3mHSSiZ6ATYmZ5uMjXo9vsvTtJn3VzWWZr0WFdRZ4ivi3NOWH4MiUyGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYEHeqLV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cA6Xree6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MFH2kK023642;
	Fri, 22 Aug 2025 15:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3jmjfuVXxlgAJyN56vJZvDbitcccQ1MRsnIJa+uDGLM=; b=
	HYEHeqLVmp0G9IyWOrfNyTDX4I/mCzj0koB+bosRL282q3plD9lWIxz7CB8R+bBD
	SKsOlp6EkxwL98X5ZJjnTVg7B+D/dGwAA/yuBHYUuFIdv1IQUuFwBdB0zHnYkRyG
	9V5QZrJwJDJt6hWSSSrshZYyWYPYN5xUWvcIV9nlBoF+EBPzNR76QSmq0kPi3vuN
	z1uzyoYfkNzD+TuzxSTAntc3k2E+yFoRFV2TIRsxJLlgQWQTMex2Why0FWso/8u+
	oXhA1dLQCiMIiNZAk7AhWQYSDs2TGSu50n3qopKy1Rt4KmMkx4szsVxoGKL42biq
	C8n3Ry2tRB42lXP/K0iKIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa269p07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:57:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MFPapI021102;
	Fri, 22 Aug 2025 15:57:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6hgu03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1qP7+E2jif8Ucbjryu4eQE6RzJfC1AspLWerTB/T6ulIB+8hvUffX6KBNLPLdFALE/Vsz1fC9TUTSE2tgYBVMO3AsLlCJdODvrNOK6G7nUrCTJVTDkU5dWyvmAkM3cojKkdf3lzSD0YGtiqSsjTmdt1ggPgb+uVk6xTBbWUF1pV+Abw237p7/xRaIILm7S/zRn8x5hX81XMzB+AD3H92QCoUt4jA17HELvj9/hzXNQvJ3s2+nM4KoscfvSP3f/eQg9HexgfABqKC4WxtjpcyG3Qpo2t4MHV5lAu8T+PfB1D2F6KT54vm3Hui4BKAIaoeaq21PdnHtBVXslpGQrNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jmjfuVXxlgAJyN56vJZvDbitcccQ1MRsnIJa+uDGLM=;
 b=qRfirUIXUpyBB2PO4Kqm0Ki1IWneHkzOAcc8OGOZSBrbTS2/a2bU5k1yyyMJL07FaIU4xa+xPhnhuO1A+nyrIMfTlZ1v0rec0htI9N5CMvKNW9Owi50L9Nsd+orAIq1QoYd6A9Jwd3groHOEHbSVd/BlIGZ6V8dV+cuvTZS7SJEhAFJB+0a7jNPfUWzgrIQmMBHKcwcaFm8npfGcfOr8/BNmpSy9vRcYkIDWVZPJI4Knhpe8uPsaRPnMowhMZPMHKGxb2J/VzWIMKE+5wLwVoItjj3uqXZkgJ4qCtxOJKfblBbXUAcvCogj8RcsrFeP2x93IPivZm7MpWSnSvbNFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jmjfuVXxlgAJyN56vJZvDbitcccQ1MRsnIJa+uDGLM=;
 b=cA6Xree6bXq6p36yv6CAel1Drj8NwqYuwUNZpdw2028svvGoSwko+lfr8RASw4Wa59wkGPfiKJi046bP45drKEu7wuNjPJRgUvVT+iFo+Uo5VJeSH0vAn6GiC7wnbJqzK0KboQgEpkz55NV2csXYFJOe5u+bxocdwU8i9hottj8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:57:32 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 15:57:30 +0000
Message-ID: <14cf1f79-11fc-43ef-9f6b-01e0f80c9da1@oracle.com>
Date: Fri, 22 Aug 2025 16:57:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
From: Alan Maguire <alan.maguire@oracle.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, olsajiri@gmail.com,
        dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
 <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
 <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
 <5a926464-62bf-40b2-8ca4-a7669298a8ea@oracle.com>
 <d845b2ae-a231-4bd0-a3f2-b70f14b395ad@linux.dev>
 <9da9d7f2-e586-40a4-8080-2903920d32a3@oracle.com>
Content-Language: en-GB
In-Reply-To: <9da9d7f2-e586-40a4-8080-2903920d32a3@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0177.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 001b9ac9-5433-4ad9-7b31-08dde1949996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emEyZjB4UVVmVE1TbXVGWTh6T3gxMHdNRS9Md1hBSzU1NjdUbHozL1lWS2d5?=
 =?utf-8?B?WGRRVjcrLzhqWm5xRW8rcll2L3phcWhxcWYxWkVzYmk1LzFkNDd5WmNLSU1x?=
 =?utf-8?B?T0dXMWtxMlplb0FRMTcyYmJPVVRoL1RlMmxHdVkrVWtIbUppRk81ZUZua3pt?=
 =?utf-8?B?RjVGOW54SGpJbUsySisrTXRxYWNEcUpwOUJQQkJ2L3NzMTIrMlc2RS9TVzk3?=
 =?utf-8?B?UmNpajhtMW5EQ24yWkxBbTFrUUZRVDFhdXNQbS9rWTJ1dHNKREIrYmxZaW0x?=
 =?utf-8?B?Vk5wZzR5UVREcWFRVnhrc1B2cDh0cEVsdDdNM2doNWpCQnJWeVZtSmpENCtz?=
 =?utf-8?B?UVllazR3OXNhN0RKd245cGcvdW5GUTdYUVE2NUhWNlZVSGt5eXlHTGdLSUQw?=
 =?utf-8?B?VmNESWVmU3cxSy9qNHRvZ1RBcytTanFVM0c3SkREVFBLRi9OelM2SXZ6aWJZ?=
 =?utf-8?B?RjhSR0FVVmN1cGRGb2VHYkhSZ1B0NHZ1ejkxSlJFRGJXQkV1MkRrZnFZSXlp?=
 =?utf-8?B?eDBMbExNaWpxZWFRMHUzaHVsNFVHQ3h5RmVhYSt6WDZzWklrSTdMU3ZNaS9l?=
 =?utf-8?B?RTV5ekQyUjRVL1REZkpyS2ZWSHZKOTJVY3hzZEtUeW5RUEkza1JZM2pEenlR?=
 =?utf-8?B?NU05Qkx0RVdwU1hrbUhGMHMvbm9DQk43WEI4NUVoRWFXRzJPaTBseTJmMXZx?=
 =?utf-8?B?cVJiT0QrcmlBdW1OVHlGdU5rUWpFVGdtSUk3M1cydVFESGhnbisvRDM5aW94?=
 =?utf-8?B?ZHJod1Z5WVpHQ1RHb21XTDZmZFlXWG14cjEwbjZCUUFwY1JScmVISStibEVE?=
 =?utf-8?B?SDBWTDZ4aUJveFB5a292cFl6bGVsViswT1k5YUQwOEZWY2JsRWYvYjR2WmtR?=
 =?utf-8?B?VkgybXBFSG1JVWU1enVGTXpvVmpxWEZnWFRTSlhHcUk3M01NMjVKVW1DaC9F?=
 =?utf-8?B?VU91QkNPL0lYc0dZYkNULzJUNTh0SmdvdnUxYURIaUFHZ01QWHFUMEtQMFZl?=
 =?utf-8?B?ejRQQXRINGtxcmxybllMWkR3RjhDaHpCU0VlRTBuUDVNUFZjZ1ZQcDBDcm1o?=
 =?utf-8?B?blBhR1hlY0NyYkRyUUR2REllTnV4NlVuQmV6VDA3OHphOVA4U2xDcExuTFZV?=
 =?utf-8?B?c1JnNEpON09XZFhOR0JhL3JKV21oMHZNM2dlSDNRRzkyUWVkNUdrZVdRMWxo?=
 =?utf-8?B?b0diUFpxVGVURFlwTE80WE9kMFpYTWdPN0lzOERLVkJmdGtMeE4rQUtld3RG?=
 =?utf-8?B?NHIwQ2V1Y2xnMXhGK3B2R3Y4RWdXRVQ1b3BVUE05VUxYMmhIQVFCeE85Q3hz?=
 =?utf-8?B?cHFpLy9sdHhMQ3VJQWp5bENyVWdDOStZU1R2T2dJZTRDdThtWEVwMkJqODlz?=
 =?utf-8?B?bUlUMCtidWQ2UElDWmdnOHlSM0MrNFNZYmNqMHFPaXFpdTdrYTVwV3Vjd2tn?=
 =?utf-8?B?VmluV2NiVTlpQlJ0b3k1T3FlRTY0R3dsb01ac2hsK3ltUFhKdjBIdGIzL3R0?=
 =?utf-8?B?bXduM1cwNjZ0WGVsZ0U5V0xlK2VrWXZzaC81dllmSkE0OVFKSzJXU20wVTdh?=
 =?utf-8?B?bGpZbEk5Uk1WUm9haHp0VERkdUg1akxwRWptNktXWFJKSVFHSTZRb0s2SkQz?=
 =?utf-8?B?UEZhSHNKb244TUZKRlhNM0xzaDZ4eXJhekk4NTI1dEdIcm1QYmlyTHRjSHNv?=
 =?utf-8?B?eEsrWVQ3UE01Q0tnc1YrVGxsQ3A0aEVhTkI1Ri9STmZyN3lYbTRNNzdhQmND?=
 =?utf-8?B?ZUh1V2lZbHVBT2k1d1Z6cXZFUEFqSS9MQ285MGRzYUhya05OU1ZLKzFETjVB?=
 =?utf-8?B?U2lubDFXT3B4VkdoTHJPTVFyaXZ1NGRlb2VxUSttUTJuVUlCcGNScndsMWtz?=
 =?utf-8?Q?Kuner1ZxHZH8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3pOQlltamlNcXgxV0tzN2ZGcVRDME1kcEJzb0RrZzFkK3huTWQ3MGlRMXRj?=
 =?utf-8?B?ZUlZMHA3ekd0UnErMzZoOHNEOUR2QnhlNTJ5MmlZeGpMSU9oSlNRMlA5WEkz?=
 =?utf-8?B?dFQxemJaQ3kxbEJ1R01CUHN1MC8rdmR4NmdDZndlMklYdDNpb1ZGdFRJbzRj?=
 =?utf-8?B?TStaNGRkbVFoeWVUS2J1R0ZvbmF5ai9kbGNXTVhYdFlNQm5MdVdZNHBSYnFU?=
 =?utf-8?B?c29CdDdseEhMa21nMHhobXFUemJCS3ZQeTUyNktoSEJZWHV6ZS8rQmJmdjRv?=
 =?utf-8?B?K1dZS2hlV2xKM0NKSGtrTzlsT3R3K2xCRkd6cDNGTUdUZTFBT09oZGQ0ZTBB?=
 =?utf-8?B?SlNBdzlNR2MvWkk1cGhVWk84SVY1TFRJbmdka3dkL0dPQzNoajNaNktsNnE2?=
 =?utf-8?B?NEd6UXV5SXdrZnZ1TThBc1RLVXNzZ2daVDlaREN3R1ZIc0FSSXpzNm9LUStp?=
 =?utf-8?B?QWV4WUxCZ2tEWGdBaHNuZ2hSTlJTenlBcDNDeGN2SnV5em0zZ3VqTTU3YVdR?=
 =?utf-8?B?RFJjVFp3Q1hSRzRMWk5WblZYNnZsKzlWK1RFRWtUQ0N1TUZGRy9IYlloOSts?=
 =?utf-8?B?aWJtTU53QkF0azErOUYzcDNDZlExb3hCS29kVTlBVFZDNGJwM3RJemxxdGdL?=
 =?utf-8?B?bGRGRCtCWDRqajg0ZzUzWkQwZXJrUndxTmx4eGtlMWc1TUdXQkpMS2QrWXE0?=
 =?utf-8?B?Rjl1dU9oRHFiZDNjYVBQc3FYejYwMWtzUWdraTFKeWtvbWN0aGR3OTRXSFo1?=
 =?utf-8?B?U1BXcllMcW9keTFaMytuZjZZR1RJV2pYaHhrT1FIWmJVME5HM3VvMmhTN3J4?=
 =?utf-8?B?T0FtbFJmUTRPeG5yeHpwS1hBNUpiWDd6ZWlkOXMvd2NVbS90RTNDam84TTk2?=
 =?utf-8?B?VHRXRHhOS3B5Mnd6b3ZwcEFHdTNHRmxiM2hWcyt1SEM4bUQzQ2tNMWVZME4r?=
 =?utf-8?B?UjJSa2kyNFlXNUFEdUgrRFJpNW04eEx4MEVqWEtXazRYU3hLQkRaUWtVZDBB?=
 =?utf-8?B?eWZzbXcwMC9OdkgxdjRVN01xcG4yMGNpQStqT3oxYTlFQkFsZ1NIYlp5dGp5?=
 =?utf-8?B?U3B1blEzRVE3azZKSHFnMEhJaThLTk1hOC9xRVlaUytlOVFZU0dFd25OMkJ2?=
 =?utf-8?B?czdUcFdoanlGZ3NXWjNCczBxV1J0bWRROWlOYzNMdEpwQzNYeDFpSlljZk1W?=
 =?utf-8?B?TUQ5M3VqZEkvRmc5ckJ6QU5pa3FDNjZvSkZPNFRqVEFhTkxzQWFvSkJjRk1X?=
 =?utf-8?B?cm1JVit6WEt1bnNzVzdEVmwrd0dUM1NFTk55elRobnVmdDRuM2FUWDJqWlBM?=
 =?utf-8?B?cVUvZnh2OWVXU3dHOVhudzllakw4aisvRllIeFBoQkEvRWlrODNTVU4rdGkx?=
 =?utf-8?B?cWxuR291VWFMS0JHSll6SVRWaW4rOHBsai9aYVdvSm5XYit0VnN4WTFMNlpU?=
 =?utf-8?B?bm9Ca0VWY1hUa3pTT3RaMFYwU005M1JZakUzZ29mdUE4MlVMQmh4SDYwTVpL?=
 =?utf-8?B?SVpSa1RlTmlWUFhLczdLV20xUld2ZjVmK2ZCaVBGRVhJT1ppMjhmSjBOZUdK?=
 =?utf-8?B?ZURCS2FVKzNBekJoYy9OL0R1bERmY0M3WVorRFFXVmwweFNMMHpzWWJDNHJz?=
 =?utf-8?B?azlWNndHRk9rcDhIMndaN2tvS3J1Wm5uNDlIc2w0dkpWL0FIY0lHZUZCaGxo?=
 =?utf-8?B?dndLemNiZlBtV0hXdXRaTmpyeW0vUkNVN05pR1FITlZDUkxIbGlTajRpdGJz?=
 =?utf-8?B?MzREa3hMbTRWbG80Z1BYU2kwYmg4dzgrRXBXOWtXZWhHRXU3YWRXWGI4eU0v?=
 =?utf-8?B?aWpwS2VLNjhSd1JucmdEOFVJYXJYT0IwZUFaMkUxLzhYK1YyRzJUTGZ4WllQ?=
 =?utf-8?B?OXRVQnFHQlZjdEFaYlUxUytPejFhRkxORmhBR2lZby95RldORnZUZTFpUnRP?=
 =?utf-8?B?VlZMUnpsVG9mdzRkbDM1OGc3SC9XN3Zkc2JmSHpDclJFTlRmOVVVZnFNcE12?=
 =?utf-8?B?NGluUSsycXhFeUdaWFRzYjZGdnJXOVZFZDE4Z29aV0puUFpHN3JwVzZuclQr?=
 =?utf-8?B?dW9MVzlUWURqcWtVWWlzM3FCb25JMEVxVnBkcmFib3Yyc1BoNDNjN1hTL29I?=
 =?utf-8?B?b3R6cUwvanJWUld2RXlORjNsems0QSs5OW1RRG9FMXRxWmJxdDZzTFh5dnpr?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d8kN5bpwf7sHqIBEyPC/6xmQnuXHnuZYt2lbkE4+TEGF95IlFcj8oBr+6NqyuWdo/cjgmFQFewAISHmGdRJTL8qY5dmvMKby5TPxstK98Pl+v1ItsE1xR+ZKUl35DWV3JnK5IXoM3Ycxd1AjxO1qF9thPv8U94zBkGTUG/PrlfW9i8e7hEG+LLVe4of51SxUqZMkaMVTZKkpj8aP6D2mRHu7qB9N4P2temIWBc8upGycWPVVsGeDNSREJ2v/K6QvwlOv+UmDsIMrH9KM/lfzGGMcAlPyo06mmqdM2cFOL4Ul5I1MV7ujQ2L8tpTzp6Sa0kmYxI79PX/ux4CmJSPgc12ew6SuAgPftETmdtvMQA728FISH5Lf8EZIIYc9/JjPNNd8C2XnIjwxQWc5pa+C6bf+ylrTh584xPjUvXU8uwidQS0TPb4yrDN3f23ZbSqNDz4+QyZ6SBZCAOTKMtG4Lm5hzapiqccvqN2I9U5PxaCYL1bgEkEh6Y8epxr6crm2nzyacB14BeFj8es4yiDxjjV2I8irJJAOXJkiZD3WM+7HOZ12brQ/v4VFaaQttAtFCMMFO7wMJEteg3QvawzhHUk+ksMARJEuvMAOXLxC2Qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001b9ac9-5433-4ad9-7b31-08dde1949996
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:57:30.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7yyTqZt4WLwLceyu0E4ZPL1tC30kU2OqPOodR3UT24nVcuFbyDtYtJ0ZCQ5UxUXxPCLlxN6wPb8Qc6tU2QGOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220144
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a89370 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=RGFWwebjtHBWPh8rVzEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: GG1y-6T7qybnL8y-YZSnqGGxAollFbY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX7bOgas+9hFT1
 uS669TZ9rCX+bp+0xUG2H3BSeKScfawkRAuzLHwapZaPMAB0rwzj4+Vdj4H90FZRLZ9YFQyBGrl
 Tk+rmdj99tTeuEMDTZAxmrHI5mAf5gflSGfCI+7fp7SA2kG2g5xi54ii58hFjIt5yeqP6M6xGGG
 WyktQWMucSPTNOMBiEF2J0DozL3lo8428LdHoKWI9G0KVI6bEPy2zPoaS9R6b37bu7yhj4c6qCI
 8tyAFXEmrM+aPzMx5uDrCpLU2v0KArHoIv5tyVHPbUlkfyvwOFiPXFwDITWNo2gx9OHjS1X4Jsw
 YSPhyx4P7HswWFEAQp8tzas6yVKu5xm3W+xFq6eIDIUnFrnXfaAg9kpQPYEiqNxDc1bkPkbVOG4
 3+4Fo5DEzyT1G+Kz289gxY/ad231nwPuCg4ocYjGNEkdHpPhsnA=
X-Proofpoint-ORIG-GUID: GG1y-6T7qybnL8y-YZSnqGGxAollFbY9

On 20/08/2025 12:04, Alan Maguire wrote:
> On 19/08/2025 20:34, Ihor Solodrai wrote:
>> On 8/5/25 4:24 AM, Alan Maguire wrote:
>>> On 01/08/2025 21:51, Ihor Solodrai wrote:
>>>> On 7/31/25 11:57 AM, Alan Maguire wrote:
>>>>> On 31/07/2025 15:16, Alan Maguire wrote:
>>>>>> On 29/07/2025 03:03, Ihor Solodrai wrote:
>>>>>>> btf_encoder collects function ELF symbols into a table, which is
>>>>>>> later
>>>>>>> used for processing DWARF data and determining whether a function can
>>>>>>> be added to BTF.
>>>>>>>
>>>>>>> So far the ELF symbol name was used as a key for search in this
>>>>>>> table,
>>>>>>> and a search by prefix match was attempted in cases when ELF symbol
>>>>>>> name has a compiler-generated suffix.
>>>>>>>
>>>>>>> This implementation has bugs [1][2], causing some functions to be
>>>>>>> inappropriately excluded from (or included into) BTF.
>>>>>>>
>>>>>>> Rework the implementation of the ELF functions table. Use a name of a
>>>>>>> function without any suffix - symbol name before the first occurrence
>>>>>>> of '.' - as a key. This way btf_encoder__find_function() always
>>>>>>> returns a valid elf_function object (or NULL).
>>>>>>>
>>>>>>> Collect an array of symbol name + address pairs from GElf_Sym for
>>>>>>> each
>>>>>>> elf_function when building the elf_functions table.
>>>>>>>
>>>>>>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is
>>>>>>> set
>>>>>>> when the function is saved by examining the array of ELF symbols in
>>>>>>> elf_function__has_ambiguous_address(). It tests whether there is only
>>>>>>> one unique address for this function name, taking into account that
>>>>>>> some addresses associated with it are not relevant:
>>>>>>>     * ".cold" suffix indicates a piece of hot/cold split
>>>>>>>     * ".part" suffix indicates a piece of partial inline
>>>>>>>
>>>>>>> When inspecting symbol name we have to search for any occurrence of
>>>>>>> the target suffix, as opposed to testing the entire suffix, or the
>>>>>>> end
>>>>>>> of a string. This is because suffixes may be combined by the
>>>>>>> compiler,
>>>>>>> for example producing ".isra0.cold", and the conclusion will be
>>>>>>> incorrect.
>>>>>>>
>>>>>>> In saved_functions_combine() check ambiguous_addr when deciding
>>>>>>> whether a function should be included in BTF.
>>>>>>>
>>>>>>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>>>>>>
>>>>>>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>>>>>>> CI-like kconfig) that are now excluded: all of those that I checked
>>>>>>> had multiple addresses, and some where static functions from
>>>>>>> different
>>>>>>> files with the same name.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-
>>>>>>> b1cb-10266c72bd45@linux.dev/
>>>>>>> [2] https://lore.kernel.org/
>>>>>>> dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>>>>>>
>>>>>>> v1: https://lore.kernel.org/
>>>>>>> dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>>>>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>>>>
>>>>>> Thanks for doing this Ihor! Apologies for just thinking of this
>>>>>> now, but
>>>>>> why don't we filter out the .cold and .part functions earlier, not
>>>>>> even
>>>>>> adding them to the ELF functions list? Something like this on top of
>>>>>> your patch:
>>>>>>
>>>>>> $ git diff
>>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>>>> index 0aa94ae..f61db0f 100644
>>>>>> --- a/btf_encoder.c
>>>>>> +++ b/btf_encoder.c
>>>>>> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
>>>>>> *btf_encoder__alloc_func_state(struct btf_e
>>>>>>           return state;
>>>>>>    }
>>>>>>
>>>>>> -/* some "." suffixes do not correspond to real functions;
>>>>>> - * - .part for partial inline
>>>>>> - * - .cold for rarely-used codepath extracted for better code
>>>>>> locality
>>>>>> - */
>>>>>> -static bool str_contains_non_fn_suffix(const char *str) {
>>>>>> -       static const char *skip[] = {
>>>>>> -               ".cold",
>>>>>> -               ".part"
>>>>>> -       };
>>>>>> -       char *suffix = strchr(str, '.');
>>>>>> -       int i;
>>>>>> -
>>>>>> -       if (!suffix)
>>>>>> -               return false;
>>>>>> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
>>>>>> -               if (strstr(suffix, skip[i]))
>>>>>> -                       return true;
>>>>>> -       }
>>>>>> -       return false;
>>>>>> -}
>>>>>> -
>>>>>>    static bool elf_function__has_ambiguous_address(struct elf_function
>>>>>> *func) {
>>>>>>           struct elf_function_sym *sym;
>>>>>>           uint64_t addr;
>>>>>> @@ -1219,12 +1198,10 @@ static bool
>>>>>> elf_function__has_ambiguous_address(struct elf_function *func) {
>>>>>>           addr = 0;
>>>>>>           for (int i = 0; i < func->sym_cnt; i++) {
>>>>>>                   sym = &func->syms[i];
>>>>>> -               if (!str_contains_non_fn_suffix(sym->name)) {
>>>>>> -                       if (addr && addr != sym->addr)
>>>>>> -                               return true;
>>>>>> -                       else
>>>>>> +               if (addr && addr != sym->addr)
>>>>>> +                       return true;
>>>>>> +               else
>>>>>>                                   addr = sym->addr;
>>>>>> -               }
>>>>>>           }
>>>>>>
>>>>>>
>>>>>>           return false;
>>>>>> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
>>>>>> elf_functions *functions)
>>>>>>                   func = &functions->entries[functions->cnt];
>>>>>>
>>>>>>                   suffix = strchr(sym_name, '.');
>>>>>> -               if (suffix)
>>>>>> +               if (suffix) {
>>>>>> +                       if (strstr(suffix, ".part") ||
>>>>>> +                           strstr(suffix, ".cold"))
>>>>>> +                               continue;
>>>>>>                           func->name = strndup(sym_name, suffix -
>>>>>> sym_name);
>>>>>> -               else
>>>>>> +               } else
>>>>>>                           func->name = strdup(sym_name);
>>>>>>
>>>>>>                   if (!func->name) {
>>>>>>
>>>>>> I think that would work and saves later string comparisons, what do
>>>>>> you
>>>>>> think?
>>>>>>
>>>>>
>>>>> Apologies, this isn't sufficient. Considering cases like
>>>>> objpool_free(),
>>>>> the problem is it has two entries in ELF for objpool_free and
>>>>> objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
>>>>> the ELF representation, then we could potentially end up excluding
>>>>> objpool_free as inconsistent if the DWARF for objpool_free.part.0
>>>>> doesn't match that of objpool_free. It would appear to be inconsistent
>>>>> but isn't really.
>>>>
>>>> Alan, as far as I can tell, in your example the function would be
>>>> considered inconsistent independent of whether .part is included in
>>>> elf_function->syms or not. We determine argument inconsistency based
>>>> on DWARF data (struct function) passed into btf_encoder__save_func().
>>>>
>>>> So if there is a difference in arguments between objpool_free.part.0
>>>> and objpool_free, it will be detected anyways.
>>>>
>>>
>>> I think I've solved that in the following proof-of-concept series [1] -
>>> by retaining the .part functions in the ELF list _and_ matching the
>>> DWARF and ELF via address we can distinguish between foo and foo.part.0
>>> debug information and discard the latter such that it is not included in
>>> the determination of inconsistency.
>>>
>>>> A significant difference between v2 and v3 (just sent [1]) is in that
>>>> if there is *only* "foo.part.0" symbol but no "foo", then it will not
>>>> be included in v3 (because it's not in the elf_functions table), but
>>>> would be in v2 (because there is only one address). And the correct
>>>> behavior from the BTF encoding point of view is v3.
>>>>
>>>
>>> Yep, that part sounds good; I _think_ the approach I'm proposing solves
>>> that too, along with not incorrectly marking foo/foo.part.0 as
>>> inconsistent.
>>>
>>> The series is the top 3 commits in [1]; the first commit [2] is yours
>>> modulo the small tweak of marking non-functions during ELF function
>>> creation. The second [3] uses address ranges to try harder to get
>>> address info from DWARF, while the final one [4] skips creating function
>>> state for functions that we address-match as the .part/.cold functions
>>> in debug info. This all allows us to better identify debug information
>>> that is tied to the non-function .part/.cold optimizations.
>>
>> Hi Alan. Bumping this thread.
>>
>> I haven't reviewed/tested your github changes thoroughly, but the
>> approach makes sense to me overall.
>>
>> What do you think about applying the group-by-name patch [1] first,
>> maybe including your tweak? It would fix a couple of bugs right away.
>>
>> And later you can send a more refined draft of patches to use
>> addresses for matching.
>>
> 
> Yep, sounds good. Better to separate these changes; to support that I'll
> add the tweak to your patch where we record but flag .part/.cold
> functions as non-functions in [1]
> 
> If no-one objects, I'll land that in pahole next later. Thanks!
>

Done, thank you!

Alan

