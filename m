Return-Path: <bpf+bounces-38316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7AC96317E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1661C21C6F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB01AC882;
	Wed, 28 Aug 2024 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p5nR5SxE"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011077.outbound.protection.outlook.com [52.103.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E11A7ADD;
	Wed, 28 Aug 2024 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875962; cv=fail; b=SCslxgbm+JCr2/FgpXCTziK/Lbw0NRQYplmEucs5R2aWiRdsbxMpl7LEvdW0QVtTL0YMNefGbIbGnxt+cnjjfju4NL30yWd554a8C/Xnu+y+AwU474xSJSMkP7g8maUuW+fakOsyN1H1m/ARP1cogQPacZynw4AGrZDcnmYXaHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875962; c=relaxed/simple;
	bh=5uJRJXrWTA2cc2nuSgiwj9l5rMzI8ZvWe46+Sp8Djjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aEoBjASlTlWtnkSiNaNHGUO+r6nh0pYx3AAoY+A1I77a7dpoSQrTo8v0kiqV8LwmD1UiNsZQZboBrJhvV4D3fsi283ciZx4hWf30IKTFWlhbgqfP7rV99XwpCr0lslStlOi9CvuMghd/hdoOo//2b0ULiMcMZBIaF+71lWk9e3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p5nR5SxE; arc=fail smtp.client-ip=52.103.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvS2PxrkLP1s0TaLBC+zOxuuOl7GCZBgf/M//FxZABZtkm7QNqALSo1jhy2FfrN4FulDe04LNp75MZoypw51UBdE55Cm4v9CfEjZbwODODZemb+NWuPv5d8ocV8Ck0cXHtTwN3vtqpzx1dXOkVLW2NKIzXvx60cgYwoYw7WQTJDn+CgescD8wUDLHVJZbaxtkiWtF1g0BWXWL5DGMmUM3EUjFJW/sHvAZAOEj7tFTJr2RkANQ7UhocUDRpoiWjotjBmddtywwlMyBMff0Ql7MSWl5O+I655WrYvHU8y6bBRcMMc8ST8ELdFbsEDTIFBf54meiVczod3mQonHVpm9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoF9+wvVTSN+C3/jESYwKa8ba4J4KmB3fEVoUAxXEo0=;
 b=X2OAKdNHCceT+OGtMX2pGBsVDcOUi16O613npkoju55zYTMy4jyTR0e1HNbIXcMVvrTbt4M8dmtA+OzW4rYczqK1cxeNufxyg23R5WWahTsZfyylq+MywUtl9iaUOHhsYDgXz2IYl8mjB+gtITCGeVAgjQ/q9zRnGAuwH4rADltiecy5RgF0H1BKGI9FkxDH42udb1Kv1H8P8pQSzV1Rj0cvm/3byWHZlS/S7is19qARZEFnbF0f6pagsvUtG6npLMEhzz6vxathC0EusuMQkjcvTLX+w+nOJkwcfitqc1H0Lm9PjWhel679JqnwWxWpj5URl92AEoS5gGkTtrbKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoF9+wvVTSN+C3/jESYwKa8ba4J4KmB3fEVoUAxXEo0=;
 b=p5nR5SxEDaqh9df9G05PL6ICRGDfAw3GC35O4Na110j07CHNnsuuPRP/Sf77wjcGLbIE+GUCIkJZ0MyOaqAXx3zgc02pwDsN4Gr75pId5CEM/wBHK3uBi403mHCvr6NDQJ30QL4RmnCon3j6Yx4rX+gTCFxE96s7IvuDD3TYLUtlFXF0/cwNnejoxdO+lQZl41A0qDA8P6LZlVRDss2PqaNLT8c2kdT+sL0vG+PidM1sLA/qrqC7xChi6+cI0bC32b797MgYcLVSjiEY2IK4sv52hz7BB+eunwft8145SGF6oWOglJ+A+M0Le0ZM2KUu38x5+w+LrTzi7AROX/O94g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI0PR03MB10807.eurprd03.prod.outlook.com (2603:10a6:800:26a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 20:12:36 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 20:12:36 +0000
Message-ID:
 <AM6PR03MB5848BEDEF27DB0203C094AF299952@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 28 Aug 2024 21:12:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Relax KF_ACQUIRE kfuncs strict type
 matching constraint on non-zero offset pointers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQ+wbFj7-s-VH=bx2MVbWJ5ea_2xdzY-mDKss1m146Ux1A@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+wbFj7-s-VH=bx2MVbWJ5ea_2xdzY-mDKss1m146Ux1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [asHjklo3uRDS4u1wxW/BcJhA/gL435Lr]
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <565ff073-bb35-4b36-bd6f-936034e794c1@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI0PR03MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 154ff8b5-5ebe-4a87-9e34-08dcc79dc207
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|8060799006|461199028|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	UG40mX6L2g8yQceuoVQKCGg9KCDhvRaz3T8qOZuzn466lL+N0MfxWfU9Gdf1hL202lpcXNZf3PgcUv1NOKJEXzBKavCzM3LV9FAf88QpHADKF+rIu3Bs0nZU/Lrdmt1WwBysk3RbTLGh+43HI2nNSTvyJS38Mz8bsQ2z3YLtbfEND0agCcDT0CbPepgWdA8HVnR+qB8tnQLMNIWYkfCyTlSiR8wHWCsBxlvxNNl+mVAoNscUCzPApN3li0MXi8zsRg1vwJcXcGBQxYC+dnGqfLHF2VcPgGNSu1I41kn77VR+BOqFUUy9TDRk0geNPGefXd61Zmipa4NQu+/IUMcG4tVKgD8jAcj959+Cwc0m16hNdGsTKcyFxIC/qz1LqVudzXf8o6nDdvfbKmGvmoYjhQhy/vBDyMvMr8sKIWOJ4Zl/djTZCLfm3IWyPruIKmEBSEm/re5n+k6Gi6kceBNDU889iWUIdTqH3OVnHb3KJJ2GP6DXtZr1Bcx6eLebtfCgXzYiIxEmDWDmeqCQeHHmO6m4EIFC2NIAOZsaH4bBCiPUBGp2UduS/hXJulv5CB801vnCj30TpfodgEauwoZUE6i3q6aPzUUwapV44cylpGwZgwcXvNMrI24W8ucQluQ4iOHcrRb5MuWWoqFpOvyiK2LUZXajswlfYbW0utvSEInhCEJZQgpK4XfIRd/+97eRuHTeGg2L6nm2KnhfCIKw/iaCchonTuT7Mn0+02WFZ2YyKNAsn1CuD5bDQvBJ3ThIybK3rLmwT0bhyS3N8JuGWARxYHvs4GHIdcJPOods5WE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHo1K0VRV1lTZnZJa3h4TWdRVHMzbXlXQUFLc05FNDlkWldjOHMzRHhEUDR2?=
 =?utf-8?B?WFVCTDFoMEJiOGRpdjRRMy9DVEVJMC9YWEU2MEhONFkxQTVxL3RYZ1FjQ3Yr?=
 =?utf-8?B?Q2NnV2JubVViOTRyaGpCNUdnZXo3bFVUR3JlUVpGYlk2VEIxTVdGUUE5ZXha?=
 =?utf-8?B?RWgxYktuamJvbnFucHhLOEpLekJkN3BHRk0yR3BOMnFZUGpKczFSWlJhUlE2?=
 =?utf-8?B?WE9RQW5EbmtDVXUyQjVYQUsyVktVamErVEZpdWZGS1NvWXU2TG4raVNZTkpJ?=
 =?utf-8?B?UTFyTlUyRzdDcE0vb29LQ3hqWWtLWlRLaUs2TjdQU0N3dk16eVJuektDKzkx?=
 =?utf-8?B?Ly9XVTBrNmRDL2gzd3BjK0VYb3Z3OFNpV3RJaG9yT3Nsd1BGbTNTMVNkY0lw?=
 =?utf-8?B?Q3NBUDcwWHVJS2RuaVZhWU9Ma1NPcmlDTXhVOEFHTDJtY1F4ZG1QY2VneXpS?=
 =?utf-8?B?TnpZYkd3aUhCQzE0VEU4Slc4U2RESGkzZDBIQWJ6V0NPQVE3SzJSOWpKUHR5?=
 =?utf-8?B?UnBFeWsvL1ZkSllGNDUwN0VYczNWTjl6M1FUSXVFL3h1VEEzTURrMnNWbEo3?=
 =?utf-8?B?Mmk1MWJFaXNndEExbWVZNStxTGNPbFFZZU5XeFZvWnMwNjlIYjYvQjF6UElm?=
 =?utf-8?B?Mi9pT0FZNFpyK3hWZDdKcER3TGZZREVPSGF2WnJvMktCTUNXenRTUVlpekwz?=
 =?utf-8?B?aVk1Z05MQ2UzT2NVaWxCSzR6ejF1YzNtU1ZMR3FkQjYrZVpFWnJwKzQrc2pK?=
 =?utf-8?B?R0c5UEl2L1dFTjRaMFhmK0JnaXZzbWFWTmdLY1JZdHhqcloxR0k4eUxUQkN4?=
 =?utf-8?B?c2xpaGtLZXIyQ2o1NGFuUzFjTVZjcVh0V2JrTUJwZkN3ZHRTMjd6UGlsTlVP?=
 =?utf-8?B?WStBYWFVb2pYOUx2aEJxbGQ1anN5THUvY0hqbDYxV0lsOXBsTnBydjdMT2F1?=
 =?utf-8?B?emFiNU9GTnhRMDNQbFRxZVhCM214dWQxbGJyV3A3eXF1eEZEZHphQWJRejNq?=
 =?utf-8?B?UzRPVUxmS0tJaVo5bnhKY1lXckcrV1o2NFlLaEUrbmRVRHY4aTlQZEhxRXdy?=
 =?utf-8?B?bHg4bTdDSnJTaFQwWkYwZ2dYWE1ZQlB6MEI5NnViV2dTNnorM3FTcHQwL0R1?=
 =?utf-8?B?RlQ2TWg5MVZ0QzJ6RGFEMXE4eTN5OTZBQ1JmWVZXZklqalZpaHF6ZWIwMk9C?=
 =?utf-8?B?VWJ5aHVtRjQwbS9xOFpBUjVYOXAwNk5EV2N2em5mYm9Eam1YczVKdFNkamN0?=
 =?utf-8?B?L1dCZ2hrdU95d0xhcnVScnJzNXNBT3E0YXpKT201ZGhTZVZXbEljVnpPWVdJ?=
 =?utf-8?B?ZkxhcWxORVRwUStMRGloUERaemR4TUl1Q3dWYVI1ZGhOV0EyVm5OWFVRSWdY?=
 =?utf-8?B?M1ZNR3VTKzM5NTVjN3RyNjkrcWxHL3paWnNTUGlBaktEMHR6V2J5blBVcWhK?=
 =?utf-8?B?NDVhcE0vSENTZGZSNTRjRTFJdXFVd2k5MnlLNHROV0ZibTNrMTEzUFB0OFVF?=
 =?utf-8?B?YjNHT1hCREFPc2dtSXdMcDJVc0ovbGlCWENUVlhZcGIrSURXenhZWjBHS0hI?=
 =?utf-8?B?ZzlROWFlTVZoVlZkSkdvd25xanVVN2gvbzNRb21sajl1cUhOa0pGUUxKZGZF?=
 =?utf-8?B?VWNnL1Jka1I1U2twaGwzdU12MmN1R3A2Q2hmZkpzbGdHQ0JoTm9kbWtpTkNa?=
 =?utf-8?Q?/8UAOOH0aVr8/hH4Z4eL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154ff8b5-5ebe-4a87-9e34-08dcc79dc207
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:12:36.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10807

On 8/21/24 19:02, Alexei Starovoitov wrote:
> On Fri, Aug 16, 2024 at 6:24 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently the non-zero offset pointer constraint for KF_TRUSTED_ARGS
>> kfuncs has been relaxed in commit 605c96997d89 ("bpf: relax zero fixed
>> offset constraint on KF_TRUSTED_ARGS/KF_RCU"), which means that non-zero
>> offset does not affect whether a pointer is valid.
>>
>> But currently we still cannot pass non-zero offset pointers to
>> KF_ACQUIRE kfuncs. This is because KF_ACQUIRE kfuncs requires strict
>> type matching, but non-zero offset does not change the type of pointer,
>> which causes the ebpf program to be rejected by the verifier.
>>
>> This can cause some problems, one example is that bpf_skb_peek_tail
>> kfunc [0] cannot be implemented by just passing in non-zero offset
>> pointers.
>>
>> This patch makes KF_ACQUIRE kfuncs not require strict type matching
>> on non-zero offset pointers.
>>
>> [0]: https://lore.kernel.org/bpf/AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/bpf/verifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ebec74c28ae3..3a14002d24a0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11484,7 +11484,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
>>           * btf_struct_ids_match() to walk the struct at the 0th offset, and
>>           * resolve types.
>>           */
>> -       if (is_kfunc_acquire(meta) ||
>> +       if ((is_kfunc_acquire(meta) && !reg->off) ||
> 
> Agree that relaxing is fine and calling acquire kfunc like:
>    bpf_kfunc_nested_acquire_test(&sk->sk_write_queue);
> 
> should be allowed,
> but above check is strange, since
> if offsetof(&sk_write_queue) == 0
> it will disallow calling a kfunc.
> I mean if the field is the first in the outer struct this
> condition will force strict type match which will fail, right?
> 
> So should we remove the above is_kfunc_acquire() check instead?
> 
> pw-bot: cr

I agree that if strict type matching is not required for both zero
offset and non-zero pointers, then we can remove the strict type
matching for KF_ACQUIRE kfuncs.

I sent the version 2 patch set:
https://lore.kernel.org/bpf/AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com/T/#t

