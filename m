Return-Path: <bpf+bounces-67100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB4B3E1DC
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 13:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EAA3A3AD2
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2332038B;
	Mon,  1 Sep 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mz1WJoqT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zFUgyGeQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6931E0FE;
	Mon,  1 Sep 2025 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726828; cv=fail; b=cUZYmDuoTWyyCrSso9KyyYOLp/cR0vMpWw9467pbPbyQ76RMDhcpxh1XvkebT1qh5FtXxduKCJ/QQethmM3hYQNv8Oz7It9DEqssCihp3Ne0U1jZf8J2VL00npGXRM7tMaIiDOVNUA1fMAPYp4/07dk2PIkWhqlhvPELjsXVQ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726828; c=relaxed/simple;
	bh=uUsc611zMeKl/CNbgWeh3FRMhjlL7+j3PAwHcuWx9Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cL5PSw8R3bNaBr8IGm5ijNWJoyfH4K7CTCdyU4raxxRBp4bFKZ67cIoPe+4RfNDT8dIwQE7U02siM1OVhM7OK0c0G8k0RhgivTzNtRE33CQFhqwvA4+5yg4KGHAwMmY60OvGkf7p7IakwZBvX+HfMltel6kY4yJGLVeKJL8jKPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mz1WJoqT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zFUgyGeQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fmhM018243;
	Mon, 1 Sep 2025 11:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pO10m4b2WjNU+V8Wf4+rfZKEXWJ9LMUBrcowqbH67j4=; b=
	Mz1WJoqT3l1t+bqWgb6Buh8Nxrk2gQ0K/ioN4x9+6F6FzuxCl24vjSBckC39PopL
	FDlCbvswoxCipb9CRbrRM4D8dWwrs12t9ebILAD6i+tK0KNirX0kC7nzjEQVGOZN
	wpQPOcUo7TxNXsy65I1xrMdxG7wAnjn+ecPd4Q0Dn8hoJ16ordfQP8EzN/zIXs0l
	8EfX/8o7TkWXmBcBeoT7cd/dKphZ0U66ufgj9KnpyYZxAuNzxAwu/3nJhgBSja2N
	gwp7B2ebs1U3oGGZcrLlmYJ/ClNDAVRJYVa58jTTD1VcMSp/ZO6ZlyN/42HZ7baD
	AQFP/RDTalCm2ChL9ptDVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9jb2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:39:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819mfXR004131;
	Mon, 1 Sep 2025 11:39:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr81whc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDh0rmhetwSds0MBXa31qK9wkGk7E07T2kJafc6g7whtHzDqfBtIhjvvuwlp8ACdij+dJjoNj94R1SAGTqiXKXeTUwbHnH8OKk17foKFnl751IovkcpzX5NAWM6rVVD9HHm8bgFIqPFt+mU24zQIsq+xvdi81+0MYoPT+3Ii+cZGRHbM9qZoWCbh+4SWpHYKavmYe2VkDEvtu0dGXZgLuoBo7rLRjumCtEvS3l5a+cIThmvx7v1hLiHxosfwoLtwzuPE+dcj0vMk3GzxHsY5HYIiCRXAeg/d5r8SFoAUfg2xnC6A2Wc0HFfa2KwyOYeirQvU1lApXHpY8HM83elhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO10m4b2WjNU+V8Wf4+rfZKEXWJ9LMUBrcowqbH67j4=;
 b=enif/tUHREtGjAAH+BhJ0sCtVzxc01STfAbRNBm8n3g/aAr0hVOFUJTjDUf5LCTiB2H/ztDDDTDyh7cDkOhAGo4tgaYCtqzPDEF4dzXqBdlHHpb8GvOKEZxJc9VQTD5DJoRIi0GeP7zxo/QbB9pukzwr0AhdCTRe7+ZdKvxOqMCJX6L5xFss6LIYlhAbjA1uBsafJ54SQMMgfRCl4g2YpsAvVFlVwPRuiJb25q/vfHQbXBYJua0ttWkssZGSlm3uAvMBCRoEh3SIwcr+VGxa5j2By+6NdldMjbxnLQt8iMjAwNtFFmeHhEc87Y1LszdRCHpWrSzp0+nIZAfaqYegcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO10m4b2WjNU+V8Wf4+rfZKEXWJ9LMUBrcowqbH67j4=;
 b=zFUgyGeQ1BrNwhWoE+al/T+wMK1q1L0JLSSQ6amWthdvqgKhVsRKzzsDjQAvmjml9wF3ZbH34lbFcGPQtH0GHRvE3eCMWm/Dd04A4UU+LVS1VJeUs0xVap+WFNgISSXGenTR7Mgx/JehhaIt1DEZubW7CQsTJrjp91SVwndY/EM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 11:39:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 11:39:38 +0000
