Return-Path: <bpf+bounces-44084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1669BDA38
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519FC2847B7
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E404A11;
	Wed,  6 Nov 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N74GiyD5"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBCBA3F
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852398; cv=none; b=qa/STBlW+lovHDEULnSPEUeYsqijumz0+Of6Qp64asguKc7DZPUZCt8PuKnIbFLACFuiYICwUu/vsueSPeeMSVyLsgMU7cT9dQZW+rRpiux2nsQT4kmC1py3XpKFldKH1wi/9p8ZN4RpXvB20nxmw2Y441fWpBgQrbRCczMvB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852398; c=relaxed/simple;
	bh=tokgym2Hjj1V++x9mREZ/ZaP3YPJbxcIiJjQXYEoeJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0WURp56bzIOI1VNg19ODAc0kjYp2cFWuuEMRaWS4J0H0XOurrWwKm9wKO96UEoPiKTMOcvce5U4+FeEwrsyAGvsEfY+2m1fSIPDkrxDJIT4JCWilyslauZjWxgfGiISqHPJD5a1JwfYFKKMLq6GRGTPaWELDGLerKGs2J4NVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N74GiyD5; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730852393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKWVw7vuKzmKB7UKKF18qWT9gyObf++4FsCMzScNe+s=;
	b=N74GiyD5UG3gK0Kv8RqmhaKIUBw+E7BjXYtDf0FJQ207XR9MOFeYPAZ14M1NdvKrnwGqAt
	k0xUey40RLz+/7GOcdjODNM77Y2txCLTvWKvz0tiv0MrV8UkxrVWMldgagvUe1HJMYKGec
	feSXmu3lACuXCuEFZ1w4dkZmo1JLZe0=
Date: Tue, 5 Nov 2024 16:19:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev>
 <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
 <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
 <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/5/24 1:52 PM, Alexei Starovoitov wrote:
> On Tue, Nov 5, 2024 at 1:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> I see. I think it works, but feels complicated.
>>> It feels it should be possible to do without extra flags. Like
>>> check_max_stack_depth_subprog() will know whether it was called
>>> to verify async_cb or not.
>>> So it's just a matter of adding single 'if' to it:
>>> if (subprog[idx].use_priv_stack && checking_async_cb)
>>>      /* reset to false due to potential recursion */
>>>      subprog[idx].use_priv_stack = false;
>>>
>>> check_max_stack_depth() starts with i==0,
>>> so reachable and eligible subprogs will be marked with use_priv_stack.
>>> Then check_max_stack_depth_subprog() will be called again
>>> to verify async. If it sees the mark it's a bad case.
>>> what am I missing?
>> First I think we still want to mark some subprogs in async tree
>> to use private stack, right? If this is the case, then let us see
>> the following examle:
>>
>> main_prog:
>>      sub1: use_priv_stack = true
>>      sub2" use_priv_stack = true
>>
>> async: /* calling sub1 twice */
>>      sub1
>>        <=== we do
>>               if (subprog[idx].use_priv_stack && checking_async_cb)
>>                   subprog[idx].use_priv_stack = false;
>>      sub1
>>        <=== here we have subprog[idx].use_priv_stack = false;
>>             we could mark use_priv_stack = true again here
>>             since logic didn't keep track of sub1 has been
>>             visited before.
> This case needs a sticky state to solve.
> Instead of bool use_priv_stack it can be tri-state:
> no_priv_stack
> priv_stack_unknown <- start state
> priv_stack_maybe
>
> main_prog pass will set it to priv_stack_maybe
> while async pass will clear it to no_priv_stack
> and it cannot be bumped up.

The tri-state may not work. For example,

main_prog:
    call sub1
    call sub2
    call sub1
    call sub3

async:
    call sub4 ==> UNKNOWN -> MAYBE
    call sub3
    call sub4 ==> MAYBE -> NO_PRIV_STACK?

For sub4 in async which is called twice, for the second sub4 call,
it is not clear whether UNKNOWN->MAYBE transition happens in
main_prog or async. So based on transition prototol,
second sub4 call will transition to NO_PRIV_STACK which is not
what we want.

So I think we still need a separate bit in bpf_subprog_info to
accumulate information for main_prog tree or any async tree.

>
>> To solve the above issue, we need one visited bit in bpf_subprog_info.
>> After finishing async tree, if for any subprog,
>>     visited_bit && subprog[idx].use_priv_stack
>> is true, we can mark subprog[idx].use_priv_stack = false
>>
>> So one visited bit is enough.
>>
>> More complicated case is two asyncs. For example:
>>
>> main_prog:
>>     sub1
>>     sub2
>>
>> async1:
>>     sub3
>>
>> async2:
>>     sub3
>>
>> If async1/sub3 and async2/sub3 can be nested, then we will
>> need two visited bits as I have above.
>> If async1/sub3 and async2/sub3 cannot be nested, then one
>> visited bit should be enough, since we can traverse
>> async1/async2 with 'visited' marking and then compare against
>> main prog.
>>
>> So the question would be:
>>     1. Is it possible that two async call backs may nest with
>>        each other? I actually do not know the answer.
> I think we have to assume that they can. Doing otherwise
> would subject us to implementation details.
> I think above tri-state approach works for two callbacks case too:
> async1 will bump sub3 to priv_stack_maybe
> while async2 will clear it to sticky no_priv_stack.
>
> Ideally we reuse the same enum for this algorithm and for earlier
> patches.
>
>>     2. Do we want to allow subprogs in async tree to use private
>>        stacks?
> yes. when sched-ext requests priv stack it would want it everywhere.
> I think the request_priv_stack should be treated as
> PRIV_STACK_ADAPTIVE. Meaning that subprogs with stack_depth < 64
> don't need to use it.
> In other words struct_ops prog with request_priv_stack == true
> tells the verifier: add run-time recursion check at main prog entry,
> otherwise treat it like fentry and pick priv stack vs normal
> as the best for performance.
>
> Then for both fentry and struct_ops w/request_priv_stack
> the async callbacks will be considered for priv stack too and
> will be cleared to normals stack when potential recursion via async
> is detected.
> I don't think it's an error for either prog type.
> Overall we shouldn't treat struct_ops too special.
> fentry progs with large stack are automatically candidates for priv stack.
> struct_ops w/request_priv_stack are in the same category.

Okay, indeed we can treat struct_ops the same as other tracing programs.
They are adaptive too subject to various conditions where priv state may
not be used, e.g. small stack size, tailcall, and potentially nested subprogs.


