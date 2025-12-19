Return-Path: <bpf+bounces-77190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5ECD15F9
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8317930DBB49
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB243342536;
	Fri, 19 Dec 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oopWd20f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CcFqvgH1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383C34214F;
	Fri, 19 Dec 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168603; cv=fail; b=shUvXa2oiZjCDDKCks5jfqHF1+SKeHl6Uxx01L86BrogA5V+4ZLOQ7xhG8IwPs0VKm91z9M3vxYTnvFW6O3s+Lf0jo8kw9F2DnWNxnAKImR3KG8mHSgHTGOSReQyY8QHaMvIA1TtgXXgG/V2NsYGzrZXZid+wkZQIS0A/ueS2Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168603; c=relaxed/simple;
	bh=YcsZmK1bIch+iP+3VsbSrzgUnh1pWaMxMyh8SnfkRdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gS4aGPAAO/fEKyFrWmYcr2LXl20h+aEtSSDgKOfkn14uU1MOHWpsABEY/htjIoe7lZI1lQynhuKMkIrCkPyWIY7O/4AQEKdDQgj0roM7dMRybDFHFNqXsJQanL4vHhHgdIZS/Q8O/fTBJVu14RIImoE47AsLnt6OYo/nMe9tfoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oopWd20f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CcFqvgH1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJHv9st197575;
	Fri, 19 Dec 2025 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s2F5PGxWbfDIBlU5YiX244mWEmI2pOp8hrSc37Uq5Og=; b=
	oopWd20fKBDHJXBUFFmhF9soFaffiPU/zQ9brFxqUyM4NvbtYJmZdnkVEKazAdVy
	TLEJ2estrCjX4DLeFKQeOJjY7/osklGxCMvknPs89IsZQ/0TDk7PIcmd0zdo2qy4
	Lt6VI7Upot/hSlaXAdol3p+Un7zg8SZkC3Hh3x6Enz/jXeuvANs1tp5F/lY0n550
	JV0ujqrpCHx/HAk8n6ytFvHDxwh7/AYwe94+EiRC3oZv5vVWVExd5MQJsmeBlS7f
	KPx/QDuOYqzDUA2Z95kg5zSo844c9zwJl6NHb5ZGmr0AuGHjhvZFUVHhlp8M2bZm
	+LZzwqG40vxZ8DYoLCQYXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r289h9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:22:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJGP5BC036899;
	Fri, 19 Dec 2025 18:22:53 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtmtfq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwmHb6QmfrdyrLcIMSxFuHq+A9vSMtoBxCUxUM0cXwtq+gM6QgZO6Tc53i5iVD6hg6Gn9nl1GdcS3WrALIW9+iRoHaFRmh8mxc1TWQVfgATxYpd1UhNqsLeXOxN0gKrsRkbC6oX78PZR/EPO1/J1YOvkRs1Ks5HRLMwGqSr8UIuIGS95v6klpk9nCNk7DBu5qt4XKZIOzrLVGvpfYwhmcl4cAEl6EqBgpxh5elDbdaQv3PVD4aVBl7S94KpN/0A3IdM2fIif0DCbE/guXKKO7yZcHerDjgLzRTKj/RbB6kohMNW053jFZCdCWg0RSE6VBDmMkPDtKE2dYUPdiN2uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2F5PGxWbfDIBlU5YiX244mWEmI2pOp8hrSc37Uq5Og=;
 b=q7DSt0YzTEFhS59IW6i4OA5n8hMagdzEc5X1ED4zVxn5fJVBKsY8N3LaheFPbVgIWIdlpoj0LyjTDF3+eqArHHh5voyoG/c3TT3X0kCqTHmTLXwYZgPxpOrGAbdiBYXKUZqJeaPPtgj6NPYLUW95pLmwgmHML8+8hpE08GD0tYj4mD9drwlwMZ9de9TmpmhnrvLBBIkv3EKPV7XK2q1Fq6kIaumIsNqGOhjZWsiDyNas3ZJFON33uDY5Uo+T6VOmxN35hwFsAzXTX9e6pRgW1e8SNZNSZMBvLyVuC5w/ApLuYWPrZUp5pEFUTejv/UqrtDcAfeh004r3Am+HP7lSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2F5PGxWbfDIBlU5YiX244mWEmI2pOp8hrSc37Uq5Og=;
 b=CcFqvgH1bvmkjNay0bydhSnZ3bAXbMY4eZRkkXNUT+GP4S1N7/viO5Vnquz6KuBzkNY3sLncfNRyk68bri6JEs33d41amwI1EiHNBLCyCAEIhwGdvu1UTBGEvP1zeAzUZhdIPpxI0gAG1rq3WEJPTGDk6iDiQr9T02/g9ROmjG0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:22:50 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 18:22:50 +0000