Date: Mon, 1 Sep 2025 12:39:35 +0100
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
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <73ca819c-9a2b-4f12-853d-557a4e7399e9@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
 <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
 <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
 <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local>
 <CALOAHbBRQf=QLqYgA9E8m6AKGmZxY6rFZsoXwTYCaiSqpTb=JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBRQf=QLqYgA9E8m6AKGmZxY6rFZsoXwTYCaiSqpTb=JQ@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: c05d00a0-2d66-4667-0af5-08dde94c3b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1STEZ3M2pDekJoaWNBTGZLRzcxNS9JMlhKZjJ4V2xvKzh3RkZpbWxJbTZ3?=
 =?utf-8?B?ZUwvajNyZWt4N1UycmM0VjJrakFoYWxqWXpjN012b24vMUFtenFWbW5nNGxx?=
 =?utf-8?B?SEtEOUFsdllEL1VSRGx1cjZ3d2NuY1lrMkhPT29ENHV5dnQ0TzR3d1BGUThu?=
 =?utf-8?B?MlpJRDdUWnAvSEQxVWdvdmh4cUNLWVQzTVR1RDB4UVNVb2FvUFRuajBIbWhB?=
 =?utf-8?B?aDZnL0FmcEZrdXhiR2lUM0lPQ3kzUy9rN1FVd0NnN3hSNnhKVlRWYVEvSjZ1?=
 =?utf-8?B?KzZ5VTdQeXhFMjRPVm5kK205S3ZRUmNrVHI4RktxVXRReE5aMFl1ejN2UlVW?=
 =?utf-8?B?Q21Md3dwaUhKaHdyNktBTU5nYWluSTRLNjN1QTBZby9ScXlGSUN4Vmc2bHNX?=
 =?utf-8?B?Nkp5VkQxMjFMRXJ4MzJRUmZ2a1MwNzR1aWVsb1hXczVnc1dPZFlJUHJMMTNj?=
 =?utf-8?B?OHM1cEpTcGl3cFJtNng1VVlKZjZWb3Yrd1JVdE52TmNod2dEN0w0bUhKU0dt?=
 =?utf-8?B?ODZ2cjIxZXpFSlc2UDNQYzBBeE1xSlNacGxQeHNpSTEzTlJ0ODk2dHRwVmdV?=
 =?utf-8?B?OTBSTElxSktEZDNtWFFkdUJOZGs5bnZrZlJ0cG5tZU80Y1JROTk4aldWSFlS?=
 =?utf-8?B?Ti9WUHAyc1FHNGk1TU13dytoZmtvZ0tjbDZpVUNDS0dNNXVOVGx3NVZMd0VX?=
 =?utf-8?B?Z3pEWEt5eUJGZitKNnhHa0I0L2k1V1k2ZmswclVrVno2SWRHdURVOGgwQUVR?=
 =?utf-8?B?YnhvcWdCL2VmL21jV05xa2lQNjgvOGFieUE1S3JEZGpDcFR4azBvSHVLaDJj?=
 =?utf-8?B?bEU4OWF4NjB2YVdVdWlVVkxKRThZWHM3QTB1dzJ4QnVTcEtJU3U0L0JrQ2dx?=
 =?utf-8?B?Zmo2dHQ2UzdIWWNqbU9RcnBQczdIWkFRMklTR1g3cTJYcGY5WENWY2hObmZh?=
 =?utf-8?B?UmFVc25ZSnpBSHJkcGw2UDZRZmpuM2QyQmxlL2JPa3Fmc3JtaHg3WWhkTGNZ?=
 =?utf-8?B?aXJMQnRDQ3U2UWgvY3grQWVaYjRlYlVydk1CUG1XYndtNDFUMGV0ZEthRVRr?=
 =?utf-8?B?Vk5LNk9NWGtobHBqRVk2QWNWYmo0ZU5hdHZGcmN4dEgvdCtpME9PZ2ZBT205?=
 =?utf-8?B?NnBIQXd1dkVoNk00dFV4ckFHSGtIelkwYXU3YXNCOUxNblVqZG9Zb3JQVm9m?=
 =?utf-8?B?M3ZNV2dKbUo4LzRmOFhQdXBIQ0dUb0E0ZlNPdUw2ZzY2WEVueXdrZ2MzODg3?=
 =?utf-8?B?MU5ZV0N2cWtJN01yQmdLdEZQa042NVAyNlBSMkZjRmcyWTcwTWs0ZEJhQmh6?=
 =?utf-8?B?MDZnZ0R2eGhaaHpYNUpRM2pOQ0Y4ZkM2RHNBa2hmS1k2enNRWUw4alZmbHZO?=
 =?utf-8?B?TElHS25pODJVU3Fxb2VVUGRKL05vUTBBdnU3VTQ1K1VDcG1FaDN2bEhSY08v?=
 =?utf-8?B?dHh6ODdpSk5VSU5ORTh1dWZiMTI5aGVVSEQ2aHRMQW5qdFkwL2xwekZpd1Zs?=
 =?utf-8?B?RUNhT0t6NTBBT0VXZFUrY3k4U2ZZSUlxWjhDRU5TMU9ObTZtQU1Xek9adUIy?=
 =?utf-8?B?WGpaU2ZxenR5RlJqRGVMZnJPeVo4VDJkVFpDc1kvbjJRTklSTWRSWFJOWHp5?=
 =?utf-8?B?amFkaXFmME00RXdweGErWlBXVVZ1UHNOdVZxSzd5SmNOSmVxT2lLaXYyazdD?=
 =?utf-8?B?VElrN3oydC9xTHRmWld6Mm1yRlpwTExUbUtrRjRWa2JqUDg0UVpWNDVRVlJa?=
 =?utf-8?B?RXYzbXBtQVlhSzNQdXFEbXhLbzVIRVV0SVhIMWRxYjNlVEY4Mm52d1R5Y2N2?=
 =?utf-8?B?MUpPVldEUnZOb3RJWU9ldmNwQ0N5Zlc3b1E0VUMvNFg2dlZnaFNmM3E1cXNx?=
 =?utf-8?B?aXAxQ2xKYjc1eDJzUHIrOWdKQjRMckd4ZkwvYUk1bjhPN2pCKzh6YWpGYjdU?=
 =?utf-8?Q?dgMicrhiGtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHU2SkxhdUVhRnZKQU9LdTFMekh5ekpwb0FtY05YaEpHdGY4UFkyTU1CeE5J?=
 =?utf-8?B?SHo3MkI4TEZpYWZvOXBiTGd4bTY5M2wxZDZrQmJiU3c1azBsWklQYTgvd3lk?=
 =?utf-8?B?cjBmblhnLzhkL2JnQ2tZY2xSeHFTZEdpSjZZM0xZb01UVzZHbGdubE9jeWw5?=
 =?utf-8?B?dkNZZDVtV0VhdzJvZlpMektGLzBJeG1GUUErSUROMDNZZ1Z0a3dWakdpdnJQ?=
 =?utf-8?B?dUxXbmxMeW12dU5pS2V4SGRiRDFUWmlaUmpuaS8rUCtOd1NJbmc1WGZzemhn?=
 =?utf-8?B?UEhuckdFbEdwVnRxZjEwcmNsMG40YUxhbWZJekc5d1FVL0plcCswOVlndyto?=
 =?utf-8?B?QmV2bnM0OGpWaTB2TFl0NWhibWJKVUJpeGE1MlRYTWwrZDdOY0VNMlgvNmtC?=
 =?utf-8?B?RTZRcmpERXdIMDdyZ1lZSWg0NFRUdUx1SDhBT01wWHJIZm4zSEZFYU9PenR4?=
 =?utf-8?B?WGd6NnNXY2d2T0IvbDliejE3ekdyODlRcE5ZZldxQXYvaWRPVkk0QU93QzJE?=
 =?utf-8?B?UlB2czlOYVJnbHNNdTJ3TFlqdmFpaUJXU3Y3SlRwMFFCVFN2Y1NzWFpOa1VC?=
 =?utf-8?B?eU5Ga3BGbXR3YWJXbUMyMVRaNzZXUEVEbldCMlk5Sm9vU1NLZzdmdWlIZjNB?=
 =?utf-8?B?dzRpRnhqNkNtK0syWWZGT255ZDZqWHBLR09qZS95a1ZaRjkvK2xQS3FjL25K?=
 =?utf-8?B?NHBLOGN4c2YrMjNrOUI2aDNzN0ZmNzhJSWI1ZTFPMzRhU01JVXg4VlZxeXlZ?=
 =?utf-8?B?MDhEeEY5U1p0OTlkdDFxMlAzQnVMQklOQzY3QUVlRDhBL3JETncxcTdRemFx?=
 =?utf-8?B?Nkw5bDNNcFJtc0tJcmlXTElITHBYY0Rud0lsNEZSMEdjMHpmUjk5WEgvYUdJ?=
 =?utf-8?B?a2tYVythU1V4UXkxcTZMRnhOU3ovL3NHelpEL3V0U1pEWFN5ZVVjM21JdlFv?=
 =?utf-8?B?NFExa3hDS2gyeFJiWDU3SXlLQzZ1YXdVQWhhNnJXR2trV1dld2FFWXM0eHVU?=
 =?utf-8?B?SEVyVVBwT0Y5cGF4L3FPSWNDRXN3V0hLQmhneklqMHVQaGN1N25qb3lsNG5i?=
 =?utf-8?B?YVNQNysralljQmFxRUJIcUtIVmNkY0lkK1BacVVOYmFpd2xJR3A5N3JWZjZz?=
 =?utf-8?B?WVJOaTFBRTdVVUI0WEV0MVZYZjZDMUx2VE1pZzlzQTJCL0d5aldTY2FWYU1E?=
 =?utf-8?B?V2NiUjV6Rk56bVA3d1RnNGNSa1VvTVkxeWlBVnFmTURPYnZoUS9CbTVvdWhT?=
 =?utf-8?B?bStCeno1WWVPVDJMNDQzbElheWI4dkt5SXNBRjJnMnNabFh2SEh1V0xSVkF0?=
 =?utf-8?B?M0EzeXpMOWQzVWpkRnpMRkxBd3RuOUF2ekQzaVVtb1o4dXhRSlhCblVtelE2?=
 =?utf-8?B?ajd0aFgyd1A1K0Erb2ZCU0pLdnZ6SjFMTGk1OWx3K3ExU0Q0NkdKWHBreHVM?=
 =?utf-8?B?OXlSWUtLaVVLV3NZdFM0dkR4bDRYRVFaNGFlY1NMN2tqdVAwVW9JYm9KRmxT?=
 =?utf-8?B?b3BVUHlEbGJGOTJTVVV6V2hjWmVNS1NxYnl1UTN2T3NPR1RMdTEycnhPL0xo?=
 =?utf-8?B?ekdoUFEwN1czL1RXbGlaQ3VGVW9sRmhCbzZYSUpRdGRPNkJnSDdTcnR2Z2NT?=
 =?utf-8?B?OStIRnJSYTRodllueWwzVW1TUGRSU3NmOHg1NThVcGJHaktkSERjeklCYkxi?=
 =?utf-8?B?cnFjMnVicUh6aDZkK2xEZFRsTnJBY1JUdGpPTTBIVk1FWlpFZ3VTR3JLNHlO?=
 =?utf-8?B?SDkzT1hsUWtGeU8waCtIYXVhNUNSR3RFWmhsMXk5ZkNyRFJvdXA3Tk1RNndV?=
 =?utf-8?B?TTVESkZiVEVuV0JSNXdXM2ZMNEk0MnZEZUxOZHFKb2JVaTlIZm5ESWJydTIz?=
 =?utf-8?B?eHNlTTNFVGtrK1hHR3BoMHZoS1pxOHNjc1hkaklOM2dVcThPaTFkS0I5ZU9N?=
 =?utf-8?B?STZNRzkxdC9oTUhuUG5GNnBoTG1YamI3V1BMbHJ3ZEptYWNRNkt4Mjl6azdq?=
 =?utf-8?B?S3E2VzBreTFUV2NxRXlpeTh6cVhSeFcxandTM0JlV2pwdUJZMnNBbS9HZ1hs?=
 =?utf-8?B?YzY4d3dPTEczbDFqVWN3clV2T2hZK1NUMXk0Vjh6M0lKdm5QcU9XWHJMbGxK?=
 =?utf-8?B?NTJjK0dvbDVES252QWRWRS9pWFlPTUx2SXZxREpHMU1zMlNvQkZSeDRCMmp5?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J5hJr004Tyi+Fd5/hbiEY+My73+v30slkFDoAe6EEjBtoyrvL4qQ/rzxsJuvIQehlmd0WwmQx6kbk0ro1gmtDrCCnXLZsexccJ+qn1wajmzIACv+v3lP7NpMKJ1QJ89BgpzOSTGZYX4WZRQK0TZcdH4Yfw3HqMtLk+uKiNmEQR8eoiJrwyF5MtnC/nEhudMTxY+OTDrUWXwT6vIocrGxJfuORr4ENqBJ0goz2jFH+keqJnUt3kHTfOmPS099CKuK+6qr++grvjG1jgA1J7KKF/yWW9QtiTmivI+DO3BQnthpWU0PeJxvddfTsxfZfPelIGMwzAAZlZLKwAZMf9EIGUr7sJl70kZxAaula2gdoCjymzeaHx3yj9Hr+ZpkWGuppGf2OpVXdfg3JpEK4XM2WZnEO4DXTYBstivD86Qa4Ge27yK7ZghiIyfKnNovDjirInTt9sw2HHIsaezCsd0WDeNZIxavGFaHjHFSbHxlBZ6CeMLWBe2rkkwDX+iUB0luR6YLk/SE2zKYykIbEhx5nHevm1TUIAPxVbhi3sUCXhMsX9H6YpV/U5QIZhqjMWbzAaw0QPYqf9pCdUUh+1dB1Hqt29J8Yit9JjYh41ihH6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05d00a0-2d66-4667-0af5-08dde94c3b9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:39:38.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNrhP7W1iz8J5WETB2dNssAKxAyCJmFovd+rBhvzeAaJZzcoJn7X3L6+QIhZwf9wABT+F7xu+CDVq3oVgkv6Rz1/gCe0Aztki8gIWB+MN1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010124
