Return-Path: <bpf+bounces-78693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005BD185BD
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F0330B2392
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AB38B9BD;
	Tue, 13 Jan 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SA+yLG4e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YL4xh8eH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC338B7AD;
	Tue, 13 Jan 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302191; cv=fail; b=YTKTxV+cENjyOpjai+cDadCeag/YQP+WG0lLCHZ7K1GAxsXoGlz8iAOL80HfslmnNBX4n/d3CMEMmqY7HVuS5GgDcSi7bgau5sTQpZLxST8Q2QzGZKqt4acltzLpw0lZmqRSaFlzel+5xzb3ZpJoI0oQgB65pXjL6VH1x/GFXLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302191; c=relaxed/simple;
	bh=oADBmZ5gxL/xOj0WPvnPwGQZhBsncw0UtCzagZCvbrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZtElZPgSCynYOgVfN0ogsdzjte6IJRIFFa5QzcdE2Uok+8KrssvVI4WCx+cv3NO5jmanwT7J5CRsvzNHLseHa306WhM5Acdq0fRoewYACgtr7ioA/wVh45wGXVz9ATWECJ8iTSJFffC0H0yOGHYmdjzN+EdDET5MN3Wh/O2bbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SA+yLG4e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YL4xh8eH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1h1492754251;
	Tue, 13 Jan 2026 11:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Bu5W73V2MAULy/GWSKrAZXzlnYdGNK5ho+//7iDqog4=; b=
	SA+yLG4e4tyk6S+Inyx2W5AaOGtmY7u58O9GXnUvwdmHRddcOtZmgrF8V3UzaVVT
	jfQ1BKnzHc6owKNCp3KzMFvA2w5YVx3uzpd2l0PYBCH9XvZCgd6DQOkRjJiK8Qte
	R/khqCylwSB5R0LXfzzZeb4N/6tHfJiYOuXHxs8WAbNBco/Dwf0Tu15eiPob8sa3
	snZd1tUAtVLClagtyIDhD7KtTwqZqOHb+Ayuv94SBIt/w1VzhNtcczrpLFvkeYTP
	r7bwNInMX90yJy6WA39wcvj3O2Ctx15CLRhdPWpFTBaIqokXqZDW3SzMySon0DPD
	6xrALKZXB5YXCNy9XKcXfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgk83p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 11:02:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DAfQln028706;
	Tue, 13 Jan 2026 11:02:45 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78k0v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 11:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0mM4g5UijsZth1hN1WJTLqZnONMEU72zpJ1PlKRssXmWBIENqpbcjN7FtiexMjNWzuTOee8Lbu6xiMhXMg7/wescxmvDpV1mG+KQkhQjlrejKc645foXWmnjqde5d2TQhWd/M5p1hLDpQx3m3FutxxQgO4fPGvsZyjqouVV9+T8XBer88oWjof92oTNY6ZX9wSKRKHKb5p9zQBwDXL0+ATtPlmLFSN8uDNF7/xf4/P7iF1VvnZzIJEgLt9qm/vFD8yUTeH6dT232FZhQqtj8h6HjFiuAu5Vu5kzAbnUdNie6bDVd4FYA9qlbV9xVYMX6yRbxPlnYJlMmFXzOgaemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu5W73V2MAULy/GWSKrAZXzlnYdGNK5ho+//7iDqog4=;
 b=jIuDfGnMlln3GVOnL8SYvocfhnN8aobq3K9I3gRcBceYvrZVtZr/hbfBmSS1bB99sQY6PpOucke2Jjt+A8lxDRgTAYjz1aWRRmavWWdVXlrflveyGydd4KGI2T9AchPE/LKBbANEwCeZQcsGkO+93RSkmpoETFmd1cD+L9QOSXoH8iNZk/V/6SZCkJWhmH9qZGbvQmKNeumKAIXhhQ8RUE5iZj8+xPrjdoGgJ7JrixO8dfcYnPjthP+4b9vad4VimcoXSfM7VVHV28D7KeriDvA+AswpRd9nayMFpC/OtVfmC63Y+Q1uAB2F41PdYEPo1Mbe/2DALMEZlFxCPHmmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu5W73V2MAULy/GWSKrAZXzlnYdGNK5ho+//7iDqog4=;
 b=YL4xh8eHzSnHkJh/c4CJQ7fzVMpuP19sTFOeDnLn0c2+SktgG8KMgqd9MBanAS3Azm7P/V253GyzsB3mvKLZNWj6g+VJO5mrDtlSHam70uMQqdAIueviMM0EKyKZ1Ki+MWAhAh894z5hAYuTtoKPWmpWonXgaaxfRz9b1LYOr2g=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 11:02:42 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 11:02:40 +0000
