Return-Path: <bpf+bounces-78124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776ADCFEE8B
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D99431666B7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48756390CAB;
	Wed,  7 Jan 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JHWX+w2j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CdalThCk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48F36826C;
	Wed,  7 Jan 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801091; cv=fail; b=i1zmjwqkeV9Qpqd30wNzNokuR/5Jzii+Y85Oxpw1EsWQmT+bQYENBeZmTE4GjeimKRiCwyMLu2ev+hoBvPI/t0m1HnVfPdX2twxdQon60+kCQBBr4Dt0dURMhYmGyiVDsCjltiNuj5m1YKup1WbynMDTOlrpDVGMQeFb7UQRun0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801091; c=relaxed/simple;
	bh=gkCJBjhFaC0UXTtJl1BbjcW5Sv3AZQ7VuF+b4iwnmY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NnQ9lq+XLLXb6pUKXmtJ5v4o5x3fZWUZ2ceqkoxFRPxDBXBq9cbBQdm1NTyYe4l313oGm9TUNs1n3jEVKJ6dQN8qYMAfykyoyYqv/HXh2xuOf4aQu5G5msgfD8zf6VXxV9cfiMTjdSlj/VpSufGOT6L4JyRXgkXC8vjowNYH1yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JHWX+w2j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CdalThCk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607DvMce2158014;
	Wed, 7 Jan 2026 15:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X4xFltqaMHEnrmrdXUUFp5D88zb7GWiSQ1la0KDfFBo=; b=
	JHWX+w2jjqHDJ1Vul26io6GGT5H7YxdVVEla0o/VvESDhcFb8UDZ2uN4xHmGZSid
	icGrvrdb1i4421LttPEc940twZ7lI8LmWI6Wtf7FNDEwjgkN0lac41JQsm4umcu5
	kcjm+aEzOUczntMs+olsK2FY8PELC/SU3xLFj04iw9CfbRfSieYZ8FhYpNfpr+we
	SltYYITgcA7pzpNOA9dni3izMbEaIXf3VQ5zq5huNfIBl5RIPQpQgD/SKc6DeMJF
	24MVkSUuO440UILMioQU4n8/sArhB9630h9y4LAeerwPMZOQ20yM9GtSXW3UfXXc
	Mw32Q7QqB8ZNTOI7ExjjZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhrtvr6c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 15:50:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607EGLPE030664;
	Wed, 7 Jan 2026 15:50:53 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besje167u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 15:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAgILsLLWRfDbMM5YbhR26oR5IajLnPyvehyxihaoTkxGv8o/+0ZybF7N3MpPAKHyu3L4BATRxhff4j3RF7MCIELwWV+z2pzjjikSuj8FxMvS/3PjXX9W7gR61ZY41tDSnd4hW51JGwTSxTc4pSQlsIbBJ1PqN/3Dw8xFnUokSjegWLdO6pHTgxsX0IqUhpz3qV6zd3nOhyDzinGlFdGgpiqmWYlCr1LtuuUNvmLZ8++K8LTyUmpgmslGy+3e6VPk+4PQ36wuwYW598rMU5JcF9luA2n7tdBmTuDo4mdxz/XD5NGp26pertV+a8so4qr1LMGuDTriHtx7CgyrhCYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4xFltqaMHEnrmrdXUUFp5D88zb7GWiSQ1la0KDfFBo=;
 b=uVibiA1wMBOykqrWQpZUXyeVOrsr/f1RpVhy06lWQzY6l1rBpQe3RVCM6DRrnfCxgUYdiGwPZo5J3bZmUW73L9qYkiq7IJ75oKXNqEZtq0K5Lv5FTiORb+GwLEdlDbBZaRv8bsSHO2WTyAXyVbCSWFlMtgQSAsbw08XQkzb5tPZNbMFKyxDUuKNqCTylaNDOIP8FG5Tvl+WneozPBBG7u/TDuxdDUn1v48C+bcCQNrHAnGarsAZ7KdCTIMFyQOR9qsbdyRq0qF0EpvBreypvgHvwAQJRdTLNnfxgMwIir9fx+cWsMXK/v+T97hVOorv7Ur9zdClUU+DqTZs6OVsf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4xFltqaMHEnrmrdXUUFp5D88zb7GWiSQ1la0KDfFBo=;
 b=CdalThCk0T9lRTmWx1/wUWD9n4yHM7gNo66nQOnGCBcnkmfxH2WDsac6NfwweZ/twTiiFWo3+dOOlsMTp0/71bv70oylbe2VKcmJ/lOpAwaNGvSVENRI7DMO28J8ZIMfvQzGu0WtvaX3nrK0Lk7ipmEsQN+zIlbMiscbXEkgNPM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Wed, 7 Jan 2026 15:50:49 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 15:50:47 +0000
