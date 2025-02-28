Return-Path: <bpf+bounces-52888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7DA4A1DD
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485EF1769D5
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E627CCC3;
	Fri, 28 Feb 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XTeC9UQ5"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2041.outbound.protection.outlook.com [40.92.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCB27CCDB;
	Fri, 28 Feb 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768142; cv=fail; b=L9cv9myLagAvAExaaMblKToqdzjRAnFCblfqmKDgAZhw224xy8p8Vmge9yr1b+9lP9McnUhgHNpkOxGWH/q2ZXAG6UVZEjmDpaXHjnztvRKOC+jAtLzP0mqGKIw3MYaQSuXvVDrWsNMN/IqdVd4xl0BMTAQY8ICI/QrQzvaf8Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768142; c=relaxed/simple;
	bh=IYU4yNWQJxcSc4IimLjyVImt8pFgPppWslmXSQefWBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LgxgntbHIpNDQ0b0jHquNzq4WOqG1MwEfOYIVukk9JkizNrLNDoqYtPi1KVUtH9+5VQsm9tPrC/zW7Xp0x35iAmY7HPlNJTHiCcguXfi7hv0guUzmFMOpTrp17TconjZVGIeX1XAKB1EmO2fmjjRaQPMT8RZyRBYmvni0bnRfQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XTeC9UQ5; arc=fail smtp.client-ip=40.92.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMfQIuePcZnuZpxlmpn2U0w2AtU+bhB8nspizlqx5O1smqUCDkpXcWi1zW8zWIIPPP44+Di4PdAUcZiRH6IMnvUAq/mersUkdNVMPhZawADqg/xJIozo8niARxwG16NFGlozXqk7y/LT7X062v5VDTMVbaI6lLMMbXU34G2+fE6Y0F55qmxqhV/Zc8rVYJiVkziI/eiUsf5+hZnCA4HHZpe53gnQtryAIdKoNZTkw0AyxI3s8AYF5JXFo6eAB2vcxu8Zg+kDtL1jLYQGAHswg3tP0Z5Upv2OwF62vPNL2rrASh/D+zPnPpm4Wvdwhf1vKMZF8pfE1wRuVe0HRqpQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j//WSvoHlwFDBVHuBSxoitbu+/WgacDrwMids6Oqmu4=;
 b=c11KNNMAzS7u3ks7Z385NWluvCXjDxu7pA/zwxMWvplKGXFkSSmxYvCZMKFN2J55fpFJVSQFe7lxF8SqKkx/uuZuJZnESvj8SdkgKvcpXC+yf77nT4EM61lJBgTlqgffsN/Kc5c+Ek5aen7f9Eaki78LpyKDAGD4S4Od3tVgTzu6Qz9FpPanFGEyriCljMgkto2ih528oRSVcHD3+oyApuiWY6ItmL/NMVC0f0vqlbTzNHXt7QdNhS09/2jV36If52sNxddKukG/lmcAkhmWnMkvuZB9TfvulxSwGBgSiydS/1za0oHS4OOqv+oizIOLiL3c3DjkRCykjCiBPneUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j//WSvoHlwFDBVHuBSxoitbu+/WgacDrwMids6Oqmu4=;
 b=XTeC9UQ5ElNuZRfvZ96iRSdHYiQcKn5AqtO3t0jlbcckk4zQjAEJ0qTmdS3KcEcuerZIjLlr4uyxPWxsC3LmlGsYP3ytnPTlgLdf7zmvJGHd5O9bxzw/MOYFAei6JMmMQeKCSyKl/SUNw8KRK3L8yAwaZWrXVRtktB2QUO1hVBtxdM8pSTR57omlemlh7sK0X7pvMVcDJF/NAquUcgqVpVfnWqVnKcrNu5zakpb/mZljp9XMhf9Mn/fw0pdCSrvj6Q7rUpXYZyhToBS1QiOJ8IHKE0NXLrTR3FdTeHPJRLWMxQE+ypBXzV022nfWDnKF/4YHSHlONZw7cDyigfkC1Q==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6469.eurprd03.prod.outlook.com (2603:10a6:10:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 18:42:17 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 18:42:17 +0000
Message-ID:
 <AM6PR03MB50809C9EB32C9705DF6EA14299CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 28 Feb 2025 18:42:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::25) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <3d1fa4de-f11f-4dd3-947b-078ccf20ea71@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 901536d7-c24d-4cc3-9a07-08dd58279f60
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|5072599009|19110799003|6090799003|56899033|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9GbHg5N2JaRG9UbmQ1aEJTWlNwenFsMnU0N2N1SHgvWEFleGtyTVpicWZ5?=
 =?utf-8?B?d1VITzYvcFlxUHJkSytvenN0eGl5bGJPR2hhYlNqZXJyY2lnN1I2ZDZnVFY2?=
 =?utf-8?B?d3FQWHRUcVVkV3lFY2l6VGpvUklQMnBPZjlHUGd5dmFYZVdtczRzcCszcmpV?=
 =?utf-8?B?THFzZm9VcFZQLzVxblk2OWJYcmVEcGNCSEtmK3JEc0xNN2kzWHdRN0MwaUNx?=
 =?utf-8?B?ZmpqVnViWkVWbWZCdTlsdUthaWYxUGxjNnBac2VUQ2NDc0wzWGRBVHBIaXdL?=
 =?utf-8?B?UjRSQjErK3k3aHZMbmgvNEJKT1JXL3JNN0lNZ2hwVXpPRlEwL2Q2VW5DT3M5?=
 =?utf-8?B?dmNxdkZnS2NVamh0L0lRK3Z5S2ZoZ3ZmRGFyUzdDQnhlSWZQYWFrajVhM2Mw?=
 =?utf-8?B?Nk9sMEFUQndxUmRnV2lJYW5hWGFWWElqSW8vVXlNYzVXVG1IK0ZsNnk1NGN4?=
 =?utf-8?B?VzFmU1VISEpVakJteDhBaXQvZGUwSDlVeUdpM1hsL3FjbFdBNTZEcHBHYXdV?=
 =?utf-8?B?MGl0eHJzajc4Y1hFSHZiV0lFcmhUMFVNNEtITUdNeFE0YWFXckNhOExUS0VB?=
 =?utf-8?B?d1VDVGRsakxHVGlTcU5ES1Q3U0ZXaWtQNkdhSWhmSVAyWDZPenZ5MlVSS1A3?=
 =?utf-8?B?L1JGRlBnRzl1SWEzTnhBckw0TFJhcjRGNk9sU05oc3dESTVPN0RjbGpGYlk2?=
 =?utf-8?B?eDJrdjR4N2ppd0lDUmkrL3FISEJXNG5JVWFrbXhVcU1COXBtTm80U2txSVAz?=
 =?utf-8?B?eEVEVkNnNzliMFZYZG1NSXN3cHFYa1RuZEpwSmFUZ2hJZUVjbVdkczA5cDVV?=
 =?utf-8?B?SDErSkF6MzZLQngrVGdwR3A4TlY2d1JNNkJqblhSQTNBaGVZQkNlK3hFVWRR?=
 =?utf-8?B?bHBSVE5wT2dnSXMxbEhPQloxQ050S3R6TGI4S2RPajk5VFpna01iQ0wxYURr?=
 =?utf-8?B?UnphZGpYcm94VnUrTnZ5WCt0c2tiZGhENVdWKy9QV0Z1YThSWng4azczMkpP?=
 =?utf-8?B?KzlDMVFHTGNBTitnYk5BODBsWUVzRjdFY1krOGlZbjA4dlJkUUZDSFVtUlRH?=
 =?utf-8?B?Sm1IUEhXcnU0dTZRNC9kNmplVHg0Z2ZNNkRnaW9MaituaHRud25aWldUNGVV?=
 =?utf-8?B?bGVUYnpCNlN2RDk0Q0x6dmxQNFpiSkRTbHJ4bWt2Q25RVTFJeWlTcFVJb0FY?=
 =?utf-8?B?OVpCZFdpWEtJQ01JeUJ4YUhNY1VobkJRUVp3MTNDRFFBZlFuK3BRNTVHZndr?=
 =?utf-8?B?UE5leGdLRCtWMWgveHdWQ2wxM085VmhkQVRZcldVNnZXTkErdWRzZS9zcVli?=
 =?utf-8?B?UlhZcUJZZ1ZEdDZ2N01nVi9ibTlFY0VlZkFGcVdhdjFoeGd6RUJsaVdkQzh6?=
 =?utf-8?B?NVJrbXdtcTlmSjJsaUhhUGRoSVVEWkpPS2liRmtQR1ZKNmRNNiswOVkwNXo2?=
 =?utf-8?B?YzFvY1VIOGRZQVREK3Znam10bFNlRHVFOVRFb1ZxRkQwaHBmSlZZY1FoTStS?=
 =?utf-8?Q?g0alqM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZzWUp2ZmZrWkF5UlREUG11bmN0UGRZTU5pMzRyUTZXL1FvblpUWFVXcGpm?=
 =?utf-8?B?dk43VlZaNkIyV2UrV0FyNWh2V0FNWldZZDVvUjlVSUpteW1oRXlhRUNMN3JB?=
 =?utf-8?B?V0F6YTZBTm9MTWFNR1Z5OU9ZaVF5d1VrNGtJRlVNdkpGZ3V0R0JQK3VOV2NP?=
 =?utf-8?B?S25Bc2tJckxYWjhXSXVIMXNpeE9YZytUL2U3M1BTSUQvelQ2ZndvRG1raStv?=
 =?utf-8?B?MTVEWEpBUTcxU1VkMS9HN2FsRnBtNWt2bTdlTHRVN09BSVhVS3BzNFhETXcr?=
 =?utf-8?B?QW5VMHRKR1pBYjRJQllTN3drejBwUFROcW1VVms1R0hZWmF0ZmN5RVNkL1pv?=
 =?utf-8?B?RzlRWi9QYTc0WWZXYXZlWnNxejJvRVJKbG9Gd3F3TlFzdzBqOWZtdU82ZnB1?=
 =?utf-8?B?MU1FQWwxRzdPcXkzQ1IwK2dwTzd3QkdyUTJjYlQ2M2RBWmdXdjBzRW9peEov?=
 =?utf-8?B?Wmp5VUVzZ1J2VHBuZlpmR3VCTWdCTVhkUEkyZ0lmam9BQ1lzd1gwTkNFNVpH?=
 =?utf-8?B?SUVDcHMvM1JJSkNBd1B2Q245cGNVRnJDU015QWZ3SW4rZ2Z6eWlwdm8zbG84?=
 =?utf-8?B?RWgvYTNRRFhMamRvRXhLMERhSEJRN0lHS1FzU1lnY0NnbjlrUkJnWURhMEE5?=
 =?utf-8?B?RnA3MWtldDhTM2NNMWk0YTJOSm1SNnd4OEJQVm8zRnJ0cThsNEJPcFYwM2Zo?=
 =?utf-8?B?U3htaTNaVXllN0NlK1NtOXBpdzRBNVpwRHA0TzdlK2kxaUc5S0IrR3Y2Z09F?=
 =?utf-8?B?VTBoRjBzbkRLRG1wV2hxdEV2bGdtU01hN1AzblBGN2tmTUcva1NOYit4eUpB?=
 =?utf-8?B?VFpvVHZmeUdwN0p3clo3S0pwUWdqaVRXQTNRc1IySEluZnZTVFAyeVY5cGFz?=
 =?utf-8?B?V3JSNldvaW5Md1gwWkkyUGh1YkJaalVhN0YwNTkyazVhTFREZEk2ZlBtNzUv?=
 =?utf-8?B?cXpTWWFmaWRFaEJmVkRiamNXTzZKWTN5QVRmeUFLTGgrZVk3WmJlb0hwampw?=
 =?utf-8?B?K0V2UGZLU2Z0RzNrRzlid25UUVA4SnhwaHR6aFVqYURNOS9iRStpU0JGTE8y?=
 =?utf-8?B?Wm9LdFo5cUVUTnk4cEJrN3NKTkJCRVdjTkptYWNHSk9TT0gxTURCWnpWNVgz?=
 =?utf-8?B?cml3THIrL2ZYRnlZNTV2NlJDODBkMEcvQkM3YUJUNktadjNWcnJnYllRRnBS?=
 =?utf-8?B?VE12RjJ4alBJR09ydGFnak9oOHFvb0pxVkhSOG1GbkczYmdWcWpKaWZSOFRN?=
 =?utf-8?B?MGtQMDBvajRPYzRhMTAzMVYxdUxoN1FJY3l3eUZyZzRpWTJ1VHFZUWJXM0Jp?=
 =?utf-8?B?aDZ2dUFNNC9LbkJyZUNJeUEycVdEUVJSbWtZY1ZaRnFQbGlvYi85aWpxRzZY?=
 =?utf-8?B?OE1ER092allKVVVjZ1NhWDJyZk1pYmNTblhnME1laVBuQW05SUUvODd4VktX?=
 =?utf-8?B?bEZjeGdzV1F4YWRhTHJzbEFySWRVcnp6UWN5Rmx3aWRpU2o5d20zMWZUNkxs?=
 =?utf-8?B?aDc3MVM4dzNsbDhlay93ZkVCZ0w4ck90bkpGeFovcmJRSTBOdWwvanF2NmlP?=
 =?utf-8?B?Z0tGL1RkK0E5U29hRExCTExPZlI4anFEOVV2MEVXdVpXMitJcHdxMHh6cjVU?=
 =?utf-8?B?b2pZUDNuNGI5RUtTWnpRZlRBZTJEM1NrVzQvaTAyclRlVFBvK21kLzdBWVoz?=
 =?utf-8?Q?mbe67uAZ6w4YmmuxtqVO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901536d7-c24d-4cc3-9a07-08dd58279f60
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:42:17.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6469

