Return-Path: <bpf+bounces-75061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC5C6E4A9
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 12:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCB3517E7
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E3352FA5;
	Wed, 19 Nov 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSyBzGr0"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2B32721A;
	Wed, 19 Nov 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552179; cv=fail; b=iiubPd/Cj1RJv/bQyuqQPODwnKAbI9Kn7cOSVBIcB6PDKyvy1Kg4QJTGK39OHgRh2Ek+f941gd8RjULc1BGg3OSokx2+MfB5+svvR3h+6tXYsCZxO2lnr0TrgOWi0DOAuVfn2EBqPnlIvPZ9EY3vd9KA46B2uPHKZXTe7CkOO+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552179; c=relaxed/simple;
	bh=DFhOWoYdhhHl3a+7Na1ZmRFUd7m0jZ2lGZVb3J/GTnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeiMXEdIUvlDghAgNiKON6/EDHPS4HOASGZZt+2gqNFXUImtcSOC+UoeoYGoplv2r88UtJLq6X6C/puXOuA4z8xkDacyV5g1yymArm2uXhTDbln+RuM/ryKLkWD0FfoUwq7PdxIf2GbkT/Z+RH2ozQHTjFklw7ycFlK64QrU3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSyBzGr0; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD/1bWyGAnXralnTlDJV/rMouvNZdCYe++zY6n7FmXr2xRC+t6H5k4ztENIe+83rptuQS2MoM/FGZw6TP7rK1R8ODBcfXT2A1TE/V3iWljjMskEz1rq0jGGK1o1I/RHxRJaMOM0wSSd/N/XKzuOaxZQ9RIyq3Dn7VbgFkDI1fVRmUoqy4pe4DC0LjEas3T+ARViS2aDFZRAqCcpudTQvO/ipt6cg9yt33sEeJb1+TnXIwZB6Qqn7zZYt/FJ79/9uS8KkFoVc2G7+g8TJMSH39v1BxQj8jzuNq2Qwcb8n5tsGWX52528reWpSIA8v2Lnv2T0pYG6pRRI2X+oK3TVjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EawWJTCx3XZ5VD/dz3huqA2YEg6iqTJXrVCJLJPj+4=;
 b=yMWLUM7vzTIiRIz+RwKwo9oGhzlmN9FEB7IMt3gt3Xg2VfzEechDWlWbNQeqYqw9taKRd5hFMhIQFdJNFvUS7e9U2rVoYHo0Z0oFTzwzYuSY38Y6zsZfJHFHH6N0SsALg4LWtNL9qJ+crJGIULVDZpnGyVXFqwAXfhS5DYL/Fs80LXmqu39lrT2nkx8lDPJro6PbFETL4pcfKnoTVfCkG26stRAM3ju7ysFi03rNj0p3lk+g7iMFNOH94HLDGe3JD8M8eSvgyjUEAX+kcrLd5VlCM1Md9jhAq5N60tK4pEpEKCAU/wc1IcK4tCkT73Q8leVKgQIygPAtl/ydkfWt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EawWJTCx3XZ5VD/dz3huqA2YEg6iqTJXrVCJLJPj+4=;
 b=kSyBzGr08buLhH711FAxB2jth2Ptgi91WF3ztaz5ZBagsKOpU3VvWeU4wFG0LbYSixWCNVjphCvb8Ds6BXPQL4rcRxHDpu2Bl4Dzr58leltiaKCfk2p2H3QbVmhaLB7KzzufpBF+ozT3ZOvCxQodVQiiFOtYHIivZcw3XGc1KXn8cmZfCb+0OmYwBHWHwIYz+42AmrJH2U0PzclMEb9z3Y23j1h425RvoKYvGkhzX7hfbtdXGIU0U9PXJkogI6tpRL8EP2IaUzgbO1fle4xQpeS6iHM980KGjYryh/X3JMtAevgBrX0k+rZQigASgoolfTjhM2HpLGSEWOZ3h9BLBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:36:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 11:36:14 +0000