Message-ID: <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>
Date: Wed, 7 Jan 2026 15:50:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
To: Matt Bobrowski <mattbobrowski@google.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com> <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
 <aVwihhKEszvcyNKo@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aVwihhKEszvcyNKo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c079f87-8fb7-41af-e148-08de4e048668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGtPREsxSzVQMHBjYThkY3Y1VXViOHhmSmFTR201RW8xRzhnd2tsa2tOYTBB?=
 =?utf-8?B?Y0NPYW5DN294YkpHVmdUdGNnV3JOSDZ6QjdVNFhDd1MyVUsrTW5xY2hoK3hU?=
 =?utf-8?B?UEY3L3pmQkxsOGhRT3hGOXZrNXJTQUhyVWVBTk0reUl5b1h0RTlRM1J2RlBE?=
 =?utf-8?B?akc2T25ZSWJEK3VEbmhNT1J1dEZ0YkJaTnJ2bCtXZms1Z3hJbU84cEtnUjBE?=
 =?utf-8?B?dDhUQWRzWTY2U3FDMWlsaHFqWFVEam1LZGg3U2pBMmhkK01WWVZEQ2hhS29K?=
 =?utf-8?B?SzEvbTd0NWRqK2NDTXYyVUFhVG9sL05NczdLelVmdldCQytBOGlMVTFQa3JO?=
 =?utf-8?B?MXVSTzlsYlMrTmkva1g1bjhTeUx5bXRsemFQQTNnckxQb1dQeUlwVjJjeUQ5?=
 =?utf-8?B?ZjlKYlROVVdISmtidnR2d2R0dkcyZXBSeXQrcUdCQlJYa2lSZHA0MFNXZkZz?=
 =?utf-8?B?azZrZ093RnBPYXo4YlBLN082WWljYklPY21yZlNxNzhQQVcyWVB5RXI4Q1RD?=
 =?utf-8?B?dG4vSW05OVppMGNUVkhHMWZLQjVUVjB0WWx4TGxWRTNYenJ6bjVYdFdPMytv?=
 =?utf-8?B?dUVJc0NOSi9pSUdJcUtQbmUzYWpyTkN6S0tUTkRNTkpJUUl1SEZzN2RqZ1Q3?=
 =?utf-8?B?WjhXNmN2ZE9Zb0xCVHFLZjkralR3K3R6UXlXeitYSUhjZWxXR3g0Z3RGT1dY?=
 =?utf-8?B?b1VJM3owZzU0cWI1UE9Xa05oVDcvTWVrdHBQdGx4YzhXZzB3VkprZWQxSGpK?=
 =?utf-8?B?WU1lUkFtcldsWXZsTXhNd1RZQisvdE5aRkdOTnJKRkdham1aeE55c1RvRFRN?=
 =?utf-8?B?ZDcyUW1RZXZiWmxYQmpKOFhKY0JoM3p6ZEtMbUtyZEt4YXdkSVh2N0ZWWWdI?=
 =?utf-8?B?OUZDbmhlMHpBUGRlYWpEb2VTZW1pRFJBWDJuNGpXTkRlbVdvTHgwY1VEZkdE?=
 =?utf-8?B?VUZrN1U1VmRPZFFDQXl3bGlwWVVvRjNPMWdhOUJteXk0OWV3U3FGcDZGR0c1?=
 =?utf-8?B?SFJacmpIMXRsSStmSmV6ajgyRkduNHExTHlQM2VTYmpQTmhtN0MrYVMxVUlN?=
 =?utf-8?B?OVZGWlFVZzVzMWEreWw2ZjhuWTdHU1ArRWlNaDhQclU5WHFYMnVPWGNZV2x4?=
 =?utf-8?B?YkpPR1hSdWY3OS8veHI0akJVSEdtb0JHVUEzMHJyU1ltNGdkVFhsYVdBOTNO?=
 =?utf-8?B?U2I5Rks2WDBBMHU3WkVJbDNoMWRmN3R6NFl1RGFwS2lxNTdBOUVsZnJ4T0pm?=
 =?utf-8?B?ZVdJbGZUV0lGRzZucEZueG1ZS1h5NU10bTJKK01OMk10QVgzYzlHbWtxU1pH?=
 =?utf-8?B?QktiajlMQ2ExcjF2M0xEZ0xCRVhOQjRMeW1RS0Y5MXd4N0Nrc3NyS0pWV3lX?=
 =?utf-8?B?emdQNzRuM2s0eUphVmVYbU5ZQ3pJZ0xqaXJFUUlpaHdoTTZ3QW9NeDNUYjFM?=
 =?utf-8?B?S1BKYk9leHZ5c0x3WHArVUdZVTZtMVAwTTF3L2NhYUkrcE9QdUl4Skxvdnh6?=
 =?utf-8?B?eEt3cUFzam9KNHhZTVlsMWsycm1nak96RUxLTVpEUWtGZkhOb2xvUTN0c1d0?=
 =?utf-8?B?aG9wZ0JqL2JjTkRZQS9EVlJpQTBXZGJ3WmFhWi9ENmdrNXlPdDQzb2FFUEcv?=
 =?utf-8?B?YkpNdVRrUERUcWdwRGV0QjhYYmo5cGtZcjhqbjhUaWNLcFdOaGlNMEwwUUxY?=
 =?utf-8?B?UnoxSDJzYit5dVBDRHlreFAzTXNPRjA0RVZSN1RmWnhqT3o2Wml6T0V2TEU4?=
 =?utf-8?B?L0tKV3A0Nzl3enh3MmM4WWt6bGRGdTNheHdvYWdhcWpCVDBZMUM2OWI2eEFs?=
 =?utf-8?B?TWwyTjk3dkQ5aUQ2TkVNaU5qS1BRamN5eXdybHpwbXEvakN4a0RDaEVzd1NO?=
 =?utf-8?B?Qk9xcWpvSWt6VGJqdElySjdzeXphcHp3T1NuZ3o5VEEzVXVLQ2ZLTlVGRnI4?=
 =?utf-8?B?bGJxRlZidkVoQnhYUzQ4Mmc5LzVzL0VHZGhVVXdpWUNPZjB2Q01wMitjenhi?=
 =?utf-8?B?Y2I1RWhGNjFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tkp6NWY5bmdXU2VUbWhPRGVnWG83YWVCQjFiQWJEajdRRXgrQ1pvQS8ybDUv?=
 =?utf-8?B?R2c4MmovbUsvSGRlczlZK0lFclRybnhqYUxvNFJWQW0wekkzalR6cktabjdM?=
 =?utf-8?B?dWtxbXZxRXpKUDZjTWFlL1lYV3RhVGswQ0NIN2xRMmFzY1VlMDhhNXRMSVVr?=
 =?utf-8?B?VC9tU2UwNWhMakx5YmNLU2JZdnJGK2dKTElnZGg5SVNIaWpZc3VQVURFMkp5?=
 =?utf-8?B?SWp6Sm9HcDB2NzFWOHgrMEpxTGg4Z2h4RTdPMTRQdDRJbS9wcWFsbnRlQmRw?=
 =?utf-8?B?TTI3YmpSS1M0eVJGenU2bWUwT3JWNFQwaldxaG10WVlGeENwOHNPc2FEeW9S?=
 =?utf-8?B?NzZNTW04M3dXMHNWVkJZSXlpWi82SnRtWUIrSVAwbTNrczlZYnpSaGp5Z3NV?=
 =?utf-8?B?c0dpRUc1UDMreHRZbVJXajN2aWJtMkczUG5PbGlGaUhIL1h3dDlrdWFTTHM1?=
 =?utf-8?B?MUZEOEVWR0E4cFZWTVMwWjVybFpBUTNzbEVPb2tMTWRDdXdEZGlLblpmUkJP?=
 =?utf-8?B?Z0dwMWtaaDJqY1U0NlEybnUybVhlNE1scmVRc2lTcDMyUWFnWXVyMlZWS3E3?=
 =?utf-8?B?Lzk1MnFzbDRRSjlKUTRBcDcxaG5Ha3llNklyb1ZHNFQxYWIwYlNWTHJaOXFy?=
 =?utf-8?B?c3NYcHIyUUJyNHJXbys2NWRGTHFtOEZTdEpvbDVmb2p6azRva2JTRnNsY05z?=
 =?utf-8?B?OXgxSDRSaHhzUERPcjd1TWE5bUxqekY1R09WSzkzZkNPSndTT2RCVTVYMU5j?=
 =?utf-8?B?RmV2THJhSlhxSG1MSHg3U09BcWhSY2dBUkU2elNyREVBZ2ZCTFJoSVQyb3hu?=
 =?utf-8?B?V3UycmlFRDZ3bjFxbS9rbmtRZkg3MkVvdEw5RTJsK253UWd2bnZBUlJmZXYz?=
 =?utf-8?B?YTVtTTBVakRPWU9hU1kvbngzeXROQTJWSjdmUmFsalRaTW1VQ0ZhMVRQWk5J?=
 =?utf-8?B?U1ZhemphL0RYV09ybHgwSFh0QWpBdU9Xdi8rVmFuUUVrNGROUXp2U2I0ellt?=
 =?utf-8?B?bWtXNmRXb3AwUkJVWUJYTDZ0OG9ZdXJVQlkwN3VkN0RqZXc3TkwxKytoY0hF?=
 =?utf-8?B?Ui8xWGQwMGxUZjBJTVJVUjMzazFqZzEyT3YrQ1diSXJjeWI2cFNOb3BKVHhV?=
 =?utf-8?B?QlcxempwOEpTeTFTK282RGV4NHFsRWg3M1hkSmYveDhSVElyUEQxL1RSekxP?=
 =?utf-8?B?bnRZNlIrWnJXVUtibXhJN1V5ODhxWDVMZGZ4eFVBYzZydzB2bDcwdGtZV1o2?=
 =?utf-8?B?ckV5ck8wRDNDcFVIN2FDWXM0WU9mSlJWa1BsOXpPcVNVVzdicGdDNXF0bnNV?=
 =?utf-8?B?b1ZDZlFKMWFVRkVaS3k5ZTVJVGlKZ3RmTkREbTYrKzB6WmNSbC9RS3JmcWhX?=
 =?utf-8?B?RXRUVVN1Y09WNVh4MHV0Wk1iS0grMHF0Yy9qVXdMVDRNejZEcjZyZDlzYWhC?=
 =?utf-8?B?THhBQnlaM1AyMUZibnFFUjBMeFVITDRRWmVmdHZVMTl0U0ZVTnQzSWVaTWVE?=
 =?utf-8?B?ODlWS05Va01uY0F6czdnN0ZDdjVzemU1WEZhdlRSQkxER01PazBTRFRUMEJ2?=
 =?utf-8?B?cUxWR0h5MHErWjR6aS9VWit1Y08rZ3RzMVZiVEhUOEw4aGhFMVNDZVc4UVU3?=
 =?utf-8?B?R0FNN3lnM3BkclVFQ1N5dFFwdk9Idk5Za2MyNnhuak0wZW1MdkpmbkVKT24r?=
 =?utf-8?B?YUtGQStYaEJMSGF6NSttZ2laK3NoNmMyWSsySGVOQzFpb1gzZ0JHeUVCeXNn?=
 =?utf-8?B?RDNqTG9oZGM1RGljTzBtNzhIVHdsU3dvV1RML0VBTG9XVUUyS3Z5d0N5eVJa?=
 =?utf-8?B?YW50Umd2c2VhNDRKbUZ2dHpQLzJ4UURWUDRRZlZieVNZdnJwR1k4MDE3NVhI?=
 =?utf-8?B?cnJwTjNPQ1hLRFhETXVmdnBGc0FXOXdlWXlWcU8zdHQ3b0Vic29oS09OOVNy?=
 =?utf-8?B?YlBwL1VhTjJBdDQwM3FVempaTmpqTkNpM3BuMHBiWEJlM0dka3JGQVpwcmts?=
 =?utf-8?B?SjZtSnBsdUVMck5SRGtQZngzSXFNVC9DYTk2VkJMQnMvMm9zZEZCMzlKUWdj?=
 =?utf-8?B?U01IRzJhNUE4T1NHcFB5cVdCclp0YmN0MWMrSGtob0d2bjZHMTNRVmM3bVo2?=
 =?utf-8?B?elRRSUIrNnNNQ0prSmxKdlVURzVHZDBHcklSdnlwVjZiWVZJdzFodFZZelBw?=
 =?utf-8?B?UjRuZ1BRWVN6WmhrMERPUXBMdCtWYW9JdSt6V0VTVjlTN3NTVng2QnZlSjdK?=
 =?utf-8?B?V2dDNHFWM0FudTZ4TllOdHc1TC9hQW5LQjRJVmloTmZteDhFeWJaYXNZUzB2?=
 =?utf-8?B?djEyRWhwYkpOZ2JxOVp4V0pQSmQwYXpPNXhtWTQydStYdVMzdFZuZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rZ+J13mKYeRBxp3cVCBnqLG8qezod9YOCqeuOIQyzlfqZ3EIoBrdKG/gflU01eEV0YmzC0gEMpD7E0dFtKe5sLNL4lXtHNLeUL2XDsqqk8hmN2mswFuuQhti8pEAVLUARfqaPV9r4UJQ/1x+mZAkTildxipGX5WD6FADcoxplBc98RCKwOAhYXg57WymwDidnDTroGZCmwchalPdzsLp/J/0a3rKD6LZT/o419AJF605LGh1Q+ktbSOy61HP3W9twuYaRnE8alOKKdPBIKzZePaYd0j0cM1N8umuyfpVShztquWmJCl1YXjS2zhHwGDE9POIke8m6ttkDesudMng1eK116xe1w4eUdL+xsg14i9UW9f3wsRxj2ry8+rGDq7qP14/HRXZAh9l7lR88IteRaG6paFuoTi3n54NpHFpBaJHHaRHYoB6o87P+xNQDY5/SfDc8aD8XCGsiL+s9J2RZGxNTrzAg6lyQJmv3UkPSlGQ4KI1//0h32+jer2rtAR0wpLz67b05JIqm5JtCwFaPnt69lPqghNX3C11L1cCVpIMQir5hm5umKtQGga4D4MVNHmDxMLdVUJ8ai2pYZWivzQQXMJtf+Mif9rMGTIEd7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c079f87-8fb7-41af-e148-08de4e048668
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:50:47.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGGT+VRsbFXfREQwWor0FrTew1HQ97V+P4SCs/N9FIfTqi0bS2mjgRmC5iE2Wf3RxcPRvFaPZIIkB87aCqn6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070123
X-Authority-Analysis: v=2.4 cv=bfFmkePB c=1 sm=1 tr=0 ts=695e80de b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=NuCc1AyGcG31WA4rG1kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: R9o8O7iXsANRaG4-OwpczTJnhvElBILq
X-Proofpoint-ORIG-GUID: R9o8O7iXsANRaG4-OwpczTJnhvElBILq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyNCBTYWx0ZWRfX4KOl3rYfNaRQ
 CyKahVCSRl7QD9riBCAArlAYCQ4hhRbDun0dLJ3qe760z9XWZlXqCoBhnMnFaoPZFwKTBFUB3JT
 5OeYhgGz9b+NT/pAUT8CD/Un39C1TcMOp3Q3hekvIBpwWMvmLMNnmk+sxktlwj/pRKN48T0iywg
 +B4FMhbTgl+rNdoakUHVeCGsFnL25ZCUczOSxO2cQln650JRRuSO5NZrNj4p5h+gqlg/5p6n3FY
 7nuaVBI/9eiO4MrEE2ZNvMreVpWISG6ldSegPpy5m30OTQKBC/X16A4msJ0AAwagPeyAe0eVcIH
 bv2rf/+1UGNgwp4WDpPa8agB7sYHUyWTbKzea231QMry8zekZDP9P548BI+znAuW1n1ylvCVVuf
 7Y9p2Iul3zslNSpqayM4UIk0OCGVJvzQjU4pfr3XGSJ1+4XYcbNF5NPc4g2tY3S4HEd7eBn2aLi
 5rvSdlbqdET7JZhu12mmuFRkBI+faWz/gpcMeuAY=

