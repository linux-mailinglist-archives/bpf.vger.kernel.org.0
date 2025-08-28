Return-Path: <bpf+bounces-66843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9AB3A627
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FCF1C83DC7
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178627A90F;
	Thu, 28 Aug 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cj7J8bPq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585EC321F53;
	Thu, 28 Aug 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398213; cv=fail; b=bKYjY6OEt+6/gNK5VYG5v3uKoq8p+LC8QrZmS3z9A43C4xAf5q2vlsLEF6XFHZAkDsJbbrcC0eileC9+pguaMi1j0bz5H5Uuny7a3dQlXwgJuLHdoJOyzMzxiD58VwatlnhZTmEaCEKSxFOz/gkCjgHYZq7t/5R0KeGXCvR1PdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398213; c=relaxed/simple;
	bh=3X5FZBh0uHB/7jerCUDLWwj/ZCfZ7aYSLR1fbNpTvEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sVwVdhCQ9n+3LI7o6TxeI32rBBnxiq/7i0fhJiUaNLdnKmQtKegzH0erl8lqDniRnfD7iCU3AKxrctR3lLra1xAEJ+4c98NM+w1pHHvU17wZEU1oIuz9+5nbHqQvudFxqdUNgQicCtS7PJjv2ZLbeiwpb2aiz2GZXenF6EeH1cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cj7J8bPq; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWAug2cFzWq4WkeRizQE+r7VcIrgec3769cTtbQcpJQvMFeNlI8H5MJVeB20CRYFxRdsJYCDka9o6TP8iFF2GY3dTZrJCjyuJlzDjiugcrJzrHcIXWtoVrG69Jr9jYcP56lMA8Jt+Y2zP6FjUO+N4Nm0oko8GvzM958qs49K/Hy2xwwY229RnSBElEuw0izEgJANvu5OuNBGXs9QPHjXXOiCkwxzcKj65EL04Xu6MO5+J67kp8b9hB38luq0LVaRJxRjIkMmy4jClMffX3p/HQCtQNeqvQn3e+a2C181XlTcdOmR5xP0KGGooQM9pBhRnIdJBn9kH6bzZEB8Q2tKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H46lwVXa0VRK3OrFeWZh0RWV/fh5RCCz/WV6NQLoObg=;
 b=Ikoyo5jDtS5K018gSma5F0S0xGVYlCtyYG9EelBkTLHy3uTaL8FhbUyNVBNPUvAybAiqr5AbV0wL+kNpeLJH67B42kCwXXmC81RyWbYpbrXiYgXS3XLw/V/9ODpYWxPLEZiamqY7ilavnSPJGbLjZd1h/7odCXLI2B+U7nrzSh2iDUVYg/TksPEuQDri6Wbh1BPnWAYREq0nlfDHI8JxnBvMuNbND7WaINHxvjH5l1U4GkoetvqnU6MlX3YL5k8hbO+9ejlhcTkxcDkS4MjzU34R8G9vdFVouc8BW91DcQpYD64lZwqIrNUC8gZrwQyUVBsCEePZ4V5CQJ4hSQeK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H46lwVXa0VRK3OrFeWZh0RWV/fh5RCCz/WV6NQLoObg=;
 b=cj7J8bPq2dg9KRWXjXCbkg6PTPStGHiKDjVQop5vr6hI4CQGZXQtiTfI8Q706GKPXp1Dyx7moHBuCEepI0xdXNl64wcYgNXxiNhMeUPW9q2s4CWt0NpUOjNRFQ56XfqwqFK43hybDckOZ4jW/SCiYsqiZHf792lkw9eq9zTrarTI3v3E2xFtTa5K/gjCA2ft+LLAOya9N1d9TTrkcnM03qJSHpW6SsHPXoU0WW62oR7NRqgWbThMng8OXV1kzlPfXaUlcLFtZiSRfGgpRZsGlbuOnZEtH6xOXT+i4zfOaStVtqUB9vI7wfsiB8fagojm+AyeXUvkgLdTWtszocnAIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 16:23:24 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 16:23:22 +0000
