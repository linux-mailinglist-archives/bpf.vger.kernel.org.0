Return-Path: <bpf+bounces-46736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE29EFCC6
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4214928AD29
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C118A6A3;
	Thu, 12 Dec 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jj6XIe+o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yF6RnXp5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAE25948B;
	Thu, 12 Dec 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033100; cv=fail; b=kYUFCrD/Lljqp7hN+WeXpX0NYVknBbv0BW/6mPqG+I5bAPxT58DMvZjZ4De0z+NEJcMPaJ7V/HFXNz+VHKz4qoOsZSiCde7BczUxC8GSmlOoj+qszBgUyK1+YAAgn5M70pQto8QIwPA1oWxA8fusAJHQHOxu81JYCF6yNZiNhd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033100; c=relaxed/simple;
	bh=V9AyE7W4tgSUze0QUzPl883ZuIiybDiLXFHFiN7CWOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrZtkYJqNt3ccZeFM3K7V7cjA9Ldm7+KvvXyUd/MbooSJXNndmd0efGDQ3+iyo+zG+qqmKsNjC3VjmzeEKPTH0rZDytSgzSYsUybCJi5onxgtFeNot0t7qv0j6zLmsQLofAsP7ZGJOSBAdiKlGEOFoaPB/aV/zBFLsww6bH0sDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jj6XIe+o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yF6RnXp5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJfrYb029837;
	Thu, 12 Dec 2024 19:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ieq1SRdjBW/LE/sUGVLGU1D/ymayLSBeNYy7nKK8+n8=; b=
	jj6XIe+oane9ZBmsMjFypaFYotZTCiG4pNLpJxk6aLEl4OYHCGjBBThXlJCQ3Fzm
	lNqOMD5dvNPtvTDRYn1+WvH+vSpCaK/yaRQVuGuP8YJGhnNln/y6X7m9CX4sXuMZ
	08ZXPQ07dVH+aKIsQBXq7sbHHM2wfRr3Qr2OGHMmUeevkKV3VjfnjOAffSHowj6E
	erY9f6iT0KY8/NPBYb7ncjnxn9EuCALneLk3vpigTwRoBkDJ8meu47zFbLVGNjUK
	ybfQ0g9h5gLRiSH/Z/XXX5gfvDVka8ZwH2OpFEIDDHhov1b0HKcKutL/ci+L4RuO
	FVYygczehegnXUBLI5G3aw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt3xg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 19:51:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCIADHg019211;
	Thu, 12 Dec 2024 19:51:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctbukdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 19:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqk3euAleiOircciN3DKJV5XCU7IcEKZQ6H8sCLDzk4q2JYKndz3wjvTOAZNpBio2YXuEFcQsH2+mBuMh1nNt3t7KQT2fu6u2ShfEFA3yxEzWHQLucPxdeuVXkuMCuJBoAaOHs2fuTgqV5I6btkhhdhaBsQk1gpQBeAHfkwyQKY7sdGJFaPb12X6VcF8WcvRl1aC24R7U9yKqoRDeERzlUOE2vFwEUs9HExWIgsRDDx6UzuCrzqi1/OO/svzAwyeb/731Lpw6dDf2Bvr4djDrRpmIKb7VlTP4K5vNIKKQ0y9t9s5avjNWfeFVzGCS8actXbNWeMNex9wTdP6Qcj5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ieq1SRdjBW/LE/sUGVLGU1D/ymayLSBeNYy7nKK8+n8=;
 b=yZ1yjIKYPIhKZfCVoeQAQkhtK+86ojP272ktci3rnFlOH9dw9vOvQ1rK6TTRdtqJfySMjFNYle2BVvVV+BPjCngARWhQSZ9DQtsjLi9tQiLNayPKdLVW4z6OkW2vv/8sH6+aLhvrpLehFQj5ogPWYmxTBEMYkg8QzSSnPQM/NwE0OfPlod/44qcVd9w9SB9hjuc/w/uXuMIzAmSB2rAysb60EBzCLxBdMlLs9/7argvN9Isk6bU6JoqxiCCIgpGo7WCfu75D7nX/L7uEtnHEPV2BeP14g86jkb2zATLB87YxYlFWvijh6UV3lec02FFRZ8MkfCvMxF7qRpvz3QCQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieq1SRdjBW/LE/sUGVLGU1D/ymayLSBeNYy7nKK8+n8=;
 b=yF6RnXp5Dj5zl6KlX3noMIa9jhia4W3xqiITD/XvlqVj/dF4on+WI0jz3ynSI9H93RuwOJEol8kJxaRZNP+Cjeg54deyFEmzjnEFBWxXgUCLMCBkjenVA6V1/mk5C2CoS49mWQQ9Uy1gEBpfwkULVyAyX82+WsY0Gdi6nXYpvWQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Thu, 12 Dec 2024 19:51:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 19:51:01 +0000