On 05/01/2026 20:43, Matt Bobrowski wrote:
> On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
>>
>>
>> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
>>> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
>>>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
>>>>>
>>>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
>>>>>> Currently, when a function has both a weak and a strong definition
>>>>>> across different compilation units (CUs), the BTF encoder arbitrarily
>>>>>> selects one to generate the BTF entry. This selection fundamentally is
>>>>>> dependent on the order in which pahole processes the CUs.
>>>>>>
>>>>>> This indifference often leads to a mismatch where the generated BTF
>>>>>> reflects the weak definition's prototype, even though the linker
>>>>>> selected the strong definition for the final vmlinux binary.
>>>>>>
>>>>>> A notable example described in [0] involving function
>>>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
>>>>>> distinguished only by parameter names (e.g., file vs
>>>>>> file__nullable). While the strong definition is linked into the
>>>>>> vmlinux object, the generated BTF contained the prototype for the weak
>>>>>> definition. This causes issues for BPF verifier (e.g., __nullable
>>>>>> annotation semantics), or tools relying on accurate type information.
>>>>>>
>>>>>> To fix this, ensure the BTF encoder selects the function definition
>>>>>> corresponding to the actual code linked into the binary. This is
>>>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
>>>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
>>>>>> definition will match the final resolved ELF symbol address.
>>>>>>
>>>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>>>>
>>>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>>>>> LGTM with some nits below.
>>>> Thanks for the review.
>>>>
>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>
>>>>>> ---
>>>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>>>> index b37ee7f..0462094 100644
>>>>>> --- a/btf_encoder.c
>>>>>> +++ b/btf_encoder.c
>>>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
>>>>>>    /* state used to do later encoding of saved functions */
>>>>>>    struct btf_encoder_func_state {
>>>>>> +	uint64_t addr;
>>>>>>    	struct elf_function *elf;
>>>>>>    	uint32_t type_id_off;
>>>>>>    	uint16_t nr_parms;
>>>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>>>>>    	if (!state)
>>>>>>    		return -ENOMEM;
>>>>>> +	state->addr = function__addr(fn);
>>>>>>    	state->elf = func;
>>>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>>>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
>>>>>>    	encoder->func_states.cap = 0;
>>>>>>    }
>>>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
>>>>>> +									  int combined_cnt)
>>>>>> +{
>>>>>> +	int i, j;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * The same elf_function is shared amongst combined functions,
>>>>>> +	 * as per saved_functions_combine().
>>>>>> +	 */
>>>>>> +	struct elf_function *elf = combined_states[0].elf;
>>>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
>>>>> This will match the case where two functions (weak and strong)
>>>>> co-exist in compiler and eventually only strong/global function
>>>>> will survive.
>>>> In fact, checking again I believe that the loop is redundant because
>>>> elf_function__has_ambiguous_address() ensures that if we reach this
>>>> point, all symbols for the function share the same address. Therefore,
>>>> checking the first symbol (elf->syms[0]) should be sufficient and
>>>> equivalent to checking all of them.
>>>>
>>>> Will send through a v2 with this amendment.
>>> Hm, actually, no. I don't think the addresses stored within
>>> elf->syms[#].addr should all be assumed to be the same at the point
>>> which the new btf_encoder__select_canonical_state() function is called
>>> (due to things like skip_encoding_inconsistent_proto possibly taking
>>> effect). Therefore, I think it's best that we leave things as is and
>>> exhaustively iterate through all elf->syms? I don't believe there's
>>> any adverse effects in doing it this way anyway?
>>
>> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
>> is 1 or more than 1. My previous suggestion is to single out the
>> sym_cnt = 1 case since it is what you try to fix.
>>
>> I am okay with the current implementation since it is correct.
>> Maybe Alan and Arnaldo have additional comments about the code.
> 
> Sure, sounds good. I think leaving it as is probably our best bet at
> this point.
>

hi Matt, I ran the change through github CI and there is some differences in
the set of generated functions from vmlinux (see the "Compare functions generated"
step):

https://github.com/alan-maguire/dwarves/actions/runs/20786255742/job/59698755550

Specifically we see changes in some function signatures like this:

< int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int type, int flags);
---
> int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags, int type);

Note the reordering of the last two parameters. The "<" line matches the source code, and the
">" line is what we get from pahole with your change. We've seen this before and the reason is 
that we're not paying close enough attention to cases where the actual function omits parameters
due to optimization; that last "type" parameter doesn't have a DW_AT_location and that indicates 
it's been optimized out. We should really get in this case is:

int neightbl_fill_info.constprop.0(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags);

So it's not that your change causes this exactly; it's that paradoxically because
your change does a better job of selecting the real function signature in the CU
(and then we go on to misrepresent it) the problem is more glaringly exposed.

The good news is I think I have a workable fix for this problem; what I'd propose is - 
presuming it works - we land it prior to your change. Once I've tested that out a bit
I'll follow up. Thanks!

Alan

