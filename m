Return-Path: <bpf+bounces-44717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC19C67CC
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717C2B291F8
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B02165EE8;
	Wed, 13 Nov 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3zNHoZxp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C0165EE3;
	Wed, 13 Nov 2024 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468043; cv=fail; b=GoeqMC2rCScSPtrVsdhaXW5wromuoMGjGH86NER1iD233rNYd7RAbHLdj2T9hNK7aj1Jn3oPc1POZWTnmW4rEaq9KtM99Jl4P2Db+csH76NZ02msTYmPPKOpBEnmUshNd9K95tWRKof/2KRP/FY+YiWC2PzZtR5ZzxIvvPLviAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468043; c=relaxed/simple;
	bh=6FtHLwhLGpOPDxLxIGd8uEMLEReD4IyWf538lX2H3y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aM8PgT1OqFP98v5DWqqql1QeXDKWN4iEvWUu1Br4EHhqHWYFdZG5DTYvNhRGr5ZcgiAPrcVsC/NnpX2Tj8rTq9Qi/DFAvO3KETqmjUZIp2DKINIIsBcv7DLkx1z6alfYBJMZe+XcRMQNMfXXChysUtFETowsY4WkTizFtt2TQ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3zNHoZxp; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX81T3/fwozHBNXOcWZ6vBHD5W7koW1MguUcPEDncB/rU/lOMPLQhXYFemRPUMpubiE3NmA9zsvlVMoxbBUjVbCAQWKYPJfHGhbiL3ZtLkVIMmEkCN/p4akpvZqrhK9RnmaLk72RP9SkCVfg7xcyySAKBQKd7asKKsUmNAt4wwUUia+Brzlevv79a9lUdfN9G4y50w6/f1w7SzW8SoqpIRGh9ZzpRSIwONqbYAnrHozN5aFfPokWG7l42aCz8z/xjW91p1kBXatdb3+HOhe7R1M80DpgnHYGbKbchcMAXa8BAq4wZaOoFkp+NoLMqtsBNCqlfYxOuE3wJs2QiPTrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKdEq418IxGb7KLbGMbHfwM9KY92cdW1u/NW0CFiydY=;
 b=PT0Xhv/ZTzT1rKNFP/J8BOp9K6+67EHei4T5g7r8deDgtxXNXaU8jCIn7+0vD/6voXmKn29SZkX7tusDWI9ZZ6AB3n8eE+C9yNf4prUgC1FPGjXSl7PlXatSgcAK/Rue5MVtnsAwsPidN33+b/RvL+g8rAMvFWyRspxOAu5eM9m0fIyAi5y4mRMQiPqAw737IDBt/2DVwjmcgmWb5KdnLD7tagsifqFsY+U2py7CUvCJaQPiE/fRN1ckijA8pa1D7L1VDtiEBwavLCPp0eyoI/ih9LETYV/DrsYrOZC6QT3MvUBT1V1ikEArc56ZA57647QWcO4gSWILGj96spz0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKdEq418IxGb7KLbGMbHfwM9KY92cdW1u/NW0CFiydY=;
 b=3zNHoZxplD1g+fLbqJ7frO+P07UHib7aO56lo5M1YkvhiaIUY5oSX/ng1nB73KCQBaT9cB2egoTOb9HsIKiHhlEDmsRLEyPOwhJKv6KtWnixt5Bli8A6r9r89wQRe6pRPnHRhhJ4N4WcPGdF7YM0jxtKicLnhQmMN0BE19mqQa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 03:20:38 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 03:20:38 +0000