X-Proofpoint-GUID: OOkAgiLEriFb9HwiGc_Xqy92JUqYHomu
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b585fe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gZmX6lM_sLUD9SpUINcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=MFLWxieuL2uzg9c1HGcs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX3ZKTE67ieVfq
 08Ojrf3bpFPSGRlPykBCjYtjN3UsE24Y9U9kCbs97QJPSRXnrKh99UDRlEcWhR0zzckw3iA3U0i
 LhdRCprobGRPGdgLVkJ4QZWpI/OuzEk8+ZMKFllBVrrE4DzukWVZQ0Xbn4AGw3PsDmQxboX1rDK
 HfUmxwu414hk4SgcWVo1Y6QHm3RR8ymtqTHDyueFdczv82S7Fsan8Praws7t9Pfzm8H1GuvbQWW
 YV5VwhSgrFC0tkCApvCeSgj6MJgMNVh5ofdO6bpeTb9OkDLexTc176TNELAAUQlT6qepBZ1UU1A
 fxHF0RjSqtE+o58g8+QFzOBOnEi7F+cFatmM6F29TwkKv5OPJXibzG10Cv6VRDfZsLWVGIfO3jY
 9xAbt7Hd
X-Proofpoint-ORIG-GUID: OOkAgiLEriFb9HwiGc_Xqy92JUqYHomu

