Return-Path: <bpf+bounces-68737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A8B832E9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2C4A76ED
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3952DECBD;
	Thu, 18 Sep 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqjmJ1b5"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE52DCF61;
	Thu, 18 Sep 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177846; cv=fail; b=Y7yyLaUNAnenVrFDGUIQ+/LTvc73S7uaQwbLvda5fsZAvGCEV58hi3OyuC/ZcyNUikdGO7SHBS+ufPpfMxqmB51l77f9VVZGb1nd788i55XOFC5m69H+VejG5TWua5rkYLwNch8J+E6lajS4521yGfQ00zty08OuRhsWqwhcEDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177846; c=relaxed/simple;
	bh=qwTulzGnmxRgmTUyOPV0JyR5UaWkxKH62v8RomN+qlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6XHtVGjB8sUQdRefENEBG2RYbzeFAoErc6ZgOUZqeO4V/PA3Alov9Btag/jIm+YBh4/91uhocXY5p9aHmebb2BofNYVK46jYefH3gJf0r8RLQT1FWuHuhG/a2ouZSrppp3Yu41XaOmvbkEucrDZU+X3YpZZIjgBhRDlCmhmNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqjmJ1b5; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd4JKRmJluE1hfPnByJf1/ztPDrTVjOn1tPRoBPBb8u/OXYgzgaGDtWCSgq52Lt/kvxTL2Kq+oQit9OI+sZcntBGgL8iL22BxwKUa3B0Qqx7IdsPVKBoJutj5ILKFNdv79vRRqOPhW8Dlxjf52QjPrFA6JhRGG+khSNNcnzwwL7khnVO/j7wXtgJ2MIHJlinW/zs71PH7+nDVk9QV6QdepakJ7jLs8R8h8ZzsCg5+5zEvO8lIB+EcaosgS25a47/muOUFIs/6BzOYG/fWievm0hWONZRdkWLUd8VfyHWIZte4vUHlFJP4hvouUXGy8w7rnz3n9rN8Vr3yhCVISqZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdwcCYE42LKKfQ+mwGA31NX9FgSo7gDv+dbVL0IVmxw=;
 b=KQmy/JWoRbB8C298RJZDfBNJo6BZ5NjZ8WyuU8R7Yut3eDWgVzEm+5eHKYS2/fa28IM7Sq4bO8Y2aZ9EuHx/hzqXcOkkaxsLLEjSWUApjv2CTJ7Dq4Q2e5pijMhuSz4rImKZ816FEf77HMnij2gpqJdqIWoXpJwsEj1LMhlJpUWo7XOL8qzc1r6MFkpzinfmzP5MwGtaGLxbGw0bSHCRXqjvM6Lhx4AKOCwcN1/FbjzINtEtZQqb5f4lZ6bitAq137LpimPNtcsfZgbrlU2L0zw5r7mp0vIpyubV4v7VRBnnrsePWqXUvQAHu/BwtKJaNOB8wbXeu6jbN6iGnvEznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdwcCYE42LKKfQ+mwGA31NX9FgSo7gDv+dbVL0IVmxw=;
 b=HqjmJ1b54PzTjTjjkkyxuL0qRxGy2jovQhCq6PDFOwY9rUjBoCgUCeLyUfIwipnyXZTvgPUahRxHj9b7dpoAf2h4E61uZ4ane0h98UUnLpAmBC0J9ei/t6OvwqbsrLAtPFaBpyU7cf2Lo7YJFZsDATF2RWMsvl2pCZLu+dlzPs4w1u9aRXY3TvKbP9kVHWiKtA80aBMeLjuL7wuiZ9fdDNGdeWL2DGLm5NW5gG+1tGLKRzyIRg12toxo/lYR5klmwfOMiCMgo7saPGeSkJz8dBqEQY5uqv4gqsJAqPYKv54cWl410ZQvQuHnV63L84buGu1IYU+QfE1mHnNNcpEQ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 06:44:00 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:44:00 +0000
