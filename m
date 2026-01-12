Return-Path: <bpf+bounces-78605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FACD14A2C
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F5D3015AD7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0837F747;
	Mon, 12 Jan 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rbC1QDsi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LGI7SD8W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BEF37F0F3;
	Mon, 12 Jan 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240059; cv=fail; b=YbzXABtNVIRloF6ajR4S9moYiH3TXHJ76rFacs6UF7baBtTWbxtET9lrAQVv0Wp9hQhIxSdZr7eoI9q+4PtDSVdPujHMVyWQ3VMOzf0BB3k0/+u0RMKgOXWbj4lLEneKzS+xio+WbvkpTIpir6eNJ8+rzLLJvkfBRq8nisTvxI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240059; c=relaxed/simple;
	bh=jNaCo+/tpYZqgmMUKNsQrYBOIJvNH0p4lQVxMm/6dJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHDwgi7bHJ4q/WQmMjGcKJgbUTxlbXCv1Zs/gyEZu1SbUr6BQweUGXjXaYBLR8z3+H/N7pZUaRhOYqHbsNhdf5y5Y2SRjx8ISV4MFKCl/PWutTLaHpoLGB1YJQH2KkXqWiSwRb/eoCXX+3WwyMeW8W69wYw0coLBA0qFKYYVMpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rbC1QDsi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LGI7SD8W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CFxuUY125933;
	Mon, 12 Jan 2026 17:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wXE95hoZNFqmTU+Eg+bMeRgCz8VftLp5l8Zp5cFFx04=; b=
	rbC1QDsiAAJZEgqXYbV7YLUOpAobIARM8jDi6RMRVROvq+FAEKxL0JH5Gh8TQLOW
	A8sA7+rxADXOenJmWedh27YfTU6s1tVGCeQTuplFnpquYW/U02L1TKcvJAUtk2YX
	hDirIygZ0gt3PmHkW84yljNdF/98T7EuvIG/XDJppzAQHQgCuT359rfX014vWuhP
	mCLhISdnltgLG+JqKjKp9/JdUS3+zKUKhJOnqibj3qw9LgF5CzgdaOK5x6xGaNzh
	f4lBIgBkHV+lXkEro+7NWrC5Q+K8yXTC5rniwssqer1o4xIJyrQDVDUxR3sOVqyF
	tsULYuTSPmTRBssh6P8WXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8a1w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 17:47:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CHJWtr004522;
	Mon, 12 Jan 2026 17:47:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd77pnde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 17:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTWslFzObLz9uqCFKQ6jWtdmwvJFbXaPmi+SP6LT3KSab6eOI7SlR5S7hi2OS5UP729zeYo7uy+oqpRpenCOeaMxJCKa9l+CHogXv3hj9kz1k0jIMOfro0zqHRo9tWLjnEa26PzMvl/KO4cE2+0pPqBFANUUMB2F65YGFMonw+9YPn+zJMHmE/oqYgLGGu9F2/YXKIZOAQl/7OPoIl8Y1Cg6XoPisRqBjpb7QzMXTm2iCAliI0sMX7SqStMmV62H9G07qHVbJDp4QJ1IBjoGDpwqhN692WYrVwkyoSHNYebWNiMx0aUmHNSq3MlgfKXATBjb0p2KfKF/cJ5ZPXDIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXE95hoZNFqmTU+Eg+bMeRgCz8VftLp5l8Zp5cFFx04=;
 b=p7iP95xZFcZ4wzBOQemWQfuWAjGlZ35sbr2lbmARFLQCnquOQjoobT1Jw6OswbszADoZa4eVnJKPPtcWmAW7vk6lGrKOB5PLYlGoEYA4B29mRoUhIMfkTcrNg6AEYw3xWe9dzVYUqLFCFkQUG+nTKuGEVXkJ/HWNSu1VRdxNcInP2SOfDE1Bnmlxb9ZNqk35dOYz3Ht5RktG+KDtwoFooQ7H+Y+pf1tG2ZbbWbcaHWS4L0yB7d6XxV3syVCl7Mc+9UqkLvcIttchCeTOBsf//+KA3G9tbfbvJ9e3uqbKajh43qjp6GKtWGiJQNuduIhyZjNAYwQK6GAt5Oc7WB+EAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXE95hoZNFqmTU+Eg+bMeRgCz8VftLp5l8Zp5cFFx04=;
 b=LGI7SD8WQc2QsNWowSspUFAQC6QKc1K/xss9jti6e84IPuCgyMHmklNNdu0eRAXYq3ZrVwbBBubzJ2mfs8SriWzeNxqm2245KHnNsM/+BPnxJImbs1GlgUUkRigzfXUU8KHbxZzOanX+12LCqItxgfYuXwMk5LV7IQR89EFyVlc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 17:47:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 17:47:10 +0000
