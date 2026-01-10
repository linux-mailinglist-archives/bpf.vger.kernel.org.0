Return-Path: <bpf+bounces-78461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80CD0D6E1
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E9530142C5
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F05344055;
	Sat, 10 Jan 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+EtKoNR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KikXKL0R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA225771
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768053967; cv=fail; b=CO5ocMPjTdDzIHczrEso/UcUBPOydSmffqhxVpm8G1/EFj9FBAClVQKHcWs5JdEutjEqr9r+rPv5x6gA/ZhdhHTmAbUT+Jbm12W4ryRXD/SnfGqTyocuhycI/W6IeYwjk7xI1a1b1zyOFXbPzR6E2focryIScm0NgT+fzCLPK70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768053967; c=relaxed/simple;
	bh=qshnj7lRRO+wCK4YmUBlotCsPToWpi+77CJBkFjIjUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MTGjZoEUVN+2t4IgBQ0CradJLic5s+G2BHMLfkuiOiwmmwjWvrLu77SVSKJB5lg5dBrsPDmTJ4qKZU4ZhQt/mJ+LrmB1DA8xBw98QA9UwRGHW0kayL/D0AHaebTmBshaamPl04E/y4nUI9obLUHV0Di0+f+omYI4d9UUgX6JDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+EtKoNR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KikXKL0R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ADxAG21816825;
	Sat, 10 Jan 2026 14:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u+oW8j81avMqin1kNnd8bD8KlA8Ni0Hc7yop4xRj+Xs=; b=
	L+EtKoNRoGfDAiTQUWl+UcIHHx2qYnGmOxihm3EIuDRHA38nKPL7aW+TkNrTVmTX
	feoqxTQdw7yc17Cm2RQllzYORsjy4ResBKaf+EymPKS2uOSuI+aa/JnEGkKPuwM6
	Puv336RwTmts98e0nC655cPbPrv8vQE2BpOsZ2k0xCWPyTQTjEZ33tCr3Abm6L2a
	DdStDh/+uM2Ja9p8ji2eKCkhC4uAGahN2cmWdgZUDvKWoY/0Dgpb1z+X3QQl6psO
	52kw+rw+UTni3jTmlv1TdqPt6EXrRsxYycqmpPdft6qKXATdHZSQM5f9o7Tus5vk
	tA3AxrssLPGcARFxcmCVxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bketbr7kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Jan 2026 14:05:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60ADhoOI029335;
	Sat, 10 Jan 2026 14:05:38 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7ftfch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Jan 2026 14:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK0H1jSekY+2R9zu63ag+eIDtR4bPGal5iH/pIxm0x1VT6IX/D6CP5yjhDtdDmfbREnC5tdX2C8nC27Pu+xDk6Tqn6jBOFjDiFHQN18sUk81krUkumurmTcgYRP1rpw81lSSHwfB1VYKehw6NtViJ+PFCyM/xwp5h1qXlorfDKVGP46HbXuZl37ARYPrECjQI8na+Rzk5js17XsxRRXrhNrvBwGn2NzINy+D9GcotVG+fjWIu15QBP0J46nFFqJVBQD3ZVmjfqKmwUYem5UvVEM5mXq40yicLHZff9PkZlNOxwo4nJx1NbChBoh7382nEP58VZf8AteoKl+VqGlLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+oW8j81avMqin1kNnd8bD8KlA8Ni0Hc7yop4xRj+Xs=;
 b=QjdiXLlWwR8aSA+qXuA2u1C4VkiiUzAmy3+TfueiUB1Fx+uTMQ/JQwtIBxes3s20wjEu7NjlGlra2n8GN3tuESPcNvNpMnVJUZb6R5W+KlSWerPT64oBg/1mMn8Z5MwTDM99eHygSzx2psnFvJi8w6njdIwUBo35sbK9twEVElWpBIxElaVkR9diPSAhcag8xQEGwltYHndzc5EQaAnSNvvAf8GyZcAZxjc16lRYF2QND/ScMZXjML6g7V94jd3qoggYwd2P3MRRQ3kZ6BG52KKWfd6OsF6kjgIJIpiSgyqglwyveiC2N3QvYzObxzavsz+yROh3xl1IVk8tiHiB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+oW8j81avMqin1kNnd8bD8KlA8Ni0Hc7yop4xRj+Xs=;
 b=KikXKL0RPbC7jUP6yvjeFdBtQs7jFqzURPQWDNbE+k3otMJAQOXvwb+9PNcnEz4pHoNsWpO1/Hpe76hTftv3KMDN9RSI4WB0arvL52eV8v3AXu8eUamjM2DtJCKgccyHrOLPMAdQef8aur9YUOInH8/SmXiVUhm2sT/zNX4DW84=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 14:05:34 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Sat, 10 Jan 2026
 14:05:34 +0000
