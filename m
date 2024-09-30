Return-Path: <bpf+bounces-40583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889A98A813
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12C6B26DB5
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BF190482;
	Mon, 30 Sep 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOVgys8H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60B1CFA9
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708624; cv=none; b=DGfWW9dhI1CDdM4Hi908wnJXW3JfcIjzRS6IboBfLbF6b3tGOpNys9x7bbX0uJM5OmRJlR332TXhnt0OhA14sAQ5P/GV+Pd3K24Wv425I1AyAFyJRGX6BDGiUyMnkayr2se3An+rRuoQpa2NSmWcl/mudhkmaqjMcTFFRzzW7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708624; c=relaxed/simple;
	bh=t/OTRRfQ9B7Awt8TsMh80DnOdNY9dNPAj/SYDIwC43Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ01X48+zBYfcnYMsHUvdFbbg/LJKZ9oIxZHoCbqRdP7u3MlO07+QhiShbYu9Sogc9zGAMdQU6PxEG7XHMVWnR5uQxmZ5kqseRx1nu0JK0S/Bg76gOwvUIdZT/nBD0Cmuy1WvRsgQFlapE95a6RCmIMKbIBWxX5mvyVkMYByG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOVgys8H; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso2092969f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727708620; x=1728313420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oezz38eALGQOjW+T1FCfd0WBJZ6K8+DZy5/wrrBYlCc=;
        b=EOVgys8HoBDVxymbo+xqp0TSgQdYwtWA7IxYp6Vq1YXqzZj7IrdvXga2pXhElJsi6f
         jD5tQQdtc96NeKGtN3XhCOJJ/akyAFREJ7wQnno17Oezn6sbDtCxC4w8jue5mnQgzmNX
         xvnVPQnlDscNIVO2hXDdbxv3M1+sVRh2X3pA9ysr8TT+powHCmarS3vV7cNAu3SJfTDn
         cHh0iHmCUctFI1Lbwnj4MEB0Q1goauYNMMeUsg6L1YWrDZ8WZgI1l0dtrb0MOg7bKg6N
         V6CJMw402An2w40SYJTNMdaVXIkGv5KuQAgb/ESfiBU30nN+PR8fD4SMkGYsm0V9Tdnf
         /gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727708620; x=1728313420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oezz38eALGQOjW+T1FCfd0WBJZ6K8+DZy5/wrrBYlCc=;
        b=dKmbAzHDS5rotIgbyos55sP2euHtswgOn2wAtUpsxLuGIU42uJvqK+2pUwyGOVcHEJ
         y7n1rcDrNlQMD8gUr1qcPWai8SslQu+frqcA1x1bye1GdWDQcWqyZfa/2nQbf6EnC22l
         Evb8yb095+rQGaqC0vjZtnCbbI6819CsjGWMPh57VkgtN9jwsqUDJFmlSdmPV8L+IR63
         A+5AvSoX8CD2mpZAkMc7v/O3Bcw/2ny+IA3nipbJU/EU9K4KTDVh2tg+qp6J0btZIaVJ
         1NuLazmK2gHNWyoOjsnuQdVnhwVo+8NSM96WGvLfVD8M8eo/GLHFkBlthOMCnV1Z5YBJ
         PhXg==
X-Gm-Message-State: AOJu0YyxZuZLsQYRnR+ULWS5Caci3AIRYdJjBE+/Ka22Gnmt/ZPenGL+
	OVphxWl8fQ+aSYCUlrgp7zh7YbeZ4WlnMKLb1QMJyttIHftRlUxPjlLmRwryQV/fuEqk1j3ijgg
	JfDlz3FRMoVgJQIgvwVAM9oKr0Mc=
X-Google-Smtp-Source: AGHT+IEUCbc0VOujdqPogGrka1KmWLitNAMG4vASAbOPXLp6oP3qAfTjI3L45KglkIJJFh7s8gMHVbsIJjeKUkdrqOY=
X-Received: by 2002:a5d:6445:0:b0:37c:ccdd:41b3 with SMTP id
 ffacd0b85a97d-37cd5a60966mr6933937f8f.8.1727708620254; Mon, 30 Sep 2024
 08:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev> <20240926234526.1770736-1-yonghong.song@linux.dev>
In-Reply-To: <20240926234526.1770736-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 08:03:29 -0700
Message-ID: <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Add jit support for private stack. For a particular subtree, e.g.,
>   subtree_root <=3D=3D stack depth 120
>    subprog1    <=3D=3D stack depth 80
>     subprog2   <=3D=3D stack depth 40
>    subprog3    <=3D=3D stack depth 160
>
> Let us say that private_stack_ptr is the memory address allocated for
> private stack. The frame pointer for each above is calculated like below:
>   subtree_root  <=3D=3D subtree_root_fp =3D private_stack_ptr + 120
>    subprog1     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 80
>     subprog2    <=3D=3D subtree_subprog2_fp =3D subtree_subprog1_fp + 40
>    subprog3     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 160
>
> For any function call to helper/kfunc, push/pop prog frame pointer
> is needed in order to preserve frame pointer value.
>
> To deal with exception handling, push/pop frame pointer is also used
> surrounding call to subsequent subprog. For example,
>   subtree_root
>    subprog1
>      ...
>      insn: call bpf_throw
>      ...
>
> After jit, we will have
>   subtree_root
>    insn: push r9
>    subprog1
>      ...
>      insn: push r9
>      insn: call bpf_throw
>      insn: pop r9
>      ...
>    insn: pop r9
>
>   exception_handler
>      pop r9
>      ...
> where r9 represents the fp for each subprog.

