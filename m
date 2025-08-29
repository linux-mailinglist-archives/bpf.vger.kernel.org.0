Return-Path: <bpf+bounces-66974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAEB3B91E
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C778A3AB81F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143EC309DC0;
	Fri, 29 Aug 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnTKC3Rl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqWGjnzK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27C3093C6;
	Fri, 29 Aug 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464253; cv=fail; b=KtXwW4BQXzv//RGk8MNQJp1jJImngSq1OiJsHlLt6F5by5d2YORpvofN/SoZA30pTodUK7eiiVRavd+6gN4K/LKkb90bprGcboBVO/pV1OY6UsjcEjjC/3Ycy9n8WZwjEDxE44Lfyyru3+wU7hj4YeW8kH1reTvAYc+BsnTLOuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464253; c=relaxed/simple;
	bh=uSuB+/x42gD5mH7OZfZkHrrenU3BuG0mVUscx2fi8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NomFYPUij9DmvrSGKDRfdFq8P61WrzYtDJ9CCCg77wEA4JmhNR5cmR4rPjy9XjO7AwQgBj2z0yCJj8Vi96INbU0LCdxgU54TvRrYzGb2F/SZI72Tb0+X5dhiWhuHCHl5wBsrkbGvF73OXdGeuodZPT1KWrH++pHGkRu5PBAvRz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nnTKC3Rl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cqWGjnzK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAY8Kf019078;
	Fri, 29 Aug 2025 10:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yciLyQCaYyK4cMN23K5Fprmyu1DDgVC6i1ry7/RaVI4=; b=
	nnTKC3RlqMHmFm4rwKBHgC90vXES083Gz06MtC0xBuIyktWuoGMefCFzStphrz1M
	Zf8C15rCTPyHiLVK9vRtxnJzsAgENI92DnFYX2WkftAvdKoMg9jGreg5uSrJY1H1
	yJppg5lqh80qmE+zk8kICiMhBnl4dAMd5nni8ukVFIlQFq+X7btx670je6ykKfXV
	9JqBBkRlWZWlY1i4iRyTrMTOhVWaPjFmCTcYY9BtvxBvKN37nCOE+LzM1PsSDLjL
	1R78vscalm7N5KOa2dJEMhqAddYmBwVzP+0a0iLLyk0fQ9Idjbl0tk2Vnh6uixSk
	b031uzBobbeDzeTqmq9hag==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42ta3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:43:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8il0P018986;
	Fri, 29 Aug 2025 10:43:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43d2yhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO9KSG96chgpaCpQH1a6T2J0FJuOke3hoyFJMZOtcqJ6MHG265ruMgmPYUN1Zcn3U8FyCOi6UfeAsCofSxrNo/ul9aO+sEXTSmCa1YVXTNm0lmueZycdWinzb4Rp2bj1IotUhFHRikxvxhxDR8jk9vbWSoHnWE3NeZqcTx9xC2MPa9+HIAlTdybrSzU5ZuuuVm4dyC7EwsLinzUfF6er0q+Afzxez1VkJn0JkUVN+SCDBth5H5w293gcrDUrRVP+5C63fuhfaaT8tpZ/vHh9HhKy+BD0vWOattzOEllFEQHzSMkZF2q72H+DoYMZwO7xN7ZfGRx8JHFrEUqEJVv8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yciLyQCaYyK4cMN23K5Fprmyu1DDgVC6i1ry7/RaVI4=;
 b=fJJmpCKess8fHe22G3VgeOn992S/MaMCbSgK48t5gpPkp9JZ/yKDZizO8ClpkxmINUoQMuT6LSvJw4pslE+lDbiFLnj1e6aGIYLR4xzWVZNKLpS72wfNQnO1WkduKLJXEE8rn+LPG7nsfy5XaLVb2P+fbvYVUVS0phxMavrGO+SiJw/l2CE/swlvZS8iHLblJKBWdc2X2Uzo9JGMrrCr8of0KfOgOdXdHwtnqkvH1zSxizYE3qHfhYbmNklh9g47mmigshl00XwsUSJ74+x3hOnnJvwFoCBwxFxeoHmLVyjrmRZE1ANfRMuOCSXGdB1OlxJJFQW9h84xpmFnjtH0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yciLyQCaYyK4cMN23K5Fprmyu1DDgVC6i1ry7/RaVI4=;
 b=cqWGjnzKlF4DP5qHlIIBq1wRfXevi8bJXxJGvVx+DK+gXVUGdH/7qOHnclFRNEv3mQPD5X6CskgnetcSOFrKLbdi5+BWwj1KqGUjv8O6ikMzbGcUXrQj6YQQ+//nR2enu+NXPEhz8XX9x8YtY2XsstsxYNs+oVxl4vrsSw3eGeI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 10:43:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 10:43:25 +0000
