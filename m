Return-Path: <bpf+bounces-37370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71579954B44
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E28B23C50
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB11BBBFE;
	Fri, 16 Aug 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S6HmrXdp"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2014.outbound.protection.outlook.com [40.92.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F31BB69B;
	Fri, 16 Aug 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815783; cv=fail; b=YQeXBntWa1RdRGpCid2x+GEy88uW6Sixl6NBNwsew8OtfeWZjFcxSu1/2q8r8aP1xzTq7+8rsmNwQxhTXq1c2EzifS4g7HxB0UKe4k5nw1y6wXQe8aHtS8ELTVcMYU1LWGiTWsZ4dcbncE31n6vEoo+AL5ciX2fRHQkI6u9aGyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815783; c=relaxed/simple;
	bh=q4Rn5QSMdItAp+Wz+HTGiGbMtaox8C2UerqvcDp+71U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gp+pL7TkBombiC7/+omFa8YAJXmXaNHq3l1eH2Og1y6ek3tGFcdRxbcpr5k1+cY77ggYbuaG2IgeMJSiwhqROEZ/YhhmYJWX3JnidVHigx02+QSo/l49rUbuYbz5ZtiQpJ/7pI8dCTWJPQAZ/Z1uGxRtgbXjHxNw4mK+Ldr2I/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S6HmrXdp; arc=fail smtp.client-ip=40.92.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvPfA2Xv3tosV9sF2LhISzx9cwdNTZTL3yOUb08ym/giD8+CmVR1ygp2qYjDxKnyWaZqBR5O89QrRj0zu3m1IqlN2xN6QdH/QBPb3hMTJS8G0RWVBVHasKloZUyuvLBl0p7CWiMxPt+DMzQBi1hywqlBKs/E3uZ5yLMgBETqxqbgqhLBRH3yssGdfmLSNSavn8aWhGe99K8H+b4CUkU+87WwQGv+tULzkeVF8P5E+vUXgE+5VV8QhqG94GM9+9n+bVKsIpmDXaK+W0nn27VMyBx4L87Dxc6o5oK791XKtz2iZenJLIivMzwbHev9bp/fzfl1iWhsxLElxTRraV8nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+gIvZVrf7/RhFmuSUzGxIDq04XUwBtHLF/o+dF87eU=;
 b=NsvnUvF5oJfDZpsDlp8BhwYL1MAEhW+KXcMGmrq7/T1J0U0EQHV0zNf/vNsCK18mq97BX2BqJVRGZuVmuG87YTaT+I+mpfMF3kR8qHcMz/3EDsIeQjXARTSyFxnIlByVl+yhBf7G0kQbwsgq5uJnNW5MR+4YI5UGMcoyE1tuVTEFGXJzOTtZjs9mxOEff4mdg1AXdtCrZfxaFNIinWPRL6amuolaEH/NwAEiuk0SGgfN8CyFU48XTb7/jPyfzzMx4oWo2ze8WqeyaEpOuBK32qN4Fb2jIpVrCkqBhloWlaleiOmNDYGIwWCObMGLPgdBdPjjuuMj1I2ypG3qyCVN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+gIvZVrf7/RhFmuSUzGxIDq04XUwBtHLF/o+dF87eU=;
 b=S6HmrXdp+JkM8NXwCNjycO54L7hUsoEyz3rRNReomRFYW6Pp6M8NkjntrMRE1yd1/MZHeyGfp1ktOCsfYHkwBhEUjdqGTKyqeDnTbKhpbILAj1kUGg5eEFE5sTaDq/UVqVloQD50g6P7/FAGrIPuj8UzJEMtIOfENYQ/qKALpfsuDTV6lDBpHHlZJno83gBft+I77i38a6k5YNL+23dCscF3GrrB8YVPtjx2s1WWatbUgga/QKiAQ9wqpKvYD+mgeBEW8V+HiVVkG4YAvjI0lmd9Jp5wNxoBK8mfQr1pCj5tUs5JQp3jeWZ5hhNy8hh8n0yMT1JIxaJddX6kG3aL/g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM9PR03MB6788.eurprd03.prod.outlook.com (2603:10a6:20b:2de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:42:58 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:42:58 +0000
Message-ID:
 <AM6PR03MB584807BFB29105F1D7FDC89E99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Fri, 16 Aug 2024 14:42:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next
 method valid
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [es2+0vLxHA9sMl5K1jA+MUEdJiIdJCcJ]
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20116758-cf42-4e34-aa8c-15710c464396@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM9PR03MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: a03d6622-e7f0-4c98-5a3e-08dcbdf956e3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|19110799003|5072599009|8060799006|461199028|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	zbEjetON5DafrLHG2jngjAKtBx6H7rFcSz6hag+rAl7Hdqi3Hj1cP2abgWVRZbnZSq+IEFvLLrG1xRsnTnX5tBgRsukmvlm6nfWmiLmnfbf1+ufcMeD54EoGw/3N60QGwCbjAqF0UZqSL5g4cqDa7rPAGnfVzQj8Oy5aIfHb83yyIoJsvymHwH19y87bxwqmUGB78DgjC0ycaNyX9yKOgMltv4L7Qe530w1+dwg3WWjkKTjblXG32hfMD3ODmH7ubflGzh3foqWlG3ao1OKK+rbF+gFSwvK432yB1D56436L03gguXdE7MAQWySi3GBSHuFAxXvs+5ffFP6pBpqmpnZunqzhR6UHNOPHz3IyM9FKuCuQAMNjkb7NA+HSxnmDEQ/XkT3VqGBrZk71Zekxdy2webRFkF5fBvv4UiB9wuaf3Z3AzDebpHC6dJjUAcsV2+oF6vskXWxvoJeJmxez/3kPQ4EJhDcRu4RNhm6dM7nlnFthNcGIQlZ+rY9lLvSUqXGutpHe6oJATXW3lS2l4Q0CK4y5qgBYzFCCpXWbKanq/P6Hv5ToJqRkTNyBg0o/gZAMUJMWilFvNkwBe8uee9H134FNYJwgdZa/vR5/UFW2WzcecT2jjcDRqzdT7CVFxgivunvU9SH3yVrZeTVP2kH5WKuduh/6mD+ejw7l/AEYLjQI8K8sVWExl9XrtTSOYpZ3t+V+A8emxexGsXKRwNODfcmKYH+v86p0daAbTlFUfBOeus1m/f+lqCwZG0T+C4DhLFCtapvDsFMDttR7ru3ZA7foVlVD1nA8HzWfOuUSGc1odmIcdPneKgGjtIV1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmV3T2I3Ujdpb014RzREVmJRdUZFbXFSZXdGSDhFbTZsRDRiVFhkRFVjeFRL?=
 =?utf-8?B?djF1YjBXV25jU3BpbFNUTWJ5Z1hUeEc2ZDd1aGlFME5oWWRZcFMyWTFhOE10?=
 =?utf-8?B?bU1ZOEFubFFqajdZelpacHZ5UGI5SnZPeEg3ajJCVU51bS9tQkZuMGZESkto?=
 =?utf-8?B?TVhEWW10eUdvWXVuVEF4dUlNSy9MeXVBeXNXYzRUbkg1cG11VGdQOHVqVXlu?=
 =?utf-8?B?WG45YU4rMU9zWU1VbDNjcU9BclE0eDBjWk5yY041MmJ1SHJXR3NlSGR4cHFL?=
 =?utf-8?B?UW5NVytUQjlvZGJ0dWliT296SGNGaVRkVHZYM2dEN0JoQmljTTVWcjdDaHBP?=
 =?utf-8?B?NzUxUzRZQTBEcW8yOTF3MmNKWGFDdWJYYVRrN1B0ZjBaVHpONlhoWmgyaHJq?=
 =?utf-8?B?V1VSdU5HSHMzcEttWWZwTXVNYTZZeXNXb1ZEaHh2Ry9CUStjTjdKSUoxV0Qw?=
 =?utf-8?B?ZzRIR25DZlZLa1JOaTZsYlJJaHR0ZkZua2dvTm9NTFp4T1ZFUHNvb25xRms5?=
 =?utf-8?B?dDcwZlZ4b0Rwd2Y5WG5tR3ZDM05xNnNSOFBkQnlsOElEWGU5ZmQ2TlVzTFFJ?=
 =?utf-8?B?Q2tySlk4cG8xRzJTTkxEQlQvQ1FtS0wwcDRkTTF3S28zWWtuZVJRZ1FXZDd4?=
 =?utf-8?B?S2hYMWdFNGZ6ZGlEOGd2M2haTmdaR2t0NVZ6Z0dGMGFCSmc2YkpVYm8wbkM1?=
 =?utf-8?B?RWs5djNSYjg1WlhpTGN4S3VSdXMrZnBKVmpZNGQ4ZEJMdHVqb1ZjbXBNZkhJ?=
 =?utf-8?B?aStBS1krK0FhQUxKWDFDSUtTRmZYZlJXb0daeTh2WTYzdXllZEVIeGNQNnVl?=
 =?utf-8?B?SXdxUjB0ekJtS1NWY1lTZW9NL2RIaFI3SzM4UkRoakVIYUpxTkN2RVA3ZVZU?=
 =?utf-8?B?WHF3N2FiZkRSV1hQb0JPbzBTL0FIaldoY2JFRFY4T0orL1BTeGlScTBJOC9O?=
 =?utf-8?B?anVGNzJQRjhNSWlPVlRSWitPcjFRUTBNbUhvT245Q0hsTk4xQnEzTWhGanRB?=
 =?utf-8?B?YVg3dElWUTV1ZStXMzlNTzFPMEYxaDY1MjhOUUNSWS92eVZSdys4OVUzek9J?=
 =?utf-8?B?UFFTZmRGYS91UDQ5QWkrbmV5WGdsZ2gzTjdFNTFOZGxrbmI1bE5JOGpHTHA5?=
 =?utf-8?B?N2IrSmdTK1g0SDRZTFBMdzdpWGUwckpCNjAzaEVPa0hlL3VsL0JXTzJGM1JM?=
 =?utf-8?B?WnlxajZtUjlTRjd0S1EzTDJmU2RaOXJ4TUtqR0JTdCt2TjRvbUVnejAvS3Vz?=
 =?utf-8?B?WUlVemQrSk1lcldEMmw3NGVDZndoUG9idUN3LzEvYTRITEtVVmNnaWozTm1S?=
 =?utf-8?B?M1hJaDlhVFVoNEZHd1Z2UzUvU1cvS3lOaHBSdkd2Ukg5QTJ1WFdJdTBnbWl2?=
 =?utf-8?B?S1VrdjduUTllNGlDUFVkNmpYSEkzdHNGNytodlNhc0h0NjJHWVc2dGRZUW52?=
 =?utf-8?B?NTQ2N0ZuODc2QksrbnltUFl5a3NPVlc1dmFDNUdHbDR0Z081UTZ3Q3F3MEtq?=
 =?utf-8?B?Z2R6RDBzMGRLd0hJdGtFbFZFUGJxRzlWd0FVTmhYYkYzMnZRSkdlVkh2a2Vk?=
 =?utf-8?B?L1UzWkVKdndLak51cEEvQ1pub3FKeGNJdmhDR29UQ1BrVXlVMXVyYzhmVFV3?=
 =?utf-8?B?dm1iK3pjQzFQWmxMdnZLVFlVWUdmKzRGSG83YWNGU2M5OTdoaWlHWUlQVnFF?=
 =?utf-8?Q?pXmEQP8vMRrN37IZjNF/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03d6622-e7f0-4c98-5a3e-08dcbdf956e3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:42:58.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6788

On 8/15/24 18:15, Andrii Nakryiko wrote:
> On Thu, Aug 15, 2024 at 9:11 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently we cannot pass the pointer returned by iter next method as
>> argument to KF_TRUSTED_ARGS kfuncs, because the pointer returned by
>> iter next method is not "valid".
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
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/bpf/verifier.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ebec74c28ae3..35a7b7c6679c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12832,6 +12832,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                          /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>>                          regs[BPF_REG_0].id = ++env->id_gen;
>>                  }
>> +
>> +               if (is_iter_next_kfunc(&meta))
>> +                       regs[BPF_REG_0].type |= PTR_TRUSTED;
>> +
> 
> It seems a bit too generic to always assign PTR_TRUSTED to anything
> returned from any iterator. Let's maybe add KF_RET_TRUSTED or
> KF_ITER_TRUSTED or something along those lines to mark such iter_next
> kfuncs explicitly?
> 
> For the numbers iterator, for instance, this PTR_TRUSTED makes no sense.
> 

I had the same idea (KF_RET_TRUSTED) before, but Kumar thought it should
be avoided and pointers returned by iter next method should be trusted
by default [0].

The following are previous related discussions:

 >> For iter_next(), I currently have an idea to add new flags to allow
 >> iter_next() to decide whether the return value is trusted or not,
 >> such as KF_RET_TRUSTED.
 >>
 >> What do you think?
 >
 > Why shouldn't the return value always be trusted?
 > We eventually want to switch over to trusted by default everywhere.
 > It would be nice not to go further in the opposite direction (i.e.
 > having to manually annotate trusted) if we can avoid it.

[0]: 
https://lore.kernel.org/bpf/CAP01T75na=fz7EhrP4Aw0WZ33R7jTbZ4BcmY56S1xTWczxHXWw@mail.gmail.com/

Maybe we can have more discussion?

(This email has been CC Kumar)

>>                  mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
>>                  if (is_kfunc_acquire(&meta)) {
>>                          int id = acquire_reference_state(env, insn_idx);
>> --
>> 2.39.2
>>


