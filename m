Return-Path: <bpf+bounces-58137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE06AB5C01
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81574860CE7
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1D1E8328;
	Tue, 13 May 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8yGBayE"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01111A0BF3
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159568; cv=none; b=aDY+ZZrZelG6fj87K2nB8wdCEwGaqDs2IhHESpRcCxeR4DjZErI//QKXrsoKZR/i3wUATZSGv+Qagf/pNfBPHhx8A8Nawrve+Svu3AyLbxsZ1GIZxBvwzC1+CX6SR0xOakUpjmWqZMhq1TTNY7XoFjUohTpuoYBr2mpSR2QJ3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159568; c=relaxed/simple;
	bh=PkKWv8aatNKj9KIGqiVY34pw/2XDArJp5rXFNG0xwjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsU6jZnV1TQXVdeymQMK7H3tqXeIkmp82d5pdK6X8OzoteudiYNKD4xo+QMNwhbsu89QSNaO2PkqefS01zhk6bHQZi1U1K+JXGEArzmOQFe2MeuNTE2DLbaHu/9Ltb4+AU7d3uafJ5WkzOBVSQ/NbKin25tM0Ch4Fk9pP3DrhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8yGBayE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96833998-caf4-4d68-9aac-a81d87c7bcf7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747159562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXH5IuxXeHOhdrJBxEH4M4+mYB11v3pDrtZ3cTpwXJQ=;
	b=n8yGBayECiQtMjxlra+9IXiJ9VkIJ0YWHOQgVfvZ+yOKgmEbwqvTyvYaaime/WKaV97WB9
	ST2sbB6wHuimjWtH+EO71RCN06J0vMNs6ver0f1dxKTVwkv4eB9y1gnP1qLTEqoVCaX6XC
	+zBlJS+7yOP71jd9wnMCiRbvdq7qkPs=
Date: Tue, 13 May 2025 11:05:56 -0700
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
 <a07347c2-3941-4d21-a8d2-9e957ad8368b@linux.dev>
 <CAADnVQJr1WCQ9UE91cbO3jjd3jn4he9SZuZgsdLy3+HOdjviLQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJr1WCQ9UE91cbO3jjd3jn4he9SZuZgsdLy3+HOdjviLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/13/25 10:54 PM, Alexei Starovoitov wrote:
> On Mon, May 12, 2025 at 10:49 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 5/11/25 8:30 AM, Alexei Starovoitov wrote:
>>> On Sun, May 11, 2025 at 11:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Marc Suñé (Isovalent, part of Cisco) reported an issue where an
>>>> uninitialized variable caused generating bpf prog binary code not
>>>> working as expected. The reproducer is in [1] where the flags
>>>> “-Wall -Werror” are enabled, but there is no warning and compiler
>>>> may take advantage of uninit variable to do aggressive optimization.
>>>>
>>>> In llvm internals, uninitialized variable usage may generate
>>>> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
>>>> uninit var impact on code optimization. With clang21 patch [2],
>>>> those 'unreachable' IR insn are converted to func bpf_unreachable().
>>>>
>>>> In kernel, a new kfunc bpf_unreachable() is added. If this kfunc
>>>> (generated by [2]) is the last insn in the main prog or a subprog,
>>>> the verifier will suggest the verification failure may be due to
>>>> uninitialized var, so user can check their source code to find the
>>>> root cause.
>>>>
>>>> Without this patch, the verifier will output
>>>>     last insn is not an exit or jmp
>>>> and user will not know what is the potential root cause and
>>>> it will take more time to debug this verification failure.
>>>>
>>>>     [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>>>>     [2] https://github.com/llvm/llvm-project/pull/131731
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    kernel/bpf/helpers.c  |  5 +++++
>>>>    kernel/bpf/verifier.c | 17 ++++++++++++++++-
>>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> In order to compile kernel successfully with the above [2], the following
>>>> change is needed due to clang21 changes:
>>>>
>>>>     --- a/Makefile
>>>>     +++ b/Makefile
>>>>     @@ -852,7 +852,7 @@ endif
>>>>      endif # may-sync-config
>>>>      endif # need-config
>>>>
>>>>     -KBUILD_CFLAGS  += -fno-delete-null-pointer-checks
>>>>     +KBUILD_CFLAGS  += -fno-delete-null-pointer-checks -Wno-default-const-init-field-unsafe
>>>>
>>>>     --- a/scripts/Makefile.extrawarn
>>>>     +++ b/scripts/Makefile.extrawarn
>>>>     @@ -19,6 +19,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
>>>>      KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>>>>      KBUILD_CFLAGS += -Wmissing-declarations
>>>>      KBUILD_CFLAGS += -Wmissing-prototypes
>>>>     +KBUILD_CFLAGS += -Wno-default-const-init-var-unsafe
>>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index fed53da75025..6048d7e19d4c 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -3283,6 +3283,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>>>           local_irq_restore(*flags__irq_flag);
>>>>    }
>>>>
>>>> +__bpf_kfunc void bpf_unreachable(void)
>>>> +{
>>>> +}
>>> Does it have to be an actual function with the body?
>>> Can it be a kfunc that doesn't consume any .text ?
>> I tried to define bpf_unreachable as an extern function, but
>> it does not work as a __bpf_kfunc. I agree that we do not
>> need to consume any bytes in .text section for bpf_unreachable.
>> I have not found a solution for that yet.
> Have you tried marking it as 'naked' and empty body?