On Sun, Aug 31, 2025 at 11:11:34AM +0800, Yafang Shao wrote:
> On Fri, Aug 29, 2025 at 6:42 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Aug 29, 2025 at 11:01:59AM +0800, Yafang Shao wrote:
> > > On Thu, Aug 28, 2025 at 6:50 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> > > > > > Also will mm ever != vma->vm_mm?
> > > > >
> > > > > No it can't. It can be guaranteed by the caller.
> > > >
> > > > In this case we don't need to pass mm separately then right?
> > >
> > > Right, we need to pass either @mm or @vma. However, there are cases
> > > where vma information is not available at certain call sites, such as
> > > in khugepaged. In those cases, we need to pass @mm instead.
> >
> > Yeah... this is weird to me though, are you checking in _general_ what
> > khugepaged should use, or otherwise surely it's per-VMA?
> >
> > Otherwise this bpf hook seems ill-suited for that, and we should have a
> > separate one for khugepaged surely?
> >
> > I also hate that we're passing mm _just because of this one edge case_,
> > otherwise always passing vma->vm_mm, it's a confusing interface.
>
> make sense.
> I'll give some thought to how we can better handle this edge case.

Thanks!

> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Also if we're returning a bitmask of orders which you seem to be (not sure I
> > > > > > like that tbh - I feel like we shoudl simply provide one order but open for
> > > > > > disucssion) - shouldn't it return an unsigned long?
> > > > >
> > > > > We are indifferent to whether a single order or a bitmask is returned,
> > > > > as we only use order-0 and order-9. We have no use cases for
> > > > > middle-order pages, though this feature might be useful for other
> > > > > architectures or for some special use cases.
> > > >
> > > > Well surely we want to potentially specify a mTHP under certain circumstances
> > > > no?
> > >
> > > Perhaps there are use cases, but I haven’t found any use cases for
> > > this in our production environment. On the other hand, I can clearly
> > > see a risk that it could lead to more costly high-order allocations.
> >
> > So why are we returning a bitmap then? Seems like we should just return a
> > single order in this case... I think you say below that you are open to
> > this?
>
> will return a single order in the next version.

