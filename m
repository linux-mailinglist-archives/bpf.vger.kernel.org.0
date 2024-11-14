Return-Path: <bpf+bounces-44840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA709C89A9
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC76D283628
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFF191F6E;
	Thu, 14 Nov 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYlELxMs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bE7nWLmO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2E18CBF0;
	Thu, 14 Nov 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586633; cv=fail; b=EsH7X6iBk+MPlq4OKSiYwhpkuHQBYWfvBDFZxEN12Vs8KSAAdHtwpsCIH2kYC8Ps0QAKaeKT/5nqG8REPtFlPQSHp8dOpNbeA8B0QgwmYkDZucuWiXMMVPhQjfj9J/WoiBVM+uvxJqDCqHLFhx/7AzfRcJGEUWE5anARHJu9dNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586633; c=relaxed/simple;
	bh=mZTdfVCu8j+CkqFeoPT7TkzX65O0ysr8UbyHAgrFF34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ogROlz3kay670Gqjc4f/SqWX8eKCj6zDOYaKrQH9xyy/VHFnSBkK3uCS24A37zpkQR2xYefM0i/WoRL1NdrqbHWEpDrZN5MuSn5xD4UnWoa8st8tgrlGQwSPybt9EAkcoi8HpSrl//nm3MI5vk7qDA+HxBP85nV9kJbO8iyRlPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYlELxMs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bE7nWLmO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1fbE0018587;
	Thu, 14 Nov 2024 12:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jqc5pJXnslpEVPZkV1L1DjCUMpi80kTwENDYF/IRW2Y=; b=
	mYlELxMsXBFZACSdmv1PijaGuGhXc166biynBhmWvNFXesOafPMnDpY5foh26I8o
	wx3oHY3qOgrLvcbguzetKgKqfQS3tv+6Lq/0FPPJUn85Lc3xy5sj665q0B9Z1wLw
	7HAcDZSasAQIkMcy64PU+1s77YZAWBku1Kz2HM4U0GM0zsMi/7NLBJKJ2Kglg9iY
	7Pf62rB1zgs0nNJZpMresR+SAe/BLO2L9l/1MUPNTMXgKzvILkdlrtnNwuyLmI3V
	b69YJSjhR8IoilHpK+z+JIdJX7zlY7U9QdsP59nXQstUuJpVh1CYK4bfJDA7KM3F
	RAl1furX2PD9ejbJiLxi3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc15jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:16:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEC91ma005659;
	Thu, 14 Nov 2024 12:16:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b3j85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH3nJhjexLlNcCUPdmq7O0Ay7o4CUef3MCRSUMlePJ0o4qXDS5uroF/zSx6wV2+hWBeaGNvH/POdvpSc1nlk8+SxjtdBm0vpTdU+t0hgjbzW3L6nt90zgxmMy0PAE9SKpi6DTMRm1uoq0cZy6oyyXyLBZ/gfoyF85xc0bGnrbYSXdtFO0lsB310HX02kZHxHw+VKSUbd4IbKzWgtUFx9PdOKprTRsRlbKJW4NYrYrA/UXJZzmjA4PAmgm529AO6CgHqGlhCI0fcJViKdWRFCznjP01LjFekA3PMoG3MC/MFEC7Red/37z/Tanz1V/zFAT2Te9/ePAyR1dSCjmIrnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqc5pJXnslpEVPZkV1L1DjCUMpi80kTwENDYF/IRW2Y=;
 b=ReH8PNMVnHe8XFEBhdvsBBY3LpdN69EVWLTpdh8Nijh9dq52zHBxEo3BiPIuTIwMW5HvoAkPq/YEDVkHkpJ10/t7hmq7GaHFLVBtrbZWTRxHiSYY1eG1IzSixuJ7g5sadIFeIS3DKLc+m6MkA1akB1h0+054hYloJ5y0URv8cCNqoul+5sMoSmsHwyuA1yH3uWlz7Epj8qVhfxZ4z0G8uw9oWn3ZShvWN+a6txigvO/Qoq4rf0wEdShh51ZyoF30F9f4PJ//snEZP0n+jQ9tbxdbO7KG1Ewjql9tgRNF/Su47Uh52OOiT07RwwIraoUlWCRWuNlulw899OxjrrnH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqc5pJXnslpEVPZkV1L1DjCUMpi80kTwENDYF/IRW2Y=;
 b=bE7nWLmOdCS8cSdKAod465YMboMyMEy6vioy0LaEOLop8H16ouEskAyRO90D1qw0szuwkqdBBH5FNw+uuieLbY70P3L500LkYxtSRW/o1yzc9gmYo1jIi6O2j0RWCpeMB+/4yNuBpfXxUE5dHGE3ntstcz02qTiwL21Put73cXk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 12:16:44 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 12:16:44 +0000
