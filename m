Return-Path: <bpf+bounces-71876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE2BFFF7C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C003AD644
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8657218AAD;
	Thu, 23 Oct 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T79Re9NO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AcNx/O0L"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F9301487
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208771; cv=fail; b=dVQLaWRK08T7QuXl+MDp2UKl43uYS6ED2cE3OwiWnxm1Db6gdrIKgJ6kmkYxspo7IunLi0yUYRtJ5AaKEteItFGuRl51KYkTV7xUCo7MhTTxT/vzXwzisr2mX7e336RfrmGs/mLKFCiGHPhYNffew7BuD/DR31LAP7AbfIAZub4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208771; c=relaxed/simple;
	bh=C3w0vI2fFox1hckCF1h+e2EglyS5e2Fo0nJXTtdOaTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHLoonPCrD1GnVYwZvebSKmWT6o9gB7bETYqu1/muV0tkzbjO7C2lkHJBj703KdYte9SQGk7q2/UIQRcKPx7Hr+kNy6uLhrAALtkVqlc2R1z9L784Orw9A2EHe1FZvQnFGEnDo2PH3X7pdIMVQX0PX3R5zAz8BN+oQk5P82nus8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T79Re9NO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AcNx/O0L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7ufTi023058;
	Thu, 23 Oct 2025 08:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9aOQoYv9+cZZdP9Utci4D13DD5cc+vBbIzn6MYjdTzw=; b=
	T79Re9NOEAHolLig1EbwxrlABoz1xZqorPQBJdtLTW5zj+XpZsJxAgVemH+n+Tve
	18MTzTg3hHtOUuJXTiQDI2ykShJmlLKEOcZsKYJsvAb70zXXDojA6wyvGuGXJzUP
	EXQyHcDXbOtPXOdEifdCljrkj/oRzh0zr/+WD7LUTInG41clGhPSWI1ELgq48rMA
	2MM4df15JKe3ufmDT0f9OYyMlYq8gf1Q0AFocpMGWvp86kI9t1F2n4jNt449QJBr
	DtEhoORcK4fg70+1v5imXs6NkUx2KSIKrhi3NK8cO5n4CyZd2b3RUPUM9j8BeHwy
	hxbO9NRsHnnQJ0lD66GLnQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3kt1mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:39:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7P2b5022260;
	Thu, 23 Oct 2025 08:38:52 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfavmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOYNqNOEWBTEQEVAh3is6RUcstNZ5XDEbMvR5zJVdafCCGDI8xcGq0y7V3AWyY1us4LWSs4E6dHUaUA0nhnMc9nnaXqtrPq0KeXjrmP32l8dzLtHntgMAaFyJ8nrmWqxEzJwySDUYkoy41TzvbTVlqUllBK0Dsez5bsWPzmzTf4cCPzzpoKxRtL/zNIFGE55cihi9iQbRnh/BNDxG47zi58dEZQn7yXnMzyq5CbGN1wzna07C8TUMEsZyOOENVJmA1Ag6FRIkdCQOnPwkBeXPsotz16LJP/pmAEUg7zrkLoeAdFrFcJ2wBMmDbB0SBbQSfQGHmSoGzoRJhgc7LbU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aOQoYv9+cZZdP9Utci4D13DD5cc+vBbIzn6MYjdTzw=;
 b=sKSVJgYMKcaZp9FBuaTbDXLmD6NC3vFvi/CJMYpDVNXZheBRR/bRSz13Rbo+B6om175HSyluPUL2QZFIfExGVL5Ws3ZLXatXsjHlZJyY3aCMCKhI2kBzc/cXYCikR9I+X5WLwZXu/jNiNo+HDl2cm88x8Rd18EVLSfB4JsTe/mjgCiPw5uibWEzwwNWESoorhQ35WTfN3j3aTxpZYkYrNc86FciOepg8NIxjIoVRNZi1wd6zf8SUq0kR0po6tWiwlWGRyKkkQBnTnGIpkUhY4lLl1KJRxafeaPshlW5bXxcmTuwGZbp2NxcKHGB0mqRGhpJsUAYt7rmOp3ub8YGkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aOQoYv9+cZZdP9Utci4D13DD5cc+vBbIzn6MYjdTzw=;
 b=AcNx/O0Lmx1xpJje1CXTLBZqVWUmPrhadO+krAlFp0LY5aPkTpBrwhIO5WcW5otyX5g9EbV3gSYIcMMiyGFC2wJjIE92gHTl+eMZTzUdfaITn6PbiUUMU2ZYioZ0NMr5S6fri5GiaX4/9kXx/ggh8E9YAyKLqTNxKShMkQ5J7MU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS4PPF415C917DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 08:38:50 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:38:50 +0000
