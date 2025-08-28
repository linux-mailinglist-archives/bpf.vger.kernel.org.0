Return-Path: <bpf+bounces-66828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C557B39F32
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A6D5634E4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20640313E17;
	Thu, 28 Aug 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxBiHe9T"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F6313530;
	Thu, 28 Aug 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388382; cv=fail; b=QN2UkxhMSWX6EYILH7p1E1ji70bi3QOqKJwO/LjwwA0yCv9OH5q6AJp69asySOfVgKQPn4hvknY5zr2Orvbli5EdPcE6FTFUBfyGPAwhfnyWsE3OrqIDUkOHpJw8FKsAG6zNenayzYvGD/esERPK3a+kppfSTeZ471GnmyVqek8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388382; c=relaxed/simple;
	bh=KxS4dIu3RAWau2bSeaChpvjU4+AUT42eAXan9ilWvAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQgDxBa9VUfapkRY/xWD4ANeHN278o6MiQXftmbkiMYgPm/lPjS0MAE84CnBYan+akUbEe5xZCOktoB+1FPbeMUH+NS1icmhxqajjpo4lg2aim/xzr9erG11PyL3dUJyyVUNrpTdxj6hR8RmQmNAaAz/6cOA5PSFAKidCCAVvxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxBiHe9T; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/bFYO+JtoX40bQhr5+xI/1uhL0ErYi/xLXUDhajfJFwd5kbcpSSuzDdXvKAAa3Zy6IMBzQqoLuGu/Ctlf4L3XFgZ6m1BrmKgG3gQ76ppoUTSEQYg8mlo4LRSfOAQstKkwfLgSAIA7l/s3qMV15uRSgjHiZ1LykOUyUvT4q4wINfglxvEgvsvvL/XlKUelmqnhXMNNPJRgGNiJD4rQgvFYO/fTHJBPPWvw5w+Y0TM5NZNiUCW1OWTuc+/byUz8JhPbe/UCw26Nq2mV4aAajXH4sMehLMzA1FEihgIyumws8pMwYX1Qt/6WvIMQHdY0QOwdOQp2ym4k7In5ZX76hq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxS4dIu3RAWau2bSeaChpvjU4+AUT42eAXan9ilWvAU=;
 b=fg6PgRNLAiJFdnAjD9T4tccF1c5U0txoA/lwBR2ouQZC6oYqpiE7lisN9t+39xzZmvjGpyVkk6Qn8HHL3hnhtPRefKj0vosNNrTwRdUb5uLAmij2JVa0vkDd6y6XXjVTGhPaWmC9c3/HPJAwco/nMGM7q5dPh0p/3ylIXPGsSitlPaEqQ10IKP9ZCwHPXWEU1SwU3RlIeDqp8zLEwvpQb6ffYBQ0CLBZkmnJf5SlhuaPgcNPjthuHOOyg5bV+misPLgGSiYrLWpPp47d3JvPG9pepXHnOJ/9afXbvynSUgRRMj/RW6ChwQBKAsyBbrzKH0CGbzCMC8d/h6xnSvRXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxS4dIu3RAWau2bSeaChpvjU4+AUT42eAXan9ilWvAU=;
 b=YxBiHe9Tqi8+G2VLnQIvFMeN5xgUHh0XwprW/aq2biXirXYssQN02fex26dhYpBzAV1aOuykeSwZGG19tqvSqDY7zHrd6epvgfK+Vm99Y05Nqp6XLZe//viZj+tHftwj0B88Qw/sr+0cHjBk+lB9dNqgQadWVG3+nXy8kdRu72tlxoxEUAa3c82k4QzST+qR+VdArFjxwcgeY3rcxeWU0FoiG+Mdf+BEF52es2vyz2IDXbV3iNTh8p2rrsDUgFWHAoraFb8BYpPD77xVzlZ55B4eLDxqw26M5t+rzdJBgPcPAlYPdfuxyhtRNf6pQeK2WPED6hp+kQh/QNJC+pxJuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:39:30 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:39:29 +0000