Message-ID: <9bfe242b-b09b-47a5-9446-1cfc0897aef2@oracle.com>
Date: Thu, 14 Nov 2024 12:16:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
 <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
 <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
 <5e640168-7753-413a-ab00-f297948e84ef@oracle.com> <ZzOoGJBiL-l6BfQd@x1>
 <71778df3-62a6-4b1d-9ccf-4a8eb0e23828@oracle.com>
 <548c7b6b-3b84-4053-baa7-72976731ab87@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <548c7b6b-3b84-4053-baa7-72976731ab87@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0669.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d18783-03e5-4432-9284-08dd04a63418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm1VVUk5WWl3S1BPUFNnT0haRzg1MDZkTy95QTZrZUVjc0dNazZ4UjZ3MnA2?=
 =?utf-8?B?VS96amp2MFVvaG0raldrMDAwdktqamNFMzFTdkRPSmR3SGFQUkhiSmxlVy84?=
 =?utf-8?B?MVZlRWsralNpSE1SQ1ZBQmR4alJZd0ZpeTFYWWVuZjJ4Y2pLRElSTEN2N2lS?=
 =?utf-8?B?S3NsaWFCZWwrdlRCVndCY2EyRm5rV0dERGRpN1IwTGJyN2RPbTVqdFJHVVFZ?=
 =?utf-8?B?b1I2Q3ZMZ1ZJUjMrTVJzK3lLby9rWGdYTnIvcVJ6NUprSDlja1orN2dlMjE2?=
 =?utf-8?B?YWRyajY2OFp2cnh1YXhIQ1RidTc4Q1BDK3pZU05heGlrTURUWHRIUWFab2VY?=
 =?utf-8?B?bUNQQ25nOXVsbEx0N3gyZEZlaEFqTXZqaE9GclpzOVFuNDNVNXJPendMc3RW?=
 =?utf-8?B?ZmlMWWxyVG5Qd2dsZGdDbHlhdjZTNkxwNTQ5TFVDUWdpODJxbzBQQ1lTZFd4?=
 =?utf-8?B?RXZwTHljcU11dnBIdjAwWDNramVCUmtHRU9rTHg1SzJZaUY4STRKU0VMZDA2?=
 =?utf-8?B?eDZxZVVOaXE1VzlLSzBLdEZBbWJNN0pQS2oxUUlGSVpEQ2xraWZGNkpRNnpJ?=
 =?utf-8?B?bko3ZlY3N1ArSUFXV0VYbHBONGFHS3NiaERzT05ZZzkzR1ZGSmFnTGJjVGFG?=
 =?utf-8?B?ZVVMQ2tRdkJzWTBCTy8rQWJmdFpiZW1Cdi9QV0gzdi9yWkZnVzlqWk1FZFJy?=
 =?utf-8?B?dnhCNzdSaEYvNEFWeFk2Q2V3R0pZRXhkMWpuWmNxaXcvVDFZemRmUHlvejF0?=
 =?utf-8?B?V1lZczhkVnBoY3JRaStjT2RnNVphVEtVMmVqRXZ0M2dFVk5JUkM4eHlsSjJq?=
 =?utf-8?B?NGZiSE9JOGZ3ZDZMRFlYWnFRdVQ1bWszakdrVFoyQkk0UThMckh2MDB3Z3pW?=
 =?utf-8?B?RjNnN0hxRXd3a3pRQ25GcTRUb3ZERml5b3o0NThjaUZLN0JQQ09YTTMvaGJq?=
 =?utf-8?B?Ry9RUlU4bEdnVVpIMkh5Ynk1d2NtRHJMbnVZaExOKzQ1V3RKYVZoRER6NFQ2?=
 =?utf-8?B?OVY3MmJKbFh0d0Z4N2taa3MxRDRvNTZ0TC84RTc3eTNnOVJ4bVlKNWFmVUla?=
 =?utf-8?B?dTJWNTQwMFhLOXNkNHhWVFU5dTFGVlFadEN1KzNpVnBIR1ZSdzlwcjJlOXVI?=
 =?utf-8?B?Um5kTFZtaHVyL3NpTStCRktGY1EzZmw0RFpsQ05lVCt5ZTBGRmVheUlmTUtP?=
 =?utf-8?B?UnZEa2NTQUhvMjdDTXV1ZGx5QzRWSGhLZFhPY2xlNHIzaXM3ME5acFE5UHdW?=
 =?utf-8?B?Q00xQ2YzbmFTalBQdVp3ZUVrQ3hXRm1ScCs4K3NnN1YwZUNTWWhUTEpqYXJt?=
 =?utf-8?B?amR3YW9Eem9hUDVneFRvVDVmZTI5U1M2ckVrTDZ0SUIvT3JoMnliZ053KzdF?=
 =?utf-8?B?NlhzUHMxeDZlbGJCMTlkWTFWTjVXTG01TFpYQlpCUlhUVjNoQ2xESVhHRGhx?=
 =?utf-8?B?dCtSQk1uVUFaOFZJQ1U3VVZhb002YWFvVmMrUkxCZUJocEUwQlk1YjF2RzJP?=
 =?utf-8?B?NzF2L1hLaXFITDRqbzFqZ1NQMmUwenBtVC91SFJ2THdNT0FWNHE0SnRUaDRo?=
 =?utf-8?B?NzJPRDhMdUQ2NENSK0c1WG5maFRtRHNpUWQ4emNLdzB1SkVBeithVUpZcFQ5?=
 =?utf-8?B?R25RTTFRRHRaVTNwRURqMWNWTFFoZVUrU1V4cnFBL1VLbi9xVlhIN0U5R0dT?=
 =?utf-8?B?OTBKcGlJQXE0Q3NRMGg0SnVCd2FrSWhHMEZ4WmdtVlBJNzdCaFhpbDZPNXc1?=
 =?utf-8?Q?i/rro5Qry6lar+2z8dycQq+hm5g2+T58YKw2apN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUtyZ2FkNDhnYlZGSnpadkJCOFlPUnNvWkxLSDlYR0pxeGhTUXROU0pLQ2cr?=
 =?utf-8?B?QmZYV2daRVp1V0VDNjVBZWNkcTRYVnBESDFSQ2ZSWFJabDJBVGYzM1JyQlhV?=
 =?utf-8?B?T3RrWDhmNFR5bkJOUGhDQy9JNTJkU0M5c1hvUnJSUHREdVV2bW5yNnVQdkxN?=
 =?utf-8?B?ejByTUhLWnpYeVovME9KWStDNlhUbnZoT1l4emlUTFhPSXNHWnpXK1Iydncw?=
 =?utf-8?B?TDBweFlMN2RQQ3dpdmZjK2pLcHhwWGZTU3RvaHpCM0NtUXdyMFk1WDRlK2pX?=
 =?utf-8?B?TVlyUE1LdVlSZFpqQm9naVJJS1NENnZ4QU9yaUcvOFZEQU1iV2JHSDZZNEw3?=
 =?utf-8?B?UnZyQjd5b1QrS1lmOXI0dFNVSkpUSmtjTFZsL0VlcWhwWXFJTUUwcjJVWEtL?=
 =?utf-8?B?cDk4SGhvUW5DV0huRUFzZGwvSnlBMXJXVlBJcDNoMkhGUGlCK0VMV013NFo1?=
 =?utf-8?B?UlBUbXcrMVlEakQzajRzSndrTWgvdUdjb1BhUnI1Sy9jSXBhbGNnYjRzclZq?=
 =?utf-8?B?WWFsMlY1K2Y2Q1Q0WTA1d2RyVHF3ajdjbTZTaFJidFNFaU9EQWRhQXVDc1Jv?=
 =?utf-8?B?d05vNTY1TjhKUTFiMVFTZ1RJTXJUbVY3dDd2RS9lSFNndGlBUE5DZWppQklM?=
 =?utf-8?B?M3AyaStFS2M3dDZFK2M2SUE4NUZBWURWa1dycE9KMnRwZ3hzMWN2MFFqUGVD?=
 =?utf-8?B?VFlIaXJBbnhhRVlXMk5WOXBkTktTSGlhd2YreVNjemF3UW80WTQ5c0IzVTlD?=
 =?utf-8?B?RVlZOHRhaEo5WjBiRUFpd09VSXJ4emk0OCt5Q3owWWI0RzBZdTlBTjJMVXU4?=
 =?utf-8?B?SjJhcVFrZmlxTWROZXRzL2JYVkoyZUNaY0x1K3UybVc3N0JDcnhMc3FGK0sy?=
 =?utf-8?B?blUvNDVQemozWmV6SmFPRSt1c3ZjczhKWHB1bXdHN2FJMUlWdjBYRkUxTXVQ?=
 =?utf-8?B?UDBCaFRnYit2RnNuQThHVVJNN1l0WFBqSGcxMDgycmVUVlhPN0tRNHlpSEty?=
 =?utf-8?B?OUJuVjA5elN0dkNZd0djUFczYVk0VGdEejJDcy9tZ3E1SkY5aTRiRXhPMnpu?=
 =?utf-8?B?K1UrOHdZQU8zVnRJZFNhYTNYNk9JQWJrN3k5ejV4YXlwMUIvSUJpVEpyQ2p5?=
 =?utf-8?B?WEZNQlJ6ZjBvMVJPSENHUVpMRVg2MStnRDZsY1hIWG9wczVJeHRwQjVmejhF?=
 =?utf-8?B?ODNaWkZvSlF2NG5VaW1WWHRHVmlyMUlzN1NqZm8yUDl2dllOaUE2YkJqdStV?=
 =?utf-8?B?ZkJEQzluNG16elU2SWZ2eWVQTVNCWmszUEtzMDVhUXVhay82Y0l3MmpGZDJt?=
 =?utf-8?B?L2xCWVNGbVRnekt2WUdiSlJZeks3d1kxWmZNeHFNK1ltVlZqeHlOSUQzQndw?=
 =?utf-8?B?TVFXb1Y1T3VkenBPa0I3NnVYMGVtc3JweUt5TmhldnpIT1lZcHhRNXVwWWY0?=
 =?utf-8?B?L1prN1pMS29kZmwyMmdXSkswUEZtcGgxVXNIc2hodFNvT25EYldtZ3V6N2NU?=
 =?utf-8?B?YWYyVUxVOUI3dCt5NGN2aWtyOWFnY3FhZmJKbVF2U0YwZitJS0l5bXlxcEdk?=
 =?utf-8?B?bjNjYkx5b1g4dGFWaDcxUE9MUkVWRjZkT0gvMTFja21NYjFPTWNBaVlIb3B0?=
 =?utf-8?B?K3ZVQWVEL0VESkFSUWN0Q2NlcXBWVDBXbUV4cFN6ZDlwVy9mRmJVb0IrQUZW?=
 =?utf-8?B?RDBKYkw0VkZrR1UzSHhmNU8yb25PQlBtOG9rSG9CbDZ4Q04rMnFEaGM2L0h6?=
 =?utf-8?B?T2xlRGhlTzZtbmNEQm1uQTRwMTg2bVJrbTIydzBwVU9mcWh4Nk5PaThpSE1q?=
 =?utf-8?B?eUMxY2pvRGhVWVo2WDBLRU5kNFN1a29qUS9QcUxOZFU5WmZCUkdTZDEvdnV5?=
 =?utf-8?B?a1JDS3RPRHpXT2p0VE11UE1pK2ZMb3Y5czBDTzFWWDhTcHd1SWp4czRBRDl4?=
 =?utf-8?B?d3dtNzE5YlpPQmsreGFWRXpEaGdDZVFIcFVxZGhGYzk4d1VobEdwN2hrb1lO?=
 =?utf-8?B?d3RHYWRTZWhwSkVlYmdhOHBhdHBqd1pGMDJqSFRJallkNjF0cDN6aWk0RVlS?=
 =?utf-8?B?VnlqM0VhRDZKVENSNSs3b3lxYngvVkZyN3Q0WGNLNHZKODh4ckRkV29LUHJF?=
 =?utf-8?B?SkFDSndoWWZwZ0xjQ0czZnJKaG9remh3Wm9ZRGVvbXV4WTg3WWRkc1lsQ2xZ?=
 =?utf-8?Q?044aeVFt9pzoEERTszecgT4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dz7uhOeRknkO4l/BPIgRa1aPHy0+L99paCI+EfYAjhC0ZVjDJgveYuuYepq2JP9on97i4ZmM26v+sd2GQHVAsim0dvchbVwdwxdQhIki1NTCcy3hS5sOzRGVKTH2zosNJ3FbbysdVWxsLJndwgsmmsT6qSuBEN2Jpo0BacQJN7H5g2Z4IbKcceAGiK/F/i1BBe3OEBmMR19VpTo8pNDL/xlcKZ8po6ezcucQ33HDYfLdeST5lSzWRKUs+u8CwTIVoqT+JbvFNLGpRAd07ev7Mw1xJ7a9asbAjWBIZc7WTLgEmcYP+nRulTwHTt2PRGA7uWMuVBewuePqHh2oUte0ZpoFSadB6c37OmBLzFYb3XAEbg5olQmikwv7DWnCDIOnDaPavPb/vm+mpYK6XXl56dVXcJwXbaYnSGeCCL9BUboLg7fQh0hPSwFmHnCCPdzNJiQAcOg8+zBargRCl1jbeWpuuzcZ/+4fkhNFMH6FDlMOj5sbEkbQpo3y8NGru5GsIuG9eO7+y/kVsuEuUy0c0CWki4UmF1XCUIRdsVuRv9Wdrk8QwsLlTOYqrAz2Q/yrApHsycHL5vA2NJgdnLM4Jv67wovq0VY9jjRou+aSRcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d18783-03e5-4432-9284-08dd04a63418
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 12:16:44.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvvHxeJYmYAiizZEts6N4AEhER3Y5mSL2VPiWRw/gKGpi1hmt/WSlOrvBfF8wBTADradg/zUBvV0N/yjIR9JbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_04,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140096
X-Proofpoint-GUID: pHzj5EaKfIpmOXLT3PDiDS6NzZle8q0k
X-Proofpoint-ORIG-GUID: pHzj5EaKfIpmOXLT3PDiDS6NzZle8q0k

