Return-Path: <bpf+bounces-40590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14898A9D3
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583611F23741
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F10192D84;
	Mon, 30 Sep 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L/wPzxlO"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822223BB24
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714033; cv=none; b=CJVcRos5ohIpwFCGVOFE9YG76MKl0P8aCaYKoB4/4ZVhtrIn+236+P0KIUszA8nZ55p8jMKGjK9dwDibKuR5/NSGnyiNgo1p8aDw8uWa1ust1kxmAOT3QrClFFXqDzwqnJl5M3Rh9E+UF0zB0vDRlLMEC3BmuapneA/4A3rPm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714033; c=relaxed/simple;
	bh=fJ0QAKnxlc/5LLRj35fK7RrOOaDFB3qxBZybQx835dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9bUdfQTyMie4zZeuXE7j+1UrgZoi0EpkBKh5eC5IuVj+/g2vTyFp99MZN9bAvBj5amNdczU5+rZ+lp3Lnetp8B6OjErQzFCmxr4gYW9TEXyJ9nnS+LPpsxFOZD88II412WRYvkEX/Uw/b6XYM1Y8Zunlevt6Y8mp/gh3fSGubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L/wPzxlO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06f3db51-6bc7-4318-9b15-ae694cca7aad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727714029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WokSy989cMOLXrkf0ZMfpTlHurG8Wf45TpV+nANyQwg=;
	b=L/wPzxlOFOzsWBSKL5yECWV9riFLsoQP2NdRzwxJULpBySuNHY2vt/iJYkLbT5j9FcHCLj
	Kvk9xucbxbZJtOAdcMxiHrPLlxiJ1PogJIA44PUgpADynE8AjWITwCv6WgFgptW3dF9Jc1
	1n98qI7seFmj+eRtN6S9+toa/szkP9U=
Date: Mon, 30 Sep 2024 09:33:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev>
 <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/30/24 8:03 AM, Alexei Starovoitov wrote:
> On Thu, Sep 26, 2024 at 4:45 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add jit support for private stack. For a particular subtree, e.g.,
>>    subtree_root <== stack depth 120
>>     subprog1    <== stack depth 80
>>      subprog2   <== stack depth 40
>>     subprog3    <== stack depth 160
>>
>> Let us say that private_stack_ptr is the memory address allocated for
>> private stack. The frame pointer for each above is calculated like below:
>>    subtree_root  <== subtree_root_fp = private_stack_ptr + 120
>>     subprog1     <== subtree_subprog1_fp = subtree_root_fp + 80
>>      subprog2    <== subtree_subprog2_fp = subtree_subprog1_fp + 40
>>     subprog3     <== subtree_subprog1_fp = subtree_root_fp + 160
>>
>> For any function call to helper/kfunc, push/pop prog frame pointer
>> is needed in order to preserve frame pointer value.
>>
>> To deal with exception handling, push/pop frame pointer is also used
>> surrounding call to subsequent subprog. For example,
>>    subtree_root
>>     subprog1
>>       ...
>>       insn: call bpf_throw
>>       ...
>>
>> After jit, we will have
>>    subtree_root
>>     insn: push r9
>>     subprog1
>>       ...
>>       insn: push r9
>>       insn: call bpf_throw
>>       insn: pop r9
>>       ...
>>     insn: pop r9
>>
>>    exception_handler
>>       pop r9
>>       ...
>> where r9 represents the fp for each subprog.
> Kumar,
> please review the interaction of priv_stack with exceptions.
>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa5..c264822c926b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -325,6 +325,22 @@ struct jit_context {
>>   /* Number of bytes that will be skipped on tailcall */
>>   #define X86_TAIL_CALL_OFFSET   (12 + ENDBR_INSN_SIZE)
>>
>> +static void push_r9(u8 **pprog)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       EMIT2(0x41, 0x51);   /* push r9 */
>> +       *pprog = prog;
>> +}
>> +
>> +static void pop_r9(u8 **pprog)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       EMIT2(0x41, 0x59);   /* pop r9 */
>> +       *pprog = prog;
>> +}
>> +
>>   static void push_r12(u8 **pprog)
>>   {
>>          u8 *prog = *pprog;
>> @@ -491,7 +507,7 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
>>    */
>>   static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>                            bool tail_call_reachable, bool is_subprog,
>> -                         bool is_exception_cb)
>> +                         bool is_exception_cb, enum bpf_pstack_state  pstack)
> enum bpf_priv_stack_mode priv_stack_mode

Okay.

