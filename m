Return-Path: <bpf+bounces-38619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E50966C8A
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F342B1F23F3D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD81C174F;
	Fri, 30 Aug 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgacwMEP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dej1W5Cf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726E1741C6;
	Fri, 30 Aug 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057304; cv=fail; b=Ii8ZQzg2KRb8iUovnX00qNyLN0C5pyr+pxa5Q74/w0EYg3iQb66ihiec48sXquFzGasGXASiti+hHyfhyY5ysfNFcMrUx3veed7kWiCe6b4BKxV74dnuOSopx5htrjjvGXFyDwpeq6fl6sr2jhz7KXHXdEo6HJQIXNmYXQaG3mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057304; c=relaxed/simple;
	bh=bdUtQOcpidGCl6jziV/LODekGpb9fezz/RZiBbU4K2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGr6YufmitJiwfVA7S1oeee9wdfobuLhW8NvHfn6pLA+9KNsdFYu5hs5lUDzcOnaUscSk3pPDfSjB4Uexl/wbKPc9aFQnTNuKud+vBDAZZ3MaUBTDyH699AytcIdLSwq3K7IVz+BkUWMThBvPCCcOVSaG786eH8VFy+tVko1ql8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgacwMEP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dej1W5Cf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UMNAJf030649;
	Fri, 30 Aug 2024 22:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Opddx39BwOqbrMRYkacQd5Nhz5TGYSc7e3LevyutAGg=; b=
	KgacwMEPt8Lzhkvmha+LbB3pdvxm2WAIy6XMPK9Sg15MDxwUyko7bNYziWGAKrcU
	VZv75OZhcCBlzNoz8qpN9VFRXBkGXQCwYcCcLyoGTfNCHbpMYDd8cYBQPYJfWTrw
	OWfA/pu0UlxG/EemnL38FcRDb+UWC3D79YhmQGq4iL4D+rFzcUdTZd2FQPmq3C1E
	S6W/njhrmBIc8/BNMR0bsq+lKLLhpYRen2wVwIiGZ4ksBSAIfCULG+SyMW6U0HaU
	qEL0LLEHVlQ8cPsPyPepPlr1n5Qiafrwta76vbxxTVqLykGnsFe916dQc7MGCCg6
	hdj9VJJjlCRhicd7vPlHZA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugyr7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 22:34:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47ULTQbr009924;
	Fri, 30 Aug 2024 22:34:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894sjety-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 22:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfYVyy+yKvI//bVSVYDXTZF9Kpk/OPLEQyrfV1VB8vfcuW9Mn0WxhKq7JxxCOUoXr0l+klER5D6z+v8U2EHOpRyODZwWhYOyfup6WMx1wNOmZsnmsj4eIQRFFPlBKo/NZLArKh00rwcVn9t8yEQjCUAVzeMGrRUUhg8McUOoiPPJObFDb2Pyx5xj1wfPUASWE5moOsTPZD51lMahqvyQSBgN/WheJikcHPoGXDVliIFALzR7cKCAqKgDi4VNUtOkQ7mnp9VDKofSOBxaEkIQ6gVmsU41EDtZFuNG8l6MIcOlKJWMGNZRMi471xiRQaZiw5nHNC6I7h+mBaZ57+FqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opddx39BwOqbrMRYkacQd5Nhz5TGYSc7e3LevyutAGg=;
 b=Ryy8jWYt66Zprg+x7AfIjbIPRi22EV+Mng8PRWU4ln4n8S3vGdN2LIVZcq8AsIvlPlvTVEzKFkL/e+eLmUp5FSjmSzx2XV0W8Pqurl2luoE60mmmgkJINViyDZVlkk28TAi/hd0/4wADisBfhALyN7bvrtp8jq62bcaghcxPklxYKjNpu+tQIxmHhLn2qvMOZNSy/DeP7vJ2+8X4UUDp8trkNRFe6mvVFj+uN/cODwah14wKlzgZU4A39cCu7MhZ14xujG8rSmDVggwnl0FRLAEILg/gguE3H62bFDLCYlgbQOfvk/T6tUi+uc9/VjC3cflr3TvGXNPj0XiYQXGeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opddx39BwOqbrMRYkacQd5Nhz5TGYSc7e3LevyutAGg=;
 b=dej1W5CfiP2CxFG0EA+gF2tPCoo29Iq1EJxQ9q7bfz/CVY54U0gkRWmbWn8lncojOs24y+Ix1hehzy2ZyTV/3IFXIU26o1lVkhGd+NXwHGBaBq/MJqcWzzMDBnJobmdduqjSxfvLqAwwYXqbXEeLhQ1+BshdzCbK4IrCGTW4r5w=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 22:34:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 22:34:45 +0000
