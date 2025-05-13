Return-Path: <bpf+bounces-58099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF3AB4B74
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 07:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBE1888E2E
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A81E98FE;
	Tue, 13 May 2025 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISjJXNZf"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3011E8329
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747115367; cv=none; b=neKAovY17FxNNAjF0irErigos7EEVL6E5+2R4dnhLOuaDZY5sXxZIBDoy+vKW7vxaoF05YOuRyltIeb40EG2lopO0j+iGlf8gOzBpwZlwB8bJuFCloZrcmqRXMtaXRfNfkgkBCq0WEoN5EEpuRsyWnaLsbajDc9Diuz3MKGsc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747115367; c=relaxed/simple;
	bh=g6NCP6P1K2VR8cJ78sfBEgS0wPHXtBKseOh02B0PBBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaIa3myVOIA6OptVkwsW1ZzJJJVfDnVKTfyPGFYaZATlmFEnXO663IO6Z74Jnw0sjtqqXDe4M822vAd/Zjw2Lq3MNE5Ej0cEB2fLFeD442F7pStFR4nkGos6ZjGAvrfoiSnq4aRLfjTqr3EdABkNWCOeBQiLlpEcsEuWYj/L2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISjJXNZf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a07347c2-3941-4d21-a8d2-9e957ad8368b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747115361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVPGMmzlGNvDmYeCcXS6Pss2Rc98l/l74HHIXaqfS1o=;
	b=ISjJXNZfp1mcFYV/l7gFEPmm9OLngnUCCkkMRxgNEXjYMqhyGYSrWcZ0SfR1X7LwBmIkRi
	LBBkj56ZgSyFMTPbH2ou8ZlmqPSUout1gNThyj3PUsDylNik/sCIC0nMJzDs0VSt6g4S7h
	QiURxjqu2fVNd21OAy0zWOC1/5+zy9Q=
Date: Mon, 12 May 2025 22:49:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Warn with new bpf_unreachable() kfunc
 maybe due to uninitialized var
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250511182744.1806792-1-yonghong.song@linux.dev>
 <CAADnVQKi30n+BkRpWKztBnFJ1tsejJYE6f=XtGUodvozZar6PA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKi30n+BkRpWKztBnFJ1tsejJYE6f=XtGUodvozZar6PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/11/25 8:30 AM, Alexei Starovoitov wrote:
> On Sun, May 11, 2025 at 11:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Marc Suñé (Isovalent, part of Cisco) reported an issue where an
>> uninitialized variable caused generating bpf prog binary code not
>> working as expected. The reproducer is in [1] where the flags
>> “-Wall -Werror” are enabled, but there is no warning and compiler
>> may take advantage of uninit variable to do aggressive optimization.
>>
>> In llvm internals, uninitialized variable usage may generate
>> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
>> uninit var impact on code optimization. With clang21 patch [2],
>> those 'unreachable' IR insn are converted to func bpf_unreachable().
>>
>> In kernel, a new kfunc bpf_unreachable() is added. If this kfunc
>> (generated by [2]) is the last insn in the main prog or a subprog,
>> the verifier will suggest the verification failure may be due to
>> uninitialized var, so user can check their source code to find the
>> root cause.
>>
>> Without this patch, the verifier will output
>>    last insn is not an exit or jmp
>> and user will not know what is the potential root cause and
>> it will take more time to debug this verification failure.
>>
>>    [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>>    [2] https://github.com/llvm/llvm-project/pull/131731
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/helpers.c  |  5 +++++
>>   kernel/bpf/verifier.c | 17 ++++++++++++++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> In order to compile kernel successfully with the above [2], the following
>> change is needed due to clang21 changes:
>>
>>    --- a/Makefile
>>    +++ b/Makefile
>>    @@ -852,7 +852,7 @@ endif
>>     endif # may-sync-config
>>     endif # need-config
>>
>>    -KBUILD_CFLAGS  += -fno-delete-null-pointer-checks
>>    +KBUILD_CFLAGS  += -fno-delete-null-pointer-checks -Wno-default-const-init-field-unsafe
>>
>>    --- a/scripts/Makefile.extrawarn
>>    +++ b/scripts/Makefile.extrawarn
>>    @@ -19,6 +19,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
>>     KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>>     KBUILD_CFLAGS += -Wmissing-declarations
>>     KBUILD_CFLAGS += -Wmissing-prototypes
>>    +KBUILD_CFLAGS += -Wno-default-const-init-var-unsafe
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index fed53da75025..6048d7e19d4c 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3283,6 +3283,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>          local_irq_restore(*flags__irq_flag);
>>   }
>>
>> +__bpf_kfunc void bpf_unreachable(void)
>> +{
>> +}
> Does it have to be an actual function with the body?
> Can it be a kfunc that doesn't consume any .text ?