Message-ID: <acf74a59-f399-4952-81d7-f99e13785fb2@nvidia.com>
Date: Wed, 19 Nov 2025 13:36:09 +0200
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
 <e634a466-a968-4422-a30a-49f6261d8703@nvidia.com>
 <20251118091328.052c88d6@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251118091328.052c88d6@kernel.org>
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: ae14c93e-4aa7-4e52-ce10-08de275fd88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdVTVBLTmFKU2NmbkZ4Mk1OVUZUOEN1Y1pXbXVWc0FPRkpzMUk2WE1Nem5M?=
 =?utf-8?B?bUN0ZW02N1JxUUlQQ2dsc1JwdWhWc2hnNzNmTVlPaWxNOXhNN1ZwZm81LzZZ?=
 =?utf-8?B?RC9LU3R4SWNFdUEyeXFpaFJFTVZYQzRvam5uQTcvY005QUFCYlZyV0cvZU1G?=
 =?utf-8?B?djVsV1VUVms0Q0o2bkFRUXdvY29ERmpaR2hERmVDM2J6VXU1eVlNOTQ3T0RS?=
 =?utf-8?B?bzYzNXlBaFdsVzFIbVBhZ0VBUUdpYkEvbmVVbW4rcHJWWXVoN3F4djhyemVL?=
 =?utf-8?B?TmQ2TnozaXRpOTFhTnZhY2hMYXdCcjluTFY4OGM0aWJMNkFIQW5HS0tKcHh2?=
 =?utf-8?B?SGpFYlAydW40WGhsSU9lZGd2RU5FQkxtQ2R6U3pWaXFYVTBiVkNvR1l5Mzc1?=
 =?utf-8?B?T3ZCM1FpSEhoQ2VNOXpXY1lRYjlMZjNmZmNBcS83T05kVXJJT01jeEF6Y2pq?=
 =?utf-8?B?TGRGaHEweXM2emV3S0pBRzNVNnh5a0NSRFRSaHFFd2pDRFdaanhMYnhBSFZE?=
 =?utf-8?B?VkNxcXpFdnE5azg5OG1SMkJmdEE0VnpNdG1qb0lJRGRoaWVTSjNXVTl5UEZk?=
 =?utf-8?B?ODVwSDduWHVDcjZ2RlEwUmQ4MHdGcW1Eb1NrN1BneGY4YUZEU1AwVG1zcSta?=
 =?utf-8?B?MDhsaXFyN2lnekxjQ3JlK3hSdDYvZzBZSzFuMC9WNkU3SnhFQVk3YTJ2dEFO?=
 =?utf-8?B?MnAvUFp4Z3RvQkU2VFdaZEtuZFErY01Ic2RRNk14QksyUUZGZFdrZExEeW85?=
 =?utf-8?B?d1BRU3g5TUN0NXIrdEY1S2YxejBVWnNlM0xBQkxiTjAzMmx0N3RFclk5VXBU?=
 =?utf-8?B?bVBWODVQaHJMdGMyY3lzaTR3VUUzeXhhZDRMb0hvaGFMaHhPVUZQS0xnbFBt?=
 =?utf-8?B?V1YxVUNiQnNYOEExVi83N0wrRnJHZlJwQmhYM20vUExVdldBTE1OY3Bqd1Mw?=
 =?utf-8?B?bFo0Z3Z4Ni9xTHN0YkJEWXZvdEpkQTJMSW1oR2ZTQWx5bVN1Z1FKODhXZ2xs?=
 =?utf-8?B?a1N2NWh1aEppZnhlY0lVMURETndicE5JUFAzeW5weEFrZkZiWDR1aEZ2ZUww?=
 =?utf-8?B?U0drSE1XSC9xbjhDcXZHNUJFMW9KSHZFTVpYNE8yWUhIUDliMEhINXlqSmNO?=
 =?utf-8?B?ZjRrTWhGSTB1N0lpTVQxUnpteUhuWVcrUWJMT3g3bUtLN0JiZitYU0lhaFdQ?=
 =?utf-8?B?Z3d0RlAwVHhtdjhtKzZ5dnlqdmU3MThhNE1sTXZRK3pnTU9vVHNUNWVMejdN?=
 =?utf-8?B?R1BMSHRuUkExdFF3YkpFVURnbVp5MktxVElFWlJnSE1kZWUxUHJzZGpmZzQ3?=
 =?utf-8?B?VTYxRHdDV3ZpS1plK3ZYV0lQNjdZdERHc2RrRVRnOE81MDVNUm5ya0I3ME5N?=
 =?utf-8?B?MzZsVVZVWmhyWUZKVWIyTEdVL0tleVNjL0NlMGdLOXlKSU5uUzZVZHlxcEo0?=
 =?utf-8?B?YXhKdG1saTMzc04wNEZpSitORnFJaFZnV04xOTJaUElPTTQvaUNObThmZUF2?=
 =?utf-8?B?QTV5SnRIRHhqVTF6QU5NZGx0dUYzUTdpVkU4TVduV0dtMlU2RTM2L3d6RU5S?=
 =?utf-8?B?Tlh1VlUyMFNxWENWcU5ZQktZYTFuQTJoRnh6ZjRRQWgwakNBMFdNSzBJWjR5?=
 =?utf-8?B?b0dBd3c4a3MxZm5aS09CSUQyQmNuSFYyby9HRVpuVXBsb1Jtenc5S0o5aFNO?=
 =?utf-8?B?YysyUnJENXdHRTAxV0UzZjlrTFB5cHloV2JVZmVZUTJJS3dGY0YvUEFwKzFV?=
 =?utf-8?B?aHBHN3F5QUFiYzZNOTFHRmdRbUxnRUtYTEd0bThTYms3OE5ibmxnTW1rQ3Ft?=
 =?utf-8?B?bmxCMTlYTno5ci80ckRCNndyS2RLcVdnZkZ2L3F4TXJNdWZYdkVHMDNoelZh?=
 =?utf-8?B?M3R0eFhNR1FFVlhiSzVlelYwdmFaNXVndVFRWFFPTlFmT3AvcDB0M0I0UTY3?=
 =?utf-8?Q?KQTsdjos0Qe9hHcoI6I6HxUwJlovbCDw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGRiL0RFcjg2bDFva3ZoV2JOTlIyYVBNamE1UFY5MGpva0Zlb0duL0JiMkRu?=
 =?utf-8?B?WXhVb2JIQ0tZQ2Rmcm13blNnQkF6TXpEMHoxcm5oS1VNZDV2S1NxSnVvc0c1?=
 =?utf-8?B?WEFFWVJ0TSttaFpLaGk2ekg2bFh2WW5YemdOeEw2Wkc2cUkrSnd3TWZPTWxy?=
 =?utf-8?B?T2t4SEx2OFVyTDJXMFZNY0tCV245U1dZM2tsMGFzWk1LZ0pMNDAzT0IxT1R0?=
 =?utf-8?B?SWVyRWpGUHBZNXFaWGhjeTY2QWJLUzZONFVhbWVJejZkMm9qdWRnaDkyNnpv?=
 =?utf-8?B?S0g5Y3U0NGJTTUhsV29VLytHZS94SFl2aGN6dGVoVTVNTFg2YTJVQUw4bmlj?=
 =?utf-8?B?UFR5NXFWOThMTGZuSkZqaHRJVzhZanlVak1qZjl3K09JYkQzM0pkUDQ2ZmRS?=
 =?utf-8?B?M2VicmhRS1NNV2NZcVY4Zm1naXB3R3lLR0pjT294SXNlZk80cFd5R1I4VnlL?=
 =?utf-8?B?MlJ5TFpSdDY1V29NaFh4aklQSG9waW02cjZvRzd4N2tvMWpTb0ZuWHUzYkV3?=
 =?utf-8?B?bUJYZ1pBZjFWVXpGRlpPQnpmZGhvbFJteVdRMmphY3NvTXJVSi9qazNXblBP?=
 =?utf-8?B?SkF5clhIbUhVbzNOTElaMCt2bFVYUVZleWQ3d1h2ZFJ5OFNsREg3MnFnTlhn?=
 =?utf-8?B?YVNKcU50RjJLZC96cldTVk5EOTZIblVLNmEyc3lCV2V0WTRmbGQ0WmFwMDVo?=
 =?utf-8?B?ZUF0YU9zOFpsUDVCY0NHZFFVL2Jzb0gycmFwbzlkVUNycGhqTUdMdXhKVHZR?=
 =?utf-8?B?MXJjdU4xbG10NUFmUGd0NFNyQUdtOGR0U2lKNFEyWWlrS1gxREhRNVM2WXFp?=
 =?utf-8?B?a2QwYjZJQU5DcmhyaS9WNDhZaklBUktQdmxuM2FtT3NsVGtpMjlzMlZlcFZO?=
 =?utf-8?B?UWtIcTdhbWJEa0RhZHR0VDduRlN2TnUwdFRIaE15NElMYXRURGxOU1pIYzFv?=
 =?utf-8?B?cm5vRk1RaGFBcVJVSU1Vcm5YKzlIMHNHMmRWSFliMUJSM2w3RzRZcDN5d1Jv?=
 =?utf-8?B?Y2RZeDJxVHlkVlZQR2VGY1BLQjhLOWRlTEpjUkJVY0lVdUR3RTF2VUpNejZE?=
 =?utf-8?B?MVhGTC96NFQyQW56OTdwYmFDRUM3dDBwZml2NGFEOFptN0RRbCtReFIreW0w?=
 =?utf-8?B?ZTVBelk5N0pHdXVCUFJZbGVZd21lbTJHMVRMTElhS1pBTHp6VjRiS1gxdnpy?=
 =?utf-8?B?Wk9wY2tDdVlTMklBbjdqM0tZVW9pNE53YVM3ZXRnNEhhbzRVWHpoUHlvY1pP?=
 =?utf-8?B?VlhHcjNFZmhMNHRQQlZXZkhpT095T3hJdXp2Y0RvYTE2bGw0YTZDNmk3TUky?=
 =?utf-8?B?TkZueU1HSzNZWGcvSHVJRnlMTXFhdTkzR1RkaWtFSnZLSjVVSEVQSko1Ym5i?=
 =?utf-8?B?VkN0Q3ZxUlNpSGRIK3NRd0lMTmRzYUJuN1BvT2ZaS3NzWFh5TWxqOHBIVDJF?=
 =?utf-8?B?eCtIR2ZHQlJ0QTJNNzV1WXNnQVdMMUFmTC9rQ2hvTy93OFVJNk1UZ3JLL2E1?=
 =?utf-8?B?RUR0ZjFhWklYMHhCS1RpWlM5ZFdLSWtNWkVub2gxRmx3dzBPN05QSUg2RW1a?=
 =?utf-8?B?NWJIS1Q2N2FXbC9MRExoSUVQMU9aSFZMVEk2eHpLNFFxWGZmL0JNNEJiMGd2?=
 =?utf-8?B?N1I2WlI4bVRyWjB0RlhmVlNJUXVGMnBaNlpKYnNPdW56TTVZTFlsTktuYzVu?=
 =?utf-8?B?SWlWc3Y1Z3dNUjllNk1FM3FYU24rSDVJaHJrdVBxK1dobnZiamQyYWtIbFRV?=
 =?utf-8?B?emNBbXh5MUFjRjBxZEpzaTY2cU9PdTkyVHJBQU5YMm5RL002aXg0cXBLQ3lh?=
 =?utf-8?B?cWt0Q0sxdk9qTlRIN21NMzc3VURkVmp5bDNWOStiOG1ZWFp4dW8rL1pxRkRy?=
 =?utf-8?B?YzFBTVlyVEpGcm1iTkdzYjRGM2dZd2pkZk1TajJJcm90T1RmQkFJdCthUjNr?=
 =?utf-8?B?U3puRVlJR3ZHdkhqK1d5UmdKZW53c1BJU1JaaGsyME42RGo5L0J0SEQzeXVz?=
 =?utf-8?B?YUlzb09LM291ZmZZRkkydmVKMGxaN2pPYXp3WTFPbURBNEVnUWZwK1g4a21C?=
 =?utf-8?B?eFIvZDlqZTEyUUlsYTZod21tTnB5dTdzWWNsamRUWkJqazZnS2lBVTBUUy95?=
 =?utf-8?Q?EbuY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae14c93e-4aa7-4e52-ce10-08de275fd88e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:36:14.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3WcR4+l9Lu6H0op5OhfLQg02Ao8zIS7jSx7Of3+Rf0hGPnES6HgSQMp3yxa0a6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715

On 18/11/2025 19:13, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 11:38:04 +0200 Gal Pressman wrote:
>>> Could you try to detect that do and dump replies are identical 
>>> and combine them? They are the same more often than not so 
>>> I think it'd be nice to avoid printing the same info twice.  
>>
>> We need to take care of both cases where the whole operation is
>> identical (e.g., ethtool debug-get), and cases where only the replies
>> are identical (e.g., netdev dev-get). This kind of complicates the code.
> 
> I was thinking just the reply. This is mostly for GET type operations.
> Request doesn't exist for DUMP, but for DO it carries ID.

Some dumps have requests, like ethtool's debug-get or strset-get.
I have a patch that detects identical replies, but it's quite ugly TBH.
I'd prefer to keep the code as is, but up to you.