Message-ID: <98436a72-236a-43c4-b6ac-9d74b53b0223@oracle.com>
Date: Tue, 13 Jan 2026 11:02:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 bpf-next 7/9] bpf: Add trampoline ip hash table
To: Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-8-jolsa@kernel.org>
 <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>
 <aWVnVzeqWJBXwBze@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aWVnVzeqWJBXwBze@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da6fc8e-a98a-4e5a-bcf8-08de529344b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1lEcjdvK0ZKSGtwcGZlUnNNOU96ZlFWYVc5VUdwVExNSGsvdC8rdkVwSFdX?=
 =?utf-8?B?OStxRCsra1JZUGZ1aWUxVGcvd2ZYdEVOV2FFZzFJUzhvSXNhYXA5K1lGRkxv?=
 =?utf-8?B?TFcrYjRHL0JyZU1vcmR2VDhoNUx5aVJzaWhlVmFxelYxWTFJVFN1N2htSXg5?=
 =?utf-8?B?enV0NGdIZU40a2c0K0M4bkhNV0ZKcy90ZjhtK0VvVkdtY1Y5YkRIeFo5V2RR?=
 =?utf-8?B?RFJ2N0ZYNVFyejRaTGozdTI4Um95ODRlQ3RPTExGSFRzWVd6TlBVUENKY09i?=
 =?utf-8?B?aVJjS0hHbGFJNFFGTmRYeGkySFZCR1lPWFhSajdDU0Vtb3I3WG5XR3pGVnVr?=
 =?utf-8?B?SE5tMEUzd2ZHZlhCYVBnY0V3Q3MvdWtCSThhWFMrRkswQ0NoYjVvdzJKMVlr?=
 =?utf-8?B?Ny8zVnFLZTU0N0xLQTU0b1owL3BWVHJick5CUEk2SDZmUHNtZHpURGJrMmMy?=
 =?utf-8?B?QjN4VjduOG5kS3oyakRZTU5ycFI1MnlqeUJNU2dUcGVmYUJKelBqcGNGQ3d1?=
 =?utf-8?B?MVYwVjFwTFVreVpzRU9ObnBQaWVQK0JIL2s5Ly9PTTlVcXk1NnVKZU1oNnFK?=
 =?utf-8?B?RTR0KzFKR3p6WnB4b1ZUSWR5RTZaRTh4Nm1ZaUdKbU9pdlFIc1ZicjAzdWY3?=
 =?utf-8?B?N1ZLSVdQRWNxM09zdWd4WFBobkx5cWYycEpjL09PSlZtT1hIMjA5cVJQNDBU?=
 =?utf-8?B?NlpTWFY1Q3RCYThjREdIOW5raWhGL0lHbmRzWHBoaG04cHpHR0Q3a2lid2VM?=
 =?utf-8?B?ZFJKelBaN1h1UHdkV2owMU4vOW9ibkpoem51aVdiMkwzRGpsWGdxckdQeTZY?=
 =?utf-8?B?UnhqSlF2MDUxSWFKUWNjQk5mVHhjczRKMk92WkpWQ0VudHJSaDQ0YTNsdFRa?=
 =?utf-8?B?VlJUNHhmWkJiSlpheUU3Z0dXbCszZVlHblI2VjBJbXk3WjczTGNJM2pZa1Js?=
 =?utf-8?B?YmJDT20wdC9XT2E1RGY2eFFlUWY3QnNkUmhUV1d5cWhyelkrcFlPWWxoMWhK?=
 =?utf-8?B?cVRQdzFWTC9OTWtMZTFyM0hsMElFeDlMN1hZV0k3ajZGQU1iNlpQM3lOaDJV?=
 =?utf-8?B?YUsxRmlQY3psQjd3WC9Vb0MyS1EweHZVRzZjUDB4UUtpSGRoeHJHdzFvSzJy?=
 =?utf-8?B?QkFiSGhsaEZyNmVHaEhaKzRsU3Q3Y0lnZWVJRmlaNGg0TCsvUS9Gdk5UakVh?=
 =?utf-8?B?a2swUGRBdnFRTzNuTUluc200c09LRjIwL3JuOGtWZFdNQlhPM0dGMEtWTUVW?=
 =?utf-8?B?cVJSK3E3OG9qU1BQWGV5Z2Q3WlY5UlBtcDRVcHR6M05YaVAxa0YrL2FhTkZ3?=
 =?utf-8?B?NzBwbXJ6OTZLVFlVbVBIQ2V1K2FmUnZWd3lFVnZWRzNLMUlVeVN6RytmVE1p?=
 =?utf-8?B?QWhaZk9xQyswUkQrNHQ0RXFOZDNDRGJHNFI0YkJKOUM3SkhHZ3ZiY202SUhS?=
 =?utf-8?B?RXFERk1PSU5rRklsUmxFd0toUDliVmVyVXZNaU44TGdSZzI2NWt4NXkwY3NP?=
 =?utf-8?B?YnBUNk5nMmNncWYxbkh5bllOZVlVa1o5UmorbDBQSHlOWDg1UDF5TktCcTRQ?=
 =?utf-8?B?YlQwY2hVY2FkTkEvM3hsdXdSblJpd0dHRFcyNWpIcDlCS3ZjejFGTGt4OVVN?=
 =?utf-8?B?VXFqRU5LcUh5ZngvK0h6MG9wYldVYW42NUxaT2poa1hSN0Q2bVdtRm05a3l0?=
 =?utf-8?B?aWs1MWV6RWRsazIvZ0pleDc5TVlJSXZOb1F5cTZvcWkwY2tyV0h2Sk5ONWxV?=
 =?utf-8?B?dE9haFVIOGcxVDFyWndzaUo1a3lZRFk3KzZ6QlJISDVyT244WDFJVXg2MHRl?=
 =?utf-8?B?L3NOZEp4Mi92d3h6NDNpeHQ0Z2pJbFpTMG91NVNhMkQvcmI2dEg5SzFtaVFO?=
 =?utf-8?B?UEtzRlFkVHhybTVjRmVoWTBaUVduTzFVU0JiMXRoaFZVeE92LzU5T0J4VGVC?=
 =?utf-8?Q?sL5usNFExCYB5DTGYZw8cyLS4BEzYdhl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJFMmcvZkt6bUwyN2wvZGVHdzFQR2FaeW9GWWc3alhpbHlVOEcxVzNBdk1H?=
 =?utf-8?B?TGtJZlhheGduTmdLeFBvRjh2YVZ4QzVNQmdoMzc1bW9MWW9oYXF4WWVoVXgr?=
 =?utf-8?B?S2kybktpMUpsRXlVbmxFMDhSZmJkTjNRMlB2Z3Fhb3FwTXlyWk1zOWRHMjZq?=
 =?utf-8?B?WWcwU0NyR0RnbEZicXNKdlhFVlQxRjNlTWNoanBwVjJXSWJ0aTlrMnZ1cElB?=
 =?utf-8?B?VTloaGloMzh3ZzhEWTdyNjFQTlhUNUhSaWZtcXVyRWR6TzRXNU9jTExxN0JG?=
 =?utf-8?B?TjFzYVdJOXMrZFpVR0dtMHV0c0tiaUJ0c2RVREd5bm1XL1E0Yk9oNk42dVpW?=
 =?utf-8?B?dTl1REZYVkFvTkQ5RjBtTHVaa0FjSzU0WFFZNGQrL0dRQXNBbklZRUhwNnJv?=
 =?utf-8?B?Z284eEpNSDdISFdFUU0zUHpETFc3UlhXVmRneUVoRGNLRmpqK25Zd21FeHVh?=
 =?utf-8?B?WlVCNEtnWE16bUZ6MzJteG9oRGIvdUR3SWMzQ3hMTVN1YjBJRWlGQUk0clJ4?=
 =?utf-8?B?dkRBTDVmbU1YQlpJTUl3NjdpQUo1TlcxVTZPSkxxQmozbVdKTzl2UHBXVUZr?=
 =?utf-8?B?bGdwbVdiNkF4aFBnREFaTDM1ZVgzem5ZdmMyc1JIUWxsUklUSjJITjhESGlj?=
 =?utf-8?B?dnBHdUxBTlRSVEpucjVUVTM0aHFtUS9WY1JkaGJXMXozUndZaElSakhZdnBX?=
 =?utf-8?B?ME5Fb0tGSmwyRktUVHVrRjJjRHpjYi9tRFpYMkNFWlYzcHJlbnRCdW5PL2pE?=
 =?utf-8?B?M2U3bWxEeCtrSkdjdXZLa21lWG5ITUpkWU5WTm1ySDNQTUl4WmIxQTc5YkZ4?=
 =?utf-8?B?YnBsenNUSXRTNFE4d3E1RlRldUtSM1Njb3ZibTNPemNjdE5EMERLUUZjWjds?=
 =?utf-8?B?NndZUUplUWNZU1JyNmRueGU0dVVGb1ZZTkxMMjVRdHRzVzRLeFRscmpqR0pj?=
 =?utf-8?B?WUF5QnVqTTBudzBMcFM0amk4Q2lOYm83V01PVzNIS3dTeUhPcVR0U0FyQXRU?=
 =?utf-8?B?NWlWNzZ3RXdBNjQreUNvdkRwOWZvZ25FTGxWWm9vR1ZDZ0xtMUVvSU5lOERk?=
 =?utf-8?B?aFAzejNCVjF4ODkxYkJ2d1pyQUczY1kwSU52VmE4N25VRU1VNEZJa1c4VEZ2?=
 =?utf-8?B?NmZDN2R0ajFUeWhFcDk1U3BNK3J4VEN6cURtcVJuUk9WYjh6VnpDV0VMUDdr?=
 =?utf-8?B?TWVIRHZKbXhReUh3cjFkRG5yYWtjUjZBNDZTdVIzcG40aVBBVG5mQmJRdEtx?=
 =?utf-8?B?cFVIU05BNnJJNjZBYnRVUHNGY1Nucy9zVlVzZ2ZiUTQyL0RycUR2QTkwMGcr?=
 =?utf-8?B?MG9RUEE1bHh5Rk5OU21KQ2ZWZWFoTXZhQjFZR3V1NTA3UFlBMUNNNkhIWWVp?=
 =?utf-8?B?SzJRdWdoa2RXWEZSVmdPbmh1OFhOWlBmUTRtRlowMEVSTEI3ajBVOVdrMU1j?=
 =?utf-8?B?eVBUMk1TZ0ZZUy9zdjFrYks3cXdQM1NtOFBWQkVZVGxHcWMzSmRrSExOY3FS?=
 =?utf-8?B?SXI4STRjYzhGQzFkOE5ZUU9mOU1rTFlsOEU0WkpBc2RIM09mR2poYjZCcUNR?=
 =?utf-8?B?SEN6Z2tzVUI5MTB2b0ltZnJCMG82Z216Rnlqd3JuL1FaMzlxdTRCZnZVVGFt?=
 =?utf-8?B?U1RVMHM3MFg4ZE1CbWM1aGtjQzNDdUtrYUZ0MWJXeS9SUGpsYjRLdTZrY0xL?=
 =?utf-8?B?d2FiQUhDbjFYeFZnb1BGS0VzQTBrUzlrRUViM0JPaEFzYXpOZGM5d3N4NGw2?=
 =?utf-8?B?WnpacXg5ZWxTSWtYcVMyNjVXcTJSajUrUklFTFBYdEorNWthVU9RTVdyckg0?=
 =?utf-8?B?K0t4ZDdsaklTOHcvTHRaYmVLMFNKMlAvVWpwd1VKSzA3UVNQMzY5UjhEbEZo?=
 =?utf-8?B?V2ZlQjVBRzVLd3J5UEoyUnZiclNaWm1JZno5Sk9vVkJvN0tkeGlTdnh6b1dN?=
 =?utf-8?B?WFpMOVVsdlo0VG9YbFFqL1NVd1pSYTNIWjRJaDJGdUVwM3N6WVpuVWM4dVFk?=
 =?utf-8?B?YjRVQjBrYWZ3WWpnZ21VckJRN1plOHhEbXV6TWV0NHZiVFRINDBKc1Vvc1FK?=
 =?utf-8?B?eEh6K3gvMkxDVTFqRHhHQ2REMDdjN0ZtY3IvQXpCa3liU1h6Q0JCNEdsaGJP?=
 =?utf-8?B?M1VuY2h0WEhaTEhVT1E0QlhaSTk3UVRNVGNDeFpGaGFNQVJBNjl5bnpRUFZ3?=
 =?utf-8?B?SmM4N3F3K3dNZUJ4cW1rUTRzZzFmNWx5bDJ1UDF6amVOd1NFUzBkTGtDTlBs?=
 =?utf-8?B?Y20rS0FmT0ZBMkNIZUV4dXdHYzNGY1NoNlkyOXh0aEZPc283MzFOTVBjSE1s?=
 =?utf-8?B?V0N2Vmx6cEp0SFhCVDNnS0tmQTNPUytHNUlQNEFiNUloc3h5aWsvQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vpDpEUB+xrtlKbFA3HzakAnbVQOqA1fyqF4x7ffcloEU8h1NTNYGmN5AH7WhV+zpW1qrIe9wD1LQrGX6w8jf3ZfXeqTbbvvo3VxAW92c20Vyz8B1b4//pNbn1mAF2TqQAPG5CgZ/aCFg+6mIaiPFvBbExWJGrdOj5dCv/+qOJn2/5EE+Stbfy1u3sLk6c4CZ/PRcQU6y/6GjjKpTbGLnv/Dy5p4M5FKSjRXIW8wQtfUReBJd3ihCu/Msrtf/IwZi7I87vcko3CfUalLqwxE+MKfsarIPdHnCEdsI7w2eHyC3yoq1izPbYqmYItO0w4dqhx1fxSbBnzp+IlPPLLg15XNrvQLKCh/09EamBIpO71S91/n0pkhKovSjKNY0dibGarm3/sZ1CcKVbH2pkwgJjcG5qO//8U5carOXZqPt2Jh0c0efavjHFr5YBf234JP1gDIP2Ujkj8AAmOghnawEfGV9IMtSMW3wXv2etEU/8iM318MMePrh8u7mCXVXZvd480BCkOsJlzkKJWip2g8cwOpcbKTcV4OyPUO3IckT5KNmDeOxtadxjH4cEOcdf9Uo1akWe0SKCebAMmiBeTZJx/U5iQzFW/t7P2VUC/U2PLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da6fc8e-a98a-4e5a-bcf8-08de529344b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:02:40.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkbelhMuMIWJU5VqyIaVPtAV4OHdDZalNrpEcNvNAKkZ70fTynsWpaQbr7acKEXqsEQmQEfiVdqe8pfjovogug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130093
X-Proofpoint-GUID: vGeoY63jQm8cpyex_zG6j7tHemT_ZBVV
X-Proofpoint-ORIG-GUID: vGeoY63jQm8cpyex_zG6j7tHemT_ZBVV
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=69662655 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=t18Owuh5Nn7Kg4ywImYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MyBTYWx0ZWRfX/ny+0ugz3vYR
 4It3z0JzPfvRgPYMR3XSlNrUYy8/fjSiG5Foe/ra9N1eYobp2DmRozNK0dhkNq94thtlvZ+EqXA
 nW4jazGscAEDeCvhJSo9n7EPTyktrtOc1l5zbhd2ZhA5Tkg4LmPVHhIrVikuwatbYOrolL6lqPt
 Xsjf9M34LaqfLuk9fwMW7REB5ROu0pwnEBAV3JHE6sWgYpWOq0WvE2gxJiJliGLlnvaBZ4DwzTw
 yUdpWhSi7xrocKp5/Nk/YJ+ocCMyBo7+hItoGdHGIm0YVsubZtXN9qIUNu1dlmOJBDARsX3FCZA
 evXQQP7SQgtyxWvIjfx9dFeMfDFrVye0fhf40fj08MBFdjVRg6d3JDQoXGXTb3R8D8eoTAdGf+l
 NBCwo4XDdo1lWFOc5wjG5z1z2s7PbgNsrNIiznZ4tiUYcrk32M7QIx+Mq9rct26/+pI2yEEApcQ
 IlHV4zFrVinWIj4XjxA==

On 12/01/2026 21:27, Jiri Olsa wrote:
> On Fri, Jan 09, 2026 at 04:36:41PM -0800, Andrii Nakryiko wrote:
>> On Tue, Dec 30, 2025 at 6:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>
>>> Following changes need to lookup trampoline based on its ip address,
>>> adding hash table for that.
>>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  include/linux/bpf.h     |  7 +++++--
>>>  kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
>>>  2 files changed, 24 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 4e7d72dfbcd4..c85677aae865 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1325,14 +1325,17 @@ struct bpf_tramp_image {
>>>  };
>>>
>>>  struct bpf_trampoline {
>>> -       /* hlist for trampoline_table */
>>> -       struct hlist_node hlist;
>>> +       /* hlist for trampoline_key_table */
>>> +       struct hlist_node hlist_key;
>>> +       /* hlist for trampoline_ip_table */
>>> +       struct hlist_node hlist_ip;
>>>         struct ftrace_ops *fops;
>>>         /* serializes access to fields of this trampoline */
>>>         struct mutex mutex;
>>>         refcount_t refcnt;
>>>         u32 flags;
>>>         u64 key;
>>> +       unsigned long ip;
>>>         struct {
>>>                 struct btf_func_model model;
>>>                 void *addr;
>>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>> index 789ff4e1f40b..bdac9d673776 100644
>>> --- a/kernel/bpf/trampoline.c
>>> +++ b/kernel/bpf/trampoline.c
>>> @@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops = {
>>>  #define TRAMPOLINE_HASH_BITS 10
>>>  #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
>>>
>>> -static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
>>> +static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
>>> +static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
>>>
>>> -/* serializes access to trampoline_table */
>>> +/* serializes access to trampoline tables */
>>>  static DEFINE_MUTEX(trampoline_mutex);
>>>
>>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>> @@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>>>                            PAGE_SIZE, true, ksym->name);
>>>  }
>>>
>>> -static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>>> +static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
>>>  {
>>>         struct bpf_trampoline *tr;
>>>         struct hlist_head *head;
>>>         int i;
>>>
>>>         mutex_lock(&trampoline_mutex);
>>> -       head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
>>> -       hlist_for_each_entry(tr, head, hlist) {
>>> +       head = &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
>>> +       hlist_for_each_entry(tr, head, hlist_key) {
>>>                 if (tr->key == key) {
>>>                         refcount_inc(&tr->refcnt);
>>>                         goto out;
>>> @@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>>>  #endif
>>>
>>>         tr->key = key;
>>> -       INIT_HLIST_NODE(&tr->hlist);
>>> -       hlist_add_head(&tr->hlist, head);
>>> +       tr->ip = ftrace_location(ip);
>>> +       INIT_HLIST_NODE(&tr->hlist_key);
>>> +       INIT_HLIST_NODE(&tr->hlist_ip);
>>> +       hlist_add_head(&tr->hlist_key, head);
>>> +       head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
>>
>> For key lookups we check that there is no existing trampoline for the
>> given key. Can it happen that we have two trampolines at the same IP
>> but using two different keys?
> 
> so multiple keys (different static functions with same name) resolving to
> the same ip happened in past and we should now be able to catch those in
> pahole, right? CC-ing Alan ;-)
>

We could catch this I think, but today we don't. We have support to avoid 
encoding BTF where a function name has multiple instances (ambiguous address).
Here you're concerned with mapping from ip to function name, where multiple 
names share the same ip, right?

A quick scan of System.map suggests there's a ~150 of these,
excluding __pfx_ entries:

$ awk 'NR > 1 && ($2 == "T" || $2 == "t") && $1 == prev_field { print;} { prev_field = $1}' System.map|egrep -v __pfx|wc -l
155

Alan

