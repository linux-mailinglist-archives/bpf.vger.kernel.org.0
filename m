Return-Path: <bpf+bounces-74931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67311C689A4
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F180A4F0D4B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF52EA147;
	Tue, 18 Nov 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fpLI7Kf3"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F22FE05B;
	Tue, 18 Nov 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458696; cv=fail; b=UoiEf1j2giKX0N1OuL3U7e9fOlSe7nmCpGr1mFIekzRT4A6MeSavXG9Y6ExDFr4zusxIq7Apcjjg4XrdLs51EIIXXeziHJg0OxbldKiH0U1QfVHLihpVTZRMQXKgxwkeaFuGtxrLF9wfvOSH/y35uZNwvLm1VqemNOFd/pJ/34w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458696; c=relaxed/simple;
	bh=WSdRCIKEqfkoCOYTLRAVfyUGVGkQnQrKfI08eCMOBAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FFiw9sIsPKDDftP3ymwWi+SXd6IO17BSbbgPggUyxZcUu/mfTpKrXWBbDLUkIMtBfT897K26arx6B2IOTK1HTgsP4RsR0UswagNt5qTWuLiDs6VAdChJqDqH21MHHzuRx4Yg/YaWkIiqwAqKz77Nt2bROdzQZJ1jXaxDMmnH86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fpLI7Kf3; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d50Gp3wjRJtJhMdGtYxgWfCslsqKZPDaXAiS7pbJaFkKPdEY2NGjfX8rUQsn9LD54hlL6bDF+RMRug/EIUkO2Ovo6TcSAZAkTiQ7/620CkMyOL8MiJroxnJVwMgUl4IROmmbpfbUgA0I9gtQzTABGhUvmKLiSf1dY1IjHDG4UmWHmPjFOL5p/IXMt/gEp8/F6i+X6iGKRbs+YTGAjWyasdPym2EaB7bWmRFNQr/Gt3sE89gEYxdctHBmwyz8IWMWc8s8WyCHhEE3xo3ZZ8ORU7hLRPdePPRhzmlYOM/bfalmHiSvrJt6yeGPx8AgSGvuNQpsiOl4g1dh/gXRKpmTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ9H5sInXxLmBkVjUhkhp8wRg5ytK5PtCagRyB6GNU8=;
 b=ueMwclVHBCo6oPg8Pvc+qaz+IQURDh4lXaRKRrgCfkmXFDkLy3pjAFnfSDcz13igH/rTinQ06Mj5hmXYc9jpGTbMJd8n4ybtQN2kn1e4ii9dDdjEoy5mXRsllG29JuUz9NOMMWW0YenUAptqHFfzZuckRdVL3rsIpdyzu+c7G5V2w2E89R4yUkWmJhuHWchQ0WcbP6ld2EX7hCPBQtAJv/CQfGmaznOjjtpJgwwDHNp+SDR7wXaGqfPDJlklkRD9a+enAS8BSz3Q/9lIXKvgCa9SWpGPH7c5Hof2uRNwvKIDRN6XDLbumlWJfLdOpzVApnB2uAxxiaa+mhwq8ORUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ9H5sInXxLmBkVjUhkhp8wRg5ytK5PtCagRyB6GNU8=;
 b=fpLI7Kf3ttzNQMHPnNglzW6xlKZSve8AVur0W6kTzkclW1Zjduf3YvKWCkoNvk59NsBK4OJX8P4hCbyhcdY0+j31xRpD2hCTaf0toH3amWvaWftDb3Kr/qaincnwuqFqX5H6Fyd/J3hVpSNX4jtEObnqLy4wowGpnL4DpXuFjW4SYdtrneHApuGdhWL/Jw9Fsg3pxROKkiX0fGcdZxkt+sErA3NJKs3rMmWwnJsxAudclEU29rKEI0FOQi98ft7S2S25dvLoqaI2CiT4oQK0gFnwGl51x1wGNWEbxwJnakrIOlOcyFQ7lVsmOzcm2vt2IHImfjMk+ZYwFAxmauF7Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:38:10 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:38:10 +0000
