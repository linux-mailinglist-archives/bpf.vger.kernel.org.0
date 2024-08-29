Return-Path: <bpf+bounces-38340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A5796381B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 04:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D21F23262
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4838DD6;
	Thu, 29 Aug 2024 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQTMRkSs"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9B39851
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897706; cv=none; b=Z8U3vPMyHNRFcPvyEr0qujtw9NACRnuXbJZ02d7TUcfC6ebYfrkHmCpMkXMxlpRFPi4V1vfgvFRWnaJtb1OlKKbOV8YVyNKwky6sjPlG4CAQP+KOAjJDrLA2BqGDet8lQZsJysgPHqSr09gjo5674qwv9jL31Jjf9xrzV2NG4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897706; c=relaxed/simple;
	bh=WPG/3sXixpeegcaRtLWY0hpTMvCOa76Qki5fO/9trdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzPTaPPYTvYGpgV/l02CY0MCc8L0B0SPX547/5cejKPV2pL1bfb14sDKRA0tRhwUa9tAIWVRh7wHIMUELnMe391Nbk2W8s6NPRMlYkiC1HBxjaT5Msw+0jct+x3stRyInN1BGSCVDCQChGoTL8fA5TFu1yxn9Gd0jB/QoxEEh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQTMRkSs; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36a43f60-749f-4f15-9273-c4b223d0fa56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724897701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcVf08TqBa7twjfosNuNiIcNE4IAFaP1QAsAxoTOxzw=;
	b=PQTMRkSsEUMUWIG8xBeI+Urra8Ams2UP/3u9mxp7/UNqIz5iQBUkCORIwZprYTCcI/wUux
	otu3bA48reS8zWpvj03swpVZsaicDpZDeKY11xJqQdQ4CteKhxvV4yVm+zY61dU04fflQ8
	vd7rcqjg2tpqzigZnpKSYblfhDCSAPQ=
Date: Thu, 29 Aug 2024 10:14:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
 <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
 <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
 <c63deed3-d5e5-4b1b-8cb5-ce9f92812e49@linux.dev>
 <CAADnVQ+42X27_gv8EvoiBairsnHvjoodM4X9oxvAuuBooZyzMA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+42X27_gv8EvoiBairsnHvjoodM4X9oxvAuuBooZyzMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 29/8/24 00:01, Alexei Starovoitov wrote:
> On Tue, Aug 27, 2024 at 7:36 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 28/8/24 04:50, Alexei Starovoitov wrote:
>>> On Tue, Aug 27, 2024 at 5:48 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>>> I wonder if disallowing to freplace programs when
>>>>> replacement.tail_call_reachable != replaced.tail_call_reachable
>>>>> would be a better option?
>>>>>
>>>>
>>>> This idea is wonderful.
>>>>
>>>> We can disallow attaching tail_call_reachable freplace prog to
>>>> not-tail_call_reachable bpf prog. So, the following 3 cases are allowed.
>>>>
>>>> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf prog.
>>>> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
>>>> bpf prog.
>>>> 3. attach not-tail_call_reachable freplace prog to
>>>> not-tail_call_reachable bpf prog.
>>>
>>> I think it's fine to disable freplace and tail_call combination altogether.
>>
>> I don't think so.
>>
>> My XDP project heavily relies on freplace and tailcall combination.
> 
> Pls share the link to the code.
> 

I'm willing to share it with you. But it's an in-house project of my
company. Sorry.

>>>
>>> And speaking of the patch. The following:
>>> -                       if (tail_call_reachable) {
>>> -
>>> LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>> -                               ip += 7;
>>> -                       }
>>> +                       LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>> +                       ip += 7;
>>>
>>> Is too high of a penalty for every call for freplace+tail_call combo.
>>>
>>> So disable it in the verifier.
>>>
>>
>> I think, it's enough to disallow attaching tail_call_reachable freplace
>> prog to not-tail_call_reachable prog in verifier.
>>
>> As for this code snippet in x64 JIT:
>>
>>                         func = (u8 *) __bpf_call_base + imm32;
>>                         if (tail_call_reachable) {
>>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>                                 ip += 7;
>>                         }
>>                         if (!imm32)
>>                                 return -EINVAL;
>>                         ip += x86_call_depth_emit_accounting(&prog, func, ip);
>>                         if (emit_call(&prog, func, ip))
>>                                 return -EINVAL;
>>
>> when a subprog is tail_call_reachable, its caller has to propagate
>> tail_call_cnt_ptr by rax. It's fine to attach tail_call_reachable
>> freplace prog to this subprog as for this case.
>>
>> When the subprog is not tail_call_reachable, its caller is unnecessary
>> to propagate tail_call_cnt_ptr by rax. Then it's disallowed to attach
>> tail_call_reachable freplace prog to the subprog. However, it's fine to
>> attach not-tail_call_reachable freplace prog to the subprog.
>>
>> In conclusion, if disallow attaching tail_call_reachable freplace prog
>> to not-tail_call_reachable prog in verifier, the above code snippet
>> won't be changed.
> 
> As long as there are no more JIT changes it's ok to go
> with this partial verifier restriction,
> but if more issues are found we'll have to restrict it further.

OK. I'll do the restriction in verifier.

Thanks,
Leon


