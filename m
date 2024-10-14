Return-Path: <bpf+bounces-41847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D6E99C566
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307251F23A26
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C715ADB4;
	Mon, 14 Oct 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObxrDokC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9F159596;
	Mon, 14 Oct 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897365; cv=fail; b=g1VNUpOp6x1b9AjQnPHe1SoIlZuYjXVBGDbPvqJvbNbthJQYhaF7omPoqaIXyguEpXOGTy7UBpul2LO/qik6P+tlvsvgeDPA4hXI/+NKUXQlyRsIsLgJOx3M3Kv2VqaPK8ztPj9LUeJtB1A37+VabViPbSS+DFR9How2DXWqA18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897365; c=relaxed/simple;
	bh=IXFIx1FdUihXNiMMwaWPIW2a5SIY2MvRykJ2FIhMd9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HgvbIrV2J8fBFpjr9llye03ar/SvbkOJboyEva6RTBjGOLznPtOHvo6fDW9yMHpANk5u9aUX6C0h66THNCpe4zYcP7gxNB2NyCHSpQi+8/6Y/rpRPJrci/dl6yo64hR/qEzu0mg1VPfsPFlcqSPfEhMgj4rXTUD3Ys6pPtNxU5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObxrDokC; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2Dfuptzodqo88rDZjGf+fE6HuDysE+f24HV2rDhuC3QBXwbIe8ZFlf2uEDGSdHHowGdpYLige7c5RMNoyG8t21JG9i/+aCOA3SfCGsvvBWPezFx/T90N25FVyYyLs08QIOph3PlTn+il3A0gsktwgXW5v7j/WcCMUxNbhKjCqxujoBJfK6iViPunkUU3VwExYBDlOV27mMYzIQG/0lHsD5b7WFDfX9OYPXF0VEfdQhyp94IeDTPElzpzxazxbwcwsTJivJEmkYPmVbo5QputVHb60sn1c3lNUNh3PJLWjWxNBBacOLbBHGMZnvJuJIZdUC+Rvynnim2quJTQ9efCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK+/VrzYvUlL1TU6sGo1YPifwvsFurasveaC67AtSWo=;
 b=MNOJk+Tc0/bxNv58v+zpvcHXwkfPRadaMdVAqH4JO+woXzfsAYAyX7nOUrB6bg7cN1AtZPhd1UxxGYgQvBAN8zuy52qU8OnOmJg0BfaNDSyTWNzP4YOGLifytcIOLF2WrThT78RCcrJP/PSXGg5F3bBu8XNh8GdFACb5a13egbv7OD6B64lgrk2npXxYPBX4YuxC7Pu1l9c7TXdkS7uxxsOHSINUaohB5PtMQ0tD8BRu3Hk8EexGI8ihFSumEskHtv5TSEnlOID+fP/EZK8idXiKrAKqQG+2HxrnL4fHzz9hBY9H+5htYgjZV8QaOmIE3CF12fJxsIj/i5lPOPW/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK+/VrzYvUlL1TU6sGo1YPifwvsFurasveaC67AtSWo=;
 b=ObxrDokCI8Q+WK0j8UYClc/xzB+g6GPEOOS7iatXQiDdJ1sBauiu4fr0JqcqcI/pAjcncUZkdDfRjNfmjXXZ3eGXpz8BkV+6w/yz0yQ3b1Ik4uEM6agYtBxU/pHU0w50BUUQUHS9C6wMk7wsPGmQNdImKu533EUbTsONvphMHs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.25; Mon, 14 Oct 2024 09:15:59 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:15:59 +0000