On 2025/2/27 21:32, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 27, 2025 at 09:23:20PM +0000, Juntong Deng wrote:
>>>> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
>>>> +	    prog->aux->st_ops != &bpf_sched_ext_ops)
>>>> +		return 0;
>>>
>>> Why can't other struct_ops progs call scx_kfunc_ids_unlocked kfuncs?
>>>
>>
>> Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
>> called by other struct_ops programs.
> 
> Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g.
> scx_bpf_dsq_insert()?
> 

For other struct_ops programs, yes, in the current logic,
when prog->aux->st_ops != &bpf_sched_ext_ops, all calls are allowed.

This may seem a bit weird, but the reason I did it is that in other
struct_ops programs, the meaning of member_off changes, so the logic
that follows makes no sense at all.

Of course, we can change this, and ideally there would be some groupings
(kfunc id set) that declare which kfunc can be called by other
struct_ops programs and which cannot.

>>>> +	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
>>>> +
>>>> +	moff = prog->aux->attach_st_ops_member_off;
>>>> +	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
>>>> +
>>>> +	if ((flags & SCX_OPS_KF_UNLOCKED) &&
>>>> +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>>>> +		return 0;
>>>
>>> Wouldn't this disallow e.g. ops.dispatch() from calling scx_dsq_move()?
>>>
>>
>> No, because
>>
>>>> [SCX_OP_IDX(dispatch)] = SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,
>>
>> Therefore, kfuncs (scx_bpf_dsq_move_*) in scx_kfunc_ids_dispatch can be
>> called in the dispatch context.
> 
> I see, scx_dsq_move_*() are in both groups, so it should be fine. I'm not
> fully sure the groupings are the actually implemented filtering are in sync.
> They are intended to be but the grouping didn't really matter in the
> previous implementation. So, they need to be carefully audited.
> 

After you audit the current groupings of scx kfuncs, please tell me how
you would like to change the current groupings.

>>> Have you tested that the before and after behaviors match?
>>
>> I tested the programs in tools/testing/selftests/sched_ext and
>> tools/sched_ext and all worked fine.
>>
>> If there are other cases that are not covered, we may need to add new
>> test cases.
> 
> Right, the coverage there isn't perfect. Testing all conditions would be too
> much but it'd be nice to have a test case which at least confirms that all
> allowed cases verify successfully.
> 

Yes, we can add a simple test case for each operation that is not
SCX_OPS_KF_ANY.

> Thanks.
> 