Thanks

>
> >
> > >
> > > >
> > > > In any case I feel it's worth making any bitfield a system word size.
> >
> > Also :>)
> >
> > If we do move to returning a single order, should be unsigned int.
>
> sure

Thanks!

> > >
> > > >
> > > > And generally at this point I think we should just drop this bit of code
> > > > honestly.
> > >
> > > MMF_VM_HUGEPAGE is set when the THP mode is "always" or "madvise". If
> > > it’s set, any forked child processes will inherit this flag. It is
> > > only cleared when the mm_struct is destroyed (please correct me if I’m
> > > wrong).
> >
> > __mmput()
> > -> khugepaged_exit()
> > -> (if MMF_VM_HUGEPAGE set) __khugepaged_exit()
> > -> Clear flag once mm fully done with (afaict), dropping associated mm refcount.
> >
> > ^--- this does seem to be accurate indeed.
>
> Thanks for the explanation.

No problem, this was more 'Lorenzo's thought process' :P

>
> >
> > >
> > > However, when you switch the THP mode to "never", tasks that still
> > > have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn’t an
> > > issue under the current global mode because khugepaged doesn’t run
> > > when THP is set to "never".
> > >
> > > The problem arises when we move from a global mode to a per-task mode.
> > > In that case, khugepaged may end up doing unnecessary work. For
> > > example, if the THP mode is "always", but some tasks are not allowed
> > > to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
> > > will continue scanning them unnecessarily.
> >
> > But this can change right?
> >
> > I really don't like the idea _at all_ of overriding this hook to do things
> > other than what it says it does.
> >
> > It's 'set which order to use' except when it's this case then it's 'will we
> > do any work'.
> >
> > This should be a separate callback or we should drop this and live with the
> > possible additional work.
>
> Perhaps we could reuse the MMF_DISABLE_THP flag by introducing a new
> BPF helper to set it when we want to disable THP for a specific task.