With or without 'naked' attribute, 32 byte text will be
consumed:

ffffffff8188daa0 <__pfx_bpf_unreachable>:
ffffffff8188daa0: 90                    nop
ffffffff8188daa1: 90                    nop
ffffffff8188daa2: 90                    nop
ffffffff8188daa3: 90                    nop
ffffffff8188daa4: 90                    nop
ffffffff8188daa5: 90                    nop
ffffffff8188daa6: 90                    nop
ffffffff8188daa7: 90                    nop
ffffffff8188daa8: 90                    nop
ffffffff8188daa9: 90                    nop
ffffffff8188daaa: 90                    nop
ffffffff8188daab: 90                    nop
ffffffff8188daac: 90                    nop
ffffffff8188daad: 90                    nop
ffffffff8188daae: 90                    nop
ffffffff8188daaf: 90                    nop

ffffffff8188dab0 <bpf_unreachable>:
ffffffff8188dab0: f3 0f 1e fa           endbr64
ffffffff8188dab4: 0f 1f 44 00 00        nopl    (%rax,%rax)
ffffffff8188dab9: 0f 1f 80 00 00 00 00  nopl    (%rax)

>
>>>> +
>>>>    __bpf_kfunc_end_defs();
>>>>
>>>>    BTF_KFUNCS_START(generic_btf_ids)
>>>> @@ -3388,6 +3392,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>>>>    BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>>>    BTF_ID_FLAGS(func, bpf_local_irq_save)
>>>>    BTF_ID_FLAGS(func, bpf_local_irq_restore)
>>>> +BTF_ID_FLAGS(func, bpf_unreachable)
>>>>    BTF_KFUNCS_END(common_btf_ids)
>>>>
>>>>    static const struct btf_kfunc_id_set common_kfunc_set = {
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 28f5a7899bd6..d26aec0a90d0 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
>>>>    static void specialize_kfunc(struct bpf_verifier_env *env,
>>>>                                u32 func_id, u16 offset, unsigned long *addr);
>>>>    static bool is_trusted_reg(const struct bpf_reg_state *reg);
>>>> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
>>>>
>>>>    static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>>>>    {
>>>> @@ -3398,7 +3399,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>>>           int i, subprog_start, subprog_end, off, cur_subprog = 0;
>>>>           struct bpf_subprog_info *subprog = env->subprog_info;
>>>>           struct bpf_insn *insn = env->prog->insnsi;
>>>> +       bool is_bpf_unreachable = false;
>>>>           int insn_cnt = env->prog->len;
>>>> +       const struct btf_type *t;
>>>> +       const char *tname;
>>>>
>>>>           /* now check that all jumps are within the same subprog */
>>>>           subprog_start = subprog[cur_subprog].start;
>>>> @@ -3433,7 +3437,18 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>>>                           if (code != (BPF_JMP | BPF_EXIT) &&
>>>>                               code != (BPF_JMP32 | BPF_JA) &&
>>>>                               code != (BPF_JMP | BPF_JA)) {
>>>> -                               verbose(env, "last insn is not an exit or jmp\n");
>>>> +                               verbose_insn(env, &insn[i]);
>>>> +                               if (btf_vmlinux && insn[i].code == (BPF_CALL | BPF_JMP) &&
>>>> +                                   insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>> +                                       t = btf_type_by_id(btf_vmlinux, insn[i].imm);
>>>> +                                       tname = btf_name_by_offset(btf_vmlinux, t->name_off);
>>>> +                                       if (strcmp(tname, "bpf_unreachable") == 0)
>>> the check by name is not pretty.
>>>
>>>> +                                               is_bpf_unreachable = true;
>>>> +                               }
>>>> +                               if (is_bpf_unreachable)
>>>> +                                       verbose(env, "last insn is bpf_unreachable, due to uninitialized var?\n");
>>>> +                               else
>>>> +                                       verbose(env, "last insn is not an exit or jmp\n");
>>> This is too specific imo.
>>> add_subprog_and_kfunc() -> add_kfunc_call()
>>> should probably handle it instead,
>>> and print that error.
>> add_subprog_and_kfunc() -> add_kfunc_call() approach probably won't work.
>> The error should be emitted only if the verifier (through path sensitive
>> analysis) reaches bpf_unreachable().
>>
>> if bpf_unreachable() exists in the bpf prog, but verifier cannot reach it
>> during verification process, error will not printed.
> you mean when bpf_unreachable() in the actual dead code
> then the verifier shouldn't error ? Makes sense.

Right. This is what I intend to do.

>
>>> It doesn't matter that call bpf_unreachable is the last insn
>>> of a program or subprogram.
>>> I suspect llvm can emit it anywhere.
>> It is totally possible that bpf_unreachable may appear in the middle of
>> code. But based on past examples, bpf_unreachable tends to be in the
>> last insn and it may be targetted from multiple sources. This also makes
>> code easier to understand. I can dig into llvm internal a little bit
>> more to find how llvm places 'unreachable' IR insns.
> I recall Anton hit some odd case of unreachable code with
> upcoming indirect goto/call work.
> If llmv starts emitting call bpf_unreachable that may be another case.

The following is the related jump table code:

0000000000000700 <foo>:
;       switch (ctx->x) {
      224:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0x0)
      225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0x88>
      226:       67 01 00 00 03 00 00 00 r1 <<= 0x3
      227:       18 02 00 00 a8 00 00 00 00 00 00 00 00 00 00 00 r2 = 0xa8 ll
                 0000000000000718:  R_BPF_64_64  .rodata
      229:       0f 12 00 00 00 00 00 00 r2 += r1
      230:       79 21 00 00 00 00 00 00 r1 = *(u64 *)(r2 + 0x0)
      231:       0d 01 00 00 00 00 00 00 gotox r1
      232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
      233:       b7 01 00 00 02 00 00 00 r1 = 0x2
;       switch (ctx->x) {
      234:       05 00 07 00 00 00 00 00 goto +0x7 <foo+0x90>
      235:       b7 01 00 00 04 00 00 00 r1 = 0x4
;               break;
      236:       05 00 05 00 00 00 00 00 goto +0x5 <foo+0x90>
      237:       b7 01 00 00 03 00 00 00 r1 = 0x3
;               break;
      238:       05 00 03 00 00 00 00 00 goto +0x3 <foo+0x90>
      239:       b7 01 00 00 05 00 00 00 r1 = 0x5
;               break;
      240:       05 00 01 00 00 00 00 00 goto +0x1 <foo+0x90>
      241:       b7 01 00 00 13 00 00 00 r1 = 0x13
      242:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
                 0000000000000790:  R_BPF_64_64  ret_user
      244:       7b 12 00 00 00 00 00 00 *(u64 *)(r2 + 0x0) = r1
;       return 0;
      245:       b4 00 00 00 00 00 00 00 w0 = 0x0
      246:       95 00 00 00 00 00 00 00 exit

The insn
      232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
is actually unreachable although LLVM generates 'goto +0x8'.
So it is possible that llvm may generate 'unreachable' insn
for the above insn 232.