Date: Fri, 29 Aug 2025 11:43:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc
 bpf_mm_get_task()
Message-ID: <bf586bff-a0a1-48ed-9115-b06598a0b0e3@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
 <CALOAHbBHLLo+Xcd=zJeQp9gvLBnyYWAdeBiqKYKgj424m1Sn6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBHLLo+Xcd=zJeQp9gvLBnyYWAdeBiqKYKgj424m1Sn6A@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 166bf36d-174b-4d62-3d20-08dde6e8e1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czNKQ0syNCs0dzc0K0NXZC9mY094K0t3R25mZzFreGNoRW9BMGRCQUlIVEh2?=
 =?utf-8?B?QzZRVjk0ellrc05RRCtzeXlKNUZGV2wxZE1SV3dTZVZydzNaODgvNUpIcXJw?=
 =?utf-8?B?WWgrNE9hNGx0ajFrY0JUU1FPM3dZMTQ4S3JnK0FZQ2dvK05scnlSVWNtbEc1?=
 =?utf-8?B?UngyZnd3RUtZbytnZ1lwem9DUjlIUk80cCs0bUYvR29lQkJMNStLUEpuQnRM?=
 =?utf-8?B?VGpVSmVzM1NSWWV6cm1Db2pLQ1ZsTk5KbjZ1UE5iWGZZNE5ma1pHS0tXTits?=
 =?utf-8?B?SmVrSk9KRjFKZHkwdkVwN0tjUEtnVktXWldobTFad2psWklOVDVrUnd4T1hu?=
 =?utf-8?B?M0l1S2ljaG5MUStxRWVRSEZ0SDg5MERVZEZuOG9RY1lNMlorYUo4Tkw0aHBH?=
 =?utf-8?B?T0RZUkRwRllLbGs0QWRRbk5xbVFMbTZadWZreDVWcng2RnJESHFPWi84NG1B?=
 =?utf-8?B?c2xEaWg1Q1BtM1AyVWJPT1dMeHVZTG1qbkRzQjJrWU04RmlsRW5VcHFpN3RX?=
 =?utf-8?B?Qis4YWZzaXJLbzlFdWR5MFFoYzh2QVg0Q2pvT0wvUFJhaGlxK3RTeW1QQ2ho?=
 =?utf-8?B?cXlZajdIMEVlT3lqVmRCVUhybFNPc1hxanlYekVvOWdxSXhjaEJyL3NHS2tR?=
 =?utf-8?B?L1JuRFpvckRoVzE5aWhrMElUajhzM3hDYVl2eWlsM0tOM3lnZEdwYkNtODFu?=
 =?utf-8?B?bzFWQmZ4WUVCVGtNWGI3YnZrREVxMXRnUUFwMWF0RVAraFNLcHdzNEh3QXN3?=
 =?utf-8?B?TEYrOVg4Ui9EOERCUEJaM2xqeEt5aVkwTXVZV1R0dTRvdEFUYVdUT2V3OTlq?=
 =?utf-8?B?Z1R2dzlZcmhOdEI0MkRrUm1WYU1XUGJvUmVnQ3B0a1BwTnRHbVRscTVtK052?=
 =?utf-8?B?b0NhLzk2U0Z2ZVpqWkorQTRrbUdWR3pXZ0lyakoraVUydzF2WDAyYm5sRUdm?=
 =?utf-8?B?NnpFMG9QRWEyVldDWG9RckkyYngwTmJLNWVPUXJFS1lIV2xYejJtdkdlUFVJ?=
 =?utf-8?B?TVRSRTY1eVRvZ0FJdG1qYTU0NzY0VGZZc1Y0dHA0WWdkeTN5NDJLY1NBS1JL?=
 =?utf-8?B?NHFoelB6OW95cWlGQjlhSmpLcDhDbW5wSzZxZm5rcEVEUHJabVJac3dtU0Q3?=
 =?utf-8?B?Tm5qVVRUZGRnamlxQXJNMmUrdEhNdkJXbUx2Z0Z6Zi9NczVUa3E5WGloY3Zw?=
 =?utf-8?B?Z3hrYW9HeEt5ZkQxNHQ4Nzl3bG85WG1XMHlBMU0xSjkzNDFnZllzcVFUWW5V?=
 =?utf-8?B?aHd1K3hSY2ZDYmRLOHNMU3paOXJ6VmJlQ3Jmd1M2bnVCOGR6ZHNhb3E2ckNj?=
 =?utf-8?B?RFBmd1ljZmhIQ05qZ0ZJNUliNUpkZlNHb0VMUXpVWHA1SHZlZktkbnM2VnFw?=
 =?utf-8?B?TDU0YW9SZkVjM2VpaVRnSHN3WjVPWXYyeTNFRGhia1J4b3F5NUh0dnFmTzhp?=
 =?utf-8?B?TGUzanlUcWRwWHhHaXpUSlVFZWw4RVhaYXpRcGxpNG5mTkNRWGl0dnArM0J3?=
 =?utf-8?B?Z2hEOEdmRzlzMjZQYVQyTnoyUGdsVG9KYVYrb1dtVGZGMnJwWWh5ZHFyVWpT?=
 =?utf-8?B?dlRUWTVWZFBXNnRKa1poellOcFA2T0hBVGVuNTFRTm9FU3FBYjdzMUdwa2JW?=
 =?utf-8?B?U1dqNFZBOXloSHpqdWtRZ3NHbTdyK3BZZUxEUzd2T2ZkdXdJOWMwR2c0WlRa?=
 =?utf-8?B?d3JpZ1k1SnVQRVBab0NoTWNKOU9YbHczZ1BqbFVIOHNLU2hyclF5eEtuTzM3?=
 =?utf-8?B?QTBnZ3ptSFlLVHc5VzlmejF2SnV5RUZVZElHdE9CUzlrSFo5TDlWVDV0TXRx?=
 =?utf-8?B?aW1BdUxqVk8xOVdYaGw4N28xc29MMXBJT2VQcmlVTFhtdFRUa2lSSDZHbFhu?=
 =?utf-8?B?UDRYQXFCNzg0Z01wMjZFREtGR1pBTW9xN0tMb2pMOEROYk40TlpTbG4zajFQ?=
 =?utf-8?Q?IdSB+2O9ZKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVFdkdTdGhWeGpPNy9RY0tRNkMwRnpjeWlVQm9zNElPU2wwSXoyRXkvMGJV?=
 =?utf-8?B?WVNxM2xZdU94OS9JbHFMVVpFeFNMMmlMbERoZ3VUU1B4UTFna0d4S1FHbzd0?=
 =?utf-8?B?VTMvTjU0SUhhNTBOODl1U0hDZlUyK0gyY3NZREhTRUIvZmFkT1ByWWRsQmNs?=
 =?utf-8?B?QkpaN1BqSHI3UU5MTDYwemI5QnNHWWw3ZC9ITXNlWGRKQ3UyMTZqZzR3bURP?=
 =?utf-8?B?YVlRSGcxb2RNT1Y1T1RiM0ZHakVFK1RPOFU5Nnk1ejRPSGFsSEJlTzJ5OXMv?=
 =?utf-8?B?V3JGYktjQWNyOUYzU1F1MGJrSkZkeGNVL2hiSFRIMEpiV1EzM2luM253bjhX?=
 =?utf-8?B?cWNnT2pjcnZsQU56dko0R3puWG1xYk1rOW91cmJaZG1ybnBnOW9GTmI1UlFY?=
 =?utf-8?B?NlZSUjlvUWJPcXVkVkxiaHlzdDVLY0JvdG5QVUVsMWU4OC9xTS9CR1dZYjNv?=
 =?utf-8?B?a3VqNUtCbnhGd2lJVnVPSllXZXpySlZqV0FrcGVaZFdDUGlObHk1cm14ZFVI?=
 =?utf-8?B?ejVBNjJic0gvdUdYUjFBQ3NzVWpqcGdLR1F0bElGSmtjcm5mdWwyRkE3QUpN?=
 =?utf-8?B?T05raWU1UldrT0NTZkpsWWtyTXU0YnZoN24vTTZkVmZSalM4MVR3ZHN5czNR?=
 =?utf-8?B?UmlGbGxEWG1EU09ha3BJak4yZDVGb1NQZElpNmxtMUhCRnB6M0QvSTEvYU44?=
 =?utf-8?B?ZUFzMmtUc0Rpdmt4dkoySWlGNVZ5SlFqQWc1K1c3ekhVMGVFbVZlekJKL0xB?=
 =?utf-8?B?d1MwUlQwYnVUU2o3VEpLYldOSGJKYmI3bU5zK1lmUHFVb3MveTNraWUzeXdt?=
 =?utf-8?B?Z2U0M2FkcXBRa0cxdFdrejgyRmtjSWFmNUVzRUJocTB1QWhsUTdVZHNhVVJq?=
 =?utf-8?B?UWtLSG9lTXluQVNmQ01kUVVHVVNuWTNDVFZZek1pQ21wckViVTVDOGpiWTlo?=
 =?utf-8?B?MFQ0UTZjdnhSd3NldXBKTkp1M0NReHVzMmIrM1hsemFaOU03cU9lS3RQa1RN?=
 =?utf-8?B?Uy9nWlo4VnhxdzVaVGl0QW9PQVpVTE5BRjJOUWJQMXdBQ0RlRGZ5aisrck45?=
 =?utf-8?B?MUc4SEx5YWF0V0JKZkFQUjZTT04vdlY4SjZCOFo3TGs1V1ArOFFleHNNTEo0?=
 =?utf-8?B?R0R2ZTJpMnpkb3FmejZwRjZUWjdEKzg2eWFTNUEyRUtscm1saGpNckVLZnBP?=
 =?utf-8?B?RzcyOHIwM3BQOFM2Qk01eVpvSFpLYUwrNTlBMEkxOU9YT3p3cmwrZXYvcmpY?=
 =?utf-8?B?NWdhQldDdlpJV2ZUbjB0WWg1NEZpSjVMR2ZqL2Y1Q2Erb2FLak90aW1nekZ0?=
 =?utf-8?B?NWwvN0k3UXE1VDZlTmhiMXBvUFVEcGM4UXhPL2RudGVkZytlNmEwK2p3cmNW?=
 =?utf-8?B?K1JVTi9ETjNBenV5SVI3OXY0YUxJV01vSEYzR245QkRxT29uS1dYUG1BdkMw?=
 =?utf-8?B?dU53UHVnWGttR0hScjUwR3B3c0tCUEQrdnBLb2tEOUlMMHRXZ3FZZXRKRmM1?=
 =?utf-8?B?bVhjbEF3V2N1ZisyK2FlTGlqU1FkczIrdTBSNFZZQ1RLSmhuaTV4QlF2QTZk?=
 =?utf-8?B?aXlxWmxJTDhCYW15bkZXUzBOWUc0M0lNcm83ZlJqV1IxbTVCMkpXMThDTzRv?=
 =?utf-8?B?T3NFNVQ1ZjlZWjRyUTlSNURiTXplaXdpSU9CU1NmRE5sa0I5cHRnNmhOVU5v?=
 =?utf-8?B?akVhZEQvVEwrcFZMN3Z0dGdaYjRBa2RJcmo0WCs2WWRSRmpBSzhia1dyWENN?=
 =?utf-8?B?aFZ0cDRpWGpEdEZhM0V2bHczdlB3OS9rRjhMVTBqc2RBdUZrQStHZld6QTJ6?=
 =?utf-8?B?NHJDbVlUZXdUSnNnTXZNdXZFZUNtdC9ybFJZdWlqOWppQ3dGL2dFZXp4eDZY?=
 =?utf-8?B?bVg4dElWZEJuSkdQZFBCajlFZVdoOGM5bkJvOXJ3bnAwZFJHWFhqZVc0azI4?=
 =?utf-8?B?dTFiSUg5WjJIN3lQM01tN0FvYjkrWk5vUmZYK2dibDdtNDROdnM2NjZMclAz?=
 =?utf-8?B?UVd0WHhtY3FjVmFabkVhSStUSkhTK00vQmRDWHpwK1pZYzVHck81SUlXd2t4?=
 =?utf-8?B?c3VvYzc2RGZmc3BJTE52NGFXSGE2SDhVRTJlUzR4Rmd3QXVvdmtqTHE1V05v?=
 =?utf-8?B?NXlkVWVua3JQcXp2dVBzeE5qa1pnL1Yxd2xlRTdEcG5TYVpjQkcxUElMb1BV?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QDf8th1RzRSe7JSVbsuvE4lYWG6Pwb/4CT42TPerB4nIaTkWdbd2u1nk9u0JDX4e7I5aZHF1udw3MbrzxHPDTykbbF21XLRsvYqr+FUpH33GsafgpahxaNk4RV4kCseJfGk+IB5MM88Sv9RDmfkVRdWx447TgrExMgzF/ymbK2LX492q5edCUBQEys9MWJ2Y2lHLYbww9JLrpK3YOXJTHfsuoDOdjCVyFKNf6YXnJRilnXqH8aBL0NcqqAmwjIDHKsl52IvuXpHVyZauFIsosFlvJJ0ORfWKwbotj3vu3ZUipTUY3mYQIJQspdM5WgGTnIuhYVLQeoqYMi/D/RCR4cGCYaDtLROQw9famkmAMMm2xS2zTh2KWeeVZCr6/3ghE8eNJP6nHxzw6ijLEpy/BcsoNQyiTbjbGAqYnvZNyqblv92RdqWehxpi+2KoLLRmiW+72+p6t37oavhGgDXcNhFPDZocNA0fA+dbaxq8W4Htd54umnzIJICxLbuEBRxQRbff2ikoHk3EWuRb1PFBKWHWRCbwJ+z4zYGXnG62RSSPJ1vN7b6Dkd5ZFrj/EF5l7OStCtvJyzgdhLNkgLupwgjW+rMRrnfngiz/ViQHfRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166bf36d-174b-4d62-3d20-08dde6e8e1c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:43:25.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRT5/Yk4utbwOnsr80JgWV9uDrCTKsHf2LG7hSWdO15xFihzw7c5h3X2qSoFpZfXbAMJlLuqLInhswCQoqOrPNNyVzb/2rn0/r4LoK2TbUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX5vqraVBYJbh1
 MRdKe6WcwM4dJgrRyuasjZhmVfmiLK9xG1eltQSUdPvWWGmoAlUHMtkHeqQ72r+pt+/YnCzSrCF
 DNIypsTBSftVJ3UybcjYeJZc4Jr4raBVrnACcQ6H1cTW6DBh7N2QD9p+olKG4CqrNgXeVNS2hdE
 t2IcLnwc2JOEe/g63vzhID5jLmUT00xG6l3QY8BZ0BqDm5VE1FB51o0z2f9StDNTGSAbAdyfdMg
 0+wWlii39Pjz3oSut+W3EHZX9IO8I3OTynIKJBtgzt5toYhvFtUWpsN+wWO2p1rpCGxx3k6HjfV
 b3BQI/PA0nUDxfgU+brRFT6dr7U+FWaOfrLg0Ncxbwzkz/CSd57cpNO9Q2ERCIzt7ad4G7qTh08
 fS01k3bT
