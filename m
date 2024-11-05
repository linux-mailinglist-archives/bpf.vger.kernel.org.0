Return-Path: <bpf+bounces-44057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A79BD2C7
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464FA1F233EB
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DB1D9A7B;
	Tue,  5 Nov 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+VHSusZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0101126C13
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825341; cv=none; b=U4YqYmJ+WUGK88HNK8ypqxvJ7wmiACQRnT1VMqEt3TjhLkZlLggKgQlNV2QSANagA6MugRXO3I+BYfdiM92W40JEX4IAR1Hn479BzI9I2MorrmjrIPZbCY9ld63UiXa+mFcUN+p4n/ckWCZh+8/H/W+K0DCwhR1nGvgzd2c31Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825341; c=relaxed/simple;
	bh=WB4biER+sfrPsDv8IodX2S+46ozDkDOoQI85xIxU40k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVo0FISHL1axJUkshbUkHf1LJH1mSp8TUHMwrUxIevKMA3+/VjTfqMM05gYIqIycg1mhK14evwbbi73E14Ow9+nOKgB7BggKdChhiV7W8xtctrFO6+lEW0bgloVa9UOzURjyJON5LVXFEPePaFL56XE4mWw3NtZ4ViT8/gHMcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+VHSusZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <893eb66c-8122-4b28-8dfa-2a7beddbb511@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730825336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2S3O/oDJ6bD4cT8SovDx9oQBhA0Oo+n4hZRc4Cu4/Y=;
	b=C+VHSusZ3voB8LpbySsm72qvMI2tBewsd5lspu0mU+qELfaAZlwvm4vsyH2X0UREcNoPJp
	tX+ZgLNpL8FZG5zsf4VcWFOY56ickdFl5PQg9DdGsRxZRBgyNDyeu1ghaoUB3D5KNUN69d
	oyUXQahmO4kyRAxXN6BBuXzsy4elWSo=
Date: Tue, 5 Nov 2024 08:48:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev>
 <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
 <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev>
 <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
 <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com>
 <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev>
 <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
 <43dc0d7d-ca6e-4ba1-a831-e2a1e43f6311@linux.dev>
 <CAADnVQJpm2JreS2peqcEZ07FvY5jb+t2xPjpZm4N1UE3_hjxTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJpm2JreS2peqcEZ07FvY5jb+t2xPjpZm4N1UE3_hjxTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/5/24 8:38 AM, Alexei Starovoitov wrote:
> On Tue, Nov 5, 2024 at 8:33 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 11/5/24 7:50 AM, Alexei Starovoitov wrote:
>>> On Mon, Nov 4, 2024 at 10:02 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>> I also don't understand the point of this patch 2.
>>>>> The patch 3 can still do:
>>>>>
>>>>> + switch (prog->type) {
>>>>> + case BPF_PROG_TYPE_KPROBE:
>>>>> + case BPF_PROG_TYPE_TRACEPOINT:
>>>>> + case BPF_PROG_TYPE_PERF_EVENT:
>>>>> + case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>>>> +   return PRIV_STACK_ADAPTIVE;
>>>>> + default:
>>>>> +   break;
>>>>> + }
>>>>> +
>>>>> + if (!bpf_prog_check_recur(prog))
>>>>> +   return NO_PRIV_STACK;
>>>>>
>>>>> which would mean that iter, lsm, struct_ops will not be allowed
>>>>> to use priv stack.
>>>> One example is e.g. a TC prog. Since bpf_prog_check_recur(prog)
>>>> will return true (means supporting recursion), and private stack
>>>> does not really support TC prog, the logic will become more
>>>> complicated.
>>>>
>>>> I am totally okay with removing patch 2 and go back to my
>>>> previous approach to explicitly list prog types supporting
>>>> private stack.
>>> The point of reusing bpf_prog_check_recur() is that we don't
>>> need to duplicate the logic.
>>> We can still do something like:
>>> switch (prog->type) {
>>>    case BPF_PROG_TYPE_KPROBE:
>>>    case BPF_PROG_TYPE_TRACEPOINT:
>>>    case BPF_PROG_TYPE_PERF_EVENT:
>>>    case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>>       return PRIV_STACK_ADAPTIVE;
>>>    case BPF_PROG_TYPE_TRACING:
>>>    case BPF_PROG_TYPE_LSM:
>>>    case BPF_PROG_TYPE_STRUCT_OPS:
>>>       if (bpf_prog_check_recur())
>>>         return PRIV_STACK_ADAPTIVE;
>>>       /* fallthrough */
>>>     default:
>>>       return NO_PRIV_STACK;
>>> }
>> Right. Listing trampoline related prog types explicitly
>> and using bpf_prog_check_recur() will be safe.
>>
>> One thing is for BPF_PROG_TYPE_STRUCT_OPS, PRIV_STACK_ALWAYS
>> will be returned. I will make adjustment like
>>
>> switch (prog->type) {
>>    case BPF_PROG_TYPE_KPROBE:
>>    case BPF_PROG_TYPE_TRACEPOINT:
>>    case BPF_PROG_TYPE_PERF_EVENT:
>>    case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>       return PRIV_STACK_ADAPTIVE;
>>    case BPF_PROG_TYPE_TRACING:
>>    case BPF_PROG_TYPE_LSM:
>>    case BPF_PROG_TYPE_STRUCT_OPS:
>>       if (bpf_prog_check_recur()) {
>>         if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
>>             return PRIV_STACK_ALWAYS;
> hmm. definitely not unconditionally.
> Only when explicitly requested in callback.
>
> Something like this:
>     case BPF_PROG_TYPE_TRACING:
>     case BPF_PROG_TYPE_LSM:
>        if (bpf_prog_check_recur())
>           return PRIV_STACK_ADAPTIVE;
>     case BPF_PROG_TYPE_STRUCT_OPS:
>        if (prog->aux->priv_stack_requested)
>           return PRIV_STACK_ALWAYS;
>     default:
>        return NO_PRIV_STACK;
>
> and then we also change bpf_prog_check_recur()
>   to return true when prog->aux->priv_stack_requested

This works too. I had another thinking about
    case BPF_PROG_TYPE_LSM:
       if (bpf_prog_check_recur())
          return PRIV_STACK_ADAPTIVE;
    case BPF_PROG_TYPE_STRUCT_OPS:
       if (bpf_prog_check_recur())
          return PRIV_STACK_ALWAYS;

Note that in bpf_prog_check_recur(), for struct_ops,
will return prog->aux->priv_stack_request.
But think it is too verbose so didn't propose.

So explicitly using prog->aux->priv_stack_requested
is more visible. Maybe we can even do

    case BPF_PROG_TYPE_TRACING:
    case BPF_PROG_TYPE_LSM:
    case BPF_PROG_TYPE_STRUCT_OPS:
       if (prog->aux->priv_stack_requested)
          return PRIV_STACK_ALWYAS;
       else if (bpf_prog_check_recur())
          return PRIV_STACK_ADAPTIVE;
       /* fallthrough */
    default:
       return NO_PRIV_STACK;