Message-ID: <d0ec401f-f857-4fbb-89f3-f2d13eb34b5d@amd.com>
Date: Mon, 14 Oct 2024 14:45:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 05/12] srcu: Standardize srcu_data pointers to "sdp"
 and similar
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-5-paulmck@kernel.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-5-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B6.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::13) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: c5df93ec-e3df-426a-0165-08dcec30d13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdlZnYwakd5T2pLbmxwUzc5NGxjOVlNSElweHdZek1pRCtqb3gydk9GbWlh?=
 =?utf-8?B?OEZsSmJQK3ZORDBuNUJLL0YyTndPT1BKM3R1VlhUWjdFSGdGTDd1NHg4Vno0?=
 =?utf-8?B?bXdsNXo0aEZMZnRFaUNYeURqdkpZL0VqdHoxVjhHTElFN0lzd1lOcmdrR2dP?=
 =?utf-8?B?VEpmMGNMS3pnNndtQ2dQU2szLzNtdndTR3JrRTRNWVp2TzdSalV0QXdBUUJ5?=
 =?utf-8?B?MkRTc2RMcEVlU3l3VFZoZzJxUUpLQllhTEVUN3ZzSjlVZ0hqVi9ra0FsaGh5?=
 =?utf-8?B?NWNYYlYwc1Y5N2g0bXRJc3VLaDQ2TGUreXlEUkRpWklHUWJtMUtZUHFXcFVv?=
 =?utf-8?B?Mk00OTViVGlXTkp6bmpSNmF6Q21HVVdBSi9KWXV5S0xWRlhla3M2RXM3T3VR?=
 =?utf-8?B?K2R6bW9TVmVWRE9iU0JQNVdBN25YV2pLMUNrTHZONDQwU3VNKzVrV2p1MWJ1?=
 =?utf-8?B?VDJPaUpablNnNWoxbXNLNi9EcjN5cTJpeHZnRXZxSjBSU3dxZlcxTThGTytX?=
 =?utf-8?B?T3U5S1UwOGQreEEvNXJiZVp2emIxOXVMdmJ5ZVl1cDNYd2t0Vm55MG1GTkxI?=
 =?utf-8?B?TjVxWk5zNk9CanFqTTZmSjFkNmVVcWZUaEVNOHpvblRMcnRMZW05RnRQbzNv?=
 =?utf-8?B?c1pFNWpvNjYzT1BuNmsxbHFOb0NYZU1IUmpqMjBmZEkyMmhFLzVMZWh6NEdl?=
 =?utf-8?B?MHRCd0tsdFBVb0RaWTAyc2JsV2p0a1lJd3d5WjEzUXBScmFRS082b1dEQUZL?=
 =?utf-8?B?YmllaGNKYUcwcVFxcVFYUGFvblZ0cDZzZFZGc0FWSzI5QmxMeEQ5L2VZSnI4?=
 =?utf-8?B?M3JGc1JjdmY5ejVjeXRpUlJrTUlsMFZSOG1IK3pxV3dWQXRTajNSSE5NOUJL?=
 =?utf-8?B?czhlbC96VG5zODFoR0xKR1ZwL2FmbWg1aVlaa1B3V0hraTBndnRQL1FlZTVB?=
 =?utf-8?B?dC9sVnllYUdJaFMyOEtwMitMYnIrbkcycGtmNEpVc3pZNisvbnlicTk4UGhw?=
 =?utf-8?B?OFhSbE4xOWlwOC9SN1RGaEVrRzJKVEtuRmRPVXdBRkhxbkZHMXJsWkZqVWxr?=
 =?utf-8?B?NHkzOU01QVczL0wrWkJYNU5yazlrWnRZZzRCMkYvZS9JYU1WbWUzSkcrWlBC?=
 =?utf-8?B?R0JleU5IYXM4U1ZGdmRPM0JEVjU5WVFHenByRlRWNDFXQUNUZk1Rc21qbU1W?=
 =?utf-8?B?WnhZMXJQVUtiZk1jeDRXbEp5MVh3RS9kYytXZllXWXNxRjZsYlNzNlRwMytU?=
 =?utf-8?B?S0tpYStRd3E0YmZMNFp4Wk5kb3pkNjlYT3BpdGZDR3ZXTTZDb1VaZWRER0VT?=
 =?utf-8?B?MVdNOTh3bGZQTW5mTEwxL3hLVzl1OWNrbFM5YXBYUGFFUEFYVjFZR2ducWV1?=
 =?utf-8?B?U214dVZueFFQcVF3NEFWWnFlRzNrSHN5d0dtc2YwVUladDZGTWZzcUliOFVS?=
 =?utf-8?B?Y0xBa1B3WXdGbW8wUW9XRlNNVmE3Q1lUTVFpUWNzQ3ZRaVExYzN2YW5lenZT?=
 =?utf-8?B?V2pBMHhYanVFTHF6T0F3V0FEYlpGMzMzNzJzZEtQWW5qTWVCS3lYNEtJcTY0?=
 =?utf-8?B?VHBkdFMzcUdvUU50RjJ6dGRucWNZc3VNZ24rTUh3YmJERkdQNVdBazVLeGFH?=
 =?utf-8?B?WG54ZHZVY2JQUklhaXZhYVRxRG9tVU1kZmZBd2dSRVB1SkpPMk1HT25RZ2Ru?=
 =?utf-8?B?dC9ia1ZwVVhHWmdjZ2RYM0pJYTFxSTB4OGMyVC8rTHlGVzErQ1UwckR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNIZExic2JXYWxjdFdxcFRGakNQSlphNDZmVkhFdGlnbXlHbGxqUjZUb01G?=
 =?utf-8?B?bXpuMUdGc1llZXBEaVBpa1ljWUJNOGg4c2ROaitQQlc1U2tTeG5vU2JtOElx?=
 =?utf-8?B?RzQySGJLVkQ2SkZBTFpaeHg4clg1ekZ1bXdZL1dUNVhtUEYxcEdSY2tLSWwv?=
 =?utf-8?B?c0N1OTZRNThxYm5YVG9vVTJ5b2ZtN0lrbkhJbnNRWVBsenVtc3F5QXp2SFhi?=
 =?utf-8?B?Znp6ODF3QW12TDNPQ1ZtZWw5N1k4Tk03ZVN2QldSd01PczJIU1ZWRFdGZzBs?=
 =?utf-8?B?OVFWTkV0NFlKTUJuYVVIeFNkdUw0ZVZUMWFwOEpmVDlsWUZOdStkTGNsR0tJ?=
 =?utf-8?B?MlpuT0U0d2s0andoaHJqTS9zYWNqdDZZSUhkUkphVS9sSjZJbFgrWmhzcHI0?=
 =?utf-8?B?TDk5YkgwaWNXK1lPdWNaNU00WFluQXJIUlVWUEMzcGF5bFNwSXdPTHBLcVo1?=
 =?utf-8?B?OVRIb2V3RjJKS0NVdE5oZndqU2h0VXdVVGdjUTFDcXUrOU05ZDJ1eU82ZXQv?=
 =?utf-8?B?SkxrY29KV3ptMEprTWplRHlWZmdEa3RPTnV3SFdzd1lPZGZQZU1FeFgvWG94?=
 =?utf-8?B?Mkh0Mm52alRRQUh4OTlVc21YS1BKeU05SXB1MlErOFRRdEpDV2FuTkJjMzJi?=
 =?utf-8?B?SWNlVXZ1ZjBjZzRkZTBBcTlDZnJQVVdNNFRtVTc4YkxXd05rRTZ6VFB6M1hp?=
 =?utf-8?B?SmozSHNISzF3SERab2xqZ2FrK1B1eW41OU1kUHVLYVBtOFpIY1lBbDlydFlY?=
 =?utf-8?B?UnlJUTNFREcrWExKbTdRckdmRE5mblpQc25LQncwS29rc1VsVnJySXJucGlO?=
 =?utf-8?B?MHNmMXh3ZEU1dll4eGFmcExOUnk3elJsTFZWY3hoWHBLYTd3UVVDNVpjM3R3?=
 =?utf-8?B?aWZSSTJHS3lzUFJpejlVRlo2bUY2UHVDbFNINTVTK3dINDZZYlJqbndnakV0?=
 =?utf-8?B?SVJ5bWx3RzZ2Smk1TUM5N2ZZUWVraDU2NTFCcHY3Y3hOOUFxdEFIUTlCMTVZ?=
 =?utf-8?B?clVSalZ3bXdhcmo3bnlXMC9yK0tEMTJBeDFRRzF6dy9PTlFJeTdhVURSTmVz?=
 =?utf-8?B?aDMzVGRMSGZhT3NtTklYMUxHdXVxZzZwZlBUcm94SG5DQkg3M05HdlRTZk9X?=
 =?utf-8?B?OU5hb3l2VUZoMDFjVitoZVlzRFFRRlU4SEZWeEp1VzAxTWJvdjF1ZlZlSWFs?=
 =?utf-8?B?aHJSdkV6U1czQnk5UHNaMC9na29xaGdLTFY2YVFwNzhKcnhUUlQvcklKZ2to?=
 =?utf-8?B?eko3U0dydDFZL1g0Zm1vQ1RlZC9ReUpKMTV2UDkyU3NYczZWU0Q1aW16THkr?=
 =?utf-8?B?dVJZTlczeGNNa1RaWXFMZVJNQ2Uyd1IzSWNJRWg2M0N5SFRqTWgyY2J1UCsw?=
 =?utf-8?B?eG1ESHJaZGIwVjFlZkRuR1hkeTB0dXJiNkhSWjM4b2dkMm9RYjNyNURyVi9l?=
 =?utf-8?B?QUxvdkNXcE5QZDliUG01dnk5RU1qWlB5WkJzcFZiaENYeWdjeXZDUG1ZTXFB?=
 =?utf-8?B?c3pjRnlrcWlYSHA5cFJHZlQxT0hNVldlVTVXRitJWDY0UFphYytQdTYzUXBC?=
 =?utf-8?B?dDZWdXpPKzFXRkFTQmxqWktCbXl1aFlKWFdiUDh0VmFQQkVxMFpjbXFvM25v?=
 =?utf-8?B?R1BoVUxpVzJ1SzZvb3ZlbUwyK25sR0FIVnhkeWhRZVRmNTBRdm9xTnZ2NEts?=
 =?utf-8?B?aG1zQk5YeTFaYkEyd2JVODNMeFlQTGFkUW55YVZGM1hKYWcrdkc0ajVwNFRD?=
 =?utf-8?B?TUE3NUxNQVRIa0NBNllqbzlhTWVsSDVpMUlhTGdXWnAxTG9lY3haR2M5aHB3?=
 =?utf-8?B?MjVhRlA0Vkd5Z0ZDWGZGam16NExqbVNuZFhoSkhnZFU5VzNiKzRYZmJaNHlT?=
 =?utf-8?B?aDYvaTV3OWhxUkc0TWtJNmpxYlZWVzYzZ2lWanY3Smw3RmNDTlBUYjdsNlJw?=
 =?utf-8?B?UWdFK2FSSlEzS1FoNEFock5wM3U1UEp4S0xiRGI2b3lkVWxFdjl6elhaZ2dL?=
 =?utf-8?B?Y0lDZjRsd1JpTmlnRFJKeVIrS0FzNXk5S2VSU2s2Umgxa0xyMWZGbENqY3l2?=
 =?utf-8?B?WjNjK2FYR1BHQm9yVHdRdHBZSU42UGFLVlVldWZ0SVN2ZzJ1cVFMVkMrRGgr?=
 =?utf-8?Q?0t5Opc/sxrtEvbR+100G07Dwd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5df93ec-e3df-426a-0165-08dcec30d13b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:15:59.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JPxbsJixvr4XxfhzAyCRyH25ugReaOXPB9xNBl/LOclIQEj6wQDzzye7XaGaYdoEtQ7W1DXcRJbOW0L626Pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> This commit changes a few "cpuc" variables to "sdp" to align wiht usage