Message-ID: <ef5271d4-74b5-4295-bdb3-2fb665b0ee3e@oracle.com>
Date: Fri, 19 Dec 2025 18:22:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com>
 <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
 <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
 <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0596.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ea65d1-fb9c-495d-2a18-08de3f2b9e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGhVTCtUWVZUNUYzVy82Wk5tSnErS0tVY1o0Z3U2ZjZ5Y0MrbWlhdGNQMEdT?=
 =?utf-8?B?SWFuQ2tjWDJGamZsSnRsQzN2TFZUSEJIaWZCWmE2M3JOMlA0Z1JoYUkrUTdy?=
 =?utf-8?B?MUJNYkphUUkyZnhmNlZHbHJhRFJpK2JqdmRkdFZ3c3plOHRZaW5jT2poUEFR?=
 =?utf-8?B?SVB1RTI5MU5PTmxwQlRUai9SUm1vUTNHcEM0b1BTVkx6REZSTEl0WjBoVWdV?=
 =?utf-8?B?ZnJtL2JZQjZoMUg5TWVnNVhCaTlFWFA4WW5NdThZbWE1RkJMSTNZSTZSWWVx?=
 =?utf-8?B?ckJOdkZ6bzF0SXJEKzRDWDdtdHFSMGhWOFhXOUpaUC9IK3lrazRpbnVabUhC?=
 =?utf-8?B?cC9HNUlmOHJXdVhodmhnWnlxbzEva3pLdk1zamFiUU5lWm10OVRJc0RUN2s1?=
 =?utf-8?B?MGpTSUNXYTN5Y09NNi9wR0tHOENhdGhoQWlBcFRITUpuN3lLd3VtQUs5L3B1?=
 =?utf-8?B?ZitEN2RFWUJhaGtpL0RTMkpkWFprOGpRc0J1NC8vQ3hJL1BMeENNOSs4YVY0?=
 =?utf-8?B?ZU81THFOM1R3ZVlRRWRheXdzZ0lvb1NlQm9LZ29GUWROdUFKWDdWK3R4bEI1?=
 =?utf-8?B?VmdyWDVHMy9sS09vQ3VXUGdERjdld3lsYVg4a2JTeitFUE15QTNzc0h6L3lz?=
 =?utf-8?B?NWZGdG1Wb3NkL2xiRERJR2Q1TjZydG9teHRvNG91c2xRNzJ0aWxhZGdJNVJx?=
 =?utf-8?B?UlJPNlFCUnRjbFBUN1NMemZtT3dsOVBrSUVpRFA5ZWhtY3FKbUFxQTJqYUdL?=
 =?utf-8?B?Y1lvTHI3WmhFR2JFaXlEOUxub2cwNXZyalFLZGl6Ri9TYnNzOEZ3M3NjdTlZ?=
 =?utf-8?B?bVQ4VGFZNTR0dXZHd2psWG84WlUvUkZreGNaUXp4NTNyQUNZMy9GdUs4SktC?=
 =?utf-8?B?cGozQXEzblVGWmJsd0dFZmZJRE8wb3NHeGxhK29lMzZaQjBlbzNOZmVJV2t1?=
 =?utf-8?B?dnR2Z3JLNmFvUHN6VWU2R2YyN1lBdW1IMXVPOWp0cDg0YXdNdVdRVEg1aXF6?=
 =?utf-8?B?ZG9KaTQ2ZVBHdWEySHZ2RDMrS3F1OXpKWkZNRXgweW5VQW5qaGtYWGpQNXd6?=
 =?utf-8?B?T2F4dkZDM0N1Q2hqOERQYkpHbjdNenFDR2Y0ZGNjemsvSFVTRGd6UzRiaC9k?=
 =?utf-8?B?OUx3cFF3bGRIZFdhbkJONTBLdEJHeGhFbG93Q1A5cTVDSHcxWVBJQnIxWEVh?=
 =?utf-8?B?U0FlR2RBMmhMQnc5Z2ExaHNKWFlraHV2WExPckVzc2JPWGxzb256VmNsNHpH?=
 =?utf-8?B?REVidTAzK2JBZ3hvZHNqTmNSdHRZSkJjNUVSanBpZWt2WDlVcXB4ZGtSZmpk?=
 =?utf-8?B?b3Q0OUI3U0tIYkxTZWg0bUxRKytkN0FYRmV4OXh0WFZjY1c0eVBGMThTYTNz?=
 =?utf-8?B?STZibmx1MHM0YWpUc3NXN1JFUHI1aFdwZjg3TVMySVdwMXRzcUlsajVxTkdo?=
 =?utf-8?B?aUFPNU1XZ0ZNTi9seE1jMVdkVzd3c2FiUFp5RGhmOFYzMEF6Tk4xbmN2M3F5?=
 =?utf-8?B?dmFhSWRZeGprVVlxN1Nhd01pa2pPbFdIQkN4Z1dTVDZYRmJYcDBjeDZwK0lW?=
 =?utf-8?B?RXZSdU9mODVHSFpzTGtyTGt3QlZzS2J6ZkxoVllNeHNjRCtqaHFtTzdJaHZ1?=
 =?utf-8?B?WXYyYk9RY1dJZis2RENxTlZPbnpPWmh4VktOOHJuaTE3bHlrNUZRbVh2dHpn?=
 =?utf-8?B?WVBsRmMzMXdTUzRoM0ROM0FWQ3g2N0tkTTl5MG1MUjV6TE9Ybjk2Zll2bGV1?=
 =?utf-8?B?cWRXMjBJb1RPRVpDc3dOYXVwTzdGZmZtQU11R0cyY2pCMTUwUXdEWEJlWTBO?=
 =?utf-8?B?RkN1Y1QyUVlrT0JpaWw1eVkrUk93aGxzZnZCT2NocXdZdld1UEgvZ3JnSGFx?=
 =?utf-8?B?bjNSZWNCSWZyVjJYMlc1Y1k4RU1EcGNyZXhXZDhLaVJndjVadGRqcGJuTzRa?=
 =?utf-8?B?L2t4ZzYrV0N2SzlUQmVlak1Eei9rWEtwUFpXaVlNMVdxcmpsM0lqdytsa2Vm?=
 =?utf-8?B?blQxV3VCNlFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC9YaFBRUzFLQ1Vwc1pVV0FhME44MmdadTNxMEZFZ2xNbHA2bjFhWXZtYkVt?=
 =?utf-8?B?WjdmZkxTd0MxcS9xbndEY2RkRHZwWUJNNGtlNVdUaC9UUDBocys0QWRYWU0x?=
 =?utf-8?B?bktRZXZ5cVlhTG90S0s3bjJFTlNVZDd4UmNxdGtsUG9mY240OVdZMjZ2OXFT?=
 =?utf-8?B?cU1wMWZRQWk3MnRMRE81MXlHWktBVUZ0SUM4Z05wM0FoMXpQV091UlVLaWdH?=
 =?utf-8?B?VXZOZWh6WGVuMTNjUFFNM1RKbTlnWGY4TThpV2JpR0hPSnBpZWhpdG42SUVZ?=
 =?utf-8?B?UlF0aVNRQ3BXUDNySkl4bEdTbDhvb1FZbjlCUnJqSFJEckh2VkdTQlc0UHhy?=
 =?utf-8?B?MzVmMDBmUGtlbHEzYVI3Q1RWUHZ3NElBMFBlNHg2VW9nNE1xUyswcEJraFV0?=
 =?utf-8?B?NnFtUUJTSnd2d1huMFV1aUxCUzNuV3Bsc1VtYzhjc2t2VHMrNStFajNZQnJP?=
 =?utf-8?B?c2dONXZLNEhwRXNlQ0RPVXhNdWhMZ1dIaEE4OWpSb3g2eGZJdEJPWFhnL2xk?=
 =?utf-8?B?UldKN29TSnM3SEFiS252UDlKR2xhSUhOMUd2UlphUzF2K3FrbkNjR1FaSk5P?=
 =?utf-8?B?aFBwSHZjK2dNN0ZDQkRZNFY3bDZaZFFOeFkyVysxYXQyMlpKVGs2ZEZjS29T?=
 =?utf-8?B?NldLM2ZCbXNaOHMvVFN0RXEzZVJnNm1HZXUrYkR5Q3lvNElScjF1TGh3NG4y?=
 =?utf-8?B?Z2dIZ3NwaFZ1dk16ZFFuM3NpUXRxeXpEVEhtUk5mb1czbXZyNU43TXRpR3Vs?=
 =?utf-8?B?YjFZTTQzS2pScnM4dWYzcXpPbTB4dG9KbUp1N0hxcEhBVWZzT3J6L1h3UWN2?=
 =?utf-8?B?ZVA5Uk9xWCt2OHFWbk9UWmlJTytWY1ZRdGx6aEpBZmNyTXVnQ1lZT1Fhb2JS?=
 =?utf-8?B?T2xMVjVaZXF2aEFZNGJ0bk1DdU9qNWQrNm0wbm5PVmNOQVc2MXdXTDJFUTky?=
 =?utf-8?B?V2RDUWdwdi85TDc2RzB2UGU4eS94aDVUSzNhY01PNVVlT0luT0FiRzlJT0pv?=
 =?utf-8?B?OHdnVUM0WW84WmlMaGpKMTdoRWpMenhJU0JVZ0lDY3V6cU52a3V1c1ZJdXVC?=
 =?utf-8?B?QXc4aGt4ZjV6ME5aQmxkVXI4aHZmdlNBbHVTUEZSQVAvblFIeERHVy9IdHN5?=
 =?utf-8?B?c0tOWXZjbzBWSmcyRVBqdE5aNk40czJqNFA1MTJRU2gyM3VwaTdyVzRHUXVG?=
 =?utf-8?B?ZXVuN2ZXWkV4SDlHZ0JwQ0JhKzN5amtTUWlEbVJYaE1KQjRpRWRVZ1FPWk50?=
 =?utf-8?B?dGFKSzJSR24vRCtJcGRKMHJhc2xTdWdWZFlSUkFCdnlLZVNWRVZoekM0U1pn?=
 =?utf-8?B?TEhFVy9ONWlhdm94N0I2LytuZ2VkeEI2cU85SlJTZ3NoeTNvanNzRmQycEp0?=
 =?utf-8?B?S0prNEx2SmlSdDE2SXF2bFVETzVRbTNsOFAwQWVCTTBnTUcyejFrdGYvb0w3?=
 =?utf-8?B?STR0TmwvTEFRbGZKY3FwSkFGS21qa2RkelVUOFdYaUQvajIxMk45dUhTZmQx?=
 =?utf-8?B?YlE0RFNkL3AxY3FSWHdTN3hweGZVanRhYnpteVAyb3luN2x3SnY0dDBqMFU5?=
 =?utf-8?B?UUsyZ0YvdWxrSXVuZVVFVmEyNVNGVG40MWs1eGovMytNZTE5NjZQcWVwYmNy?=
 =?utf-8?B?U0NkTDNnUmtOc1l3OWN0SXJDZkdnSGh0UmtHMi82cUhrRG9yOC8zWkxHWnMv?=
 =?utf-8?B?K2l2WW1qcVZNdEJEWTRkaHRJSFpIWVdZQVByVnd3V0F0QkYzb2VUUUErSEUx?=
 =?utf-8?B?SzJjeFI1UmxESXN2dzFPWHBkNUU2ZDBXRFRyZzVNdFBVaXJwNGdlR0lxT1dq?=
 =?utf-8?B?dkFMd1RiS3lrNEc5U2hGek8yUThqcHBtQkdVWGt0SFB1T3RwOVFaeFJRL1B4?=
 =?utf-8?B?Qk1KM0pyR3o2TGxLSTlYRkthcnN3cS96SURXVDJ5NVN4dzUvZUFkVldWWG53?=
 =?utf-8?B?VlJKblFkc3NrNENTZkZkWXVSMkRuY28yRlh6S2hvR1orOTZUWTNYMzl6R3kv?=
 =?utf-8?B?WWhIUFdueU9HWkJURUh4ckI5V2tId2hBcXI0V2pUVDVqbkNEaHFFQWZad2xQ?=
 =?utf-8?B?VDdnZDUraGtnYlNRc1JUMnFDTUxKVzNTM1BVeEtVaDBaZlhoV1JqYVFRcmVW?=
 =?utf-8?B?T1YyWEp4TXFnL1NQak4wbTVDUnJzUU5rNzFuQVR4Ty9udWFNdHcxWlMzNGJt?=
 =?utf-8?B?ek9HTytpVmVoOG5ISi9YUU5Wc1NiVmM2SjNIVzFoWGcvcFJTek9hWVYwWVJ1?=
 =?utf-8?B?VUhqS1d6TXFCWmNjRUZLbUthTzFwbW9nK2h1RXBxejR3L0FlYjllbkN0QzlM?=
 =?utf-8?B?eHYwd0p6VEZlL1QyU3JkWmsvZ2FGR2ZwZURXRk9BcDlDYzlpR0QzUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L5Cc/uq47lwUyPfUxv408jbKyKe4qx8qdk6Zc4BwpJ46JCcRJxGAYdWKoF5U/SEDWeIPW3QA4EBWXv39ug3mxxTxJyggd92FkKxSWWBRkaqEdE8scm2nAOO5f+7XI3un0FkTesleAteFXJNHOCa+xY6yUMUQ79O3TGqv1H8fJPW/U2TeHhQnDLuE5fEAoThKczm8/uV39MQshXpaHl4cqt3MbRibyAG8t37XCNJ5dpml+lOOssFdjWcKOBnMNTfsE+C6Dt3h4x76QQXbxBCL4OfStfrJbc3ekk3sopxhh5VZyqUCdLlwWMeuw6fC2xzkHKtdLx882MxXULPNatj3nN4jZ97rUat2vi1eo700kCKZnCnQTgBKZhtYLBDMsiWsafnlwUTRkcXrU4tWy3kp0mFThGdLw5TRF+mu+gwG7ASQp/bNTW3Mmg3Vwa7jelXUWUuH1bLb6P9HUxFWlZH7BgK87jzvi7USOVYsdXJzTkKefYUN+R5TU4REUcIBeXyiUe8UabOucvpLA5bY6VmdKP0cW2N177lTRGQmWiVVqxK2OkzL+vkUofxuPBznOZK4UsL3tFhUsK7dtIg5VJyNBzG1CXzkSAGiSaqVileE/PQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ea65d1-fb9c-495d-2a18-08de3f2b9e35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:22:50.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PBFt8TF2+Mo6xpUOMQGyUHlkElTTW5RpU4+i1qjdugoxo+x5dsLX3YEBR4PGd3swHFhHGgKyFEVfbClYJw8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1NCBTYWx0ZWRfXwacWTz2AII+W
 Ykey/cjmfjjqMOCqLL2YL13UPz5kKDtS+W30IfI6s2L7lMMSIu/0vD8rtUlafeaUXaLO1vSgEPJ
 yvqaWteAPWQpFtByQ4etpZ/+993NB7dnL3YvrdoK+37STiX767vhjUrStjjQH8X3lGtkmYZW8PM
 XgaKNfLtoVAWG2WW1CGjWlKFVg6LM7H+jfIR7ijUYXk9u55/Tjaht8x4mkkzw6pHTvJoVo5v0M/
 k21KC24UPfWTqf3HbcHeJDELfBWeT7FkgHqE+GX6AuLC9Np6KenSCAWqHgAAnESf5tSLbjLdn3Q
 aZy3tWrDzZ0j+nowao94rxrqV5fICdayQf7dh9lOebv8bYXxNSz9Hzh26Qxbyd7HmUbeZMCg3/c
 0Vlnx3SsVjYhkYlF9q7MDsaajx6cgWS+G8NInRbsJMt64FqaZipkq/PBrn150InbH8DnAExtYjl
 yz1DZGnvINevMHrmTybiTkAgQYu0jLjsjM2mf1WI=