Message-ID: <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
Date: Fri, 30 Aug 2024 23:34:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,
        Song Liu <songliubraving@meta.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
 <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 38014c87-2c19-4a46-42ca-08dcc943f2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk1NSUNvU2JQREZ1YVpQM0grRXF3TUtqV0YzZjB6cWxFa3lLK0dMc0RPQzFH?=
 =?utf-8?B?bmhYTEdpWmExN1hFQjJnR0FmZktvQnNkTURpVmZsZ0ZHdW9qaEFkeWRJSDVP?=
 =?utf-8?B?aUxNak1pZ1pYMjVDYzQ3Z2RnUnoreGthUmtjS29CQTdkcmVrUjNHVHZ5Q2xZ?=
 =?utf-8?B?MjIzV000clVSMmt2dkZYRnFGTFBEbmRzMmJ2NTRLeWNPY0RpSnpPTnpvUVNs?=
 =?utf-8?B?MUlVbnlxcFM2RitjNGVSNnR6dDJXb3pxaTFpaEJFNWw1NmVQM1ZwcndYdElB?=
 =?utf-8?B?bHJlaWF1dXdqTW5YNU9sVmNqREFqRzg0VnFBMFZPb2ZpSEtrRW9FdVhmc1VC?=
 =?utf-8?B?aGUySXpLVFZWdjFGU1JKUXFvYnNnZWFVMmJUbVNVNGkvMGdZMDU4d1JKcU9z?=
 =?utf-8?B?azRaQmhlemVSY0EvRXZZRVJOa3N0T3JnODVpQWlLSkxOSitFbStUL1pQcCs2?=
 =?utf-8?B?YzA1OGtRRXVib1J0NCtUSStFSUNvN0VabElmTlFMaEZsd3NvU052OU0xSE1h?=
 =?utf-8?B?dkkwemlhU3h5YmRDSCtRNTlsdFVQdEVWeXU5cjE3MlFoRTdnWUtncFg4bUZR?=
 =?utf-8?B?ZjNxaHdoZkFvcWt5WVRsbTQ4SE1oY2QvUjJBd0x2TXA0anNPOXFFYzBhY1Nt?=
 =?utf-8?B?eVpuRnRRQnhyamNyVUxzUGh3SlV3Tmk5anBqMnBVZGpNcDBNcTNZd3Z1M2t5?=
 =?utf-8?B?aUdmaFNPSnhsQi9VSVkzckpTRzRmTjJ6dE9Gay8xRTNQamhVQ3Q3RkpySVdh?=
 =?utf-8?B?SXJzVnNUc09qV2ZZRk9hNHJrc0JCYTQ1b2NPRzdGQmdFc3NKZnE3YUIySW5G?=
 =?utf-8?B?bWdTRGRpMTl1S3dVdmJoUmJGMzkya2ttTjNHV3FtenpIUHozV0FDOHZrQ0JC?=
 =?utf-8?B?U1BvU1B0cUt5YXVsZEh6UGQyQStsa05HNktOWWREaFZoUlAzaXlRTi9jQ3cv?=
 =?utf-8?B?M3NrYVFhbTJJeDMyODVFWUVMZEV3dmlaVU9wc2dncENSaGhsQTNNVlBndm15?=
 =?utf-8?B?R1lMOFd2MXhUN1RhRU9rUEpRd0hiS0xLcGNIU1NtWWpOalhxTzY5YngrSzBM?=
 =?utf-8?B?bmFQNDNhSlpnV2RFdUVtVTBWOHU4M2tQOFB2YzUwL3hDaklSamVPS0taalE4?=
 =?utf-8?B?bnRwakdUa05iVTNldStIVHlZNjFCUjlWNzJocjZBNWFrYWtZNHlYUTAxcm1Q?=
 =?utf-8?B?ZHA0U1RleWxGT0l6cjN1RStIZ0FPK2RQMkllMjRITTVjek4vRktoMXh2YVNi?=
 =?utf-8?B?UlJRU2ZMOHRDYThMRkxNak5DbEQ2U1RTMDM1WDI4bEhHOGt4UzBlOUMzT0tH?=
 =?utf-8?B?VEJmaFF0VGFKb0xWZ0Vzb29xT0N2RGNhRDdwZjZiY01GTkE0SEtZVmlCV2Nl?=
 =?utf-8?B?clJtOXRFTHA4aHVKaUQwYm1iemdjNUdDaWtvWmNUQjZqYWQwRWxFT2FxSFBD?=
 =?utf-8?B?TFdnRjdvSC9VaGRWdmIvMmNoUTF1NTRFYkZJYkFVVm9hK3Z5eWxwWnJET0or?=
 =?utf-8?B?a3oza1NZZjBNVWlrZzcxbDc1MHRyVmtkV1VXYm5tellJeHNZS2c4YnZKOEkr?=
 =?utf-8?B?K1Q5UGhFb0NNeWZoZEVEb1M1Zk1rSmRlUjY5T083dFZHUlNqSXlKY080YTRu?=
 =?utf-8?B?cDhORDdlOWdTMlZpUTdnLzlTZ1AzV2VvZHo1ZDJlUThsV3JTRDdHekdMM3ps?=
 =?utf-8?B?Zm9WMXR1U3k5NDA1VVRWY2M1cm5YR05KVDdXZWZZdnJuVTZvRjRGbWx5eXNy?=
 =?utf-8?Q?dWAcilDelP8atDjhk6O3ARiEYQviMllm7riPMf1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blMwTklDcWtoM1pwWkFCNEwxZ3prWEdzck5kR1RzeXFNV3J6TUtEUVhZRjh3?=
 =?utf-8?B?dzVzMDRtNzYxT2lPT0Fsdm5CcktGVXRJQWo3cXE0VkNCOWhwc3M5Ky9ZaHBS?=
 =?utf-8?B?bVJseTZRMUE2TjI1Szg2TE9yN2NLd1ZQQm1LMjZuRVVOb01hV2VFUmpPdThW?=
 =?utf-8?B?ajFJT0diMk1nWFJGRGVtbFh0ZE53UlpGYUFWMDFkd1Z6NnFHVmk4UWxLY2JK?=
 =?utf-8?B?b0RIc3A3RlFscm5rSnQrL3RlNW1VeTB1WGwyNkZ2bFRPMWJ0U1h3dVdlUUQx?=
 =?utf-8?B?Q0lROG50OU1KRi9lN3c5UUJpZHpPMUpDUkVJbWVidkNGcjVrRjhsL05xTG5P?=
 =?utf-8?B?M2hqUUQvTzNvZUtnY0pQZ3dtdEE2SmtBd0F5V1BPODF1MzRIZzhOL3czbHlk?=
 =?utf-8?B?WDdXeG5nUmFKNE9tNnR1TWN2dEJDZ0xMdjVJUDQ3ZFdsdDJZajZ0VjZreTNE?=
 =?utf-8?B?amlBc3VILzRVWjJBWVJONmNQYzVjc3AyUS9aaGs4aERmZXNLRkFVamovOCtv?=
 =?utf-8?B?ZUg4R0UvQWNRcTNNQVhpZ3BXcG96bDVqVmMvNkJiVUhOUDBGT1hPc0FjWUNO?=
 =?utf-8?B?NWtiaG9CeDhBcGx3aFZkNEJJKzE1VlY2WngvejhHdkpBNXJOeWZoNzFCNnhv?=
 =?utf-8?B?YXNvMWJZR2tqOWJZd0hNaDUyWE03WWxWQXlNV0gwVHRTSkk5WkdUOGxkeGpH?=
 =?utf-8?B?ZHpjMWNnQTFjSlNMWU1oVDFsSXZMT2tyN3VSa0Y0YXRjdlBrZVQzT3ZxUVND?=
 =?utf-8?B?bDdpMno4c3AyOHY4eWRuVSsxUU9BNkxhRnBGeklqWVk3MGFKZXloUmh3NWZ2?=
 =?utf-8?B?QWlQRXJlcUNVdTNEdERPMEVGMmJWbTNVMHNIRlVTMVpuR3RiczlhYnl5c3hk?=
 =?utf-8?B?QkZHYnNOemRCZENTdEJ6Mklic1RUaDJWMXVabVgyc3M2NVJNUHh1a3ZmWGFF?=
 =?utf-8?B?bGk1cE1vOXRGakFNZHE2NkJnWWxxN2hUZFNIME5CbmdFaW1yS2ZTRVpqV2dS?=
 =?utf-8?B?blJGcElMTmdHSkpSYjlMSE4zTzc5OWZxWXV5VU5oZ043M0UxSnpwSXZBMis2?=
 =?utf-8?B?ZW1TRjdwMmkvekVGNUxNTjZBYmhqajBsQnpmbVQyN1VSa1Z5VU1GT3NLdHdO?=
 =?utf-8?B?NTNEWmRac0ZtMCs0Vm4wZmZRcTVqS282bXZOS2ljUFpKZXcwYmFPQXNtOTBV?=
 =?utf-8?B?WWJjdDY0cFRyT2RQcjU4a2I0dG9jeWptRjZWQUJoL3JuSE41U3FnYUlhVTJP?=
 =?utf-8?B?WHFmRDVFU3laZVFUMzU2TnAyMjMxdXE5WmlHUWZuUFppbEh3MXVLa0preE52?=
 =?utf-8?B?aS9FTHVYbzIzQ1E2MnZ0cXZNNFJYTnFJSDZZZGhFM0x0M0NCMVZBK1FoTHRj?=
 =?utf-8?B?blpBQjlQNDB4RUF4T3BEd3pQdW5TUVIwSy9JclVDeW9HQVhKbzRXK2JMRzhG?=
 =?utf-8?B?QUFZMjM2QlE2U2NzSE04OW0wbUlKaFc1S2xpU0EzeXAya1EzZ1FVR2V2eGN3?=
 =?utf-8?B?TzNNelJmMTVIVDZsMXNKaDhHM2diVlc5V1RocXFOZG8ycDNESzc0ZnV3VGpi?=
 =?utf-8?B?UWkyK1Y5akpTdHYvSFEwS1o5K040Slk3czA0T2xDYksrTmZLM1FMMEtLd28x?=
 =?utf-8?B?NXVNdDBIdlF6K2tLMnJnRWtmOHhTMFk4azVTSFhFVkpvWTdkM28rV0JOeTZE?=
 =?utf-8?B?MVBFbGFoZERNQXgyN2o3TGN2RWNjcXpwRFFHMHpwNEZXR1E4TisvQ2xycUE4?=
 =?utf-8?B?TmFzamR2SVBrbGErazZhWlZLT2dzWUpsNGJmdVNSdHA3dExTd0RNOWZFc2ZK?=
 =?utf-8?B?V0xFcHk5NXlMcWNXWHBtMGgrbEp5UWdwQW5ReFg1R0tvQ3BxZUgxQzdPL0Vw?=
 =?utf-8?B?V1k1dCsvd1VrZTN2VEZpYlBOZDQ4NFpSY1RXTXVhQ0FrSlA2NVU0ejNtWm1H?=
 =?utf-8?B?ZmxSd2xmWVdGdDZGSWpYR2l4YXhMaUg0MFRIc1VLMWo0K3JURzVwbGt0UjFY?=
 =?utf-8?B?a2pweGptYXVHellnYWsybTAvTGtJU3BFVkFocHF2SUd5QWVuVzBsVzd3WGp0?=
 =?utf-8?B?Y3BqeUxmLzdwYTRKRTFOWE1ITmh2WVZZeER3TlBBdVE5UlNBUUxqTTBFWmJh?=
 =?utf-8?B?RlVYbkZ3QkpqM3kwRG5yY0VsbG9qakdPaXpDdWZiRk1COUxoK0JjUjllNkpz?=
 =?utf-8?Q?3gPfaa5J+MMq6+OpDGe9Hm4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sJLa9XEphSw/xykP0DjpsqviDnTLiCd2wp6miTw8FZCZks9EtryHrCTvlmP+Via5F3bsFbesqGO9WPuG3EPnIJPaOW3ncJwQvqjdC0UwFgjN8r7RNgoXobljpIJAfK3iWp95LbG+5HTLYzUbPA7TJ2M+DZyYiptQUQ5+EYeLL67Jk4xKl64u6RzoCH0QQJE8iclISoaiRZabmXvJeMABi/+/B8bGrzLVpF15bhiw4flOHrq7jyn4hN+UgvWNycb2X6k42eLV/J3YjI0cAnHpyw0xtt3VdIylxC5hnuaUoIxF106HDUlLUaSdH12nGVf825nLS/00tKl0NYIVEQOP5p7WLSmISDLq7x46Gtf2ZPrYF226MX+JcyA/AWkT9Pc82Gah7XJawgOMpMV2xIcy/yAUOXM3rqsR5IegsXr1dpxJs2rf8lkX+r4yJAKQNRq0zdm8KG/qM80Uw9U1hwNWhFzV/Gkop2xnoPXK5zYkGi/5NTGSGlMgiOUlCRHpV4pwjps5tm1N1653u8+ZxiPhOMjBRozoB1M9Lrgt2glOnw3s4puOq3NqG64DPp0MiGiqBwI9tsc01FaUP/LFz2X+ayHYi//rg6yVknxF/9lt97E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38014c87-2c19-4a46-42ca-08dcc943f2d5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 22:34:45.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gduy3LVnhWKDdDdbR+y9Pa1fezxc+maopy6tlI7UNqMIXcOt0gH4T8/pVnOZmWPKQAlCufIVenWT47MosXhqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_12,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300175