Message-ID: <c81494bb-1f2e-4677-a9c3-a438c4d9119c@oracle.com>
Date: Mon, 12 Jan 2026 17:47:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Thierry Treyer <ttreyer@meta.com>,
        Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
 <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
 <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
 <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
 <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com>
 <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
 <CAADnVQLFCPDoRQt4nWxsHVt3AG=HnyE=PepaniWv1yeigozaoA@mail.gmail.com>
 <da5823ad-bc47-4fb3-a308-645e9857947b@oracle.com>
 <CAADnVQLpGFkNnbex6CmbDjpPgXEH4TPvA9XrtY76SX_RaoRq9g@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLpGFkNnbex6CmbDjpPgXEH4TPvA9XrtY76SX_RaoRq9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 58db9617-b26b-44d2-733f-08de52029c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXg5RUFGZXlhVDJkN3RVdnlRS1NvL0JSazkwSW1WQzg2bmtTUnhOa3M1cFNB?=
 =?utf-8?B?N1BreGtrTzlmdXA2MG8rQjEvTTU3eUJzTUZxMzdYQlpOTUlCZmJlSUtMMmxV?=
 =?utf-8?B?SVFOWHNxczJNT0pnR2dVMmxmTlZreW5aOTNLWmJUdjFrT0Z2amJpUEFkR25L?=
 =?utf-8?B?TUpOZFI2cW9xRG1JREhlRC9pOEZvWFVDWlU4bHUvU3FvejV1V2czSkVWMEdn?=
 =?utf-8?B?ZUJMM1h2MGxsLyttWk4rNEdDV0NnWDlROHBMK1c2U0l2d3ozeHdsYlAvOGF2?=
 =?utf-8?B?STVhSzhteC8wMlVEamJlZE0rWEJnZEk2R3FJZEJlcG50dEUrblNzeUJJU1NR?=
 =?utf-8?B?cExwWVdEV3AxWWhHaHFHOVE2L3l2TEFvNitWcmg4azhzMGFEUnQxeEFmQTQ1?=
 =?utf-8?B?ZWNWUk9UV3ViRGlKVTZFU1hIdDIyOUNzaFUra05UQjBPMjZsdHUrUklKRW11?=
 =?utf-8?B?anRoZ0Z3R2c5V3l0OTFmZEV5dXdlYm5XcDFqbUVWZDYxaG05V2o5S3BVdEdC?=
 =?utf-8?B?REQ1YWpvZ015dmpabnhlenJydW9USjlSdWpaTUxOeEhyaXdiM2NOblE3NXVq?=
 =?utf-8?B?Vm1COG85M2hPVlJtbUhOYWFCYlY3VkRmWjlHSTdSSGhhMzBTTVVndnpCQXdH?=
 =?utf-8?B?cFkzRnZRVno3VkN0dHpTZjZ2UnVjTzRPU2hJZG5CMGZtOUsrR24vbElsZ3h4?=
 =?utf-8?B?TE43SmpBT0xYRXltUlpab2srdHZ4dlV3VGsxb3ovYzA0NUxOaWI0YXc1OUUw?=
 =?utf-8?B?bFpUemtQaWszVjZhMTRxZE80N3ZaaHM1eVpXcHJCY05jdWxZdldzQ3dkN2FY?=
 =?utf-8?B?Q25kNUdRa0NIQ1JHUVBDbk1QNUhxUTBIOHpVMFR1WWZCdUlJMWdpN2NxN0kw?=
 =?utf-8?B?RU9vRGpYMTlDUU1QSmZPQmI4UW9nYWpaL2xyNm1NVGJZbWIwVUc2MEoxSEJq?=
 =?utf-8?B?Q2M1bitGbk0xUlYybEdWTUI2Q2ZHb0NYVjYxTHRrKzN4SG9GUlE0RUNPQUFj?=
 =?utf-8?B?OHNNSEgwVmJrN1N2QUhhSHBWYm5KSnprRDBVb2Y2bitBcUNLM1lWTUdwK1hX?=
 =?utf-8?B?RFBtak5ieUxLa01vdzhjOG9IbkhRRWprSER4WS9UbzhIL0JwNEhsKzFhZW5n?=
 =?utf-8?B?YzMzVGdHUGNlaktqdkR2N1Y0MXFoSGJvUlFOTU5VeUJiUkduL3BBMEI1L0M3?=
 =?utf-8?B?WldodjI1a1VJVmVhVUUydHhCMHR2RzR6Ym5EbGc5MzNjMlg3Um9ETDBJb0d3?=
 =?utf-8?B?NEJhZGdQS0VPVWo3VEVmdGczcGE3Zk0wTFVyTTBwTUM3alMwQ3Zpbm40cUlV?=
 =?utf-8?B?dGcwbWVZK0pLWkJ3c1pVTXZtVjdMaGNGUnJzTVJTMk83UDhzT2Zpd1pNT0Ra?=
 =?utf-8?B?YkFqckozd1Q1Y0R4K21IT2pvNDBoNm45MjE0TWJMREdoOUErS29jTDYraFll?=
 =?utf-8?B?Z3dvV0Z2MnFENDgyOWdjakR2MnhtQ2JHNzNGb3VJTkEwWE1Qcy83STV1bWZy?=
 =?utf-8?B?eThhQUxmeVUyZ2FzeDBWY1VrUnZ6QjduMU1XUmRXc1dvdzFGWEY3b3RSelhZ?=
 =?utf-8?B?N0hsNnJ6Z0pzV05OTXZNNi9YNlZNVjVhb0orZmp3bGxhU0pMYmZNbWluWlc3?=
 =?utf-8?B?cnowdTUvTE9UQ3A4a3pIaTdKdjBUVThzR1p4c01INlArdE4xQ2ozU3pjOXFW?=
 =?utf-8?B?T1NKRlg0MXJvRXphbGtDbVliNkRGZFhrSlp2MVJleGFlNjMzaWVIdUZhUGN3?=
 =?utf-8?B?NmQrL2JvcG4vRDVWQkpFYmlldlo3Uk1oK2VZZ2N5NW9HS3c5SlJCR1BtaERD?=
 =?utf-8?B?QWtUbTZYeUMwUDMvc3Z1YTdqRFd2QzhSQUJRRXNiSFhjeklvZ2x6NjE1Y1My?=
 =?utf-8?B?b2MxTW1VbW90TG5YOGtpUmluZDVOaWthd1RXTTNPL3BocE5VQVdvb1dGdHQ5?=
 =?utf-8?Q?8FHskqLHc60grge9R5RfEzDkTTM1Gm/o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUNvVlFaaktXcHAvL3ZYVDhTRmZTZGJnbjBRcmtYWmhOM0xzd1RtMkJkQ2g2?=
 =?utf-8?B?aTkrN1VIQ1BSbmQrYmx0ZEFGSnFRWXpTVE84YWg1S0tldWRZN00wcE5wZFNx?=
 =?utf-8?B?MUZ5SDE2aVlqU1h5b3dwU2VpYUZMZnVPeHhnUG5oWkR6OWpEaGltYWRrQzZ0?=
 =?utf-8?B?OEFsWSt2MVU1eUt2cWNqSFMwd1dNSjlmUTNPcEpuMGNHRFMyN2VVeTM2RDZS?=
 =?utf-8?B?WW04Sk9KSmtMOEhPOWdVTThUajlpcmJrQ3Z6OFZacWJDeUtKWkEwbStWa29v?=
 =?utf-8?B?aDVLTlZQa3ozNXM5aGFsQzVFY29Pd2k1RE5HM0NSMGEwRmJpc1U2WnA2amdH?=
 =?utf-8?B?VlBNUkdSWUNWVEpPQVpOOHFqbkJBeFpSY01ZZGhLckl5bElqVWZUbTlDZTl1?=
 =?utf-8?B?Y2xQMGE2VzE3bWREaHprcDBGb3dCZnVRenE5ZHlOd2NkeG8wMzc1Uk90Z1hD?=
 =?utf-8?B?U255TUV3THl2L0kzcFJueTVtcHhtU1N6SXJYVUZ1TXhJcnVsSHVuZVhKSjg4?=
 =?utf-8?B?NWYzQkl2U0kwN0lSbHNWaUlZa3BIMkRCUTh2WGtvZTRCUm1hdUJsNmw3NUN3?=
 =?utf-8?B?Q1RQRGJvOFlUODFyQTlLV3BKTTVCMXp4c1pKZ1I3M3JWaW9RSWkvL2NCd0Vn?=
 =?utf-8?B?dlZLYzhYQ0MzaUQwbXp5a1M1Q01Xa09iUDRraE9qZGVpc3hlTitxUE1iZ1RQ?=
 =?utf-8?B?dHJOeXVKTjRjRXZxZG1RK0Q0QmRRY00zQXYrOWJpWWZ5VUkvYTFNdTgyRWtv?=
 =?utf-8?B?WjJ0b1loYS9VOGlRaE5ndHMzcEFNaGdxYWduUkY1eWhBbWgrdHk3ZzdDaGNr?=
 =?utf-8?B?WFVDUzY4RkFOQjVJN3I0SlpFUjI3Q1VhME5RSTBJK2dXa09BQTQxdjZia0FB?=
 =?utf-8?B?eSt0TjBPcDF5aW5JR1hTQzNMRTlESnBLQysyb0h4OHpmK1liUTRYbURUQjFs?=
 =?utf-8?B?Nzg1L1loNERpQTZ2RXVONUFiUnFMMXFnQnZZMU1IOVVteG96QktWT0FDRHZa?=
 =?utf-8?B?RGQrZWdHV3REYlNqQ2pSTUVtNWgyemQ5eGFkaDFQUHp3UkVjUW5SSG0yRi9q?=
 =?utf-8?B?UjAwOEljMFVPSkxqR29kdm10K3JXKzBURGhGM0Zsd2xLcXVUN0RjMXhTVHJ0?=
 =?utf-8?B?empQd1g3MUVmQ0xpcHJjTHFDOCtjL0lJUkRLdGZ2TUNzd2k0RnpUZEVDU0s3?=
 =?utf-8?B?STMrajZIYTFIUzdGdWpLWHhqVXkwK0tLMjhxM3RybWEvUVkrNzFxc05HblRw?=
 =?utf-8?B?MEg2TVZIRXBQczMvS1pQR25maWlkTEpDNjJXRHg3Y3JYSzlDNTNQZnI2RTho?=
 =?utf-8?B?OHlRQ1VBeHE4b3RubmJpTEljTFQrbGZkNW1OYkhYNWdNcFByZVBvcGFYYXVm?=
 =?utf-8?B?VFV1dDRwdUQrMzYxaG4vVHhsSnY1SWFXU2hjY0U5aEZ2ZytyMjJ1S0VxbFlq?=
 =?utf-8?B?OVI5cVZsMk9sQmNiRWh6T0lGYmZuQnlnTEQ1bXpXVGxTVExoMUF4SzFoVng4?=
 =?utf-8?B?bmpmc0FQd1Nzc2VVTUlMYU5HaURjNjJxMTRzUXNWQWVBbDdwamkwc1crWUhD?=
 =?utf-8?B?TGlTbU82ZWJZanQ2N0p6MVJZR1dSazJhcitiTUdXdkh0cm5Ta2xPbmJnRTZB?=
 =?utf-8?B?WitlYTMyVFp2bytZN3FlZDNSb1pXTktDWkNJNVZWcFBLWUo1UW9xejFuK0Rm?=
 =?utf-8?B?Sno0UFJTNW11Z2JLSTBURjd3NmNMem1JNnBUdnZwY2YrVytMelNJU0lYY1lu?=
 =?utf-8?B?eE9vMlU3VlpVQ0laanlzdHhnQjdZS2dBZjRPbE9yKzhUK1ZveHlIUkdQMFFm?=
 =?utf-8?B?U3dMQ2Z0UnA3b1o1YkxRQ2g0Tk9EaEpqN2lUWlJDdWZYd1NrbEZkdXU1WnJu?=
 =?utf-8?B?NFlCWThGazlrYzNvSm8xTXN2ekhPa1NqcFBiVFB2MXlwcitRZ0gwcUY1NEpw?=
 =?utf-8?B?blY4RzNWUGtTT0JkZ0FFeHZKcnVDRnBkTE5lT0tUNjA3RnA5Qi9lRFNUQWs4?=
 =?utf-8?B?bmN1YWkzNjBla3VRVTl5eFRvWkI0ZFFqUVkrN3hiMmM5OXZZZ1RYOWk1UXZV?=
 =?utf-8?B?WjUvRXJpZVU1QmV0NUE0ZVRqUi9NUFFER0xNTThzRnVNYnZkMU5RRnRqcnBC?=
 =?utf-8?B?aWdBTHZFTnNRUzYrTEgzdG9oWkVqUmhwY0YyeUI1dHBzcGF5UU85c3ZtaVRq?=
 =?utf-8?B?Rjd2eVhMUHNwTzc5ek9sKzM2N3ljRlNlbmxzVnNDRWk4Zy80SjhPQnhpa0or?=
 =?utf-8?B?eWxRQkEyK080bWRBeCt1aWNKWTJIaWNKcjFNOUFwKzFvbGRRZGs2NWs4OW9E?=
 =?utf-8?B?VGhFdW5CbzRPdWdOK2VMVGRqTTN5eGEyeDJLSEsvWlc4UUhMZGt2UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cp0Im2QZs3ovm5w2wfVag7aH/hPxGPuTvFtN0N+UyuGNhmC21Y2XA+jMri9nNKWfTS/HAQkiWZ+7ni6NCYhkqbncnA/SF2Z6Nsvr1Ypb/7g4gFm2h1wLiZsnr4ZRJE68nPSrVpHcOMV+7c6tgPWftF3Rzg7WqJRJYW6dc2q/amthhGqbK7+YHBwe11pzMk7VlxskjJHiJQzxlOCOJNfkUJp97LZZi5XEYlKGmWI0sSBZMk+NH6TGflOJvrlV3rcYE659J8Ef0MsFdnR6bIWHb0aJ4e+HeC6ZOYyQvzEFTZsMyF3klAyPhhVAwnoBplzYGas4g8EQuwdTca+Jva5ufqjjKCTEg+Q72BTTB456J1auO0cw3eGY02mETGfUPiFZ3iJDrm1q/DJIZrf0kQY6+4KgVYYtNSkA2vydq0p8cR+cC3xMnzv7X7X06/b+qivHo0V291F1War9znTHhjYdfFVSlB9YZUVIMapH1D8TeoIWub+RwtxzLBhG828lAnCIwgCmMnXMa6RkEzbKCdwXcSjWS6xXMcBMtzLxTXbO2cqRljQob1AgFGwYjPFL9F+FDN7U14K2UVBTrch8BhLtA/b3YE9RcfXqokAZLicaK2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58db9617-b26b-44d2-733f-08de52029c5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:47:10.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBXsgDJbVg2tci1ZJNzqgTlqu/3UbadzLPfd4x5JB2KwdZ8EeiO1rAj4gZQwQ15v8OUlSe9yc/0PoF0IgVKJZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601120146