>
>>   {
>>          u8 *prog = *pprog;
>>
>> @@ -518,6 +534,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>                   * first restore those callee-saved regs from stack, before
>>                   * reusing the stack frame.
>>                   */
>> +               if (pstack)
>> +                       pop_r9(&prog);
> This is an unnecessary cognitive load, since readers
> need to remember absolute values of enum.
> Just use
> if (priv_stack_mode != NO_PRIV_STACK)

Will do.

>
>>                  pop_callee_regs(&prog, all_callee_regs_used);
>>                  pop_r12(&prog);
>>                  /* Reset the stack frame. */
>> @@ -1404,6 +1422,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>          *pprog = prog;
>>   }
>>
>> +static void emit_private_frame_ptr(u8 **pprog, void *private_frame_ptr)
>> +{
>> +       u8 *prog = *pprog;
>> +
>> +       /* movabs r9, private_frame_ptr */
>> +       emit_mov_imm64(&prog, X86_REG_R9, (long) private_frame_ptr >> 32,
>> +                      (u32) (long) private_frame_ptr);
>> +
>> +       /* add <r9>, gs:[<off>] */
>> +       EMIT2(0x65, 0x4c);
>> +       EMIT3(0x03, 0x0c, 0x25);
>> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
>> +
>> +       *pprog = prog;
>> +}
>> +
>>   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>
>>   #define __LOAD_TCC_PTR(off)                    \
>> @@ -1421,20 +1455,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>          int insn_cnt = bpf_prog->len;
>>          bool seen_exit = false;
>>          u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
>> +       void __percpu *private_frame_ptr = NULL;
>>          u64 arena_vm_start, user_vm_start;
>> +       u32 orig_stack_depth, stack_depth;
>>          int i, excnt = 0;
>>          int ilen, proglen = 0;
>>          u8 *prog = temp;
>>          int err;
>>
>> +       stack_depth = bpf_prog->aux->stack_depth;
>> +       orig_stack_depth = round_up(stack_depth, 8);
>> +       if (bpf_prog->pstack) {
>> +               stack_depth = 0;
>> +               if (bpf_prog->pstack == PSTACK_TREE_ROOT)
>> +                       private_frame_ptr = bpf_prog->private_stack_ptr + orig_stack_depth;
>> +       }
> Same issue.
> switch (priv_stack_mode) {
> case PRIV_STACK_MAIN_PROG:
>      priv_frame_ptr = bpf_prog->priv_stack_ptr + orig_stack_depth;
>      fallthrough;
> case PRIV_STACK_SUB_PROG:
>      stack_depth = 0;
>      break;
> }
>
> would be easier to read.

Will do.

>
>> +
>>          arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
>>          user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>>
>>          detect_reg_usage(insn, insn_cnt, callee_regs_used);
>>
>> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
>> +       emit_prologue(&prog, stack_depth,
>>                        bpf_prog_was_classic(bpf_prog), tail_call_reachable,
>> -                     bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
>> +                     bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
>> +                     bpf_prog->pstack);
>>          /* Exception callback will clobber callee regs for its own use, and
>>           * restore the original callee regs from main prog's stack frame.
>>           */
>> @@ -1454,6 +1499,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                  emit_mov_imm64(&prog, X86_REG_R12,
>>                                 arena_vm_start >> 32, (u32) arena_vm_start);
>>
>> +       if (bpf_prog->pstack == PSTACK_TREE_ROOT) {
>> +               emit_private_frame_ptr(&prog, private_frame_ptr);
>> +       } else if (bpf_prog->pstack == PSTACK_TREE_INTERNAL  && orig_stack_depth) {
>> +               /* r9 += orig_stack_depth */
>> +               maybe_emit_1mod(&prog, X86_REG_R9, true);
>> +               if (is_imm8(orig_stack_depth))
>> +                       EMIT3(0x83, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
>> +               else
>> +                       EMIT2_off32(0x81, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
>> +       }
> We've been open coding 'add' insn like this for way too long.
> Let's address this technical debt now.
> Please move
>                  case BPF_ALU | BPF_ADD | BPF_K:
>                  case BPF_ALU | BPF_SUB | BPF_K:
>                  case BPF_ALU | BPF_AND | BPF_K:
>                  case BPF_ALU | BPF_OR | BPF_K:
>                  case BPF_ALU | BPF_XOR | BPF_K:
>                  case BPF_ALU64 | BPF_ADD | BPF_K:
>                  case BPF_ALU64 | BPF_SUB | BPF_K:
>                  case BPF_ALU64 | BPF_AND | BPF_K:
>                  case BPF_ALU64 | BPF_OR | BPF_K:
>                  case BPF_ALU64 | BPF_XOR | BPF_K:
> into helpers and use it here.

Will do.