X-Proofpoint-ORIG-GUID: CvP_i1aNghwsiXoc_DTRdaxrlqWeHWqs
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b18453 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=PSrhkukYD9OkS5OEeVIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CvP_i1aNghwsiXoc_DTRdaxrlqWeHWqs

On Thu, Aug 28, 2025 at 02:47:34PM +0800, Yafang Shao wrote:
> On Wed, Aug 27, 2025 at 11:42 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > > associated task_struct from the given @mm. The obtained task_struct must
> > > be released by calling bpf_task_release() as a paired operation.
> >
> > You're basically describing the patch you're not saying why - yeah you're
> > getting a task struct from an mm (only if CONFIG_MEMCG which you don't
> > mention here), but not for what purpose you intend to use this?
>
> For example, we could retrieve task->comm or other attributes and make
> decisions based on that information. I’ll provide a clearer
> description in the next revision.

Thanks!

>
> >
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > index b757e8f425fd..46b3bc96359e 100644
> > > --- a/mm/bpf_thp.c
> > > +++ b/mm/bpf_thp.c
> > > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> > >  #endif
> > >  }
> > >
> > > +/**
> > > + * bpf_mm_get_task - Get the task struct associated with a mm_struct.
> > > + * @mm: The mm_struct to query
> > > + *
> > > + * The obtained task_struct must be released by calling bpf_task_release().
> >
> > Hmmm so now bpf programs can cause kernel bugs by keeping a reference around?
> >
> > This feels extremely dodgy, I don't like this at all.
> >
> > I thought the whole point of BPF was that this kind of thing couldn't possibly
> > happen?
> >
> > Or would this be a kernel bug?
> >
> > If a bpf program can lead to a refcount not being put, this is not
> > upstreamable surely?
>
> As explained by Andrii, the BPF verifier can protect it.

Yeah that's nice!

>
> >
> > > + *
> > > + * Return: The associated task_struct on success, or NULL on failure. Note that
> > > + * this function depends on CONFIG_MEMCG being enabled - it will always return
> > > + * NULL if CONFIG_MEMCG is not configured.
> > > + */
> > > +__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
> > > +{
> > > +#ifdef CONFIG_MEMCG
> > > +     struct task_struct *task;
> > > +
> > > +     if (!mm)
> > > +             return NULL;
> > > +     rcu_read_lock();
> > > +     task = rcu_dereference(mm->owner);
> >
> > > +     if (!task)
> > > +             goto out;
> > > +     if (!refcount_inc_not_zero(&task->rcu_users))
> > > +             goto out;
> > > +
> > > +     rcu_read_unlock();
> > > +     return task;
> > > +
> > > +out:
> > > +     rcu_read_unlock();
> > > +#endif
> >
> > This #ifdeffery is horrid, can we please just have separate functions instead of
> > inside the one? Thanks.
> >
> > > +     return NULL;
> >
> > So we can't tell the difference between this failling due to CONFIG_MEMCG
> > not being set (in which case it will _always_ fail) or we couldn't get a
> > task or we couldn't get a refcount on the task.
> >
> > Maybe this doesn't matter since perhaps we are only using this if
> > CONFIG_MEMCG but in that case why even expose this if !CONFIG_MEMCG?
> >
>
> As suggested by Andrii, I will remove this kfunc and mark mm->owner as
> BTF_TYPE_SAFE_TRUSTED_OR_NULL.

OK thanks!

>
> Thanks for your comments.

You're welcome :)

>
> --
> Regards
> Yafang

Cheers, Lorenzo

