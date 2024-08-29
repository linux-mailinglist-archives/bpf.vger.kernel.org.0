Return-Path: <bpf+bounces-38387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32796424B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83ED7281CE7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66418FC7E;
	Thu, 29 Aug 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y1vA5rLr"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2056.outbound.protection.outlook.com [40.92.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB418FC72;
	Thu, 29 Aug 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928781; cv=fail; b=NgZl9dviT4+d2mrBVkYab/gMagrOlONRYeJDpXaPE5lTOn3Gmi04hEK1Jhc4Ica3XT8RjUKbjjioXCCnZnrN7Asa/TSk/zEOLSMvozvXwtZjK4OGeR0CKkFLX14VykwhySQ4mgmmVw9P1WK/Maapzv3lEAANAeoJGNcBO9kTsP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928781; c=relaxed/simple;
	bh=nCKTRGMn4renIxCrfL63fEkoB85zPHnh3+Dnl6uj0ZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbKuFTyZ4Qeuo4hKo3gVfHVZuH6Kg7DDtqiviVIhMnrMZmuqBTEzHEKidlWa98jfERLgOyWfYaNuJTobKS6VpaTlRDD0nrv/g2bSnjZfcDreUwcy64Ximiu0w5E6/Vcr4aYFcEbJx7NathfbpsujS/R9BoNJzq0BEpVF86puhyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y1vA5rLr; arc=fail smtp.client-ip=40.92.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLxJfcWNjhWPyDGCB+GZV3iatPXyEGs1LFmiLknvFEJ+ZAiB2GubhhQ2JzUHcAlDOKXRFtFquIGdMGOJzlrQ2UcrJZqzZI5BnAvcAxg8KjHECCHa72aDnHSB67s4ypOR6aGXlPKB1anQNSG5wD1a7AqBNrbRpXhrKPlV0ilCkK5f+rH4e15VW1seX9iC5o4p7vWkEB9r8CE/BRqDfsJsiZmNBsn0PQpSbGqeRdMIkRCZ4+XGQDxo6bTHvykRw9zidOC4q2TrJDojcQm9Kdks5cUPwd+5JHctin+jJNDV5KfL7pwBcsfd3kkLdZRXruBhWTvmIj1iyP80hwJvTpWgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9MRBL0U/ikibt7FdXKhMImtzKnwglIAtb9N0Xya4vw=;
 b=YYDbOZVNW82fUkes7UdepKkVnhZJJ3GIGYYU3jYVPISgs6y4bKyNChREwUnfrn2l0/feevLQoPfKHk1E7xqBkTqNpTtrHshiFqtpANiWdSWNlzacI0uTCjGAckNX/en2TicdhpajhnLgKZm0QQSFvff21f2is+eGdFeY0FOZFMEZXyY0+i4mc/Z2U8UgEkwAgtyaRGj0zzFB4X1GEc5s381hR6KJWnUAMgfzkiY9THLIEQ6ibRLMX7rbTpHqcPQwy/5ZO1jMM0HWKI4xWChGM2tm79EtC9oVhwQNcTIv73D2M0a4576scEmw5NRj+/ak9zNwI6Sy7h5h1ZhlzeSCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9MRBL0U/ikibt7FdXKhMImtzKnwglIAtb9N0Xya4vw=;
 b=Y1vA5rLrT52QVnFKVhNMGgJ6oUxpSfBV0ogURPUCGyJPGVE9hN4JlcbRsjB395L/AnqfAwsn4HgxC9fYHGLFHFBHz1rG1Vd3tBw9hyi7saUkW/4bVM0JxgVVtVPsZC9FCbiTj9z8dsBwDAHdVPLGm48CQ9BLnozANOpRlbfSOYPoV1/s2vDW+gS4kW2vJ02VxpWQCQzxi99aXYbvCCKYsUv772W/M6NhMqK2yw0gcSodahJakvVN8OVmC+4Hw7oTG8vD5JnYRqFcan3LcCgVjgOHKxiazXwOWSfgGUC5Jj4ki9RLMxUTTwuiJhs3bhwXYDmsT0ZFKm1EUPFdT/SwRQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU0PR03MB9125.eurprd03.prod.outlook.com (2603:10a6:10:464::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 10:52:55 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 10:52:55 +0000
Message-ID:
 <AM6PR03MB58488B410942326C129073F499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Thu, 29 Aug 2024 11:52:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make the pointer returned by iter
 next method valid
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQ+-yTEE6_B6+VOjv9uZ-sP3bUogcNPk7cZJBUqpuQVQfg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+-yTEE6_B6+VOjv9uZ-sP3bUogcNPk7cZJBUqpuQVQfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [34mJr1yCyeTM0Aq4HNwZnnGsGauSYdgo]
X-ClientProxiedBy: AM0PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:208:14::22) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <8883f493-998f-404f-ab73-c6966f1f6a64@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU0PR03MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dffafda-2521-48cc-6314-08dcc818bc99
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|5072599009|15080799006|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	AGbd9h4N1XXRGK8CIapg7mfpqISJoOEBvuKg4xP5//upOHW4OBPqygxZ9Hy+HUbVQXdTpUwfqAA3Gt5lgSbzAPzViEGc7geBcw1lfhBi1YWCjq+F7gsE7h7IxzY1CqKZN6S/l2ztFkm+iGc2CrrKzJ03e9pU8Xh0idc4F19EYgrOaMmymAo1eE/l7jep2EMof0nxSyrHbtzqLssnDDeolTBaOPrXN9sLG8ISKJ5IHI2wlolVOHmhO7Ah4ofjbBgu1jGLvcVC13H1gCnhW7lANnYtRfR0+0DYBjwMPfWHvRYJWOpyu8SBtdvOgfokJ1BzBFTPh6Sjt9dGiLFnPZOrWKi0b5P0hXMoV93iH5G1vaD4KnelbgPuGXwjCwyVD7oyecfyaK80kw/L9vbqWX0NVp8ji9DQpsrCfRWxN03RRIdUwmY9qBd516deZgYPkqobL3aoaouOKKzCmWwZBq0rudiEamD6AxhCPhEOw4ivibgMWYTWkh83MrtDOSoP8SktQaUX6Re1go2DzjJbA7XVbGEKP58xlognk1hEJFHTqGrbQ8zuSFEDAcYTqOLrCbYWvdS1RjFwW4Xwn/kzXw20WCMYomJE3g+/Aw8EjP/jI4xxUnzj3A6UZCtab3ySbRJg0Fkyz4Wj7QtM8RNHn7FtqRHQAo1xuSrrb141T6HcV0bRcXsegP3lkwjNP5hcQgIaYyskn+Diau1dqjLOljzc/7ryvUAu0zFsy/7bQR9XQhztNxeEJjd1bhOvOJOYX2KgcvaSCCpHKF6RL4MUSNshT43ulZ2ZEscoN/8u8cU9Puk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JYVXQ2ZGhkRE80M1lYdjA4b1pjNEVheWtrUFdQbUFKTUplRmMrOWhGdUIv?=
 =?utf-8?B?MS9WUjM2SElrS1ZZR21xMkVya1IwVjNqODQvZWs5ajBadkRzVEl3eWcvbXVB?=
 =?utf-8?B?VktobmdsR1RKWWxyOENyYWdiSmRxaEpvYXNydk1uQ3hEYWdCdmRrQnVrUXZx?=
 =?utf-8?B?dFE2ZHVtTjBUejFEMWFxd05XUmYyZ2tsd1VBS290WFdZRHlKUU5TQzRGZERr?=
 =?utf-8?B?U3RzODFaQVBjSms2RTVSNS82UGVwRjRvT3JFc1daMW81YXdZU2tHck9saFZ0?=
 =?utf-8?B?c3lyZmFZOCtNeXUwUTZ4R1FsdTNINThGN2l5aGxBcEhzT2ZrVnJTNUI2RFRr?=
 =?utf-8?B?OUxrVU52VVRlcnRlNFBlWWxZNFh0L1p1TDk1bDc3d1J2VWFZZHM4TGE4RTFD?=
 =?utf-8?B?QmZXMExiOUtnSXRYZkcrTzBlbzBGZjNmNWZFa0Q4SWE3NzQ4bU5pbXRHblVM?=
 =?utf-8?B?Wk1hdE5UMW50TWQvbFVJbkNsVXhYZmMvVzRldGZ1OWlDZmpFZS9BSGlWQXA0?=
 =?utf-8?B?V2lWWHNVTkdLck5IVUNhR2tOeHc3Wk45QVNqR2JMN2FENGUxQkpzV0hOODZ3?=
 =?utf-8?B?VDgyWE9hbUxoZU5QSUk1QmF0RFBaS0NUZzJZNFE4M09jUEVyeDBPTUhZUkZv?=
 =?utf-8?B?S2tPUGpUWlZDaXhkemhsY21YTk9JNE9pMFdTWFF1K2ZWVDBrNlhjUjZHcmVU?=
 =?utf-8?B?MURiT2hsRVpJazNuNEhyb2E0VmlhUGFrWXp0RThZN3VzWjdWdndOeHhJSGhx?=
 =?utf-8?B?M3lIQkFhbWdWWUcvZnBGa0NPN0drcEN1ZUxvdmJ3ZUZRNTliNU41NG82ajVo?=
 =?utf-8?B?QVAxMnRua1dGUVU1VmtNMEhMZXdRYUdMYU16aDIxUUwzbklCVlVwMVlXVERH?=
 =?utf-8?B?UTk5eWpGL1lJY2M1OUNtWm5HaEVuc2xPOVI2ZU4vRGRJTjFXRUxyajlMYlZE?=
 =?utf-8?B?NmNJM3RObzNwZ0ptbmNoTlAwRTdZVW5mMTI5N2w5UWZ2VFdTMXo4Vm5GTVJr?=
 =?utf-8?B?STFESDBMZ1Qxem1JcktUOFJYSC9tdldkajh3Z1N1WVZBUGRlMmNnRDZOR2ZP?=
 =?utf-8?B?SFRPN28vZ2hoOHBBZGRkaGN5VVQ1eVNQbjNqTFIxNDVaYjFTazd3SkNkV0po?=
 =?utf-8?B?NytpS2Evbjh6WGphMmdpaFZQcVVYRUxEcWNOcFhRbTlzUGJzRlR5eFVzaUc5?=
 =?utf-8?B?ZDVmN281VGlvYkVmWlYrUVdMQ1lVTHFWLzExM1pkY1U2TmY0VlhHRElFV2x2?=
 =?utf-8?B?L3ZvUGcyOTJGK0JRK0RzYXFQUkoraytZdTZmVUJsY3FqM3ZqS1l2bUVSeitk?=
 =?utf-8?B?dU5JcTZDdnZFbEhRYVcrMzhXVHFEREdZZGt2TWtmZVhxcjFPVWJJeWIzV1po?=
 =?utf-8?B?cGdjMENyKyt0U1RIdU54b1FRWTljZHBrYnl1YWFRNS8rUzBCbEhFcWFHREZw?=
 =?utf-8?B?dTVtYW9HY2cveFliMGMwVWtGVXhuTmtTVDRiZThsOEdpdzVNMkdHMndHTFJk?=
 =?utf-8?B?ejR6aWF2TTdHREFGWWxSaUoxdVc2anVDbmFGK0J6YUVoR0krbUFFWWVZTWUx?=
 =?utf-8?B?WTBjNHd4UHRxOEtzbnJ1cGJwVE1xV1FoRkFPdFBXYWZ4dkQwVjJCZUhRajF0?=
 =?utf-8?B?VW1yVys2YjcySmFrdDJuVVFNMDFBSS9EUjJCZ3NXcWFsUmZnM3pPcjJPSzg0?=
 =?utf-8?Q?r4J7sWbd805w/QCA3H6D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dffafda-2521-48cc-6314-08dcc818bc99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:52:55.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9125

