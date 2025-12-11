Return-Path: <bpf+bounces-76459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB9CB5246
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 602813015875
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC122EB868;
	Thu, 11 Dec 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MInnOerZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ju6Zae9K"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C929218827;
	Thu, 11 Dec 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441973; cv=fail; b=iqKUcn8zBeC0fbY+XlNNk/cCeihsxKfqe5f6AawHA2nqHsNOenxbTczuPJmUbRjNixgILvLsfeteT394vuvIOJXyklI6mRHeJEfviNGDMZwrL8eEuLAp2SouQkfFZ99h30cbwuX6XsxcGfuzJ8ycSsfKL/ZZYCW+cH45O4pdrGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441973; c=relaxed/simple;
	bh=kSUJzqGyKVRivF8t4ILI5GSTNnIMat2GLfnQ+AoEmH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ryc+sAcidNSFptCcOe6IM0PW57jZf6kHjA9jakwQfMykO56DPze5zaUu8tM2NkHyQy9nC2mehEkqUM4y2WqeJopWeLPg41Z4db0GXxe2wZNq8nj0LPLZtPnqC2FoZdSmBA5b89bG1RCYHNuS93rnwrZbfM/+HI9cbNzx9bcFzfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MInnOerZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ju6Zae9K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB1hI4g484755;
	Thu, 11 Dec 2025 08:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4N02kFYjYPTUw6qgzU99k2VZViWOuErZIFwk8/P0KiM=; b=
	MInnOerZhle6GoBXv9ASCiEtrSZGWRx//imi5ci15uRs9iJRJP1GztJ24Kf+t4ZT
	WLPUujRWzbti56B1r7tHFeAOPB5xnD7sB6JNxRGnHsaVH6VZncge82wnHNKi6use
	e3TAorguSxmgaBO84cgqvgiWwXjUvFKOnAJbiVfhbv1visYyuvARjh+fKxgQYeV1
	87QaB0Dv3eM+4I+PiISO+KkGrxnYgIOsGxleQ33xi5Wx6TMCFC9D+Iubh9tgcr9s
	Lgkg+yfgoo9fFPD0RgC7U+edtDMwiR0BB4EHSRoEP0M+y6k30d0T5Z9WQZOjWr+e
	jhhMlVmxFECgnT8+waQllw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay9y31d4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:32:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BB6jCY9020801;
	Thu, 11 Dec 2025 08:32:09 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxbjwsd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 08:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mpqt9BjexAn5olwWl0ZgDHcXl0EUrr+eplFbxIc7fFXMxPBohXJVSVEtKsWYghEB9tTOZaegtkb/eQt4U+7BcbRiL57DEFxJ2V21hqKJi3/yKBij9jpKrt86tkXeX+3rAGHmRT+RdcJNOcgYGqjv78mx5Ft5n88KDC7HAv2wEcEOmu6xY+jLiMZSix9VgWCfDtLIMq0pGBHL8hnVqAcauMs+4oKr3f79QOX4jNbUcF3cwHQrSGSQ4XQ4j0un0fV4BE6+LY4oO77IZRWK1jP/JQmmRKnPB03MHl7HtUtao8l8T/dsj2i1iEjHIW4QcB5HRBftHeV1vKHEk79uwgol5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N02kFYjYPTUw6qgzU99k2VZViWOuErZIFwk8/P0KiM=;
 b=enJV1DB++X8Dwl5c0bvKZ48s3Y4bDSYDAGVkE97oqXfuKm5SIEdBNTpj4pjBsPDSKPXGBX3f0w0mvIMzXLV7I+Yf7iQi2yN0c6pwOhM4JIJqyi88NNjRXfHwutPdgQOYrdbYcdaJUJ6psfnU3Dj1UOaffuz40sEuT/AtT3cKYUHFPMG9PINfyJqke7GR44On9jpEXQlbmZukkaejc3Vtbeyxq30rnJI7t6ShPMDg5tr0zXcVjrsLpI4wXA3XztAc8l42L0tYRBkEBNPGVk4ZcvCXil8huNoL8pJIPFUP919vLzZsDajO6YnRdkuzh2YdLxpfv8w/EJJrTx/rIwvwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N02kFYjYPTUw6qgzU99k2VZViWOuErZIFwk8/P0KiM=;
 b=Ju6Zae9K86kZ7iCXAFBksnlrgkgKuM/YLrJ7cpP0dz84+Rd7ESQlkbAZCCoaLQAgYb0FAjnPTgU+dDEI2WqjUYtxaF6m2YuFqOUZhnIs629Mg2IJRY5gUmN9vKp4a2HWyK/VPI3U2pmi9aEm2bDwmfa15Cp5Pchs8WXQB/GcQDQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH7PR10MB5748.namprd10.prod.outlook.com (2603:10b6:510:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 08:32:05 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:32:05 +0000
Message-ID: <21ce7f3a-25c0-4f46-98ba-1d76a43e7935@oracle.com>
Date: Thu, 11 Dec 2025 08:31:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        martin.lau@kernel.org, clm@meta.com
References: <20251210203243.814529-3-alan.maguire@oracle.com>
 <aa32deb9e8e7ee4895f4884d375153f5fcf90b5b319e3f7052f4b14f47bb8504@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aa32deb9e8e7ee4895f4884d375153f5fcf90b5b319e3f7052f4b14f47bb8504@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH7PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e1bbbd-1602-4d3e-2c2a-08de388fc3ef
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aEQ5K1dPcVZJRXlNc3lkOW1mL2Y4enJVeW1xMSt2WWhPY0hzTk5NalBRcGhZ?=
 =?utf-8?B?UHc4UjF1UWZGUlJTcHhTNSt1TUpJejBiem1yV2tmSW16QU1ISUtQaXlRVUUr?=
 =?utf-8?B?NXNRMVZjTm5OR2w5ZEdaU3J1SldYejl5K0RmRFJyckRBSmFpUEsvSUZjbEVT?=
 =?utf-8?B?ekpTMVN0SFlyTHczWmExV2lQUUl4U2Rtelc5VzBUcHJYTnF5TGMyOEZVVXZk?=
 =?utf-8?B?RHdQbHdrWGI3MDQ5UWhtcm9PejVEbmcwN1I2TW1hcmtvczJCbXNZTXUrRWNh?=
 =?utf-8?B?Skp2N2U2VzRQRDVUS1IzeVA0Wjd0RDM0VGVKVDJSN1M5cjAwL1R5WG8zMjY0?=
 =?utf-8?B?WHFjVXJCNXBZTWgvNG9tUk5yWXM3SVN0dmNvL2dJa1ZMaktrVU9tMGZVVHJv?=
 =?utf-8?B?WGFncXQ1K2dMbGt5cDJ0SkNpUVFQWS9DRG9kRE8xOC9lU2VNdHFFaitmM3dh?=
 =?utf-8?B?a0c3cnNicjEzY210bTU1Z3g0N0hRLzFDcE1KNVo3T1BpTEJmR1hDcWFKZ1By?=
 =?utf-8?B?UUplQXJUbXM1d1lQU25hWVBOa3pnZGlWdkxyNnlYaStkVllvbXZYeG9rdk5q?=
 =?utf-8?B?bGdTZE5QcE1TOVZ5U1RqdlBmTUh6YVBCVlRqTWFTaGlqb1FFSUQzejJiaUlU?=
 =?utf-8?B?OFB4ckM3ZFlhNWI3emt6MmlIYUkzTEhXVUZyMUhGL0dFcjdpVXUybDl0bENn?=
 =?utf-8?B?cmhHSFJKazJDTEpjUklsMUdKTGs0b0cva0c3ZnZ0MjVpNG1jTWVGbkd0V3ZU?=
 =?utf-8?B?OTRuWGVBSHNZa2VrQTUzQVJ0MFd3QkJ2K2RTQmNib1JUdWhsRlo2MTRLTXN4?=
 =?utf-8?B?RG43aWZEM3pZN0Q0c0Fab29UMXlmbFdic1FqMVNqMDgxcmVsOEZPeWNjbUt3?=
 =?utf-8?B?czNmMWwzV3hGZnhuOU9wK3JlQk1RdERFY2s2WTNNVjJBTlpPTmdqR3V2YkQz?=
 =?utf-8?B?VUoxdzdqM2xYWGpkcmhEY3RvUEw0ZDZQcUdxbzlFZi92WVUyZkVweFlIQys1?=
 =?utf-8?B?MWd0aWl5Vloza3ZPMmNqblEweFJsblN5RGlYSGNsazYrVUltRGc2aWh6Q001?=
 =?utf-8?B?V094eWxxWXdkRFBmVEUweHpmRHhKTS84L2g4cGFCano3WkU0dUUvTmFBTnlJ?=
 =?utf-8?B?azBhTUN0Y08yVFlmQ0RnK0UrYVRHY1NqNmlyR0YxYWlGbzlZQ0JaRDA1N0Z1?=
 =?utf-8?B?TnlIUXJzNlBKalhQSWpkdzBMQ3k5RWg3c3QxM1NyOWhOZ3JMWkt1TGZTaE9n?=
 =?utf-8?B?NGtoUHl3a3VQMWNScXlIYkFkWkhJMlgzaExpNkxlbm51Q3lJUVFSOG1BbE4r?=
 =?utf-8?B?V2xIaXhKalkrYkhMc0lWcndOVDNwV1AzVitPeDRiTTFuNjlhS3VsNDdEeU8v?=
 =?utf-8?B?S0xjTlRjSWRtaDB2aVVmR2k0Z3ZweFM2bkVtWVZNZUZvVUw2NVNNaFkrOWFK?=
 =?utf-8?B?RUVrR3ZuN2h5RE9VZERtbG53UDFNTGx4NHVEZ3l1eEwrTFJGakwyR3FtRktB?=
 =?utf-8?B?d3hVRnd0UUZ4Qk5wek1iMXdUUHBJbVpxRkhjUHJKSUwxcDlaZnVWSjBQTDZy?=
 =?utf-8?B?VFhWRFlmdERPN1VVNVFsdmEyR2NLcE9zbEFBQUNLWWhQQnZwZGVSMVprMkd3?=
 =?utf-8?B?bzRucTFXSnNtNnpPYzFkOHdoQTRXTnRYWjlGaTh1ZmxGVnJRVnh2L0tSbkxq?=
 =?utf-8?B?Y25vM2lTckZOMGtFck9vQU1KT21mWGYyTDBMM043bXo5OGZDU3ZENWhRaGlz?=
 =?utf-8?B?Q0ovcklMcmhHVFkweDVod2xxS3p3QXlNeWt3SHRoZzE2THliQ1hMMGdzN1NL?=
 =?utf-8?B?TkNzalBaall5UC9EZThvSGRJUS85SUJ3OEtzUFRXTFcrcm03T1AxYkRqcWly?=
 =?utf-8?B?ZGgvaG9nMFVIWldlUDQrZVZ5VUJJQXYzRzByVVVNeGYvYzJZbnF2NDlFT1BO?=
 =?utf-8?B?UW5MZlp5WEVJRXdyL0doaHcxdmFjVDlrczFqenhDUkZDVWtZV2hib1F5QVpI?=
 =?utf-8?B?ck5mYkdJYXlnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b0UzdlRnbGM4RklrWk9EVVVQRFQ0OXdESVNGVHdsWUZ4cWVNc1EreUl4UXRl?=
 =?utf-8?B?Q3lhTEtCV2prck1ybWJJWWYwNGNPWVJkY2pzVGh1WGFDZUo4SUtTeXpSaURY?=
 =?utf-8?B?aUE5Qm1kRmViTkQ2elg5WGh6WXNBYUVPK1l1eVJxNUFpWXpEVlpZazE1R0xC?=
 =?utf-8?B?Tm1ZdElneFlHZ1ZyaUZ3WGtNcXhRWkFWajgrWmJmYVpyYlI0WEcvYm9JaEpx?=
 =?utf-8?B?aDF5QWpmc3hGaTN6czgrNjBYcWxDejFLcUtVb05EaWZrcU1OalFpdHUxM3lG?=
 =?utf-8?B?MGRHR2Fob2UyUmpYY0xrRWRXUkJBelhvWjhuU0Rtb2h4ZjhicW5LUG15cGtL?=
 =?utf-8?B?RWIvTHYyQWJtOVZWdUdxWk50b2trV09yaExlZm1xbjRXSGpLRnlweWhsTUpO?=
 =?utf-8?B?aUF2WUhOamFWVnNSYUl2M2wrTVJOcm84aDRGT2lGQWlKSFBaVkZaU0RrY0dQ?=
 =?utf-8?B?ZEFESEJpTm9sYmFMcDd5YTdOeXh1QnNYNlZUL1pUbTFINWt6RUQrYVpoWlA3?=
 =?utf-8?B?UjJjWThTTWpYWGFEQytsdktwMy81UGdaVGxLN0FWd0ErVlp2ZUhmK0dWeGJt?=
 =?utf-8?B?ZEZ4L3g2VEJXd2d4d2VIUVIyWDFpeTI4WHMrS0hJZmR4Rnd1RFhrdnJ6TzVL?=
 =?utf-8?B?Ny9oTS9Hc3hZcWVHZklKeXNOT3pSSXlZMkFtdFRUZDFmcmluVGtlL1dJdHp5?=
 =?utf-8?B?SXVJMGN5a1pRT2JBY0Eya0lCS3hEanE0UlpMTmYwUWMwN3NYS25yc3lrVjI4?=
 =?utf-8?B?M284a3RkOWJrSWQzTmdUYk1rZjhLK21WM0NNUTU0dGtYem1VSFRHYTVZMVRm?=
 =?utf-8?B?ck5MZnU5OWdOSVVRcnNyKzFCK21NYkg4QVQ1YzVJaTdrL2VuUU1HY1VsS2hr?=
 =?utf-8?B?Wk56S2ZINVMyWUE3dEk3ajZhQm05MHEzZ0hkV3NQMUhyVFZ6WWRoQ3o0Vjgr?=
 =?utf-8?B?cnlPREhnM0FxVFQwc3BCL2hyL0FyNnhMVmx6U3VDMllJQnNMb2E2TXlEb2JY?=
 =?utf-8?B?K1l3TTJwRzZDK3VBZ1FtY3VhS0hHdTB5ZWNBVXZzYW9WQ2dqZ0J4dWJ0T0ZQ?=
 =?utf-8?B?NnVINS9CODh1ZndDbm04WVNVdlZIZVlIUDQ0d3FUT1pZZVl0dDJmcDZNSDlD?=
 =?utf-8?B?U3RMcm1sSndTMmd2VE1yZFVFVkNXSStLeVRSTHExbjJveDhMUXhiOXBpY01p?=
 =?utf-8?B?eUQ4MTRvamozeXpObm5qYkk5N29IQU11UFllc2IxVFYrSHZMQ3dpcitaSyt0?=
 =?utf-8?B?d0twcU41UFJiTlhIRTRVVUFZdlc2S2tqYnk0Wkh1UXJjOXRqUVhJUEpGUFRI?=
 =?utf-8?B?VnBvSXdzMmdFZ0g5WVZwcytmUTVkaE1lbS9ocitTVGtGYzhFL0xEOXRuTFVR?=
 =?utf-8?B?eC9xMFFoaWdwejZUUkNFeFlxVktvb0FJWjJRenMxM1ZCUElVMmxFOXRCOXdD?=
 =?utf-8?B?dGxBUFEzL3pYR3VZdTdyU0RtOHZUSnRTYTFOZ0tqM1NBMExSTTMrUUdPcUZC?=
 =?utf-8?B?K2ZKWDZLZjBKUWRCRFBHSkh4cElzckVPcEhtaEtjckZyOGRXMndVeXpCRjBN?=
 =?utf-8?B?T3hKQW9jZEVMOWxJcTljQWxEdHRSN0tpdFJQVW5DQlN6NEIzVktLcUhXbTlz?=
 =?utf-8?B?L3NzTmlkMy8yVExxNWF4blNYWXpKMkJVdUVtMndTcWFJSGVyTWJBNzZ0bXJN?=
 =?utf-8?B?VDJyOEhabjAxTGoxMHFEZlUwRzBxMDl6TTlRT1JmenFsL0NlWnBVVUtoQzRh?=
 =?utf-8?B?d2w3N05qNnlPOVFSV3hJVi9weHBMVmFZMjRSdTNZS1RxT2MrdWowYUc4NnBQ?=
 =?utf-8?B?SmVXWTVnTmtBWUNHOVF2MXlhNkhxZW9xSDhsTjBTbFZ4S0I5UnNFcndOOGpV?=
 =?utf-8?B?aGNad3VWQy9QendNTHkvdlJ6MXhKc2l0bjUvRkxUM1ZPMi8vTmdnNVNmL1ow?=
 =?utf-8?B?blRiRERhYy9vSlcxRjhSbDY0dHZ2WFpFUy9wRnhCeERiVmZLbkZjQXBqQ2Q3?=
 =?utf-8?B?dWwyQjNaSU8reU40bDkrbFluOTdFai9QRDMvd0VXZkROM0liUjRqS2V3MWpY?=
 =?utf-8?B?TU1iQnVXbldzM2U2c2FsQmVPUzVvdlovYUhseDNkamVsMldib0IrSDNhY3c4?=
 =?utf-8?B?MFpTbEpjSnJsVzd4aXQ1RmdTeXZyMFR0Nmo4OG1CS0xjR0lKSkd4cDZMK1V1?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QpLez3/xrQiDUIliEXaKoCgARzwz9AQXWJ1LSNb1dLTdwWRXxfvve7hCCPChVfOTbVtUCSN7yuaNQrNtxu9SIjTc0tWr8zZfekt+hvjOL+UG0KJjWOdqwQztqlyYRMzyd0AgVx6J63yvkNckHu9s+m1oHEyh9BU3Pr6Tb9zKjxo6cc0q7y6e7OTxskdse2FI4qt2K2buS+KJMu5w75/phvI1mZEweJTlNvCEwkOjKCyIsPC/HeyYBezEti1u3UqPyPMxwEhseJkJ2ueOfOXEK/1VjqNQWzlYYtu8D/gUoM/avKxa5Lm6QemvZj8UTuWGo1gw6QNie5KeYLCq+Nw8ooH5M8SRrq0O3+abZPlsUyFqbspChdAGFs7F4txOPA8ff+pWJqIDlGS48hnzSRHLMg9dYkY+88uLLo7jnyt8axZZQXs1rSkLwmTm8YmuSPqqM2/BCV9bAJ1yNKOKhtdOYgh8yCASnklqx9QF9lZHdrfrFpiGyZLzfCrMez7Cyx8RR33k9A4K6KdmLj0ow8Fx3bzkecIFbsWQssVswMCxISdmP4V/bnWt3P49QjXq6Vak+sMZ43yRdt4ov1uRbi9Kl6HZ7PHaudXtJIlaC8cDSPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1bbbd-1602-4d3e-2c2a-08de388fc3ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:32:05.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCDFzeEJY4l1tjZG+2hMb+VT8mhgHaI0AHrmYzyZKOsrUbhjBX4b3fwGmerSw55EBIeqMxSzwmR75uSclNYCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512110063
X-Proofpoint-GUID: trSu0lNeZuYTqxccUFVUxcz4jkSPB1as
X-Proofpoint-ORIG-GUID: trSu0lNeZuYTqxccUFVUxcz4jkSPB1as
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2MyBTYWx0ZWRfX0Nkf6esslOSz
 TzRteIVSDoZMUEmpKdHk31flIXWDE+fCBHl1pFQA7O8Y4dE9OwhBnyL1rS5ch9l5SHtUKGU+Uzd
 ACRjy4sQ4NoEqnBXN/Jg6CjJSUZf0PnvauSBPIPDjE7geNcC0ggdJ+TaJM+mf7urEeIfTZ9TYYo
 31YxMZ87rzLqzvSifiioIPjLYH0kxGerRe2NITyAcxKIb8OosVWvTeV0JZFtSBsvMbknRH44ZiY
 7/e+ilt2O6oJYjouFu94G8NM3+CN3FraT6J4wWEKuSDhn7zGypww687eqFZ0mnsoNslEzZh5S71
 JRcpXN/XnDI4zWZpE7t9HFET9zitkC3kJ2GYL7X+2GP/e0bhdxzifDHJ7hm7FFwn/y7IOsmG4f7
 xGgrXJtaATEmzi/F04p6vekQdhWEtw==
X-Authority-Analysis: v=2.4 cv=YJeSCBGx c=1 sm=1 tr=0 ts=693a818a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=9aOA-9ZnCXE3g-sSiz0A:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22

On 10/12/2025 20:55, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b136572e889a..737adc560818 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -994,6 +1048,7 @@ void btf__free(struct btf *btf)
>>
>>  static struct btf *btf_new_empty(struct btf *base_btf)
>>  {
>> +	struct btf_header *hdr;
>>  	struct btf *btf;
>>
>>  	btf = calloc(1, sizeof(*btf));
>> @@ -1022,14 +1077,20 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>>  		return ERR_PTR(-ENOMEM);
>>  	}
>>
>> -	btf->hdr = btf->raw_data;
>> -	btf->hdr->hdr_len = sizeof(struct btf_header);
>> -	btf->hdr->magic = BTF_MAGIC;
>> -	btf->hdr->version = BTF_VERSION;
>> +	hdr = btf->raw_data;
>> +	hdr->hdr_len = sizeof(struct btf_header);
>> +	hdr->magic = BTF_MAGIC;
>> +	hdr->version = BTF_VERSION;
>>
>> -	btf->types_data = btf->raw_data + btf->hdr->hdr_len;
>> -	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
>> -	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
>> +	btf->types_data = btf->raw_data + hdr->hdr_len;
>> +	btf->strs_data = btf->raw_data + hdr->hdr_len;
>> +	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
>> +	btf->hdr = calloc(1, sizeof(struct btf_header));
>> +	if (!btf->hdr) {
>> +		free(btf);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +	memcpy(btf->hdr, hdr, sizeof(*hdr));
>>
>>  	return btf;
>>  }
> 
> Does this leak btf->raw_data when the btf->hdr allocation fails? The
> btf->raw_data was allocated earlier (at line 1074 in the new code), but
> if we reach the error path here, we only free(btf) without freeing
> btf->raw_data first.
>

Good catch; will fix. Additionally, elsewhere bot raises the issue of validation of
kind_layout_[len|off] in btf_parse_hdr(); we should add additional validation there
to ensure kind_layout_off is 4-byte aligned, points after the str section and does not
overrun the overall size. Will fix these in next round.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486


