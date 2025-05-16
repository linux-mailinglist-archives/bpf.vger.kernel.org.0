Return-Path: <bpf+bounces-58427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC4ABA502
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E848A24115
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AAB275874;
	Fri, 16 May 2025 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fwd0Akp+"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC74238176
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430241; cv=none; b=XWcKqqdueo1/FTE+TeWwF0eZdTf5ueaWjor3MTJcrLbWLPuR6Mf0ibZBQj/Z6hFO2YKin6oDSU6luC2axROhRUHGGZSIcVyICq7kptLzctXF+tBsLuCcdB+Z4hg3eQQn2D9avOAf5eEhPpO/eHjJqyyOoqO0vU/U8yjeEbnQ050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430241; c=relaxed/simple;
	bh=LHF0HkGdfGRHE4cCuUwDRoDFnRf0g5T/vDtURNSvMa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU6v9SMP1v7en0GNfOeEHcRwltPsXWz/IVTZkvIIXQ5ERHXGgDA4D/MirRo3OcMvTzyp9raMGmTUog++rt1XtGg4c1ZK7o8noci22UNvzDVCN87HVGQO9Cv6JsgvbPH+v2OD3ZA+gnKzAdX1bRB2C8QlrLH+1WdAakAThA7Keio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fwd0Akp+; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747430235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxmrDqvKKU8li8U6T2rzVwTM5St6THQd9KKy9kPGaIM=;
	b=Fwd0Akp+OqX4GKksWya2HY0MczKWnOisBBhUD+0sxq5WTy1SZ81vhS7NBcb2a9Wtf4t73x
	+fbHMMVN2j5LycxshoJ/pQTBocupyJLi5MAr4DDXaO1e/oL/Bw8dqgrxYnzmvGk2lAIj1R
	8BIXM0FaEO5YhfBF+RVpsKdpZeiE6uE=
Date: Fri, 16 May 2025 14:17:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
 <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/25 6:42 AM, Alexei Starovoitov wrote:
> On Thu, May 15, 2025 at 1:06 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>> bpf_unreachable() is also possible in the middle of the prog.
>> If bpf_unreachable() is hit during normal do_check() verification,
>> verification will fail.
>>
>>    [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>>    [2] https://github.com/llvm/llvm-project/pull/131731
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> What's the difference between v1 and v2 ?
> Pls spell it out in a cover letter or commit log.

Sorry, will have a commit log for the next version including
v1 -> v2 and v2 -> v3, etc.

>
>> ---
>>   kernel/bpf/helpers.c  |  5 +++++
>>   kernel/bpf/verifier.c | 22 +++++++++++++++++++++-
>>   2 files changed, 26 insertions(+), 1 deletion(-)
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
>> index c1113b74e1e2..4852c36b1c51 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3273,6 +3273,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>          local_irq_restore(*flags__irq_flag);
>>   }
>>
>> +__bpf_kfunc void bpf_unreachable(void)
>> +{
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3386,6 +3390,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_unreachable)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f6d3655b3a7a..5496775a884e 100644
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
>> @@ -3399,7 +3400,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
>> @@ -3434,7 +3438,18 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>                          if (code != (BPF_JMP | BPF_EXIT) &&
>>                              code != (BPF_JMP32 | BPF_JA) &&
>>                              code != (BPF_JMP | BPF_JA)) {
>> -                               verbose(env, "last insn is not an exit or jmp\n");
>> +                               verbose_insn(env, &insn[i]);
>> +                               if (btf_vmlinux && insn[i].code == (BPF_CALL | BPF_JMP) &&
>> +                                   insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
> hmm. there is bpf_pseudo_kfunc_call() for that.
>
>> +                                       t = btf_type_by_id(btf_vmlinux, insn[i].imm);
>> +                                       tname = btf_name_by_offset(btf_vmlinux, t->name_off);
>> +                                       if (strcmp(tname, "bpf_unreachable") == 0)
> same issue as in v1. don't do strcmp.
> Especially, since the 2nd hunk of this patch is doing it
> via special_kfunc_list[].

Okay, without strcmp, we essentially will avoid "last insn is not an exit or jmp\n" for
all kfunc's if we want to later special_kfunc_list[] based verification for
bpf_unreachable(). But even if we have this avoidance in check_subprogs(),
in check_cfg()/push_insn, we will hit the following error:

         if (w < 0 || w >= env->prog->len) {
                 verbose_linfo(env, t, "%d: ", t);
                 verbose(env, "jump out of range from insn %d to %d\n", t, w);
                 return -EINVAL;
         }

So I then decided to add an 'exit' insn after bpf_unreachable() in llvm.
See latest https://github.com/llvm/llvm-project/pull/131731 (commit #2).
So we won't have any control flow issues in code. With newer llvm change,
the kernel change will look like:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..4852c36b1c51 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3273,6 +3273,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
         local_irq_restore(*flags__irq_flag);
  }
  
+__bpf_kfunc void bpf_unreachable(void)
+{
+}
+
  __bpf_kfunc_end_defs();
  
  BTF_KFUNCS_START(generic_btf_ids)
@@ -3386,6 +3390,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
  BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_unreachable)
  BTF_KFUNCS_END(common_btf_ids)
  
  static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6d3655b3a7a..4890adc18478 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12122,6 +12122,7 @@ enum special_kfunc_type {
         KF_bpf_res_spin_unlock,
         KF_bpf_res_spin_lock_irqsave,
         KF_bpf_res_spin_unlock_irqrestore,
+       KF_bpf_unreachable,
  };
  
  BTF_SET_START(special_kfunc_set)
