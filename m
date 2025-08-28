Return-Path: <bpf+bounces-66831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D20B39F45
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F24C3AFF5C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DE311946;
	Thu, 28 Aug 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKHbh+ND"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5E13C9C4;
	Thu, 28 Aug 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388648; cv=fail; b=ibLE+Ldlnu69RAWosdWbuwpuGxrNkuQ1PBOfzcpseyEVZXXa7OrBIAUBpUOmalNyC6J6B/RlTcbftWOcWgJG3e8RYl/JTu5Qn9GauKlaZGKyzVl8Y3Tsl16VeW0AiD8GNZxu48/ZfR3gKf7ZB5q424HxNOQUgQ8RT6jzjToVgwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388648; c=relaxed/simple;
	bh=s+k3dcbQTht9jDIqx200PEYKUzTwrzVv02DPO7/Lbjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ia9AxUaSnoDTKfaN3Np4Sgd14KhOuYx7+q/he7J9d7iNrwXL86tRwVvSPLeDbFdmtFN6MJA5bRAjUtaxq0pPyvV7y8mEZ631cIOFBkj5uPipkXbwaht+4hDlo7iSuQJu09SVQfCz6HgNIj8XpWlIZaXi/Yxc6FLFwtVEzoIxdtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BKHbh+ND; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeDRKzIW3VrpkUhXD02DFVyaBoJhEIUfmGlzXildkZQ+vtK2EcQDyjonV8eIv1nPSVjsqhyweJUm6oAkQ4KhA0ZzU5nA4O9703FYbmyePvfITNG/RxT9+jvtryzhkFzRuQ3iuwZfpQcoW/4ptbwutXiVkA0rS9bzgvDNT1P6ri380WClgCLDqGhNXKgrICp+vu0oa0nelW1Koe1bueWsscwyosYhUyQAr9ZX+rV2SLxdVX563/8LiBJ65wYkb6crxJjxq/SpajzV1K824yjxjnNy0cLFBzf2U0FQNNj8RnaOx/lenPrTs7lHO+0m/Fo22wl7QiKrYBWNpFx60Tai4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+k3dcbQTht9jDIqx200PEYKUzTwrzVv02DPO7/Lbjo=;
 b=MGBzOSzrdCrvJk77qDLdksAWtcO7RCsMqwxwznqZEN+LoTd5f1hjWlOoiGiJew6ouiY3bY+5wQ/5GcNSIkX/DqM0xu8dDAFj925oPgosJW5aUggbNwkeN5rT0hNkETvjw99olFUDTj/ecMNiJUk0QtXgS9xO5xGtO7MuvV6CgoWGUEM8PYS45oyN6Binuvtw/FHxD7PptgF22hzOJ88uCUGCxJvB7tvriqigoNBQsmEYXK4ePcHcZVjpRo+v0TaQcrLudIUIKH/OfUz3lUR+85d7zswDJHhM2u0uTllSOYxPiSUzHsoPsDSyzY9iBHWOVzmlGFW3uL0F87D5B5ObdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+k3dcbQTht9jDIqx200PEYKUzTwrzVv02DPO7/Lbjo=;
 b=BKHbh+NDUUpsFf/sIQWg9IH1SzkvbtPKnMq6TBPkHbCNsbZ73E2df1JZyqVSOYq5h9Q3vXjF1vNcmYpEORw1D/6CWJWVm57dOeutzb/I6gI+RDmWR58F37Q1qhHynm0syiyeo0fDW/CfzSRrm7gugnGGy560LUKvZiHzcs6RnVnujCsbXNBhvppSO3I5D9iK98dN8ELGIYjDm9kXRFReCD4U8UJJQ1uvwq/uHfbyPHNZAF1etWW1HJ75VXgbvrO2cfakBUDeKWrb5Fgp7A/qbvPvtP2z6x5yCM/pxfKuIKdXeMY1WQMcSq+hvMZtV1+TvdolWmrkqrgdDqBv5lt5Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 13:44:04 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:44:03 +0000
