Return-Path: <bpf+bounces-66024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F2B2CAA4
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA09683948
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04097304BC3;
	Tue, 19 Aug 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="je5Gh0KT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSlfbvv5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F783002DB;
	Tue, 19 Aug 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624842; cv=fail; b=nJOJZ4060EOglM/sti3bUSsiJgXJLzo7KYYo6vnwKLVUvrJcca3YoR39UHjOKp6kNO9kLlO73EJ22wNdILNWPKnkCpgIe8EIB8fNOW34qoRHXMAvIyLJTT1bARtI4RBiipPaUJxIamKlJtex1VVIdLiGUnPXvxueVmO6OTbhQ6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624842; c=relaxed/simple;
	bh=pDt7puyrpDuxGibJVktDXzmFq+Vsug6FmNS6dt4IlpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxkRC6GZwI15rQI6mUuLmxtiScQUyL52254r8Q9+/kwzLLe39JRb4nG7QcW5NQAtkuWzQg05iTO8AYbiB8SxBsFH0LWnDd/bdGA+6U01itOB1Ibt+I4BhQ7hdF1tnc18NWtH0TXmqu1dB8teaeIuhwW9toWIDeKGGXrQx++p5zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=je5Gh0KT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSlfbvv5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDixho024758;
	Tue, 19 Aug 2025 17:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=//W2Fbe8q7mB5vQO7M7gOtP/lbbRNl/Vy0I39qU8IFo=; b=
	je5Gh0KTT8c5Z18QM53f1vwKraydumEF+bwFHmOM1FIeW+M1Ee0SzJpmDqzl5XR5
	i2ElJPGL6jqXSjGipPtRBqJJoyjkik1RiisDZAkSxFtG8KdhMLG+YN1AlcK/f/4h
	G3qZyKrUBSX7oA+aSy+uxDl3guxvijxN64zBWfjukVBhLAleA/5XL0m3eH0wrlle
	9gIi4/G1iG9CqOttPTlgmubRxa7P1KKVN8E8nyOrx3MpKvbCBTgMJ0+F8LdRrGAr
	YhbD/I2PVycf1nPq7oCzX8XRlZbzQkKfuWvh1ObNkRfh8+Iwm7Wx0nqKTphktF6G
	PoTrNekWPvVZY4qAZITCDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgdfnuhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:33:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JGb8r0016767;
	Tue, 19 Aug 2025 17:33:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgear5aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWN4QO3Y59fzTWcKnvzrVes6YE/wkUXADNZsKZin5Dwbtdxj0DE9ZFAyXgylkbrwTuPZt6186xxWEHke9aYYRDCHKQ9uFU1ScNNp9JU9hCt2VGWnUpUT7FgqFHjTn2mNH5DG7JNmBlETeNdCXPujtrOIt6PJWs9RMm+YeyhYM+y0cvoDMLt9mjCClE0cal2s1QX1m0uA4vhkwEtCzww9K2rbV+bptYmPe/KyvyH6g51CZf5y4N9w6pZlTXmt3y36DreGAJPOciDKzyiqOQpPpN0ONLVY5d5DOOewVyjTGo/psCf0vE0bS4EnWIF8RzVbNZAdJRZqPlalUbNyC2d35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//W2Fbe8q7mB5vQO7M7gOtP/lbbRNl/Vy0I39qU8IFo=;
 b=XaZHDzHzcT5HAl4UznabjKq59B+0vFByqukNt9uFgX3ak4+SbKBsA3sc09Vo1UEp3mwzlTjD4gCdP00vs2UdSw8rU9CMAWUUTpe0PmZQi/NR7CPgMs8mwu8guk64TsoqdFNrnTYn6aXIhXh9pMRq8f4kTB+4tKwJWTqGQLSNfAeInQGOQX2A52gkW1BUOwsbtNRIXFBFbd1RLvo5fgnvWqLjMHtGz1cV8TtcnyaK76sp7GM7xh/q9hqE2RMJDjG08sKBf7t3IZPaSYXy9sJZHRPZxCD3Q6fzp5wj6lLvkD5b/sNdC7cMdCzRAHPZXVZoc/WPb3Km8BFpPmhOhrrbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//W2Fbe8q7mB5vQO7M7gOtP/lbbRNl/Vy0I39qU8IFo=;
 b=BSlfbvv5mWLv3najJNWQ651lelyGj+7IFzv1tnNWs2cjYK+Nmq7dmcyYjRFE9oFtSjimb8TC+RIK/6KwqD0fmJvxMQO5l6HEkvTFxile6+DMmEZk18zTeUfUjyC27P3ZbKUeDgIx1yA67A7GcwntchUYIn0IRFWf6nvPiK+/UDE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA3PR10MB8705.namprd10.prod.outlook.com (2603:10b6:208:583::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 17:33:48 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 17:33:48 +0000
Message-ID: <ad67ade4-f645-4121-a4ca-40f9ecb988fe@oracle.com>
Date: Tue, 19 Aug 2025 18:33:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: "Segmentation fault" of pahole
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Changqing Li <changqing.li@windriver.com>, dwarves@vger.kernel.org,
        Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
 <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
 <7b071d63-71db-49d4-ab03-2dd7072a28aa@oracle.com>
 <979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev> <aKOSqWlQHZM0Icyj@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aKOSqWlQHZM0Icyj@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA3PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: d69ad8b9-2d04-4343-3aea-08dddf468e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckttdllIMy90Tk5Gb0w3VWlPNzdreUJMeWx6aXZ4MjVYUmhESVh2OGc2Rkpi?=
 =?utf-8?B?UXk4ZFoxRzBKOVhHMCtPUXZQSUZ5N0pRMEtONzhaeHpxTWNObE9LYzA4dnZQ?=
 =?utf-8?B?STJhYVZzbFZZRlMzZ2NoMXRQcW5PVXZZb041czhTTW9vMWtKb0lTamJwM1Uw?=
 =?utf-8?B?OWFIK3M2L05QYU9xakxmNkVoa2R4ZCtsWUpCYXY0VkJkczcyUWo3clZyUWI1?=
 =?utf-8?B?MUJJd1I5YWtqQStKejRKRkpFWFpGVEYvNkRzazkxa0xOdmd6V1RjTHBEcE9I?=
 =?utf-8?B?bmpmQmlxVlh0Z2ptN3lNSFkrcXhIdHg3eDd1TVkvODF2QUxpc3M3NW5MSy9i?=
 =?utf-8?B?NVlhNFNvc3VRdUlNbnltTkU0bU9OYVhIaWRrVkRDV2RNSWMzRWMySEU0T0x1?=
 =?utf-8?B?TDQ3ZVMwdHc5KzRBRFZ0TUErdXNVY2NxNndxWGk1U2RrNm1PVmdvc1FGS3Bt?=
 =?utf-8?B?bHRKYVNXNmVaeEJPREhDNU9sWUIxSjRoZ01sNldxZ1V5NWI3RlBnbkNPT3M1?=
 =?utf-8?B?U3ZtQTJTYTE2SkxMbGI4R0djOTVnSG5PeHV5VVZweWFjMm9JT2xaYWdGME0x?=
 =?utf-8?B?QUxUR3lTUGk5aHBFV2UxQk1HV1dUZ3QwNGZYMnVYRGpzZVYyWkJSRlpzVjNY?=
 =?utf-8?B?T2hqVEY4dVkzL2xWOFJyS1IxSG4rZm1sQTRxQWxrc2cxZnRnWGZVN1JQQW9n?=
 =?utf-8?B?MDV6TEpJam1MQzJ6ZW8yQll1YXNrSkxpT1dkUUxtU2lkSnpwTE5ublJSdVRr?=
 =?utf-8?B?ZytiZlVYY3RMSklJODQ0RSs2MU42MHJBZy9Wcmh4QTNFMTREdDcvSjJ5bEZ4?=
 =?utf-8?B?aHcwM3ppalliVzdLUG4vOTZwQVZyVVJmT044V0JtaUtWWldiazVRVUJoQlJJ?=
 =?utf-8?B?K3lWK2hIc1dta1kvQ2VPZ2NIVHUvMG4zb3BnOVY4RkwvYk9TTnNWaUJrZUlB?=
 =?utf-8?B?VmJXakExSXNiWXpMS0xNYVBlNXZ2dkdUa3JLWEdycjFhWU5Oc2dDc2M4Ym1h?=
 =?utf-8?B?K1YranpzYUZqdm9vYUVrV1haUkNLQVVQV0ExR1p4ZTlZb0tXcXBoVGtaR3h3?=
 =?utf-8?B?V2dMaENzNmJPVzl0ZC94Wkl6RUUweGgySzBkM29ieWhCeW56YThka0hpSGJZ?=
 =?utf-8?B?ai9UVldLbnRCZy9EcTlaTU0vWEFIdWE5OWZ4TlBGd1pvcTFoWU9CTThPTFds?=
 =?utf-8?B?NTd3UTJnbm1YbUpwbVRZMzhBNUQ1WmYzU3ZldTduZHVPRVBiSWIySC9zT2hC?=
 =?utf-8?B?UUozMjhRMlFaWDZLYWE2UTE5d2s4dit6eldEc2pXbFFtMEQxdWVhWFgzQ2Vl?=
 =?utf-8?B?OHZSWVhiL3F6bndBakp6VVNXQ3paSHVGRzFGanZldWRiSDlQckNyUU1Ld1VW?=
 =?utf-8?B?YVJKbDErZXpRMExzQzV6NUpwcHVHNVRYVzNncjVlMHcyL3hXZTExaVl3UjA3?=
 =?utf-8?B?ZzVtQ2N1WUpCdDFncVFEWWRzNC8yRkdDZlpXNkZzTTc4bnQyTWZacXhUQ0tU?=
 =?utf-8?B?SWRlanhyMWJWU1dvcWUrVlBla29majM1NzJuNXVFTk8vRnNaRy9iUTJ0MkNq?=
 =?utf-8?B?bmx1RlBYeDEwZSsyUU5QYkovQVR5ZWcyNjNaK2gwc3JYejBpaFJkdWs5WkFq?=
 =?utf-8?B?V1dUYnhHZW42dVJoVkg2OENzTThXK2doc1laWkpsZVZBQnUyQzQrSEFMSFla?=
 =?utf-8?B?OXFRMTVFNUVRMC83R1VxaEJ3dzRVd1E3UDdmVmN6RWlNSlhMRWh6blE0ZWdp?=
 =?utf-8?B?UThyVi9kd1Rtb2xvaDQ2THRDZTk4Y1N3OVZaelcxb05DKzhOT2xUNldDazhY?=
 =?utf-8?B?Yml3Q1I4ekNrQ2o3ckZaTzFLb0h5VU9talRSUm1uemowSXhWa2Fwemhlc3By?=
 =?utf-8?Q?zB/infBA8seCq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG1POGU1WllFUTRiUUVJSmNSUWxmNHA5ZHc5OTMvMGJjRHlWWDY5a0FyTUc0?=
 =?utf-8?B?ZklXRERNaUZSM2hHZ29XZGVGeCt0ME5HVHI0c1czUGFXU1dDK1Z6a2lwK2Q1?=
 =?utf-8?B?VWdqWDJ6Z01SUWFmZWNkTXhqQUV0YUlUT2NFelpvRUpTbjFCaS8xUTBGMkxF?=
 =?utf-8?B?MWhrbDlCZ1BiRTlpTU0wMUY3Y2VSWENGeVF0TTk3cmJTZ2U3VzUrMUU3N2Jw?=
 =?utf-8?B?Q2V3bzczVDBUaGt3d0RiN2NpMVVOZGhFYm1wTkVydW5ZbHYwejFWZ2FnYlhq?=
 =?utf-8?B?bUVyWUN3Zm9rekNDbnpTbjNaVlhQdUV4dU5OMm9ObUdHK1N4ZlNUODlGMTNh?=
 =?utf-8?B?NEpiR3JNMytzSU54T0lRdlZpYzF2RjdLbkNpRnZoWmFUaTVLZVNjSjRoU2dL?=
 =?utf-8?B?QWRLcEZVdmt4dnZSZzhTNC9FYXltSDJWanBhWGszZWdQc3ZnaHc4Q3BqZW5u?=
 =?utf-8?B?NDJMTjNMTXlTTjd5L2FhMzZNei8wZVROQW81b0dqdHdwSW9TaWVPNlNQS056?=
 =?utf-8?B?SEZtMUcySVVER3dsb0J3YngxMnpCcHZkU3lQRGhVV2ZPTENtUXZwWmt4REk5?=
 =?utf-8?B?U0Q5TUVMRE9iR0J2eXdmdVhxZUpaVStNTm8rM1dOU0dxNnNPQXkwUDhjdE9U?=
 =?utf-8?B?bU1ONjllSU1ScGxwV2hXNUkwK0RyOE1iZjk5aEZhckZVcThkUjlaRDdOYjZq?=
 =?utf-8?B?dzcrbTA0TzVtMEVSRWNpODl0WVYralJXOWVzTFZGMnRlSHZmWTJHTEdqdEd2?=
 =?utf-8?B?V1dpSHo1SEdncXo5K3lyUWFER0ZuTVJrUUZYd3cvRjRydFRXQmhnZjJ4a0FQ?=
 =?utf-8?B?dFJNdkd1NW5ZR0R4OHZUWE5Hc1FoSFFyR29xdmZZbVlnYnlBSUl3cllRMTdn?=
 =?utf-8?B?SENoWjNzL3NQSFQ3SEhRSTNaamo2c0UwT20ydE51Nm5SdjZpa2U1eXhXWXpm?=
 =?utf-8?B?R2o4bFJZeDUvcUhDeXZ0WExNYUp6STdmUzZRUWVhcTF3S3V0YVNNNzY4OTFB?=
 =?utf-8?B?QnFzckhJWlBmby84UXgwNkdRSjFscmJZQ0EzM05BaE9lZ3JpbVRKdFQ0b0lJ?=
 =?utf-8?B?bFNlTWxrQnBrcUIrWU5VQ2R6VExUY3kreFJZQ2NaYnNLVkp1SlM5S0hjc2lD?=
 =?utf-8?B?WkprREJhYzI2N1hGKzkveDNyaFp3dkF2eFRXMTA0K3BwK1RqWllLTVNCZFFv?=
 =?utf-8?B?VTRKZUlvYllVZE83M0JKYkpndnVMcnBRWmM2TnJuSVBocVRtcWc0WW16VmRI?=
 =?utf-8?B?cGVjZ1JkVThER0hFQmlUelV3VHhBUlZhM3ZLWGNvejAxNk5UaGErS3hBRW9F?=
 =?utf-8?B?eEZLbkUxbVBLK2MweHZhRERNa1oxUEJUcEpFSGd2cnIzWG1RdjRKdVp1L1Vv?=
 =?utf-8?B?c2NacTc2allXajBLSU1HZlNJR1g4YysvbFgvUS9qVWQ1MUlxUXlNRXhJOW4y?=
 =?utf-8?B?VWZiNGF0dEdyenIva1dxYWhYRXhGbFdnZ2Vic0NzNGdFZlZQV2pidTlHeEhw?=
 =?utf-8?B?MWw2RjVwNHFGNWtwZUhmb1I1MnpXT0ZiYXFzanVmcVRGNS9GUlhTMCtLZ0FL?=
 =?utf-8?B?QUozQ2lHRHJ6Z24vd2MrNHRQQVdhaGVRUU85WUtKdTRHdmVoSUZUL2JKTGdG?=
 =?utf-8?B?SGw5OFR6NjRHVFdsVHhoTG9oNFRmL3pnc3lWeGw0dUJ1NGEyK0ZxR0lTMFZC?=
 =?utf-8?B?bTFFQnhtT0pSbndGUzFsbTIram9iTkhhOVg4ZXdJeC9JWW5kbmRCbFVwem9i?=
 =?utf-8?B?dEtvd2dIQlUydkFGSmtKWHd3TUdmRExwcHBTVHpKQWZpTjhmUWF0VG1ZMHN0?=
 =?utf-8?B?eTJvTnoveGR0TnJOaEQ4aXd6VUdoWXQ3WTRTSVVzSjNJcSs0cTRkS1RiNUU5?=
 =?utf-8?B?ci81dXBYYlo2dEd4UjNHbldkWGR2N1djUkYwRllJbEMzMjJDTmJnQlUzQTI2?=
 =?utf-8?B?ZmpyMTc0UkE1YkFzU3AyOGIveXppTEJ3Ym1lOXovZWN0V3kxVUp2ZXJ5WHJw?=
 =?utf-8?B?VEVWN1NxeXRwM3hFclJ5MWlQRUw2Q25IU3ZsVUNjc3VuSXFXaVdGallNeU8w?=
 =?utf-8?B?Y2t5dFFhSmpJRlFHaXkyOTZRSVJjK0FuYTdQS21DSzNTWDZlRS9zdWpDbnNH?=
 =?utf-8?B?S052VHJnNlZrNWNQaGtNQnVtc1ZRNHBzZDdINWxuVlhUTVBSSTYzZWlIR2tX?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hdv01ScCEw/2bRNXB3Kc38N18emDh/1bDH2ggxAd7NL2tnjuVUFozv4VpywwanrO6D4659F5MPxg8bUplMJl3zDjZnSSA75Q+0C8oSR1LilsaZqnjQkdL8rm52uLbJLnO9cWCNV/U4YJHAmJ1K9L+FwjEwSxmH/3HADZApZ/c9OpFkIoAwpvqLlhldYVNUbTp+fsJxElqWPv9xorIEkTFKn2lge4qeTn8bfo+DnfJR0graumwuFpVD1Vg8zg/YCBH9bZbArIv1yT8zTI/2ksIovFkpqK5NUwWLpz3V7F78FmDU4tPsZtW3CqW8HZukwd/RApECZJINTeyzTsPQIxbGXM9KLLhRMa/exV7BK4IK7bvaakj2fjEgteyAfd9MJQui22hh3f2J4cuzH5K2KIwZHyTCa/jgmBC9MZb5aIOHZqYnKSPyT2r17qokeXj69382EM/kuxVczqTztFcgPOgKtyeUboQZRsgq9FTkaz9ZuH/7A7vRa1kCBaSI+YU2Cvlqf3c+PVQHsZSNmkUNnKNQIZ4aXFgYUcYTPxehBCSD+k0jAZNQ+l5+6pGT233KVXRePpRqkSSYg3yDCoTx8m90qka4IYL+Sm1hvm8kI9pKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69ad8b9-2d04-4343-3aea-08dddf468e02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 17:33:48.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GyGfyJyz71pKM7S9lTGY4gQtvvhOv08QoQ4WJO2wsAjTslwKOQq4Xa9wfMQi5dzrPm6F5l+TCX4khFkpsYKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508190163
X-Proofpoint-ORIG-GUID: bjTRugIJ-HLOz9NnhYqM6ToSlY1ynA9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MiBTYWx0ZWRfXx14hVvy3gG1G
 cBm9TWpn6PSsc1sQXlaFfMdxOCeQWFJmnGQiVORIQ3EMQCRiSVwOf2xenm97IQVaRhV1aPSUXJ7
 qyvf03/F/sUyId2NkC5DT9LMiR6szUWYE4vRjOY3mzp82Oj8k89/gU0q+JXdnYvSUMsaNtaSZrC
 UEGc0cPxU4U6dHqPeLH5/pUfxpTsAf1qXvHkE0ps5VnPheuon4ZhR7odH0p2IgcK4yUQZ4S7gfC
 jve6QEZTnz9NlK1mttxDwcHj+IZM1GuSISMSdOXtfGLHSPNBXvchywX8rZuIQ+bM2PYfiTgmnVF
 6QMnSYRxVsjqT+SdXiOYWsW8jIWIcZcm025nYmbvBTv0LbPuRH/u5vG7aepAwiAtdFrTpRI/5Mp
 gfuJYfi3XaBzPpsklSsxoVhrbLlBk/nxlK9RYN7myCk/9nAwhbuDcXqKqHS15XMokGQjDVAg
X-Proofpoint-GUID: bjTRugIJ-HLOz9NnhYqM6ToSlY1ynA9K
X-Authority-Analysis: v=2.4 cv=OK4n3TaB c=1 sm=1 tr=0 ts=68a4b580 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=yCU7vmp8-8xzMnqFVVUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TlN9_QlMJ3UA:10 a=FdTzh2GWekK77mhwV6Dw:22

On 18/08/2025 21:52, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 18, 2025 at 10:56:36AM -0700, Ihor Solodrai wrote:
>> On 8/18/25 6:56 AM, Alan Maguire wrote:
>>> On 14/08/2025 10:42, Changqing Li wrote:
>>>>
>>>> On 8/14/25 17:20, Changqing Li wrote:
>>>>>
>>>>> On 8/14/25 07:45, Ihor Solodrai wrote:
>>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>>> Do not click links or open attachments unless you recognize the
>>>>>> sender and know the content is safe.
>>>>>>
>>>>>> On 8/10/25 6:18 PM, Changqing Li wrote:
>>>>>>> Hi,  Dear maintainers
>>>>>>>
>>>>>>> I met a "Segmentation fault" error of pahole.   It happened when I
>>>>>>> passed an ELF file without .symtab section.
>>>>>>> Maybe I passed an  unsupport file, but I think it should not segfault,
>>>>>>> maybe  a warnning or error message is better.
>>>>>>>
>>>>>>>
>>>>>>> Here is the detailed info:
>>>>>>> Pahole version:
>>>>>>> # pahole --version
>>>>>>> v1.29
>>>>>>>
>>>>>>> Reproduce Command:
>>>>>>> root@intel-x86-64:/~# pahole --btf_features=default -J /boot/
>>>>>>> vmlinux-6.12.40-yocto-standard
>>>>>>> pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0
>>>>>>> error
>>>>>>> 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0
>>>>>>> (core
>>>>>>> 0, socket 0)
>>>>>>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18
>>>>>>> e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42
>>>>>>> 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>>>>>>> Segmentation fault (core dumped)
>>>>>>>
>>>>>>> root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
>>>>>>> /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>>>>>>> x86-64,
>>>>>>> version 1 (SYSV), statically linked,
>>>>>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
>>>>>>>
>>>>>>> root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto-
>>>>>>> standard | grep .symtab
>>>>>>>     [ 4] __ksymtab         PROGBITS         ffffffff82c11e00 01e11e00
>>>>>>>     [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730 01e24730
>>>>>>>     [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0 01e397f0
>>>>>>>
>>>>>>>
>>>>>>> (gdb) bt
>>>>>>> #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/
>>>>>>> pahole/1.29/btf_encoder.c:196
>>>>>>> #1  0x00007ffff7f92a7d in btf_encoder__elf_functions
>>>>>>> (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/
>>>>>>> btf_encoder.c:1374
>>>>>>> #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50,
>>>>>>> detached_filename=<optimized out>, warning: could not convert 'btf'
>>>>>>> from
>>>>>>> the host encoding (ANSI_X3.4-1968) to UTF-32.
>>>>>>> This normally should not happen, please file a bug report.
>>>>>>> base_btf=0x0,
>>>>>>>       verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280
>>>>>>> <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
>>>>>>> #3  0x000055555555db49 in pahole_stealer__btf_encode
>>>>>>> (cu=0x7fffd8001e50,
>>>>>>> conf_load=0x555555565280 <conf_load>)
>>>>>>>       at /usr/src/debug/pahole/1.29/pahole.c:3126
>>>>>>> #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280
>>>>>>> <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
>>>>>>> #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>,
>>>>>>> cu=<optimized out>, conf=<optimized out>)
>>>>>>>       at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
>>>>>>> #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/
>>>>>>> pahole/1.29/dwarf_loader.c:3672
>>>>>>> #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at
>>>>>>> pthread_create.c:448
>>>>>>> #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/
>>>>>>> linux/x86_64/clone3.S:78
>>>>>>> (gdb)
>>
>> Hi everyone.
>>
>> I was able to reproduce the error by feeding pahole a vmlinux with a
>> debuglink [1], created with:
>>
>>     vmlinux=$(realpath ~/kernels/bpf-next/.tmp_vmlinux1)
>>     objcopy --only-keep-debug $vmlinux vmlinux.debug
>>     objcopy --strip-all --add-gnu-debuglink=vmlinux.debug $vmlinux
>> vmlinux.stripped
>>
>> With that, I got the following valgrind output:
>>
>>     $ valgrind ./build/pahole --btf_features=default -J
>> ./mbox/vmlinux.stripped
>>     ==40680== Memcheck, a memory error detector
>>     ==40680== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et
>> al.
>>     ==40680== Using Valgrind-3.25.1 and LibVEX; rerun with -h for copyright
>> info
>>     ==40680== Command: ./build/pahole --btf_features=default -J
>> ./mbox/vmlinux.stripped
>>     ==40680==
>>     ==40680== Warning: set address range perms: large range [0x7c20000,
>> 0x32e2d000) (defined)
>>     ==40680== Thread 2:
>>     ==40680== Invalid write of size 8
>>     ==40680==    at 0x487D34D: __list_del (list.h:106)
>>     ==40680==    by 0x487D384: list_del (list.h:118)
>>     ==40680==    by 0x487D6DB: elf_functions__delete (btf_encoder.c:170)
>>     ==40680==    by 0x487D77C: elf_functions__new (btf_encoder.c:201)
>>     ==40680==    by 0x4880E2A: btf_encoder__elf_functions
>> (btf_encoder.c:1485)
>>     ==40680==    by 0x4883558: btf_encoder__new (btf_encoder.c:2450)
>>     ==40680==    by 0x4078DD: pahole_stealer__btf_encode (pahole.c:3160)
>>     ==40680==    by 0x407B0D: pahole_stealer (pahole.c:3221)
>>     ==40680==    by 0x488D2F5: cus__steal_now (dwarf_loader.c:3266)
>>     ==40680==    by 0x488DF74: dwarf_loader__worker_thread
>> (dwarf_loader.c:3678)
>>     ==40680==    by 0x4A8F723: start_thread (pthread_create.c:448)
>>     ==40680==    by 0x4B13613: clone (clone.S:100)
>>     ==40680==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
>>
>> As far as I understand, in principle pahole could support search for a
>> file linked via .gnu_debuglink, but that's a separate issue.
> 
> Agreed.
>  
>> Please see a bugfix patch below.
>>
>> [1]
>> https://manpages.debian.org/unstable/binutils-common/objcopy.1.en.html#add~3
>>
>>
>> From 6104783080709dad0726740615149951109f839e Mon Sep 17 00:00:00 2001
>> From: Ihor Solodrai <ihor.solodrai@linux.dev>
>> Date: Mon, 18 Aug 2025 10:30:16 -0700
>> Subject: [PATCH] btf_encoder: fix elf_functions cleanup on error
>>
>> When elf_functions__new() errors out and jumps to
>> elf_functions__delete(), pahole segfaults on attempt to list_del the
>> elf_functions instance from a list, to which it was never added.
>>
>> Fix this by changing elf_functions__delete() to
>> elf_functions__clear(), moving list_del and free calls out of it. Then
>> clear and free on error, and remove from the list on normal cleanup in
>> elf_functions_list__clear().
> 
> I think we should still call it __delete() to have a counterpart to
> __new() and just remove that removal from the list from the __delete().
> 
> Apart from that, it looks to address a bug, so with the above changed:
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 

Thanks for the fix Ihor!

Sorry to bikeshed this but how about using funcs->elf as a proxy for
determining if we have elf function info to add to the list, so we could
then fix elf_functions__delete() to guard the list_del():

	if (funcs->elf)
		list_del(&funcs->node);


we'd just then need to tweak

-	funcs->elf = elf;
        err = elf_functions__collect(funcs);
	if (err < 0)
                goto out_delete;
+	funcs->elf = elf;

Would that work?

> - Arnaldo
>  
>> Closes: https://lore.kernel.org/dwarves/24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com/
>> Reported-by: Changqing Li <changqing.li@windriver.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> ---
>>  btf_encoder.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 0bc2334..631c0b5 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -161,14 +161,12 @@ struct btf_kfunc_set_range {
>>  	uint64_t end;
>>  };
>>
>> -static inline void elf_functions__delete(struct elf_functions *funcs)
>> +static inline void elf_functions__clear(struct elf_functions *funcs)
>>  {
>>  	for (int i = 0; i < funcs->cnt; i++)
>>  		free(funcs->entries[i].alias);
>>  	free(funcs->entries);
>>  	elf_symtab__delete(funcs->symtab);
>> -	list_del(&funcs->node);
>> -	free(funcs);
>>  }
>>
>>  static int elf_functions__collect(struct elf_functions *functions);
>> @@ -198,7 +196,8 @@ struct elf_functions *elf_functions__new(Elf *elf)
>>  	return funcs;
>>
>>  out_delete:
>> -	elf_functions__delete(funcs);
>> +	elf_functions__clear(funcs);
>> +	free(funcs);
>>  	return NULL;
>>  }
>>
>> @@ -209,7 +208,9 @@ static inline void elf_functions_list__clear(struct
>> list_head *elf_functions_lis
>>
>>  	list_for_each_safe(pos, tmp, elf_functions_list) {
>>  		funcs = list_entry(pos, struct elf_functions, node);
>> -		elf_functions__delete(funcs);
>> +		elf_functions__clear(funcs);
>> +		list_del(&funcs->node);
>> +		free(funcs);
>>  	}
>>  }
>>
>> -- 
>> 2.50.1
>>
>>
>>
>>
>>>>>>>
>>>>>>>
>>>>>>> Command  "pahole --btf_features=default -J /boot/.debug/
>>>>>>> vmlinux-6.12.40-
>>>>>>> yocto-standard " works well since /boot/.debug/vmlinux-6.12.40-yocto-
>>>>>>> standard has  .symtab section.
>>>>>>> root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto-
>>>>>>> standard
>>>>>>> /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
>>>>>>> x86-64, version 1 (SYSV), statically linked,
>>>>>>> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with
>>>>>>> debug_info,
>>>>>>> not stripped
>>>>>>>
>>>>>>> root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40-
>>>>>>> yocto-standard | grep .symtab
>>>>>>>     [ 4] __ksymtab         NOBITS           ffffffff82c11e00 00001000
>>>>>>>     [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730 00001000
>>>>>>>     [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0 00001000
>>>>>>>     [49] .symtab           SYMTAB           0000000000000000 154cf200
>>>>>>>
>>>>>>
>>>>>> Hi Changqing Li, thanks for the bug report.
>>>>>>
>>>>>> I couldn't reproduce this error with a stripped vmlinux:
>>>>>>
>>>>>> $ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all
>>>>>>
>>>>>> v1.29 fails with:
>>>>>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>>>>>> Error creating BTF encoder.
>>>>>>
>>>>>> v1.30 fails with:
>>>>>> $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
>>>>>> pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument
>>>>>>
>>>>>> Different errors are not nice, but at least no segfault.
>>>>>>
>>>>>> Could you please share the vmlinux binary that causes the error?
>>>>>> And also check if you get a segfault on v1.30 too?
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>> Hi, Ihor
>>>>> Thanks for checking this. Here is my retest result:
>>>>> On version 1.29:
>>>>> root@intel-x86-64:~# pahole --btf_features=default -J /boot/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> pahole[333]: segfault at 8 ip 00007fd5025179e2 sp 00007fd4e73febe0
>>>>> error 6 in libdwarves.so.1.0.0[189e2,7fd502508000+1c000] likely on CPU
>>>>> 0 (core 0, socket 0)
>>>>> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24
>>>>> 18 e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>>>>> 42 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
>>>>> Segmentation fault (core dumped)
>>>>> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
>>>>> root@intel-x86-64:~# pahole --btf_features=default -J /root/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> Error creating BTF encoder.
>>>>>
>>>>> We can see that the same vmlinux-6.12.40-yocto-standard have different
>>>>> result. After do some debugging,  I found that
>>>>> /boot/vmlinux-6.12.40-yocto-standard segfault since it has debuginfo
>>>>> file /boot/.debug/vmlinux-6.12.40-yocto-standard.
>>>>> after I move .debug to .xxx, it will not segfault.
>>>>> root@intel-x86-64:/boot# mv .debug/ .xxx
>>>>> root@intel-x86-64:/boot# pahole --btf_features=default -J /boot/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> Error creating BTF encoder.
>>>>>
>>>>> dwfl_module_getdwarf in cus__process_dwflmod return different when
>>>>> with or without debug,  without .debug, dw=NULL,
>>>>> with .debug, dw will have a value, then causes the different process.
>>>>>
>>>>> On version 1.30
>>>>> root@intel-x86-64:~# pahole --version
>>>>> v1.30
>>>>> root@intel-x86-64:~# pahole --btf_features=default -J /boot/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> pahole[314]: segfault at 8 ip 00007f2b0b6b2bf3 sp 00007f2af05feb20
>>>>> error 6 in libdwarves.so.1.0.0[18bf3,7f2b0b6a3000+1c000] likely on CPU
>>>>> 0 (core 0, socket 0)
>>>>> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
>>>>> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>>>>> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
>>>>> Segmentation fault (core dumped)
>>>>> root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
>>>>> root@intel-x86-64:~#  pahole --btf_features=default -J /root/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> pahole: /root/vmlinux-6.12.40-yocto-standard: Invalid argument
>>>>> root@intel-x86-64:~# cd /root
>>>>> root@intel-x86-64:~# mkdir .debug
>>>>> root@intel-x86-64:~# cp /boot/.debug/vmlinux-6.12.40-yocto-
>>>>> standard .debug/
>>>>> root@intel-x86-64:~# pahole --btf_features=default -J /root/
>>>>> vmlinux-6.12.40-yocto-standard
>>>>> pahole[441]: segfault at 8 ip 00007f64a9032bf3 sp 00007f648dffeb20
>>>>> error 6 in libdwarves.so.1.0.0[18bf3,7f64a9023000+1c000] likely on CPU
>>>>> 0 (core 0, socket 0)
>>>>> Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
>>>>> 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
>>>>> 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
>>>>>
>>>>> Segmentation fault (core dumped)
>>>>
>>>> I think this " Invalid argument " change  is caused by this commit:
>>>>
>>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?
>>>> id=b4a071d99bb9e7c0d3c6ea7a6835389a4d350ed4
>>>>
>>>> encode BTF with DWARF less files is not support for v1.30, so, since  /
>>>> boot/vmlinux-6.12.40-yocto-standard without debuginfo, it taken as in
>>>> invalid argument,
>>>>
>>>> I think it is  ok,  but maybe more clear reason is better.
>>>>
>>>
>>> Thanks for the report!
>>>
>>> With latest pahole (next branch of
>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/ ) including
>>> Arnaldo's change
>>>
>>> commit 97bf0a0b0572ec023761da9226b068b59b471de0
>>> Author: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Date:   Tue Jul 22 11:22:27 2025 -0300
>>>
>>>      pahole: Don't fail when encoding BTF on an object with no DWARF info
>>>
>>>
>>> I see the following pahole results against a stripped vmlinux:
>>>
>>> $ pahole --btf_features=default -J vmlinux.stripped
>>> $ echo $?
>>> 0
>>>
>>> Can you reproduce the segmentation fault with the above pahole? If you
>>> can provide a way to get a stripped pahole like the above for me to test
>>> with, or provide the kernel .config used to build it, that would be
>>> great. Thanks!
>>>
>>> Alan
> 