Message-ID: <b2aa8474-cc33-451d-8529-6efdc5cd9810@oracle.com>
Date: Thu, 23 Oct 2025 09:38:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 05/15] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-6-alan.maguire@oracle.com>
 <bc3b203185107bd68c64458e0c71f68cd16e8595.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <bc3b203185107bd68c64458e0c71f68cd16e8595.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS4PPF415C917DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ff69f7-837c-482e-8c9f-08de120f96cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWdvSHdVbUdRK2V1Q1JDOFpSaktqRlVPa0prMW50bXFScUVTeW1oSHhFR3l1?=
 =?utf-8?B?b095ODRiVkxmc2NTNVBxZnhVZlI0VlI4eFlKcVRLV1R5SVhMb29nRlpUWjd4?=
 =?utf-8?B?bHNiUHdFZTVuaENiK2R1WFE2c2NFK0Y2VXRldHNuMGY3NExOdVNEcGZnSHZT?=
 =?utf-8?B?dEpVSnBOU2M5MGhjZXQ5Rkp6SDNERlQ0dmlsa1RNdE1wQ3N5MlpOdlBsWkhL?=
 =?utf-8?B?RDQyMlFrc3RrQ3ROSVlTQ1VWQ3FWUVJHQ1RTOXZSeUpSN1JQaWEvUVVKU0VE?=
 =?utf-8?B?ZWF1WTc1U2J5UWhBWnlvRTdUK3ZCc2ZIM0pLU1cxVUFBZ1dKa0Zvc001NzZL?=
 =?utf-8?B?MmJGWXRWYUI0S0JnN3llUTR1aTJ6eU12SkN0TExRbll3bHFkUXVpR1ZLcERE?=
 =?utf-8?B?bnJwQWFyeXlNQkNmVjVjT3BqKzBnRmJSTjBxazgwelhObnNUUTliTmluTnFz?=
 =?utf-8?B?ZUVPckJldmR3aWpPVkt4M3FtbnNRcTZRZEhtRzIrcm5kZGovVUZES1hxcnZS?=
 =?utf-8?B?K3oyK2M4SGJTTEpBaGF6c0VzaG1kVktzT25oUktyNHc1TkJVNU1IOXczRkc1?=
 =?utf-8?B?YjB0Z2h5OUsrdDRQeCtjL2tISkkycnNaZVY3WjRKenNNQmREaVJpZGp6UTFh?=
 =?utf-8?B?WjZjcTVab08vaEVLWE9Va0pPQk1nTmlMYW9tSVFSVklWYitaNXNVTWIzcEtE?=
 =?utf-8?B?OVc2QWRNc0JVUGFKRmMyQUNOdWhGdXZaZTRlcXk5TWliM0xqOWlRaUQ3cEpF?=
 =?utf-8?B?UlF5NlpkSlFFa1VwQlEvaXZ3cUdETFhFa3Bhdm53cTFsMXhlVkN6WGhOWXBZ?=
 =?utf-8?B?YU1SRkdzMk4raHhmbGpVMEpyQVF1S3dod3ZHZXFpN1V3aEc1c1A3YXJxUlFL?=
 =?utf-8?B?QUJhY1krM3o1SExJYkJMRkhxYzQraFFUQm1NTnJuWGNCRGhuTWZ0S1ltMENZ?=
 =?utf-8?B?TlJCM3VteFhGdnJDYi9Lc3lXb3p0N2RRSWwwTUZibUUxVnh1L05CUnBPUktZ?=
 =?utf-8?B?OWpFdmVvK21sZWxJWW9jaklhb2VFa3AxQkRyeXRhQ29xRzdGTmxTV3djdEs0?=
 =?utf-8?B?eHZYZDhCaUg5UWtTWVQwL3k1NG9CcXZJV1BMcE5zN1UzVkUxTUxubnMvTEg2?=
 =?utf-8?B?aXR2cFN3bm1nMFRUV1RJMjUwYmtlOCtOK08yc0MrUnZXdlRIRExrYzJFUitx?=
 =?utf-8?B?eWpCbDA0U1JPUmZ0Q00xNUs2bUI1NGNkVG5ZeFd4OGhBb3E2Y2N0d1NuRFZG?=
 =?utf-8?B?TVdPSFhzMURuNnI1STErQ0xnKzhkaUlvd3BOUlo2VGJzTlN5NHFtaEJFdHI5?=
 =?utf-8?B?VlJZODYzeVNZWEZoaHZKVXFHb2YxQ3BqNHhOLzErQ3NGV1pFd2QxY0VzdzhR?=
 =?utf-8?B?SnZOSjFYYmFmMFpDOEhPMkNjZEZsVTVhMVFKTUNmNVptenBnRlBKMCtKRW9U?=
 =?utf-8?B?UnUzUG94elNtTCt6ZWdoUU1uZFZ2S2MxQVhoVExTZEUweEdnZVcyZFlDc2pY?=
 =?utf-8?B?NlQzOWRoRzB6aTNlQkNaL3dsVEJJaUF4ZTA2bGpSU3lYRWpUN0hPMWtZV2RQ?=
 =?utf-8?B?Q2FTSVJZRGtIVWNWNzFwbU10TjBQNDc1S0dueUQyMXJIRFVQVEZ1Z0pSSzZY?=
 =?utf-8?B?WUlZbmRjMERTcThCcWhyYUtWanBIdnB6LytEak5QMXZ6cTNmcmRLMUZvR3M5?=
 =?utf-8?B?N2dYL0VmNHgzVVlZZmNZQURUREJrMHVueWVKeEVSVzVsbFpvcHlkcUVJQmF1?=
 =?utf-8?B?ai9lUjJIalhYY3lWeEdEekhNT3BkWk0xbFIxbElJNFAvbGxseXU4RTVhNmF0?=
 =?utf-8?B?bURNdWdRYkt5dUZnTUR6TTcrQkxhZmlhT1hlQmxZVmE0SVc0MDJmdGdYU1hV?=
 =?utf-8?B?a0czYjIrdEJaMUxMZHNSMDh0bFp2STVOWUtIRTFQcXJLTCsvMmhVRS9JQkVV?=
 =?utf-8?Q?YuLtNeE1YlVPZ/0gVqcZvDBFt+06vPqs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjdtWUNqNjgydEs3YzhTYmNUbVdvRXAxbitqVkxpTEY4L3U3VktHNng3cWp6?=
 =?utf-8?B?VFBtcUJYWVk0RkYxcGJIaWtDcWs1bEkvVTNpQ1QwVllwQmFwSzVzS0VhUy9i?=
 =?utf-8?B?ZEh0OTNNN0pmL2E0WFJ5NHlZNzBIek1Yb2JLSmxSOFpRbzl2MHZTUXJ0SmtW?=
 =?utf-8?B?eDRrU0JSNkhHbnZienRleDlWM2hPZ05ob0o0Z3pXM0V5UTZJWnZvNkVqekEv?=
 =?utf-8?B?QjcvZTZja25MaTBIZ2wxQVBuWFhGYlVIbzJvL2Y3S0pqeDJXdnNxL2ZpajdO?=
 =?utf-8?B?NmRJMGZNd0VIN21IYWZFRE5PRFNjY1JEMHRTVmJkTFl6UWxEc3pUL0RRVEFT?=
 =?utf-8?B?b0tDYmxvcG5icmxyZVZod2JlWk4rNnNoeFNVNitkL3ZuWkpCQzJVRVdYVWNI?=
 =?utf-8?B?TCt2R2tYZjA1OGFNSDQyYUhBeXBHemM4V0lXZTZqNWdtTXFFajQyRlhsTHU4?=
 =?utf-8?B?REdPdVJ1R21Wbm9jaE4rVFM0L1N2TnN4NFFhek8rbVBHY1lqSWoraFhGTTZT?=
 =?utf-8?B?YmhJK3hYa1hHK2gxcThHRVY1YlNzY25qRm10RlhsU1NGRFcrVEpNb3lTYThB?=
 =?utf-8?B?cUdveHUxSTV6QWx4SmVseXUyZHErTkpWNFRWTWFHSWR0RXV2eWJCR1VYRDl5?=
 =?utf-8?B?aUYxdTZsYUJnTkhIa0tNZjZtYTFSZHRydDVxUm1ONmJiOElUZUVBZURrbUo0?=
 =?utf-8?B?Q0pKSldXdThVVHpnbUtoRXFmVnR4R1B5K1dhUmN1bFJqZDlJcW9tR3Z2WUV0?=
 =?utf-8?B?NkwyU2J5Z1dJMVFmT1Evd2w4MGQ1NkF4azgzN2VFRlI1MDBJOEM5SHRiQlp4?=
 =?utf-8?B?WHN0aUFvVUdxNnAyMTBNQktmSTRIQWN5YjU5UlV5MmpDdXZHaUtacmUzTXEw?=
 =?utf-8?B?SHl4dXc4dmZPRjJ5MWtqYnVMUXV0OXVxRkFXdXN6ZUFHMjNmaDBpVUJqS1h0?=
 =?utf-8?B?KzhlRm54dzJubXQ3QVBONnFVbmxNMktQdUpWQnhoT2w1R0kzdDdJQStIWTVQ?=
 =?utf-8?B?UW9qQ0lMS3RZMkhJVGdYQVhMYzJ0Q2xicHU1ZUtUSFdyaWo1NG5EZmR5U2xB?=
 =?utf-8?B?MVZwenMxaWxobTR6eDlLY2xyeC9FRS83b0sxTXJsSFVSVm9mNGFwY00vYVRp?=
 =?utf-8?B?OURDZkxpeVZKVy9sSlJNUmp3THo0OU9ReXh0WW5iOXI5aHc0eFBQZlVrT3BR?=
 =?utf-8?B?TERDdmQwSER1TmJLUW5BOGtnQWVydDVMZlM3OVJjRGNtMmRvOGVZMlhnQUph?=
 =?utf-8?B?ZWx0Tjh4amlQeEw3ZDI0WXBZZ3dodzFrVi9xdUQ0YTVkcDNld25lSFZYY0lO?=
 =?utf-8?B?bXZDTENDdkd5K2gwSXhJeWFnY2RPNmZnRkRialVkSU1ML2xzUVY2dCs3bG1w?=
 =?utf-8?B?M0RCWHZDSHJGV3I1ZnZUWEFkQW5KVUFpRlFneWNzZEQ0R1JHaWdOM0w5Mytw?=
 =?utf-8?B?L1Uvc0FaTVlVU2ZlRCtlZzdGbE9rYWovNjVSUEc5NnVqc3NvQWVjcGtLRWJv?=
 =?utf-8?B?Y0Z1c1lPSXYwaS81L1pMWjhDREdQYjVmUFRYM1hYclFYVXA2bFVyYkJmelZT?=
 =?utf-8?B?Tm9Ja0FEQ0c4aGpvSEMwUzY3SU9KY210Rm9scFNoM1czMjJYTFNDbmx2NU1K?=
 =?utf-8?B?U3RZRnlnQ2pBSEtta1lBQUxVT3lWM0l6dkJEL0xUOVdVK3IyN0t6aDlhY2dD?=
 =?utf-8?B?UWN0MnpkVUJWZitJMG1aSmRya1MvdzlkckNGaGZjMHltZEJTS2F1UGx4cWN6?=
 =?utf-8?B?ckRqRys1dWluN1VhUk9ydHdUUVBNenVhYmwyNDg4eitERnB2enJ0azduSnM4?=
 =?utf-8?B?TmRhRlljUmJZZTFOMHpHcDdGdzFkMXpjV3BISVU3cU9zekRTRVNhRGN1Uy9D?=
 =?utf-8?B?Z0VCczJDUmFPdjQzdWtDQVZxRm5vZTlYL2Q2OGVhbytWT1RyZHFpSVBSczVr?=
 =?utf-8?B?ZHI0OVdnTkx2M2dXZ1dsOEcwYmNGUHYxeWp0RVJTK0RMNWJQNzJUQkFGeUtK?=
 =?utf-8?B?bmhtL1BXMU14eHdFcC9jVWhabmc4N0h1QzVBZUZxYVhGU2ViSkhOZlowb3VV?=
 =?utf-8?B?aTFDTGRWUTRIZ3ZuUE1uSVlUUWxGbHhNUmZXNlI3Skk3dEdXa01yOHVkaXJ5?=
 =?utf-8?B?NDJXekxmaUpKOWMyTHdFVnEvaGFPMkpjOXl0ZzU2c1BWTVQ1VDY2Z3JNMU16?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8CJgWKn2lreBR1AZXoT3Q0tMltVuUBL+dGuHfwIczSmUduo16v7Ut3HAJCNfGQ61HOicaAiNIfWu09RqBdC+w79icyyoF363DvwGsmQlNUtMh3BOxnm8YUOAaBI3RUlfa+KsbMvh3GJNMVnBVXQ1yckAGpsLo3Ii1B/XJ1zLdFhYmVpzADE4lZXXjgCN7fCtaVJ+uk+14gzcv0so9Cxr6BuURDBigh+nJvaab0b3xEpPR7mk/v9fUHAhMTpcoPydC7IkYdv5whU/M2rSkB5YyTJJaW6giWKGHuujOePCU9nB1zgGq6LmZdE2djdlSYovQbdkdC589ld7dD67EDsdMLAlGAI10Fx/tHz2azuSw/28Ko/3/vRRIU+riqBaQ7LNv2jy0LAXFWaM197U40Bxq8tEtWtDjynwEA1phR90z+yisyDD2vKOV/d27Lsp/OFtmHXEld7KWm+V6eQH1vRsQrzhhfu//xQ5YFGg8vC5wDhKjV4jUXyO6RZ2Vv6KRJGYnTQLc8cJVT0Jrsdzq76PuMUiozVYmvsxRSA5uKp96kimnaj7D7otxDQDo0wG/cdF1GmyQbw16jrXcV+yeMj/RHrWYgs658s9srG8R6VV5yU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ff69f7-837c-482e-8c9f-08de120f96cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:38:49.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaU6ZemiDOQpF1t5Cx4Gaih3zgP2vSF/KEW0DWC4mExe+8J5D0F0/fAYZzywHril/Var/jAcSNJJQFH5bBNlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF415C917DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230076
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68f9e9a5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HZrzeS-cu5zmqGKVGVgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: DiFcgQW_Sci3dpZUhadiL636qJe2pn1N
X-Proofpoint-GUID: DiFcgQW_Sci3dpZUhadiL636qJe2pn1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX4mUccu2/3XiE
 3voPVKEn6xTmg4huqePmggj3o2TJ+dxSHEXzs69LufwO6FYkiegtipEj9cy1e52PWYGTRdTjbBW
 ZDJj6Bq2M6hKRIsaqIHLgr22b4ul5ZTdGkM8rYL+2+ibot345hWptRQITSBS7aa5Fus/HB0AA6v
 ws7WlBR6BDlaTYveMGKW50FpRwmHY2fNVBYD0JP2t7xxX76HPpBoWnyXrPFOPe3qPG6ztVnw+sj
 5SH8aX10H8E4YwfaiCBFsK4nkd9JuxbJD8ebvJvHl7g54G/qeeIAA8+BWZRHKw0X6D3l+hAtGz5
 +9CVpUDGAskNzVdTlOJLwH3NCBml05GOnNkOvdJv5wiPRUGJggRgZB38RINurar3mFS2bueoBfL
 ik7QY4INrdX/pyBBgYkMe44P0T6h/fCtVSQysejQ8B68FLxe8PU=