Message-ID: <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>
Date: Thu, 12 Dec 2024 19:50:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1 2/2] tests: verify that pfunct prints
 btf_decl_tags read from BTF
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev
References: <20241211021227.2341735-1-eddyz87@gmail.com>
 <20241211021227.2341735-2-eddyz87@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241211021227.2341735-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6c052a-d490-48b0-a974-08dd1ae64e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk92Wkp5K1VTNE0vNDBmdCsveXMxdTdubTF6enRITFVRdndweGR3TTBnUnc1?=
 =?utf-8?B?N1FIVUV0RVJnUUpDSXJDM1dQRWw2K3V5NnkwYmFGNkIycURYaDlsRVlBTW0v?=
 =?utf-8?B?MkxlOG5OWEY1Tm82aEZQNFlRa3d3V3dkWlh1Nk5BWEZXTjVwQ01hYmtuMm5Q?=
 =?utf-8?B?THF0VlhZZFJWbkVTN2x5YmRpVGhacCttS3ZQNjJVYUkwV0s2Ui9Xc2dyQWpn?=
 =?utf-8?B?K3RRWklDTW1qNjNTWlA2alpSMjRzWEVYMUhJRkR1WmdremtDblNmdmIrN1JO?=
 =?utf-8?B?LzZvL2lncFBRYUJpblRWd3ZJY0JnTEdPSGdjZHlQKzllSDZYTmkyQjVIQ2Vr?=
 =?utf-8?B?ejRJQjArZ2doRE9YYUtZQkhTV2lqTnJydmdtM0V0TlpJcGhsM3ZSbE9rbTJx?=
 =?utf-8?B?bHk1alpLM3FLLyt6Nm9LYW8reFhxdkMyUXNodytFdDdpRzluNEk5T3ArcWpS?=
 =?utf-8?B?SGwwbSs2Yno1RnJIVXlXU0Ztb292TXFqaUptd2pJbmF5ZzRRTVp2Rk1KOGlq?=
 =?utf-8?B?YnlYa0VRanFRaURuSEF2SGlXaUxUTnRTL09UeXU3WHB5OTM4cWRFVjlwaE10?=
 =?utf-8?B?emViQldINFZYaTEzbjJYSm9QL1UxRm4rTHMveTBTc1BENnlidFpVdHpRdnFs?=
 =?utf-8?B?cUUwQ2JzSkZId2d4dTc1S0hmNlFyOVcrcExwL1hRazB0TUJUWmhabkJ6ZXc1?=
 =?utf-8?B?UGR0TDcyOHlhTmdxR0lSQ1NXQm1UZ29PN01VYWNTaHB4R29STnM2cW1qQWhM?=
 =?utf-8?B?emZiallQbEFVWTNMbk9YcHJhWDlQM1lsSzNjT0ZsMkNYT3gyWmEydjh2U0Qw?=
 =?utf-8?B?WDErZWNhLzFPZTFYVGFncVdEcGRxYUlhYjNBaGlyeG5lWDIvcE5NbEppNkpM?=
 =?utf-8?B?aDd0cFp4TU5FL1dRTDQxcjF4Y0NmZkhlUUlZdzYzcjFId294VUNPakpqSFZ1?=
 =?utf-8?B?b0tFdGVHNmxCNUdwSVZLY3BkMW9PNVJIK2p6MzVEZGh1UkJRbXRGenRZZ0hR?=
 =?utf-8?B?bFUxcFJpaFR3MkZOR3J5d1A4aCtYZGg4dkUzNzJPWFVwcTBnNTdQRStjUEh6?=
 =?utf-8?B?TEVRS0FoaS9tZUpnanRjbjg4RklNY3MxSWcrSGZnNXBtVmNvMmJCZkpLMUZk?=
 =?utf-8?B?VGdLdUJFVVBUNnZ0OFpXYUZGYmFNcFpRSk5EbndRWk9OTmtNWVlCemtCbGt0?=
 =?utf-8?B?ZGVKeGJzcUREUFVqWjhaNlhibjZSU1RUNmh1SHNUaU03Y1Q1SUhubGdjWlJN?=
 =?utf-8?B?NThYQlpFUVZLM0NYemxtUGt1QnhEM21QeEJPdXZRR05lWVVnZWxrWmsvUFZq?=
 =?utf-8?B?RFJDYmtQZ0tmUmxaWU9pMkhPeFh1aHZkbDFjdFNtdUxrWEZxMDdYejRDNU82?=
 =?utf-8?B?TzlybE43b2xJNG5OdnJXTkhET3BBMEF5Q2Fwb3p3MThzQzA0czJJTDl5a3hR?=
 =?utf-8?B?bGoyeDA1U3FxN3RsY3lTQXNQcFZrU3hjMjdMTkRmS3JaRWZHTzMyUnBnMlJp?=
 =?utf-8?B?MkYrbGQvSWhCZkJpQXh6ZmxvVVNOdTM4TW1ZSkdqTGRhTHlJNTUzTEQ0N1Qr?=
 =?utf-8?B?ZDdwdFJTdGcyM21ZZ3BtUVFLSEwyTVpiYVMzZHQrTFNteW9KRU4zekFaVWpa?=
 =?utf-8?B?aGMrRkpkZmZxaGFndi9SWGdLUFRhRXI2ZWVCay85ZXJPM0NuTGZ0RVpLN3Bt?=
 =?utf-8?B?MTVZQWRUZjFNVDdNbTNkLzQ4aXhSeEljTThRNjNBWjBDUFlyeWw5T25DZDZC?=
 =?utf-8?B?N050MXgyYkR6SFh0cWFhQU1TcjZoUEl6Vk5KUWVVQm1zNmZxZlM2d2hDZnhp?=
 =?utf-8?B?VkowRVV0ODVtRTNNNnVWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhZcFJHMjl5QVhMRjlIOWVoZEZ0ZzBGNnZwUVJqOGorSko2dUYvVkxJcktx?=
 =?utf-8?B?dkprMWFSaFhuTmprcllEZld4N0ZackZ6WlNSOFZJQkVVUmNweTFSZ0RnMGtt?=
 =?utf-8?B?YkZybGRNYlVHWjNGdmxOcUlzQnJjTXJqdE1LT3dwK1ZWbmNKemJkR2hUUGh6?=
 =?utf-8?B?MjJNRXpISmh5Z1VUeDdiZVJjTGYzbW9mMnllWVIyd3ZtQUNCZ25ySENBS0tH?=
 =?utf-8?B?YUt0MG9RMGsyTnZKTjVsbWpHcUlFbE8rL3ZHU1gzcmN1cnhvbkVPUlRoNVFs?=
 =?utf-8?B?NWR4RW9mSFlRTzB0UUlrZVFuWFhHTzJuMFhPSmpKaFlzMVpIUGpzWlFnM0lP?=
 =?utf-8?B?MnE5V2hXalVscVpoU290YnVBUTNVRkZ2bUJsUjhsYXFacnN0bnJ1SzF5YXRr?=
 =?utf-8?B?U0hmN0tTRWcrNW9uYlFGd0QydVBTSDlUdThzbXpVZEp0dmJtNFZJcGVaeTAz?=
 =?utf-8?B?M29ObmhWNjg3OGN3aERkc20wU2hRajZ2c3NvTjZDZXJzb0k2K3VDQVkvOFdN?=
 =?utf-8?B?TTgzeVZBdC9BRlE1cTViMkw0TUhZbDZMelZQaDlkcnM5cXluYXZ3c2dDQjRZ?=
 =?utf-8?B?TFZ4eW9FZHRqdnoycjQrcllXQ2RUR0xFVE5PTzJJbitab0haNG13YStBWDBQ?=
 =?utf-8?B?bnYyQmtqN0JQTUZ1a1pVWGxzMXdBdkxxY1NhYU1DQ2gwZDdEeGZLRGhMUlNJ?=
 =?utf-8?B?eTF4aklxeDh5TTB1VmVBb3NVWWEwQjNTa0ltUk5Ubkk0ckpPRWp5SjVLc1d4?=
 =?utf-8?B?eEdad2xibGw5UnlkdERjTnRHN2o5MjFsQmlIb3F0S3N1ZUNoQUQvSWN2TVRV?=
 =?utf-8?B?VGx5NVA5SGFzcXZ5OEE5TWxRV29RZklxOGpCdjAxcjhBUmxwZ1RhRVVab2gv?=
 =?utf-8?B?elN5ajBhMHJPTlFIaDIrMFpDS2ozQ1YvdFFxRDZWaVZhdllMOVNHakEwSEty?=
 =?utf-8?B?WXBJVVVOeW5IT1luNG5LSFRLNlpkdVkrT29xWi9uNWpvcFdCc3U0MzZwZCtG?=
 =?utf-8?B?dHFHWUdWZzY3ZUhxUEFJc3pqSzNQUW55V3dmNlhxVnBYNnpJT1VPZGk1YjVy?=
 =?utf-8?B?elM1aHhSR1dkOVRZQU03TEJla2NuTGdrWTFtRk1pUFJZbjYzQW92dVB5OEln?=
 =?utf-8?B?a2gxTWM5cmNncjN4bjlKQ3p3YkN6NUdaalI4Sk5nUDM1Zmh6MStpY2V4SW8z?=
 =?utf-8?B?d0tTaEpraEJkMC9KQWQxdE9hUjM5YlRvOVYzdGRlUyttY28zMXIzYXp3aElJ?=
 =?utf-8?B?UWJ2bm5mS2Y3OFB6RjZKUHRGdHRsWHJsczRoa2hRdFZ1dkpZd1hEVllnT1NQ?=
 =?utf-8?B?NFZITjdSSVNZV29GWklqY3drb0Z0czkxbXBzaGcyQUN1VWdycVpMWEhia1hw?=
 =?utf-8?B?TDNYajJmT2JKMmFzZUdEb0J3UGVwd0JLZzR1aXdwd3hwOC9iUFY5SHNldzF6?=
 =?utf-8?B?RGNYOThqaFRXMVV4ZE8xeVBseHM4eU8wQytGVGNzMzViN3U4d0tzR3dZMklT?=
 =?utf-8?B?bEcvVXpMMWVSOVEwN3MrdUtMOXl3NG1WYkVyMVpDVVZXZjdVYndKT1Q4Uk9L?=
 =?utf-8?B?UzRLTFNIbFk5SG5Dd0pBa1dNZDZYOWVheklsaVhzWTN6RDJLd2lJaHp3WVZr?=
 =?utf-8?B?L1NnZGpiWmVBdnVzWk05dHZJTVRRV3BvTStiZHdZdVdjNWo1cjcwZUhKd3Bt?=
 =?utf-8?B?YnpVdmNCSzlnRGlPajNnSzFKclZpVlZzMkNRS0R4bTRaWVBpUkYxcDVwemdE?=
 =?utf-8?B?RTFWTWdHVHZmeldxTFdZVGMvTlAxaDVBdjJ5UDRoelhnR3dZWEg1akhvSm5X?=
 =?utf-8?B?Y1BZL2JXUHpmQ1hhVzdGR2MrNk4zNXJDdXMyNnBzU1BrZWx2Y3BheENCQnNu?=
 =?utf-8?B?V1hISld6KzI3VVpNdk5US1hFbXd0OEpFdFN1c0NNMUhmN2FQYW5tMFJhajVJ?=
 =?utf-8?B?ZGV4b2xGQkV4UStISG1SUG9BdUhYNFdWdjVBNmJ4M0VNY3g0SU1SM2xabXpF?=
 =?utf-8?B?amdBM3pQTUt4UWdjNys3ZXRHZTYxSDk4WXhnWWpFOHg3SjIraUdCQzlIWlRU?=
 =?utf-8?B?TlRkZWtPcGtzNEcvUXhUM3prL0pQVkpMOWMyZkdWWng0Z2d2L1lJQjd0RUxK?=
 =?utf-8?B?QnZ2SFI3Q09CdjNHUkdXUzdnSGFPWkJtWDFEUXE0SXRITW9mQWhYQ2JkbEdC?=
 =?utf-8?Q?ZUhVpDIG3OkPR3PXautTs9Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KQVw98yYoTl9PdB4/0RegTOU7zZcXbVUlfgqRkWWr1hmjscCj1qCaDtS1dEMcW7Mg6uHsuN/tnggU7pC95gTZ4yXzB7AuIm7COBE8lpc6akVxXBQhPt9oulWBLEU/zQZIt8rt8gwJV6FrX54LLs1Aul6/SYXez62S5eMqAcSbmu/Yb7cWe9bGugxCqYf6/HrLA3xVE7V/b9NgxIR7/zoKTpsCYsO+XomZdRsg2CbifJKODljh3MaS+Jf7ZbnEk3qupn7hFkuReWXoqCctK/G87MuKTojJrOkV7yMYXKPDUj6g8ynBGrAhW2HE8XMHNptrjpe8U7BJGp7h71OFKqoSYQXyGOrmOvPiFNuEXw0DRNfvTZrrr6lpkgS2KSCx/1krNLPSUiaWiNe89mj1/uckpH8PurMc8M0QMOfMdU5tcxVj5Nj28xCGbi9y+xepkpqd1TRT2wlIQ+hs+UIEWcybI0GMoNRHXbakr48/+gRw9TY167lZW518kS4UYTTbSMBULovDFXMQtIryrRoEyCaDozgutQfnLyOQHIEs1ajguoojCOHZml9OCQvXLngxxjV0RCVV7CxGszgNUoRUQ2O6pNGG3vg/n646KDaNkdR37M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6c052a-d490-48b0-a974-08dd1ae64e41
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:51:01.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTTlra7i9gmwlqjn2MmlA9UMuo1MbfaAeO9ztQRuuBR15Sy1MZPHDH4ubqAuciNdcISwdnnH9+XPTGcbXiLXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412120143
X-Proofpoint-ORIG-GUID: mSRLUA56QFw6pzJwVd1m9bdlEKhXwe_u
X-Proofpoint-GUID: mSRLUA56QFw6pzJwVd1m9bdlEKhXwe_u

