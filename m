Return-Path: <bpf+bounces-54827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA974A735D7
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF943170A9B
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C71990CD;
	Thu, 27 Mar 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gw8kRCLk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FK9E8+GQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1E12C7FD;
	Thu, 27 Mar 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090036; cv=fail; b=VH7OCMJcD/z1/whNb1upObhbwd8QI12W+eACy1xDOYcfXDRYgXphd0+2cuFR80zfkVih10ng/cSiKkWiuBc7y3d5N7yWDRcpV3+zn7pMKV2F7VGpHyFUpkcIEE5Oh8yDYQzaoyMRZ3epB5unvpisleYFwTXeAenQOc7C9RNVfZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090036; c=relaxed/simple;
	bh=kLcyIT5h4KnnOMX4YQ819JMlaqOhK8EJV8WIungxzD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZZHM3j1pYmxu9fHszwvII9pgjBE/hvJzDnC9f0Am+Opyx+eG3fRh6Rd4iBLnP1nihzZgXWZ0nQKD7C+cK/Xnyzw6MarRfm1Ih5lotnM8lcbXjB8Ly+CPNcCvigD1t5jRVjjNrVBn9ot97YPopxrBEEAew3oER8r62An7hn1Ub0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gw8kRCLk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FK9E8+GQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCT33Y006427;
	Thu, 27 Mar 2025 15:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qxlY9ykKAbhOMdYj0mnd/Iyfw28tF/t+WOYwy/g9tQs=; b=
	Gw8kRCLkHqIvopIvocmefx0JdCWSonqbUxGr3GBfY1aVCGKEE1Pkqn2oazstDKnZ
	BCrAIgki/6fGVrK+EAEiTbLfVMr6k/NDtYresdQBUGuC+hHAiQR6BSrNddGXhTud
	0t0MY1KuPO5ODst9a6C/VLr+5CPRtaPxcbk48IIXrIEWxNkcU+uJmBkj4ECskuwE
	faWxW6o0inqzI1DW0+CfwW7s7H+cQdbE1wjEQ+NzOSN8zWKiFqmbj8QYavzgTYcf
	+tYlj12xqj31P7ih02xI07n9iKrWDRkFqpHl4V+sEQKouVVF3EGbOzIuJ14rKUGQ
	TeyAwYxWPwdC8LMnVpd4yA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45mqftak3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 15:40:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RFOW16008227;
	Thu, 27 Mar 2025 15:40:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6x6xnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 15:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk9uFOOHeYOYcfBTk06iAdgwTT2HyRsRU+L4AqdgpVRdvE4InOgaXalW1MJEe3SCNW0YobL50qYR7qa8YZDVAFOd4Mkevbw/eahvIKFnrgMGCFtnQIMXqZ+YIO8WEH4pzBn04SKr3sCkug65TnK8UDj4uvIgVSTPkpu4sjwt9EjuPzGQwTasnKYyicDvENCLZfNIz6pQ8K7b2iNykqAeeSS7+0xL6VLy5PGY4RsOpzyUEHFMsHZSc5GI3QiHyPq8qu82klO/+UKMaENvML9o7CVtYNRayQtTUhUPLi9aojIfeI/OsHylwVijJ/ckMyHXo9Iekj5F7yiqYsNcjP7kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxlY9ykKAbhOMdYj0mnd/Iyfw28tF/t+WOYwy/g9tQs=;
 b=IT2VgvKHuPKK+li3qlC8b+EwmPb4H2rDUbnFaQG/ZLVNQkkNNSUfh2k1g++4sU+ih+8fU9Yu0GnGgJYpyOe+jamCOscgwp2njyua6I63q2UYzgBsPP11XoKU6ZVy1Yb5Ik6dhjpaVrF4H4hlYuwe/naJWPul7X7S+bws50LxIqi5sCBqAMUW9tkV6lFhnJ0vtekEJZJPmDzLkyn9zQVs1URVKyWs17Xrxz229Nd6L/LJjWJLNIrDs6X4JpbQYIjWnr80zZuNbCIQazTvPGzlqApYr6o7p1BdIQIvejUoEWx4+WR9oHWjVqrtL3X1NNblQc//vdUaeFCkPmCThD7M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxlY9ykKAbhOMdYj0mnd/Iyfw28tF/t+WOYwy/g9tQs=;
 b=FK9E8+GQPmwPsssPv6+kB92x3swK0SYBELmc0NoMqXyuWTN89x+Fp3c6+TqnX+kfaN/gTrX09FMZM1vW667l+cEvpNVZ9/sEBbditd4O1dEe5MZyxXR/Z2+Banuf6JmCmHs2JagOsqL4nQQ4W1zBAkH8qSzao5ssOquBHgAl4SA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8369.namprd10.prod.outlook.com (2603:10b6:208:582::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 15:40:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8583.027; Thu, 27 Mar 2025
 15:40:20 +0000
Message-ID: <4557b284-5b6f-44df-b590-eb5a85d6336d@oracle.com>
Date: Thu, 27 Mar 2025 15:40:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
 <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
 <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
 <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
 <70bf9434663f748563e5e464ac76bab669d0acf9@linux.dev>
 <97ab5e09-6240-4fd9-9411-19b689a21e37@oracle.com>
 <53ae1b2352f808bb57ffb461d506da4e75195154@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <53ae1b2352f808bb57ffb461d506da4e75195154@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: e694dfd1-755c-4d70-18ee-08dd6d45ae3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUJReXdlTWpzUjJicmh1S3BON0owZXd0WnVjKzRsamNGcnhUbHhnUWwwQmdM?=
 =?utf-8?B?bW5zUkc5RDVSd1lyak1ySWRsczJ2MHJWYktuOUN4WXY0RG1ETW5BZ3kxYUtz?=
 =?utf-8?B?WW1lYzdUMEw2bW9kVDNDNXIwV2FSVmZ2ZGJJK2l5MlJ3ZXY0cW1UT1Y2Tk1W?=
 =?utf-8?B?N3J3N0U0NTRqbzF6cVEyQWtzd1Y4cjdONUx3RE9WYlhtQXMvTm9VemRjVE1w?=
 =?utf-8?B?b2ZWVUJ1a2pmOGRoNEFSbmNjZTB3a3ZJYXV1NWZweXV5dlpSL1lDb052Sjlm?=
 =?utf-8?B?OW9UYjB4Y21MTzVuRlhlZTlobnA3dFgvK3p5SXk1MVFkTHgyQXZjbVduT1RQ?=
 =?utf-8?B?MlRPVHU2OENINXduQ1NqSGpIcTJ0TXBva3FDTDdHaGFFQUt0NVJiV3VtMmg4?=
 =?utf-8?B?NFFkY3VjUVloTkZpSVZLZldJbE5mYmx3YWEvd3FhQ0UvdHhkQkREdDJJOEps?=
 =?utf-8?B?ZDAwUTlVZFNNbVRJRllGY3lncGFmanJhVW55bmxyWndrbmExQmNQZDdVdHdk?=
 =?utf-8?B?UUxsRGFBcUJ1TU9jdk1tbm9PcnRkSFRlZzZoZ3RodVg4VHNFYXV1V3ZLYlpv?=
 =?utf-8?B?NW9pak9vaGZDK0RHR3Q3bEtPR0cvdHlnR0pOTUFZMUc4YU1sT1RZRVdjOFQ0?=
 =?utf-8?B?empjZE5TUmlrMHlyWEVCZTgya2xScWg4U2wvdmJ3UnNQQ3RHWmVtcXBpNXNQ?=
 =?utf-8?B?a2hTZ0Q5YUdIYldUUkt5T29kUG5OMzVQQlFVcm5URUpVaDJKM3lXSWk4a2Nk?=
 =?utf-8?B?d0o3Z3FVTTMreFhyVzlrM05WajAydDFBTCtrdG1leXp6Mi9pK1BWbVJKVml6?=
 =?utf-8?B?cWJpT1ZEWllzTTdyOStrZ2lyblkvczhoQ09ZU1A5K0RRM3pBNGI2RGdkRDl1?=
 =?utf-8?B?UWRUZ2d3ZmNjREhPZDVVT2k0RzVIZ1Y5OVdIK0dFTUpSaEY2WVBXL240QXRD?=
 =?utf-8?B?bUx1U2U2bjBqT2FXTkJjai8rbFFSM0U4bGpQZDVlZ2U4RjAxUUdvcmdvcTFQ?=
 =?utf-8?B?OEVUQ25kNEFIbzRHaisvRUlOTVZmdWZRaEUrVEk5aWxyOW12eXd6ZFVqOWlF?=
 =?utf-8?B?Yms4bDU5azdOb1g0TVl1Ri9wdmVzQWN5aXIyNTdJbHZ1eGlIdmlyT3RpOEpC?=
 =?utf-8?B?d0duOWl2Q285bDZ1RGhIOUJFUGs3bjlOWWJEL3JpbTNyb0ZTNTR6YWxqQjFI?=
 =?utf-8?B?K3g4dzJ1RjlwcjNVVU8wdHJiZmF2bklqK2tsVjIvNVVNRHhhdTZpTWFRN2RG?=
 =?utf-8?B?Z3k3ZmxRRjVycjkyQnczdVBuQUI0b0F5UWRINGF0UWttWHZNN09BeTN5eGht?=
 =?utf-8?B?OThjUWtyb0FLRmJReVdvQTk2a0YyQURvVjVLYkppQ2xEQ096NjRNMHA1MGJ3?=
 =?utf-8?B?TEh5c3JRbGpPcVBjRGZMQlNBS1dXYXJ2VWwwQkxxRERKSnlaRkdLUTlyemtt?=
 =?utf-8?B?cHRyQ3ZCSUVlM3NxbitoRzBHQXpBaVdNdmZiMUxMRnNWU0pEdXdORXN6blE2?=
 =?utf-8?B?YmtqUmx0emgwZityVFl1WXlGa3BRdlRpSzVKR3hrRTVGbENaRXh2U2w2bHpY?=
 =?utf-8?B?eGxvRStwWW1pajFmb0NranRtOHVqVEFjeUowM0VYUExPNjFOSmxyS05hdlQw?=
 =?utf-8?B?V2hPZHEzblgzTWdnM05NTjdzTnZoeXlycWR3VjBnS3BsSjV3c1VHMDRZOEFp?=
 =?utf-8?B?TENWRzlKdURyL0dKc2xMSDgxMzBpeFEvallRQlZFeXVxMlhiOXl5YmZQUjdk?=
 =?utf-8?B?K0wvVjZuaFFZU3NHWkhaVEI4WlIrUndSem1Ic1FLZjJPb0kzaTU2SHVaSnF4?=
 =?utf-8?B?bE4xOEptalRWRHpFUzE5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0N3UkZNTHBxU0lqTkxiaTg3TkpzaHhKSWU5NlZlV0t3SjhvcXc2VWlCQTNh?=
 =?utf-8?B?eksweWJ5OVFlckZUV2Y3TzQvVzJ4UmpmT3FOcWVVc2lRU1BvOWVRNUFZSjlT?=
 =?utf-8?B?SmNuazBFcVFQZFBYcnl5MjA0RjViWi9JckdRUmFPL0VBTTRJYXJQMUFtOEFn?=
 =?utf-8?B?V3VINTUvMUlwQTlYakN5ZHFOU1JFbnczbFdNVitCeEdQT3hyWU1weVc4ZkVt?=
 =?utf-8?B?bDZ3Q2V4UGR5YWpjMGl2MDQweUFQUE1mUGlrbW1abU83SzYwb0ZuR3lXaWxW?=
 =?utf-8?B?RnkzMU9mV0hjQ3NyM3EwQXZtNDhHSURENjFDZ21Rb2h3K0NGb2trejlQMXBT?=
 =?utf-8?B?NXducHhSZlZGc3Q5bjZHeVE3MjNIZEwwMGhvUTFZV0p4SGFyam9MMVNmRW1M?=
 =?utf-8?B?bUE4a2FzSzVFaHpWcDJ4blNuYW5IYUpsNVlyZ2FPTFJ6UThsK3FuNnoraDg0?=
 =?utf-8?B?MEFINEMzR29VcE1mU0F0ZDU3VkJSWFBpNU5hV3lYRlBVTVFrT2RZK0pDODJs?=
 =?utf-8?B?T045RjJ3dGhtS29zMThET0dQWk56aVdQMDYvYVdCNmRtUGl5MDA3VG5EVWkw?=
 =?utf-8?B?ekluNjdWM2g4ZGdxSm5KY0JnaEhOYTJMWFRibDJPWmlXM3lrUTd4Z0hFZXMx?=
 =?utf-8?B?UmFBOGYwMUtqUkZkUmluQWQzYVFKcE5wZGhPSDRvMk5vUkc4L0NiTzJDeDhN?=
 =?utf-8?B?d084VjgzVzZzKzBqOWIzQUExNUNpZmNxK0V3RGZYVzlrWDhYWW9ucFdqeDJp?=
 =?utf-8?B?aW9wTTVZdGZGVm41SzdnM3QvS0Jya2VxbWVXUW9FbitQU1N3ZFVWYkIrR0V0?=
 =?utf-8?B?Q2c1OGtON1VkWkY1cEUwVUkxdEdiL0c2MGJoWWxYU0E1Nk5nd1ZRK1IyNkNR?=
 =?utf-8?B?SWd1Q3lFK2w3VlNtSnZMZ3FrbDVpM1RVRzRtQSt1aDZheXJPTlJCT2hFYldP?=
 =?utf-8?B?REw5alhpcEp0NDRJeW55WElZcXdKWFI2N256OFFTam84a3ZPU3JYOVJOSHQr?=
 =?utf-8?B?cHR4UVgwK3R2ejNQYy8zNmRhSjZxN0owNVRFdkZZektGYjlOWW9sSGVaSW1w?=
 =?utf-8?B?Tm5scCtqcmc0NGpXZUpJZElpcmJQd1MzTWpXTTg5YitBaGNqRlcyaG1RYTVa?=
 =?utf-8?B?VFZDcWxsSDN1bWNwOEhHYldhcEF0SHdZd3lwdkg0dkcvN0FDMkI1ZUh6QThB?=
 =?utf-8?B?T1Z4b1VQMDV0SkFjMnZPbTgxSERYRTJoR3E3SWU3dDl4Y0tFWEJCOCsyRSto?=
 =?utf-8?B?TW1mK09PbHRHbjJKbU5MN3BTaXhSOGttVDJCZm1ueTQ0elMxMHBJaDBDYVEy?=
 =?utf-8?B?ZmJHdlhPTHBRRzJ4enYxT2tZait0L3dUdDV3eWd4bEdpMGpwbENDZmh2bWVF?=
 =?utf-8?B?UFkySmt1NlhZazE4N2F6Ym5RbFNqalVKN3J1U1pZZmVIbSt3ZkUrWVc3QmJi?=
 =?utf-8?B?cUZ4d0lGVVRaZjA5cEJXd0VSMU85dXRORkdaUlIwN0NyeERwSDFaTEQ1YjZn?=
 =?utf-8?B?ekliMTVCcTBTUXFBdmNUd2lGN0w2Z2FySnBHcHdtWjJNTUxIK1NUVVptT2cx?=
 =?utf-8?B?V0lIZWtXOXEwRXlzMmZOdWVYUnVwQXhVMnR0RUIxcmlTeCtsbGpXV3NyVFVG?=
 =?utf-8?B?WjlMMm5zZUJjYnVZQ1JYU0hxK09FQWx3RlQwYVlTQjlUZ0dXamFOWWRvenla?=
 =?utf-8?B?Vk1OYmw5TTJNQ3FJYXBneFBCQ0ZoNElBWmtiUFNnbjc2KzRQTkRqNXJIejNv?=
 =?utf-8?B?RzVncjQyLzh5dmQvOXdEZ2l4TGxCY25YZ0FTcFRLcEtnMVBKR2l1ZU96cnE3?=
 =?utf-8?B?d0tvK3JENG5ERkFZNFNLQW5kWXh5cUpFai83ci93SnYyT3V2YXRHVVhRZy9O?=
 =?utf-8?B?WCsvMU1mc1lUN2JrRG1hcU5HVUtQb2EwMHFTbDNWN3g5OFYvT1JON21SMXhz?=
 =?utf-8?B?c0pnU2lNMEZxemo2eVpGRG5iYVR2a21aNGxBRkljZXM4ZVN0Z2xmWVh4bVdD?=
 =?utf-8?B?dnY0Z0gwb1M2MHRpN3U3RHorSW81UXdqa040UGFvcW15QWVyMDBWQVhRdzNM?=
 =?utf-8?B?YjdUMlBJQ1RxSVFhM09HS0lwb1Vad1hUQkJwbitQeTgxUXFRRHRuOWlTQ3VZ?=
 =?utf-8?B?YjhtMUlkUjdZc214eEFyM1J6N05nR1VFM1l3MVhIREFINXduWDZFQmp6YkFV?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	17YsVt6LVhRb5fY3X2rWEBMQbzCyLpCvvuIL3FCCWdr2hjDsfqb+ryjZGDqhFXFCwgqM7BFIMuVvwcTJvoIMQFR2NrpcExuwHw0FGOb4BksaJ0CBAmJJ/JmZ3Xj0cR7h+XFMZTvM0epaWZKxzM6tfnlInqEGuoTsqHU0Ypl2teiCtpcEErTq+sYSOwKzmtXuDJcsr7D7Qy8O5FRVQd+bNYKDa9Wm05Lw+eYFSgE44dKaJtWNa+Qn6+TP3psLMwO/AgzCmAhOfIEBQ/ow22UVNRF33EvmhTaBQxD//Y3mz4gX8baV5AhGCnp49XUfr84O8fRNMh2r3AAvyk+2hNiGUo+CLX/GfEAIoILLw/0myioqBz1O0lefmqsXU0UfiyGSIeU8x8MZ3sWqG5o4Sx8B6+FnDu8SNxd5KLKR/4DCXVYrma73mrH3Tz2XzKbZ0lSLv65uSXVIq9cCk/6SuymjFpKr6LKLI7BMztQ7wCqgeOpXi0ZC/YmwK4fZ4YXOymM0P7nKdDOZqjhnueqoviHzwgaVns7lEubRYkZ3FY3v0GOrhfWuyBUPKX5BAkbhlqAzwLJeZtXIxQWs0SEbIzlWycM27IGrWlE4i8W3+NUOUsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e694dfd1-755c-4d70-18ee-08dd6d45ae3c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:40:20.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93pEnkTISXpJsLEtyr5gXgw9Ujwzrcdh5GXvlMZOoaAQ5oHT9Njt1Z2JbF3ql4hjX/m/MEivcgS4BlGSTa2Lhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270107
X-Proofpoint-GUID: IES9ZDppiYbuUq2DI1ql1Igta_FAC30O
X-Proofpoint-ORIG-GUID: IES9ZDppiYbuUq2DI1ql1Igta_FAC30O

On 27/03/2025 15:33, Ihor Solodrai wrote:
> On 3/27/25 1:22 AM, Alan Maguire wrote:
>> On 26/03/2025 17:41, Ihor Solodrai wrote:
>>> On 3/25/25 2:59 AM, Alan Maguire wrote:
>>>>
>>>> [...]
>>>>
>>>> Great; so let's do this to land the series. Could you either
>>>>
>>>> - check I merged your patches correctly in the above branch, and if they
>>>> look good I'll merge them into next and I'll officially send the feature
>>>> check patch; or if you'd prefer
>>>> - send a v5 (perhaps including my feature check patch?)
>>>>
>>>> ...whichever approach is easiest for you.
>>>
>>> Hi Alan.
>>>
>>> I reviewed the diff between your branch:
>>> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next.attributes-v4
>>>
>>> and v1.29 + my patchset:
>>> https://github.com/theihor/dwarves/tree/v4.kf-arena
>>>
>>> Not a lot of difference besides your patch.
>>> Didn't spot any problems.
>>>
>>> I also ran a couple of tests on your branch:
>>> * generate BTF with and without --btf_feature=attributes
>>> * run ./tests/tests on 6.14-rc3 vmlinux (just a build I had at hand)
>>>
>>> I think you can apply patches from next.attributes-v4 as is.
>>>
>>> Thank you.
>>>
>>
>> will do; can I add your Acked-by to the feature check patch? Thanks!
> 
> I left an Acked-by here:
> https://lore.kernel.org/dwarves/68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev/
> 

series applied to next branch at
https://git.kernel.org/pub/scm/devel/pahole/pahole.git , thanks!

Alan
>>
>> Alan