Message-ID: <e6492627-7ef8-416b-af74-b7026de93b43@amd.com>
Date: Wed, 13 Nov 2024 08:50:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 11/15] rcutorture: Add reader_flavor parameter for
 SRCU readers
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-11-paulmck@kernel.org>
 <c48c9dca-fe07-4833-acaa-28c827e5a79e@amd.com>
 <d27da29c-7499-4f08-b582-a2bbb9b3c1c7@paulmck-laptop>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <d27da29c-7499-4f08-b582-a2bbb9b3c1c7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2079d458-10bb-4a5a-eb33-08dd0392257a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNmelhNZU9SbmpNVFlUWStEbnZ1eDEvc0VCVEkzemFXeDBsTnBNbGV4NTNm?=
 =?utf-8?B?SFpMcEUxWnJndEtKelAvaGlXRCs4K2x2dkpOMXdJUWxIcmJsR056VzJsL2JG?=
 =?utf-8?B?TUE3NUZEM3dVS2IxMFI5S0c2UjF5SGNnak9yNUI5ejJEOGxLT2ZGclJlQkF3?=
 =?utf-8?B?VlNhc05iRmtQcDF2b1Vsbkp2Rm8wUGlYU1Q5NHpQZWkvQlUyVlVKTDJTeS94?=
 =?utf-8?B?enJPdmVJV0xFVWJxdzVQSmhFblBBb1BZRlBBeUNYc0pPYnFZVFpVM1pQU25i?=
 =?utf-8?B?bzB5ZnJ3MmF5dFYzWWVZZFJ4YjVoKzdnMzJPV0JnSWFCRUZUTFVhQWE2a2l3?=
 =?utf-8?B?bWszTWJHQ1d6TVRNdm42WjloZTZnd2djbkpnaUNCUHhWSzhWL1BSdXZ3cmNt?=
 =?utf-8?B?NDdhM0FremZTN2xvN3lybXFQczlVc2Y2ajJwd1Vub2ptOGNGRit6Z1NDdGZh?=
 =?utf-8?B?QzFrQmNqYXdkRWxNeTJlL2lYWHJBQk5oNnpPaHRndEkvaTZIM1J6K29jeFBQ?=
 =?utf-8?B?ZEZpT0o4V3ZqaEdQNzZHWmtXSTFDejBoY3Z3bTk0NnVvQmFNV0t0SmZSakU2?=
 =?utf-8?B?MC83VXJPeUZVaGlnTVMxUmF2am1OTXlyUkV0Q21iRjFNS3BWR0JrcDh6Q2FB?=
 =?utf-8?B?SW10Z1kxS0loYWpud3owaER3UnpVUDYrVUNpQytxTTAvZ1MwMmV6M0NsQThr?=
 =?utf-8?B?RGxBbndaRXd6S0hRMTdZWC9wWVZxRHdGWHZZYldkMnBpSWFWSXZMTVhBZkU5?=
 =?utf-8?B?WlFNQ1dpT1ozVXZBYTFzVCtLdkRteVhQZlNMenZwSzNmK21OaDFzNjJweGVG?=
 =?utf-8?B?MkQzREU0VDBtY1NVeTEzNlI0cFlIQVIxZWgrY0xmL3VqTzhqWm9XMFo1Rmkr?=
 =?utf-8?B?M3JETHRCSUVWWC9oc0V1c2pHZ3Azbk15aDNFcWRhVlhUNmhXQnE2MkpKNy9L?=
 =?utf-8?B?d1JQb21tMTlGY2l6SEt3cTA5RDlOTGQvUHpNYTFlZTd2b3ZsNkx1ZGxnZVdS?=
 =?utf-8?B?N0MyRmwzRmh4bmJ6QWRZZXR4MkVldG5DZUU0RjArUGI2MEN3QzNSc1hacWZC?=
 =?utf-8?B?Y1lxOEhLY0NWREU4VjluZGxQdkFQQlpKZjBLSTZIQ1hyby8ydEFmMGZWaHZq?=
 =?utf-8?B?TnNDQjJidE1MMDVDQnY2N0paVFRSY0Evclp4MkV2d2xXeHJjL3J2UEgreWxn?=
 =?utf-8?B?VXdQRFN1YkdqS0tEY3VvT0NzVnFqczYxVGs3Vlcxc1lGSldSK290SVVDK1NQ?=
 =?utf-8?B?ZWcyeUszRnhRVERxSjJ5TjVwcUcwd0lNM2dMdURIcmJ3Nlc5OU5nOWFpajF3?=
 =?utf-8?B?SDRPWVZ4RFFsZEJiTUFXM3N3enJsN1NZRU5aUm1LRnloZU1RaStVVmUrekdi?=
 =?utf-8?B?cnF0MVFRQ3dYRG9JRGNTeUFha3FHa1BtZDBXbldzbEFTV3VkRDdtK0NWNUNL?=
 =?utf-8?B?ZGdUbVVlTXJDdzF3U09pM3JSb1ZoQ0RiZ01LVmVUNXJnM3V1NFYybjV3NHZl?=
 =?utf-8?B?T2xBdFdBREQ1enRJQXFTdkhlbkpRUjBUN2FtOEN2TFpkVjFvY3Z4YTBXbGhH?=
 =?utf-8?B?VWUzb3ZwSkZBdExmUTNFdjNBT3BXdlFUeEFLV1FBM1czVGc2U2cva2gyUDg5?=
 =?utf-8?B?bjhwTlFzcXR1ZzZrYnJ5Qmp1VC8rUmJCUmltc3JHUFdCRzJZYURtbEUxWXQ1?=
 =?utf-8?B?YUJ5dnJVT2lRWHIwY1RRSnlkS1pBSk0zRDU2ZXUxcUF6bkkxVFdLTXEwczBj?=
 =?utf-8?Q?vevwykyokakGZkh9s76Iiw8+VW4/eaEN6GX6MTM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2w0S2hndzZiY3d4ZVhJRGxJb3F4cXhEQUN6am1xQXBZWkJGWnp4elpsanM1?=
 =?utf-8?B?Ukk5RXIzNWVVTm5CcHBOc0p5WXo1WmhudVdTUFZUWlY5ejNYbFJYNTV3aGpu?=
 =?utf-8?B?TUY1QnBPQ3BwSTNkVzBha3VBa3hnQjJ5YjVidnhWb21ERVBEeHp3R3Y0SGhG?=
 =?utf-8?B?ZmV2RmViY2FyWm9CRDU2YnpnU1hZYTFRRlVLWFlUVDVkb0FDd3kwTkhEejlj?=
 =?utf-8?B?SWN3dXF1bmV3YWM3NFZCZ3d5NXlvR0dPTFgwb0pUczVMb3MzdjJMekRzZTFN?=
 =?utf-8?B?QTZYQytsRHFwWW9uQnZSTEhlRk9ML3pQMjRvaEk4dFdDUkpiWnoxRmM0RjM4?=
 =?utf-8?B?ZUFtTEtkbEVFVVFtYnZzR2xMcXdsdDhGNi93MmhRV1lzdEphTHpYcHg5djl1?=
 =?utf-8?B?QldVaGJTOHovcFdRYkM4alJXalBDZXpTUnB1U2lsUXl1M0VsdFZIdWJKS2Y1?=
 =?utf-8?B?KzBXTENzSnpjdWV2bkNZVVd6dk9EVkltQzJnbFZLUzJlWjlhSkIveFBMRlFn?=
 =?utf-8?B?V1Z3ajR1N2JlSXYrdGQ3Tlk5V0JDS1RXVHhDemRHc0NHRmoxUXlsRzh1VnlP?=
 =?utf-8?B?eUtDQURYUStNa1JmSjYxZC9kV2NzLzMxRmRPYkdBZFVvTUw2Wnk3QmlITkpC?=
 =?utf-8?B?T05UOWdKSXdnVS8xZENuWmNPYjJ0Z29HSjJYMi9OQXNVNzNDUk45QUV1UzNv?=
 =?utf-8?B?U2pkYmw1ZXBUVTVOVlRyY1ViUXgvVEpmaDF0dW54c05GcFp2V1hseDJlNzNO?=
 =?utf-8?B?ajY4dlNta2RGYy9PblZlWE91OHRqMFhqN1p0bEtMQUNURURXdnVCMXZIcndC?=
 =?utf-8?B?OUs1Y1hzUkFvMHNQS0hUNUdYMk5vOVZ6aDlZUGpWdGVYOC9sT1ZTNzFMMnJK?=
 =?utf-8?B?Zm5BN1FoZDJrUFlmTmZmS0UvbjFUd0lLcHEzbC81K0lJM0c1aWNNcW1nZHVj?=
 =?utf-8?B?MHROa0hwbFFKN0F4MzV3T0RZK1V2UTJKaE1NcWZmQzg0TVlDMzVjeXFiVkRJ?=
 =?utf-8?B?RXZBZzlxMzkwWld0TWRiMWdubzZNVjlPZ1dpdnpWSGppdkUzUzM0ZGhrWnUy?=
 =?utf-8?B?TzVZR3ZmUTJhN21Gc01GM3h3bEg3MitaeGgzSnN4QmJTemQwUkVSMngyVURa?=
 =?utf-8?B?YXVpbEt5V29JS25hMEMzN1Bqa0hYR3ppWVg3VmloUVJESFVmTHRaUElpaGFG?=
 =?utf-8?B?RWRYcmd3WFRySjJyRVlScmFNeTVWVHlWQ0dKTGQyRFNzODU2QlhCeVIxR0Ex?=
 =?utf-8?B?bmh0M3JCbXk0S1ViYXRnZWx4NlRveG8yR2tkZXBEYkZYeWlxK1lWcXcrRHBU?=
 =?utf-8?B?NFdnSGs3STl4UWZtcFBQSkpxTlBCbkdtTXlGZVNEYnBuUzl1VU1Jdm5Gb3pN?=
 =?utf-8?B?blRyRTdFNG9IV2dNNC8vMmtIY3EvenJKYjZNWkgwa2gzSitDQ0NIbmFBZ3ZW?=
 =?utf-8?B?ZW1wUFFBQkNoQ1Q5dGdTeTNDNjlTRTI4V3NVN09JWUZuRmtWelZlVmY0WSt3?=
 =?utf-8?B?d1QzQ1djK2g4QnBHWjhmQVNjK3N5TXBsWHVoZVA2L0NOQTgweDAxc1o2T3hj?=
 =?utf-8?B?Q3FWalpYY2xXa3dkUUVuZ3JJcElTMFQ2cVZRdzdtaHJuUVR3ZFNiMzNkaXVu?=
 =?utf-8?B?SDFNMGs3SVc1MHd0WXFIU0xyVFRTRU9FcXF5L0ZEK0JPUTFLM0lYN3dRc1dx?=
 =?utf-8?B?KzRuS0F0TnNZMUMyWWdrOHljS1pDaHIzSVBqWVgyZ2pMZzRxQ3Q4eDVGVVdZ?=
 =?utf-8?B?ZTNOWWN0ckZSamxadld2eVZxOFFCWDVEck1yQmM1Ris0QVk4WDN3VmZJZ3ZK?=
 =?utf-8?B?WFdrSjUvM2dQUEJySHlGMU50aDczNkF2Z1ptNHdKU3BtdllFNTdhbGVBdktl?=
 =?utf-8?B?dU5rcTcwMWhzcWd0RDFUQW9OajUvRG55a1QrU3hOQ2daVHJZSjF3V2ozdDlU?=
 =?utf-8?B?TTJLR3duSzJ3dGRsZWoyeWNhWWQyVnBPZmdYeUs5Y1doL1Ezc3NYWTEyRE52?=
 =?utf-8?B?S2RXcGZKcm1tR0FuTS84WlZkZk9NVVp3RGgwQmhYV2ZGMkg5STRUTW5yS2Z0?=
 =?utf-8?B?Rm44Rms2TTlPd3lHVXFEWVMzeDM0VXJBN2Z2bWlxbVF3cGlyZmNIL0xUTUEr?=
 =?utf-8?Q?c1octD2SR+rIcmyXY11Lxux8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2079d458-10bb-4a5a-eb33-08dd0392257a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:20:38.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEfzqQyiKFagQU00kL0005W1t4dcR8AXd847wgwuMwjBJn93T/gHRpS4QCyDxtXHDuM02viNcMEQA+vFRHUueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907


>>>  
>>>  static int srcu_torture_read_lock(void)
>>>  {
>>> -	if (cur_ops == &srcud_ops)
>>> -		return srcu_read_lock_nmisafe(srcu_ctlp);
>>> -	else
>>> -		return srcu_read_lock(srcu_ctlp);
>>> +	int idx;
>>> +	int ret = 0;
>>> +
>>> +	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7)) {
>>
>> Minor: Maybe use macros in place of 0x1, 0x2, 0x7 as a cleanup later.
> 
> Hmmm...
> 
> I could move SRCU_READ_FLAVOR_* to include/linux/srcu.h and make
> rcutorture use those.  Plus have a combined mask for the instances of 0x7.
> 
> Or is there a better way?
> 

Yes, I was thinking the same. This looks good.


- Neeraj