On 13/11/2024 18:27, Yonghong Song wrote:
>> Thanks for the additional info! From Eduard's analysis, it seems like it
>> is safer to take the libdw__lock around dwarf_getlocation(s), since
>> multiple threads can access the CU location cache. I've tried tweaking
>> Eduard's modification of Yonghong's original patch and adding a second
>> patch to add locking; with these two patches applied
>>
>> - we see the desired behaviour where perf_event_read() is present in
>> BTF; and
>> - we don't see any segmentation faults after ~700 iterations where I saw
>> one every 200 or so before
>>
>> Yonghong, Eduard - do these changes look okay from your side? Feel free
>> to resubmit if so (fixing up attributions as you see fit if they look
>> wrong of course). Thanks!
> 
> Thanks Alan for working on this. The following are some suggestions for
> patch one:
>   1. rename __dwarf_getlocations() to __parameter__locations()?
>   2. rename param_reg_at_entry to parameter__locations()?

Since it returns the register number, what about
__parameter_reg/parameter_reg()?

>   3. You missed the following:
> static int param_reg_at_entry(Dwarf_Attribute *attr, int expected_reg)
> {
> ...
>         if (first_expr)                     // this line
>                 return first_expr->atom;    // this line
>         return -1;
> }
> 
I _think_ I've preserved the behaviour described by the comment at the
start without using the first_expr code. Note that we set "ret" in the
"case DW_OP_reg0 ... DW_OP_reg31:" clause of the switch statement, so
will return that value; either directly, if the register number matches
expected reg, or eventually if we don't find any DW_OP_*entry_value
location info to return. This I think matches the described behaviour:

/* For DW_AT_location 'attr':
 * - if first location is DW_OP_regXX with expected number, returns the
register;
 * - if location DW_OP_entry_value(DW_OP_regXX) is in the list, returns
the register;
 * - if first location is DW_OP_regXX, returns the register;
 * - otherwise returns -1.
 */

...but again I may have missed something here.

> Patch 2 needs adjustment as well due to the above point #3.
> Otherwise, LGTM. Since you are already preparing the patch,
> please go ahead to pose v2 after you fixing the above things.
> 

Sure; if the above sounds okay, I'll submit the patches with updates.
After testing over 2000 iterations of pahole, I haven't seen a
segmentation fault so I _think_ the locking in patch 2 is sufficient to
avoid crashes.

Thanks!

Alan

>>
>> Alan
> 


