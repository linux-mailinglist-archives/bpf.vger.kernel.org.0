Return-Path: <bpf+bounces-66815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E4B39AAF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBAF7A560B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A030C630;
	Thu, 28 Aug 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pm7I3PFr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EQzYvEiS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CF264A76;
	Thu, 28 Aug 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378324; cv=fail; b=OrB44xHrVxLIwtqpe8RTH+zc6Uhw8iKPtFHaGEGcIFi69wv4EYS4iEW0hB+vcXmoCXoDzQRSPLLZhGNEysr/bgHE/wDEEO/IdFqWg2EYnDsnDCbXohJYmYJcdAktxvVzXL6cXO5VM3tqDMmxHkL/i1HnnaWNZr+hVxvogTzUF7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378324; c=relaxed/simple;
	bh=8T53YNqJSQm7uZbFiChFF1EniFRuul17YHa0Qykzrkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcVYmPQPdBTNlz9K74GVCPkF2e6gZBZoDAEmAeVsRJwLW7k7gz1i9yMFb+712wZDxb2B+uk951uq74nDRz7pvFvTgfgZ8iG8GH0mov7VgfQ6wgy78FxY/eNzj5TBFEA5lMw4oRTJMM1xxvKix8gDtMrskyhavl0DpvRn5lf/6ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pm7I3PFr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EQzYvEiS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8v89X009689;
	Thu, 28 Aug 2025 10:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uNh5JBNdnkD+yHBuNr0WYDtCo5wux2n2jtgfVnUcLJs=; b=
	pm7I3PFrQ3Ja7VsMtAExV+6WzVnJzKGFTrEnxPME9BcEKINGz0+mkOeX8kK6n6Sj
	/UWQdNc627a9eWQVSPRXhKBYo1/0euyFm2Ubidp4McLmsYa1N1fR0quVYGB2swzU
	VSM6aVcSgaMdVQ6NNB7fNvmgItPoLX3PQosBaDurQxwJSlOc/8usjtQSxJDfp69b
	vtvYnJlhBuyjeT/WlKdFtsaAC9OLHiH+/aK1Tk2fZSW9mMJzqHy0H5swqgQh71pA
	TkT/gslA/4CbgbQWZdlG5wOay55FUwS+FO1zQU+M5lG8OZkK2Ly9g8TUXIu18OeE
	t3tbL9R6BLp23J93vLfSsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t83g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:51:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S92sAT005206;
	Thu, 28 Aug 2025 10:51:23 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bv7pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUmuEgTNMPL1a7JikuPUtaRPcMPDCsPQXevs38JfYPLx4KTmrsQSDBsI9tE36euNbhIcxKfgrRDGgFCo/z/mmo0Th1lU0IB6CrgYfLLEBGV0R654VxcBpYPODGXluAbfHcIxDZfE58c6B5Q8Tull6+GEbmOdc+NTAv+M7Sgc+4DeeKnSryIljQpCFu+0G9+tdpWEQG34UKD84vsIaaPRdKdgJzuwwAdW9juB65OECt/lgOk1jVdNs4+qWFSvnWuvn1Ebgh5ZNALd06Ayi8FAIzKb9oh+p8bM7+6eEKgdZpgBUQ1JcJiWRNn59mvEBR2P5ZfP6bV1qHmQzUYYFpaP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNh5JBNdnkD+yHBuNr0WYDtCo5wux2n2jtgfVnUcLJs=;
 b=JGv2U3sQ6FGJ3goK3eLkJU+Ro//rC/1xsBBb5KVqVtXlPrGZS7gY5fSS10k6oP8qNHYZsBm2s+c+XPFC7+voUY2hCUXaLviVDl585ZFiiq0q/I1IsSGBKUiOE/7Yuen/XFiIpU3PisonLrwbH5n6uDxAIqKDlzHahzll9bX6YAW1lz1G9eU+H0AfBUrOJa8uiwciFrxTZmg8jRkqGnltWaoq/Aj6A/yf3ea2AEwbpgoDrVEq4iPA68Z+SHt1oMSE7j4qgM6PgxzZacsmIwTmzYSF4iZdgvU/kDN5HtbCMX+ZfN1FBVkeSXLWr7lqhwHG96vjoflidhO/+rLjgvaJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNh5JBNdnkD+yHBuNr0WYDtCo5wux2n2jtgfVnUcLJs=;
 b=EQzYvEiSl9nLMehgNu5IeCRRgSL3oqvft7P6V3ao/woMAjbSQPTss9t9BFvqjZgtuQs5P80FpYyYOV8GPn/H5F+OWBC1kqS7EQ2K9cdCmdiyDgyDvayRl8p3RBiCvZFKtzqk5jpTtPHZ86aRtrLUgrefL/OYIijWIJqKWk+rf1E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 10:51:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:51:16 +0000