Date: Thu, 28 Aug 2025 16:23:09 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com, 
	noren@nvidia.com
Subject: Re: [RFC bpf-next v1 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
Message-ID: <aniua473ljbet6w6ov24z6yzwlzzsbvd2d5dud2gep6kp6j5fg@fngzextb6w46>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-2-ameryhung@gmail.com>
 <76vmglojxf3yqysn5iwthctiacjy6xqcvrzzny74524djwhcf3@ejctdcty3cdz>
 <CAMB2axOLCakHEGnPcRTd1-ZdcGT6+wximWDOSMY1r9PGerfF0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axOLCakHEGnPcRTd1-ZdcGT6+wximWDOSMY1r9PGerfF0g@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d41d11-6aa4-4317-d526-08dde64f351b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGFnSFBESjdYcjBBNDgwL3l1a0I5bG9udnREdWowb3NSMURYWGZ2TkcyTk9B?=
 =?utf-8?B?UXF0U1dzSFFzckRVd2tYZm04b1p4clhGVHM3cTAxZ0I3TXZWSHlacUpONFZB?=
 =?utf-8?B?aHcyMDJQN0JpT2Znc1d6VW9aL1d3QkdZOGp1WE13NHJMVE1saEpPcW9pSWIv?=
 =?utf-8?B?b3liTlRGK2ZKc2NVbWNHSzB2SXE2T1RVbjMyM3dKNjNwYlpKV2dTR3VOdk90?=
 =?utf-8?B?MWFaUU1oQk5wNHJBa1JJYlJpVERVZEVwc1UvMnd3Ukk3N2psRnhBbXZKMW00?=
 =?utf-8?B?cCt0cWszaGUvY2ZIN1NBTXpveTc1Q3lha0pwQnEwbjBZSXdNUW5BMXNaVXRk?=
 =?utf-8?B?dXZZQmlZUXRrZHU3Zlk1Y3J1QWRjWS9ua2sxSHZ2dysvNWxRYktMRnVKY1R3?=
 =?utf-8?B?SzB5WUxKRGlkNjVTYVlFYmNjNEcyTGdBYkErTWxlOSt0bmhJSm1rNHNlY1BJ?=
 =?utf-8?B?c3NQM0J1K2V1U2sxWmFNc0prcW8rRFpPZ05uRm80elVrQ2FoeG5aeWVmQ0pH?=
 =?utf-8?B?ZXBzZW1DTURPY1ZSaFZ3OWU0eFU4WGVuTlpPWW90dndKNVVDWHNPSXNPL0E3?=
 =?utf-8?B?YXB5YWNrNjR6RWlMcC9RanJoNFNhVDd5dnNZa1ZkQ1ZtbnRySU1hSG9UOWJs?=
 =?utf-8?B?RGpkTVF2STBaUTk2SS80ZXZoU1BpbnF3R1ROMWVIR1NzNVMvVlZtYUdQQVQ3?=
 =?utf-8?B?TUhRYmUzTkNPUGJUckFKbC93MHlYR295YTBxd3A2UDVuajVHaWdxbENYelVt?=
 =?utf-8?B?bmFwaEk3aTVMUHUxeGVQUllQTUlUd0JURUp2VnI0QzVrNVZGOFVKS2RuVitE?=
 =?utf-8?B?aU44NXBoUzFQNG1GMkx4QkN2Z3hoQjBodEg3SXdhWDB4aGd4ZTBmeFloMVYv?=
 =?utf-8?B?dlVHb3dUMU43Z3hVTW1UeStnRnRpSkVSb2VXaU1iOWFPMG9UcmNkMDZ4Y01G?=
 =?utf-8?B?RjM0WXR2bkw0UUMraVlKV0FjOFgxN1libkVKcitidUNVYUpFblExUm9JcVpE?=
 =?utf-8?B?bVZGakpvdDZKMEVGQ3VDeHV3NysxSVRONEdnVXFiVWNFK0p5NFN0cmZkamZi?=
 =?utf-8?B?dHlaQUdzN0ttVjdzY3Urb0srNFNDelVDL21NZ1RXTVFrdjBBWGZaU015OG9P?=
 =?utf-8?B?QzJHeWVUcVE0UWI4ZjVEaUdzMFByMDdMM0U4Y0F5S21FRmNDR1N6U2dmUkIz?=
 =?utf-8?B?RHJyMVlHenVvcXcrWHZoUmhVTnVseXlGVXdiTVBKcW1yK0xwdkdqdEhlZ2R0?=
 =?utf-8?B?S2R5WkJySWR4UXdudzNwOHo4VERvRmxiTDVHaFU5ZHh3M1ZZK0VmSXg1ZmQr?=
 =?utf-8?B?NG5aaG5ibXRBeHRMdWtWQkU0UzRCUzFBZ3BiZHN1RkRCUSsvOWtOQVpEbHd2?=
 =?utf-8?B?ZFFVZ3pCYSsrMkVJYVhwNXRLTi9STTFKSVBKV0wvc1NIQ01lcjBOWW1wUXRV?=
 =?utf-8?B?SDg1MVltMGJJY04vL2l0UTZwRXRyYzdkenVWWXBSKzFscmdvemp3dVZidjVu?=
 =?utf-8?B?VUZVc1NGT0pybkphRWhjek9OWFpQdms0WXowVjhQK1ZTTUlDNnFvWWc4ZDMr?=
 =?utf-8?B?Rm51b1ZsVmVDYkx6dFNlampOSTR4NXB3T2RUQ2tmVzVlSGxYblcrazF3bzBu?=
 =?utf-8?B?NXZwU3Y4RWs0V01HUjdEeVJGaWIvVEw0dEgwcmd5VjFJUkdHdmRFZ3pRNG5S?=
 =?utf-8?B?dTZYOFNaRzFVWGlEK2crTWJHbStZSWVlK2YyaHMxTFl5RG5HTHFQQmNpSEdh?=
 =?utf-8?B?cStHSnA4cW9BQXoxOEVZTVJHYWRtSk8wRUhLWGdMYmJNZ2g5MUthenZmbWZ3?=
 =?utf-8?B?VHo0M1MweThqbVFMQXB3ODdBN3JXREdGemErQ0ZSTHZHUHdlZS9RMWE0YTR1?=
 =?utf-8?B?ai9iTEhGeDBMZjBXYXRJSmNLdUF1WlFWQmFJeDhoS0dhN2xhNFVjUkQ1ZVhM?=
 =?utf-8?Q?/QkTpCjFlfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2ZhUzhIbWJubzNob3p1U2pXZUVyd0h4eUdOalFxK1lVWmhmQlU1dUVDTW02?=
 =?utf-8?B?eDM4dVlwUU5zV0Y5c2ZFekZWYmsvSG8yNDFDZENmd21POGFXeDNIS00xdkk5?=
 =?utf-8?B?U3A3K0JVcHkxcThkWDlidEFUM21JVTJvVzdLV2ZYU2ZPdTNRellJazZnenI5?=
 =?utf-8?B?Qmt6UVg4SXgxalVoenYzSTNKL25hcS9wN0RUUE12YXRaKzYrMkdWdDBidGc3?=
 =?utf-8?B?SFFsSFZEZy9kOWtqajdqeUowd0w1L3F5eW5McVk3WHZvR1hVTzJqb1lGRU54?=
 =?utf-8?B?clB5L1ovM3M5TmFZOWRMMTlQaVFlZ2tEUk1waTRWdjE2TXFRc1lMVVA2alFa?=
 =?utf-8?B?bGQ1QU84Wmw0czNIbitGY0pibWRtdWZucHgxNGFXQWZBUHNJTHZHOHNWYzBs?=
 =?utf-8?B?ZnJJQnVwK0ZRTWRGcXUrMk5KdUV0VmE0dk5sRXR2YVU1d2YxaWxyY084TklP?=
 =?utf-8?B?aW90c1lDSFdBQmd6a0VJMnkxRUVjaGhxOEFlYldUYldQYVd0UDZ3ejhFWDdr?=
 =?utf-8?B?SmRpNWhCeUdqdk1vTTVhbDVxL2lWQi8xckVwditwUDc0WERZdGxIUUNnUXZu?=
 =?utf-8?B?LzBJR1lmVE1ob0h4T1RYRmxvbHhYSTB3LytuaW84SGxjNzN6ZnhKTHM1bXFo?=
 =?utf-8?B?QVRuTW1rdXJaYkVpYXpodit5YjhvR0FBVXp2ZnNMUUhtMkdaUnV1WHJJVkNX?=
 =?utf-8?B?UVA4dkhhOFJINmhPLzRWdTB6clRZaDBNdzZMbUR2bDcxWkt4cXBmVFU5NS9v?=
 =?utf-8?B?RjZLK2pvNXUwT2x3aDJlbk1iVW1kaC9Dc0hlMW5ndzRqNHBsQ3VRR2hYcnJG?=
 =?utf-8?B?M2Y5bHFqK200K0dZNnUzV0krTk42ZVFiTGQ3ajAxT1MrQjJQOFlmTzlNS2Fj?=
 =?utf-8?B?WnI5cGFubjVUN1BZV1lnYUF3K0NmcHN3cjN2Z1dOU2JUOG95UGFoaFVZRjZY?=
 =?utf-8?B?QTl0Vy9kenVibm5WbFowdjVIZ0JEVGYrbUt2SWNvQkcyTGROdHYzVjNjY0FK?=
 =?utf-8?B?T0tCYkxQT1dqdlRhajJhTG1jeTNpRWhmWVJmVm9DdjF0aHRlUHZ3c3VTeExP?=
 =?utf-8?B?aGJ6NzJoMVU2dzQvSkc5SHN6eitmMW1jZEZibTQvV2pRdVB4M1ZxU1AvaUNE?=
 =?utf-8?B?T1IyK0lmdVNxcGFtUEdWZnlheGVsTCtMMDZFS2dMMUN5OExaTHQ5MmQ2RHMy?=
 =?utf-8?B?Q0ViemVYQkJpQTNKUCtEbWxQTlZlMy9lOGwrODEzdmRKdDlFa1YvTjhON3pD?=
 =?utf-8?B?ZWY2aGVkclRtV3lEa2pTaGZFMzdTcmZmTEFMTzZJQ3hDNDhab2Z5dkYvSExK?=
 =?utf-8?B?UlFiMXpNZm10TzRWQlhvNnNRTi8xWXRrTXZXWjl2a2dKaGZoZ3JLNXJrbzEx?=
 =?utf-8?B?U3pHY0piK1J2RmYyYUpjcFB6aEpEbTg5SlU0Q0ZPUlN6Y3U0YUt6R3dIUUlC?=
 =?utf-8?B?U2ZjTkN2RGVJbVA4bTlISUcxWHVuY2RPdkplUE9DQlBUNnQ0bjNjT0FORFpj?=
 =?utf-8?B?SDE0clFOK3g1eTZKQWNVbWQybjRpTUQ4TlpJM0xMbmF6azh4TkhFKzZ3WEd0?=
 =?utf-8?B?NHRyYzRXZDF2em9DVCtWNkhidkgxRURGeldhblVXcFVrU1RyaHJBVWxjVGVQ?=
 =?utf-8?B?SHRnVzl6U01hcTJZbHR5NjVSSlpVUkFtdmxKZ3NMYWJ5Y3RzTU5XYU1NREh3?=
 =?utf-8?B?bTJmS0l4YVJ5b0QzU0VFNWV0MDg2OXJUZWJPdXRVZEo5L3Q4ZlJzTkpETHRX?=
 =?utf-8?B?WjNvZWlIRytJQ3YvMmgwMDlDTWJOS3NwSWpDc094Y0dsU01NdkViVzBUTkxr?=
 =?utf-8?B?Vm9wZmFRcW1RM0wyc3VKaDdIQzFSMkx3UmdzWG16amJqemJOYkNOcGhhMVZJ?=
 =?utf-8?B?TnZJdE9BTldUeVI0VTROR2FoMGliNlVuM0NEQ1djTXMxT0JpWVdJWWhPTzk1?=
 =?utf-8?B?RGJDVFQyYlNjcDZRTDg0SkEvdlVneGtsdFdNVTRGQXA1OG04eUJnSzMxRDNz?=
 =?utf-8?B?TTh3ZUpQZlRKcXBQeWRlTUptbUlXcjAvMytVOFlwWFZ2bmZ3UTNmM2EyTjY3?=
 =?utf-8?B?NlFmZS9qWnY3anpaOEpxUUZETjJpNHVUMVFIQk8ySG1yNkNvT0txYXVzUzhh?=
 =?utf-8?Q?41InpszQinT8/slvFQw1AqwZu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d41d11-6aa4-4317-d526-08dde64f351b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 16:23:22.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8OOOpRww2Tgdpd/ENL7FmdqojwDuNXC64Qw/mdw6yTDgRey3TPk6orDfOqTxaArDdsJmejyvfxcopeqVwp06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

On Wed, Aug 27, 2025 at 08:44:24PM -0700, Amery Hung wrote:
> On Wed, Aug 27, 2025 at 6:45 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 12:39:12PM -0700, Amery Hung wrote:
> > > [...]
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > index b8c609d91d11..c5173f1ccb4e 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > @@ -1725,16 +1725,17 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
> > >                            struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
> > >  {
> > >       struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
> > > +     struct mlx5e_wqe_frag_info *pwi, *head_wi = wi;
> > >       struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
> > > -     struct mlx5e_wqe_frag_info *head_wi = wi;
> > >       u16 rx_headroom = rq->buff.headroom;
> > >       struct mlx5e_frag_page *frag_page;
> > >       struct skb_shared_info *sinfo;
> > > -     u32 frag_consumed_bytes;
> > > +     u32 frag_consumed_bytes, i;
> > >       struct bpf_prog *prog;
> > >       struct sk_buff *skb;
> > >       dma_addr_t addr;
> > >       u32 truesize;
> > > +     u8 nr_frags;
> > >       void *va;
> > >
> > >       frag_page = wi->frag_page;
> > > @@ -1775,14 +1776,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
> > >       prog = rcu_dereference(rq->xdp_prog);
> > >       if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
> > >               if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
> > > -                     struct mlx5e_wqe_frag_info *pwi;
> > > +                     pwi = head_wi;
> > > +                     while (pwi->frag_page->netmem != sinfo->frags[0].netmem && pwi < wi)
> > > +                             pwi++;
> > >
> > Is this trying to skip counting the frags for the linear part? If yes,
> > don't understand the reasoning. If not, I don't follow the code.
> >
> > AFAIU frags have to be counted for the linear part + sinfo->nr_frags.
> > Frags could be less after xdp program execution, but the linear part is
> > still there.
> >
> 
> This is to search the first frag after xdp runs because I thought it
> is possible that the first frag (head_wi+1) might be released by
> bpf_xdp_pull_data() and then the frag will start from head_wi+2.
> 
> After sleeping on it a bit, it seems it is not possible as there is
> not enough room in the linear to completely pull PAGE_SIZE byte of
> data from the first frag to the linear area. Is this correct?
> 
Right. AFAIU the usable linear part is smaller due to headroom and
tailroom.

[...]
> > >               if (unlikely(!skb)) {
> > >                       mlx5e_page_release_fragmented(rq->page_pool,
> > > @@ -2102,20 +2124,25 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
> > >               mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
> > >
> > >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > > -                     struct mlx5e_frag_page *pagep;
> > > +                     struct mlx5e_frag_page *pagep = head_page;
> > > +
> > > +                     truesize = nr_frags * PAGE_SIZE;
> > I am not sure that this is accurate. The last fragment might be smaller
> > than page size. It should be aligned to BIT(rq->mpwqe.log_stride_sz).
> >
> 
> According to the truesize calculation in
> mlx5e_skb_from_cqe_mpwrq_nonlinear() just before mlx5e_xdp_handle().
> After the first frag, the frag_offset is always 0 and
> pg_consumed_bytes will be PAGE_SIZE. Therefore the last page also
> consumes a page, no?
>
My understanding is that the last pg_consumed_bytes will be a byte_cnt
that is smaller than PAGE_SIZE as there is a min operation.

> If the last page has variable size, I wonder how can
> bpf_xdp_adjust_tail() handle a dynamic tailroom. 
That is a good point. So this can stay as is I guess.

> bpf_xdp_adjust_tail()
> requires a driver to specify a static frag size (the maximum size a
> frag can grow) when calling __xdp_rxq_info_reg(), which seem to be a
> page in mlx5.
>
This is an issue raised by Nimrod as well. Currently striding rq sets
rxq->frag_size to 0. It is set to PAGE_SIZE only in legacy rq mode.

> 
> > >
> > >                       /* sinfo->nr_frags is reset by build_skb, calculate again. */
> > > -                     xdp_update_skb_shared_info(skb, frag_page - head_page,
> > > +                     xdp_update_skb_shared_info(skb, nr_frags,
> > >                                                  sinfo->xdp_frags_size, truesize,
> > >                                                  xdp_buff_is_frag_pfmemalloc(
> > >                                                       &mxbuf->xdp));
> > >
> > > -                     pagep = head_page;
> > > -                     do
> > > +                     while (pagep->netmem != sinfo->frags[0].netmem && pagep < frag_page)
> > > +                             pagep++;
> > > +
> > > +                     for (i = 0; i < nr_frags; i++, pagep++)
> > >                               pagep->frags++;
> > > -                     while (++pagep < frag_page);
> > > +
> > > +                     headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, sinfo->xdp_frags_size);
> > > +                     __pskb_pull_tail(skb, headlen);
> > >               }
> > > -             __pskb_pull_tail(skb, headlen);
> > What happens when there are no more frags? (bpf_xdp_frags_shrink_tail()
> > shrinked them out). Is that at all possible?
> 
> It is possible for bpf_xdp_frags_shrink_tail() to release all frags.
> There is no limit of how much they can shrink. If there is linear
> data, the kfunc allows shrinking data_end until ETH_HLEN. Before this
> patchset, it could trigger a BUG_ON in __pskb_pull_tail(). After this
> set, the driver will pass a empty skb to the upper layer.
> 
I see what you mean.

> For bpf_xdp_pull_data(), in the case of mlx5, I think it is only
> possible to release all frags when the first and only frag contains
> less than 256 bytes, which is the free space in the linear page.
>
Why would only 256 bytes be free in the linear area? My understanding
is that we have PAGE_SIZE - headroom - tailroom which should be more?

> >
> > In general, I think the code would be nicer if it would do a rewind of
> > the end pointer based on the diff between the old and new nr_frags.
> >
> 
> Not sure if I get this. Do you mean calling __pskb_pull_tail() some
> how based on the difference between sinfo->nr_frags and nr_frags?
> 
> Thanks for reviewing the patch!
>
I was suggesting an approach for the whole patch that might be cleaner.

Roll back frag_page to the last used fragment after program execution:

	frag_page -= old_nr_frags - new_nr_frags;

... and after that you won't need to touch the frag counting loops
and the xdp_update_skb_shared_info().

Thanks,
Dragos

