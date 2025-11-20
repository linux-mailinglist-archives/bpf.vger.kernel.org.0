Return-Path: <bpf+bounces-75197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E4C76786
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7254E2148
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48326AA91;
	Thu, 20 Nov 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QiG7Yq8W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a7Bxm8dp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65897182B7
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677198; cv=fail; b=bR98Q8bDl9gOApYzu5gLJFNZbawdV0oN1ndaoPsBKbB94w9Y9rTYRpFseXjudIbrMdERTOenHgZKJC49SDlBY6FYnj5GIDWCOzDNWd7kugRpeRqLY9hGR4kfktV+xeUnAUSBl543SJbJrHDWrgcW2qVXOwyuvT71Xocr26Pm0kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677198; c=relaxed/simple;
	bh=M7q/T97D/i++bZp+nDLVVHsWq53z7iFdokIvOLVyzTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuexfxL0UQDed8YEBf8HZ7BPXWOZVfw2otHUrvb70WH0pLnwaZ/NhE3SJlbqabFGsB5k/Esst9bmFVpVGvSCG5o7ImVNYvn9kw8h1rX+fFp3OYAMKP3lKHiO37tIwdizuNsa1exF0lDnV/dZR12xnJZEB9g6VgZ7vfxuqzBu30A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QiG7Yq8W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a7Bxm8dp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJgI70011681;
	Thu, 20 Nov 2025 22:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L0VpNpfXqOuVZpRXhYOtgwaX8Bj6PgKH0K2VMNfsHZ4=; b=
	QiG7Yq8WMom1QsaQ7TRczCHZl1W/MtWxzTitIZ5QpIO46fZqbcgB0Qc7nmnc7T/b
	co1IgSwqb7dvtBMiXMu0Yk+g2EzFPcqWE2Ji2FWY3GO4ElT8t8yTy9UHOuSG2gk7
	C8pEJUiKf2oO7urG+zdK5jkHIOUlxQK9eSS1ppqZZTrvtjwLghHFpxRlgEVEb6yz
	Jk79q1ofj1v5A9Hi0SB3D3nt0RR9pkd1ttoeXcyah8or7QE2xl1MXlTf3iqx1jUW
	DgBPRNc3cUbEZOOY7U1Ol//Uj87O1IRWRA4Q2R+oRdYFK0zKHIr/ss8bwKJ2rTaS
	0pE4Dst8RrAj4by116qiIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbjbvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 22:18:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKM1KH6009450;
	Thu, 20 Nov 2025 22:18:38 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefygv77d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 22:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwScZ5ECvW5QoOLz7Djel0QdyhsJGxyu8mcf0EcWI/KF3gQaAUBI2qKicr12RquVk/l/YmcnImG1qBKSizbrnTlriRS5IE5+cL0WqX32/2CgR6prQYzPffPtcmrJ+I7WGmtiQLkXlXXPLIlgVXL6qEE687T6CyXAf45YmzY236gbzERn7OwHStAKH16nj4Y9Wq5yM/f/Nxd42A77ysQUFmLNDl1yJ9C9AbtGnTwNTFl65GX0hRujF8bKZ41uEueZebAQGMwgKVO8MKrVtr1c1LGmIWmi+bL6c8uinOF7G5ZKQ4+DFphYnTqePOirMFXSh0zaGm9TyzB3zuKeJFpCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0VpNpfXqOuVZpRXhYOtgwaX8Bj6PgKH0K2VMNfsHZ4=;
 b=w0mAQcCvuo28PIS/svfh4sacWPVI3CTl9A9jE7ueFO0hZ4z6SxuKc8pDeTy7EsdHPmqj4acGfP1C5G/JA2AVdzEEZ/rLKVGLYOmOxaTkJBQ0xAcwfERzOzaA2ksWof81VH0WskFqlZRTLTYLz3UmMoi6PpcBry+jR10QQYxmyl2pMVN80biGwRBTwRQUmQufOFPg68bRFCfaraCGU5C+HJ9n+22/YHHqO8dZd250hfOzARYW+x+FjLqhbe651g3nounStWz2/vPZp1HtQSxyuxAVytDT/IO23oxR/nHLYg/MV1NIDpKqsNmuns26AKUdQgu8z5P9sQMcjduxjCu3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0VpNpfXqOuVZpRXhYOtgwaX8Bj6PgKH0K2VMNfsHZ4=;
 b=a7Bxm8dp3JOIUZ4z1zee83NFQmFg0cyI54iQzqrpzoG4YJ/2VBkxn2Es/OwIOyzJRqS8QGXG/iBscMTcbGGVxpVZPSkkebzg3eY/z4+R9F70ktD/nswkeIqTgAt8rBxSOuwSemBtNaPa7CnyVFxdL2rU7niJ+KdOGDTM42mjRTM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 22:18:32 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 22:18:32 +0000