X-Proofpoint-ORIG-GUID: JvPhDg9VHG0pSRAFCcL-T-sJigCXtclK
X-Proofpoint-GUID: JvPhDg9VHG0pSRAFCcL-T-sJigCXtclK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE0NyBTYWx0ZWRfX7mf9i4MLlPnB
 ZTi90fshR5xGc+AvGgFsIpn0dcmmXL5QTO/oGtXdvvd2m94VwjGyKQrSk5dkqWWbAblssmOmtj8
 4VhAGwG9arLfcvt0ARj1Ur7vsHGu1YF0R6ZTqscEDBFHHJvaM4Kdr33aoK0oPc7FEfh9A0eet6y
 0iULQfPfkNYDzH8NDKhIbarP+wFYstGGuG6Vhe2mawh2u3Qbh8TtXFV3LdfO9Xcv2aMooal0h9i
 91Md+YPLP5z3hXsZMEVy240i7/aVR50+k6NOckJ3BsR5nDbR44uEpi8+7KPZe2W72hgOLQZ3SSx
 x6tIiq4MmuIXAxI1sqloSkZuASlJbFdf5duRvAqKmk/G8ItoQj5kDwkgbtRS5lAhAy4bQVlXqS5
 6WClxMWxH0NxIOKZTBeXb+y1L4tFz3lemR434vQQVT/y3ezPBtGaLAzJnfJtNmstCU9U+GT5bLX
 KNNxu5AV8vHFFiX4fiw==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=696533a1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=oOxkhYjisp4HNluEnnYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

