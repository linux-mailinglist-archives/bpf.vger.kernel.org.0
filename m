Return-Path: <bpf+bounces-49232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5EAA1586C
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 21:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2205188C3ED
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253D21A9B5A;
	Fri, 17 Jan 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mh5nzhaT"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011034.outbound.protection.outlook.com [52.103.33.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4B1A706A;
	Fri, 17 Jan 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737144567; cv=fail; b=fiwhVgUTqe/T/ClZFlNHTfrYrffFOJbnFdV/9qWmKkN3NEZwOMlNvEN/sjVHvZjjf3YG9jM09/4uJ4Kpg3CAaeKAnOJpLVp1uRQsIDb+Huu3AEiuU7U3JieOg15+RPtCPKgeRT5d2sLpQHb84LxKc23niPrO1R0Srnhmn4Nn7Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737144567; c=relaxed/simple;
	bh=oAGRguFEi8u2fDx+2nszDSq8ds/YQRYIzzcLB763auc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBxAb632h724vG+d1HxyJYYaxcbuLgbnSIXhqp7rXnxhShYMY+0BeApdyucHN/SveLgRU6V1b10yqydL2w5hq2T1CQAMMhsJI/y1BLm5A1Ggjzj6QtMyVESy4hMmMN+/Cq2gRkpWjlT1rN+Kr022k66I1hEN8wxCxeDiNHgK4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mh5nzhaT; arc=fail smtp.client-ip=52.103.33.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnKlTBqltnaUwq+cKV0Em7xyj4DtThdGi9xYnXSIDF7SAgqNE4VvwUcaNYuqnCNdqNmlWNkWLRiqjIAccZqJX931MUkJDSPkqA+AoI68i15kiwfmFiUasXKAGusyUBUvdhKc3iLQhAkYQti56M0mycj66aM0sCT2k3R/LjfjuL61yJggMoJrHCs4Zxfrkq6StscdGSShLqNwlGV2xSlfJEoJwSxw89rSSUrSP9RoEalKuHrtGYLYPAQxSr4v1ImNbOXCDJqHPiiU5V5F2qCYMRRhVeDC1+qtVmOACzKh2brE7jBzd+syLJnDv43iKnk9GyWAoCVCasOQaBHOpKa5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wdntjdKeGBhVh6ti8arZPNTAOJfZpry7w2fLGcSFdI=;
 b=yDTBNPAPN+xcrJ57gW1twJveq4i/+cyn2Om4DxgKtUsCwR+DF0NdBGeIKk5NdzqNpiFtWjC0IXs6fqiw7Pg/0pedtfJmPr7Mqw8zZMwpBHboJWBB1KDB94lSOaVIVXrI0gFIUYUyDEwndjS+frrztMILRdK4hHZrTtssOMor0WRtuhyK6TKrMmISmC74DFcVw5CVeKVd0Su0bWHe42En38EHTtcbptBQ5gSFuzNg0mTV0QrAP3U+n4whI3YIgM23ogu8FX1IhniTvFylhl2iOkJVJmaFN+jZSsaxuHKGVZ7i3YnHg7uYLZIxYzKlUPdeMX/eB0gKNowqY2xR5Kk2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wdntjdKeGBhVh6ti8arZPNTAOJfZpry7w2fLGcSFdI=;
 b=Mh5nzhaTVrQLbnd54N2UwUvN/s4Jpx/pzGHVjwK/Y3qJdRjW/CHUHvJ88nUphXlZTAUtd2ZKP/YruoWflSFam0OsZKf1TU6oe/MQiHvNGUf02RA1v+5I1h8VD5L0YrccGRjRA9iwpEYwXT3+BG4jhUZaCINvC3TkJXGaDCN8zf8FFFLuhKZm9YhqiZqsNd9siYqSiCFmls71/397lkhIDK14EiA1IhNdC+OJkWB0iynb/2D5C26DCs0DmOaPpXgPnOCetWRBdPDEveZAWglKh+mf3zU9Xj8KwrD5TUW1S4jUL+ZxSNqN0QkhSMH9L1pq2hCK3gVgJsjASyf1daZTEA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB6922.eurprd03.prod.outlook.com (2603:10a6:10:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 20:09:23 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 20:09:23 +0000
Message-ID:
 <AM6PR03MB5080A353CD7B20764053162C991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 17 Jan 2025 20:09:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, void@manifault.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z4qMOUq1KXTX-5cD@slm.duckdns.org>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z4qMOUq1KXTX-5cD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <b4efdf5a-8b51-4b82-a962-870e93cb7e12@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: c58bab69-83cd-4be9-81af-08dd3732d54a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|15080799006|6090799003|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1BuWTZjMVkvMHBxaEVLS0RLRXFnaUJiTWRkakIwT2t1dzlVSnhEcVRSMWpN?=
 =?utf-8?B?UnVTSUhjZlFLcVBuN1E4T3BQZnU5OUhGOUgzTHFqNStpb2pRaE1FMjNaaXhC?=
 =?utf-8?B?TnVsZUVxWGxzRnpORWNNdzR2Y3FaVElvTDR1aE9KdDdDcTdyV0lBMGlyemUy?=
 =?utf-8?B?UllJdEduRWpEZmNoQjVYLy92QlE4VGJ1YVA1Rlg3WjRWTVlqZTJrVXpSUFc1?=
 =?utf-8?B?TWxNZmYzbzlKQ2tHQzN1YmE2M1RBZXJxSENaRW1yU0kzVjFQck9GSVIxeGc5?=
 =?utf-8?B?ajNuaU9VQmFKMkFUR3R4eUlYU0t4VDRsaFp2Y2hOai9yYUpEK25adjJOdkJs?=
 =?utf-8?B?TC91ZTk1bS9QWmoweHAxdlhpQmxiMTFMbC81dzBoMTZWR2NsN0xza3ZoWXB3?=
 =?utf-8?B?Z3lBdkxYOUU0ZUJmbEtOdDFDdThxMUNOa0xqN0JDZDc4SkMrc3RoQ1ZQN3ls?=
 =?utf-8?B?VlhkbjQxV2J1OUlMeEo1RE53ZTN4QnBGZkRtT1JoNmo0eTh6L2xsdEROWlo5?=
 =?utf-8?B?VzMvVEFHR1BUK1FwYmxoQ2wwdWw2cG1GekdzUXk1T3dwRnc2Zjc3aVdsVzVH?=
 =?utf-8?B?WlN2QjZyU1dkNGE4cHFpNmJqOGppK1Y1T2ZKenYyUnZjdGxLWG45NExjazJ6?=
 =?utf-8?B?SHlCZTJYbHpGeTBiVExEV0pDbjRZNkZLVGl1aFVhTld1M08xV21pSVBSR0N5?=
 =?utf-8?B?d0tNK2xEQXlBQ2QxQ295VU9yVGY4MDhmYkoxV0Z3TU9LdUEvb2ZjRkp0QTVl?=
 =?utf-8?B?bVdOMkpqR1pSdUhXcldyODYvVUNZM0pjRTFSTkRtaEZNanB6UlJia0w1Skp4?=
 =?utf-8?B?QjI2MWwzZUlYZVRETmtteWZIN0N0ZVdJMEg3cXl2N2FGNm0rRG5MMVFtaTFm?=
 =?utf-8?B?UC9Oa2dMOXI4ZUJiTmlFRlFPUFBKVjIzbndXc1dtSmV4czhKMDZTc0xITjgz?=
 =?utf-8?B?ckVzcXU1bkVlSmpiVUFFZGNaa04xSnFHdDlhSlZFdlpUZVU1dzd3S0NKSldx?=
 =?utf-8?B?ZXlCeFFBL3F0eGNPYU45ZWY3Z0tkM3ZBYjE0ZSs3bG5TYURBNjhtNlF2bmhG?=
 =?utf-8?B?aWUvbEZYV1Q4c3VoeEVlRWJnWkIzSFdybGtMT3hMcmwyS3BUSGpXM09DV2ts?=
 =?utf-8?B?SFJSR0ZRdXcyTVR6OWhHbG4xQkp1SjYxeG03NW8vYy9iZmxvWkJOYklWMFVH?=
 =?utf-8?B?SHVTS2VibEFJTHUxeGhPeWgxUklITlhwMDErNExWYWhBZlVLYzNqMExOdjJl?=
 =?utf-8?B?SEduVmlVd3NLdktBdFg5M3NpM24xa3BYcVl4NXRPakZVenJTT01yZ2t3ak5Q?=
 =?utf-8?B?b2dTWmV5T0JEMHd6bUlSSXUyZXFmU1c3ZVdLM3VRck1JbU1ieDJOYThIRkFM?=
 =?utf-8?B?Z0sxbXIrdTdyRmxLb21nRkJoVlJPWXl6NDNaR044Y3VySVMwMTdhQVY1amJ2?=
 =?utf-8?B?WEx2VVcwcFhFSzc4WFArOVJvR08vVWpoeVY0T3NkR0xUcU13SEE1cFFKU1VV?=
 =?utf-8?Q?4wNu2A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUZySFROMVd0U2cyNTc3eFhzeE5NUGlhWmQybnQzUFFKMWpseGh2UzBWOEhF?=
 =?utf-8?B?RUVITVd5T1ptNVdLaHFuRlNoYmZUVmFuZ3FzeEREbm1oUFBBNHpwa2NleCtK?=
 =?utf-8?B?TXV4aDk0aHdUcXRDaXZyNzFJUjV0MDZGTWxRTDlaSE5ONzlGRStPYXRMR3RC?=
 =?utf-8?B?dEUwdFNtR0w0YkcwMGF1R3ZGV0RSQnpLUFNJcm4zbk5rRWdESXlOZk9jaEgv?=
 =?utf-8?B?V2ZrVmVMTklkNld4YzlWcTVRWWQwdTNHZi9PcFpKTHhvU3JYdWVPcWd2SkpK?=
 =?utf-8?B?ODk0Q3g0Y1Y2cVR1a3NPejRVOXpiTktSMXRkVmFlUFlxS29OTldsUktIYXBG?=
 =?utf-8?B?SHdJTmE1Z05DTXllc1BnTFJLSy84UUpBUUNURWNoRUpqcDgyRGIxMmNYN21U?=
 =?utf-8?B?Z2JJUSsvaml3Y29OYWZWam1qNTZXdFFRTTdROStXaWVqTWV3ZWxzM1FINUtE?=
 =?utf-8?B?YXhjbUtwQm5zWExtTnRUcyt0ZVl4VFBYbCtTbGRhUzJlT2hRdFU1ZUlwTVV4?=
 =?utf-8?B?dE56UkZpU2NScm1FRzNZRGRHblR1RkNBcGw3bHZRZW9oMGVkMk9DRDJ5c2py?=
 =?utf-8?B?Qy9qSDJ3cGQ4UVN1c1Z6K01QYXpuWHdXWHJDNHV4dVE0cVNLYmZtQ1RZMDFw?=
 =?utf-8?B?bHI5a0x1aUQxVEdsYjV3MFdGMnZRbXc1U1o5MllWdzhMNUdncWhGbE4rQVgw?=
 =?utf-8?B?MVozdjJGRXl3VXNEQjFDL3MyUUFxb29JbmI3Vll5NDV5SGtEOXVvVVBsbmV0?=
 =?utf-8?B?V2pGNUg2Qzkwd3hHT2NQZU9CaHU4L3pEcWJCb0pJWERlbFhhQlRDK0czNGtH?=
 =?utf-8?B?VVMxVnZPZzNGTWlhUXhRVnFiazhQN2ludEorSWUwamJldTZrSkt1YlRzREJG?=
 =?utf-8?B?SGd1SGYvTlR0dzZaeVVJQ01leThLVDUyazYrZ1pDeEFGRC94K204WGJXMmh2?=
 =?utf-8?B?K2U1VVRmTUtkOFpPSWxJSWNZbXlQeEc1U1FLd3l0OWxmdktXVXNsTVZvNTRk?=
 =?utf-8?B?aVRydTlkRmk0ekdlNG1hS1d1NnpkbWVPY1R5T3E5ZUhSSmFMN2xkTjdFL1NE?=
 =?utf-8?B?TlRzUU5pMzJZNHFxTXVqRnF2emRpWkFiUkNvTm4yUGJiWW9iRlRNdHFTT2Nw?=
 =?utf-8?B?KzlHR09iZmFDMzdwNnJ5TnEzU2VBUVluSHFHaWJSb2x2VWhaT1Q3UWJaeitI?=
 =?utf-8?B?UThHaUhpeEQzaE4xeWx1NTYzVW9ZRU0wRzlBYURCT3dPUlY3SGphUEN2eS9Y?=
 =?utf-8?B?eGtkVkEzYTdPMlNrYzZZdjk2RUdKckVJQnBIWHN0S0F2cVhqRmdFM1pmL2lw?=
 =?utf-8?B?d3MrTFFXaWgyQ1V4UmwzK21xclEzQm4zRFg2WUEzaFlua1BVLzRPNnBIQWlr?=
 =?utf-8?B?ZVhlcmNCQUlEN01PaWxOYW5SOHcvd29KRTdER0hzUG9wUVhDamloQzg1Q1ll?=
 =?utf-8?B?c0tnUzl4TGFCdmlSRm43TDJXS05ZcTJ6L1J0ZWhXREJ0OUQvc2owV0hmeFpN?=
 =?utf-8?B?emt3RjQ1R09hSitVUW03dkJkMXh5QzVpbWQxRWVYQkhpZEVrMHRTOUdtcnRS?=
 =?utf-8?B?MDZYMHE4OUZUZjBpWkpOSU9ISjk2Y0VzWjJGa2pMWGMzZ2JPZXBVOFVhdHRz?=
 =?utf-8?B?eXlYSWVPZy81cGhLZkJReEhoL1hHZEF6UTlPTHBhUWhCZ25GNkNNMGV6UWNT?=
 =?utf-8?Q?JT8iJypQEGRa6rjbW0Ty?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58bab69-83cd-4be9-81af-08dd3732d54a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 20:09:22.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6922

On 2025/1/17 16:58, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 16, 2025 at 07:41:11PM +0000, Juntong Deng wrote:
> ...
>> +static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabilities,
>> +					   u32 context_info, bool enter)
>> +{
>> +	if (enter) {
>> +		switch (context_info) {
>> +		case offsetof(struct sched_ext_ops, select_cpu):
>> +			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
>> +			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +			break;
> ...
>> +		}
>> +	} else {
>> +		switch (context_info) {
>> +		case offsetof(struct sched_ext_ops, select_cpu):
>> +			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
>> +			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +			break;
> ...
>> +	}
>> +	return 0;
>> +}
> 
>  From sched_ext's POV, this, or whatever works is fine but I have some basic
> comments:
> 
> - The caps are u32. If all kfuncs use this facility for access control, it's
>    plausible or even likely that 32 is not going to be enough. I suppose it
>    can be turned into u64 and then a proper bitmap later? Maybe good idea to
>    start out with a proper bitmap in the first place?
> 

Thanks for your reply.

I considered this, and 32 capabilities is definitely not enough.

So although in BTF_ID_FLAGS the capability is 32 bits, this is used as
an index and a bitmap is used in struct bpf_verifier_env.

We can have UINT_MAX quantity capability.

> - There are benefits to centralizing all the caps in a single place but it
>    can also be kinda cumbersome.
> 

Yes, I agree, maybe centralized declarations are cumbersome.

But the purpose of centralized declaration is to give each capability a
unique number for distinction.

I am not sure there is a non-centralized declarative way to do this.

Do you have any suggested approach?

> - Even with global defs, the cap adjustments are procedural, not
>    declarative. If it needs to be procedural anyway, I wonder whether the
>    global defs are necessary in the first place. What prevents implementing
>    it the other way around - pass in the calling context and provide helpers
>    and macros to respond yay or nay procedurally.
> 

You are right!

Thanks for pointing this out!

If it is procedural, then global definitions are really not necessary.

I will rethink this.

> Thanks.
> 