Message-ID: <bc54daab-3b01-4a25-8032-52a123fa823f@oracle.com>
Date: Thu, 20 Nov 2025 22:18:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
 <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
 <aR9YasvOhnSI564i@chelsio.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aR9YasvOhnSI564i@chelsio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 40045619-7555-4253-3234-08de2882bd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnNDQWREVjZiS1VscW5VZVlBcVpQQm1aUVJHdjBJSWdyVmRIbmtzUE1jdk9i?=
 =?utf-8?B?VFN5YWtiTE5reUdyOU1OMmZtSWp2bUtqM2pXOS9jNHZobkxoK3pCa1hRbk1F?=
 =?utf-8?B?YVBIdHhxeHNYbmZtYzRVWlVwdHllZjVLS1gvWWJvc2Q2a2xOMlE2S3ZLMEl6?=
 =?utf-8?B?bU1UcjNUY0QzK1pUdXRsU1FQbEpzOVBXWTB5ZVlkeHpVVjJUWjRMbTZyZlFB?=
 =?utf-8?B?QzZjaHZlK1BRWTRrYm80emJ2RHA1TkFpNFExR2o4YUkvcWNIeWlLL2xlNlRV?=
 =?utf-8?B?YmVGeUlIUEdHTEhYdFo4OFRpc21zTFl1K08rQlFXYmptYkozT0JBd2FkcHBu?=
 =?utf-8?B?c2tzOVpEYnVzb2dHdzg0SEpzUHpoaWZNT25rcm0yMXNwNlNHWlJZb0xWeEhv?=
 =?utf-8?B?TGpHeGp5a1dQeVYvd09Jck54RW9GTlBERmx2TXZWZnRmYnYySDJxUk9MVDdV?=
 =?utf-8?B?b1B0NlAyOHZzM21ZcWJIMWVDS1dTUFV1Q203UnE5eVVPR2Y5RE5sQzE1MDhl?=
 =?utf-8?B?VTRHWmZiZ2xoWHArNlRIQ0wrdzl4S1NVREFIWjVSdFBJWFJzT1lhck9HRURK?=
 =?utf-8?B?V2ltQ0s4ZjBQYmQ3ZlNPbjBCay81dENXdDVhOWsyTTFQZmk4WGFsU3B1ZGZU?=
 =?utf-8?B?bm8wMXFZV1RQK0wvZUlHOTJQblE5WHZNSkxodVhJV3V1WnBCcWExS2tucjla?=
 =?utf-8?B?SXJseHlNaWRxVyt3S3RMeEd1Tno1bFF3L2JTK21xb01tbCswQVRGUU16citZ?=
 =?utf-8?B?K295WjlVaFRMV2tmZms1bkUrZzhEREtSbDJpeHR0K294TjA4Nk9OelZwbm54?=
 =?utf-8?B?cFFnVjNtdVJQdnB6a3dQbnp1R1pIeEh1N2FlWHo3Vm1jS2liTEk4TUFxOEFS?=
 =?utf-8?B?amZER0R0SWpNOTV6U1pOZ3VhRlM3dEorMGx0dG95akMxNTUzQVdvMlVZci9K?=
 =?utf-8?B?T204MnFFdGJTMGpDMnFyTFdVKzViMVYwSUkzL1EyNkN6U2ZGdUNRdXRCT2dM?=
 =?utf-8?B?V0JrbFFmb3R2a2dGbVA4SitmQ0dXM2lSZDNGR21XNXJKUWJpSE1lTTJpVHRU?=
 =?utf-8?B?MkI2ODkrcmRvWVlBczMvTGNqSXpHN0xJVzNCOFluZ1BkK2R5MlIyVm15dDVu?=
 =?utf-8?B?ZUhtZWcvWk02SGFLbm11K0dkbjgyM3ZKRWpVKzJKQ1FxKzlNcFJKbTIrMG1o?=
 =?utf-8?B?c243Z1Bqd3ZwbHBaN2xGUXdkM2hKeWVnZEw4NktYaEUvTUNLUFpudkEvZ0hn?=
 =?utf-8?B?aERlQ3grVWtKb21rZ3Biak5zUS96STNnem92NVR1VEVwQXJMd3UvQ1pJa0hU?=
 =?utf-8?B?TzZZYjNHTUw4RXlWRk5xeEFPYlpMUEt1U3pLVUxvWG1GQXlmZ0ZUSU1IMzdp?=
 =?utf-8?B?SmNOd0JBaW0xcG1lY25tOUprNkNmTTlqSEtZWTZVS0R3M0x6UDRFRGNSUGky?=
 =?utf-8?B?d0xMVWNtZkdZa1RqS3FCQkdaaWhtam9BaC9JS2dLeHdNMytwZ2VrTlZCYlhF?=
 =?utf-8?B?K0JXSi93a3FUK01wckhZWk5hS2pjL1NBN1lzWFlhZ1hSYTdURUJtWS9Xb08z?=
 =?utf-8?B?WDdtcHVuT2toNCtzbERQUldDRmFkdUVFaWN4eXJmSTVnY1UxdU9xaUxwYlpQ?=
 =?utf-8?B?NStua2ZvcDEyMGFENFZNUzl4WWVScndUUmtNbW5SS1BOU2V4eVNSRFJmVTU4?=
 =?utf-8?B?cW9zYkRrQUlRVTNJTENhd1R4ODVLTXVRYU9oRlJmVm9UTDBoNkM4MWdQcWRv?=
 =?utf-8?B?VjhrSTlxNlhLeUFOZFNXS3FjRWYxU3BPZEJ2eldqTm93ekJiTm5LTVZ1WHNE?=
 =?utf-8?B?dEdFdnI2OWJqNFJENEFVQXdxR3dYeEd3RDUrZzNUanE3bWtIRzJ4Vk4yckV4?=
 =?utf-8?B?dllqeG9LSWxOTHAvYjVxakdhWnE4SE9CU2ZCcU1vRFVQcFhVQjVCaHBoZHJi?=
 =?utf-8?Q?pFA3t+fvcrMoNrrfkyXlhvqM850NdXhu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDh6WVk2MDhTZVVnYldyRHQ2TERVL05iZ3VhNHBTTUQ1LzFheFdKZGV4ZGV5?=
 =?utf-8?B?V3orNG5HKyt1U3dSK01OZ2xPajBGS1p2UThHbnNzS2V5NkJOZzB2VEpQMUc1?=
 =?utf-8?B?b0orTTJ3Q1R3Um1GMTh4VGdJeHJDVllLeWMvYzQxem5TZDc1M08yZ1hNWjZ1?=
 =?utf-8?B?WEtlMk9jdXl1ODRQR2tZeTBYTDh6OGNJNjdDaEU5TTRBWmF3eHVYcG5zVTJ0?=
 =?utf-8?B?N0FucVV6bUF6VFlIM1JuODBOQ29yV1pLa0tlcjk1VUMzQkViNVc2YlIzZzFq?=
 =?utf-8?B?MzF6Ry96Nk5ScWdZRmxWTUZsR3VDeW1qRm54d1pmWE1FK1doNHVaL1c4ZnM1?=
 =?utf-8?B?QzFNVWQ2OU43YU5BRUhxNUdoVWh1RUN1NGFoUFJSd2w5Mmw0bWVCN1lzdDla?=
 =?utf-8?B?OVJtRU92RlhwRVY4R0VKWWk1bFdtVjhWY3QwRzNnc3gyTWYya0VOSHc1Z0JH?=
 =?utf-8?B?d1lUaEdTTkNxSUNoc28vczJMUUNiK1g4dlpETURMemM0RGVIZnZJNDRGbGUx?=
 =?utf-8?B?ZDBuVVdqbzZzaEVVcTArQTFKNnhuRmZja2Y1aERyVHcveUVtbzE2MERWK2lL?=
 =?utf-8?B?YjNwa3cvWFNHMmhnY1VkRjJBKzl3SVhTYklEU2E2RFdRd3Nod0FVTi9WVndq?=
 =?utf-8?B?UXZnMWhPWGVFU1c0RTdrZkxadWZ1ZTJUZi9DMk5DYXQ2RU44NzMvclF5NVBC?=
 =?utf-8?B?RGkvcGZDalJXR25uTWtqZE5DTHRvRTRuM0EvaFA3NnRocEhHZzdsaFJQZTRx?=
 =?utf-8?B?Mys5cEhaUWVYR2Y1QkZROElxWDFsWnVNQk9NL3VxL0xnMit3VFc0b2dpbCtD?=
 =?utf-8?B?SEp4bVZpeVNNeU5FTkpxUUM5WjJlOWZBYTRValdJRFRQSjBUOHVPQ01XeUNE?=
 =?utf-8?B?QUJoU3dMUTF1blU2ajF6UE9HTXBMN0hPcHRiVzRvd2ZTNU9BNDZ3MXVKaUsz?=
 =?utf-8?B?blo5YjVoYWVZVE9hdlFlMXFmTmYxQS9YYlJnaDdaSVoyVVR2RzY2eExQSEUv?=
 =?utf-8?B?UzMvTVF4MmxPZmNlMVZLalNMbzBmWXhCV2Njd0p4UkszMW5KZkVFeFFzWFFq?=
 =?utf-8?B?TkI4OXMwZzlDUWZYdkVSSngxRVdrV3QwM0hTcitYQ1ArSW5maEp3N1pPNDYy?=
 =?utf-8?B?cm5DY1Y4QmNsNW93VFROVFpFVHdKS2FsRFJXNmxpOHNqTGRCNldENHpCS2J5?=
 =?utf-8?B?bHpkT3I5UXdqcVlmYnhSU2FIRmJDK3I0WjJKSzZsbnJhdElsTEdRaUxpcXJV?=
 =?utf-8?B?WE45MGYvWlN5S1NKY1d0VFhScnN6a3E1Wk4yVUs1NW1SSUdBMGFPNEVCc0dK?=
 =?utf-8?B?cTJ3WDdrT3ZSS0dNci9TTGFqd1ZMSlNBdmdwS3lscXhyc01FaFU0V3VqQmZj?=
 =?utf-8?B?RW84MFV4ZGhtdjV2dUM1QzdkUXU4Sm03VitjanhrNmtpUExrMUM1dCtURXhR?=
 =?utf-8?B?T04xUVRmcFBidWl6cjhsUEtLVjFuQzhkRjNDdEpXbkhwaDJxbnIxR1FaZjAw?=
 =?utf-8?B?MzJEZlhhcGNrd2hMYWJ6a01sbjM0QjJoQW1TNEV4RGxaU1FMVkl1QTBhbXFt?=
 =?utf-8?B?cmdVWVMyWGpraW13K1RvOU9GNUl2OENUUld6cU9ITnMyQ0ZNNnkvaGxGd1Fk?=
 =?utf-8?B?SHA1TmdHZk41d25lTWk5cXhBUmFaRXRoMHl1M1lNb1lIME5qTTF2VGVPeG0r?=
 =?utf-8?B?dit2SDE0Qlpqc0lHZi9DYnRSSHRTYVpOSlBXcjVva1ZSZ09aeTZ0azR5cGtC?=
 =?utf-8?B?RGR1WmZJTDZNV2s1SjViMXBFOHUxZGxPVVdYTnpqSHRDNHRDOWwrZk5walMr?=
 =?utf-8?B?MnlybXdFaGxKUGtibkNUdDlaM2tkRFFPWXFDSmRDMnlNQTBxRk1tUXg1NHI1?=
 =?utf-8?B?SmoxeW8zU2plQXpjdTN3b1dDOWNoazlzSDZZYXdmS0s2ZEZyMndNRXVSZTRV?=
 =?utf-8?B?MzZJaHpUSk9MN2U2NXVvL2R3MTdjRll0dTByczNSTDF6S3dOTllacWN5aTZx?=
 =?utf-8?B?OTZsaDd3c1ZWZklEaWpTejNYL29MNDJDeTlaWllxck82bmM3dWZLS3luaTZD?=
 =?utf-8?B?VmZvMjlTSHVpTzVEcytUZytwOVZva2YxTEROeDh6TmI0TG5vdVBjbjE1QTlM?=
 =?utf-8?B?dmEwWVFJTFROSCtHWFBOdjhJVWdyVStOWVBOaVJGQXJONHZzREhIdzBRMUFY?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vu5YnhJ623JVPWJ9KszVI2543TzjwhQjFD1PJRI1uyt7hI2Yk7Ubbm4G4RsV1rbWSafCj3g+2Q5v8YV0GHZQJ2QkP89US00Qxe+jbyhwV1wi91zPv7ihJ6h1axv8cuIXBJTz+S1nfx3ih8a6qSXHZP4n5WVRqh1i6DOK7k464g5pZZOkS9ZPnUniyeioBdTKvb4vE1dkoXycYxdMW95Olb8lBMS+/F8p8zmwH5IvEEgQAmwRJ4rnQJnYmaLJeuvHdPM/iGX9kZOVFFNPyLajpSSrJL4sqHp0WwUoZfgltqseBr/h/GfFN/RNioxd08iIEqOl6H82MdtZi6rCulo0aETUl9AUUp/8k6pToh/RKIqTB/XvnYsp3cr4EUU6/L4+nsh8TC4qyECrkR+agQu15PGIMwmnXHdlF5Nq1866qYyIqTnAsBXwuqcJuQmux0UGxhEA1T3HxAYiVouGtojaYRwXlmiff7PKmnVBPjbz6y/MC2idCE6RDFS40Roj9XuGZ8qi0Q28lTkhMdlaryKoVNdZE3GUq29ycgOl9MpMNSA3rS6x2FHnuo76acuCBbyhj13y1xoRYFKS8/grVtaD2YqbarDoPtzEdDDH406AHS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40045619-7555-4253-3234-08de2882bd7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:18:32.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiEFl91RjPDe5NrF2bgM9KJ1qU5T6b13xvvZ0psHriqIcSmUE23MQLF7O5nitNEVk2wlDVC3wyiTh6k2bg1rXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200157
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691f93bf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QV9UqLgA4Q9WNwrmhG0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13642
X-Proofpoint-ORIG-GUID: ojXQKqwcXU7WvW4rfkCRLqJy9CAHPW2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX29JQXiEATcxN
 QGs+orHfeq8Y3m/fHtTvRfQWP+hwIreCx3FF059i2B5Bck8ikvo7iCYIPiw+jwnW3V7II4pUqHi
 JoNpPpITMdE+vAT8RKtzqcUCuf0uXSaLSUfYewqoFjbcSOjSbr2DNuWpeZXMVJbvEW6RbYo3Zey
 S7EOqzMvSFeqDip2U2X2RwKfkWPLf6Xu/P+VaeCjhS8r/UxZgaSbT7ROUt7kOlOEqgJcVL9T8Hu
 XLEWqFKl/k07AQivD4PCtfX6ZDfQNqdPKEuCw9fGJluFJEV3bRyimjWOPzyFnCIV7WTdyBTiudu
 76kmUWFTSKo04c04+IJVVnSHOWzRzOiyzl6CF84fN+dSZqVeGa+YxcUZY2iTK3OQHjt3+HRosiP
 Rxgv4G3vndVcZV8ho8RA8BiPkoGimx2985khIjpAFRJezOl6KZk=