X-Proofpoint-GUID: HvD5Jqpod8CpHdzpQDWX2Y7FjT9QVOZz
X-Authority-Analysis: v=2.4 cv=H/nWAuYi c=1 sm=1 tr=0 ts=694597fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=E-1xI6f4GHS1-yatyE4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: HvD5Jqpod8CpHdzpQDWX2Y7FjT9QVOZz

On 19/12/2025 18:19, Andrii Nakryiko wrote:
> On Fri, Dec 19, 2025 at 10:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 19/12/2025 17:53, Andrii Nakryiko wrote:
>>> On Fri, Dec 19, 2025 at 5:15 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 16/12/2025 19:23, Andrii Nakryiko wrote:
>>>>> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> BTF kind layouts provide information to parse BTF kinds. By separating
>>>>>> parsing BTF from using all the information it provides, we allow BTF
>>>>>> to encode new features even if they cannot be used by readers. This
>>>>>> will be helpful in particular for cases where older tools are used
>>>>>> to parse newer BTF with kinds the older tools do not recognize;
>>>>>> the BTF can still be parsed in such cases using kind layout.
>>>>>>
>>>>>> The intent is to support encoding of kind layouts optionally so that
>>>>>> tools like pahole can add this information. For each kind, we record
>>>>>>
>>>>>> - length of singular element following struct btf_type
>>>>>> - length of each of the btf_vlen() elements following
>>>>>>
>>>>>> The ideas here were discussed at [1], [2]; hence
>>>>>>
>>>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>
>>>>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>>>>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>>>>>> ---
>>>>>>  include/uapi/linux/btf.h       | 11 +++++++++++
>>>>>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
>>>>>>  2 files changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>>>>>> index 266d4ffa6c07..c1854a1c7b38 100644
>>>>>> --- a/include/uapi/linux/btf.h
>>>>>> +++ b/include/uapi/linux/btf.h
>>>>>> @@ -8,6 +8,15 @@
>>>>>>  #define BTF_MAGIC      0xeB9F
>>>>>>  #define BTF_VERSION    1
>>>>>>
>>>>>> +/*
>>>>>> + * kind layout section consists of a struct btf_kind_layout for each known
>>>>>> + * kind at BTF encoding time.
>>>>>> + */
>>>>>> +struct btf_kind_layout {
>>>>>> +       __u8 info_sz;           /* size of singular element after btf_type */
>>>>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>>>>>
>>>>> So Eduard pointed out that at some point we discussed having a name of
>>>>> a kind (i.e., "struct", "typedef", etc). By now I have no recollection
>>>>> what were the arguments, do you remember? I'm not sure how I feel now
>>>>> about having extra 4 bytes per kind, but that's not really a lot of
>>>>> data (20*4 = 80 bytes added), so might as well add it, I suppose?
>>>>>
>>>>
>>>> Yeah we went back and forth on that; I think it's on balance worthwhile
>>>> to be honest; tools can be a bit more expressive about what's missing.
>>>>
>>>>> I think we were also discussing having flags per kind to designate
>>>>> some extra semantics, where applicable. Again, don't remember
>>>>> arguments for or against, but one case where I think this would be
>>>>> very beneficial is when we add something like type_tag, which is
>>>>> inevitably used from "normal" struct and will be almost inevitable in
>>>>> normal vmlinux BTF. Think about it, we have some field which will be
>>>>> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
>>>>> totally break (old) bpftool's dump, as it really can be easily ignored
>>>>> **if we know TYPE_TAG can be ignored and it is just a reference
>>>>> type**. That reference type means that there is another type pointed
>>>>> to using struct btf_type::type field (instead of that field being a
>>>>> size).
>>>>>
>>>>> So I think it would be nice to encode this as a flag that says a) kind
>>>>> can be ignored without compromising type integrity (i.e., memory
>>>>> layout is preserved) which will be true for all kinds of modifier
>>>>> kinds (const/volatile/restrict/type_tag, even for typedef that should
>>>>> be true) and b) kind is reference type, so struct btf_type::type is a
>>>>> "pointer" to a valid other underlying type.
>>>>>
>>>>> Thoughts?
>>>>>
>>>>
>>>> Again we did go back and forth here but to me there's much more value in
>>>> being both able to parse _and_ sanitize BTF, at least for the simple cases.
>>>> What we can include are as you say types in the type graph that are optional
>>>> reference kinds (like type tag), and kinds that are not implicated in the
>>>> known type graph like the location stuff (it only points _to_ known kinds,
>>>> no known kinds will point to location data). So any case where known
>>>> types + optional ref types constitute the type graph we are good.
>>>> Anything more complex than these would involve having to represent the
>>>> layout of type references within unknown kinds (kind of like what we do for
>>>> field iteration) which seems a bit much.
>>>>
>>>> Now one thing that we might want to introduce here is a sanitization-friendly
>>>> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting kind
>>>> which can be used to overwrite kinds we don't want in the sanitized output.
>>>> We need this to preserve the type ids for the kernel BTF we sanitize.
>>>> I get that it seems weird to add a new incompatibility to handle incompatibility,
>>>> but the sooner we do it the better I guess. The reason I suggest it now is we'd
>>>> potentially need some more complex sanitization for the location stuff for
>>>> cases like large location sections, and it might be cleaner to have a special
>>>> "ignore this it's just sanitization info" kind, especially for cases like
>>>> BTF C dump.
>>>
>>> So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
>>> we can "overwrite" any possible unknown BTF kind?.. As you said,
>>> though, this would only work for new kernels, so that's sad... I don't
>>> know, I don't hate the idea, but curious what others think.
>>>
>>> Alternatively, we can just try to never add kinds where the vlen
>>> element is not a multiple of 8 or 12. We can then use ENUM
>>> (8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknown
>>> types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
>>> are other options. We just don't have 4-bytes-per-vlen for the most
>>> universal "filler", unfortunately.
>>>
>>> The advantage of the latter is full backwards compatibility with old kernels.
>>>
>>
>> True. And I guess during sanitization we can just handle intermediate
>> types in a type graph by adjusting type ids to skip over them, so we
>> likely have everything we need already. Funnily enough the BTF location
>> stuff will give us a vlen-specified 4 byte object (specifying the
>> location parameters associated with an inline), so that will help in
>> the future for cases where it is recognized but other kinds are not.
> 
> So coming back to flags? Let's do two flags: "safe modifier-like
> reference kind" (for type_tag-like things where they can be dropped
> from the chain of types) and "safe to ignore non-structural type" that
> can't be part of any struct/union and are more like decl_tag where
> they only reference other types, but can be dropped/replaced with
> something? And if kind doesn't have either of those, we won't attempt
> to sanitize (and hopefully we won't even have kinds like that, but if
> necessary we can add more flags with some other "safe" semantics, if
> necessary?)
>

Sounds perfect, thanks!