Message-ID: <e634a466-a968-4422-a30a-49f6261d8703@nvidia.com>
Date: Tue, 18 Nov 2025 11:38:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option to
 show operation attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Nimrod Oren <noren@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
 <20251116192845.1693119-2-gal@nvidia.com>
 <20251117173503.3774c532@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251117173503.3774c532@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e254d3e-4ffe-40bb-c25d-08de26862f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WENiM0RQREYwRHRtanJGNFVhVHNJSS9BeWpIb3FMb0VOb29Kbjl5cmN3b2Zh?=
 =?utf-8?B?Mkdidnc5OUdzTzBnakZ0eEF4ek9iYVI3S1piS3UxeW1CM2ZObGlMNW45QTFj?=
 =?utf-8?B?bmc0czA2UDZ5OXVxTFBHbU55cXJXZkkxRXN2aTY1WFJqbUhDOVkyYUhxVGN0?=
 =?utf-8?B?RzdPdUFDanpITVc0ajdYdXNZb3FQem5KV29SWHZBbUFEbklCdlBIdHJ3M3NJ?=
 =?utf-8?B?b2hraEJoSUMrZ0ZQSkg0UElIWkEvSDVNcUNvL1d5NjhWOFdQR041aWxUYkJj?=
 =?utf-8?B?T1VwQTZFQnlmRTI5VUc1czBKeEcySVpMS3FFM2VGK2c4TXBzcTc0TWJHMUMz?=
 =?utf-8?B?bjg1TlkwYkt4WFhLVS90TmdZbHBrRUN5L0c5WUFEK3JHaFBaWVRzSW9pS3No?=
 =?utf-8?B?dHRsZC9rWUlsNENXS1dCTWtoOXhaaVJZMTBZVDlHSU9Da3Z3MXEvY0xkWjFM?=
 =?utf-8?B?b1I2MEYvT0tTeXVhUUZ1RFBrSUxLTlI5YjRYck9SOWswb0VTLzB6RFNZazFH?=
 =?utf-8?B?MHRtK0lZcVM4MHplYS9CL0NhT0RTVFdSc0NIT1VwWTBsM3UxUHlET1djcHlI?=
 =?utf-8?B?dkg4eHR4VU91NlFqTVJWbFJzSmp3b0tsOTNISU1yelJlYjhaNS8rZVAxT1hQ?=
 =?utf-8?B?eURackE1WUIrZEdWL1pydTB4Y1ZxZkFkYXhEQVNtZVF2bGtRcmwzemdaMkNU?=
 =?utf-8?B?MzlvZzdEbGV5aE1jQjNuUVAva1Rmc0hYb1c1SUVkTzZDUjRtVW1FQWM2SUpY?=
 =?utf-8?B?aklKZWtoVGNoYWVEd0xNem51dTlIdXZpd1lOa0NzV3dvMlRsTEE2MG5wVzl2?=
 =?utf-8?B?TE9lUVRXU280QW45eVg5N21CSy9ZMHllUmF0b21abExuSjJ6eGVubHZJUDdV?=
 =?utf-8?B?L240RmJ2ekJmR0s2eDRFVUhqaW5GaUpVWHdZVkJ3N2xFTUEzby9Ja1cyU1JQ?=
 =?utf-8?B?TE9NMU5WRFlsdERnVjBtYkhLVWxZMlRvaXpPMHJWZVRRTjRtUVIxWmt4QmRm?=
 =?utf-8?B?MEpQQkgreXp1MDNVWXlLZkZodjFEek1ERytXaHR3eElTSWNzRXdBZVFIdFMy?=
 =?utf-8?B?SVhTVTE3UG1ndzhYaWQzZlNmMUdDc0k4OUdJcUh5azRDclltTXYvMWtQZE1o?=
 =?utf-8?B?SkJ0bHFiNzR4b1NzT3NoakE3TnBYdTFaVnE3ZG9zOTNZUndZRTdKQ3VJZm4v?=
 =?utf-8?B?SUE3WWhYbHRVYWQ2Z2JxS1lPeHlveXNRYUM4OW9oQzNwb3c5R0k0WXdhelFy?=
 =?utf-8?B?R2t5em1pUzZVS1NkVDl1OGFGcjFjeXpUR1Y3R3pWQ1VVaEFpRUR0RWdSMjZa?=
 =?utf-8?B?WFRVNm1PWSt3bXV5QUdYS083V3hHeDhPRHU1b2d6ZUYrSlRHZzZTTnlRSEFn?=
 =?utf-8?B?ZEhZOUQ4b0l1OXpzNlM1NDdPZU83Sy8wOUZVRU1oOWl5SENhaStkY09sWkdI?=
 =?utf-8?B?MzR2ekVTMDh5ODZQT3ZEZWZqbjlZMUZsMlZBQ0U0ajB1NW9DOFMvVmZBS28y?=
 =?utf-8?B?cHN3bG1NTTF5TGtkNFVHRE9NM0Z5VE0xeUNlMkYrMitDQ1U4aHRqWHF0MTQ1?=
 =?utf-8?B?T1ZiemgvUnBPUFB0NzVpNkUrcmhRd213eFl6d0FyeVJnK2MwczhoVk5Ob010?=
 =?utf-8?B?NjUwUlE4RzhRajJXOFdDcy93T3JpYXR1a0JBeEwyYjFHZ0Q5dFFDV2UxSkdO?=
 =?utf-8?B?OGdtdkZpVmhBdGdDaHhrNXU4V3EvVmVGZFJtNWhuQlJyTWtSb05SbE05MkI3?=
 =?utf-8?B?M1JpUCs3NDJaMldja3Fhb1FTTFBGODNpMDV1a1NhZWtTMmxpemEzc1gycGlu?=
 =?utf-8?B?VmdzNXgveEM4UFFIWFZGL2hwamV6MmxJNlVkL2RWc3g4R1BkMExQTnJMSTBI?=
 =?utf-8?B?NzZ0MU1RYThDeWhHK3Q3TTJ1NmJJNWpXeGpDenExVnkrNGVNK2xxRGFGMUdR?=
 =?utf-8?Q?71KNT85n70bcJn1kgRSOa8Dv1nEn/fQa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtXZ1ozVmxRaldhMTdVYWE3VE84S3JMV2UzYWpzbjl4SUtTQXNiU21FdVh0?=
 =?utf-8?B?S0FPd2hqR1lPN1ZYUTl0UDJ0MDUxazhkdC9FZTVtS25lQmY0VXNNbGhhS0V3?=
 =?utf-8?B?L2pRcnhGKzk5OVMxN2NCOEdZOGNEWENPZzloMjh4SnI1c1ErS1NSYmEvbmdh?=
 =?utf-8?B?eDN4NW9MeU5OWmVwaFFIWnNKRFYvZzNLTklFaFBvMWVhSElKNEtjbjh3SDMx?=
 =?utf-8?B?NHBsSGdjQjYybnZvdzg2bll0VlY4NTFZQk1ocVZFTE9oQ3BPSDZkT0hNbXM3?=
 =?utf-8?B?YmhwalM3SlJxemg0RTJhNUN1YkRRdXNUWWFMeFBZYTRxdjJ1dlJOTWd2REo0?=
 =?utf-8?B?VkxhbnRQdml4VElqanZBM1Z0V0dFUGJIbDl0a1U0QjZodWU0aVpPa1pZMm1J?=
 =?utf-8?B?ZGRKZ2JoZUxlSTFWem9xbE5jMmFCMm1ZdEhqQU5FREJPbUZqelFwWEdaNnNG?=
 =?utf-8?B?bm1NVVgvSDBZL3dVQy82OU5STTZtRGVNSTB2RXlGdldoK3RIYkgyOFdvWkVz?=
 =?utf-8?B?cHkvb1lHL0MvdW4ycHpielhJYkpIdHlJQUlCeW9Icmo2Rk0xalRINnA3MVhP?=
 =?utf-8?B?KzRjODhCR1RCaTlMSDJ3VDJlMUdzNXNZeWhwVUc2R2NDN2NGd0NYK1RRY2Np?=
 =?utf-8?B?emhnamtJUFlmOWgwWS83NG9vRXF0U0tRQzVkam9XMFJtZWQvVzFwb2QyMEtF?=
 =?utf-8?B?amZ5NmU4RFVMeUw2ejdQeHp5d1QxaStuS21yQlZwWi9zc2I2dytubjVGYnNk?=
 =?utf-8?B?b3d1UTdVQjRQQUtIOWdkbHpIbTdUcTZSTVdySm9vTUtReGRZd1hEdWJYNHRw?=
 =?utf-8?B?dkR4ZERMc0crWTJ1d1pIWXhBUEg0aEc0eGxNN0dZWFZUekZ6U0F2UDlVZmpu?=
 =?utf-8?B?Qk1PQTFYaThrTTZDSlcySHBCb1o1bEZVTHdKSlB6MzQvU25OZjczWmMvaWtM?=
 =?utf-8?B?NVB4Ri80c0N3SXgrNWM5YVAyWjFzTkl5c0ExOUtOeWdDUFFYVXgvWVBUbHVE?=
 =?utf-8?B?NU9NTkd1SExzNHNwU0JYeUlLSUNES1RnRXRLa2tHbVdFdGE1U21VeWtUTFBx?=
 =?utf-8?B?Y3pzbzBNS2FMRGV5RHhIVVp1bWMzVURMaWYxZmgrMEZIVGZCdnJkQllqVHFy?=
 =?utf-8?B?UGNrZGpBTDd6S3pubHF0UDJ5YjEvKy9jQW1SS3E3c1VBUG51eHUxR0FpeHIr?=
 =?utf-8?B?Zm85S1hWTjZwQXdxRFFEUnFsNExQVWdMM0k2K3NBdkY0RHBZVXNwZWdZOVpp?=
 =?utf-8?B?TldaK3ZKUkhTaUFsQy8wcmx5cm94QXIzRGV4SkFtRXVwZGdGMHlOUFZsYkFE?=
 =?utf-8?B?bkJrbmF5YytSSVdpZnhtYk5YN3ZpaEtmVW1RRWF0eThIZmljZVAzRmxsNmxx?=
 =?utf-8?B?dkNpM0thTExrbEp2THhLbXhzREk3SEMzYUIvUjgwdmcxNFlTTDQwVDFua0ZN?=
 =?utf-8?B?dFYwZktLMFZMVnVvTXkybU9pNnByQ2FqQ1lad1Arb2hhTzNOQjh4OENSeGxH?=
 =?utf-8?B?ZkhiSjNlRHZJQU02UXVmeTllcnJNQ2kzNTBLMFJ5SVlUKzVsQm80TlEvYW9D?=
 =?utf-8?B?eWRHWkNQV3Bjbm9CTEpEVk81Q0FHejB0UUJwUGJoSzJiMDV0dTBxSWlEekNG?=
 =?utf-8?B?NGlYRGdIQzc1S0lNVTU4andyNjRTTWd4a3ZrNHRVU0NpSFVSQ2FqY2pXMVBR?=
 =?utf-8?B?SnV2RW9pTU84MmIvdzhvcWswMC9QR2YxaUErVU5SRnh6anhxTk9EWG9hTTZp?=
 =?utf-8?B?WEdnSGVDdG0rdGhFYXBDUVVhZHg1YUFnTE9OblZXYWRYcDM4Mkc0RDVvbmRR?=
 =?utf-8?B?cExRM3phTDloTDRxbURGcHVwZlUwZjdNRzZ3cTdRZGhVRUZ4TXVCL3VtazRv?=
 =?utf-8?B?SzBrZXpnZVNmcTFrUS9raCtLS1pCZ2VzeWpTdUEyYmpLQ0lSMXp6WEFPRWps?=
 =?utf-8?B?bko2bVVqVThuaFAzWWJxUDFneGU5QldHNW9sQVVpVEFKR29HVUltZVR3MzJk?=
 =?utf-8?B?K2lKb3lXbDZzcWxkeStVYVRmMHlCanpNWGdUbkdZc0RiblFmcTFjVkdMRlR2?=
 =?utf-8?B?M01yY2xtS3RZVVEycElGRUgrL3NWSDZaQnRXTXNVbzB3OEpLOHg1bWtPTTBI?=
 =?utf-8?Q?h5ij/ULcQICgAprsVPKFK70U/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e254d3e-4ffe-40bb-c25d-08de26862f9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:38:10.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWZ2BxvBZ1wqoJ51Dj10BUmKTt4ZAH2HLr7FxWHB5PHKVQxEuMqf0ZiICazVSByQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On 18/11/2025 3:35, Jakub Kicinski wrote:
>>   Do reply attributes:
>>     - ifindex: u32
>>       netdev ifindex
>>     - xdp-features: u64 (enum: xdp-act)
>>       Bitmask of enabled xdp-features.
>>     - xdp-zc-max-segs: u32
>>       max fragment count supported by ZC driver
>>     - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
>>       Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
>>     - xsk-features: u64 (enum: xsk-flags)
>>       Bitmask of enabled AF_XDP features.
>>
>>   Dump reply attributes:
>>     - ifindex: u32
>>       netdev ifindex
>>     - xdp-features: u64 (enum: xdp-act)
>>       Bitmask of enabled xdp-features.
>>     - xdp-zc-max-segs: u32
>>       max fragment count supported by ZC driver
>>     - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
>>       Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
>>     - xsk-features: u64 (enum: xsk-flags)
>>       Bitmask of enabled AF_XDP features.
> 
> Could you try to detect that do and dump replies are identical 
> and combine them? They are the same more often than not so 
> I think it'd be nice to avoid printing the same info twice.

We need to take care of both cases where the whole operation is
identical (e.g., ethtool debug-get), and cases where only the replies
are identical (e.g., netdev dev-get). This kind of complicates the code.

I'll give it a few more attempts, but maybe this should come as a
followup to this series.

>> @@ -128,6 +131,40 @@ def main():
>>      if args.ntf:
>>          ynl.ntf_subscribe(args.ntf)
>>  
>> +    def print_attr_list(attr_names, attr_set):
> 
> It nesting functions inside main() a common pattern for Python?
> Having a function declared in the middle of another function,
> does not seem optimal to me, but for some reason Claude loves
> to do that.

I used output() as a reference, but I'll move it outside.