X-Proofpoint-GUID: ojXQKqwcXU7WvW4rfkCRLqJy9CAHPW2A

On 20/11/2025 18:05, Potnuri Bharat Teja wrote:
> On Thursday, November 11/20/25, 2025 at 23:23:39 +0530, Alan Maguire wrote:
>> On 20/11/2025 14:20, Alan Maguire wrote:
>>> On 18/11/2025 16:47, Bart Van Assche wrote:
>>>> On 11/18/25 4:07 AM, Alan Maguire wrote:
>>>>> hi Bart, thanks for the report! Not a know issue to me at least; I tried
>>>>> to reproduce it with pahole v1.31 + gcc 12 and no luck. Would you mind
>>>>> sharing a few additional details:
>>>>>
>>>>> - compiler version
>>>>> - pahole version
>>>>> - full .config
>>>>
>>>> Hi Alan,
>>>>
>>>> My answers to your questions are as follows:
>>>> * Compiler version: gcc version 14.2.0 (Debian 14.2.0-19+build5)
>>>> * pahole version: v1.30
>>>> * Kernel config: has been attached to this email.
>>>>
>>>
>>> thanks Bart! I've reproduced this now with gcc-14.2.1 + pahole 1.30 and
>>> it is also observed with latest pahole 1.31. Investigating now, but if
>>> you want to work around it in the short term, disabling CONFIG_WERROR
>>> should allow resolve_btfids to proceed even where duplicate types are
>>> present. Hopefully we will have a root cause/fix shortly though. Thanks
>>> again for the report!
>>>
>>
>> [adding cxgb4 maintainer, for reasons that will become clearer below.
>> Context here is that Bart is seeing kernel builds fail at the
>> resolve_btfids stage; resolve_btfids is finding the BPF Type Format
>> representation of core kernel data structures has duplicate entries for
>> key kernel data structures like task_struct]
> 
>>
>> After adding some debug-only messaging to btf__dedup() in libbpf (which
>> I will send as a patch as it makes debugging these situations much
>> easier) I saw:
>>
>> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but
>> differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0
>>
>> Examining sched_class we see:
>>
>> [107] STRUCT 'task_struct' size=2560 vlen=194
>> 	...
>>         'sched_class' type_id=480 bits_offset=5440
>> 	...
>>
>> [479] CONST '(anon)' type_id=8624
>> [480] PTR '(anon)' type_id=479
>>
>> [8624] STRUCT 'sched_class' size=216 vlen=27
>>         'enqueue_task' type_id=8844 bits_offset=0
>>         'dequeue_task' type_id=8846 bits_offset=64
>>         'yield_task' type_id=8823 bits_offset=128
>>         'yield_to_task' type_id=8848 bits_offset=192
>>         'wakeup_preempt' type_id=8844 bits_offset=256
>>         'balance' type_id=8851 bits_offset=320
>>         'pick_task' type_id=8853 bits_offset=384
>>         'pick_next_task' type_id=8855 bits_offset=448
>>         'put_prev_task' type_id=8857 bits_offset=512
>>         'set_next_task' type_id=8859 bits_offset=576
>>         'select_task_rq' type_id=8861 bits_offset=640
>>         'migrate_task_rq' type_id=8863 bits_offset=704
>>         'task_woken' type_id=8865 bits_offset=768
>>         'set_cpus_allowed' type_id=8868 bits_offset=832
>>         'rq_online' type_id=8823 bits_offset=896
>>         'rq_offline' type_id=8823 bits_offset=960
>>         'find_lock_rq' type_id=8870 bits_offset=1024
>>         'task_tick' type_id=8844 bits_offset=1088
>>         'task_fork' type_id=236 bits_offset=1152
>>         'task_dead' type_id=236 bits_offset=1216
>>         'switching_to' type_id=8865 bits_offset=1280
>>         'switched_from' type_id=8865 bits_offset=1344
>>         'switched_to' type_id=8865 bits_offset=1408
>>         'reweight_task' type_id=8873 bits_offset=1472
>>         'prio_changed' type_id=8844 bits_offset=1536
>>         'get_rr_interval' type_id=8875 bits_offset=1600
>>         'update_curr' type_id=8823 bits_offset=1664
>>
>>
>> Now looking at the first duplicate:
>>
>> [36354] STRUCT 'task_struct' size=2560 vlen=194
>> 	...
>>         'sched_class' type_id=36389 bits_offset=5440
>> 	...
>>
>>
>> [36387] STRUCT 'sched_class' size=64 vlen=6
>>         'state' type_id=28 bits_offset=0
>>         'idx' type_id=28 bits_offset=8
>>         'info' type_id=38195 bits_offset=32
>>         'bind_type' type_id=38228 bits_offset=256
>>         'entry_list' type_id=90 bits_offset=320
>>         'refcnt' type_id=84 bits_offset=448
>> [36388] CONST '(anon)' type_id=36387
>> [36389] PTR '(anon)' type_id=36388
>>
>>
>> sched_class looks totally different! The reason is cxgb4 declares its
>> own sched_class while also #include'ing task_struct-related headers.
>> Bart's config exposed this because he had CONFIG_CHELSIO_T4=y (I had 'm'
>> in my config).
>>
>> If we look at drivers/net/ethernet/chelsio/cxgb4/sched.h we indeed see:
>>
>> struct sched_class {
>>         u8 state;
>>         u8 idx;
>>         struct ch_sched_params info;
>>         enum sched_bind_type bind_type;
>>         struct list_head entry_list;
>>         atomic_t refcnt;
>> };
>>
>> ..and cxgb4_main.c has #include <linux/sched.h> and #include <sched.h>
>> with the clashing sched_class. Using pahole we can establish that the
>> BTF encoding is simply reflecting the DWARF representation ("pahole
>> cxgb4.ko" shows this), so BTF is effectively correctly reflecting the
>> underlying DWARF representation. This will make life confusing for
>> debuggers too.
>>
>> So although it is a bit of a pain, I would suggest the simplest approach
>> is to perhaps look at renaming sched_class to be a bit more
>> domain-specific - ch_sched_class perhaps? That way it will not clash
>> with task_struct's sched_class.
>>
>> I can send a patch but it would be great to get cxgb4 maintainers' take
>> here first.
> Thanks for adding me and the detailed debug, Alan and Bart.
> I will try this and let you know.

FYI I verified that changing sched_class to ch_sched_class like the
following resolves the build issue:

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 392723ef14e5..ac0c7fe5743b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3485,7 +3485,7 @@ static int cxgb_set_tx_maxrate(struct net_device
*dev, int index, u32 rate)
        struct adapter *adap = pi->adapter;
        struct ch_sched_queue qe = { 0 };
        struct ch_sched_params p = { 0 };
-       struct sched_class *e;
+       struct ch_sched_class *e;
        u32 req_rate;
        int err = 0;

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
index 1672d3afe5be..f8dcf0b4abcd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
@@ -56,7 +56,7 @@ static int cxgb4_matchall_egress_validate(struct
net_device *dev,
        struct port_info *pi = netdev2pinfo(dev);
        struct flow_action_entry *entry;
        struct ch_sched_queue qe;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        u64 max_link_rate;
        u32 i, speed;
        int ret;
@@ -180,7 +180,7 @@ static int cxgb4_matchall_alloc_tc(struct net_device
*dev,
        struct port_info *pi = netdev2pinfo(dev);
        struct adapter *adap = netdev2adap(dev);
        struct flow_action_entry *entry;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int ret;
        u32 i;

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
index 338b04f339b3..a2dcd2e24263 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
@@ -330,7 +330,7 @@ static int cxgb4_mqprio_alloc_tc(struct net_device *dev,
        struct cxgb4_tc_port_mqprio *tc_port_mqprio;
        struct port_info *pi = netdev2pinfo(dev);
        struct adapter *adap = netdev2adap(dev);
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int ret;
        u8 i;

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.c
b/drivers/net/ethernet/chelsio/cxgb4/sched.c
index a1b14468d1ff..e15554b347c0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.c
@@ -44,7 +44,7 @@ static int t4_sched_class_fw_cmd(struct port_info *pi,
 {
        struct adapter *adap = pi->adapter;
        struct sched_table *s = pi->sched_tbl;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int err = 0;

        e = &s->tab[p->u.params.class];
@@ -122,7 +122,7 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
                                   const u32 val)
 {
        struct sched_table *s = pi->sched_tbl;
-       struct sched_class *e, *end;
+       struct ch_sched_class *e, *end;
        void *found = NULL;

        /* Look for an entry with matching @val */
@@ -166,7 +166,7 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
        return found;
 }

-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
                                             struct ch_sched_queue *p)
 {
        struct port_info *pi = netdev2pinfo(dev);
@@ -187,7 +187,7 @@ static int t4_sched_queue_unbind(struct port_info
*pi, struct ch_sched_queue *p)
        struct sched_queue_entry *qe = NULL;
        struct adapter *adap = pi->adapter;
        struct sge_eth_txq *txq;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int err = 0;

        if (p->queue < 0 || p->queue >= pi->nqsets)
@@ -218,7 +218,7 @@ static int t4_sched_queue_bind(struct port_info *pi,
struct ch_sched_queue *p)
        struct sched_queue_entry *qe = NULL;
        struct adapter *adap = pi->adapter;
        struct sge_eth_txq *txq;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        unsigned int qid;
        int err = 0;

@@ -260,7 +260,7 @@ static int t4_sched_flowc_unbind(struct port_info
*pi, struct ch_sched_flowc *p)
 {
        struct sched_flowc_entry *fe = NULL;
        struct adapter *adap = pi->adapter;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int err = 0;

        if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -288,7 +288,7 @@ static int t4_sched_flowc_bind(struct port_info *pi,
struct ch_sched_flowc *p)
        struct sched_table *s = pi->sched_tbl;
        struct sched_flowc_entry *fe = NULL;
        struct adapter *adap = pi->adapter;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        int err = 0;

        if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -322,7 +322,7 @@ static int t4_sched_flowc_bind(struct port_info *pi,
struct ch_sched_flowc *p)
 }

 static void t4_sched_class_unbind_all(struct port_info *pi,
-                                     struct sched_class *e,
+                                     struct ch_sched_class *e,
                                      enum sched_bind_type type)
 {
        if (!e)
@@ -476,12 +476,12 @@ int cxgb4_sched_class_unbind(struct net_device
*dev, void *arg,
 }

 /* If @p is NULL, fetch any available unused class */
-static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
+static struct ch_sched_class *t4_sched_class_lookup(struct port_info *pi,
                                                const struct
ch_sched_params *p)
 {
        struct sched_table *s = pi->sched_tbl;
-       struct sched_class *found = NULL;
-       struct sched_class *e, *end;
+       struct ch_sched_class *found = NULL;
+       struct ch_sched_class *e, *end;

        if (!p) {
                /* Get any available unused class */
@@ -522,10 +522,10 @@ static struct sched_class
*t4_sched_class_lookup(struct port_info *pi,
        return found;
 }

-static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
+static struct ch_sched_class *t4_sched_class_alloc(struct port_info *pi,
                                                struct ch_sched_params *p)
 {
-       struct sched_class *e = NULL;
+       struct ch_sched_class *e = NULL;
        u8 class_id;
        int err;

@@ -579,8 +579,8 @@ static struct sched_class
*t4_sched_class_alloc(struct port_info *pi,
  * scheduling class with matching @p is found, then the matching class is
  * returned.
  */
-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
-                                           struct ch_sched_params *p)
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+                                              struct ch_sched_params *p)
 {
        struct port_info *pi = netdev2pinfo(dev);
        u8 class_id;
@@ -607,7 +607,7 @@ void cxgb4_sched_class_free(struct net_device *dev,
u8 classid)
        struct port_info *pi = netdev2pinfo(dev);
        struct sched_table *s = pi->sched_tbl;
        struct ch_sched_params p;
-       struct sched_class *e;
+       struct ch_sched_class *e;
        u32 speed;
        int ret;

@@ -640,7 +640,7 @@ void cxgb4_sched_class_free(struct net_device *dev,
u8 classid)
        }
 }

-static void t4_sched_class_free(struct net_device *dev, struct
sched_class *e)
+static void t4_sched_class_free(struct net_device *dev, struct
ch_sched_class *e)
 {
        struct port_info *pi = netdev2pinfo(dev);

@@ -660,7 +660,7 @@ struct sched_table *t4_init_sched(unsigned int
sched_size)
        s->sched_size = sched_size;

        for (i = 0; i < s->sched_size; i++) {
-               memset(&s->tab[i], 0, sizeof(struct sched_class));
+               memset(&s->tab[i], 0, sizeof(struct ch_sched_class));
                s->tab[i].idx = i;
                s->tab[i].state = SCHED_STATE_UNUSED;
                INIT_LIST_HEAD(&s->tab[i].entry_list);
@@ -682,7 +682,7 @@ void t4_cleanup_sched(struct adapter *adap)
                        continue;

                for (i = 0; i < s->sched_size; i++) {
-                       struct sched_class *e;
+                       struct ch_sched_class *e;

                        e = &s->tab[i];
                        if (e->state == SCHED_STATE_ACTIVE)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h
b/drivers/net/ethernet/chelsio/cxgb4/sched.h
index 6b3c778815f0..94d45de793ef 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
@@ -71,7 +71,7 @@ struct sched_flowc_entry {
        struct ch_sched_flowc param;
 };

-struct sched_class {
+struct ch_sched_class {
        u8 state;
        u8 idx;
        struct ch_sched_params info;
@@ -82,7 +82,7 @@ struct sched_class {

 struct sched_table {      /* per port scheduling table */
        u8 sched_size;
-       struct sched_class tab[] __counted_by(sched_size);
+       struct ch_sched_class tab[] __counted_by(sched_size);
 };

 static inline bool can_sched(struct net_device *dev)
@@ -103,14 +103,14 @@ static inline bool valid_class_id(struct
net_device *dev, u8 class_id)
        return true;
 }

-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
                                             struct ch_sched_queue *p);
 int cxgb4_sched_class_bind(struct net_device *dev, void *arg,
                           enum sched_bind_type type);
 int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
                             enum sched_bind_type type);

-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
                                            struct ch_sched_params *p);
 void cxgb4_sched_class_free(struct net_device *dev, u8 classid);