Message-ID: <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
Date: Thu, 28 Aug 2025 16:39:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: de2617c7-6399-4b0d-074a-08dde6385046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1ZjeFUwRG1qdmRDY0UraEdYbGtPMUVtWkVQaWVEaEFzT0ZpMFRxaXg1WE9w?=
 =?utf-8?B?NUxiOG1wUXkzVEtjT29WcXlVRnBjUWhiWFlYK0xHR0RjTG1kZUhTK3RDekc1?=
 =?utf-8?B?QkVsNWQxNHJIY0hybzJBKzFhbUVFbE00MzZYOTFOV1gwVE1xWE5Ia25qTEF6?=
 =?utf-8?B?UVBaZTZoVjV5a3F6N0pxWHY3RlpqdGpaaWo3bFRWQzl3Q3IyblR3MytOWkZz?=
 =?utf-8?B?Q2diY2dBVENVTkpFTWYrNXpTWmRzbGl6eFQ2cGh3MC9ZcWFIUy9EK1dDcEts?=
 =?utf-8?B?azcrKzFRK1lGM05hcGljUXRyN1hTNGd0Zko3eHJLSkxMWEwvUVB3TUFpd0hJ?=
 =?utf-8?B?OXhIbXVwSTNFV1FJVmhGTVFIaUI4ZkJJUlhHeFB3RUw1YkcxVDJEV25ETWl2?=
 =?utf-8?B?cE9PMXJ4YXpJUkNhcmZ4STFrRVNiU2ZLYmJuM2dXZkF5cmJNaUloQXNYUDR6?=
 =?utf-8?B?ajdYY2MvMGVxUG93aXNaN3h2Mzhlc3ZycitVSzh6b1I2UjNTY0YzMStJZkl6?=
 =?utf-8?B?WGpuWHg0Rkc0WUp1R01QdXdxTGQzTGhjRUprMHVReEh0eFhyRjRnME42K1ZG?=
 =?utf-8?B?MTBURUJuZkxjY21SVkljMHhEMU9iNXcwaiswTlRuNklQYmRONlZpa0VOWlFn?=
 =?utf-8?B?cXBrd1RrTDlFSG5kRzQ5bVdHU1RHcVVYaWlVOWNLSFZEOU93OEdzZTdUTGVr?=
 =?utf-8?B?V2crbDdVNWNCWng1WlhHU28rUmF2LzVoeGVQSTlCZUxCOGs5QkhoL3AvWEZO?=
 =?utf-8?B?UnFjT3djcEpGYlNHcGptTmUrcWsrQUtNUjByS3p4ZXp4QUJ2eVBZTHhiR3hr?=
 =?utf-8?B?NnMxQUVuK2ZZS1JmRzFYbG9JR0czVHhiRTJBTk9KcnpSdFRjS0RKVDIwSTU3?=
 =?utf-8?B?R0FqMTloeXZVdkxWL0hXR1dDcmJ4U1R4SXFPZjUwYk45UmJkbURhb01FWUhm?=
 =?utf-8?B?K0V3S25HNTQ2bzBzWUxZYWxaOExWUFN5Ukh3UzdPWnlUNElRS3JVb20rSGht?=
 =?utf-8?B?ZFdEVDh4bEhLclMwTjQ1UUxWN1B4d25jWjF4YUQ2MFRCaEFrRnFnMGdiREJB?=
 =?utf-8?B?M1U1N3FqZXhtTVd1ZUVOcEdTQlEzRGx4dnVRWVpwZGFhRm1CNjAzdDB1VTho?=
 =?utf-8?B?cmd5ZHh6eHlFMVRnUUpHWU82ZXhuaUNlYnFWSldscFFVQ2ZkdmNCbHpDREhR?=
 =?utf-8?B?N2FWbFptWm9Ec2M4eSs5SXZGc01tVmFST2tDM0E4b1dTN0RuNUQxWnJFcEZw?=
 =?utf-8?B?MU1PSDZrUmNtNTBEbk5GZFdJZTV2eURTcTBtQUNhOG5hWncrUU90L05QRktT?=
 =?utf-8?B?Z3VPYjFjMEJ2OXhVME11Um5XWVQxV2kyWjRsYmI1dE5VTWgrV091M3ZjMWlm?=
 =?utf-8?B?VHFiOEZKNkxScG9lWW5iVVhDRXRjNUlEMm5RVmJ3VVRDTHBqUlB4c25pQlFa?=
 =?utf-8?B?WWZRMDF4ajhGWGhHYUJJemsvRmZ0Tjh3Z1JmYVpYczEyUithZ3RmR0RwT3RU?=
 =?utf-8?B?RldnOStjcWhPak9yZ2RMbS9PZG9qbWd1UUhnMi9JQmxxZm05Q0FyMVliaFFL?=
 =?utf-8?B?dmcvNFYwWkl3cG8wYzg2QUVlN28xVWhQVmx0eE9reDlsaDkrRzVqazRjVVQ5?=
 =?utf-8?B?WWNTbzRXd1NQTlZPRUZBeC9QWFpmWTN5K1l1TEltd1ZRVVhxOXlpWVRLK2ZN?=
 =?utf-8?B?aWxuRjl4elQyczNQb2NZQXJkVEl6OWxTY2taVFVVRDVjV3ZmTHBMT2dnKzdW?=
 =?utf-8?B?L0UzU1dscENRcjdoR2QwRlNQYzFsRWVmR1VaTUhUbGNVRkNPbnIyS1Z6RzRH?=
 =?utf-8?B?ZEFIc084bXVKRlllMmEvb25ZZDlJekJjUnNLRHl3czl4MjNVckpad3ZkcVNN?=
 =?utf-8?B?SllxVEhaRXBiRXAxNXZqV1R2TjJKTlJGamY4Um1Jd2d2THc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVovUnVMZHFGUjhiUzZhVlllOGtYWGhoVU9FdXNGZUQvMS9RTWY2MmZjWEJo?=
 =?utf-8?B?d2hjS3VOSU03UnROZU90Zi94dnM4U1Q3MTFpLzFmdHB0cm1VbGZjSTV0RmU5?=
 =?utf-8?B?UllnbzZMeWxzaERPZHpzMlBsclp4MktUK2RTUGUraXFCUndiM0JEbXg4ZWo2?=
 =?utf-8?B?aGh5b29MaEQ4UTFqZUR5ekxZQ2FrZGpuSVEzTWh2dVRDQXZLQW9TQzM3SjA3?=
 =?utf-8?B?VnNIa0xlVFZIQ0hJbjErTXlmamtUSjdrMTFQa2srMGFzZFFWdEFlWm01Ny9Z?=
 =?utf-8?B?TG9VcnRXTDZUNmdGUnpJTkVlTXNsNW9LT0NGR3JDdGxvdG5aTlI1b2pqQUNx?=
 =?utf-8?B?ZWlWS1hxd1o1K2dYd25udU1uQ29JazAvY1FGZzE2T0cwSWRTc3ZkeEkybWN6?=
 =?utf-8?B?OFhaT01sZTdiL2ZINzFrRjlhQkk0eWNTY2tiMS9MSGFycy9pemNrdkNLMmhk?=
 =?utf-8?B?KzVnVDZaRjRmZEJyTEljVHR6S0lZRkJ6a2ErbjZOZEUwRjI3UlVSa2R1ODdx?=
 =?utf-8?B?UTd0Qk5LSFF5OWlRQkVnWjlZdjgvaHd6VHg0L29LTm5HMnBrNUU0UzdqS0tP?=
 =?utf-8?B?bzlJLzIwYnBZMlhTQ0loMDE2WUZyejFXZUxYWC8wc3R3WVNoZnJaMU9iV3FS?=
 =?utf-8?B?WjBkUnRDWHJIcVVWS3JqSDA3MEhoR3pCRmNDbTN2T1ZLOTZxeHR2eVpGLzlK?=
 =?utf-8?B?cGM2a25CcmhQSEJ3UGZIL2RkZTNuakJldk93cjlOelNxcEcyVEZxa25XN1Nn?=
 =?utf-8?B?eHhxRjNoUlNzZUFFVXlmK1A4K0VkdWNZOWNVU1RqSmdlQkplZy9IM1psNE5D?=
 =?utf-8?B?Szk4NXo0d2RNTC9kTGFqWm1idXJURVZvaEltSE5HTUtrU21pQlhDVjgxdUxv?=
 =?utf-8?B?TCtzdTUyM2duWWNXak1MVFhHbTQ0RGxJbllubEkvNW5xbDZJUWlqYld0eGVK?=
 =?utf-8?B?UjM3MWV0V0Z4V2sxMkcvVitoT01JZ25ZbGtqNi9wbnlHSzMwY1RxWFRCejlC?=
 =?utf-8?B?MXR0elpCKzRDUElQdUJCRktVUUFlMlJIaDMyN0k3ZG1yZG92Y3ErdkJHM3dj?=
 =?utf-8?B?NHRtMys5L3hET0lRM3A0dnIvZ3g4MTlhckZ0SmlyMy9tRjlSamloWVo5VHJU?=
 =?utf-8?B?ZHRNT0dvQnVVc2dpMHI1VCtmY01sZmRmUWhlei9wdVJZbjFORHQweHFLdHlz?=
 =?utf-8?B?VTM0d1VGWWVqNG5BMU5IcE5PeWlTUzlDbHgzU2JQSk8rLy9XazhPWERnSWNN?=
 =?utf-8?B?YnVzY3ZTRXlHeUNZWkE3TFdrVndBdUw4OTdiVHN1YmU5c05teUYySTBlaDVk?=
 =?utf-8?B?cEV5OGtxdFNDcml2ZjJFS1dNSENlakdTS0tpRjNQa05OVkRKYklyaWY3OFdi?=
 =?utf-8?B?OVNrQzBVajNjSURuYmFFTklvdklDM3Y5NENkMy80aTdXUVU2WVI1aHBwNWhP?=
 =?utf-8?B?Y2NCaG5TeUlCZGRLZTdnTE13Nk5NWWgrbXAvSXdDbWE4ZTlRbCszT2o5Wk8y?=
 =?utf-8?B?YkxFNmQ5ZUNYbWxManl3VTdkWGxJa01ZK0o2d1Nxbk83bi9DZGxYK2szaXRa?=
 =?utf-8?B?aEIvVEtlL0FyMkhLV0FwdExrUzVFeEI3b1J3eGRwK0pGNi8vN01zY3lsRjBv?=
 =?utf-8?B?U2N3WmMrcnd1WTFINU1LQUxrc1VseUExajRKemt5TlAxWXo1ZWhRMkltNDIx?=
 =?utf-8?B?ZmVubUFPdFhBSWwxUXNOYS9ycXZIQ3VGa0wvUnoxOGdhemhnaVFWWElsdnJx?=
 =?utf-8?B?bWQvaWVuVk5YSWVrTWJjS3d3ZjNDU1dEQ3pwZDZLcjZmYnM1RjVCZitVWFYw?=
 =?utf-8?B?eFRPV2ZkdmFFVWZyakZabDI0M1NNTURudkc4S0hzeXJkcWgzVTFpV05CWTU2?=
 =?utf-8?B?ekxZVitaVXhHbGR5SHppRVp4Zjc3aWt1K3FreDF3ZDBscWp3TUU0bjRQaUZv?=
 =?utf-8?B?dGd0Z2l1cTgzbzA2SHJRbGJBbm9jdFN2YUJlOWh0YTY2dTF2Z0g5TUg5M3lk?=
 =?utf-8?B?bFI1dFJYZWhEbWhUbGRRNi9TU3p2Q2ZTMXdiYlBUZUtZRFZsREtGTGpMTG1B?=
 =?utf-8?B?aEkrdGhjWGZUK2tQYmNhTlJBUGltcEJHa3E0Mk5qTWNkN2NXUWJ2VUdqdkE4?=
 =?utf-8?Q?DEo27eN7auDzPBJxee4VhoylX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2617c7-6399-4b0d-074a-08dde6385046
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:39:29.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwgxPdYp2SJKuPfCETuI4Mvy9FRxP4gV6Sq2jRP7l/OTUoygch/2uxHZGc1OZ8PHUk8S2AOi9UlSo/Cj2Y2RoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

On 25/08/2025 22:39, Amery Hung wrote:
> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> pulling nonlinear xdp data. This may be useful when a driver places
> headers in fragments. When an xdp program would like to keep parsing
> packet headers using direct packet access, it can call
> bpf_xdp_pull_data() to make the header available in the linear data
> area. The kfunc can also be used to decapsulate the header in the
> nonlinear data, as currently there is no easy way to do this.

I'm currently working on a series that converts the xdp_native program
to use dynptr for accessing header data. If accepted, it should provide
better performance, since dynptr can access without copying the data.

> This patchset also tries to fix an issue in the mlx5e driver. The driver
> curretly assumes the packet layout to be unchanged after xdp program
> runs and may generate packet with corrupted data or trigger kernel warning
> if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
> bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.

Thanks for working on this!

> Tested with the added bpf selftest using bpf test_run and also on
> mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
> striding RQ will produce xdp_buff with empty linear data.
> xdp.test_xdp_native_pass_mb would fail to parse the header before this
> patchset.

I got a crash when testing this series with the xdp_dummy program from
tools/testing/selftests/net/lib/. Need to make sure we're not breaking
compatibility for programs that keep the linear part empty.