I tried to define bpf_unreachable as an extern function, but
it does not work as a __bpf_kfunc. I agree that we do not
need to consume any bytes in .text section for bpf_unreachable.
I have not found a solution for that yet.

>
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3388,6 +3392,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_local_irq_save)
>>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
>> +BTF_ID_FLAGS(func, bpf_unreachable)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 28f5a7899bd6..d26aec0a90d0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
>>   static void specialize_kfunc(struct bpf_verifier_env *env,
>>                               u32 func_id, u16 offset, unsigned long *addr);
>>   static bool is_trusted_reg(const struct bpf_reg_state *reg);
>> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
>>
>>   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>>   {
>> @@ -3398,7 +3399,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>          int i, subprog_start, subprog_end, off, cur_subprog = 0;
>>          struct bpf_subprog_info *subprog = env->subprog_info;
>>          struct bpf_insn *insn = env->prog->insnsi;
>> +       bool is_bpf_unreachable = false;
>>          int insn_cnt = env->prog->len;
>> +       const struct btf_type *t;
>> +       const char *tname;
>>
>>          /* now check that all jumps are within the same subprog */
>>          subprog_start = subprog[cur_subprog].start;
>> @@ -3433,7 +3437,18 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>                          if (code != (BPF_JMP | BPF_EXIT) &&
>>                              code != (BPF_JMP32 | BPF_JA) &&
>>                              code != (BPF_JMP | BPF_JA)) {
>> -                               verbose(env, "last insn is not an exit or jmp\n");
>> +                               verbose_insn(env, &insn[i]);
>> +                               if (btf_vmlinux && insn[i].code == (BPF_CALL | BPF_JMP) &&
>> +                                   insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
>> +                                       t = btf_type_by_id(btf_vmlinux, insn[i].imm);
>> +                                       tname = btf_name_by_offset(btf_vmlinux, t->name_off);
>> +                                       if (strcmp(tname, "bpf_unreachable") == 0)
> the check by name is not pretty.
>
>> +                                               is_bpf_unreachable = true;
>> +                               }
>> +                               if (is_bpf_unreachable)
>> +                                       verbose(env, "last insn is bpf_unreachable, due to uninitialized var?\n");
>> +                               else
>> +                                       verbose(env, "last insn is not an exit or jmp\n");
> This is too specific imo.
> add_subprog_and_kfunc() -> add_kfunc_call()
> should probably handle it instead,
> and print that error.

add_subprog_and_kfunc() -> add_kfunc_call() approach probably won't work.
The error should be emitted only if the verifier (through path sensitive
analysis) reaches bpf_unreachable().

if bpf_unreachable() exists in the bpf prog, but verifier cannot reach it
during verification process, error will not printed.

> It doesn't matter that call bpf_unreachable is the last insn
> of a program or subprogram.
> I suspect llvm can emit it anywhere.

It is totally possible that bpf_unreachable may appear in the middle of 
code. But based on past examples, bpf_unreachable tends to be in the 
last insn and it may be targetted from multiple sources. This also makes 
code easier to understand. I can dig into llvm internal a little bit 
more to find how llvm places 'unreachable' IR insns.