On 23/10/2025 01:57, Eduard Zingerman wrote:
> On Wed, 2025-10-08 at 18:35 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> @@ -420,6 +423,98 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>>  		}
>>  		break;
>>  	}
>> +	case BTF_KIND_LOC_PARAM: {
>> +		const struct btf_loc_param *p = btf_loc_param(t);
>> +		__s32 sz = (__s32)t->size;
>> +
>> +		if (btf_kflag(t)) {
>> +			__u64 uval = btf_loc_param_value(t);
>> +			__s64 sval = (__s64)uval;
>> +
>> +			if (json_output) {
>> +				jsonw_int_field(w, "size", sz);
>> +				if (sz >= 0)
>> +					jsonw_uint_field(w, "value", uval);
>> +				else
>> +					jsonw_int_field(w, "value", sval);
>> +			} else {
>> +				if (sz >= 0)
>> +					printf(" size=%d value=%llu", sz, uval);
>> +				else
>> +					printf(" size=%d value=%lld", sz, sval);
>> +			}
>> +		} else {
>> +			if (json_output) {
>> +				jsonw_int_field(w, "size", sz);
>> +				jsonw_uint_field(w, "reg", p->reg);
>> +				jsonw_uint_field(w, "flags", p->flags);
>> +				jsonw_int_field(w, "offset", p->offset);
>> +			} else {
>> +				printf(" size=%d reg=%u flags=0x%x offset=%d",
>> +				       sz, p->reg, p->flags, p->offset);
> 
> Did you consider printing this in a more user readable form?
> E.g. `*(u64 *)(rbp - 8)`?
>

That's a good idea. However currently we use register numbers we get
from DWARF, so would it be more confusing to see something like

	*(u64 *)(reg1 -8)

Not sure (we could translate reg# -> regname but I'm not sure where the
right place to host such a translation might be).

>> +			}
>> +		}
>> +		break;
>> +	}
> 
> [...]
> 
> 