> elsewhere.
> 

s/wiht/with/

This commit is doing a lot more than renaming "cpuc".



- Neeraj

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcu.h     | 35 ++++++++++++++++++----------------
>  include/linux/srcutree.h |  4 ++++
>  kernel/rcu/srcutree.c    | 41 ++++++++++++++++++++--------------------
>  3 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 06728ef6f32a4..84daaa33ea0ab 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>  
>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> -#define SRCU_NMI_UNKNOWN	0x0
> -#define SRCU_NMI_UNSAFE		0x1
> -#define SRCU_NMI_SAFE		0x2
> -
>  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
>  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>  #else
> @@ -235,16 +231,19 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
>   * a mutex that is held elsewhere while calling synchronize_srcu() or
>   * synchronize_srcu_expedited().
>   *
> - * Note that srcu_read_lock() and the matching srcu_read_unlock() must
> - * occur in the same context, for example, it is illegal to invoke
> - * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
> - * was invoked in process context.
> + * The return value from srcu_read_lock() must be passed unaltered
> + * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> + * the matching srcu_read_unlock() must occur in the same context, for
> + * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> + * if the matching srcu_read_lock() was invoked in process context.  Or,
> + * for that matter to invoke srcu_read_unlock() from one task and the
> + * matching srcu_read_lock() from another.
>   */
>  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int retval;
>  
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	retval = __srcu_read_lock(ssp);
>  	srcu_lock_acquire(&ssp->dep_map);
>  	return retval;
> @@ -256,12 +255,16 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>   *
>   * Enter an SRCU read-side critical section, but in an NMI-safe manner.
>   * See srcu_read_lock() for more information.
> + *
> + * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
> + * then none of the other flavors may be used, whether before, during,
> + * or after.
>   */
>  static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int retval;
>  
> -	srcu_check_read_flavor(ssp, true);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>  	retval = __srcu_read_lock_nmisafe(ssp);
>  	rcu_try_lock_acquire(&ssp->dep_map);
>  	return retval;
> @@ -273,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int retval;
>  
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	retval = __srcu_read_lock(ssp);
>  	return retval;
>  }
> @@ -302,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>  static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	WARN_ON_ONCE(in_nmi());
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	return __srcu_read_lock(ssp);
>  }
>  
> @@ -317,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  	__releases(ssp)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	srcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock(ssp, idx);
>  }
> @@ -333,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>  	__releases(ssp)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
> -	srcu_check_read_flavor(ssp, true);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>  	rcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock_nmisafe(ssp, idx);
>  }
> @@ -342,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>  static inline notrace void
>  srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
>  {
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	__srcu_read_unlock(ssp, idx);
>  }
>  
> @@ -359,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
>  	WARN_ON_ONCE(in_nmi());
> -	srcu_check_read_flavor(ssp, false);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>  	__srcu_read_unlock(ssp, idx);
>  }
>  
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index ab7d8d215b84b..79ad809c7f035 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -43,6 +43,10 @@ struct srcu_data {
>  	struct srcu_struct *ssp;
>  };
>  
> +/* Values for ->srcu_reader_flavor. */
> +#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
> +#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
> +
>  /*
>   * Node in SRCU combining tree, similar in function to rcu_data.
>   */
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index abe55777c4335..4c51be484b48a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
>  	unsigned long sum = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
> +		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
>  	}
>  	return sum;
>  }
> @@ -456,14 +456,14 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>  	unsigned long sum = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
> +		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
>  		if (IS_ENABLED(CONFIG_PROVE_RCU))
> -			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
> +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
>  	}
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> -		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
> +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
>  	return sum;
>  }
>  
> @@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>  	unsigned long sum = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
> -		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
> -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
> -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
> +		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
> +		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
> +		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
> +		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
>  	}
>  	return sum;
>  }
> @@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>   */
>  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  {
> -	int reader_flavor_mask = 1 << read_flavor;
> -	int old_reader_flavor_mask;
> +	int old_read_flavor;
>  	struct srcu_data *sdp;
>  
> -	/* NMI-unsafe use in NMI is a bad sign */
> -	WARN_ON_ONCE(!read_flavor && in_nmi());
> +	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
> +	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> +	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
> +
>  	sdp = raw_cpu_ptr(ssp->sda);
> -	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
> -	if (!old_reader_flavor_mask) {
> -		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
> -		if (!old_reader_flavor_mask)
> +	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
> +	if (!old_read_flavor) {
> +		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
> +		if (!old_read_flavor)
>  			return;
>  	}
> -	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
> +	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
>  }
>  EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>  #endif /* CONFIG_PROVE_RCU */


