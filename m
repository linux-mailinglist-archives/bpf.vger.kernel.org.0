Return-Path: <bpf+bounces-58684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38284ABFF03
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B639E530A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C6822D4DE;
	Wed, 21 May 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQBGCDsW"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A21A0BFA
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863359; cv=none; b=pNZ9Vbh/g6Yi5pRjkJOz0M6RN/kZODotEEgy4PY+x/yd8ToACyZcoCZXvvtsJ8pLkmvIdmAoaG5oqbK4znsLjRf1b3RVc8z5RjgwHGV3gA8+RNzQ6XT56xofl3ks+gNM6lLGGRYcV2hYhdI54D0yW3Zz1ysWOhcQEgsNN9jP8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863359; c=relaxed/simple;
	bh=ksTK273b6WFFZ6+N889A4xJr4hNpPI3f+AFa0evT3ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcEOu9w6vZjxj/KvTvmX7OUkE4t3OY+wdLAlNFIwZEG3I+H2y9f6SWgX3E5XNgAct7CavOD0aLky+EKdZiLEz+Hpm0onykdSkyPq0/ooQPVd4R6xQpxcq1O18cRsb7YbzGh59cjJm1QbF3+QpMQVXvCZEbOxF/Cl3AMCjVO6r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQBGCDsW; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6885590a-266e-4230-9eeb-4fbfd7e2f3f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747863354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Epa/526VlmBsZbJzMgTrBdLagpNkNDtjWhVsbQGUL0=;
	b=jQBGCDsWJczXkfNJkf7DijHgLGg5AtWWsgyoumImZab5N5ptzjbRfxM14nKMC0ZxvTsKA9
	3N45wa4oWOnPrCpysQmMvG6/asYbiCDHWSC40tVFwDoTzd4nZNIdwaSAYQanBHjhnrsE5T
	oV9LouGteGkmU3se968ylNeVa3VmByA=
Date: Wed, 21 May 2025 14:35:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
 <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev> <m2ikltd6kz.fsf@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <m2ikltd6kz.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/21/25 1:58 PM, Eduard Zingerman wrote:
> Yonghong Song <yonghong.song@linux.dev> writes:
>
> [...]
>
>>>> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct
>>>> bpf_verifier_state *vstate, struct bpf_reg_s
>>>>        }
>>>>    }
>>>>    +static int push_cond_jmp_history(struct bpf_verifier_env *env,
>>>> struct bpf_verifier_state *state,
>>>> +                 struct bpf_reg_state *dst_reg, struct
>>>> bpf_reg_state *src_reg,
>>>> +                 u64 linked_regs)
>>>> +{
>>>> +    bool dreg_stack_ptr, sreg_stack_ptr;
>>>> +    int insn_flags;
>>>> +
>>>> +    if (!src_reg) {
>>>> +        if (linked_regs)
>>>> +            return push_insn_history(env, state, 0, linked_regs);
>>>> +        return 0;
>>>> +    }
>>> Nit: this 'if' is not needed, src_reg is always set (it might point
>>> to a fake register,
>>>       but in that case it is a scalar without id).
>>>
>> Here, there is a bug here. Thanks for pointing this out. I need to check
>> BPF_SRC(insn->code) != BPF_X instead of "!src_reg". Basically passing one
>> more parameter (e.g., faked_sreg) to decide whether src_reg is faked or not.
> I don't think any checks are needed.
> Fake register is always scalar and it cannot be collected as a linked register.
> So it won't end up in the instruction history flags.

Let us say that we remove the code

+    if (!src_reg) {
+        if (linked_regs)
+            return push_insn_history(env, state, 0, linked_regs);
+        return 0;
+    }

The code should still work. But we might end up with more unnecessary
jump history entries. For example,
    dreg->type == PTR_TO_STACK, sreg is faked (i.e., BPF_SRC(insn->code) == BPF_K)
    and linked_regs = 0

In this particular, we will still generate a jump table entry which
is not used in backtrack_insn().

>
> [...]