On 11/12/2024 02:12, Eduard Zingerman wrote:
> When using BTF as a source, pfunct should now be able to print
> btf_decl_tags for programs like below:
> 
>   #define __tag(x) __attribute__((btf_decl_tag(#x)))
>   __tag(a) __tag(b) void foo(void) {}
> 
> This situation arises after recent kernel changes, where tags 'kfunc'
> and 'bpf_fastcall' are added to some functions. To avoid dependency on
> a recent kernel version test this by compiling a small C program using
> clang with --target=bpf, which would instruct clang to generate .BTF
> section.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

nit: the test is great but it would be good to print out a description
even in non-verbose mode; when I run it via ./tests I see

  5: Ok

could we just echo the comment below, i.e.

5 : Check that pfunct can print btf_decl_tags read from BTF: Ok

?

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tests/pfunct-btf-decl-tags.sh | 65 +++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100755 tests/pfunct-btf-decl-tags.sh
> 
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
> new file mode 100755
> index 0000000..7e7f547
> --- /dev/null
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Check that pfunct can print btf_decl_tags read from BTF
> +
> +tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
> +
> +cleanup()
> +{
> +	rm $tmpobj
> +}
> +
> +trap cleanup EXIT
> +
> +CLANG=${CLANG:-clang}
> +if ! command -v $CLANG > /dev/null; then
> +	echo "Need clang for test $0"
> +	exit 1
> +fi
> +
> +(cat <<EOF
> +#define __tag(x) __attribute__((btf_decl_tag(#x)))
> +
> +__tag(a) __tag(b) __tag(c) void foo(void) {}
> +__tag(a) __tag(b)          void bar(void) {}
> +__tag(a)                   void buz(void) {}
> +
> +EOF
> +) | $CLANG --target=bpf -c -g -x c -o $tmpobj -
> +
> +# tags order is not guaranteed
> +sort_tags=$(cat <<EOF
> +{
> +match(\$0,/^(.*) (void .*)/,tags_and_proto);
> +tags  = tags_and_proto[1];
> +proto = tags_and_proto[2];
> +split(tags, tags_arr ,/ /);
> +asort(tags_arr);
> +for (t in tags_arr) printf "%s ", tags_arr[t];
> +print proto;
> +}
> +EOF
> +)
> +
> +expected=$(cat <<EOF
> +a b c void foo(void);
> +a b void bar(void);
> +a void buz(void);
> +EOF
> +)
> +
> +out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> +d=$(diff -u <(echo "$expected") <(echo "$out"))
> +
> +if [[ "$d" == "" ]]; then
> +	echo "Ok"
> +	exit 0
> +else
> +	echo "pfunct output does not match expected:"
> +	echo "$d"
> +	echo
> +	echo "Complete output:"
> +	echo "$out"
> +	exit 1
> +fi