On 8/21/24 21:53, Alexei Starovoitov wrote:
> On Mon, Aug 19, 2024 at 3:16 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently we cannot pass the pointer returned by iter next method as
>> argument to KF_TRUSTED_ARGS or KF_RCU kfuncs, because the pointer
>> returned by iter next method is not "valid".
>>
>> This patch sets the pointer returned by iter next method to be valid.
>>
>> This is based on the fact that if the iterator is implemented correctly,
>> then the pointer returned from the iter next method should be valid.
>>
>> This does not make NULL pointer valid. If the iter next method has
>> KF_RET_NULL flag, then the verifier will ask the ebpf program to
>> check NULL pointer.
>>
>> KF_RCU_PROTECTED iterator is a special case, the pointer returned by
>> iter next method should only be valid within RCU critical section,
>> so it should be with MEM_RCU, not PTR_TRUSTED.
>>
>> The pointer returned by iter next method of other types of iterators
>> is with PTR_TRUSTED.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>> v1 -> v2: Handle KF_RCU_PROTECTED case and add corresponding test cases
>>
>>   kernel/bpf/verifier.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ebec74c28ae3..d083925c2ba8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8233,6 +8233,12 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
>>                          verbose(env, "bug: bad parent state for iter next call");
>>                          return -EFAULT;
>>                  }
>> +
>> +               if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
>> +                       cur_fr->regs[BPF_REG_0].type |= MEM_RCU;
>> +               else
>> +                       cur_fr->regs[BPF_REG_0].type |= PTR_TRUSTED;
>> +
> 
> That's an odd place to make such an adjustment.
> check_kfunc_call() would fit much better.
> That's where r0.type is typically set.
> 
> Also, the above is buggy for num iter.
> check_kfunc_call() would set r0.type = PTR_TO_MEM for that iter,
> since it's proto: int *bpf_iter_num_next(struct bpf_iter_num* it)
> but above logic would slap PTR_TRUSTED on top.
> PTR_TO_MEM | PTR_TRUSTED is invalid combination.
> I'm surprised nothing crashed.
> 
> pw-bot: cr

I fixed the above issues and added corresponding tests.

I sent the version 3 patch set:
https://lore.kernel.org/bpf/AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com/T/#t