Message-ID: <9594c48f-1651-4448-b8e1-5a8a07f64108@oracle.com>
Date: Sat, 10 Jan 2026 14:05:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        nilay@linux.ibm.com, bvanassche@acm.org, bpf@vger.kernel.org
References: <20260109101325.47721-1-alan.maguire@oracle.com>
 <CAEf4Bzaysi-ji0Q2m=6Fc0YTPnrKVOPDNoQW9Y6rB03R4Pe3aw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzaysi-ji0Q2m=6Fc0YTPnrKVOPDNoQW9Y6rB03R4Pe3aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: a98d27ef-6aaf-4b82-c600-08de505152a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnFIS3JuOFNFeGg2MUhVQTA0SnkwMTV0eFhyN2t5V1lRVmRCYnlDOW9MVjhz?=
 =?utf-8?B?TWgrUkpYT3Z3anJZcXlkdTVGRXc5d1VCUmN0eHYwQ2QxbmtkRWxMc2FJalB1?=
 =?utf-8?B?TjJjK2R5c0YrcERPU1JQRlFqNFlqcER0UjhVUEhxeWNFTjkrK2xmN0VYVmcy?=
 =?utf-8?B?TkZ0alFsQmlLT0pJaWxPeVBmZi9FRjJNaHNXOUZrYXl1bWZQSWh3cGx6M1VE?=
 =?utf-8?B?eEpLVDJWOS9iZmdJbXdJVm5XR24wdGdpUHpsM1VRMEtYVVhiT2NDRkRRVUU5?=
 =?utf-8?B?U1E5bk52cGswNjFGT0NWT0RRYnZuUmN1YXBvTEhJMTR0N212UzJ3RXF4QTl1?=
 =?utf-8?B?eDNIdmphQ2xnKytYNHZCUkZmcU5BY005WEMwSDIvQjJpZ2F4bVVxREUzYnhz?=
 =?utf-8?B?bFFHRlZBcmJJcHVkZFdaUDBTM2pYRHRwbDdzdjc5NVFNK1ovVDBGNmlMSlpS?=
 =?utf-8?B?MjhwU2FlbUpORVhZSm43eVhXL081OTY0bEdoSnJUcjFZbDJDR24xSUpaOGNq?=
 =?utf-8?B?TFFocWVrK2dmekVDSjIwWjBHTzV5aUg3cExIL0Ewd2owM1I2UGpBWEZybGRl?=
 =?utf-8?B?VFFCcWRVVzJuODUzekpYdEhoajhybDlxVVNlVmN0UnJVQjFzSDk4RkJGcjBy?=
 =?utf-8?B?N0FQM01zZXV6Tm9QdUM0ajZBSUtTaGNhaVZJN09yZGJRWno5UXk4RWVJTS9t?=
 =?utf-8?B?SUVlZHZtNGlET05OcWtaNzFnbVI3VzZCMnF4S21YMWI0YlZiR2RmeTc5S01h?=
 =?utf-8?B?UkVxY21PcFZ1cUcrOUlSdFNHYzhNUkxPUTcvd1JET2UxNWxtemU0SkZpVmJP?=
 =?utf-8?B?UXdYQlNjdDJ0TktCcjQ5WE44c1lnQ05zSnk4UEs5VUJweFhxZFZmdFlja0Zs?=
 =?utf-8?B?bmZab0lBOHBwK1o2aEM0MVR1NHk3RGExY1UySFhwZ1BobjhNU0s0L0p5N0ky?=
 =?utf-8?B?Skp4OE9DbHVRVDFqUDBRSnNxSnJxUWFWZDAvRjRldDI5NmZKM3ZSd1A1WWJN?=
 =?utf-8?B?M212MkZnSkxLZlN3WmJzTHRqTFFhNVdKdlBhckVod2lvZ1REVW9na1lPaE1C?=
 =?utf-8?B?UlFpZ0VoS0RWUmwydS9CNWJOWmxsQkFEZEZWSmw0YlpJRTVCTThlTHFnZ0h0?=
 =?utf-8?B?c1dFNDc4LzYwcXFRaDdnd1RvZ0RtVnFZcDNBY1JZbjVobFh1d0JpbGFTc3FL?=
 =?utf-8?B?Zjc5bWprOU4zTU1YWmpqdnlSNzJiS0tJVFJFVzl6bVVNUlppMjc5MGhON3VB?=
 =?utf-8?B?QzN2TWg2Zmk3OEwrTTZDNEgvRXZ4c2dhV3dnNGZod2ZYY3YzTkVSQm5PTDZY?=
 =?utf-8?B?VGp6Z0RLUVpuYytteERtVU5jZG5wVk0vT2pJMmViTVE0ajJUeGJwNVBJVjI5?=
 =?utf-8?B?ZnRrOXVsUXFtTlZBaFQ0T0lGQS9Ya3BIL1M5RDBNOW9WQzhmRndaNWJMMTlD?=
 =?utf-8?B?aE5xNjhURlR1dmlLOW5oNnBKK2FYVGI1bHJTS3NaZnlIdDlCQ3ZPMG0rbmNQ?=
 =?utf-8?B?aHp0Q2ZrV0d4aGU0MFFGQy9jQ0NJU05MOWpQZTBEMjdwZUgyNG1KS09iRGYv?=
 =?utf-8?B?amwvQVpyNUlHNnFXeDRuYjFKbnNHZjU4S2RTQVFSWmhORkdUcjd1MXhLWnho?=
 =?utf-8?B?dzdQL28zU083MFhjQldwRFpreXNTcmhpYnlrRHRBWDBPQ3FSUEE4VHhUZ1Nj?=
 =?utf-8?B?S250WXFaamk0VG41SnJsbS9CcmN1WUkvUGZ1TUh3VWMxWWUxMUh2OWY1T1Rm?=
 =?utf-8?B?V0FMcVdVTnRITTNRQkNYTzFUNjlnQlNBSWNtRzRvV1JWaVdQM3pNNVJFNEF5?=
 =?utf-8?B?eFZVblN6bnpLMEJzdGdWMm5qazhYakxHUlgycEdkNmdSbDlEeUVrdTR2MlJY?=
 =?utf-8?B?RzBoN2p5UlMraTlqaEdhcGlPdlgvUzNLZEtVRFZWT01Gc3RWSSs3VkZnL1ZY?=
 =?utf-8?B?cXFZWnRRN2RyMzZ4a3lRWm80KzhESzJLbi8wOWxabUNXaW9sZmJSbmJDdzZ2?=
 =?utf-8?B?b25FVCtEV2JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1lSS0VCditxT3FPQ2pwSy9nNmlRN2xSUnE5OXZ6Mm4reWh6SW9PcVlYbTU4?=
 =?utf-8?B?Wm5IZ0pOcWY5S0xocFZ5a3ExY3VEOUtvTFMzYWV1c0RBMFVOVHM0UGc0OFB3?=
 =?utf-8?B?UnRqTlp3bWRFeExZY045MXcvNTlITjVKVVorKy9vKzgzUWQrUjRoc0w3dmRn?=
 =?utf-8?B?M2NacW9CaG5jSmN4WEszdDhrdXFRdW5BNUlBc1VvZFlSR3BhZ0RwSU9jdVIx?=
 =?utf-8?B?YjlTdlpzNjRlQVpsT3VxK2hRMFZTaUI0VnZGZVZVNXhUR3lRSnVJYjA2V1lH?=
 =?utf-8?B?VjlFLy9hMk9QeXZrVmZYNWllL0Nnc1FBRlAyY0dhOTNQdmh4KzdSYnk5VnRm?=
 =?utf-8?B?WkNhV2JvU1JFcFJWUWFvUnVlM0ZHb2JCSXR2Kzg4c1NDRHNpMjNyNldPcWFm?=
 =?utf-8?B?Y1ZsSmNtUlpVOTBFSFdpaFd0SXFlWE8xbFYyMVJBbXR2eERIZ1U3WEVSczdE?=
 =?utf-8?B?d2dmS0hHOEJPay8rM002cHY2ZnQyYzd2ZEZZOFgrRWlYVmZRc0FwWS9aZmor?=
 =?utf-8?B?Q0FWUmMwUzZaajB1Q1RyNWZsYllZamZLWkJMZWF5dytxQUh5Tmg4NDQ0SmdD?=
 =?utf-8?B?NUZ2dXJjcERvZzNBaU42L0pHd2ZlQTdqNzZqazZLMWQyT2lCbHk4L1liRk5B?=
 =?utf-8?B?aTBDbjl5TkJDNW9YUCs2akExTldYN2k2bnJ1WnNGWmFnWEtZTWNHYnp0T0NJ?=
 =?utf-8?B?VW5NampydWRLQWhNYXBieGFmdE9KUE5CbGFHVlhMMDZDT3RwZzNnUStxTXJQ?=
 =?utf-8?B?aHkvcVFsUFk5WHRVWjZldEcwSXlhSVJTajIzclZ6c3dmM042L1dsMWFNYXB6?=
 =?utf-8?B?dG82SXFkZWp0SDlDTXBqOEQ2K284Q1FqR2kvRU5Qc0NNeTErWHdEcndid2Zm?=
 =?utf-8?B?NFNYWkJ2NUE5YWRvekJXdGZySm9nMElKb3NnMnRzbzF5UmZtZHM3UHlwRGg1?=
 =?utf-8?B?ZTlmSGRiT1d3Q3l5V0hpNFMraXdnRVI5QmJVeURCcVlaaDluWHN6RGRXL1BQ?=
 =?utf-8?B?OW1tdlJzcEMxcnIrbjgyN0V4cmtscFM5TERsMm9jSHVxNHBVOGVOalpBZXNT?=
 =?utf-8?B?NjB6V0J6TXFFczFMT3ozUHVPbkxCRXl3WHFPYXh3UHhiNXhiVy9CWXRmd0N1?=
 =?utf-8?B?QXduQnhMTHQzdGJ6WTBVaUVtWnVHblNVdTFwa2lpWGEvREY3S3BNYTBZWGwx?=
 =?utf-8?B?MGdLQkF3QXpNZEJ4SlNOTjBic0ttLzluYy8zTlZXSkRJekxmY2drN25BdXdw?=
 =?utf-8?B?ZU5hR1Z5dHd6VE5vTFZEV1A0cnJ5WXMxdkx4eEpsdU5iRmZLektSY2Vxdzln?=
 =?utf-8?B?ZzNKaDFQUHhuajJOL1MyWnlwUVcyOUl0Qm9vR1oxWEY4QXZWc0hwRkZKenVF?=
 =?utf-8?B?bWlqWXc1WitrWlB5eHVvYlhLc01sbWxEd1ZzOTZ2b2Y2SVZrVkFWc0xTRzJM?=
 =?utf-8?B?eVNyd1M3Q1FMNFdWZkFFNWRJdkpyRUdleVA0VzF3UXh1NlJDWFhwUkF0Y3dC?=
 =?utf-8?B?a3VIYVRBS3Q4ZjY4M3NERzZFeHUzMCt3S0dNY2REV0tYdUtUVjZ0ZGVoZXl5?=
 =?utf-8?B?QThaZnJKTXdvcTRXQ2VSOWk1YmZkcDlXVzR3N0NKMUgrN3A0QjJ4M1pnM0w1?=
 =?utf-8?B?dnd6TlZ6R2YvVHhtbmJPQzhwMDV0b2QvcG9pMksvZ2kvUnlpR3RRY1ZlbXJ2?=
 =?utf-8?B?VVRTbEhaM29sUXRVM0VtNEFXMlBSclhJb1BWcHl5RGdpUGVMYUMxL0FnZmRF?=
 =?utf-8?B?TVZQeUhUa1NmakVEaW5MUnFnN2xldGZJRS8yR0s0R0pYQ3RYNHVDcjVoRmdE?=
 =?utf-8?B?cUdiWHRCbGh4Wis5MUp0RUpoVTVkUFQwaEN0SkFFb2xNcmhDYlVGRVVIMk9Q?=
 =?utf-8?B?UXp0SEY5VERlOTJIRHNhQTViWnNzemlWNVNXT0UwWkNQTTJnNmRSc0lOZ0xx?=
 =?utf-8?B?WllTem5YVUFjNTVlb21zeHJSQUJBOWZBNlVWeTRXczhhbnZiS1FFaEdhbDFN?=
 =?utf-8?B?MWNya0o0Zlgxa0UyVzNtZzZvSXRZNFVUWHcyRU12V216UzhUbkNaNFFKaHly?=
 =?utf-8?B?N1A3QXlvbCtPbXpyT2g3czRaNzBvcVdzL3pVczVNa0k2V1gxdm5RYVlpSldT?=
 =?utf-8?B?KzFDN2FSVHg5OEo2aHltRFMzV1dJNVJkblo2ajk0OUM1Y0FCaStjZHVNS1ZR?=
 =?utf-8?B?Yk9uRTVQZXBuaUNKWmZnWkR5VDdBSTFBWitRVldiZ1A1aldETlh2dTdtNmVV?=
 =?utf-8?B?SStPN09RV003M28wWWU5REV6UitCVmRBUGlpd1lYdTU4NU9FZEt2YzRWYmlQ?=
 =?utf-8?B?NGRKL01rMDk2WjR3cjBCWmIvYlJHNm5UQWRsanF2M3A0OGVvT21SZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TxFJihLvRwZ82EFnbQzl2zp/gPfNNW/Fo2q4+vNWRalSWWMOQA/uOfhA97qUjaJGAwP3iH3JX3sxU/G+opO7zoX+7B9Lmsw1GfWpY+AYfe4FHEHtFUvVfDwQF86XpZ0P4aaNeNNpi6QJj2qOszFvtNqmwpSQxfnZ2pZR6720t97MAuAwHDkNAx3097qVz7tCS+I7/7iAg5wzfb4++6Z95fkUQxBSskrYR5x+qswLAEpMXil4GLNlEgMTEbkvmJ02IyMm3zXnuAdlzS6q223ySltz5BY7XyLeYM+GahDxJ6jGO22oBR/61iUrQBniSw/JkJyvp84DaIO3gRJq+I0UCqbKAW2MOINZ+LQNfr70ctHYVzkXpWCkIy1sRcMP+oFZs3dYeDXEaF0G8iKtpBLn54NZnpSfJtqfwNz0E1iViCVe1r3dUSYTiELf7hE2EYhzpqlIioU2Y0rQ70oDNPDtV1z0n1kYDdSjCdLEbIHS/qOi43uMdv1n/L9355wWwe926HAflOaw7G0x4yPuogCVXDPpeZBnPxPLz0JyPNSq5fZlv16vB2BUrYzRsa+lDVTclP4O3Q1UP7Qa7evEQCtKGivA+COmUXW6ZEECnk6DmdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98d27ef-6aaf-4b82-c600-08de505152a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 14:05:34.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur7rAL8Ixso2hp1z3d9X5N0ph+17OZn7tIKhC84YFSq4+nZ+PELj/qA8VX9RUK675PdJbmrEEEuzDrGUdt3HBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601100122
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=69625cb2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=uyWW8qpwm5CMpyDoaEIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-GUID: NU-_xd0NSteM7seltcf7uzgHfJfVQtjJ
X-Proofpoint-ORIG-GUID: NU-_xd0NSteM7seltcf7uzgHfJfVQtjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDEyMyBTYWx0ZWRfX12j0VDP/2yOC
 XI/ExiBFwD2Iqc6QMruZShDCmC4r2NyxbbnkZJwVXTI1f9FaVUngEh2g2eTkEl8RXo4BAA82jze
 HsICs5PiRC3/HgxF4zLdGKCyUHNtr42wQWGPie99t5BEkoUxbjs8hVB/X/PhF9eZ+YtsTRrkQM4
 ZKm9SyjdEAgdjxdnmqSUQ4ElYDm3P1dUoZ8CzXeLhDLRanFc16+4Aa+mioBcfAgVRNeJCtRS8s1
 YlHFKAD7GRoTteR9Sfim+zk7SuKdMY4XkwAPa41Xd/tvbgsU7d2R3tMu9SeRiWoSFt9UUxEJ77l
 2a6qXozVM8Xy68Q7qN4cO4noVIcrR033pxMLLKfQFmebZvQv+kg4ShZ3v1PDzGCfox8JHld1HtJ
 WvlVwoQ0ywkM4QuJ1OntiNeEzco2NgPvJQ6Ifxbk7C/ad9zQKsKHwk5WH/570sB+6eOvYb6N3Dl
 S4AKQYCqZviqMhL5f2joXKrRnWvkZf9iHW17F2bs=

