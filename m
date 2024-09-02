Return-Path: <bpf+bounces-38723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8F968C9D
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 19:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FBF1F2328B
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4A1AB6DF;
	Mon,  2 Sep 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azxlDkmF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rb0sfAn2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D31A265F
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296524; cv=fail; b=sCKI0p3lTmH/IPIc0OIDwGyIEcOJ3hR/kOR8ZMaqIjlYYBvNS7rK1mWzeLY0k4iv3B279AIPz9Tz56TxW6h+GLMzARD4iq0Mq5wkRTDA6dAO1U86Y8Pc5xn8hch5eJR51Ny5hEsKvCm3TEcLjPbszTLrDJmW++jbATeLq2esfw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296524; c=relaxed/simple;
	bh=LEXjV0hfP+P/sgsUAPmHjW5lHmZF0qAHDkgRiKCexc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPsXG0qjS1dJK1HiurlbApEHjUy+9xcJjVtoKbM0R19R+taC9kudWvrGo5B9xOIjQwvmKfanNq/uDU9hGBzD82wJq0PKmisamlKFLBWZub5rdhcyiYLonBMTlhoBpesUb5Ey03Ir1dTdDfMBdME7DSNRVOS/8gVCRyLPBDnO13I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=azxlDkmF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rb0sfAn2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482D9nIm011970;
	Mon, 2 Sep 2024 17:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=bDMUfgU4Fd2HOwtlAV5ZJYBh7Fw89cRIKb215yvaAOM=; b=
	azxlDkmFYvlKADVJqrtuN4pfDtnR6eJnsjlRFUyfEjoSl3sgBdHA2JNMTVIdRf49
	kQ/ayR1lmeEwiVfuOB8XxpIfI497vlIc5v3zdD9FrCw6dtGSMskLzCz6k+99IvyW
	Iyed/ATVo+4vaBxzpSFixC08f1vKB39BdOZY17egi2Y6NwdLg+bCY2N415ECy9sB
	KcUhteFdGcgwh7lawE4VF9qurrd061ZIgbGDlOUwizbBiCsSe490D99So6PTZp0H
	aWX/k+s2i1Vn5J4ZS51BITb/D7vd6D8aMXMLkqlzk8z9toYRGt5jSPi6/a9RRa4J
	LYIc+MBzpg2649x+kxgBgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dcth8h69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 17:01:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482ELXJC039526;
	Mon, 2 Sep 2024 17:01:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm7uk4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 17:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOefs2CUO7FKCY0W+FOEzDk4el59PmB/Ka+BtezRrlATFGOQVRb8Egk2FTeix+9qA53oidi4q9NXffldJRXUF+BQJi5+pk3wX9O5sDYdvwdnfIYJWF0sWMVN69tlBZbNuQO76w4oswAduMpV5xLb97pH1wLOfvwwl75vfTWHvfdEpwCQ4d711Ovn74DRTCOfM+TWaV3dJaBedRQZHQPbtD3HCZ5bJ5vz/B+yA4LLsl/VmLuyvprgBUf/Y0QbpRE5yNG3mfGFGjqmc1HkYA5m5agLweAn3LlqZ/g3zLjKEcfc/WaQj08QFbJWv2atH3U/yp+WJzsZcC49WUo0Dznhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDMUfgU4Fd2HOwtlAV5ZJYBh7Fw89cRIKb215yvaAOM=;
 b=ptL7q5zaQSTlno6EJ89ZhSkRlAJdKD7A6C9Chgk7tfrh4Lzo+/XQ1AOtZ6zRhNF84u0uz23xQar4Gk04Zojxc+KPB1DXF9IrxTt73aCkSfKayY3Gr8h+hZzmx1VyzXe6nvnUyap0XqoSRu3lyX5sqciRTqundzfepk/u7TFBAPtXPpVmOWSovoLaKVJvI0b1r/K44iuPvlD7KeQtuq27MKL1GiJFKN119rGXt9DE8EWH4W6/Qszi1hKiICYQKZRBl2ZNfGv014ne9lszytzuBYTTmZhDQXp5qb9wV0f8df/l7+r/N2A0/KKHQBfsbHyfZo7XX73iRrKBWb7Djct6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDMUfgU4Fd2HOwtlAV5ZJYBh7Fw89cRIKb215yvaAOM=;
 b=rb0sfAn2Mx2XtP+Y9rDkq+/Jb3wGMbqTTufuMrtpEHykZnQ8YP+LGnPRqpHsDC9B2BhUCMHGqTFroWPZ1dRwWhb2E/8Lj1URGEigX5E2lccRLZ3LiGr5yifp2RfJOIoDMfKW3P6Iwyynw98Xp37j0mVryb6X6vXRjq21bjoa0lI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB7852.namprd10.prod.outlook.com (2603:10b6:510:2fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 17:01:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 17:01:35 +0000
Message-ID: <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
Date: Mon, 2 Sep 2024 18:01:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1725016029.git.vmalik@redhat.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <cover.1725016029.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0645.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b28deb-92d3-48cc-a623-08dccb70e6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXFiQXE5QmV4SDUyc2xyOU52dzNKZGg2eFF4SU13Wmhwa0dJOFNRNFBlbDQ2?=
 =?utf-8?B?MVFOcFljWkNPbythdy8vS3JsZGwyNTBDV29kbC8zN0pGQ3NzeVd2eHZ3RFB4?=
 =?utf-8?B?amZPY0RZeW1nSDNOcy9aM0ZaSXhyVE1lVFVvZWk1ZGFxNkRNOXNETmJZWkpI?=
 =?utf-8?B?c2xBSDhuNTdqSFltTUFnaUk2U09pblFiM25TZWQ1YTBsYVMvb3hxVE9nYWl2?=
 =?utf-8?B?SG55bVpKZThJdnVCcHk5clhETDhNYk95cmg2MnBRcmw5ZCtZV0ZHeUphZ0dv?=
 =?utf-8?B?OEdKbWNtSmJsdkI1a0dzZmc1L25mV3lFbVVyQnQ2ZGExUmNtcFpmV3c1czBD?=
 =?utf-8?B?YTAwOEdGOGNUcDN0TkZOL0JzY3l2alA2NGFnU2VQOHhPUTFyWktCejVtWW9K?=
 =?utf-8?B?OERqM0xWTFNoN2xEd2tiK0JmdmZHdDI5NWJ4eEo2NkNDRHhmWVdaT2xFQU5G?=
 =?utf-8?B?T3RyRGRGVE1aR005OEJpQlozS21IQlpMQzFTWFhDd2U4Z2loTFdzSloyc3RM?=
 =?utf-8?B?aVI4bUx0RGo2eDMwTVZRNkVtVWN3ck12dlQxWEVhWFN1cVpmaWw4cmtZUWFT?=
 =?utf-8?B?ZTBCa3hMZzB5U05vZGw4ODJHMTNmZ2V4OFZ1c1BZaWp3cytPVGp4cmFzaERm?=
 =?utf-8?B?STIzSUNmTjIvZ1pzbWcwL0hJWkZKZkdqZWZiNDVoY0VDSDlSclJpb1ZWK2VQ?=
 =?utf-8?B?bXgzaXZmbWhhcGIyY0pWbm0yeUNJOXhZQVJGK2RSWVJxam8xWjlDK3ZES2hX?=
 =?utf-8?B?T0NEUmtxaDBrVUhoaTFTUHJ6Y2wzVyt4ZDRHcDY5U1lkUzRyNTBPR1ByYkJN?=
 =?utf-8?B?bEFxcHd0SFpFVWRDQ09WZWNXR0xINjNLa2I5QTdHdiszZVRwbWlRUmdUbWNK?=
 =?utf-8?B?SnhrRGMvSjd2azdJZHllWDdsdlVMbXpVdEdSWEpuNjYxWXpuWkN2RXJZN05H?=
 =?utf-8?B?UmRxZGRCZDRwSktEUXp2TWg5ZUJiQVd0b0h1elY1S25PdTBqSzE4TG5vTFI5?=
 =?utf-8?B?cEo4WmF3MEdjWTE1NzQycTJlK3prZllVUGgyNkFNU1NpaWNNUW5rVkdveE5x?=
 =?utf-8?B?a3dleDVRUFZLT3p2Yld2RFlLcnNNUnYwYnhiWm1BYlZvRXAyRTFWL0R0Y2w3?=
 =?utf-8?B?azFBRjV1OEd6Smh0aE81MWozVWkvVFNwRHAwV1VIUkNscjR0ZUFGaU91d1Ay?=
 =?utf-8?B?UklqMWMxRW54Qzc1V3NPSGNZVjRjRFBSNS82RW9ISGo5bjdVcHpUMEtzT2lp?=
 =?utf-8?B?SnJLajVadHUrdlhiSi9CN09pRFhhcEQvb3V0TWF2aEFDZkNNaXhyVmVRUkZY?=
 =?utf-8?B?YzNkQVViZHpObjZCWEFZajRFRzlUZElhN3gvaVNMYlRqRUVhSWZ3UFZTM1Bn?=
 =?utf-8?B?RnVKMVNKbmlOUU1XMGNXSnVZektCek1FdFVVU3NPRmhHK1VWQUl2cTlkYzZE?=
 =?utf-8?B?eVhwMUJqeGNBbCsxdThEZWxyWTBEcnVRRzNib2hJWmY3NXNhWXdNRVVCRC9t?=
 =?utf-8?B?YThFR3ZJeVQxTnkvVG5ZRVU1QnpLQWtjV2lqYTNkN2dyM1luemcvQmIvbXBu?=
 =?utf-8?B?NUxZSTlHL3J3dGIrSk41ZkM0QVhEaWcrTXJVOEkzT052UkNkajRHcDhTbUhw?=
 =?utf-8?B?UWxhcGRyM1pXYnJlYVlLQm8wdG1TMTF6V1laYTJvUDAxOVJFMkNZcFY3RlVJ?=
 =?utf-8?B?b3BqTm93dVlWVkw5UHNVbU12a1JhVGhmQVdJelZYK3BZRloya3pBTVdWZThO?=
 =?utf-8?B?S2duVTUrMlhydWxDcFVEdFZjZjNpcXdzeDYrZnJHWThiVTVPSVRwUTRRRzlh?=
 =?utf-8?B?emFNWjQwWFlGUUxMODBqZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENDNEU3SHZsWWgrYlI4T2hrU2drQnRtSkxRMWRyTTJtb09GbEtSclVmSnZa?=
 =?utf-8?B?Y2x4SEZRd0h1d3lDbFE0TlZVdkkrN21XVGtxWnJtb040SytEdXB5Qi93TE1N?=
 =?utf-8?B?Z3hRZVhtc3JpQ2dzMjJJTzcyVzNpZFhRRmk1SDJNNlBGdysrS3dCTjhjSnJX?=
 =?utf-8?B?dTlPbi9zYmp5NGRtNFBabjZCRjVrZDhsUHVyUXAyc0s2RWVlWHgwTzljMnFz?=
 =?utf-8?B?UTA2WWlIb3lyZlNEMllva3RHc0hqVjREQVFjZytFZHNFbTk1V0JabXNoNk82?=
 =?utf-8?B?S3l3aHVSWi93VkxWbytSYjNCNDNSUG92d2lvdy8yMGlsV3ZtdC8yRTMzZTIy?=
 =?utf-8?B?THlFeDliOE9nTVVyVjljN0gxTWhueVozQ01iTnZGTEFGWVVMRXl0QWlmSHV2?=
 =?utf-8?B?YnFOZUMwTzI3YzlYbklmeEx1NkhCU2hvam5QcS9wUm94QXZxNFhOcTdQS0I1?=
 =?utf-8?B?c1BQRTZrbFJYd2FaeFhwQldkdjA4UzNIb2hvcURyWStXQmJKb0h1ZHZ1ckxh?=
 =?utf-8?B?OGdFdGVwV3paQjd6QU9PZTZQUHlkNFhzYkxXbVhCSDdyRU9wRVdQZTlEL1BS?=
 =?utf-8?B?clpyUmcrTGZ6ZUdGaHd5alVaVktCb0YxUk80eVR0TTdlSUd6UUtMOW8vWEx5?=
 =?utf-8?B?OEN6SStWb3BtaFNtd3BIWU0vMU8rOFFiTUU5eGUyUU1qZkhoR0lWTmR3ejFV?=
 =?utf-8?B?ZXc3V1k0czc1Q2l6OU1TSzFhK1VhbTJ5eUt2SmZaTUNYTXZpSVdwNG8ra0ZC?=
 =?utf-8?B?NkV4ZHhVQXNORFhrNlJMVXZUbmdjZWRkZitaMGpFQnQwUGVQK3dTcWVnS0ZT?=
 =?utf-8?B?U2VXYUtybHpWdXo5bDZTa3dJQ2Y0MVRKWDhGN0JiOVpKVm5sYnp4NDlVMWor?=
 =?utf-8?B?WS9tMFVyKzhaOXl0cW00bjB6MnRWSTNhQW9sRDdYZ0pvSkV1RnpyQWxRaFc1?=
 =?utf-8?B?N3BwTFdlUnlzd3loMExSUzRaRzFyWE5wT1VxTVljcEJ0Wm5Oa1BMVEhQNXFY?=
 =?utf-8?B?cDVsVTJEY1lYYUFaU2lxc25vQmZiRkJlaUwyUFkxcy8wZXIyMnJoeVM1SEZE?=
 =?utf-8?B?YnNOMnJrOXZ0eUhkQXRUWXNtMUJDVE9wMXZib0ZYaEhRQ3h4dGdzSWt4WkFa?=
 =?utf-8?B?c0JlL2t3WStSUytxanVheUxBZ0NRNmpDTXM1dDVja1BVSmxQaDNXSGZNNEEw?=
 =?utf-8?B?TFFhdnV2LzhNUHdyemhXVVk0NENScUo5T1I1S051aW96ajJnZVM4TUgraUIy?=
 =?utf-8?B?a1BjMFBsT3pndGI2dmNwZ1FkR01nbW5HM3pxL1ovTjNKWEd4STRvNmpMVFdC?=
 =?utf-8?B?eDFVenhoVHVRdHZmQmh6dUZMT29xK2dGbjdzaEVHZFRDclNsQXpoZkIySjYv?=
 =?utf-8?B?cThqUWVQaTZVZlN0d0pSMXYySjRDbUl3NkNIbVo3ZzQvTVR4c25FeHFzTlVU?=
 =?utf-8?B?QjZPUmpoSWlWTGlkYXRYOXo2cXU4S1RZbUVKRTR2TDdHNVpFWnNCSjYwUEJU?=
 =?utf-8?B?YUJvd0ZpMmlkVmZIeG53ajl1NzlGWUFIMzNONDhiQ3N0aVpJeEoyZWduTmty?=
 =?utf-8?B?WStPT05SWmdoSU5wZ1JtdDNUbzFNamwzTTZMRndoWC96ZGtGQUZiZnc2VmFa?=
 =?utf-8?B?dTZFSUM3Z3hTQWcxbDlzNjEzeEhOTG5OMG85UXVoTEVjd0hSbWVETGg0bG4r?=
 =?utf-8?B?bzlyb2haaktjblZlRXVCSThTM01Pc2pLdGt3eDJYT1dJTTNwR1ZYcXRYUSs3?=
 =?utf-8?B?eDBRQUp1ME1WdDRuaXVhQkJ0NStBbHJxM2xZdVBtRDZLUTBSWE13a1ZGNkc4?=
 =?utf-8?B?d3pRZ1JLUHlkaXp2WFJGSVBKREVxZHlwekczUEZWazZ5ZDVtMUkydk92Qmh2?=
 =?utf-8?B?eGNYK0JLaWRBRHRXNm5HMExFUHNZeWRWcncyTzQ2SUVrS0tpTkRlZkgvNEZu?=
 =?utf-8?B?bm1XM0lYL2R2YjhOZ1RWRkZCMWN2NnVVeFluNHkrTnRMWjY4YklnaFU1cEJj?=
 =?utf-8?B?ZlhYZXkvSERYT0tBZlJQamxZU1pEdk53dktKUkdqK3VWKzI1WWJ2c2VSZTFR?=
 =?utf-8?B?aFlEYjVHL29hR1YwK082cVZKVDRoV2xsQjNCUDduOUFWUnMyYnJta0E4QWdJ?=
 =?utf-8?B?RjBJalFzWW1kTnZ6TTA2MnhOSEpscEx6UWEybThBWW4wMDZPdWdBeFNLeG9J?=
 =?utf-8?Q?Lr7npMFRpmY0/WYUrvzmsdw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q0j6rq1uOF84mISsATRxtHHk3Z8FoflbdqH3554KdK+hQUEylX4FfYHakE2/QL7DkLw0xGxWPi0T1X6WXPtqMasU3DMHl5mH0368WQYmBeEOJex5ar+8f0G0vEEfA0sNQSeFRJr8DTKEUdGEHikZzO7pGs1zQqUBby0BWuIUNPwlFcANge9bc6q/feOhPPYHFfkbF238bpeMvcGYUCNAhDOjrDR5eKhoQOICA8YavFFV+L8TrRTqs4uqCAB7EzxDsG9Z3aPZzpggL/FTrUDN/bN2JyUjta/LspRJb8c0B3TUG5IqoOXleFaSG3r7Bg06tuM9UdRsvCxglf07qcd9jplY5N7sBcfWblFM+Agjp1b+XxDrgPnMWA30WptxASgElw3rcjLxBZTkKQyWlf0ZO0zmcFvaOYHnHsXWSL94WSVY5T2cQSR+AaTbq1h6vEyvzEqDE4XKjT2GkrbtYUNO6JwIvqr52DO81xJj3Ierv3q9jlelENXj8MFALrPSofZWi3yW62ETt0B5y1mqvhobmkM1Ht5wsJhyi7IlMq1thjhy/IUB88eFU/TDyhOaJw/0l5c4NPm09lqjwbbrgQ7MiZm3GPDO3/7oMhzn9J08tX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b28deb-92d3-48cc-a623-08dccb70e6be
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 17:01:34.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OBWc6B7/TxxPTC3CfGdCKXY7XuSP74iIE4CjbJtba+PkvG/nDe+/dkxpzAqKVQP4jrCK9vWyZB93enoOlrAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020135
X-Proofpoint-ORIG-GUID: pCMl1Wtav0bxPV09aeEWyi3JvqkFH69c
X-Proofpoint-GUID: pCMl1Wtav0bxPV09aeEWyi3JvqkFH69c

On 02/09/2024 07:58, Viktor Malik wrote:
> TL;DR
> 
> This adds libbpf support for creating multiple BPF programs having the
> same instructions using symbol aliases.
> 
> Context
> =======
> 
> bpftrace has so-called "wildcarded" probes which allow to attach the
> same program to multple different attach points. For k(u)probes, this is
> easy to do as we can leverage k(u)probe_multi, however, other program
> types (fentry/fexit, tracepoints) don't have such features.
> 
> Currently, what bpftrace does is that it creates a copy of the program
> for each attach point. This naturally results in a lot of redundant code
> in the produced BPF object.
> 
> Proposal
> ========
> 
> One way to address this problem would be to use *symbol aliases*. In
> short, they allow to have multiple symbol table entries for the same
> address. In bpftrace, we would create them using llvm::GlobalAlias. In
> C, it can be achieved using compiler __attribute__((alias(...))):
> 
>     int BPF_PROG(prog)
>     {
>         [...]
>     }
>     int prog_alias() __attribute__((alias("prog")));
> 
> When calling bpf_object__open, libbpf is currently able to discover all
> the programs and internally does a separate copy of the instructions for
> each aliased program. What libbpf cannot do, is perform relocations b/c
> it assumes that each instruction belongs to a single program only. The
> second patch of this series changes relocation collection such that it
> records relocations for each aliased program. With that, bpftrace can
> emit just one copy of the full program and an alias for each target
> attach point.
> 
> For example, considering the following bpftrace script collecting the
> number of hits of each VFS function using fentry over a one second
> period:
> 
>     $ bpftrace -e 'kfunc:vfs_* { @[func] = count() } i:s:1 { exit() }'
>     [...]
> 
> this change will allow to reduce the size of the in-memory BPF object
> that bpftrace generates from 60K to 9K.
> 
> For reference, the bpftrace PoC is in [1].
> 
> The advantage of this change is that for BPF objects without aliases, it
> doesn't introduce any overhead.
> 

A few high-level questions - apologies in advance if I'm missing the
point here.

Could bpftrace use program linking to solve this issue instead? So we'd
have separate progs for the various attach points associated with vfs_*
functions, but they would all call the same global function. That
_should_ reduce the memory footprint of the object I think - or are
there issues with doing that? I also wonder if aliasing helps memory
footprint fully, especially if we end up with separate copies of the
program for relocation purposes; won't we have separate copies in-kernel
then too? So I _think_ the memory utilization you're concerned about is
not what's running in the kernel, but the BPF object representation in
bpftrace; is that right?

Thanks!

Alan

