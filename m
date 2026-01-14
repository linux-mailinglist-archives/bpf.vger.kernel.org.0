Return-Path: <bpf+bounces-78836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D2D1C50B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5862D30194C1
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC02D7813;
	Wed, 14 Jan 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dRMkPZQg"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68D2D7DE2
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363101; cv=none; b=ISeWmwrASrpWaGdyIw4kFi4fZf2OIFM0UHaLLwoR4xyy4Xfgh3ua37in2kEZOYUY5eOBzPWUwgTmFEX+Y1GC6f6U5F2twRBBzWKcU+07HUkNA+CSA+9OAA3qG0dZJhYZNPYXUduGa13vRsDNj/hyQnOnnRjGIENiNDfl50sc2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363101; c=relaxed/simple;
	bh=MCDN8flxLquTUPEz+Ko6ciZOlX7+BRuMaRD0vZpxDXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVcTBf0jJTG0qXa2Dcb4vi0lUn36HXk4MQgoFKZNL1+4B42Kd6hK5nec4czfX+h0D73FaaE/xy/Kl44qIt22sIUL/xVhS3MJ3OXtcpm27O+PbM0/BBf71QA/VAk+rmREqw0CWVsQfOSCCQzHKGyPff1M+Zo8A7jDryLGpZhvdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dRMkPZQg; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e501b557-5220-43d2-be19-3a939df0439c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768363087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzy7fr0C5AI0nkgfQZNX+ZDEBppbKPD7uT6faQ1cxto=;
	b=dRMkPZQgUIf1lZu/GXVKUznU9HhiPKrkI23aXFRCs92ONsmPe/H/3JbPMSqmUdtxsh8RlN
	wAukdQdjgKayl9pYecO6DADvMUYr0MtHER53ndlUcZ/OUaVNM334KPzI/k5+RDMPvU9Lpo
	9UcwsQBfS88rM3DUBHDNMcJegf3XvN4=
Date: Tue, 13 Jan 2026 19:57:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykyta Yatsenko
 <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
 <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
 <93ecdc25-aa5e-485b-8ff4-a9db3b585861@linux.dev>
 <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
 <CAADnVQLizVA16Q-wVMd5-00YSPZtyuu7Exn9B8c_r1rn2cztkg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLizVA16Q-wVMd5-00YSPZtyuu7Exn9B8c_r1rn2cztkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 4:55 PM, Alexei Starovoitov wrote:
> On Tue, Jan 13, 2026 at 3:48 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 1/13/26 2:03 PM, Ihor Solodrai wrote:
>>> On 1/13/26 12:39 PM, Eduard Zingerman wrote:
>>>> On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
>>>>>
>>>>
>>>> [...]
>>>>
>>>>> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>>     for (i = 0; i < nargs; i++) {
>>>>>             u32 regno = i + 1;
>>>>>
>>>>> +           /*
>>>>> +            * Implicit kfunc arguments are set after main verification pass.
>>>>> +            * For correct tracking of zero-extensions we have to reset subreg_def for such
>>>>> +            * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
>>>>> +            * from an earlier (irrelevant) point in the program, which may lead to an error
>>>>> +            * in opt_subreg_zext_lo32_rnd_hi32().
>>>>> +            */
>>>>> +           if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
>>>>> +                           && is_kfunc_arg_implicit(desc_btf, &args[i])))
>>>>> +                   regs[regno].subreg_def = DEF_NOT_SUBREG;
>>>>> +
>>>>
>>>> Did you try doing this in `mark_reg_not_init()`?
>>>> This function is called for R1-R5 some time prior this hunk.
>>>
>>>> Did you try doing this in `mark_reg_not_init()`?
>>>
>>> Just tried, it doesn't work because REG0 is considered a caller saved
>>> register, and so it breaks the zext tracking:
>>>
>>>         #define CALLER_SAVED_REGS 6
>>>         static const int caller_saved[CALLER_SAVED_REGS] = {
>>>            BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
>>>         };
>>>
>>>         [...]
>>>
>>>       for (i = 0; i < CALLER_SAVED_REGS; i++)
>>>               mark_reg_not_init(env, regs, caller_saved[i]);
>>>
>>> CI run for the diff below (on top of this series):
>>> https://github.com/kernel-patches/bpf/actions/runs/20972520708
>>>
>>>
>>> [...]
>>>
>>> ---
>>>
>>> Resetting all reg args appears to be working however (see below).
>>> CI: https://github.com/kernel-patches/bpf/actions/runs/20973490221
>>>
>>
>> A follow up after a chat with Eduard.
>>
>> This change in check_kfunc_call() appears to be working:
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 092003cc7841..ff743335111c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13958,8 +13958,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                 regs = branch->frame[branch->curframe]->regs;
>>
>>                 /* Clear r0-r5 registers in forked state */
>> -               for (i = 0; i < CALLER_SAVED_REGS; i++)
>> -                       mark_reg_not_init(env, regs, caller_saved[i]);
>> +               for (i = 0; i < CALLER_SAVED_REGS; i++) {
>> +                       u32 regno = caller_saved[i];
>> +                       mark_reg_not_init(env, regs, regno);
>> +                       regs[regno].subreg_def = DEF_NOT_SUBREG;
>> +               }
>>
>>                 mark_reg_unknown(env, regs, BPF_REG_0);
>>                 err = __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
>>
>> https://github.com/kernel-patches/bpf/actions/runs/20975419422
>>
>> Apparently, doing .subreg_def = DEF_NOT_SUBREG in mark_reg_not_init()
>> breaks zero-extension tracking somewhere else.  But this is not
>> directly relevant to the series.
>>
>> Eduard, Alexei, any concerns with this diff? Should I send a separate
>> patch?
> 
> This is odd. Clear it only for res_spin_lock() processing?!
> Should be around lines 14149 instead?

Yes. Sorry, this was a messed up local diff. The commits tested on CI
are correct though. I'll have this fix in v2, since it is necessary
for KF_IMPLICIT_ARGS to work.

I'll look into this problem more after implicit args land, unless
someone beats me to it.

> 
> First, need to investigate why clearing it in mark_reg_not_init()
> breaks things.
> That's what clear_caller_saved_regs() is doing already.
> Maybe these two loops in check_kfunc_call() should be doing
> clear_caller_saved_regs() instead...
> Needs proper investigation.