Message-ID: <5ffe8232-4724-403d-942b-deb631effe0e@nvidia.com>
Date: Thu, 18 Sep 2025 09:43:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/6] Add kfunc bpf_xdp_pull_data
To: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, paul.chaignon@gmail.com, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250915224801.2961360-1-ameryhung@gmail.com>
 <a9ce1249-f459-440f-a234-bdb8dd4238f2@linux.dev>
 <20250917142239.245e9ed2@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250917142239.245e9ed2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: d2472e05-a99d-487c-d31e-08ddf67ebfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjYydEdIbmUwSjBqajFSK0NMK2dhMzRrbERPR3VpVnk3ejk1VDF3a1IrVkJK?=
 =?utf-8?B?S2VmTWMvRnI2UmlTdmpkYU0vaTZpRDV5N3FRK2h2YVFKc1lXYWg3WWl4cDA4?=
 =?utf-8?B?UWRxMXJ2bHFvMXNZM3hCRENtdDlEY0trQXcwMm5JcGphdmtnZUo4ME1SeFlu?=
 =?utf-8?B?UFZWRC90L2FtcVNNNmUycDE2SWtOK2VoWVU3d05pejdoQkNCUCsxWkZaWmIy?=
 =?utf-8?B?cTVZZ1FSbW5paFBJWXBjQUo5U3pla09jMk5BMFJDaG5jaFl5RXhVeStlNG9x?=
 =?utf-8?B?b3ZsaWE2ZTRMWmp2K3pwWkgwdm9pUG0vYkJOdU1rUlZGMUF0RDBPajFxVEdN?=
 =?utf-8?B?RnNvdjBlV2VkZWI0T2ZYSnZWQkEvTGpYaitNYlZqOU9FSHdUSjBPZUp3YWwx?=
 =?utf-8?B?MWx0SXlmQXB3UUxoTXo3eUZXd1FpK3pYT3UyNUlSUEk3bVozUWM3ZnJtZENW?=
 =?utf-8?B?UExCREFXSUlDS3Mya2NyZXROcXh6L3VmZURhUEtVMVhMMkxJNjY0cHRkejM3?=
 =?utf-8?B?c3ZER3VRQ2ZCaFg1Q3Q1Mmtwb1VHK1VaQldOMFBhL3liUEU0Q2R0cUhNRStQ?=
 =?utf-8?B?bW1OSTU1Y3VVeXRmYjRjTjNPUC9OYWt0WEFTSzB5WWkyQ05obTVHWE1MZU43?=
 =?utf-8?B?dDBJNm9KOWtTRU5aOGdnRXBVYjlSL0ZYaUl1elFYTU8wcmFHNU4xU3F6Qmha?=
 =?utf-8?B?OUFZUzlUaU5NV2xweUhxU2hlaHNMN2srZm8vVzFldUhEUDl6UVFuYVhyUzJ2?=
 =?utf-8?B?dEUxcHJ1TXNKZUVsUnMyZjc1eXltQTQrd0RZQTdCR1lXZlFNQTh6S3dMWENV?=
 =?utf-8?B?UlM4a2xCWi85UTl5eW1nMGwxd3hyYnhHdzVPVG40NnRFdHozeUtFOVhoa0dH?=
 =?utf-8?B?MmFWL1RwMHBpRWtTb0RrZnk4RDRZRElvdGdVRmNQNElmQVdBeWdqYkxWZDJH?=
 =?utf-8?B?dnFwNE9ZSEJ4Y29ld09LSWhNZDhNWUNSZFhUeGViTnlYK2QweGlaK1JORG9P?=
 =?utf-8?B?cFowUFJiQ1ZROVJIQ1dqZzMyUEJIMzd0YzJTNUZMZGc2STcwNW1DWW1La0Q5?=
 =?utf-8?B?YmVDV2JiVlJiYnVxMEtER2dIbllyNE5OMktnUndERHMrcWJUTlNkTUx1T3NY?=
 =?utf-8?B?ekdDZ1pwdUkxZXJjbk9LV0xDWGQ3U2k3UzhkNHhnQmlnQndNS2ZQNlZHZU5v?=
 =?utf-8?B?emZLeXBPd3dBelU2R1oyMEpyTy83cFlQSjdXcVJVMXhuMjAzazgvZ0hCWi81?=
 =?utf-8?B?NTc4YXpQVnRpSndzTTlYS2EvTGYrWUhNaGZRV3BuSHB2UVQxb0hhYUt2SVhx?=
 =?utf-8?B?Qk1rcTBaQTlwMDU5cEZDYTY3RUFPcjVyK1pCRHRQcGR5dVpqR3pHd3dPVWd4?=
 =?utf-8?B?WkZTajBtTDJEaVJWNEpHVis3U2p0YzhNcFU1dXhoWFhuTE5ZSER0VnBpVlV6?=
 =?utf-8?B?cG5nUHJocldoTk9OTTcyTkJSeE5EVmRjZVkzTTdKYlNOUzVjdVhQVEtKYWQy?=
 =?utf-8?B?aXlyTTFWc2FSbmVtRG5pVXoxTTVVZGdDZythczRpVnp0RXY5VGMwOXZpWFor?=
 =?utf-8?B?bS9BRFdONFJHdXQ0M1k4cDZSZ2JnYkxOdUIvZ0lFNXQ2UGtXcDNLSFJzaVdx?=
 =?utf-8?B?eWo4Skt0M01FNW51cDBxWTlCMkVZK2d0MWl5dDQ0KzdUUFQ5dVc1VWZuWFJW?=
 =?utf-8?B?RjVUaC9hUURmZVUyRGdKcWg3L2trTXRiMXo2a1Qva1kzRUJ1b0Nhc2JkMStK?=
 =?utf-8?B?QWZrekRhcDE0RUllTVNVVTRVcDFBZVBianQ0YlVURUZ0djlsMk0rTnBBcXZB?=
 =?utf-8?B?ZWM5RXh5L0h5aHhUVThHbHRUNDlWODFOS2ZuVUlxYkltQ0JWZExSMDBWcHVV?=
 =?utf-8?B?cFhVQU9VenVvR3hVZXF4M2taT1YycTBTMGVGc1BkSjZKUVF2clRDWS9kUnJt?=
 =?utf-8?Q?6LyntiLkBl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEVCTXlXU0xPRHp1RWdtL3NvcUkwSzkwdGJ0N00xYitHVmtQSkZOWmo5WFpu?=
 =?utf-8?B?OW9xOUVjaFdSdDVrMmY0cjBlUHlJdTduU28rd2VtRit4UHFVZmNlL000OFZI?=
 =?utf-8?B?L0lHSFBUbGhPQlFydkE5T3gwT3dmejAra25jbUp0ZktSeEZHL3FkOUg5OHBJ?=
 =?utf-8?B?eStEU1V5RTZoM3NNVjZ1S1VGdllzazhaM3ZtTldJSStSWDZDck5FTGFLUVFP?=
 =?utf-8?B?aC8zNG9FVnR2cWg5Mng5MEJWWXNwWi93V2VKbGRBaFc5WHNxQURZN21RRDMw?=
 =?utf-8?B?UTkvRXoyQnpVOVd5S2lyeG0xZE5ocnNQMzVKNjFFUllId1RyM2VKSTZMaUxj?=
 =?utf-8?B?T3A1Vk5NLzBJdmxFNTRsV2QwT0g4WHhHVzhkVGpqRmNWSlJUZlQwbHA0RXgy?=
 =?utf-8?B?bHhrSEVSdkhPcTc1VFRzT1FoTVBLdTU2eFQ4a0FQSE9vUG9lTmNwc1Q1cnJp?=
 =?utf-8?B?NWxQZ0JTRmZYMXFSM1hyZVdYSzJGZ2w4Z1lEM2tQWDdTQlFDT1ZDdXpobmRD?=
 =?utf-8?B?eERPZUJlV2JjR205QkVOeks0UStlYTRDR04vLzRncWV4b3dOTVRZR1YrR1JS?=
 =?utf-8?B?WGFsK2xWV01OOUxxc0tsYW9DVG8rVmR2cndJQzZPQmVpQjVKeHZqb3ZlRWdV?=
 =?utf-8?B?V0Q1eUxlRzh3KzRGaGxpNkFQVkRIY3dVM09nQU9SclJhYVpVbG81NXQvT1lH?=
 =?utf-8?B?Slh3NWpid2k2QWVLUDc3S2Q1Q2VUZnRpWVlDVXRKK2krNDlTQVJHVk80NlB6?=
 =?utf-8?B?U0FyOFJFNXp6Zk5FdmQ2S1JFSlpELzl6Ym9aN2JtQkUrT3AzYXNGaHdxajJ3?=
 =?utf-8?B?VVBIRERKQU5pK0gzQWtsdlQxSy9pdDFBNDZEanVKNGZnT1o1SFVubks4Tlpa?=
 =?utf-8?B?SGlXbFhjMzQrK1crMkRsQ1IwUHpxU0JuSXBMQXVqS0FrUGtvM3E3Tlg2WGdM?=
 =?utf-8?B?amRPUWtGQ09aR213dkZDZGpmT21paTZqRG1JaUxZKy9GdWtlbU9RelFuL29n?=
 =?utf-8?B?REc2U0RETEtKZzExWkJVaXRleHMvZ3NRRGtnL2ZMNGFzQTJQekxDSXM4Nm80?=
 =?utf-8?B?WEx6V3V2THplRnJ4bHUxbTRNL1dIZVJKdmExeG5yZkd6V0dTTEx6N3dKc1Qr?=
 =?utf-8?B?YXpOUnYyVThwQVE5Q0JrNkFYeE9ZMDAzUVRzOUw0NkJwakM1a2JhclNtcEp0?=
 =?utf-8?B?dHRGYlRrOW9rN2tGNFZaRldXY1lacHlRenJQemFUS0xyQ1NubmxnV1lmVDV0?=
 =?utf-8?B?K0hHWHFMcUdFVmRrUmtpenVKNGhzTW5xclJNdFdVSWxKOS9kVWRVaCtwaW02?=
 =?utf-8?B?YWVBSUE4QWZxWk1tcG1hTW11VGRWYW01ekdCK2VEMlZKdjNPRE1XMjNaSGVn?=
 =?utf-8?B?UzZUKzFOcVNEalpyOStRbWlpSFhKdEdaaGhhYXh1V0hBMFBKS2hCbm1tRTV4?=
 =?utf-8?B?L2hEOHFqTXZSYjlnTGpUNG9nQXNraUxkb29JbnVSKzZuOTd6RGlaQS8wV3A1?=
 =?utf-8?B?RlJqdklla0ZreGlQV1Y3RW1RbjFKVkp3eWRYNSt3NjN5NWFIM3ZrMUNoaGtw?=
 =?utf-8?B?cDZtOVZCKzZtdU1hTDhLVTJsSlI1K1N3ZDFpcWQ5TzY4ek50L3JhTUJoenBW?=
 =?utf-8?B?bDJqdUNqanJJZThha3llMFJTM0ZoOFJHZW10VDlEZVhjbER0MHNuemYrT09j?=
 =?utf-8?B?b0xaakJYa3AxbW5Udzc1NC9paStsY2hqM0EzNHNDa254bmtDVmVxVFVWWE5P?=
 =?utf-8?B?cHc4WXNZSW5xWHU2ZzMvTlByNzJKZnhCYWd4cDVmNHdiUnZRcjBJcG4remNa?=
 =?utf-8?B?eE90YllBeVk0T3BDSnlibXRXc2N0eHIwaDJkRDBUYkVxcXo3YTFjbkxIeUFz?=
 =?utf-8?B?cFhQTEpWR3FxdzJPS1c4VjhUaVRYWUYvbEpOdEVscFc2WnpBWlZXWmN0ZVNp?=
 =?utf-8?B?VlZZWGJickhGNWVYVmhOL0YxdTc5dTY4Z2o1cmZycDcwL2c2SmdTSXlrSHQx?=
 =?utf-8?B?aXNjSGpXYnJ6VXoxU1Z4N0dGYlJ0Q3RROVp0TW45c3R3T0p3MDhpWkF3djkr?=
 =?utf-8?B?bzNWVzh0eWFuOXg0MGhQV3FuZVM2OXVPWUo4cnhFZjdiZDJxVkkvVUZ5L2Jr?=
 =?utf-8?Q?6M7zVkX/Yzh1mmlB5QSPrVYrO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2472e05-a99d-487c-d31e-08ddf67ebfc9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:44:00.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqlsvFG86a6ZoM35ttkkK7R6x+fs2Y+YhVsly1RzkCEQotXeIxQVceRdQejITPiqez1SRY3TOtgi+X0Qy++JKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803



On 18/09/2025 0:22, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 11:50:01 -0700 Martin KaFai Lau wrote:
>> On 9/15/25 3:47 PM, Amery Hung wrote:
>>>   include/net/xdp_sock_drv.h                    |  21 ++-
>>>   kernel/bpf/verifier.c                         |  13 ++
>>>   net/bpf/test_run.c                            |  26 ++-
>>>   net/core/filter.c                             | 123 +++++++++++--
>>>   .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
>>>   .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
>>>   .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>>>   .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--  
>>
>> I think the next re-spin should be ready. Jakub, can this be landed to 
>> bpf-next/master alone and will be available in net-next after the upcoming merge 
>> window, considering it is almost rc7?
> 
> Nimrod, are you waiting for these before you send you dyn_ptr flavor of
> XDP tests? Other than Nimrod's work I don't see a problem.

Yes I am waiting for these to be merged so I can rebase my work on top.
Thanks