X-Proofpoint-GUID: wGYQ6-3bEMzJugRO4UK9wtnco2XzlXMX
X-Proofpoint-ORIG-GUID: wGYQ6-3bEMzJugRO4UK9wtnco2XzlXMX

On 30/08/2024 23:20, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 1:49 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
>>> On Fri, Aug 30, 2024 at 6:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>> On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
>>>>> Arnaldo: apologies but I think we'll either need to back out the
>>>>> distilled stuff for 1.28 or have a new libbpf resync that captures the
>>>>> fixes for endian issues once they land. Let me know what works best for
>>>>> you. Thanks!
>>>>
>>>> It was useful, we got it tested more widely and caught this one.
>>>>
>>>> Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
>>>> do a resying in pahole and then release 1.28?
>>>
>>> Did you mean 1.4.6? We haven't released v1.5 just yet.
>>>
>>> But yes, I'm going to cut a new set of bugfix releases to libbpf
>>> anyways, there is one more skeleton-related fix I have to backport.
>>>
>>> So I'll try to review, land, and backport the fix ASAP.
>>
>> Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, I
>> think he meant what is to become 1.5.0, so even better, I think its just
>> a matter of updating the submodule sha:
>>
>> ⬢[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd647312718e7f
>> commit b6def578aa4a631f870568e13bfd647312718e7f
>> Author: Alan Maguire <alan.maguire@oracle.com>
>> Date:   Mon Jul 29 12:13:16 2024 +0100
>>
>>     pahole: Sync with libbpf-1.5
>>
>>     This will pull in BTF support for distilled base BTF.
>>
>>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>     Cc: Alexei Starovoitov <ast@kernel.org>
>>     Cc: Andrii Nakryiko <andrii@kernel.org>
>>     Cc: Eduard Zingerman <eddyz87@gmail.com>
>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>     Cc: bpf@vger.kernel.org
>>     Cc: dwarves@vger.kernel.org
>>     Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.maguire@oracle.com
>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> diff --git a/lib/bpf b/lib/bpf
>> index 6597330c45d18538..686f600bca59e107 160000
>> --- a/lib/bpf
>> +++ b/lib/bpf
>> @@ -1 +1 @@
>> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
>> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
>> ⬢[acme@toolbox pahole]$
>>
>> Right?
> 
> Yes, and I'm doing another Github sync today.
> 
> Separate question, I think pahole supports the shared library version
> of libbpf, as an option, is that right? How do you guys handle missing
> APIs for distilled BTF in such a case?
>

Good question - at present the distill-related code is conditionally
compiled if LIBBPF_MAJOR_VERSION >=1 and LIBBF_MINOR_VERSION >= 5; so if
an older shared library libbpf+headers is used, the btf_feature is
simply ignored as if we didn't know about it. See [1] for the relevant
code in btf_encoder.c. This problem doesn't arise if we're using the
synced libbpf.

There might be a better way to handle this, but I think that's enough to
ensure we avoid compilation failures at least.

[1]
https://github.com/acmel/dwarves/blob/fd14dc67cb6aaead553074afb4a1ddad10209892/btf_encoder.c#L1766

>>
>> - Arnaldo