On 09/01/2026 17:28, Andrii Nakryiko wrote:
> On Fri, Jan 9, 2026 at 2:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> We see identical type problems in [1] as a result of an occasionally
>> applied volatile modifier to kernel data structures. Such things can
>> result from different header include patterns, explicit Makefile
>> rules etc.  As a result consider types with modifiers const, volatile
>> and restrict as equivalent for dedup equivalence testing purposes.
>>
>> Type tag is excluded from modifier equivalence as it would be possible
>> we would end up with the type without the type tag annotations in the
>> final BTF, which could potentially lead to information loss.
> 
> Hold on... I'm not a fan of just randomly ignoring modifiers in BTF
> dedup. If we think volatile is not important, let pahole just drop it.

It's important to stress that the final BTF representation doesn't ignore
the volatile modifier; in fact it is included in the final BTF for the two
cases where __data_racy is used in a structure (in structs backing_dev_info 
and request_queue). See my response to the AI bot for the reason we weight
towards choosing the more complete type as canonical.

> I think BTF dedup itself shouldn't be randomly ignoring information
> like this.
> 
> Better yet, of course, is to fix kernel headers to not have mismatched
> type definitions, no?
>

Of course, but these are not mutually exclusive activities. Some issues
like [1] admit to such a fix fairly easily.

In this specific case however the __data_racy annotation definition depends 
on __SANITIZE_THREAD__ which is set via compiler flag, and there are cases
where KCSAN is deliberately disabled; from scripts/Makefile.lib:

#
# Enable KCSAN flags except some files or directories we don't want to check
# (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
#
ifeq ($(CONFIG_KCSAN),y)
_c_flags += $(if $(patsubst n%,, \
        $(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-object)), \
        $(CFLAGS_KCSAN))
# Some uninstrumented files provide implied barriers required to avoid false
# positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
_c_flags += $(if $(patsubst n%,, \
        $(KCSAN_INSTRUMENT_BARRIERS_$(target-stem).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
        -D__KCSAN_INSTRUMENT_BARRIERS__)
endif

So there's nothing to fix for such cases; for some objects, disabling KCSAN is 
intentional. Since some core .o like mm slab/slub files disable KCSAN, the 
non-volatile fields proliferate widely.

[1] https://lore.kernel.org/netdev/20251121181231.64337-1-alan.maguire@oracle.com/