Interesting, yeah perhaps that could work, as long as we're in a sensible
context to be able to toggle this bit.

>
> Separately from this patchset, I realized we can optimize khugepaged
> handling for the MMF_DISABLE_THP case with the following changes:
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 15203ea7d007..e9964edcee29 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -402,6 +402,11 @@ void __init khugepaged_destroy(void)
>         kmem_cache_destroy(mm_slot_cache);
>  }
>
> +static inline int hpage_collapse_test_disable(struct mm_struct *mm)
> +{
> +       return test_bit(MMF_DISABLE_THP, &mm->flags);
> +}
> +
>  static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>  {
>         return atomic_read(&mm->mm_users) == 0;
> @@ -1448,6 +1453,11 @@ static void collect_mm_slot(struct
> khugepaged_mm_slot *mm_slot)
>                 /* khugepaged_mm_lock actually not necessary for the below */
>                 mm_slot_free(mm_slot_cache, mm_slot);
>                 mmdrop(mm);
> +       } else if (hpage_collapse_test_disable(mm)) {
> +               hash_del(&slot->hash);
> +               list_del(&slot->mm_node);
> +               mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> +               mm_slot_free(mm_slot_cache, mm_slot);
>         }
>  }
>
> Specifically, if MMF_DISABLE_THP is set, we should remove it from
> mm_slot to prevent unnecessary khugepaged processing.

Ohhh interesting, perhaps send as separate patch?

>
> >
> > >
> > > To avoid this, we should prevent setting this flag for child processes
> > > if they are not allowed to allocate THP in the first place. This way,
> > > khugepaged won’t waste cycles scanning them. While an alternative
> > > approach would be to set the flag at fork and later clear it for
> > > khugepaged, it’s clearly more efficient to avoid setting it from the
> > > start.
> >
> > We also obviously should have a comment with all this context here.
>
> Understood. I'll give some thought to a better way of handling this.

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo

