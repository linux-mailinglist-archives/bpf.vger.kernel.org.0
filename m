Return-Path: <bpf+bounces-51055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A071A2FCBE
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A54F1887EA7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97024FC04;
	Mon, 10 Feb 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="By1jdniy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j+SydXpX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF41C5D6A;
	Mon, 10 Feb 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225722; cv=fail; b=r1Dx5gn17V+4SL5U970s7Xozfzx+EutecXqz/NSsIgx5HHrWQp4lKYoN6QnAhBAq/PnJEq6Mb/eu70KgdTMLfX3k3zeYnyDintWX4KRE9QRLzhmEISMjotlyvgA4S8w1Giip0xlXgwrrmvup5igmG48N4eo81sjbvwvCqJn8jkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225722; c=relaxed/simple;
	bh=30KO+B0bzB7cdFWa28+lGok80W4QGfhzsJKsWdO7xKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7Z624pqT2mc7AYN7SBBWtdr9FTf8DlSRlekBnMC+QB5QY0ET4GcEjoTnHjr48HlrBegDB30rGXg+5sjWug2W/SMV5ROTJbv6rHnoKatqKAPqmc8MeLBf95Ei2AJraMigb0O2iVcgBHmnw0JX2dWjkTl1iM2Y8ewBx3GVeBSQNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=By1jdniy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j+SydXpX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AKMiUs024192;
	Mon, 10 Feb 2025 22:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dwz+UQrCVEMoiNY0DdFfdA7nytF0USkUF73ULF8CaMw=; b=
	By1jdniykxXiQAb377aE9z5FPTmb9KH4/fahgn3PYYXE2nHNkSsDoaQ2Xyxa8ahN
	TqWGl8Bf5duvHeChgIk5Vlm9ot7/IT9m4OWpyspdKDSsPmTPQ63x7OyusO3fo3aq
	8F7ZZfKDRuZtaOEfu2grCwcluwpLFMgdui6CJeO0b4PeqUtT2u1SxazZvmo8QJ/q
	QBB4oyFmSUsUHRTwqND0MeWNYbqngUv9gl8i0Ab70eseza1xmlWasUKfCfY8BeR1
	imuQPy0tPICdNYg6c3SJ4P3U33jCNPQUsf9G26znC10cP7MIHtl/yuW5nITUCPz5
	I0g0Zmi6+hu3hakY1EK0Mw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qym3s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:15:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ALPJFv002665;
	Mon, 10 Feb 2025 22:15:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq81a83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 22:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQEe4rBFLMHhRMmPFjO1BIckPQwWkGdRMlkcxOTn/y33aiOlSvdPYYz84HklnckpbabwnZjCqsrDzQprqCY6ikXdQwb9gJpwTc0mmm6q4PjpR5XW2InMBLzpJOreumY1c2ckbD6IR79ynPw5ljpfYsm2N51CW1zCmUuuhXjHLbjS8KMzHvUosnNahIa/UhNNbmgsH4s6Ol1bxnSkU0cdNYhi/jZwBg8BnY8Nb2ESaAnj7w/W4dbhP1WtjKvnfgnG2dodCcNCmIauLwX8/N2waeRYM8HNuxYQuM7D4xvi63SDdlFAORZwZsMSZ+oAjFmRWnyCUWa3EI1/79HyyG4Ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwz+UQrCVEMoiNY0DdFfdA7nytF0USkUF73ULF8CaMw=;
 b=jXmmFPYCEPuTqQZMntI7veyI9EBUV03xu9EzlbLL+U4LctJ8NJKZmxRZANWz+LM3vxnoxCN9PrC0LPF+keu5MPuu906CD035Mp2xnrln9UxpT4xfgYIkYekLXaV7B59ZJ8bS519WSguqhoaMsU4jbiPi5Mcv/4CUSo1MyFZVBwt0QMUOmocpcmBC1oPbH/VDjbuAnm9hxBkjMKdkk7LQVh+rnqB+1qqXP+gkqXU6xTs5Ff7eMP3zbgxApyh82MOhT5EcravsfGWSxthMHaeSrrB4fQuHcBsPxc/4YC6tG4+robb4Lwt2o3pW1B3i9XCN/wheOK/NkjGtT7wurN+8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwz+UQrCVEMoiNY0DdFfdA7nytF0USkUF73ULF8CaMw=;
 b=j+SydXpXQXYDkyoblqNS802fG8kGV5XWaip6SayYmnYsWS6ewjHGY4y3K20lrTlT3kjSjCMQ1sGp1xKQwT8KmrsuqvhsGGeXwgeNfxhtr70OEhsuvIyt9lT4ENFWnibnCUY4Hv7FcLgNnjTrBQrMlCVhMX0ZDwogfVbrZeStKB4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 22:15:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 22:15:06 +0000
Message-ID: <f2b54a36-cea3-4729-bc5b-8524a5be50fa@oracle.com>
Date: Mon, 10 Feb 2025 22:11:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/3] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
 <20250207021442.155703-3-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250207021442.155703-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fe5f67-342d-47e3-4772-08dd4a205fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJwcVppOGRtei9kNG9qVkk1VkhQZmtnczh0Y3VQUzBmTGluNENUcjB1dXFv?=
 =?utf-8?B?UkI1RkVRbElLekZ6QThZYlZQdThZMTBZVS83b1ZDb2J2Zi9Wa0lnSnN2SjFV?=
 =?utf-8?B?dENxUWoyL1ZVMFp4OXUrRzNxWnEwcktCSk9KbktyN3lEeWpGWlM1cUZ0Y3hw?=
 =?utf-8?B?bFJkek9ySTEyS001R1hKeGhnKzZ0aGYxa2ZvbnBBN3ZrQnNiQ0dzck5UOGNk?=
 =?utf-8?B?M0RWc3Frc1R3VWN4bEZJVzA4OUNlS0ZYL0VRcWlyZ1JkMFJCcVZ2VjM5QWdO?=
 =?utf-8?B?VHNuRlpJUWsrVWduZEtDdFJiYnl3aDIxZitWelZGQXg0SG5ZWStCVWRDY0hB?=
 =?utf-8?B?T20wQXd6K2pWbjJFSmkvUlB1eEQySVlnVjBQV2psbE1FaVVkaDRxSU1lZnBz?=
 =?utf-8?B?QlBrdGYvSVBMaWNmcmVxdjFiRUltdHFwSTVWTDdadWNKNW9xaFloVlNPV1Vu?=
 =?utf-8?B?bU9jT0JpOFdqWW1rMkhNZTlOQWQ1K3BoaDdOaENGclZKT0Q1VUxGZGVyeElT?=
 =?utf-8?B?ZTc5ZENzeU9PWk53TGdoR0FiQnVQeHlMRXBVNExSMEhKMUc3aStwMmpGSWhB?=
 =?utf-8?B?QTM3ekszSXJFOWtTa1RybjlVN2lBR3k0aVV1dkJtTGN4RVhreDAxakFqTmVa?=
 =?utf-8?B?MThHV2orb3NDaVRGbThqbzlTL1BGTnJEZ1VDdURFb0JKQzN6YlNxV1JEaDBx?=
 =?utf-8?B?UEt1SUhKbk9YMWJBckVSSDRCWHNyUTNzSlkrb1p2d3JGRGJ6c080Y3h0L3RH?=
 =?utf-8?B?dXJUSzNyUnYyaXNyM3pZWnRrd3kzb0RweEVjSkpQbUQvNHZKWElId05Ca0Q3?=
 =?utf-8?B?N0xPazN1dzJxZHUydnYrcE1PaW5LbTM4QnhkVHZjYnV6b2l1REsyOVJMSVRD?=
 =?utf-8?B?SEpXUGNCN2ozeTNwRzZKZTRpN250QlBjV05ualJYcnFLL2VPaWFua0pJTUdU?=
 =?utf-8?B?QUVGcDBsMlVpRGxBTHpBbkVSUVJ2allIKzVob2pIeWhub1hlQW1DZFh1ZUp2?=
 =?utf-8?B?R1lWNVdjeGFOZTRZNnNHWUtudGt4cWtYZk0vY29IeXBaRGVzRENOVS9XV0Ex?=
 =?utf-8?B?b0VEbTdPeU1tTURNditEUkEvZzVqMVlhcUNPeDJ5aUcyM0FCQ0RLUml2ZjVz?=
 =?utf-8?B?ZmtmRk9aRHpTL1VOcG1lOVZxZHc4c0tGT08rZkhKWUNrbGFPVmt5cCs1SkRT?=
 =?utf-8?B?ZlVpZHBXVUpIQmlzWWJSVkphVWxhZFBFTHdEZGYyTUxvM1NlbGpOSE13Y3py?=
 =?utf-8?B?QlRkUzU4ZDlrNWliUm9YWnNQWUVCcjg0c1hBNnV3eFdyalNBVlBlaXJUeWdS?=
 =?utf-8?B?a2krQ0MxY0s4QjJMdGk0WThyTXlmTWdxKzhkTjJlZHdteHpzNWRxdkhVVUIr?=
 =?utf-8?B?azI2eGkxWjYvd21vclRLblIxOFEwZFhNZGlnakVZcGowaVFaOTFDd3RCdnBY?=
 =?utf-8?B?bWM2MFNoY2M3R09iRDdOakk0Zk5nRE5oVmVVN1VXakh0OENiWXlERUViQlN6?=
 =?utf-8?B?YTNlMStHMmFicEZ1M05NTW1aUkxqVis1UWhIeDdoT2pwUGdybWlSaTdsNjN2?=
 =?utf-8?B?NThtRU85NkUvaThleEprdXFtSHc4UHczTTJRSVVtekhKdEcybkZhMGhhWGdD?=
 =?utf-8?B?alRkeUpsREhxZ3hvV1RmM3YyMCszOEVKUWtESFRwdWRkQkJxbUE5blRNU0xK?=
 =?utf-8?B?bmNpVlJya0huS3hRT0ZSUGZnSHAzQzBDZjlXQkk3Mi9VVkpxZkc5ZEtUZEtW?=
 =?utf-8?B?ZFZUelhhdjlpSjVOY2krTE1vUDhhSXR2N2hZUTJWUXFMSGR1RnR1SmhENjJ0?=
 =?utf-8?B?OG1PVXJQM3RYVm9UTFVJMHdXT0VUdGg4RkJ5ZHFUYXNDbFg2TWZJQVhKcjc2?=
 =?utf-8?Q?RbMDnP66O0H4X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNIZjVFa0FGN1pJMEFqNU9vV1k1clVraGxzS0JZbTJzWjE3N2ZIQ2o4OU1I?=
 =?utf-8?B?dlBObnpIcTdBd0J5eTE4SlFnMlEybHJVVEJmMFpGNERsdml3bmdsdVFCNHkw?=
 =?utf-8?B?OHZDa2UrdVp3eENZa0R6Zks5czl0NlJ3TjNLd0NtaGFtazRuZ1hUTVBGNTZR?=
 =?utf-8?B?bzFiS2s2akZQblhybDUwWWQ3U1ZQSWNkSW1YVkMxWGxzbFNZZUxBdlV1bC9O?=
 =?utf-8?B?NnZ6dGlJOG9RbStGaXZ0aGVPKzFWWGNITDFBNDQxVXlJMnVZZ00ybUNHM1ha?=
 =?utf-8?B?OGZJWjRwT1M0TnlRbXpVTmVtMHBxTGUrdUp1aHkwcGduVFBFS0FkUEE2S2lF?=
 =?utf-8?B?dzk0aGRFV3MrWENXQkp2QU9QTHpGbUhXZ2t2TWEzMFMxSEpNd0w3aXl0d1dp?=
 =?utf-8?B?aFNFQ0pwUzRYZEI1RWRrUlF0cVY1WTNaUTRvdE9uZE9hVXFZRkZ0aTFZYWRl?=
 =?utf-8?B?NHRTczBBWWRJQzNkSGRoOXBrcGVYSk9CWk40QXZKVjZlaW1ScjNCNUhub25E?=
 =?utf-8?B?OWczVTZydFdianRKWVNwVGlNYVJ1Q1ZxbUtRYnR0VEp3RUpCbHZLVTZTeTk1?=
 =?utf-8?B?L0doamlNZElXQnFTT2JyaEQ1SjBnaXBrY3dOZ3pCRmZVZ1JFUUk1cmMzeDY2?=
 =?utf-8?B?eHhFa2hKK3gxNmZBYXBtWXg3YlBCdFEzSEk4Y2ZlR0RTVnNRM3lFY2p3eGoz?=
 =?utf-8?B?L2hLUXdJUUFtVDR1czhpK2x3cjhvYUFrUFUyYk9aNms2aGpwbmVhYkh6dW1K?=
 =?utf-8?B?cmJJdDZtWHVmcFc0VWM0YjJ5dzRxeStoVVZFY1ZzZ1ZrTllFWXB1QWpCK2dm?=
 =?utf-8?B?bXJzL3o5ZG5jZjcwU1lKRHlaRXlYUDBFTkcxRTh5VnBYakx2QmhNNWR0TjNx?=
 =?utf-8?B?R2ZiSTlvc0R4OHhoZGRyRWFEblV5bU4xaTNSbnVwcWpFQ1JsckR0ZXErbkky?=
 =?utf-8?B?Z3puU2hVWVprL1BiUFZRT1A2d1JTSTRiS2pmYVdoVGVISUhJbmlwRk81SVMv?=
 =?utf-8?B?c1lOKzg2bytrTGk1d2xWMVhGZ3c4TmFBMnVNekw3cEhaTUlibnd5SkVERnF0?=
 =?utf-8?B?SmRYcHNYdTh6Z1c0cXVjeUdZNExkVW4wK3JzanBQQTRiZE1Vc0RLeTJHTVlr?=
 =?utf-8?B?ZFN3bHowMTR5cnhUKzlQZ0J3TTJEYWZ2VTlyL2g3MTMrVEFvVWVxUWM0cWRK?=
 =?utf-8?B?MzJlVXVhVW84S0VuK0puNmNhUktRdnB0NWJWSFY3NEw5ckFqSnZzZW15Mmtl?=
 =?utf-8?B?VW9TdUVIejMyZ3Z1OFJNNkVuVlpZR3hYRTZNUHB1OVQweWxnb0IvUmFPTC9n?=
 =?utf-8?B?U3VZM2N0dGlRQVN5T3lGYjhhZVFrZXdFbVFoc0pBYlJQc2Zub2x1bmpaWUVj?=
 =?utf-8?B?ZHpKbTRUWTNkcG1RcUxtQnpNanJwTjlxaVBOUUd0NytJZHFHRUpvSWpQYSt6?=
 =?utf-8?B?dFdGbGVPTStRODJKOVZQMno3eWZzYzI2ZTAyVHFNZGFtT0JZWENvUE1LSGc1?=
 =?utf-8?B?SjlhT0V4YzZGOS9OV0dDWk1BbUlRbUFQeS90NFJZMXp4Tkc3YmU0MUozS3dz?=
 =?utf-8?B?RThFUWhINm5vc0lhU0tLUURCSkd2Z1Q0QkFtUXJEeDN3VTErUEcvb2l6Tm1x?=
 =?utf-8?B?QVY4eGNsSnEwRG9Md1RkM2tEbG1JS3l5WVV5bjdaRE92ODQzYkVPN2ZjM2h5?=
 =?utf-8?B?Qkp1Yk1iWnJVV2lwNXQ2NXJrRVZaVzRocjJITmhIZVVXY3h1VWNDYWZpK0Ir?=
 =?utf-8?B?QWJwMGNUR2kreXRJajV4emc3Ym9RWnNpTk1IWnpYaTIvM0t0UTJKWGxNUkhE?=
 =?utf-8?B?S1J1V3NVcEtwTzE1QmVCckdCUHo1d1BJeXN3YzU4RStOQkxySFZCdmt4SGtR?=
 =?utf-8?B?dnpYMWIrdm5QbUZNajNOejhKSGdRNlVLQ3lqRWxvVG1OdU03YXVZM29WVE5L?=
 =?utf-8?B?YU9DeC9hQmhFRkdUemt6cEVjVUlKZ3RldE4yd1IzTGNIOWFLWTNkZ3AzWXBz?=
 =?utf-8?B?dkVGWW1MalhXb05TUkNPRGtVS3ZWUG52aTRITzRIZ2VIaUtuMHZ4U2Z0ZlVE?=
 =?utf-8?B?a003eXhERkJlY2Y0UlNoRkkrZ1hGc2V1YkV1ZSt3MGdiOXYxZ2JEc3RaNVF3?=
 =?utf-8?B?RHZKd2EreXZjelBLMUM4R1FOUEdUaFBnejRsQ3NncHBQWkNpRitPWitwSVdC?=
 =?utf-8?B?QUVyL2VOcWRPRDk3KzlNenJnV0NQNU1QaS9RakwyWGpNVnRTWWtOOWd0eWxi?=
 =?utf-8?B?USsyVjIwajhxMUM0aGlXdThLSkJ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q5QbvM2tm0EMD/up5L7Q+FguDnkab3mhECuTNyh5VL4KM5NQthvQqmphgNh6utOVAxyrTpqbnl8CtKT2FEhCfddWV1fJ5f4LrSMMVpUjV3i1zFBAsck1cp1EnshprDnRTdq7AxQ+QdSJdWbTAqN87WiUtLqZpyyZ1kB8xv6KwC2p2VOPYoiSNmp/z7lqE+0CdMH3IMHAFdsUkmYtsT/04KCZdMcb9TKIPM3dbFER2dquOyP/LPKYqo9ijR20o0hLFeRV8MgwOvPGwAwHtUzmHbmeAxel1oqbag0ZprHwfs1bs4J6FdI0NNr95rcz5zwieLKB+OvBJGViIGQpiCynp4VI2w8nCOlQ/QiIcykJmFjskzV4fdusY05z5Aoawn/PuxFujBFHrDX1kpmWv+ged0rprYmd9wTAU5llszEsdvwr/rBOCImtV1rdeu/psLF2HR8bpEF4x88LkXLwuxAz0GIY3+mRl0sYzTH6kNvd93WQ6pT6UHIzrOgah0xcelgRUEyYnEpzkCK4u7Ty2NuCPKNOqQxbfTUQKnrF/3j5dEGph+1DWyS1Wgi61+HZYB8YYKDeZOVxtRDA1uotRglyoyp/NQJIxboWTR26Na5oWJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe5f67-342d-47e3-4772-08dd4a205fee
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 22:15:06.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6RtNaJmivLLWY5hn89ospGMtP6/fxVWwxDAbstNZWhnj2gohGJ1PZXAJ5O/hesvJT2FoqahICsvqMfA69IkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_11,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100175
X-Proofpoint-ORIG-GUID: VGXLpQYRE990pnV4r3aSs5Xe6HsdR6sO
X-Proofpoint-GUID: VGXLpQYRE990pnV4r3aSs5Xe6HsdR6sO

On 07/02/2025 02:14, Ihor Solodrai wrote:
> When adding a kfunc prototype to BTF, check for the flags indicating
> bpf_arena pointers and emit a type tag encoding
> __attribute__((address_space(1))) for them. This also requires
> updating BTF type ids in the btf_encoder_func_state, which is done as
> a side effect in the tagging functions.
> 
> This feature depends on recent update in libbpf, supporting arbitrarty
> attribute encoding [1].
> 
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

a few minor issues below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e9f4baf..d7837c2 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -40,7 +40,13 @@
>  #define BTF_SET8_KFUNCS		(1 << 0)
>  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>  #define BTF_FASTCALL_TAG       "bpf_fastcall"
> -#define KF_FASTCALL            (1 << 12)
> +#define BPF_ARENA_ATTR         "address_space(1)"
> +
> +/* kfunc flags, see include/linux/btf.h in the kernel source */
> +#define KF_FASTCALL   (1 << 12)
> +#define KF_ARENA_RET  (1 << 13)
> +#define KF_ARENA_ARG1 (1 << 14)
> +#define KF_ARENA_ARG2 (1 << 15)
>  
>  struct btf_id_and_flag {
>  	uint32_t id;
> @@ -743,6 +749,91 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
>  	return encoder->type_id_off + tag_type;
>  }
>  
> +static inline struct kfunc_info* btf_encoder__kfunc_by_name(struct btf_encoder *encoder, const char *name) {
> +	struct kfunc_info *kfunc;
> +
> +	list_for_each_entry(kfunc, &encoder->kfuncs, node) {
> +		if (strcmp(kfunc->name, name) == 0)
> +			return kfunc;
> +	}
> +	return NULL;
> +}
> +

above function is only used within #if statement below, right? Should
probably move it there to avoid warnings.

> +#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
> +static int btf_encoder__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
> +{
> +	const struct btf_type *ptr;
> +	int tagged_type_id;
> +
> +	ptr = btf__type_by_id(btf, ptr_id);
> +	if (!btf_is_ptr(ptr))
> +		return -EINVAL;
> +
> +	tagged_type_id = btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->type);
> +	if (tagged_type_id < 0)
> +		return tagged_type_id;
> +
> +	return btf__add_ptr(btf, tagged_type_id);
> +}
> +
> +static int btf_encoder__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state *state, int idx)
> +{
> +	int id;
> +
> +	if (state->nr_parms <= idx)
> +		return -EINVAL;
> +
> +	id = btf_encoder__tag_bpf_arena_ptr(btf, state->parms[idx].type_id);
> +	if (id < 0) {
> +		btf__log_err(btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, id,
> +			"Error adding BPF_ARENA_ATTR for an argument of kfunc '%s'", state->elf->name);

nit: since we call this for arguments + return value, should we reflect
that in the function name/error message? maybe pass in the KF_ARENA_*
flag or something?

> +		return id;
> +	}
> +	state->parms[idx].type_id = id;
> +
> +	return id;
> +}
> +
> +static int btf_encoder__add_bpf_arena_type_tags(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
> +{
> +	struct kfunc_info *kfunc = NULL;
> +	int ret_type_id;
> +	int err = 0;
> +
> +	if (!state || !state->elf || !state->elf->kfunc)
> +		goto out;
> +
> +	kfunc = btf_encoder__kfunc_by_name(encoder, state->elf->name);
> +	if (!kfunc)
> +		goto out;
> +
> +	if (KF_ARENA_RET & kfunc->flags) {
> +		ret_type_id = btf_encoder__tag_bpf_arena_ptr(encoder->btf, state->ret_type_id);
> +		if (ret_type_id < 0) {
> +			btf__log_err(encoder->btf, BTF_KIND_TYPE_TAG, BPF_ARENA_ATTR, true, ret_type_id,
> +				"Error adding BPF_ARENA_ATTR for return type of kfunc '%s'", state->elf->name);
> +			err = ret_type_id;
> +			goto out;
> +		}
> +		state->ret_type_id = ret_type_id;
> +	}
> +
> +	if (KF_ARENA_ARG1 & kfunc->flags) {
> +		err = btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 0);
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	if (KF_ARENA_ARG2 & kfunc->flags) {
> +		err = btf_encoder__tag_bpf_arena_arg(encoder->btf, state, 1);
> +		if (err < 0)
> +			goto out;
> +	}
> +out:
> +	return err;

not sure we need goto outs here; there are no resources to free etc so
we can just return err/return 0 where appropriate.

> +}
> +#endif // LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
> +
>  static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
>  					   struct btf_encoder_func_state *state)
>  {
> @@ -762,6 +853,10 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>  		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>  		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
>  	} else if (state) {
> +#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
> +		if (btf_encoder__add_bpf_arena_type_tags(encoder, state) < 0)

kind of a nit I guess, but I think it might be clearer to make explicit
the work we only have to do for kfuncs, i.e.

		if (state->elf && state->elf->kfunc) {
			/* do kfunc-specific work like arena ptr tag */

		}

I know the function has checks for this internally but I think it makes
it a bit clearer that it's only needed for a small subset of functions,
what do you think?


> +			return -1;
> +#endif
>  		encoder = state->encoder;
>  		btf = state->encoder->btf;
>  		nr_params = state->nr_parms;