Date: Thu, 28 Aug 2025 11:51:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc
 bpf_mm_get_task()
Message-ID: <4ee47412-2a33-431e-b667-2daf25bf0b38@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
 <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: d5569910-636d-4b98-e76c-08dde620d03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGVTRnBPdzF4NHpzNkF3Q2hsMkRxamNKVGxwaTArTjlrVWZQZkwvc2lCbEJq?=
 =?utf-8?B?dWh1b3hnS3hrMXFlZWY0Q1VMd0t3Z0JVT2J5UW1zaGVsd1k3amRWNlFBUzY4?=
 =?utf-8?B?Yy8vWE5IemdSck5PaWlkZmVycVJ0SUpkSjV2dHNlTm1VUHR6ZXJjQzFVUUYv?=
 =?utf-8?B?V3FFTDg0VFAyZUZBNmdodkJST2x3UFZCN1FHekNZd0xpdEd5cm1EekJZM0lD?=
 =?utf-8?B?NlVTYi9hUlM4N1BFRlNIbnh3Q0FwT1c0Sk9UTGNsRWZTYWRNbG11UEVmbFFD?=
 =?utf-8?B?cGNaK2hJMG1OZGtiZHFyaHEzbklLT3BVeVVQbmxVSjNJeDI5WEphY285S05s?=
 =?utf-8?B?MEJDRzJqbk9iLzZGOEwwbTNFNmM3WGpQQkFlRGhKSmgrMURuREJ1OTJiam9n?=
 =?utf-8?B?QTlFbUtSczYxajdiQ2JRL3lzVlhOQnErYXRraW5MT09KMGxnR2h1SENuemVX?=
 =?utf-8?B?ZjdYUFdZWUVmYUZPVGkwYUhnZXE1OVZLQ0JVYktHaURpQjQyUi9FOTVBWWZO?=
 =?utf-8?B?cllocnVLVkJEQjNsdWF4OHZzVnMxeEs2S0RhUmVPZ2UzVVQ1UHV2amxUTEJq?=
 =?utf-8?B?SlNtbi9HcUx6QkY5SVNyb1JQQW82MDl4N1RJT2pEbUVsa3haNEZFQkhlNHls?=
 =?utf-8?B?U0t5QXZzT011bmNBcHNHQ1lrdW9Ka0pvdkl2OU1sMUQ0U2dNRnBjcjl2KzF4?=
 =?utf-8?B?cE9HV2FNTmpxZHB4WnNhVEkvcWcvNUp1N0IrNldnY2JzRXk3UHlnVHN6YWpp?=
 =?utf-8?B?d25LQml6VmlMY04yMCtqTk5FMnJyWUNUeE04djBrbmI0UW5HT1Y3ZnhHdnh5?=
 =?utf-8?B?am9XWXdVTEk4akpZZU9GcEtjM3Q1QmR0K0xGSHVYVlExWU1sNGpQMy9NaWxE?=
 =?utf-8?B?V3ByQ29hdVU4OEpmUWExNDNGUEpkcHFmS2p2TlhCNmR4ejJzVnp0RlJQMm9Z?=
 =?utf-8?B?SS9ZOWt2ekdkSXYrMDdVRHJJRTlwTE5teDZtZXRmTXZQaU1vamQxMmVPZlBi?=
 =?utf-8?B?RnQxSUlTU0lpV2JhRG9VZVloaDNMdlhWOHNTS1M4UXEyMDNDcm9NUmtHcmph?=
 =?utf-8?B?MktMMGVjcE5pZlpMeXl6T3JzUnRzc05Id1IzUVVCMjhoWGsyQnJlbXJkczFm?=
 =?utf-8?B?Qm9qSkhiakxyTlAyWVVYdzlsS1M2aTViRlpPS3l4YXRmWUg3QlZwSGZYTEVv?=
 =?utf-8?B?SEtkQUEzU0JtZlJPeGMwelFqU2VrYWgvcWZCL0hxYUtNejZvUk5ORVdLUFFS?=
 =?utf-8?B?cU14K2NPZHpOOHloYTZZUXBhMFJiR3BuWm4wWm9aYVRQUUZnTFU5bVJtRUpm?=
 =?utf-8?B?RjFuaEptME9oWDc1N3RLalV5K1RuM3R4cVhaSnBiVWtaaU1iQWZwK2liUmt6?=
 =?utf-8?B?NG10ZXVMOFZMT2ZDZnRWc3BMaGJCeXFjZlk4WnpkYzRRb2FDaWFMemh0WElt?=
 =?utf-8?B?VnFtN1I4SldVdTBYVkZFcFlHYzlsbC9iYmZ0OHRsMHNLVmIyTi9TR3MwbTgz?=
 =?utf-8?B?Z3FvWDZVcjU5UUs2T1lvSWNCNFJYSS9ySzFvK0V5MmtLMVpvS1ljcnVBRlNV?=
 =?utf-8?B?YzBUN3p5N0ZJRXVJSlpRRmhaUGJYMG9CWEQraGNzbTNtbTY0WHhMOGxqbExM?=
 =?utf-8?B?aDZZYThNcnpaOCtTSzJUOURFWGVZZkkrMkpzbE1WSWYxSS9YcnRoTHBueGsx?=
 =?utf-8?B?N1JQZ2p5TEMrS011KzFQbEc2WVNqNEMvWlBhMkZta2M4RUdZWnorWmE3Zm5K?=
 =?utf-8?B?V1hFQXVLVHROc2lrcTFlTy9DVlNTWDRrRTRtMlMvWHZDWW9ramprVnU0TjFZ?=
 =?utf-8?B?Z3ZpcGxvcnF0VmRRS0hxRGlJUTh6citrd2RoemFPVGhNVHJkR0V5NEJia0lr?=
 =?utf-8?B?Q0s5QWp6QXB4dlpwR2R0VHhBUG9nVENSRVJtS2g4eUladVBOalhjY1o3Zjk5?=
 =?utf-8?Q?A2igQcvfP8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9HZzFRNzM2ajNiVDhMUmF4Y2pFaTJGMis5MUEzMEhUM0NORHdXL0NJU0pT?=
 =?utf-8?B?V1pSMGtKZUIyOGE4bVZQYitFSzhUMm1FVkh2U25yYUdld1VoS3BGRUVpSjVU?=
 =?utf-8?B?K3JOZHNXL2JJN2xSVVRPWVFKZzgreUJjRTRhVHFTK1dGRE04VFlmaEFOeFRW?=
 =?utf-8?B?ZWhLckNkTkdLMDd2YVNjVU1IWUROb0VOQ1E5cG0rYndqeDNnNTRaM0hPWFVU?=
 =?utf-8?B?MWtxanlnaVZ4QS9PbmlWR09EL3dkZG0rcFl3SGFBVVVtQTJsbmdJcTBVY2NQ?=
 =?utf-8?B?Y2dpendFdm1YUFpicU1rbTNWbG1ldEQ2K0xoT2RUcjM5NCtzazNQZzRtVURD?=
 =?utf-8?B?RklvUWJJdWNIMlZaWitNcndVYXhyc0NvR2xPa29qS0dTdW0vSnVuTjY5dWxD?=
 =?utf-8?B?bjQ3M2hXVUNXeitQYkFmYWg0NnFiM2xHZG1YTGw0SGczNXBUbkhvTldZSWNL?=
 =?utf-8?B?eW8zK08yemx2ZFNQMGpCRE56eUw1eExiSFNBYjJUUUMyWERaZ2tnOU9WdzRj?=
 =?utf-8?B?ak9mZkZkWUhCU2dRZ3lEcVRHYnZWdTVVRk5IS1luUmwxeGhDekI2SXdkYWZj?=
 =?utf-8?B?NjdqaXE4dll5b0xhNUg4M05YN0IwekY3d21wMmtrZWx2eEZjc3NXdk41Wmxq?=
 =?utf-8?B?dlpXdEtNWEhhK1p4TlU2aituMk1rWjJ5UnpLbFA1VHMrdTk1RWtxbnE1U1Rl?=
 =?utf-8?B?V3RuL2Y4OEZSTXBSZVFiejhyMmtmbWR5NW5hZCtLRWRXOWkrK2pieHU4QXlp?=
 =?utf-8?B?aVpzc3p3SDRnR2ZtNVc3VHd2a3pjcERZcWQyR0U3WDZSMXdMT2xDaUlIT2VL?=
 =?utf-8?B?THBhZ2xCcW9zSTk2S0xQZGlqU0lWbXB6WkxkZ3VobTBxWUVPcDJoSmFBTTdx?=
 =?utf-8?B?SzhPdllXdjh1dk5zdkZWYnlmSjEvWEttZ3I5Z0w0K1pDMWFSUVI2SmU4RWZT?=
 =?utf-8?B?MlE5STc5UVpYaDdRN1FqanVGQWVwZDJoUjc5T3N3L3pHTXFVTFBzdWRFVkJM?=
 =?utf-8?B?K0F4Mk5qVWZyWkNNblhZZDVNbkc4S2dtSFdyTXhRL3NsbUN4bmQ4ZW9Tem9a?=
 =?utf-8?B?OHFwL0ljVWZjRFJRQnhTK1RkNk1xazRZSEk4TDdpU2s3SWV0eHFUOXJpUVlx?=
 =?utf-8?B?SDJlQWQyR2l6N0UxbitkVnhsc3JYUHBoTlZ4cmZiakt0UHlraURyTzJCK1B0?=
 =?utf-8?B?RFdRQkI4YTNBVHhwNDlPTkVFUDdmajV5eXZnM1huMUtaY3dKbEJJWlNjaFBQ?=
 =?utf-8?B?SjFuakRqYWRDR3dXMzRoWTRkcDd3MUJneXVSN1hkMmlGdmVFSkdHbUVQL2Iz?=
 =?utf-8?B?MEFLK1E4aEtYakNxbjg3ZHBFQkcvR2creklUWW53azhKc2VyQmZsNFZyVERK?=
 =?utf-8?B?ZHo4emJseDQzMjYwdFc5ZXlXc0dLdldleHQyemQxY001M1B6Q1dKaFg5bm1a?=
 =?utf-8?B?R05ZNVNaZXB3VGpjNGQ0TDFVaEM1LzYvVjQ0REhWSmg1UjJqMlZlSmViTTht?=
 =?utf-8?B?YUFFZW9vdlJuVm94dXJRUEFpWXJqdXJVYk4vREJlTXdCUWhxWlRVS3EvLzNs?=
 =?utf-8?B?dC92d1FpdVdvUUZzbE9GVnR2YUFZL2VNeElOcXpnM0hLR2NZbHBvVHJCeWJM?=
 =?utf-8?B?Z25wcUd0WC9Lc3hzVUxCdjhQeGlJQVl5Z082N0s3d2tpY1VVOXFpNXVDdlcw?=
 =?utf-8?B?Ym5qL25HcGF0MG95Ym0vaGJ4VXJPVkZwVWxiWVlNamlsUUQyR012bFhLUUZY?=
 =?utf-8?B?SzhJN2V3RnQ1TndHaWxUejg5S2ZXeGFHbDlHalFscXZEQ0dTNHpuQXhvdDdV?=
 =?utf-8?B?SjRkZXlCK0ZndXE5TDRidmdXcUVBanFjbEdjenpoQlRqTjB5NnNsTStkY2Yx?=
 =?utf-8?B?ODkzajdWN1haRFNMcDZCUzhHdzlzUEdhK1B0amt0ODN1T2tCMkhKKzA1aWsr?=
 =?utf-8?B?U1dwRlJHR01LNmM3akRHdzVMNmJRQmhHNThzZ2RvSHFEekxJNDlzWEs4ZXFa?=
 =?utf-8?B?MTNNWXhwbDVHN2RwZ1ZwcU5UclFvTy80WE5MZ1EzQmUxbkw0NUQ4MGh0UkJH?=
 =?utf-8?B?NUs2Mk9xNWNHQWlyMGVsNEJUU2lYemlIVGtRSStVSlFtaDNUdTNPM0U4ZUlJ?=
 =?utf-8?B?b1RWc3pPV1NRUGdmMFM5NDlEOSszK1hMTHUwcGZpSHlKNzNWTUtKaWJ5MTQz?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehB+jR+QXccIeuVAn0hjRrCn4BKBtb7rOx6RgFqoBVf21AXihztpWTa70vzBh2VwO+8r/PnF0kg8C3jZybNuBTSnAopwmKY/HGdpvdStAsmXiKLlZj0oLW9ybvHEBUs3yk87N4idkT1Gik42r6VzVoFazvZEemLy8fA1Ma0CVLdZbMO4JM/V1x1Wd3pmbSGCVmDEweHP65v2KnVCh4+Ev8nsfOyGnLp+ByUliaXKk4NvmA4k0B6h9lalOM5oq39WE3/+60r8I4fJ7VrF2n/6DxKk+4ujYihati7XlX1+EH3HAQ7K5L4AfuFEmEHosEQ7zBH0F3iltJKNHIQcvQYDOVXkDkqQCQMTM+a9W/EGqW/uhoBo/mXmBOWp60DTix7OhhIuWPt3FuSHb5Ip3Y+FXTb2XDACv5/PBH/1qo6rzsZyxNy4DAss9VaAeQeE6J/N277acyhXZWPrUmp+Ys3yQQhYztNpj1KfmJx3+8/5yYmrve5f/VbU/0hmBGgSSoGOIVbfxm6M1W0CjEHsSTWpvFNLptkbUbu833qx8rX9pyLoxadbc/TTjPuNMd59g7+QlLAN3lqOQQIk+UeMXiY3oyG5ggjLGpWpPCIcBnj9aXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5569910-636d-4b98-e76c-08dde620d03f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:51:16.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMup3RXnq0ROLLpdr/Y9sICIZ+ig1slt5pDgUWrMskVpD2fHjtNe/iJftrNRamd9H5oWzrThoYUu3o7YiR3h6MVeNtF/b3MIqIR7h883+KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfXzlD1GCu3/GOk
 7in+J70h1Yc4NKg66T7BkWSD/4F/DgrrYKeJXTbgZoGImJjvVosnF0LVv+xQoi4an/+ej4P78Eb
 gn92gBJt39QkFEtXE79IFrh5g+GdWS6Z9WL0/TY3/xu0XC7WlRal+kCiqrQncS//J5BfYVwAlb8
 8hzma1oGhN8Cnnj2Ei+PRRwsBYTM116nEbddpEom/VFG4fjWS+stX/+p5A2sRZSmiinFhqsP/NT
 1mEl29tIHkWre1sVVg6NEc8PYWAcdPASD47O6VLyPGDsmQa2HOwrOPGdyg3QKCDmc8JspzJkn/j
 A0Tgb0c1K059Cyggt1ZDw3X0iVi89rd5ZlRzvHFrnuDaFR/DJaSMpfo8ucrBS5FBld210n95bU3
 s+DIqDoM
X-Proofpoint-ORIG-GUID: EcnnMDuNx9UlPlE2TXunVClcORfPI4PH
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b034ac b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=VubKZi28iM5vmcOvH3cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EcnnMDuNx9UlPlE2TXunVClcORfPI4PH

On Wed, Aug 27, 2025 at 02:50:36PM -0700, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 8:48 AM Lorenzo Stoakes
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
>
> BPF verifier will reject any program that cannot guarantee that
> bpf_task_release() will always be called. So there shouldn't be any
> problem here.

Ah that's nice!

What specifically here is enforcing that? Apologies again - BPF is new to me.

