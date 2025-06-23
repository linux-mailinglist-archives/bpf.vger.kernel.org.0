Return-Path: <bpf+bounces-61278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89772AE3DB7
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A093A84AF
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366123D2B7;
	Mon, 23 Jun 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwyrp3rM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6381E492D;
	Mon, 23 Jun 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677211; cv=fail; b=H5GeN+A/mkU+L/c99UwXi6yGxv9fo5LGmQnroluvtqRFKJcKEZS33bfAvHkz/spgfd8aS8rM81ScznxInHJiV4I/xoSGdFhaiaGjzvybecWr5YdZiFj6vo4ofSkCJfNAxnI9sqY3tpicW6VlfrVfAdOMi5gbRdrj12MwjMB6J14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677211; c=relaxed/simple;
	bh=xYyTNKutpVpHTZ9LGv9R1ZeDOzyj5VeaK/FMtn8vn78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+XarmqVFgpQqdNrMjFQHS/o1VwysIppWe4vNGFCy3bpHWzSEVk/yt1GXYbWoVxj9VonYZTF6DZwy1Hny+RBlI6nACZ/0+7AzvdQeCZwhDpwt1Dh8suYfK8b0qTvRhHo692XSjSe2kuwmOrFQZiUwyTOxA4z6bDlMbpfANvJHfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwyrp3rM; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVa7opKLObFSqish1Lq+3e9txwxKiwMsZmyO8sP1eNaICdrQo3oiV6MiR6J/ATWxDYFeSqi6kk1dTKOYPExDvoKCc1DnDthhRBZgkryKoXTTJCv+6nbK8nTEh5OUC3uYdYjEfYSoVpHbG0axlXSZF3gByP8afgPCa6GFiRU8Ope3XZSiAryD6jqPe8JaP+Bdf0Z9W1GUoEfjNU0oNOXhrA1CrjchORt/Z00j4LwB7TVu6nwNEvfffKH/Z/geZ2NljzQ2lVpWvGaP061UiS2mSdUqj/Lw5C4nESrxPMbvx69g+r1JNlCQMHZ61Yv6pEMf2CZobeD51MXkwuwnAf/gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GazbYdqpaw8GeEVdkx1lwmAKtN+uJoMFTubIFVrCIFc=;
 b=UF7Kqg68WbRwnOQLJ6dk3q9+yGVBBihNj1PFAMcyBwKKeL1GlCeiGR9pk3oSCcjjYDKLL2xchoOmNrFGzffJgcJUJ/pSv4oWbqxaY68satO1ptVh2BgjC0CafcD9ybxI6yNjU3A0O/5aVqvFei5IdsgKrsatfRlCQ1efHRGPHwNroe0E/dw9sK/1WPmBq0vsQMbVjPzjqe/1EIbsW2bbIM3Eg+uctcm1nMyVlKHLV0W+tzr06+iBQ3WGn0gaufSzqUD3k4Txv613tg+OkwUHrzVTfRp9SLTUks8ORV8gDS4fhu/rvZstM46THcciNNHGIYJDzEuDX4LHVRMhewmdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GazbYdqpaw8GeEVdkx1lwmAKtN+uJoMFTubIFVrCIFc=;
 b=gwyrp3rMIsLvNwAN579vxQFs093WhGJXWqxPha64IQKTIp2X+HNd0aAPRJ3JmJ5nfF+uXih7+ETlf6aO6+nXh4XmVDAZt3TiI3wHyYXPN2CAk7Avj/3eNJfGo4X2QtZz7JoZZkSWz8LRVLC/fz3Q37eWeYSdgmMO8qD4ABRpdSLxzqsb3+pPHTPSr6ia3iK36JPuQ1QX6TsJchRdtUnw6B0+AZpfHZcDGB0q8RGga8s/UA/OqB6SKH3I9/GzTA9WFcZu5ABr7rny7M+WOIzXEHZFMYFmL2FNFnwNHMz8x9hfEguhRJ40Ut/c37xcDeqlkla10zF4NY+HKwtgxgORJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Mon, 23 Jun 2025 11:13:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 11:13:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, jackmanb@google.com
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Date: Mon, 23 Jun 2025 07:13:21 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
In-Reply-To: <20250623101622.GB3199@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0937.namprd03.prod.outlook.com
 (2603:10b6:408:108::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ae75e5-06dc-4e73-e535-08ddb246f90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnMzMG5UdEx0RTdJRVBTaWtCSGQyMmhiZVJoYXJhdS9ZTEFaM2kyYVZsNzhW?=
 =?utf-8?B?VkFUcWhlZkV5dFZoQ3kyVjlvOVhoQjdmODIrczlWVHJzN1FvbTArRDhubUJs?=
 =?utf-8?B?bitQZVdUaWRkRnJPbnlhY2FxYnRTRDQ5NVoyVkJ4NkRJL3A3YzhkaURuTW80?=
 =?utf-8?B?UWh2R3RnMDliTFdQc1laWlZjcHZoVTlRcllITStCMUJEYmpWUFRsUHpTQkxy?=
 =?utf-8?B?MHhkQnRLNEtZanRMMkd6dnZJTyttRFFKbGs5QWVLS2tZSjFucllTN2pzb3Mr?=
 =?utf-8?B?SHRqbGVnL3NaaDdHNTBCbG95V3ozc3M5ZC8zcmQ2cnRpcjRGalVzOWVyWXVI?=
 =?utf-8?B?WmxFZEtyUWprdkp4NURwVHc3enF1bFVMYzFhbE1jTkNTOG1HRFlXNUFaWlNU?=
 =?utf-8?B?UlA2U2Y2cUYybjgvWDdLbGR3Wm9rM2FIcUc2SG8zMmREM01rSTN0RVg1SEJw?=
 =?utf-8?B?NDRLQ2kwNU50eFRORmg0RTRQenR5YUNJVnRGZ2Rtd3NjeWIyVno2TFJDS3Yz?=
 =?utf-8?B?VklIV29lNDZ5V0FFTG1pRUt6UHNwbVRyRlNRb3hyeTVXb0dJYzB0QzZPL0xv?=
 =?utf-8?B?Q3lXMmJSUHdyQU01SGc4clZvQ2lTOVFsMEp3SUQzTm5rMDdKdG1uV1FvZTJo?=
 =?utf-8?B?UEM0S1ZDZGp6QjN6bGRveUNqZ2VUU0YzbGM1YkhOWU1xdjk0VGpGUG1MOC9F?=
 =?utf-8?B?R3Z1d0ZIandkNjdIb3BaV3hpTU84ajRDWUdEaERGQjhjcDhjZC9sV1E5aWJ2?=
 =?utf-8?B?WFc5Tnk0ZmxyMDduR3FVNGhOd2ltaGtLd1M3bXArQjlyVm1ML2xabndidGV0?=
 =?utf-8?B?MWc5V1N2YkM4T2dpZWx1WkkrMEd1S0ZUZ0h5aDJVVFo4Umc0cXNoeFlsbllj?=
 =?utf-8?B?RCtKK0FmNXM1Nmg1dUNIL0JQQS9ZSEFGeXA2TkVjd2J6VVplT0x3b05IM21i?=
 =?utf-8?B?N0pyZlFrbTg1WkgwNWpxK0k5VVdxckVzd1JCM0draGpkeStHZW9MQU1BcGVI?=
 =?utf-8?B?cFVncDBQYXNBdTlNd1FST0l0aW5IMlh1L2VzQlZiRVVBVmxQWXBPVHBqZlls?=
 =?utf-8?B?cG5udWY3VmxiWW0yZXhPQjk2SXpsWmg4engyZEV2K3N4RlhvU2V0T3V2SElk?=
 =?utf-8?B?UEVBZHdxZkVpYWVDMzFPYmFqS3FlQjRrbVRLNnlYdjd0dUtFSjJBZUlZL0JR?=
 =?utf-8?B?TmpsQkNKS1RNbHhldmRFZ2wxOFVyNGlsc2tRN0VBYkd1K2UyaWVja1B4cG1t?=
 =?utf-8?B?TFBMbVJIUE5LOTFBSnlobEdqYXM0dml4SEV0NHBHdDNaVDBJcEp1WlBOSlYz?=
 =?utf-8?B?ekdMSWs0Z3RMQXBIRFkrcysxQWxUdWxOeTVhWVZzMDVZY3hBS3ZZZGlUOE83?=
 =?utf-8?B?OVpkZ2hiQWp0Smo2ODVoc1lkclFBeEtFWGJxNFhPelV2ZEt5bWMzbnRpTGds?=
 =?utf-8?B?SmoyeTE0a0VDdG5YQjRoTy8weGxGOHNSN1FvMXFGclg0UFlWYk1Kb3cxRnZP?=
 =?utf-8?B?N3lGM256WXJuMXFUNjlwWmZMMmRDR3E4MTZaT2pPY1UrMmtpOEdmbE9hVHBS?=
 =?utf-8?B?b1VqZ2luU0Rua0x5OXJ0TzlaclNsTnRYM3V5TmFIaUQvOFRVb1hqOEtsQXVk?=
 =?utf-8?B?czRZemp2NXlac1hIbzB1RHlTSEg0cmtrazNLT2gvaWJqdDRYZFJLV0tac3g3?=
 =?utf-8?B?T2VEdkpVS3ZhRmJCeHhIRGt2TWp6a2FLVGtsNnBiRDhYakN1b0JzdkZFWGll?=
 =?utf-8?B?dTk3eWpJN2UvUmd0Ym5IdTRsYXk0amozVlorU0pmS0hMRmd4Q3FvbVFBS1o4?=
 =?utf-8?B?ODhXZ204N1R3ejEwYkJETHFPN0toZXgveFczYUpTbSt6V3MwWUlOdWhGT0ZG?=
 =?utf-8?B?N25zbEN1di9yZTlMS1hjbU5LWmpkc0ZweXRiSFpJenQyZXFlR2w2L3ByaVNk?=
 =?utf-8?Q?uQW6aJrclaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZreExEMmFINEVHeG5OZWVMelZHMmVVdXkxbGJNcTY5M2JLVWhaQkcyZ2o0?=
 =?utf-8?B?bWZTeU9RWkxPVmZDbkluRGV1eDdsZlE1UEhVbE1HSFltRTBYMEJEckttSE0x?=
 =?utf-8?B?U1FtNW5jVFlvYlRId2h6UjEyN2lWZFdyUm94OGVZdlRmM2lkZE43V2tUTEZv?=
 =?utf-8?B?c2tJNFlubjVnTEFSOE5STWppUjRMQVhyNS8rVjJQQ05ybmEvTGtxcTcweExG?=
 =?utf-8?B?UCtCZ3Yrc1Y3NnVzZHFlQVB4NlBHWFloRzc4d3pvbm41VXZPSjVnZkRHV2Ur?=
 =?utf-8?B?L1ppcnk1MThUcGdaVXhXK1RHQ2JoNjFkdDFZbHJxY1VXRGZXS0xWanBvOHE5?=
 =?utf-8?B?SUVnb2x4WU4yRktXYVZBZ0RBUUdPdmtrMHZVYlBjTXovZWMvOUpGOFBFY1d4?=
 =?utf-8?B?TTgzRHhIL29kUTEvckZneTFpU2NzVGJNeDNuaWNvM2tGNUVMWVI2L2lvN1ln?=
 =?utf-8?B?NGY5OVh4cStFeEl4YU53K2prTVl6dVRQV1RzM2dwNEVmUXFDYmh6Y0twWU4z?=
 =?utf-8?B?Y3d2ODRFbHYwMlFyMTBZblJxRXVpTnZaeXJwVHM5WERmdXBFSlB6a25xOW9K?=
 =?utf-8?B?TXJxWEtzUmNjYlQ3RGY3UlNKdGhhRDdNZmhpSmZZSyt4V2tpQmR1bmEvZkhQ?=
 =?utf-8?B?YTdsVVdBRzZRcHZKYThJRDZJMlBvamg5Q2dIOXlMVktuRWpxMmVYYjd2SHM1?=
 =?utf-8?B?NFlkL09BMjhleDEyY04wanhNZS9BTExicjRnRHM1VEFOWjltVndrQ0Z0MDNW?=
 =?utf-8?B?OUxwc3ZGSjd2UWtPc2IxUjBCcXQveEw2dTlMa0tROTRKMXc4K3hyenBBUWww?=
 =?utf-8?B?c1dqNVM2Z0VrdzF5VWRFNHFET3IvbElHeXd4VGpJWS9WTlU5K1JpT3h3cDk3?=
 =?utf-8?B?T3g2L0FqcUcyNEExUjBSa04vS3VCMG9mWHlEcHpNaytzSHhZYTRTbUxLOVN2?=
 =?utf-8?B?cElLbTR3VWNFNUc4VXNHOTN2RU1nMGVkUWpEcmIyYTkzMEhvNFhnT0pCY3VE?=
 =?utf-8?B?MVZLTXZseW10eTB0TTFCWEk2UmpkbldwOWtBNkU1RCtxV25uZUJUMndkSXJI?=
 =?utf-8?B?TExiNGUwYkx0US9MOHpVdFAyWStBZ1pVWkdYUjZKaUcxV1lzcmlqL2VrYWZO?=
 =?utf-8?B?VWRUTFRhV0U4c0ZTZFYrV2VoMVVReThzeFU3b3J2NGsrVHNnbnNsSEhlMlJO?=
 =?utf-8?B?bjNlMjJIN0MxZ1lQWWFhcXZZS1BId3B1UGhLMk1KcU5XcEo3VnBFOC96SU1Z?=
 =?utf-8?B?THlOWjhZUWwyQXUrMEUxUnN4eEdDeFh6Nlk1d0hHeVFRbnFwQnNLRmhyN0Zn?=
 =?utf-8?B?UW1ZcFBRUExkMDRmeTlKekxqaTV0amJodE5seEU4cjlkMnFYeXlVMVNSN2tI?=
 =?utf-8?B?NnZwVFpNM2VpbHd5d2t5aTBBNTRIc056eU1VdkljaGxZdDhqcDkyaUN2V3pB?=
 =?utf-8?B?cm1PVzJDak51OGUwMGJha3hjVXdnZUtyeUFvOGtibHdUdGRxZ0dFdENXWmVK?=
 =?utf-8?B?U1RENHpYbXR0U2I4akpoV0g2YVJuMWZuYWE2QWFiU3BCQnZpL3J3K2hoYmFJ?=
 =?utf-8?B?UXU4TGpWTnlNUmtFQWt1eURvSTNZVHU0aWxVdG55Qm9qYU1sZ1pqc3JLaHhM?=
 =?utf-8?B?cGlGeDduTXdQRnNBaGhOa0w5ZWg2VEUrNExuVzdzaERHa3BMYW12ZVhYT0RY?=
 =?utf-8?B?elgxNngvWU4zejdJTlpTTzFEd0pFRk9VYXBWangzV2MzakM0ZWw3a3h6UGt1?=
 =?utf-8?B?ZWtOWE5VS25jTXcwUkd6L0Z0VUtHdTNOb1gzZ0hmSWk2eGpyREIvc3RFR29F?=
 =?utf-8?B?TU9OVlorbTN5a2tFZENGcDlXeXVMdXVMQzliWXNFTDNzM2Nua1pySHE3WlND?=
 =?utf-8?B?dU9mcExybWxJU3MrR2ZlMmdzRS9yWS9UaitIYnQ1K1plbkYrSTE2OHFnWG1h?=
 =?utf-8?B?SjJqaWdPa2t5dXBQNEFJQjlWaWtmeGtpTlAxenU3L2tXWDFTK3djZm1LV3VG?=
 =?utf-8?B?amNWYjBpdkliYlhnMHYzTi95ZWNINGdqSExHNU1FMmJXQ2tvaldETXorZ1lt?=
 =?utf-8?B?cS9uU1NLelNJbGdUVTZBQmJHcmhURHg1RkRjMytVM0ZUTnRMTWdJeXF4S3RW?=
 =?utf-8?Q?KnF8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ae75e5-06dc-4e73-e535-08ddb246f90c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 11:13:25.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGFv0fjPNUbIsSmU4dnos1NQdAvXx0ReBvZ85URGA9/qDeTBJ7gi/QnP8hQwCInl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

On 23 Jun 2025, at 6:16, Byungchul Park wrote:

> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>> On 20.06.25 06:12, Byungchul Park wrote:
>>> To simplify struct page, the effort to separate its own descriptor from
>>> struct page is required and the work for page pool is on going.
>>>
>>> To achieve that, all the code should avoid directly accessing page pool
>>> members of struct page.
>>>
>>> Access ->pp_magic through struct netmem_desc instead of directly
>>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
>>> without header dependency issue.
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>> ---
>>>   include/linux/mm.h   | 12 ------------
>>>   include/net/netmem.h | 14 ++++++++++++++
>>>   mm/page_alloc.c      |  1 +
>>>   3 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_st=
ruct *t, unsigned long status);
>>>    */
>>>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>
>>> -#ifdef CONFIG_PAGE_POOL
>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>> -{
>>> -     return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>> -}
>>> -#else
>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>> -{
>>> -     return false;
>>> -}
>>> -#endif
>>> -
>>>   #endif /* _LINUX_MM_H */
>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>> --- a/include/net/netmem.h
>>> +++ b/include/net/netmem.h
>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count=
);
>>>    */
>>>   static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _=
refcount));
>>>
>>> +#ifdef CONFIG_PAGE_POOL
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +     struct netmem_desc *desc =3D (struct netmem_desc *)page;
>>> +
>>> +     return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>> +}
>>> +#else
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +     return false;
>>> +}
>>> +#endif
>>
>> I wonder how helpful this cleanup is long-term.
>>
>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>
> Yes.
>
>> There, we want to make sure that no pagepool page is ever returned to
>> the buddy.
>>
>> How reasonable is this sanity check to have long-term? Wouldn't we be
>> able to check that on some higher-level freeing path?
>>
>> The reason I am commenting is that once we decouple "struct page" from
>> "struct netmem_desc", we'd have to lookup here the corresponding "struct
>> netmem_desc".
>>
>> ... but at that point here (when we free the actual pages), the "struct
>> netmem_desc" would likely already have been freed separately (remember:
>> it will be dynamically allocated).
>>
>> With that in mind:
>>
>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>> could check that instead, so we don't have to cast from pages to
>> netmem_desc at all.
>
> I also thought it's too paranoiac.  However, I thought it's other issue
> than this work.  That's why I left the API as is for now, it can be gone
> once we get convinced the check is unnecessary in deep buddy.  Wrong?
>
>> 2) How valuable are these sanity checks deep in the buddy?
>
> That was also what I felt weird on.

It seems very useful when I asked last time[1]:

|> We have actually used this at Cloudflare to catch some page_pool bugs.

[1] https://lore.kernel.org/linux-mm/4d35bda2-d032-49db-bb6e-b1d70f10d436@k=
ernel.org/

--
Best Regards,
Yan, Zi

