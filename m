Return-Path: <bpf+bounces-66498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14FDB351FC
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1D53B8810
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53C2C158E;
	Tue, 26 Aug 2025 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2CVqtMz"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3272C3263
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177222; cv=none; b=taIBluGQ15W70DeFrGAarVf5dHCXEjbocx8zrwCcjVMC3+6qz9Qdx1o4zioGL8LofmHpaFF98Vupvii2Bc1AhoTID1t34WsCDZjWCi9bsJsTYAtQQW3aR2YoMzY8gooEIr4paZWAO3tOX/TlJKSlEUn3H/NX3vAFPtByL7xxAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177222; c=relaxed/simple;
	bh=Dr01xf3X+t87m2TFJHgSqQMx/EzhDVGBb8RBRMueygE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJdPgSuqGrPRHNwBRrN8jERaMz6jJEp8RrYre9NnN/BfdVNsKWx2TnLidIVWGNfFNct9ZRIMF7pZs0CqUgkVHywjCKMkd5vnC4/TkAE95Kt/chwNMAYW9G59uQiI0u0fkTaaRdtLOoQ+Kd7/OnWEoKD76nlXryFzgU59dN3VbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2CVqtMz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756177217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBnr+3gqBKHwxH+XYIunfWRkjyyrH6/vS9zzWyxh4ho=;
	b=r2CVqtMzHN/M/aKBKByK0Hh/6GyHbZYGYJ2c95LoZsABaONDCQFErVfUIpT2A3A878+I7E
	H5yuGRPCC1k+9yWkfj+eFX2KgLnjo/rEVAn+h0ukCy2wzceWVvS1ysv2q4X1hoCSrwudLS
	8VtS6FBibO/c4IHgKWmfDerQCGVf+I0=
Date: Tue, 26 Aug 2025 11:00:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 kernel-patches-bot@fb.com
References: <20250825131502.54269-1-leon.hwang@linux.dev>
 <20250825131502.54269-2-leon.hwang@linux.dev>
 <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 25/8/25 23:17, Alexei Starovoitov wrote:
> On Mon, Aug 25, 2025 at 6:15 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Filtering pid_tgid is meaningless when the current task is preempted by
>> an interrupt.
>>
>> To address this, introduce the bpf_in_interrupt kfunc, which allows BPF
>> programs to determine whether they are executing in interrupt context.
>>
>> This enables programs to avoid applying pid_tgid filtering when running
>> in such contexts.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/helpers.c  |  9 +++++++++
>>  kernel/bpf/verifier.c | 11 +++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 401b4932cc49f..38991b7b4a9e9 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3711,6 +3711,14 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
>>         return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
>>  }
>>
>> +/**
>> + * bpf_in_interrupt - Check whether it's in interrupt context
>> + */
>> +__bpf_kfunc int bpf_in_interrupt(void)
>> +{
>> +       return in_interrupt();
>> +}
> 
> It doesn't scale. Next thing people will ask for hard vs soft irq.
> 

How about adding a 'flags'?

Here are the values for 'flags':

* 0: return in_interrupt();
* 1(NMI): return in_nmi();
* 2(HARDIRQ): return in_hardirq();
* 3(SOFTIRQ): return in_softirq();

>> +
>>  __bpf_kfunc_end_defs();
>>
>>  BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3751,6 +3759,7 @@ BTF_ID_FLAGS(func, bpf_throw)
>>  #ifdef CONFIG_BPF_EVENTS
>>  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
>>  #endif
>> +BTF_ID_FLAGS(func, bpf_in_interrupt, KF_FASTCALL)
>>  BTF_KFUNCS_END(generic_btf_ids)
>>
>>  static const struct btf_kfunc_id_set generic_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5c9dd16b2c56b..e30ecbfc29dad 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12259,6 +12259,7 @@ enum special_kfunc_type {
>>         KF_bpf_res_spin_lock_irqsave,
>>         KF_bpf_res_spin_unlock_irqrestore,
>>         KF___bpf_trap,
>> +       KF_bpf_in_interrupt,
>>  };
>>
>>  BTF_ID_LIST(special_kfunc_list)
>> @@ -12327,6 +12328,7 @@ BTF_ID(func, bpf_res_spin_unlock)
>>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>>  BTF_ID(func, __bpf_trap)
>> +BTF_ID(func, bpf_in_interrupt)
>>
>>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>>  {
>> @@ -21977,6 +21979,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                    desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>>                 insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>>                 *cnt = 1;
>> +       } else if (desc->func_id == special_kfunc_list[KF_bpf_in_interrupt]) {
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>> +               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&__preempt_count);
> 
> I think bpf_per_cpu_ptr() should already be able to read that per cpu var.
> 

Correct. bpf_per_cpu_ptr() and bpf_this_cpu_ptr() are helpful to read it.

So, this patch seems useless.

>> +               insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>> +               insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
>> +               insn_buf[3] = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, NMI_MASK | HARDIRQ_MASK |
>> +                                           (IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : SOFTIRQ_MASK));
> 
> This is still wrong in PREEMPT_RT.
> 

You are right.

Double-check the following macros:

#ifdef CONFIG_PREEMPT_RT
# define softirq_count()        (current->softirq_disable_cnt &
SOFTIRQ_MASK)
# define irq_count()            ((preempt_count() & (NMI_MASK |
HARDIRQ_MASK)) | softirq_count())
#else
# define softirq_count()        (preempt_count() & SOFTIRQ_MASK)
# define irq_count()            (preempt_count() & (NMI_MASK |
HARDIRQ_MASK | SOFTIRQ_MASK))
#endif
#define in_interrupt()          (irq_count())

If PREEMPT_RT, 'softirq_count()' is missing here.

Thanks,
Leon