On 09/01/2026 18:34, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 5:21 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 09/01/2026 01:40, Alexei Starovoitov wrote:
>>> On Thu, Jan 8, 2026 at 5:24 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Thu, Jan 8, 2026 at 10:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 06/01/2026 01:19, Andrii Nakryiko wrote:
>>>>>> On Mon, Jan 5, 2026 at 4:51 PM Alexei Starovoitov
>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>
>>>>>>> On Mon, Jan 5, 2026 at 4:11 PM Andrii Nakryiko
>>>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Dec 23, 2025 at 3:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
>>>>>>>>>> On Sun, Dec 21, 2025 at 10:58 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Hold on. I'm missing how libbpf will sanitize things for older kernels?
>>>>>>>>>>>
>>>>>>>>>>> The sanitization we can get from layout info is for handling a kernel built with
>>>>>>>>>>> newer kernel/module BTF. The userspace tooling (libbpf and others) does not fully
>>>>>>>>>>> understand it due to the presence of new kinds. In such a case layout data gives us
>>>>>>>>>>> info to parse it by providing info on kind layout, and libbpf can sanitize it
>>>>>>>>>>> to be usable for some cases (where the type graph is not fatally compromised
>>>>>>>>>>> by the lack of a kind). This will always be somewhat limited, but it
>>>>>>>>>>> does provide more usability than we have today.
>>>>>>>>>>
>>>>>>>>>> I'm even more confused now. libbpf will sanitize BTF for the sake of
>>>>>>>>>> user space? That's not something it ever did. libbpf sanitizes BTF
>>>>>>>>>> only to
>>>>>>>>>
>>>>>>>>> Right; it's an extension of the sanitization concept from what it does today.
>>>>>>>>> Today we sanitize newer _program_ BTF to ensure it is acceptable to a kernel which
>>>>>>>>> lacks specific aspects of that BTF; the goal here is to support some simple sanitization
>>>>>>>>> of the newer _kernel_ BTF by libbpf to help tools (that know about kind layout but may lack
>>>>>>>>> latest kind info kernel has) to make that kernel BTF usable.
>>>>>>>>
>>>>>>>> Wait, is that really a goal? I get why Alexei is confused now :)
>>>>>>>>
>>>>>>>> I think we should stick to libbpf sanitizing only BPF program's BTFs
>>>>>>>> for the sake of loading it into the kernel. If some user space tool is
>>>>>>>> trying to work with kernel BTF that has BTF features that tool doesn't
>>>>>>>> support, then we only have two reasonable options: a) tool just fails
>>>>>>>> to process that BTF altogether or b) the tool is smart enough to
>>>>>>>> utilize BTF layout information to know which BTF types it can safely
>>>>>>>> skip (that's where those flags I argue for would be useful). In both
>>>>>>>> cases libbpf's btf__parse() will succeed because libbpf can utilize
>>>>>>>> layout info to construct a lookup table for btf__type_by_id(). And
>>>>>>>> libbpf doesn't need to do anything beyond that, IMO.
>>>>>>>>
>>>>>>>> We'll teach bpftool to dump as much of BTF as possible (I mean
>>>>>>>> `bpftool btf dump file`), so it's possible to get an idea of what part
>>>>>>>> of BTF is not supported and show those that we know about. We could
>>>>>>>> teach btf_dump to ignore those types that are "safe modifier-like
>>>>>>>> reference kind" (as marked with that flag I proposed earlier), so that
>>>>>>>> `format c` works as well (though I wouldn't recommend using such
>>>>>>>> output as a proper vmlinux.h, users should update bpftool ASAP for
>>>>>>>> such use cases).
>>>>>>>>
>>>>>>>> As far as the kernel is concerned, BTF layout is not used and should
>>>>>>>> not be used or trusted (it can be "spoofed" by the user). It can
>>>>>>>> validate it for sanity, but that's pretty much it. Other than that, if
>>>>>>>> the kernel doesn't *completely* understand every single piece of BTF,
>>>>>>>> it should reject it (and that's also why libbpf should sanitize BPF
>>>>>>>> object's BTF, of course).
>>>>>>>
>>>>>>> +1 to all of the above, except ok-to-skip flag, since I feel
>>>>>>> it will cause more bike sheding and arguing whether a particular
>>>>>>> new addition to BTF is skippable or not. Like upcoming location info.
>>>>>>
>>>>>> I was thinking about something like TYPE_TAG, where it's in the chain
>>>>>> of types and is unavoidable when processing STRUCT and its field.
>>>>>> Having a flag specifying that it's ref-like (so btf_type::type field
>>>>>> points to a valid type ID) would allow it to still make sense of the
>>>>>> entire struct and its fields, though you might be missing some
>>>>>> (presumably) optional and highly-specialized extra annotation.
>>>>>>
>>>>>> But it's fine not to add it, just some type graphs will be completely
>>>>>> unprocessable using old tools. Perhaps not such a big deal.
>>>>>>
>>>>>> I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
>>>>>> whether they are more like DECL_TAG (roots pointing to other types) or
>>>>>> TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
>>>>>> fields, PROTO args, etc).
>>>>>>
>>>>>>> Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
>>>>>>> Skippable? One might argue that they are while they are mandatory
>>>>>>> for some other use case.
>>>>>>> Looking at it differently, if the kernel is old and cannot understand that
>>>>>>> BTF feature the libbpf has to sanitize it no matter skippable or not.
>>>>>>> While from btf__parse() pov it also doesn't matter.
>>>>>>> btf_new()->btf_parse_hdr() will remember kind layout,
>>>>>>> and btf_parse_type_sec() can construct the index for the whole thing
>>>>>>> with layout info,
>>>>>>> while btf_validate_type() has to warn about unknown kind regardless
>>>>>>> of skippable flag. The tool (bpftool or else) needs to yell when
>>>>>>> final vmlinux.h is incomplete. Skipping printing modifier-like decl_tag
>>>>>>> is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
>>>>>>> though one might argue that they are.
>>>>>>
>>>>>> Yeah, I agree about vmlinux.h. One way to enforce this would be to
>>>>>> have btf_dump emit something uncompilable as
>>>>>> "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
>>>>>> modified.
>>>>>>
>>>>>> But yeah, we don't want bikeshedding. It's fine.
>>>>>>
>>>>>
>>>>> Ok so is it best to leave out flags entirely then? If so where we
>>>>> are now is to have each kind layout entry have a string name offset,
>>>>> a singular element size and a vlen-specified object size. To be
>>>>> conservative it might make sense to allow 16 bits for each size field,
>>>>> leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds.
>>>>> We could cut down further by leaving out kind name strings if needed.
>>>>
>>>> Are we sure we will *never* need flags? I'd probably stick to
>>>> single-byte sizes and have 2 bytes reserved for flags or whatever we
>>>> might need in the future?
>>>
>>> Just to clarify what I was saying.
>>> I think it's a good thing to have flags space and reserve it.
>>> I just struggle to see the value of 'ok-to-skip' flag.
>>>
>>> So 2 bytes of reserved space for flags makes sense to me.
>>
>> Ok sounds good; I think there is still value in having the single flag
>> that tells us that the type/size field in struct btf_type refers
>> to a type though, right?
> 
> What's the value?
> 
> I sort-of kinda see small value of a set of flags like:
> - this kind is a type (int, ptr, array, struct, func_proto)
> - this kind is a modifier of a type (volatile, const, restrict, type_tag)
> 
> but then we cannot quite classify var, datasec, decl_tag, func..
> 
> So it feels like it's getting into the bikeshed category again.

I suppose one value would be it would be easier to recognize pure reference kinds
since they'd have such a flag set and have no extra info. But I think at this point
we should just focus on support parsing of unknown BTF kinds via kind layout. I'll add
an empty flags field for now.

Alan

