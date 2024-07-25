Return-Path: <bpf+bounces-35599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A693BA24
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 03:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C71D1F21F26
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677D63A9;
	Thu, 25 Jul 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RL30Y/8j"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6A4C74
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721870950; cv=none; b=NpxAfw+Q70Heapb/tCzDolb2cbGwIJFfyj9yawGhyb35qWjhF5XxWCZSTX+drFlrWCdx22qW8JYcq+myHj57Py3Yz0jgDiOrsxcy3mhUu01+K9gFHHFGq7fCHsExfKSyxoySBl/jPsh013vzt6SIDp+oPPu8RTcirKRyag3gMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721870950; c=relaxed/simple;
	bh=D4Df2yLlZLjyHvUkvuVJb5Z7AjTh6aj6UA+ZGKokCIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjuT2uhw+lV2D1cM6566g/1HUk2Eei7iZg1htLIP+1wFYWRBQq4OAXj2QLK79cZtidNXPM/nl/eLQ0WsInAub7VRDI3YMQ07VseLbGxVlIO3DKYqWTo3y39se/s4FtNi39w84irImllNdbUuXpi1wGvZxSQNYh8lAwdXV3/1TfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RL30Y/8j; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4582b8db-e59d-4ca0-9a0e-4d0f21a1af66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721870941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhmLD46nvN5Sk9l5I+t7MliwEdX33RrU4gOe3PYsSj0=;
	b=RL30Y/8j3r2fPyxovXYkF6OrruecRsH1+J1fIG3158u3ozslhKSQ51tDq+slWPWnYb/tBs
	K4XYfhktxqVsk2pt0r7KFkz2rVGre3jOmzsNuHeHSJok/xjhAsF4JL0TzzutmjVdA1O17x
	mpblnWJ2Ltqr0OfTL1HVyvhfXIZRCA0=
Date: Wed, 24 Jul 2024 18:28:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 01/11] bpf: Support getting referenced kptr from
 struct_ops argument
To: Amery Hung <ameryhung@gmail.com>, alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-2-amery.hung@bytedance.com>
 <907f24f2-0f33-415e-85c6-0400ab67f896@linux.dev>
 <CAMB2axNDVCdH7stBj8-duOcV1P=qjyjUAR+YXywVMx8HgRPokg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNDVCdH7stBj8-duOcV1P=qjyjUAR+YXywVMx8HgRPokg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/24/24 10:00 AM, Amery Hung wrote:
> On Tue, Jul 23, 2024 at 5:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 7/14/24 10:51 AM, Amery Hung wrote:
>>> @@ -21004,6 +21025,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>>>                mark_reg_known_zero(env, regs, BPF_REG_1);
>>>        }
>>>
>>> +     if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
>>> +             ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
>>> +             for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
>>> +                     if (ctx_arg_info[i].refcounted)
>>> +                             ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);
>>> +     }
>>> +
>>
>> I think this will miss a case when passing the struct_ops prog ctx (i.e. "__u64
>> *ctx") to a global subprog. Something like this:
>>
>> __noinline int subprog_release(__u64 *ctx __arg_ctx)
>> {
>>          struct task_struct *task = (struct task_struct *)ctx[1];
>>          int dummy = (int)ctx[0];
>>
>>          bpf_task_release(task);
>>
>>          return dummy + 1;
>> }
>>
>> SEC("struct_ops/subprog_ref")
>> __failure
>> int test_subprog_ref(__u64 *ctx)
>> {
>>          struct task_struct *task = (struct task_struct *)ctx[1];
>>
>>          bpf_task_release(task);
>>
>>          return subprog_release(ctx);;
>> }
>>
>> SEC(".struct_ops.link")
>> struct bpf_testmod_ops subprog_ref = {
>>          .test_refcounted = (void *)test_subprog_ref,
>> };
>>
> 
> Thanks for pointing this out. The test did failed.
> 
>> A quick thought is, I think tracking the ctx's ref id in the env->cur_state may
>> not be the correct place.
> 
> I think it is a bit tricky because subprogs are checked independently
> and their state is folded (i.e., there can be multiple edges from the
> main program to a subprog).
> 
> Maybe the verifier can rewrite the program: set the refcounted ctx to
> NULL when releasing reference. Then, in do_check_common(), if it is a
> global subprog, we mark refcounted ctx as PTR_MAYBE_NULL to force a
> runtime check. How does it sound?

don't know how to get the ctx pointer to patch the code. It is not always in r1.

A case like this should still break even with the PTR_MAYBE_NULL marking in all 
main and subprog (I haven't tried this one myself):

SEC("struct_ops/subprog_ref")
int test_subprog_ref(__u64 *ctx)
{
	struct task_struct *task = (struct task_struct *)ctx[1];

	if (task) {
		subprog_release(ctx);
		bpf_task_release(task);
	}

	return;
}

afaik, the global subprog is checked independently from the main prog and it 
does not know the state of the main prog. Take a look at the subprog_is_global() 
case in the check_func_call().

How about only acquire_reference_state() for the main prog? Yes, the global 
subprog cannot do the bpf_kptr_xchg() and bpf_qdisc_skb_drop() but it can still 
read the skb. The non-global subprog (static) should work though (please test).

I don't have other better idea. May be Alexei can provide some guidance here?