@@ -12225,6 +12226,7 @@ BTF_ID(func, bpf_res_spin_lock)
  BTF_ID(func, bpf_res_spin_unlock)
  BTF_ID(func, bpf_res_spin_lock_irqsave)
  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_unreachable)
  
  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
  {
@@ -13525,6 +13527,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
                         return err;
                 }
                 __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
+       } else if (!insn->off && insn->imm == special_kfunc_list[KF_bpf_unreachable]) {
+               verbose(env, "unexpected bpf_unreachable() due to uninitialized variable?\n");
+               return -EFAULT;
         }
  
         if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {

>
>> +                                               is_bpf_unreachable = true;
> why extra bool ?
> Just print the error and return.
>
>> +                               }
>> +                               if (is_bpf_unreachable)
>> +                                       verbose(env, "last insn is bpf_unreachable, due to uninitialized var?\n");
> bpf_unreachable()
>
> ..variable.
>
>> +                               else
>> +                                       verbose(env, "last insn is not an exit or jmp\n");
>>                                  return -EINVAL;
>>                          }
>>                          subprog_start = subprog_end;
>> @@ -12122,6 +12137,7 @@ enum special_kfunc_type {
>>          KF_bpf_res_spin_unlock,
>>          KF_bpf_res_spin_lock_irqsave,
>>          KF_bpf_res_spin_unlock_irqrestore,
>> +       KF_bpf_unreachable,
>>   };
>>
>>   BTF_SET_START(special_kfunc_set)
>> @@ -12225,6 +12241,7 @@ BTF_ID(func, bpf_res_spin_lock)
>>   BTF_ID(func, bpf_res_spin_unlock)
>>   BTF_ID(func, bpf_res_spin_lock_irqsave)
>>   BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>> +BTF_ID(func, bpf_unreachable)
>>
>>   static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>>   {
>> @@ -13525,6 +13542,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                          return err;
>>                  }
>>                  __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
>> +       } else if (insn->imm == special_kfunc_list[KF_bpf_unreachable]) {
>> +               verbose(env, "unexpected hit bpf_unreachable, due to uninit var or incorrect verification?\n");
> !insn->off must be checked as well.

Will add.

> The wording of the message is odd.
> s/unexpected hit bpf_unreachable/unexpected bpf_unreachable()/
>
> and I'd finish with "due to uninitialized variable?"
> Humans will read it. Don't abbreviate.
>
> "incorrect verification" part is weird. It won't convey
> any useful information to users.

Okay, the new verbose message looks like:
   verbose(env, "unexpected bpf_unreachable() due to uninitialized variable?\n");

>
> pw-bot: cr
>
>> +               return -EFAULT;
>>          }
>>
>>          if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
>> --
>> 2.47.1
>>