Message-ID: <f35db6aa-ac4c-4690-bb54-4bbd5d4a3970@nvidia.com>
Date: Thu, 28 Aug 2025 16:43:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a
 frag from head and tail
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-3-ameryhung@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250825193918.3445531-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To IA1PR12MB6186.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3484d3-0525-4789-87ec-08dde638f319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnBGdXdkVHVzNW8xUEdDWjNqaW5xRmRsSC9xUmxFMFlpcVpxNW1zN29KVDNw?=
 =?utf-8?B?cnhaa2xiTTU2U1VBZHFuT1hRYlA2UVljWGhDQzVqdE1kSU9SWjd5MmRKQU9V?=
 =?utf-8?B?WTNIOFlqY3IxQVpWK0wxdFRNemI2R0ZjdWNwdHFkWWtaeG5RbmEyREJ3OWc3?=
 =?utf-8?B?d2pUbjh6bHBYMFdJZ1o4YUJOYjcvalp2d2h4M2VHTTQwQXB1Wm8vQWNOd0lt?=
 =?utf-8?B?aGF0RzZPME1QVDJJNzc4bmN6N09IYVVBL1J4Z09qcXpxYjIwT216bFhmZndV?=
 =?utf-8?B?Q3NtODBMZHBYdWJaMXk3QjliU2hjb2t3TEJ2T1NRem41NHo1V01Wek9VTHhU?=
 =?utf-8?B?L2pLUThyaVRGUlU4SUNDbnQ5ZFZFTzUxN0c1SWM0L3lhdUFucFJ1N3VJNFJk?=
 =?utf-8?B?aExBYzZGOG51cUszNTdZRVloRkdLc01qdWtDRHAvam9uTWRjTXN1dmIwUTZn?=
 =?utf-8?B?UEZVcTB3Z0hyMnJjZDFZTU9LdmoxbXhKS2xUMUlVQWZhMWxGMk43VCtEalht?=
 =?utf-8?B?c1lCOHBIOHcvZis2RFp6VHp5RjBqRWFEMjhEUWNneGlZcDh0UWFSQ3NtaW4w?=
 =?utf-8?B?bFgzVFVmWHhtNFI5N2Naeng5ZURBMEVta3gySnk1MWlEdnVlY3FkbUN1cThY?=
 =?utf-8?B?TC9EVkdrcm5FU2M5RlZDT2s5NTQ2cUJsOWtWS0tXL3pIMjZtOHJhUnBWcCt5?=
 =?utf-8?B?dWJCQy9BWHBndFFOM2R6SjExNWNQbXdKbTF6ekVpRjVsWWk2Nm1ldHFEZ3Bj?=
 =?utf-8?B?VU9VVTN0ZHBMa2RRcEtMaWsyWk94bTM2NmxMdWZuRDkyYnZYbTY4R3ZhVmVh?=
 =?utf-8?B?cytTNUNzZVBYSS96dWxXa1diK0dtTjRyT29xTEdheDhaYnhKc0dFaHJPVmdU?=
 =?utf-8?B?QmpkVDFPVTJpaTEwdzB3dGF5ZERMem5iTHZ3SjVGZkJHWWFtcnR3ZTc4SWZQ?=
 =?utf-8?B?aTd4clN4d3VMNWlTaEtwdmxMa2dBYkRhZStaSU1aWU1hSmRyOXpSdEJ1V2xJ?=
 =?utf-8?B?UFZjVnRKaWlSOUMvYkYzT0FyS0tXL2Z0Y1pnUHVGbWdYY2FkL0pBY25leW43?=
 =?utf-8?B?RTNQM0JKMDFlZ1JXQ0dNSTduUTlnMWUxT0JsU3ZVUFFhc1pKc09abnVuSFAv?=
 =?utf-8?B?UzdEdHpCcmJuR00vY2RGLzdDOUdtMzhJRDR3Z3FmRU1YWFhCTzZCS1MvR3ZT?=
 =?utf-8?B?T0xRM2lCTDdrUkFRZWUrZXFrVFVZK2Y2aEZCUERmenF4M3JWcm5jZktSajR6?=
 =?utf-8?B?WDNxWThVRG9KR0U1SzlYR001eCtoZDRVRDFyUUkwN3krYm1IbXBtTE8xbWp3?=
 =?utf-8?B?dG5sdmwzQ2tHaWlCZTJYSzc1cEl4a1JBTVZKV3NTak9MZ1QrYlliUnhhanNn?=
 =?utf-8?B?RWtsbGFaeXFtL2cvN0szU09NOUdaMEh0OS92dnFCbXBENnJ5bkdXVUx1T1Nt?=
 =?utf-8?B?SmVSd2c0WkxyQzNrdlMvNXNDNUxCeUUyQWl6c3YvTEhoUW9OOXA3ejlnK2RT?=
 =?utf-8?B?ZkJhVVcxdk1rTE5CY1U0aTVqa3B5a1FXOVhnV09TUjJIcy9xanFrRS85V3Ro?=
 =?utf-8?B?SWlIZUVHa21vS0hCTjBNYWxqdlArenFKeEFJK0xPQmdQYWs2T0lzdG1LbC9s?=
 =?utf-8?B?NzJDcFJHcE1MZnp5clVzWTloSXQveXQvNDRMQ0Z0T0tjb3RlckpsZ2VKRFM1?=
 =?utf-8?B?OFNOT2pVK2xtcUk1OWRYbWxjdHdXWFdBbEVyTmgvMFh2Wlh2bnBZNXMrTFU1?=
 =?utf-8?B?ME1weGNrbEZ2S3hCd3kwSmZxYjROWUNldzIvMnNNcWtpWWRvTUd0dmJaTmtS?=
 =?utf-8?B?eVFEOEtyTUdIeHI5VGN3UVoreE8rVG1kb245K3ZTTUtWME04Y0pNSHpYdFhV?=
 =?utf-8?B?cVo2TlRxa3E3NFlBei90dThDVmpoM0k1TWpwMmw3cGxxaFpFWERwakxKS1FM?=
 =?utf-8?Q?fR6jgIUzu54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVZTT1d2TjV0cWJncmc5T2V2eEFGN0pHT0ExTXc2RnlQYmVXMWZEMGhNcWp1?=
 =?utf-8?B?dXZtOUNKTm9NajFuNlJVZEZtY3RjM3ZPVmsxSll0NVl4SjV1TzZxUlRRVDNJ?=
 =?utf-8?B?UTdSWWd2OWliaUJDbHBxc2NmUysvN2NyN3hQTzI4ZGxaNjNnakErRExtNUc5?=
 =?utf-8?B?SzhpL21WN1BXejBZUElybUdYdG5qUWtzaDNyT0cwUXJvRTFTZ0lKeTBaaE45?=
 =?utf-8?B?eDhjOXAvUjducHp0SmtHR1hUYlc3NmMyMzN5Y1NUZkRKRXI5bWtXTU5KZWVn?=
 =?utf-8?B?c1E2Vi9XaVpseXU2Y2wxK1liK1RLL25jZkM1L0NHanZ0S25ieUJ0MnZBc2hm?=
 =?utf-8?B?WGh6WU5WMUgreSt3Ykh3ME9pTG5abm0zdUJRTGNTcjhZdEdsb05sT1B2a2xY?=
 =?utf-8?B?Wk1rWEVYZitXdklHOHkrWHJpWjY4TDFzeC9zejNZejVYWE05S2JnTVE4cHgz?=
 =?utf-8?B?SkN2VFdrd0p1WnYwOVZiVXIyamYwQjdrRE84Z1IzdWwwNlhZTWNCMXlYdHV6?=
 =?utf-8?B?RUczMVBhVjF0T2FxWlN0MzZtSnBsOHBCc0gvNFZDNzNtN1RzVFVqMGxwQ0Qy?=
 =?utf-8?B?TU5BZGlVVWYyUnlBbk1nVVA0a05vRHJMUHJlcjg4OHJnNmErcGVoM0VNUEow?=
 =?utf-8?B?ZklXQjd3MTFWZzFZUW5pdlF4UlNmYWJ2cmE4MFFiRERNVFJVcUc0M0IwSDZL?=
 =?utf-8?B?QmJCem0wOHlHTUZCV0lJc1JXcGdNeDNGL2JQZlZ4RTRwYm9TWSsxaWE0ckNO?=
 =?utf-8?B?VGNoVXluclVSWWJkdnplRkVKalJGZGw3dEY3THpWWGVFMno4V3JmMWxSRTV6?=
 =?utf-8?B?TU1QWmRzZ2NzYW1HNE1QVmZQdDgzOW5aTTNidUdJYm9PamZEOTd6OUNrdk5W?=
 =?utf-8?B?eWw4T29vdHNjalVJVHlaM0tES3lmZ1RYUWNJa0plaEsyczdJTisxZlRESW45?=
 =?utf-8?B?M1ZLdXJiVVhjNkd0Sjc1SGZnWEZoaDkzNGdpSjdNa1RwcXNPQUFBaWoyeDZZ?=
 =?utf-8?B?N2NIODFNdzF5WE1EMHNPMVVxQVQ1cyt4UktPUmpXQmxpUG1YSWVwQUhURHQ5?=
 =?utf-8?B?UVNDbnFWOE0wckVMcitIYXhuYVRpd2xSclNxYU9IM05CSUZmZTNhMUdWYnFG?=
 =?utf-8?B?ZjVDQ0h5YmR5SE1Qbm5jMkxMTkczbzVQR0VrVjNxMTJwSWtuQnNadWl1Slhw?=
 =?utf-8?B?QXgzcmw2cGE3WDh5ck9lbjhXQTA0OWJ4Mmh0NXEyV1c3ckMwNUJXYkpaVDd5?=
 =?utf-8?B?TzM3aG53emhXRmc5cm83Um9sNlpERzFnbzZnSjR3Y1R6OVQrSmUreVVEY1lS?=
 =?utf-8?B?ZTlaUlBualVWUkZxYTB6enFwQjBoZTdOM0F3NWJCTEx5WVEwUFZwZnBMOEda?=
 =?utf-8?B?ZHpHVncyS28vZlpBQlpRdis2QUtUc1JNY296Z0pTOWhnWkhOYk0xcTdJVnRy?=
 =?utf-8?B?TE5DNFhlb0I4TzF0LzUxaEsxVW9OWGFMYVVQVkwzanUweWdKVnZLNWFnNWlr?=
 =?utf-8?B?S09sRVo3cHk3ajFZSmxzZllid25zdWNYOUNtTi9BOHdnZnVTNDZrWEp2dGxR?=
 =?utf-8?B?QjZib0pkMnZiK1B6THVobkV2eVJncnZxTWEvZlBkZy9lbHdRbldlaXhpSitl?=
 =?utf-8?B?NGRNMkVwRjRkKzdKTXp6Z0JrMVZVOXhDY2p2QnQ2QTE5eUkrQUJ3czFtZ2Vs?=
 =?utf-8?B?TTZnTHArNVpNbnVIakd5OVNnYWl4TUE3QW4wU0RCMDRHREdpejRySXVncXc5?=
 =?utf-8?B?TkprWE12YWlLVW5rNnQzTVpOblFUZ0trRkFTQzBwb0F2R0dDYlZVRGZqM3g3?=
 =?utf-8?B?N2JnbEJwR2puZXNHWlUxQVo5WWxOdTdLSTNEYk5uYk9CSHZDdWtabVdYNE0w?=
 =?utf-8?B?aWVrd2dZSG9QdHpoU2haSS9pMzh0cEtwZTl4VTkrSytnMC9UYllTSnhKaEpk?=
 =?utf-8?B?NFQzUm5uT2dUR3F6SmtuV0M1b3d0M0FBbTNrZzVMNmlHYUdLeXFNRjRmQVNy?=
 =?utf-8?B?dWNQdndPM3IwaUs0YytNbzkyaFZlSm9ZK2RHcmxhclBvL2tmZUJ2WEo2Y3I5?=
 =?utf-8?B?VkJtc21XUnZXM2tvYnRvVVFUZHdNTlg5QXYzZERWTDFwNmJLNFpJcm9PTW1D?=
 =?utf-8?Q?I7GpgCCkuZq+oEA5Nr3QBxJkQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3484d3-0525-4789-87ec-08dde638f319
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:44:03.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlOK1ch7jksU2/zDcqWTbTFfI6JOx2ajV2S7apHtMQo+RbGtAAtiLRPDoUHseNRfmROnPPym16iaLxP7EhinGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

On 25/08/2025 22:39, Amery Hung wrote:
> Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> functionality to be able to shrink an xdp fragment from both head and
> tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> xdp fragment from head.
I had assumed that XDP multi-buffer frags must always be the same size,
except for the last one. If that’s the case, shrinking from the head
seems to break this rule.