Kumar,
please review the interaction of priv_stack with exceptions.

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..c264822c926b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -325,6 +325,22 @@ struct jit_context {
>  /* Number of bytes that will be skipped on tailcall */
>  #define X86_TAIL_CALL_OFFSET   (12 + ENDBR_INSN_SIZE)
>
> +static void push_r9(u8 **pprog)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       EMIT2(0x41, 0x51);   /* push r9 */
> +       *pprog =3D prog;
> +}
> +
> +static void pop_r9(u8 **pprog)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       EMIT2(0x41, 0x59);   /* pop r9 */
> +       *pprog =3D prog;
> +}
> +
>  static void push_r12(u8 **pprog)
>  {
>         u8 *prog =3D *pprog;
> @@ -491,7 +507,7 @@ static void emit_prologue_tail_call(u8 **pprog, bool =
is_subprog)
>   */
>  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cb=
pf,
>                           bool tail_call_reachable, bool is_subprog,
> -                         bool is_exception_cb)
> +                         bool is_exception_cb, enum bpf_pstack_state  ps=
tack)

enum bpf_priv_stack_mode priv_stack_mode

>  {
>         u8 *prog =3D *pprog;
>
> @@ -518,6 +534,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, bool ebpf_from_cbpf,
>                  * first restore those callee-saved regs from stack, befo=
re
>                  * reusing the stack frame.
>                  */
> +               if (pstack)
> +                       pop_r9(&prog);

This is an unnecessary cognitive load, since readers
need to remember absolute values of enum.
Just use
if (priv_stack_mode !=3D NO_PRIV_STACK)

>                 pop_callee_regs(&prog, all_callee_regs_used);
>                 pop_r12(&prog);
>                 /* Reset the stack frame. */
> @@ -1404,6 +1422,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
>         *pprog =3D prog;
>  }
>
> +static void emit_private_frame_ptr(u8 **pprog, void *private_frame_ptr)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       /* movabs r9, private_frame_ptr */
> +       emit_mov_imm64(&prog, X86_REG_R9, (long) private_frame_ptr >> 32,
> +                      (u32) (long) private_frame_ptr);
> +
> +       /* add <r9>, gs:[<off>] */
> +       EMIT2(0x65, 0x4c);
> +       EMIT3(0x03, 0x0c, 0x25);
> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
> +
> +       *pprog =3D prog;
> +}
> +
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>
>  #define __LOAD_TCC_PTR(off)                    \
> @@ -1421,20 +1455,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>         int insn_cnt =3D bpf_prog->len;
>         bool seen_exit =3D false;
>         u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
> +       void __percpu *private_frame_ptr =3D NULL;
>         u64 arena_vm_start, user_vm_start;
> +       u32 orig_stack_depth, stack_depth;
>         int i, excnt =3D 0;
>         int ilen, proglen =3D 0;
>         u8 *prog =3D temp;
>         int err;
>
> +       stack_depth =3D bpf_prog->aux->stack_depth;
> +       orig_stack_depth =3D round_up(stack_depth, 8);
> +       if (bpf_prog->pstack) {
> +               stack_depth =3D 0;
> +               if (bpf_prog->pstack =3D=3D PSTACK_TREE_ROOT)
> +                       private_frame_ptr =3D bpf_prog->private_stack_ptr=
 + orig_stack_depth;
> +       }

Same issue.
switch (priv_stack_mode) {
case PRIV_STACK_MAIN_PROG:
    priv_frame_ptr =3D bpf_prog->priv_stack_ptr + orig_stack_depth;
    fallthrough;
case PRIV_STACK_SUB_PROG:
    stack_depth =3D 0;
    break;
}

would be easier to read.

> +
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->are=
na);
>         user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->aren=
a);
>
>         detect_reg_usage(insn, insn_cnt, callee_regs_used);
>
> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
> +       emit_prologue(&prog, stack_depth,
>                       bpf_prog_was_classic(bpf_prog), tail_call_reachable=
,
> -                     bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_=
cb);
> +                     bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_=
cb,
> +                     bpf_prog->pstack);
>         /* Exception callback will clobber callee regs for its own use, a=
nd
>          * restore the original callee regs from main prog's stack frame.
>          */
> @@ -1454,6 +1499,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                 emit_mov_imm64(&prog, X86_REG_R12,
>                                arena_vm_start >> 32, (u32) arena_vm_start=
);
>
> +       if (bpf_prog->pstack =3D=3D PSTACK_TREE_ROOT) {
> +               emit_private_frame_ptr(&prog, private_frame_ptr);
> +       } else if (bpf_prog->pstack =3D=3D PSTACK_TREE_INTERNAL  && orig_=
stack_depth) {
> +               /* r9 +=3D orig_stack_depth */
> +               maybe_emit_1mod(&prog, X86_REG_R9, true);
> +               if (is_imm8(orig_stack_depth))
> +                       EMIT3(0x83, add_1reg(0xC0, X86_REG_R9), orig_stac=
k_depth);
> +               else
> +                       EMIT2_off32(0x81, add_1reg(0xC0, X86_REG_R9), ori=
g_stack_depth);
> +       }

We've been open coding 'add' insn like this for way too long.
Let's address this technical debt now.
Please move
                case BPF_ALU | BPF_ADD | BPF_K:
                case BPF_ALU | BPF_SUB | BPF_K:
                case BPF_ALU | BPF_AND | BPF_K:
                case BPF_ALU | BPF_OR | BPF_K:
                case BPF_ALU | BPF_XOR | BPF_K:
                case BPF_ALU64 | BPF_ADD | BPF_K:
                case BPF_ALU64 | BPF_SUB | BPF_K:
                case BPF_ALU64 | BPF_AND | BPF_K:
                case BPF_ALU64 | BPF_OR | BPF_K:
                case BPF_ALU64 | BPF_XOR | BPF_K:
into helpers and use it here.

