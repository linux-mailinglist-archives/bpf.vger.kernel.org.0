Return-Path: <bpf+bounces-52592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E370BA450F0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 00:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9647B169F50
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA6233724;
	Tue, 25 Feb 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E31QG26v"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2025.outbound.protection.outlook.com [40.92.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AF25771;
	Tue, 25 Feb 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526488; cv=fail; b=XqXVbxggl8xERCHUm5Ra/Vbr+MCpoehdPlbOYakDHD7SiepMpwgmbHVRxpZKy/hqe1zu/Bf1UXWYMF/yMCVQVu+GLLovtWORei591VYyjAZzT8aC5KH4djsDxGOPCZOzHWiVg7roBy0BFLGFbMXz9lNNzqs+qLIf++kM2lsNNLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526488; c=relaxed/simple;
	bh=v2VslUzXudNfVt6Sr8+IB5HKjlsDKVaLveMwdTnSO40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOUCCRufAYiRrBGZHX3rURrfXMFmt1opl2jUmS2e20E9Je29Fb/tUICgYVmo5tYAchWPzl0WRCbqj9w/jw9X7wOmDJXfzZQvs5mLMCAK1z2bL/8DM3TEMSACLfi1UoLk1q7N4qRqpmjF+IqGPtva9bfgFb41VfVHnGI2qbTZHtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E31QG26v; arc=fail smtp.client-ip=40.92.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlS4SZSPz9vmqO1DYv7+9WVtKtEPo8NWi+x5vwKjiDC2sLAqVH+3q/HDg7gO6V8RG2v9xp01rx5p8msRn2pq48xS8oWzggqyEpgZEfo8ruET63H6JYjRqCrg/bAWOSZ8XeYQkMCYVUVpIkbn9Eck7esVIuhyQzIKq58i9xmLt7NRRakwxW/0zFG33g+iz3NxSc635EVcu7pc3eORGLhIX9K9ujAOvNOfcqczMfloNBHzuToWPCjCL1O2rIadlcv2bprqspUn+c7qdzZ18udQrBxmFTloyV6m1fhupp+UtnFta07Wba173n1FoD/ShKgkwH6Gr6Zxoqwnv0vjssnCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdBBnISJONgek03M3E8W5vpbvSn/VPguTxghQz8nsf0=;
 b=L0plbhNG9Aq8EoYx5rcEkUoS4m5noscaFAeeV2VyrDQ782U9VYb0JUEiBx0sqtCHUIiD0A66IY9m4+dMiGkjjVQ9Q9MjGIChE/ndZDyBNFpevL+mJOdd6U31Y+gsCp/8IAstl6fPkmTtEJJUDpaNjdpsFWdDZC/7PU6OoaIwi+gsKou+j61KgLOcFJgTTxi7HsSgmdKt+VPNOHZ9nf04Fb6btToca2lcs5nwqPdwKH+Gt3b9UVW+YXjpuzGJ6T55NUo+F+06kG4+O6eOZdCmqGsi1JISep3wUu49INbdDpZGJb02fR65BfVO3cOM0ZzOs1TdDnr+I/OLoVsvDRuxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdBBnISJONgek03M3E8W5vpbvSn/VPguTxghQz8nsf0=;
 b=E31QG26viQTYgv8NjP0QAgUpJ29CR0V/UVwuaI9bwAwW0bHrfYFDcC3ej3Y7zHwgA4viXHwKFuQH1VRqs+ol6Nu2dtjHzQu1VzgZiJA7c5rTTQUNS/vIjQz7nOCmQVqUtkSi36Uf94R/VV4Z6XykPHriWBWqRYrS4og4/zGc/q5RBHl0EihIqvcHJnsx1ck+WAWE0+8fSoOcPJFn58IKpOJAiNXh+FAscFTcdZseffq6vPjg0sa9qRtY0X865zoiIbs8JjSRMkAm9OsS1NsybsDugaafCR7my0QHtw7Mksy01zCQTkuiDQ+nqs3kvF9CTP9OAHBo2AQS0OS7NulRsw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6196.eurprd03.prod.outlook.com (2603:10a6:20b:15b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 23:34:44 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 23:34:43 +0000
Message-ID:
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 25 Feb 2025 23:34:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <228b5f50-2d0f-4907-9092-351cd4c19d2b@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 46472877-9b11-4496-c3f3-08dd55f4fb68
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|6090799003|15080799006|19110799003|8060799006|13041999003|440099028|3412199025|41001999003|18061999006|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVVSczEvNExIdktlVjVnbFdDQUd4TmdvS0V5VTNhanBFZWN1UnNtS0ZYWEFH?=
 =?utf-8?B?VzlFNWJ2ZWVLRlZUODJ0ZGgvN2JwQmJSR28ydXNFOWtBTk5DbHZycDEvSmtJ?=
 =?utf-8?B?V3owVnEvUkEvM2xwR3NPQmtZd05rbCtxYTVmNDRldEQyMm9uVEVyWHhEcUxS?=
 =?utf-8?B?NEdUakVWajZtMzNiUkN6TEp4SmlXTSttNUg5TzBwU0dLOXRFeFJBTzYwV0FW?=
 =?utf-8?B?b2ovYlZqd1lIOG5wa2FONmdhdit6WlQyVytxb1ZGbWNyMHhiUVEwOHJhZHdB?=
 =?utf-8?B?S2pTV3NINGZJZnNPU01qcFQwNXRlMFVNdDVwbVBZY3B2a0UwamFQVDdKS2hX?=
 =?utf-8?B?S3dnZDhXcWcvRjVPRDhWMks4dnhnWEdGNTd1Q1dlZy9IRDY2Zlg2d1kxckIy?=
 =?utf-8?B?MFZ5SjMxNXJSVVduOWc0MkdDd3p3ZFVBenZMOHdneHhtSGJhdElqME9qc0lh?=
 =?utf-8?B?MnhzaWx2ZWE3OXZkSlFVcFJseWRaK3VVZmVUOERDV2wwd3RhQ0NQcFhVaVNK?=
 =?utf-8?B?b2tmZmlPNnJvSTlZcHhYaHBDWFRhaDBZWDBraWg1NVc4YThrR0tnVU54aERs?=
 =?utf-8?B?UFoyRG4vaWMvOWpQRzVjMHZJejV6S3E5clBDVHN1U1l3QjhtQlI3NUJxU0p6?=
 =?utf-8?B?eVEybEVRdkNWZUZlZ0hxcUxmMldPSUpycTFsQS9Fd2kzOU5kcnFFeC9PTWZq?=
 =?utf-8?B?bDhTQk13aXJHUllkaDkwRkZPVHVNL0wxL1NxVmNtaFcrbldaVTNLWThCYS9P?=
 =?utf-8?B?TVJPelJlOThZVnJhODArd3VIdUpQSHlaVTBrYkpyemYvWEIxUzFGVnlnNlBW?=
 =?utf-8?B?Z0dPcFAvOE1HU1ZTRmQ4Z2tKOFFQckovRDhISXFGeEM5VmJyRWJOOFNRT1JN?=
 =?utf-8?B?K3lEcDZiSDFVMld5Qi92UDRlL2RQM3RkU2NrbXJjb2Z4NUtqTDNiRVhnVlJD?=
 =?utf-8?B?N0F1dVBZMDlSU2IwMWFQVWI3OHlzMmtMdVA4ejh5bzFTc0hsUGxXZzdsdTBO?=
 =?utf-8?B?U0FvOEk1OVphNUxqOVRocThRd3YvenlUYW9hYUVoK0t6N0hBMTlaN0lwZVVk?=
 =?utf-8?B?YkpodTR6bHZuN2Y0NSsyK0RMQ2E3NUhPdFp2bzYrallkRkJocytIWTZzcHRB?=
 =?utf-8?B?Ly9JRllLemJSQTJqeE1FOUpJdVJyYmQ4bVZVaGFJdVNDS1VYMW9TVVoyUWdC?=
 =?utf-8?B?ZDVSWDA2a2ROUDVtQXNqdEF5Y3BCOWx2dmdZOElzUGR4M25rWDNUQzlTNUt1?=
 =?utf-8?B?Zm93YkovcWNzcEtjd3RxSEVNdW16NDdQWmVScGhoUzgway9zTlZHdmE0Vy9I?=
 =?utf-8?B?NGRPU0Z3eTZJWDNYQmw3V2ppcTdvSlRweTBFV1hncWFVNTNzM2FkZE9rRDRC?=
 =?utf-8?B?NGN3U3c4Sld3UDJtTXQ5dGFacERQVFowSU9jc1FYRThlVXpNM1FrM2p0UHNO?=
 =?utf-8?B?VS8yR1F5c3BPQTBhVFNKcndNZTA4ditkam5qcFVlUWJUbUlNVHQ1N3dhanpS?=
 =?utf-8?B?ZDluN3JzemJPcGtUeGRJaUpjbm5UdjIvSllsOXoyVDYxQVAxT2U1UWR5VGU0?=
 =?utf-8?B?dE8xcmoyN2JBU3NYTkhpWmg4Q1RvOXNFczBUNithTVhiSWVYNTRoMUM0QTds?=
 =?utf-8?B?dmIxd0ZLdk51QzRYWm91Q1g4ajZBelE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVSWk42Rys3Nm5vdmxhc1p1Sk91aFFObmh5NzRGQmdQY2dRR3lCV1ZQeG1V?=
 =?utf-8?B?RDhkZ1RzditBMWh5RkF3czE4YUx6amxvb05qY3JmS2NoOGZVSFRVTnJoSnhY?=
 =?utf-8?B?YjNicG00R0ltZUJDTXRmOEVxc3ZIUkJrdCsrbkEvSHhUaDlzUks1MGM1NVdC?=
 =?utf-8?B?aHRqaGZFMWhUcktVMzFuSHNTN0tJRVBPS2tBZWxlREloV2FiMG9xLzNDQlZJ?=
 =?utf-8?B?a05TelJDeGZaMzFCb0FTdExoRXNNOHRMemRiYndaYk5pVHI2YVZFNG1tMHpF?=
 =?utf-8?B?UTJjN1JQU2c0SHcvODZ0UU1TdFQvVTRFM0lsYzRqanRUSW13NkdsTHY4VTVE?=
 =?utf-8?B?TXFwUXE3VVZQOUZyTUJyWGlUVkx2dXk2SGIvMkhHazBJYXk1dkF5WGY3WFVL?=
 =?utf-8?B?aUVMQlpURTAzRko2OUk0Yy9zZGErN1lRS3lGc3NJRjEycEkyZzUraVZTQ2du?=
 =?utf-8?B?TTdNZCt4TzkwMU5NRjh3b1QrRmZPTlphNXptWkpiWXFadjN1eEo2dUEyVkhy?=
 =?utf-8?B?Z1NoSHY2VlJrZklLUkp2aXdWb01NWGF1YnBUbitCUWZiWGVnaXFEeVlYNHRF?=
 =?utf-8?B?U1lSZUZMbHc0d0NOVVJGbm8vMmxWWGJKWnc0YXBFbnlKdkx6WlhOOE1jbmRD?=
 =?utf-8?B?ZUVaRWdJaDVVVG1FZzdkUHB1Y24rKzdsdzE3WUFIMUs4UmhPM0RuYnRaUlds?=
 =?utf-8?B?SW1Nd2JGRXFyVC9MZk9lVXVZT04vSC9ULzhCbUllU0lmSUU0Qk9NemhFME4x?=
 =?utf-8?B?anFjWTNpWnZ2WWZPY1JacFdWakNuMXUxK3R2bXVJeHhpS3JlblVuUkROeGR4?=
 =?utf-8?B?RHdQdVo3QnYzaFJRU2VpZWJJWEtnWGsxNTBENEgxaDJVYVJxWHpmdVpvVURo?=
 =?utf-8?B?Tk9zRWVtUGhESllvL3Btd08xTXJwUWd4ZDhwUmVjcG9KRGN6QnF2NmVCZVlo?=
 =?utf-8?B?bnp5ZFJ1YWR5bkVEenlBY3dQeld0TnNOUWRwamZPS0sxaUlHeFBYS2hlcGtT?=
 =?utf-8?B?UnM2YjdlYTFRK2gyNXF4TTVibHVYRVZHdnpzaUtDcmhkR3hFekJOc3BXK2FS?=
 =?utf-8?B?aFpOWUtXcFN1bXRMdWhnV1FIWTRsQ1VvcVBlRFg0ck9tVUNIQ2tGSEpIeUpq?=
 =?utf-8?B?SngrQTF4RzdRWjhGN01OZXQrcElWMHRMdlpSaFBnM1FqcHI4Wm5jeGw2REJQ?=
 =?utf-8?B?RGZCZzhteTNHTW1TRHdIMGRBZGUwTlNuMkhYdisyNXl2OHMyb0VZVnNnT2Jx?=
 =?utf-8?B?ZGFzeTBLN0lUdWR2cmNXR2cwcUY5ZHErNDRFVXpGWnR0bHhEMExHYU9JSEJW?=
 =?utf-8?B?elVjSkFRK216R2dydksvcWt5TlJXUFdUNWJ0ellFRXI2WEFGMThmaURhQmcx?=
 =?utf-8?B?bGhjdGUrT3lpVlpVRWFxYXorbXlIVHZPN3B5RytPSWtlVnVvK3hLQlVtSElK?=
 =?utf-8?B?WTJmWmNXRm1OeDZOZXk5a0tzeGdtNlE1Vm1kTVF0dm9DY3d0Q2t4QzNkMjM4?=
 =?utf-8?B?YWI0dEpVSjcxKzBIU1kvcXV0YVpRMGlVL3lEQjlnaFZXSkJ1ZGtrSzBTbk9G?=
 =?utf-8?B?QVZtYnNVeWZXZjRWcHoyTWl0VFRlNSsyWGFPYzFPYWRXVDVjUytOM2ptakFO?=
 =?utf-8?B?OVFKMk9pV2ppY1lzWUZtNE4wUTB2dFZKVEpIZUJiZzVlN1RYcFp0YmxydDJj?=
 =?utf-8?Q?LLEgoTSZd/CpsrcnE//W?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46472877-9b11-4496-c3f3-08dd55f4fb68
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 23:34:43.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6196

On 2025/2/25 22:12, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 4:36 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> +void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
>> +                              void *arg4, void *arg5, void *arg6 /* kfunc addr */)
>> +{
>> +       struct btf_struct_kfunc *struct_kfunc, dummy_key;
>> +       struct btf_struct_kfunc_tab *tab;
>> +       struct bpf_run_ctx *bpf_ctx;
>> +       struct bpf_ref_node *node;
>> +       bpf_kfunc_t kfunc;
>> +       struct btf *btf;
>> +       void *kfunc_ret;
>> +
>> +       kfunc = (bpf_kfunc_t)arg6;
>> +       kfunc_ret = kfunc(arg1, arg2, arg3, arg4, arg5);
>> +
>> +       if (!kfunc_ret)
>> +               return kfunc_ret;
>> +
>> +       bpf_ctx = current->bpf_ctx;
>> +       btf = bpf_get_btf_vmlinux();
>> +
>> +       tab = btf->acquire_kfunc_tab;
>> +       if (!tab)
>> +               return kfunc_ret;
>> +
>> +       dummy_key.kfunc_addr = (unsigned long)arg6;
>> +       struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
>> +                              sizeof(struct btf_struct_kfunc),
>> +                              btf_kfunc_addr_cmp_func);
>> +
>> +       node = list_first_entry(&bpf_ctx->free_ref_list, struct bpf_ref_node, lnode);
>> +       node->obj_addr = (unsigned long)kfunc_ret;
>> +       node->struct_btf_id = struct_kfunc->struct_btf_id;
>> +
>> +       list_del(&node->lnode);
>> +       hash_add(bpf_ctx->active_ref_list, &node->hnode, node->obj_addr);
>> +
>> +       pr_info("bpf prog acquire obj addr = %lx, btf id = %d\n",
>> +               node->obj_addr, node->struct_btf_id);
>> +       print_bpf_active_refs();
>> +
>> +       return kfunc_ret;
>> +}
>> +
>> +void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
>> +                             void *arg4, void *arg5, void *arg6 /* kfunc addr */)
>> +{
>> +       struct bpf_run_ctx *bpf_ctx;
>> +       struct bpf_ref_node *node;
>> +       bpf_kfunc_t kfunc;
>> +
>> +       kfunc = (bpf_kfunc_t)arg6;
>> +       kfunc(arg1, arg2, arg3, arg4, arg5);
>> +
>> +       bpf_ctx = current->bpf_ctx;
>> +
>> +       hash_for_each_possible(bpf_ctx->active_ref_list, node, hnode, (unsigned long)arg1) {
>> +               if (node->obj_addr == (unsigned long)arg1) {
>> +                       hash_del(&node->hnode);
>> +                       list_add(&node->lnode, &bpf_ctx->free_ref_list);
>> +
>> +                       pr_info("bpf prog release obj addr = %lx, btf id = %d\n",
>> +                               node->obj_addr, node->struct_btf_id);
>> +               }
>> +       }
>> +
>> +       print_bpf_active_refs();
>> +}
> 
> So for every acq/rel the above two function will be called
> and you call this:
> "
> perhaps we can use some low overhead runtime solution first as a
> not too bad alternative
> "
> 
> low overhead ?!
> 
> acq/rel kfuncs can be very hot.
> To the level that single atomic_inc() is a noticeable overhead.
> Doing above is an obvious no-go in any production setup.
> 
>> Before the bpf program actually runs, we can allocate the maximum
>> possible number of reference nodes to record reference information.
> 
> This is an incorrect assumption.
> Look at register_btf_id_dtor_kfuncs()
> that patch 1 is sort-of trying to reinvent.
> Acquired objects can be stashed with single xchg instruction and
> people are not happy with performance either.
> An acquire kfunc plus inlined bpf_kptr_xchg is too slow in some cases.
> A bunch of bpf progs operate under constraints where nanoseconds count.
> That's why we rely on static verification where possible.
> Everytime we introduce run-time safety checks (like bpf_arena) we
> sacrifice some use cases.
> So, no, this proposal is not a solution.

OK, I agree, if single atomic_inc() is a noticeable overhead, then any
runtime solution is not applicable.

(I had thought about using btf id as another argument to further
eliminate the O(log n) overhead of binary search, but now it is
obviously not enough)


I am not sure, BPF runtime hooks seem to be a general feature, maybe it
can be used in other scenarios?

Do you think there would be value in non-intrusive bpf program behavior
tracking if it is only enabled in certain modes?

For example, to help us debug/diagnose bpf programs.


