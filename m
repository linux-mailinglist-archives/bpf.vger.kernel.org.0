Return-Path: <bpf+bounces-58584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD877ABDEFF
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B291A3B4D93
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F62627E7;
	Tue, 20 May 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm/yBP0H"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443C26136D
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754734; cv=none; b=CNSC0xGa+d3hRRSt1oc92fqa0hkiCDlk1o6lJNsbbfLm9WdhiDLzRjGi5xYDolK51snFtLBDn0jIn1VzuQ5HiuPRqjX5T0aSdQjiqaI9fM3r5xgp5GRoIht/8wpqDOV9s6IYOMb6xImpGRLloOJy4i0B1WOakZpTjvQsbFcq1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754734; c=relaxed/simple;
	bh=6DfwpIfOn8npc3l7DsMsDweGWtOL/Vz4kn5hVnNItWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKvsNs8SYoavCRR9Msnrc8QFGjAhhviDukwitcuer+0UsiYLCpcphPawzb3gXXit7BmUA3asvyxj6lMPyC6Pch3GBRM+gA+9RfZxOyDu06mh4fjxZF5MEnK4IzR4+Y9cvOw12bkWznvnhmW712XCoZV0Ntp6Af+gw0s5xa2OSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm/yBP0H; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747754729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um2NaT/tj1U8C0lGlW1nobs7X5w3hHDp43KzPAdyNyc=;
	b=Hm/yBP0HoU7FWyiRio8gEyUQFPS9D35TGTY/IRvOW497eN5NOy5eaKK4la2d3VwjuciIsB
	Fg7ANBQ+/aSylRA8JGOkAW2czrpMB4e7sL7TTW+uW3MyyalqRKvMhsOOt3IGrXVKRlYJ9x
	phgCRwwH/Sdsu3KObQJsKbYzR095ohY=
Date: Tue, 20 May 2025 08:25:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250519203339.2060080-1-yonghong.song@linux.dev>
 <20250519203344.2060544-1-yonghong.song@linux.dev>
 <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/19/25 6:48 AM, Alexei Starovoitov wrote:
> On Mon, May 19, 2025 at 1:34 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Marc Suñé (Isovalent, part of Cisco) reported an issue where an
>> uninitialized variable caused generating bpf prog binary code not
>> working as expected. The reproducer is in [1] where the flags
>> “-Wall -Werror” are enabled, but there is no warning as the compiler
>> takes advantage of uninitialized variable to do aggressive optimization.
>> The optimized code looks like below:
>>
>>        ; {
>>             0:       bf 16 00 00 00 00 00 00 r6 = r1
>>        ;       bpf_printk("Start");
>>             1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
>>                      0000000000000008:  R_BPF_64_64  .rodata
>>             3:       b4 02 00 00 06 00 00 00 w2 = 0x6
>>             4:       85 00 00 00 06 00 00 00 call 0x6
>>        ; DEFINE_FUNC_CTX_POINTER(data)
>>             5:       61 61 4c 00 00 00 00 00 w1 = *(u32 *)(r6 + 0x4c)
>>        ;       bpf_printk("pre ipv6_hdrlen_offset");
>>             6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x6 ll
>>                      0000000000000030:  R_BPF_64_64  .rodata
>>             8:       b4 02 00 00 17 00 00 00 w2 = 0x17
>>             9:       85 00 00 00 06 00 00 00 call 0x6
>>        <END>
>>
>> The verifier will report the following failure:
>>    9: (85) call bpf_trace_printk#6
>>    last insn is not an exit or jmp
>>
>> The above verifier log does not give a clear hint about how to fix
>> the problem and user may take quite some time to figure out that
>> the issue is due to compiler taking advantage of uninitialized variable.
>>
>> In llvm internals, uninitialized variable usage may generate
>> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
>> uninitialized variable impact on code optimization. So far, llvm
>> BPF backend ignores 'unreachable' IR hence the above code is generated.
>> With clang21 patch [2], those 'unreachable' IR insn are converted
>> to func bpf_unreachable(). In order to maintain proper control flow
>> graph for bpf progs, [2] also adds an 'exit' insn after bpf_unreachable()
>> if bpf_unreachable() is the last insn in the function.
>> The new code looks like:
>>
>>        ; {
>>             0:       bf 16 00 00 00 00 00 00 r6 = r1
>>        ;       bpf_printk("Start");
>>             1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
>>                      0000000000000008:  R_BPF_64_64  .rodata
>>             3:       b4 02 00 00 06 00 00 00 w2 = 0x6
>>             4:       85 00 00 00 06 00 00 00 call 0x6
>>        ; DEFINE_FUNC_CTX_POINTER(data)
>>             5:       61 61 4c 00 00 00 00 00 w1 = *(u32 *)(r6 + 0x4c)
>>        ;       bpf_printk("pre ipv6_hdrlen_offset");
>>             6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x6 ll
>>                      0000000000000030:  R_BPF_64_64  .rodata
>>             8:       b4 02 00 00 17 00 00 00 w2 = 0x17
>>             9:       85 00 00 00 06 00 00 00 call 0x6
>>            10:       85 10 00 00 ff ff ff ff call -0x1
>>                      0000000000000050:  R_BPF_64_32  bpf_unreachable
>>            11:       95 00 00 00 00 00 00 00 exit
>>        <END>
>>
>> In kernel, a new kfunc bpf_unreachable() is added. During insn
>> verification, any hit with bpf_unreachable() will result in
>> verification failure. The kernel is able to provide better
>> log message for debugging.
>>
>> With llvm patch [2] and without this patch (no bpf_unreachable()
>> kfunc for existing kernel), e.g., for old kernels, the verifier
>> outputs
>>    10: <invalid kfunc call>
>>    kfunc 'bpf_unreachable' is referenced but wasn't resolved
>> Basically, kernel does not support bpf_unreachable() kfunc.
>> This still didn't give clear signals about possible reason.
>>
>> With llvm patch [2] and with this patch, the verifier outputs
>>    10: (85) call bpf_unreachable#74479
>>    unexpected bpf_unreachable() due to uninitialized variable?
>> It gives much better hints for verification failure.
>>
>>    [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>>    [2] https://github.com/llvm/llvm-project/pull/131731
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/helpers.c  | 5 +++++
>>   kernel/bpf/verifier.c | 5 +++++
>>   2 files changed, 10 insertions(+)
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
>> index d5807d2efc92..08013e2e1697 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12105,6 +12105,7 @@ enum special_kfunc_type {
>>          KF_bpf_res_spin_unlock,
>>          KF_bpf_res_spin_lock_irqsave,
>>          KF_bpf_res_spin_unlock_irqrestore,
>> +       KF_bpf_unreachable,
>>   };
>>
>>   BTF_SET_START(special_kfunc_set)
>> @@ -12208,6 +12209,7 @@ BTF_ID(func, bpf_res_spin_lock)
>>   BTF_ID(func, bpf_res_spin_unlock)
>>   BTF_ID(func, bpf_res_spin_lock_irqsave)
>>   BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>> +BTF_ID(func, bpf_unreachable)
>>
>>   static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>>   {
>> @@ -13508,6 +13510,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                          return err;
>>                  }
>>                  __mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
>> +       } else if (!insn->off && insn->imm == special_kfunc_list[KF_bpf_unreachable]) {
> Looks good, but let's not abuse special_kfunc_list[] for this case.
> special_kfunc_type supposed to be in both set[] and list[].
> This is not the case here.
> It was wrong to add KF_bpf_set_dentry_xattr, bpf_iter_css_task_new,
> bpf_dynptr_from_skb, and many others.
> Let's fix this tech debt that we accumulated.
>
> special_kfunc_type should include only kfuncs that return
> a pointer, so that this part is triggered:
>
>          } else if (btf_type_is_ptr(t)) {
>                  ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
> &ptr_type_id);
>
>                  if (meta.btf == btf_vmlinux &&
> btf_id_set_contains(&/special_kfunc_set, meta.func_id)) {
>
> All other kfuncs shouldn't be there. They don't need to be in
> the special_kfunc_set.
>
> Let's split enum special_kfunc_type into what it meant to be
> originally (both set and list), and move all list-only kfuncs
> into a new array.
> Let's call it kfunc_ids.
> Then the check in this patch will look like:
> insn->imm == kfunc_ids[KF_bpf_unreachable]

IIUC, the main goal is to remove some kfuncs from special_kfunc_set
since they are unnecessary.

I think we do not need an 'enum' type for special_kfunc_set since
the for all kfuncs in special_kfunc_set, btf_id_set_contains()
is used to find corresponding btf_id. So current 'enum special_kfunc_type'
is only used for special_kfunc_list to find proper kfunc_id's.

I think the following change should achieve this:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 08013e2e1697..2cf00b06ae66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12060,7 +12060,7 @@ enum kfunc_ptr_arg_type {
         KF_ARG_PTR_TO_RES_SPIN_LOCK,
  };
  
-enum special_kfunc_type {
+enum special_kfunc_list_type {
         KF_bpf_obj_new_impl,
         KF_bpf_obj_drop_impl,
         KF_bpf_refcount_acquire_impl,
@@ -12126,24 +12126,10 @@ BTF_ID(func, bpf_rbtree_first)
  BTF_ID(func, bpf_rbtree_root)
  BTF_ID(func, bpf_rbtree_left)
  BTF_ID(func, bpf_rbtree_right)
-#ifdef CONFIG_NET
-BTF_ID(func, bpf_dynptr_from_skb)
-BTF_ID(func, bpf_dynptr_from_xdp)
-#endif
  BTF_ID(func, bpf_dynptr_slice)
  BTF_ID(func, bpf_dynptr_slice_rdwr)
-BTF_ID(func, bpf_dynptr_clone)
  BTF_ID(func, bpf_percpu_obj_new_impl)
  BTF_ID(func, bpf_percpu_obj_drop_impl)
-BTF_ID(func, bpf_throw)
-BTF_ID(func, bpf_wq_set_callback_impl)
-#ifdef CONFIG_CGROUPS
-BTF_ID(func, bpf_iter_css_task_new)
-#endif
-#ifdef CONFIG_BPF_LSM
-BTF_ID(func, bpf_set_dentry_xattr)
-BTF_ID(func, bpf_remove_dentry_xattr)
-#endif
  BTF_SET_END(special_kfunc_set)
  
  BTF_ID_LIST(special_kfunc_list)

I renamed 'enum special_kfunc_type' to 'enum special_kfunc_list_type'
implying that the enum values in special_kfunc_lit_type has
1:1 relation to special_kfunc_list.

WDYT?

>
> Digging through the code it looks like we made a bit of a mess there.
> Like this part:
>          } else if (btf_type_is_void(t)) {
>                  if (meta.btf == btf_vmlinux &&
> btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
>                          if (meta.func_id ==
> special_kfunc_list[KF_bpf_obj_drop_impl] ||
>                              meta.func_id ==
> special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
>
>
> *obj_drop don't need to be in a set,
> and btf_id_set_contains() doesn't need to be called.
> Both kfuncs should be moved to new kfunc_ids[]

As you mentioned, for this one, we can do

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2cf00b06ae66..a3ff57eaa5f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12110,7 +12110,6 @@ enum special_kfunc_list_type {
  
  BTF_SET_START(special_kfunc_set)
  BTF_ID(func, bpf_obj_new_impl)
-BTF_ID(func, bpf_obj_drop_impl)
  BTF_ID(func, bpf_refcount_acquire_impl)
  BTF_ID(func, bpf_list_push_front_impl)
  BTF_ID(func, bpf_list_push_back_impl)
@@ -12129,7 +12128,6 @@ BTF_ID(func, bpf_rbtree_right)
  BTF_ID(func, bpf_dynptr_slice)
  BTF_ID(func, bpf_dynptr_slice_rdwr)
  BTF_ID(func, bpf_percpu_obj_new_impl)
-BTF_ID(func, bpf_percpu_obj_drop_impl)
  BTF_SET_END(special_kfunc_set)
  
  BTF_ID_LIST(special_kfunc_list)
@@ -13909,7 +13907,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
                 if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
                         regs[BPF_REG_0].id = ++env->id_gen;
         } else if (btf_type_is_void(t)) {
-               if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
+               if (meta.btf == btf_vmlinux) {
                         if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
                             meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
                                 insn_aux->kptr_struct_meta =


